# AGENTS.md

This document serves as a guideline for all AI agents and developers responsible for the development and maintenance of the **HangulClocks** project. To ensure consistency and technical progression, the following requirements must be strictly followed.

## 🚀 Core Principles

1.  **Modern Code Style**: Prioritize **Vue 3 Composition API (`<script setup>`)** and **TypeScript**.
2.  **Adherence to Design Philosophy**: Reflect the **Modern Minimalism + Cultural Elegance (Glassmorphism)** design system, as specified in `design-system/MASTER.md`, in all UI developments.
3.  **Real-time Documentation Updates (CRITICAL)**: Whenever a new feature is added, tech stack is changed, or a new pattern is introduced, **`README.md` and `AGENTS.md` must be updated immediately**.

## 🎨 Design System Guide

Compliance with the following guide is required for all UI and styling tasks:
- **Background Color**: `#0F0F12` (Deep Charcoal)
- **Surface Color**: `rgba(255, 255, 255, 0.04)` (Glassmorphism)
- **Accent Color**: `#D4AF37` (Antique Gold)
- **Effects**: `backdrop-filter: blur(12px);` and subtle borders (`border: 1px solid rgba(255, 255, 255, 0.1);`) to express glassy textures.

Refer to [MASTER.md](./design-system/MASTER.md) for more details.

## 🛠 Architecture and Tech Stack

- **UI Framework**: Vuetify 4 (Material Design + Custom Glassmorphism)
- **Build**: Vite 8 / npm (Based on **Node 22 LTS**)
- **Data Management**: YAML (`@rollup/plugin-yaml`)
- **Deployment**: Docker (`node:22-alpine` / `nginx:stable-alpine`)
- **Structure**:
  - `src/components/`: Reusable UI components
  - `src/assets/`: Static assets and **YAML data files**
  - `src/plugins/`: Vuetify and other plugin configurations
  - `design-system/`: Definition of visual values and design tokens for the project

## 📝 Document Maintenance Rules

All AI agents must keep documentation up-to-date in the following situations:

- When new dependencies are added or library versions have major updates.
- When new components or core features are added, changing the appearance or behavior of the project.
- When the design system in `MASTER.md` is changed, modifying color schemes or layout principles.
- **The Most Important Rule**: Even without a direct request from the user, if the work being performed deviates from or adds to the existing documentation, those changes must be reflected in the documentation immediately.

## 💻 Local Development Guide

### Install Dependencies
```bash
npm install
```

### Run Development Server
```bash
npm run dev
```

### Build for Production
```bash
npm run build
```

## 🐳 Docker Deployment

The project supports multi-stage builds (`node:22-alpine` and `nginx:stable-alpine`) for GKE and other container environments.

### Build Image
```bash
# Standard root deployment
docker build -t site-hangulclocks .

# Sub-path (/hangulclocks) deployment
docker build --build-arg URL_PREFIX=hangulclocks -t site-hangulclocks .
```

---

*This document was created to help AI agents maintain the context of this project and produce the best possible results.*
