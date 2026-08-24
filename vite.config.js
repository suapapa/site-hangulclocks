import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vuetify from 'vite-plugin-vuetify'
import yaml from '@rollup/plugin-yaml'
import { fileURLToPath, URL } from 'node:url'

// https://vitejs.dev/config/
export default defineConfig({
  base: './',
  plugins: [
    vue(),
    vuetify({ autoImport: true }),
    yaml(),
    {
      name: 'strip-csp-in-dev',
      transformIndexHtml(html, ctx) {
        if (ctx.server) {
          return html.replace(
            /\s*<meta http-equiv="Content-Security-Policy"[^>]*>/i,
            '',
          )
        }
        return html
      },
    },
  ],
  server: {
    host: '127.0.0.1',
    fs: {
      strict: true,
      deny: ['.env', '.env.*', '*.pem', '.git'],
    },
  },
  preview: {
    host: '127.0.0.1',
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    },
    extensions: [
      '.js',
      '.json',
      '.jsx',
      '.mjs',
      '.ts',
      '.tsx',
      '.vue',
      '.yaml',
      '.yml',
    ],
  },
})
