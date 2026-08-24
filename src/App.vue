<template>
  <v-app theme="dark">
    <!-- Atmospheric Background Ambient Glows -->
    <div class="ambient-glow glow-1" aria-hidden="true"></div>
    <div class="ambient-glow glow-2" aria-hidden="true"></div>

    <!-- Navigation Header -->
    <header class="hc-navbar">
      <div class="hc-navbar-container">
        <a href="#" class="hc-logo-link" aria-label="HangulClocks 홈으로 이동">
          <div class="hc-logo-symbol">
            <span class="symbol-char">한</span>
          </div>
          <div class="hc-logo-text-group">
            <h1 class="hc-logo">HangulClocks</h1>
            <span class="hc-logo-sub">여러 분들의 한글시계</span>
          </div>
        </a>

        <div class="hc-nav-actions">
          <a
            href="https://github.com/suapapa/site-hangulclocks/issues/new"
            target="_blank"
            rel="noopener noreferrer"
            class="hc-register-btn"
          >
            <v-icon size="16" class="mr-1">mdi-plus-circle-outline</v-icon>
            <span>시계 등록 요청</span>
          </a>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <v-main class="hc-main-content">
      <!-- Split Hero Section -->
      <section class="hc-hero-section">
        <div class="hc-hero-container">
          <!-- Left: Narrative & Value Prop -->
          <div class="hc-hero-content">
            <div class="hc-hero-eyebrow">
              <span class="eyebrow-line"></span>
              <span class="eyebrow-text">한글과 시간의 만남</span>
            </div>

            <h2 class="hc-hero-title">
              시간의 결을<br />
              <span class="gold-gradient">한글</span>로 새기다
            </h2>

            <p class="hc-hero-subtitle">
              빛과 글자가 어우러져 흐르는 시간. 국내외 메이커와 개발자, 공예가들이 창조한 다채로운 한글 시계 프로젝트들을 한자리에서 만나보세요.
            </p>

            <div class="hc-hero-metrics">
              <div class="metric-pill">
                <span class="metric-num">12+</span>
                <span class="metric-label">아카이브 프로젝트</span>
              </div>
              <div class="metric-pill">
                <span class="metric-num">Hardware & App</span>
                <span class="metric-label">다양한 구현 방식</span>
              </div>
              <div class="metric-pill">
                <span class="metric-num">Open Source</span>
                <span class="metric-label">공유와 DIY 가이드</span>
              </div>
            </div>
          </div>

          <!-- Right: Interactive Live Hangul Clock Showcase -->
          <div class="hc-hero-visual">
            <LiveHangulClock />
          </div>
        </div>
      </section>

      <!-- Archive Gallery Section -->
      <section class="hc-gallery-container">
        <HangulClocks />
      </section>
    </v-main>

    <!-- Footer -->
    <footer class="hc-footer">
      <div class="hc-footer-container">
        <div class="hc-footer-quote">
          "시간은 그저 흘러가는 것이 아니라, 아름다운 한글로 기억되는 순간입니다."
        </div>

        <div class="hc-footer-links">
          <a
            href="https://github.com/suapapa/site-hangulclocks"
            target="_blank"
            rel="noopener noreferrer"
            class="footer-link"
          >
            <v-icon size="16" class="mr-1">mdi-github</v-icon>
            GitHub 저장소
          </a>
          <span class="footer-dot">·</span>
          <a
            href="https://github.com/suapapa/site-hangulclocks/issues/new"
            target="_blank"
            rel="noopener noreferrer"
            class="footer-link"
          >
            <v-icon size="16" class="mr-1">mdi-plus</v-icon>
            신규 프로젝트 등록
          </a>
        </div>

        <div class="hc-footer-divider"></div>

        <div class="hc-footer-bottom">
          <div class="hc-footer-credit">
            &copy; {{ new Date().getFullYear() }} Homin Lee &lt;i@homin.dev&gt;
          </div>
          <div class="hc-footer-disclaimer">
            각 시계의 사진 및 저작권은 해당 원작자에게 있습니다.
          </div>
        </div>
      </div>
    </footer>
  </v-app>
</template>

<script setup>
import HangulClocks from './components/HangulClocks.vue'
import LiveHangulClock from './components/LiveHangulClock.vue'
</script>

<style lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&family=Noto+Serif+KR:wght@600;700;900&display=swap');

