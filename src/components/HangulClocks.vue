<template>
  <v-container class="py-12 px-4">
    <!-- Header/Introduction -->
    <v-row justify="center" class="mb-8">
      <v-col cols="12" md="8" class="text-center">
        <h2 class="text-h3 font-weight-black mb-4 gradient-text">Hangul Clock Collection</h2>
        <p class="text-body-1 text-grey-darken-1 mx-auto" style="max-width: 600px;">
          한글의 아름다움과 시간을 결합한 다양한 한글 시계 프로젝트를 모아보았습니다.
          각 시계는 창의적인 디자인과 독특한 기술적 구현을 통해 한글을 새롭게 조명합니다.
        </p>
      </v-col>
    </v-row>

    <!-- Grid of Clocks -->
    <v-row>
      <v-col
        v-for="(clk, i) in hangulclocks"
        :key="i"
        cols="12"
        sm="6"
        lg="4"
        xl="3"
        class="d-flex"
      >
        <v-card
          class="modern-card flex-grow-1"
          elevation="2"
          rounded="xl"
          :href="clk.href"
          target="_blank"
        >
          <div class="image-container">
            <v-img
              :src="getImgUrl(clk.imageName)"
              height="280"
              cover
              class="card-image"
            >
              <template v-slot:placeholder>
                <div class="d-flex align-center justify-center fill-height bg-grey-lighten-2">
                  <v-progress-circular indeterminate color="primary"></v-progress-circular>
                </div>
              </template>
            </v-img>
            <div class="image-overlay">
              <v-icon size="48" color="white">mdi-open-in-new</v-icon>
            </div>
          </div>

          <v-card-text class="pt-6 pb-6">
            <div class="text-overline text-primary font-weight-bold mb-1">{{ clk.author }}</div>
            <h3 class="text-h6 font-weight-bold mb-2 text-truncate-2">{{ clk.title }}</h3>
          </v-card-text>

          <v-divider class="mx-4"></v-divider>

          <v-card-actions class="px-4 py-3 bg-grey-lighten-5">
            <span class="text-caption text-grey-darken-1 font-italic">View Source/Details</span>
            <v-spacer></v-spacer>
            <v-icon size="small" color="primary">mdi-chevron-right</v-icon>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
const hangulclocks = [
  {
    title: '한글시계-오늘도 수고한 당신에게',
    author: "Jung-Min An",
    imageName: 'hangulclock_jungminan.png',
    href: 'https://github.com/minsOne/HangulClockApp'
  },
  {
    title: '원목한글시계 한시',
    author: "쿼터노트",
    imageName: 'hangulclock_quarternote.png',
    href: 'https://www.idus.com/w/product/112e60de-29e0-45be-94ce-c5530596fde7'
  },
  {
    title: '세종이 한글을 만들기 위해.. 포기한 이것.. ( 초대형 한글 시계 )',
    author: "긱블 Geekble",
    imageName: 'hangulclock_geekble.png',
    href: 'https://youtu.be/3OnIf-UtNqs'
  },
  {
    title: '한글시계 design based on attiny4313a.',
    author: "cakeng",
    imageName: 'hangulclock_cakeng.jpg',
    href: 'https://github.com/cakeng/HangulClock'
  },
  {
    title: '너가 있어 아름다운 오늘, 한글시계',
    author: "이상훈",
    imageName: 'hangulclock_sanghunlee.png',
    href: 'https://hangulclock.today/'
  },
  {
    title: '한글시계 for Android',
    author: '이준희',
    imageName: 'hangulclock_junheelee.png',
    href: 'https://play.google.com/store/apps/details?id=com.leejoonhee.hangulclockforandroid'
  },
  {
    title: '세운(시) 여러분(계)',
    author: 'Space_바421',
    imageName: 'hangulclock_sewoon.webp',
    href: 'http://yovisong.wixsite.com/spaceba4/2016-11-homo-laborans'
  },
  {
    title: '한글시계 - 한글로 흐르는 시간의 아름다움',
    author: '대디스랩x이카루스',
    imageName: 'hangulclock_dlab.jpg',
    href: 'https://www.wadiz.kr/web/campaign/detail/1240'
  },
  {
    title: '한글시계 만들기',
    author: "만들마루",
    imageName: 'hangulclock_mandulmaru.jpeg',
    href: 'https://blog.naver.com/mandulmaru/221413981408'
  },
  {
    title: '한글 시계 만들기',
    author: "kocoafab",
    imageName: 'hangulclock_kocoafab.jpg',
    href: 'https://kocoafab.cc/make/view/508'
  },
  {
    title: '한글시계(HangulClock)',
    author: "이호민",
    imageName: 'hangulclock_hominlee.jpg',
    href: 'https://github.com/suapapa/hangulclock'
  }
]

const getImgUrl = (name) => {
  return new URL(`../assets/${name}`, import.meta.url).href
}
</script>

<style scoped>
.modern-card {
  transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
  overflow: hidden;
  text-decoration: none;
}

.modern-card:hover {
  transform: translateY(-12px);
  box-shadow: 0 20px 40px rgba(0,0,0,0.12) !important;
}

.image-container {
  position: relative;
  overflow: hidden;
}

.card-image {
  transition: transform 0.6s ease;
}

.modern-card:hover .card-image {
  transform: scale(1.1);
}

.image-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.modern-card:hover .image-overlay {
  opacity: 1;
}

.gradient-text {
  background: linear-gradient(45deg, #1867c0, #5cbbf6);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.text-truncate-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  line-height: 1.4;
  height: 2.8em;
}
</style>
