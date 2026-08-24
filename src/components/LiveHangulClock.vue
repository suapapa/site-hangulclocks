<template>
  <div class="live-clock-card">
    <div class="clock-header">
      <div class="clock-badge">
        <span class="live-dot"></span>
        <span class="badge-text">{{ isSimulated ? '시뮬레이션 모드 (5분 단위)' : '실시간 한글시계 (5분 단위)' }}</span>
      </div>
      <button
        v-if="isSimulated"
        class="reset-btn"
        @click="resetToLive"
        title="현재 시간으로 복귀"
      >
        <v-icon size="14">mdi-refresh</v-icon>
        현재 시간
      </button>
      <div v-else class="clock-digital-preview">
        {{ formattedTimeStr }}
      </div>
    </div>

    <!-- 5x5 Hangul Grid Matrix -->
    <div class="hangul-matrix" role="region" aria-label="5x5 한글 시계 매트릭스">
      <div
        v-for="(row, rIdx) in matrix"
        :key="`row-${rIdx}`"
        class="matrix-row"
      >
        <span
          v-for="(char, cIdx) in row"
          :key="`cell-${rIdx}-${cIdx}`"
          class="hangul-cell"
          :class="{ active: isCellActive(rIdx, cIdx) }"
          :aria-selected="isCellActive(rIdx, cIdx)"
        >
          {{ char }}
        </span>
      </div>
    </div>

    <!-- Time readout text in Korean -->
    <div class="clock-readout">
      <span class="readout-label">한글 시각</span>
      <p class="readout-text">{{ koreanTimeSentence }}</p>
    </div>

    <!-- Interactive time slider -->
    <div class="clock-controller">
      <div class="slider-header">
        <span class="control-label">
          <v-icon size="14" class="mr-1">mdi-clock-time-four-outline</v-icon>
          시간 탐색기
        </span>
        <span class="slider-value">{{ formatSliderTime(simulatedMinutes) }}</span>
      </div>
      <input
        type="range"
        min="0"
        max="1439"
        step="1"
        :value="simulatedMinutes"
        @input="onSliderInput"
        class="time-slider"
        aria-label="시간 조절 슬라이더"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'

// 5x5 Hangul Clock Matrix (5-minute interval based on rusty-hangulclock)
// Row 0: 열 한 다 세 네
// Row 1: 두 여 섯 일 곱
// Row 2: 여 덟 아 홉 시
// Row 3: 자 정 이 삼 십
// Row 4: 사 오 십 오 분
const matrix = [
  ['열', '한', '다', '세', '네'],
  ['두', '여', '섯', '일', '곱'],
  ['여', '덟', '아', '홉', '시'],
  ['자', '정', '이', '삼', '십'],
  ['사', '오', '십', '오', '분']
]

const currentTime = ref(new Date())
const isSimulated = ref(false)
const simTotalMinutes = ref(0)
let timerId = null

const updateClock = () => {
  if (!isSimulated.value) {
    currentTime.value = new Date()
  }
}

onMounted(() => {
  timerId = setInterval(updateClock, 1000)
})

onUnmounted(() => {
  if (timerId) clearInterval(timerId)
})

const activeDate = computed(() => {
  if (isSimulated.value) {
    const d = new Date()
    const hours = Math.floor(simTotalMinutes.value / 60)
    const minutes = simTotalMinutes.value % 60
    d.setHours(hours, minutes, 0, 0)
    return d
  }
  return currentTime.value
})

const simulatedMinutes = computed(() => {
  const d = activeDate.value
  return d.getHours() * 60 + d.getMinutes()
})

const onSliderInput = (e) => {
  isSimulated.value = true
  simTotalMinutes.value = parseInt(e.target.value, 10)
}

const resetToLive = () => {
  isSimulated.value = false
  currentTime.value = new Date()
}

const formattedTimeStr = computed(() => {
  const d = activeDate.value
  const h = String(d.getHours()).padStart(2, '0')
  const m = String(d.getMinutes()).padStart(2, '0')
  const s = String(d.getSeconds()).padStart(2, '0')
  return `${h}:${m}:${s}`
})

const formatSliderTime = (mins) => {
  const h = Math.floor(mins / 60)
  const m = mins % 60
  const period = h < 12 ? '오전' : '오후'
  const displayH = h % 12 === 0 ? 12 : h % 12
  return `${period} ${displayH}:${String(m).padStart(2, '0')}`
}

