<template>
  <v-container class="py-8 py-md-12 px-4">
    <!-- Header/Introduction -->
    <!-- <v-row justify="center" class="mb-8">
      <v-col cols="12" md="8" class="text-center">
        <h2 class="text-h3 font-weight-black mb-4 gradient-text">Hangul Clock Collection</h2>
        <p class="text-body-1 text-grey-darken-1 mx-auto" style="max-width: 600px;">
          한글의 아름다움과 시간을 결합한 다양한 한글 시계 프로젝트를 모아보았습니다.
          각 시계는 창의적인 디자인과 독특한 기술적 구현을 통해 한글을 새롭게 조명합니다.
        </p>
      </v-col>
    </v-row> -->

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
          elevation="0"
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
                <div class="d-flex align-center justify-center fill-height bg-grey-darken-4">
                  <v-progress-circular indeterminate color="primary"></v-progress-circular>
                </div>
              </template>
            </v-img>
            <div class="image-overlay">
              <v-icon size="48" color="white">mdi-open-in-new</v-icon>
            </div>
          </div>

          <v-card-text class="pt-6 pb-6">
            <div class="author-label mb-1">{{ clk.author }}</div>
            <h3 class="text-h6 font-weight-bold mb-0 text-truncate-2">{{ clk.title }}</h3>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import hangulclocks from '@/assets/hangulclocks.yaml'

const getImgUrl = (name) => {
  return new URL(`../assets/${name}`, import.meta.url).href
}
</script>

<style scoped>
.modern-card {
  background: rgba(255, 255, 255, 0.04) !important;
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.1) !important;
  transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
  overflow: hidden;
  text-decoration: none;
}

.modern-card:hover {
  transform: translateY(-8px);
  background: rgba(255, 255, 255, 0.08) !important;
  border-color: rgba(212, 175, 55, 0.4) !important;
  box-shadow: 0 20px 40px rgba(0,0,0,0.3) !important;
}

.author-label {
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: #D4AF37;
}

.image-container {
  position: relative;
  overflow: hidden;
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.card-image {
  transition: transform 0.8s cubic-bezier(0.165, 0.84, 0.44, 1);
}

.modern-card:hover .card-image {
  transform: scale(1.08);
}

.image-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(15, 15, 18, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.4s ease;
}

.modern-card:hover .image-overlay {
  opacity: 1;
}

.text-truncate-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  line-height: 1.4;
  height: 2.8em;
  color: #F5F5F7;
}
</style>
