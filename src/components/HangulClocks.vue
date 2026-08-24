<template>
  <div class="gallery-section">
    <!-- Filter & Search Controls Bar -->
    <div class="controls-wrapper">
      <div class="filter-chips" role="tablist" aria-label="프로젝트 카테고리 필터">
        <button
          v-for="cat in categories"
          :key="cat"
          class="category-chip"
          :class="{ active: selectedCategory === cat }"
          role="tab"
          :aria-selected="selectedCategory === cat"
          @click="selectedCategory = cat"
        >
          {{ cat }}
          <span class="chip-count">{{ getCategoryCount(cat) }}</span>
        </button>
      </div>

      <div class="search-box">
        <v-icon size="18" color="rgba(245, 245, 247, 0.5)" class="search-icon">mdi-magnify</v-icon>
        <input
          v-model="searchQuery"
          type="text"
          placeholder="시계 이름, 제작자, 태그 검색..."
          class="search-input"
          aria-label="한글시계 프로젝트 검색"
        />
        <button
          v-if="searchQuery"
          class="clear-search-btn"
          @click="searchQuery = ''"
          title="검색어 지우기"
        >
          <v-icon size="14">mdi-close</v-icon>
        </button>
      </div>
    </div>

    <!-- Gallery Grid -->
    <div v-if="filteredClocks.length > 0" class="clocks-grid">
      <article
        v-for="(clk, idx) in filteredClocks"
        :key="clk.imageName"
        class="clock-card-wrapper"
      >
        <a
          :href="clk.href || undefined"
          :target="clk.href ? '_blank' : undefined"
          rel="noopener noreferrer"
          class="clock-card"
          :aria-label="`${clk.title} - ${clk.author} 프로젝트 열기`"
        >
          <!-- Media Showcase -->
          <div class="card-media">
            <v-img
              :src="clk.imageSrc"
              :alt="`${clk.title} 사진`"
              height="260"
              cover
              class="media-img"
            >
              <template v-slot:placeholder>
                <div class="media-placeholder">
                  <v-progress-circular indeterminate color="#D4AF37" size="28" width="2"></v-progress-circular>
                </div>
              </template>
            </v-img>

            <div class="media-overlay">
              <span class="view-pill">
                <span>프로젝트 방문</span>
                <v-icon size="16">mdi-arrow-top-right</v-icon>
              </span>
            </div>

            <div v-if="clk.category" class="category-badge">
              {{ clk.category }}
            </div>
          </div>

          <!-- Content Info -->
          <div class="card-body">
            <div class="author-row">
              <span class="author-name">
                <v-icon size="13" class="mr-1" color="#D4AF37">mdi-account-circle-outline</v-icon>
                {{ clk.author }}
              </span>
            </div>

            <h3 class="card-title">{{ clk.title }}</h3>

            <p v-if="clk.description" class="card-desc">
              {{ clk.description }}
            </p>

            <!-- Tags -->
            <div v-if="clk.tags && clk.tags.length" class="tags-container">
              <span v-for="tag in clk.tags" :key="tag" class="tag-badge">
                #{{ tag }}
              </span>
            </div>
          </div>

          <!-- Card Footer Action -->
          <div class="card-footer">
            <span class="action-text">자세히 보기</span>
            <v-icon size="18" class="action-icon">mdi-arrow-right</v-icon>
          </div>
        </a>
      </article>
    </div>

    <!-- Empty State -->
    <div v-else class="empty-state">
      <div class="empty-icon-wrap">
        <v-icon size="42" color="rgba(212, 175, 55, 0.6)">mdi-clock-search-outline</v-icon>
      </div>
      <h3 class="empty-title">검색된 한글시계가 없습니다</h3>
      <p class="empty-desc">
        '{{ searchQuery }}'에 해당하는 프로젝트를 찾지 못했습니다.<br/>
        다른 검색어로 다시 시도해보세요.
      </p>
      <button class="reset-filter-btn" @click="resetFilters">
        <v-icon size="16" class="mr-1">mdi-refresh</v-icon>
        필터 및 검색 초기화
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import hangulclocks from '@/assets/hangulclocks.yaml'
import { clockImageSrc, safeHttpUrl } from '@/utils/safeExternal'