// Global Base
html, body {
  margin: 0;
  padding: 0;
  background-color: #0F0F12 !important;
  color: #F5F5F7 !important;
  font-family: 'Noto Sans KR', sans-serif !important;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.v-application {
  font-family: 'Noto Sans KR', sans-serif !important;
  background: #0F0F12 !important;
  color: #F5F5F7 !important;
  min-height: 100dvh;
  position: relative;
  overflow-x: hidden;
}

// Ambient Lighting
.ambient-glow {
  position: absolute;
  pointer-events: none;
  border-radius: 50%;
  filter: blur(120px);
  opacity: 0.15;
  z-index: 0;
}

.glow-1 {
  width: 500px;
  height: 500px;
  top: 5%;
  right: 10%;
  background: radial-gradient(circle, #D4AF37 0%, rgba(212, 175, 55, 0) 70%);
}

.glow-2 {
  width: 400px;
  height: 400px;
  top: 40%;
  left: 5%;
  background: radial-gradient(circle, #D4AF37 0%, rgba(212, 175, 55, 0) 70%);
  opacity: 0.08;
}

// Navbar
.hc-navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 72px;
  z-index: 100;
  background: rgba(15, 15, 18, 0.75);
  backdrop-filter: blur(24px);
  -webkit-backdrop-filter: blur(24px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

.hc-navbar-container {
  max-width: 1400px;
  margin: 0 auto;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 40px;

  @media (max-width: 768px) {
    padding: 0 20px;
  }
}

.hc-logo-link {
  display: flex;
  align-items: center;
  gap: 14px;
  text-decoration: none;
  color: inherit;
}

.hc-logo-symbol {
  width: 36px;
  height: 36px;
  border-radius: 10px;
  background: linear-gradient(135deg, rgba(212, 175, 55, 0.2) 0%, rgba(212, 175, 55, 0.05) 100%);
  border: 1px solid rgba(212, 175, 55, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 0 15px rgba(212, 175, 55, 0.2);
}

.symbol-char {
  font-family: 'Noto Serif KR', serif;
  font-size: 18px;
  font-weight: 700;
  color: #D4AF37;
}

.hc-logo-text-group {
  display: flex;
  align-items: baseline;
  gap: 10px;
}

.hc-logo {
  font-family: 'Noto Serif KR', serif;
  font-size: 20px;
  font-weight: 700;
  letter-spacing: -0.02em;
  color: #F5F5F7;
  margin: 0;
}

.hc-logo-sub {
  font-size: 13px;
  font-weight: 300;
  color: rgba(245, 245, 247, 0.5);

  @media (max-width: 640px) {
    display: none;
  }
}

.hc-register-btn {
  display: inline-flex;
  align-items: center;
  padding: 8px 18px;
  background: rgba(212, 175, 55, 0.08);
  border: 1px solid rgba(212, 175, 55, 0.35);
  border-radius: 999px;
  color: #D4AF37;
  font-size: 13px;
  font-weight: 500;
  text-decoration: none;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);

  &:hover {
    background: rgba(212, 175, 55, 0.18);
    border-color: #D4AF37;
    box-shadow: 0 0 20px rgba(212, 175, 55, 0.25);
    transform: translateY(-1px);
  }

  &:active {
    transform: scale(0.98);
  }
}

// Main
.hc-main-content {
  padding-top: 100px !important;
  position: relative;
  z-index: 1;

  @media (max-width: 768px) {
    padding-top: 84px !important;
  }
}

// Hero Section
.hc-hero-section {
  max-width: 1400px;
  margin: 0 auto;
  padding: 40px 40px 60px;

  @media (max-width: 768px) {
    padding: 20px 20px 40px;
  }
}

.hc-hero-container {
  display: grid;
  grid-template-columns: 1.1fr 0.9fr;
  gap: 50px;
  align-items: center;

  @media (max-width: 960px) {
    grid-template-columns: 1fr;
    gap: 36px;
  }
}

.hc-hero-eyebrow {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
}

.eyebrow-line {
  width: 24px;
  height: 2px;
  background: #D4AF37;
}

.eyebrow-text {
  font-size: 12px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  color: #D4AF37;
}

.hc-hero-title {
  font-family: 'Noto Serif KR', serif;
  font-size: 48px;
  line-height: 1.25;
  font-weight: 700;
  letter-spacing: -0.03em;
  margin: 0 0 22px;
  color: #F5F5F7;

  @media (max-width: 768px) {
    font-size: 34px;
  }
}

.gold-gradient {
  background: linear-gradient(135deg, #FFFFFF 0%, #E8D38D 50%, #D4AF37 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hc-hero-subtitle {
  font-size: 16px;
  line-height: 1.7;
  font-weight: 300;
  color: rgba(245, 245, 247, 0.65);
  max-width: 540px;
  margin: 0 0 32px;

  @media (max-width: 768px) {
    font-size: 14px;
    margin-bottom: 24px;
  }
}

.hc-hero-metrics {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
}

.metric-pill {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 12px;
  padding: 10px 16px;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.metric-num {
  font-size: 14px;
  font-weight: 700;
  color: #D4AF37;
}

.metric-label {
  font-size: 11px;
  color: rgba(245, 245, 247, 0.5);
}

.hc-hero-visual {
  width: 100%;
}

// Gallery Section
.hc-gallery-container {
  width: 100%;
}

// Footer
.hc-footer {
  background: #0B0B0E;
  border-top: 1px solid rgba(255, 255, 255, 0.06);
  padding: 60px 0 40px;
  position: relative;
  z-index: 1;
}

.hc-footer-container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 40px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  gap: 20px;

  @media (max-width: 768px) {
    padding: 0 20px;
  }
}

.hc-footer-quote {
  font-family: 'Noto Serif KR', serif;
  font-size: 15px;
  font-style: italic;
  color: rgba(245, 245, 247, 0.5);
  max-width: 600px;
}

.hc-footer-links {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 13px;
}

.footer-link {
  color: rgba(245, 245, 247, 0.7);
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  transition: color 0.2s ease;

  &:hover {
    color: #D4AF37;
  }
}

.footer-dot {
  color: rgba(255, 255, 255, 0.2);
}

.hc-footer-divider {
  width: 60px;
  height: 1px;
  background: rgba(255, 255, 255, 0.1);
  margin: 10px 0;
}

.hc-footer-bottom {
  display: flex;
  flex-direction: column;
  gap: 6px;
  font-size: 12px;
}

.hc-footer-credit {
  color: rgba(245, 245, 247, 0.7);
  font-weight: 500;
}

.hc-footer-disclaimer {
  color: rgba(245, 245, 247, 0.35);
}
</style>