// 5-minute interval rounding logic based on rusty-hangulclock/src/panel.rs
const roundedTimeInfo = computed(() => {
  const d = activeDate.value
  let h = d.getHours() % 24
  const rawMinutes = d.getMinutes()
  let m10 = Math.floor(rawMinutes / 10)
  let m1 = rawMinutes % 10

  // Round minutes to nearest 5
  if (m1 >= 1 && m1 <= 2) {
    m1 = 0
  } else if (m1 >= 3 && m1 <= 7) {
    m1 = 5
  } else if (m1 >= 8 && m1 <= 9) {
    m1 = 0
    m10 += 1
    if (m10 === 6) {
      m10 = 0
      h = (h + 1) % 24
    }
  }

  return { h, m10, m1 }
})

// Compute active coordinate set for 5x5 matrix cells
const activeCells = computed(() => {
  const { h, m10, m1 } = roundedTimeInfo.value
  const set = new Set()

  const addByIndex = (index) => {
    const r = Math.floor(index / 5)
    const c = index % 5
    set.add(`${r},${c}`)
  }

  // Noon & Midnight special cases
  if ((h === 0 || h === 12) && m10 === 0 && m1 === 0) {
    if (h === 0) {
      // 자정 (Indices 15, 16)
      addByIndex(15)
      addByIndex(16)
    } else {
      // 정오 (Indices 16, 21)
      addByIndex(16)
      addByIndex(21)
    }
    return set
  }

  const h12 = h > 12 ? h - 12 : (h === 0 ? 12 : h)

  // 시 (Hour)
  switch (h12) {
    case 12:
      addByIndex(0); addByIndex(5); addByIndex(14); break // 열두시
    case 1:
      addByIndex(1); addByIndex(14); break // 한시
    case 2:
      addByIndex(5); addByIndex(14); break // 두시
    case 3:
      addByIndex(3); addByIndex(14); break // 세시
    case 4:
      addByIndex(4); addByIndex(14); break // 네시
    case 5:
      addByIndex(2); addByIndex(7); addByIndex(14); break // 다섯시
    case 6:
      addByIndex(6); addByIndex(7); addByIndex(14); break // 여섯시
    case 7:
      addByIndex(8); addByIndex(9); addByIndex(14); break // 일곱시
    case 8:
      addByIndex(10); addByIndex(11); addByIndex(14); break // 여덟시
    case 9:
      addByIndex(12); addByIndex(13); addByIndex(14); break // 아홉시
    case 10:
      addByIndex(0); addByIndex(14); break // 열시
    case 11:
      addByIndex(0); addByIndex(1); addByIndex(14); break // 열한시
  }

  // 분 (Minute)
  if (m10 > 0 || m1 > 0) {
    switch (m10) {
      case 1:
        addByIndex(22); break // 십
      case 2:
        addByIndex(17); addByIndex(19); break // 이십
      case 3:
        addByIndex(18); addByIndex(19); break // 삼십
      case 4:
        addByIndex(20); addByIndex(22); break // 사십
      case 5:
        addByIndex(21); addByIndex(22); break // 오십
    }

    if (m1 === 5) {
      addByIndex(23); // 오
      addByIndex(24); // 분
    } else if (m10 > 0 || m1 > 0) {
      addByIndex(24); // 분
    }
  }

  return set
})

const isCellActive = (r, c) => activeCells.value.has(`${r},${c}`)

const koreanTimeSentence = computed(() => {
  const { h, m10, m1 } = roundedTimeInfo.value

  if (h === 0 && m10 === 0 && m1 === 0) return '자정 (밤 12시 정각)'
  if (h === 12 && m10 === 0 && m1 === 0) return '정오 (낮 12시 정각)'

  const h12 = h > 12 ? h - 12 : (h === 0 ? 12 : h)
  const hourNames = ['', '한', '두', '세', '네', '다섯', '여섯', '일곱', '여덟', '아홉', '열', '열한', '열두']
  const hourStr = `${hourNames[h12]}시`

  if (m10 === 0 && m1 === 0) {
    return `${hourStr} 정각`
  }

  const tensNames = ['', '십', '이십', '삼십', '사십', '오십']
  const tensStr = tensNames[m10]
  const onesStr = m1 === 5 ? '오' : ''
  const minuteStr = `${tensStr}${onesStr}분`

  return `${hourStr} ${minuteStr}`
})
</script>

<style scoped lang="scss">
.live-clock-card {
  background: rgba(255, 255, 255, 0.03);
  backdrop-filter: blur(24px);
  -webkit-backdrop-filter: blur(24px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 28px 24px;
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5), inset 0 1px 0 rgba(255, 255, 255, 0.1);
  position: relative;
  overflow: hidden;
  transition: all 0.4s ease;

  &::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle at 75% 25%, rgba(212, 175, 55, 0.08), transparent 50%);
    pointer-events: none;
  }
}