const searchQuery = ref('')
const selectedCategory = ref('전체')

const allClocks = computed(() =>
  hangulclocks.flatMap((clk) => {
    const href = safeHttpUrl(clk.href)
    const imageSrc = clockImageSrc(clk.imageName)
    if (!href || !imageSrc) {
      return []
    }
    return [{ ...clk, href, imageSrc }]
  }),
)

const categories = computed(() => {
  const cats = ['전체']
  allClocks.value.forEach((clk) => {
    if (clk.category && !cats.includes(clk.category)) {
      cats.push(clk.category)
    }
  })
  return cats
})

const getCategoryCount = (category) => {
  if (category === '전체') return allClocks.value.length
  return allClocks.value.filter((clk) => clk.category === category).length
}

const filteredClocks = computed(() => {
  const q = searchQuery.value.trim().toLowerCase()
  return allClocks.value.filter((clk) => {
    // Category filter
    if (selectedCategory.value !== '전체' && clk.category !== selectedCategory.value) {
      return false
    }

    // Search query filter
    if (!q) return true

    const matchTitle = clk.title?.toLowerCase().includes(q)
    const matchAuthor = clk.author?.toLowerCase().includes(q)
    const matchDesc = clk.description?.toLowerCase().includes(q)
    const matchTags = clk.tags?.some((t) => t.toLowerCase().includes(q))

    return matchTitle || matchAuthor || matchDesc || matchTags
  })
})

const resetFilters = () => {
  searchQuery.value = ''
  selectedCategory.value = '전체'
}
</script>

<style scoped lang="scss">
.gallery-section {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 40px 80px;

  @media (max-width: 768px) {
    padding: 0 20px 60px;
  }
}

// Controls
.controls-wrapper {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 16px;
  margin-bottom: 40px;
  flex-wrap: wrap;

  @media (max-width: 768px) {
    flex-direction: column;
    align-items: stretch;
    gap: 16px;
    margin-bottom: 28px;
  }
}

.filter-chips {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.category-chip {
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.08);
  color: rgba(245, 245, 247, 0.7);
  padding: 8px 16px;
  border-radius: 999px;
  font-size: 13px;
  font-weight: 500;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);

  &:hover {
    background: rgba(255, 255, 255, 0.08);
    color: #FFFFFF;
    border-color: rgba(255, 255, 255, 0.2);
  }

  &.active {
    background: rgba(212, 175, 55, 0.15);
    border-color: rgba(212, 175, 55, 0.6);
    color: #D4AF37;
    font-weight: 600;
    box-shadow: 0 0 16px rgba(212, 175, 55, 0.2);
  }
}

.chip-count {
  font-size: 11px;
  opacity: 0.6;
  font-family: monospace;
}

.search-box {
  position: relative;
  min-width: 280px;
  display: flex;
  align-items: center;

  @media (max-width: 768px) {
    min-width: 100%;
  }
}

.search-icon {
  position: absolute;
  left: 14px;
  pointer-events: none;
}

.search-input {
  width: 100%;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 999px;
  padding: 10px 38px 10px 40px;
  font-size: 14px;
  color: #F5F5F7;
  outline: none;
  transition: all 0.25s ease;

  &::placeholder {
    color: rgba(245, 245, 247, 0.4);
  }

  &:focus {
    background: rgba(255, 255, 255, 0.07);
    border-color: rgba(212, 175, 55, 0.6);
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.15);
  }
}

.clear-search-btn {
  position: absolute;
  right: 12px;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: rgba(245, 245, 247, 0.7);
  cursor: pointer;

  &:hover {
    background: rgba(255, 255, 255, 0.2);
    color: #FFFFFF;
  }
}

// Clocks Grid
.clocks-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 28px;

  @media (max-width: 640px) {
    grid-template-columns: 1fr;
    gap: 20px;
  }
}

.clock-card-wrapper {
  display: flex;
}

