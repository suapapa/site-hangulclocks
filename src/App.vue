<template>
  <v-app theme="dark">
    <header class="hc-navbar">
      <div class="hc-navbar-container">
        <h1 class="hc-logo">
          HangulClocks <span class="hc-logo-sub">여러 분들의 한글시계</span>
        </h1>
        <v-spacer></v-spacer>
        <v-btn
          variant="outlined"
          class="hc-nav-btn"
          href="https://github.com/suapapa/site-hangulclocks/issues/new"
          target="_blank"
        >
          <v-icon start icon="mdi-plus-circle-outline"></v-icon>
          <span>등록요청</span>
        </v-btn>
      </div>
    </header>

    <v-main class="hc-main-content">
      <div class="hc-hero">
        <h2 class="hc-hero-title">시간의 아름다움을 <br/> 한글로 담다</h2>
        <p class="hc-hero-subtitle">한글의 아름다움과 시간을 결합한 다양한 한글 시계 프로젝트를 모아보았습니다.</p>
      </div>
      <HangulClocks/>
    </v-main>

    <footer class="hc-footer">
      <div class="hc-footer-container">
        <div class="hc-footer-credit">
          &copy; {{ new Date().getFullYear() }} Homin Lee &lt;homin.crc@gmail.com&gt;
        </div>
        <div class="hc-footer-disclaimer">
          각 시계의 사진은 각 저작자의 소유입니다. All rights reserved.
        </div>
      </div>
    </footer>
  </v-app>
</template>

<script setup>
import HangulClocks from './components/HangulClocks.vue'
</script>

<style lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Noto+Serif+KR:wght@600;700&display=swap');

// Global Styles
body {
  font-family: 'Noto Sans KR', sans-serif !important;
  background-color: #0F0F12 !important;
  color: #F5F5F7 !important;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.v-application {
  font-family: 'Noto Sans KR', sans-serif !important;
  background: #0F0F12 !important;
}

// Navbar
.hc-navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 72px;
  z-index: 100;
  background: rgba(15, 15, 18, 0.7);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

.hc-navbar-container {
  max-width: 1400px;
  margin: 0 auto;
  height: 100%;
  display: flex;
  align-items: center;
  padding: 0 40px;
}

.hc-logo {
  font-family: 'Noto Serif KR', serif;
  font-size: 24px;
  font-weight: 700;
  letter-spacing: -0.02em;
  color: #D4AF37; // Gold
  margin: 0;
}

.hc-logo-sub {
  font-family: 'Noto Sans KR', sans-serif;
  font-size: 14px;
  font-weight: 300;
  color: rgba(245, 245, 247, 0.6);
  margin-left: 12px;
}

.hc-nav-btn {
  border: 1px solid rgba(212, 175, 55, 0.3) !important;
  border-radius: 30px !important;
  text-transform: none !important;
  font-weight: 500 !important;
  letter-spacing: 0 !important;
  color: #D4AF37 !important;
  transition: all 0.3s ease !important;
  &:hover {
    background: rgba(212, 175, 55, 0.1) !important;
    border-color: #D4AF37 !important;
  }
}

// Main Content
.hc-main-content {
  padding-top: 120px !important;
  background: radial-gradient(circle at top center, rgba(212, 175, 55, 0.05), transparent 60%);
}

.hc-hero {
  max-width: 1400px;
  margin: 0 auto 60px;
  padding: 0 40px;
  text-align: center;
}

.hc-hero-title {
  font-family: 'Noto Serif KR', serif;
  font-size: 56px;
  line-height: 1.2;
  font-weight: 700;
  margin-bottom: 24px;
  background: linear-gradient(180deg, #FFFFFF 0%, rgba(255, 255, 255, 0.7) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hc-hero-subtitle {
  font-size: 18px;
  font-weight: 300;
  color: rgba(245, 245, 247, 0.6);
  max-width: 600px;
  margin: 0 auto;
}

// Footer
.hc-footer {
  background: #0F0F12;
  padding: 60px 0;
  border-top: 1px solid rgba(255, 255, 255, 0.05);
}

.hc-footer-container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 40px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.hc-footer-credit {
  font-weight: 500;
  color: rgba(245, 245, 247, 0.8);
}

.hc-footer-disclaimer {
  font-size: 13px;
  color: rgba(245, 245, 247, 0.4);
}

// Responsive
@media (max-width: 768px) {
  .hc-navbar-container {
    padding: 0 20px;
  }
  .hc-logo-sub {
    display: none;
  }
  .hc-hero-title {
    font-size: 36px;
  }
  .hc-hero {
    padding: 0 20px;
  }
}
</style>
