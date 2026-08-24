# HangulClocks Design System (MASTER)

## Design Essence
- **Style**: Modern Minimalism + Cultural Elegance (Glassmorphism)
- **Palette**: Sophisticated Dark Theme with Gold Accents
- **Typography**: Noto Sans KR / Noto Serif KR (Cultural readability)
- **Product Type**: Gallery / Showcase

## Color Palette
- `background`: `#0F0F12` (Deep Charcoal)
- `surface`: `rgba(255, 255, 255, 0.04)` (Glassmorphism)
- `primary`: `#D4AF37` (Antique Gold)
- `on-primary`: `#000000`
- `foreground`: `#F5F5F7` (Off-white)
- `muted-foreground`: `#8E8E93` (Gray)
- `border`: `rgba(255, 255, 255, 0.1)`

## Typography
- **Headings**: Noto Serif KR, Bold
- **Body**: Noto Sans KR, Regular / Medium
- **Letter Spacing**: -0.01em
- **Line Height**: 1.6

## Corner Radius
- `radius-lg`: 16px
- `radius-md`: 12px
- `radius-sm`: 8px

## Effects
- **Glassmorphism**: `backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.1);`
- **Shadow**: `0 10px 40px rgba(0, 0, 0, 0.3)`
- **Hover Transition**: `all 0.3s cubic-bezier(0.4, 0, 0.2, 1)`

## Components
### Header & Navbar
- Sticky, blurred glass background (`backdrop-filter: blur(24px)`)
- Refined emblem logo + Antique Gold CTA button with hover glow

### Hero & Live Hangul Clock
- Split hero architecture: narrative heading with gold gradient + interactive 5x5 Hangul matrix clock (5-minute interval)
- Real-time time display with Korean typography highlighting and time simulation slider

### Card & Gallery Controls
- **Glassmorphism Gallery Grid**: 딥 차콜(`#0F0F12`)과 앤틱 골드(`#D4AF37`) 기반의 현대적 미니멀리즘 및 글래스모피즘 인터페이스
- Category filter chips & instant search input
- Glassmorphism container with 1px border highlight (`rgba(255, 255, 255, 0.08)`)
- High-quality image hover scale (1.06) + visit overlay pill
- Title with Antique Gold hover accent and concise description / tags
- Responsive empty search state