.clock-card {
  width: 100%;
  display: flex;
  flex-direction: column;
  background: rgba(255, 255, 255, 0.03);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 18px;
  overflow: hidden;
  text-decoration: none;
  color: inherit;
  transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.06);

  &:hover {
    transform: translateY(-6px);
    background: rgba(255, 255, 255, 0.06);
    border-color: rgba(212, 175, 55, 0.4);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4), 0 0 25px rgba(212, 175, 55, 0.15);

    .media-img {
      transform: scale(1.06);
    }

    .media-overlay {
      opacity: 1;
    }

    .card-title {
      color: #D4AF37;
    }

    .action-icon {
      transform: translateX(4px);
      color: #D4AF37;
    }

    .action-text {
      color: #D4AF37;
    }
  }

  &:focus-visible {
    outline: 2px solid #D4AF37;
    outline-offset: 4px;
  }
}

// Media
.card-media {
  position: relative;
  overflow: hidden;
  background: #141418;
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);
}

.media-img {
  transition: transform 0.6s cubic-bezier(0.16, 1, 0.3, 1);
}

.media-placeholder {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  background: #121216;
}

.media-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(180deg, rgba(15, 15, 18, 0.2) 0%, rgba(15, 15, 18, 0.7) 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.view-pill {
  background: rgba(15, 15, 18, 0.85);
  border: 1px solid rgba(212, 175, 55, 0.5);
  color: #D4AF37;
  padding: 8px 16px;
  border-radius: 999px;
  font-size: 12px;
  font-weight: 600;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  backdrop-filter: blur(8px);
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.4);
}

.category-badge {
  position: absolute;
  top: 14px;
  left: 14px;
  background: rgba(15, 15, 18, 0.75);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: rgba(245, 245, 247, 0.9);
  font-size: 11px;
  font-weight: 500;
  padding: 4px 10px;
  border-radius: 6px;
  letter-spacing: -0.01em;
}

// Body
.card-body {
  padding: 22px 22px 16px;
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}

.author-row {
  margin-bottom: 8px;
}

.author-name {
  font-size: 12px;
  font-weight: 600;
  color: rgba(212, 175, 55, 0.9);
  display: inline-flex;
  align-items: center;
  letter-spacing: -0.01em;
}

.card-title {
  font-family: 'Noto Sans KR', sans-serif;
  font-size: 18px;
  font-weight: 700;
  line-height: 1.4;
  color: #F5F5F7;
  margin: 0 0 10px;
  transition: color 0.25s ease;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  height: 2.8em;
}

.card-desc {
  font-size: 13px;
  line-height: 1.6;
  color: rgba(245, 245, 247, 0.6);
  margin: 0 0 16px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.tags-container {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  margin-top: auto;
}

.tag-badge {
  font-size: 11px;
  color: rgba(245, 245, 247, 0.5);
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.06);
  padding: 2px 8px;
  border-radius: 4px;
}

// Footer
.card-footer {
  padding: 14px 22px;
  border-top: 1px solid rgba(255, 255, 255, 0.05);
  background: rgba(0, 0, 0, 0.15);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.action-text {
  font-size: 12px;
  font-weight: 500;
  color: rgba(245, 245, 247, 0.6);
  transition: color 0.25s ease;
}

.action-icon {
  color: rgba(245, 245, 247, 0.4);
  transition: all 0.25s ease;
}

// Empty State
.empty-state {
  text-align: center;
  padding: 80px 20px;
  background: rgba(255, 255, 255, 0.02);
  border: 1px dashed rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  margin-top: 20px;
}

.empty-icon-wrap {
  width: 72px;
  height: 72px;
  border-radius: 50%;
  background: rgba(212, 175, 55, 0.08);
  border: 1px solid rgba(212, 175, 55, 0.2);
  display: inline-flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 20px;
}

.empty-title {
  font-size: 20px;
  font-weight: 700;
  color: #F5F5F7;
  margin: 0 0 10px;
}

.empty-desc {
  font-size: 14px;
  color: rgba(245, 245, 247, 0.5);
  line-height: 1.6;
  margin: 0 0 24px;
}

.reset-filter-btn {
  background: rgba(212, 175, 55, 0.15);
  border: 1px solid rgba(212, 175, 55, 0.4);
  color: #D4AF37;
  font-size: 13px;
  font-weight: 600;
  padding: 10px 20px;
  border-radius: 999px;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  transition: all 0.25s ease;

  &:hover {
    background: rgba(212, 175, 55, 0.25);
    border-color: #D4AF37;
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.2);
  }
}
</style>