.clock-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.clock-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: rgba(212, 175, 55, 0.1);
  border: 1px solid rgba(212, 175, 55, 0.25);
  padding: 4px 12px;
  border-radius: 999px;
}

.live-dot {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  background: #D4AF37;
  box-shadow: 0 0 10px #D4AF37;
  animation: pulse-glow 2s infinite ease-in-out;
}

@keyframes pulse-glow {
  0%, 100% {
    opacity: 1;
    transform: scale(1);
  }
  50% {
    opacity: 0.4;
    transform: scale(0.85);
  }
}

.badge-text {
  font-size: 12px;
  font-weight: 500;
  color: #D4AF37;
  letter-spacing: -0.01em;
}

.clock-digital-preview {
  font-family: 'Geist Mono', 'JetBrains Mono', monospace;
  font-size: 13px;
  color: rgba(245, 245, 247, 0.6);
  letter-spacing: 0.05em;
}

.reset-btn {
  background: rgba(255, 255, 255, 0.06);
  border: 1px solid rgba(255, 255, 255, 0.15);
  color: #F5F5F7;
  font-size: 11px;
  font-weight: 500;
  padding: 4px 10px;
  border-radius: 6px;
  display: inline-flex;
  align-items: center;
  gap: 4px;
  cursor: pointer;
  transition: all 0.2s ease;

  &:hover {
    background: rgba(212, 175, 55, 0.15);
    border-color: rgba(212, 175, 55, 0.4);
    color: #D4AF37;
  }
}

// 5x5 Matrix
.hangul-matrix {
  display: flex;
  flex-direction: column;
  gap: 10px;
  background: rgba(0, 0, 0, 0.35);
  border: 1px solid rgba(255, 255, 255, 0.06);
  border-radius: 14px;
  padding: 20px 16px;
  margin-bottom: 20px;
}

.matrix-row {
  display: flex;
  justify-content: space-between;
  gap: 10px;
}

.hangul-cell {
  flex: 1;
  text-align: center;
  font-family: 'Noto Serif KR', serif;
  font-size: 22px;
  font-weight: 600;
  line-height: 1.4;
  color: rgba(255, 255, 255, 0.15);
  border-radius: 8px;
  padding: 6px 0;
  transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1);
  user-select: none;

  @media (max-width: 480px) {
    font-size: 18px;
    padding: 4px 0;
  }

  &.active {
    color: #FFFFFF;
    background: rgba(212, 175, 55, 0.18);
    text-shadow: 0 0 16px rgba(212, 175, 55, 0.9), 0 0 30px rgba(212, 175, 55, 0.5);
    transform: scale(1.05);
  }
}

// Readout sentence
.clock-readout {
  border-top: 1px solid rgba(255, 255, 255, 0.06);
  padding-top: 14px;
  margin-bottom: 18px;
}

.readout-label {
  font-size: 11px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: rgba(245, 245, 247, 0.4);
  display: block;
  margin-bottom: 4px;
}

.readout-text {
  font-family: 'Noto Serif KR', serif;
  font-size: 17px;
  font-weight: 600;
  color: #D4AF37;
  margin: 0;
  letter-spacing: -0.01em;
}

// Interactive slider
.clock-controller {
  background: rgba(255, 255, 255, 0.02);
  border-radius: 10px;
  padding: 10px 14px;
  border: 1px solid rgba(255, 255, 255, 0.04);
}

.slider-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.control-label {
  font-size: 12px;
  color: rgba(245, 245, 247, 0.6);
  display: inline-flex;
  align-items: center;
}

.slider-value {
  font-size: 12px;
  font-weight: 600;
  color: #D4AF37;
  font-family: 'Geist Mono', monospace;
}

.time-slider {
  width: 100%;
  height: 4px;
  border-radius: 2px;
  background: rgba(255, 255, 255, 0.12);
  outline: none;
  appearance: none;
  cursor: pointer;

  &::-webkit-slider-thumb {
    appearance: none;
    width: 14px;
    height: 14px;
    border-radius: 50%;
    background: #D4AF37;
    cursor: pointer;
    box-shadow: 0 0 8px rgba(212, 175, 55, 0.8);
    transition: transform 0.15s ease;
  }

  &::-webkit-slider-thumb:hover {
    transform: scale(1.25);
  }
}
</style>
