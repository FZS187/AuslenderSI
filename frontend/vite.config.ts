import tailwindcss from '@tailwindcss/vite'
import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'
import { VitePWA } from 'vite-plugin-pwa'

export default defineConfig(({ mode }) => ({
  plugins: [
    react(),
    tailwindcss(),
    mode !== 'android' && VitePWA({
      registerType: 'autoUpdate',
      manifest: {
        name: 'Auslender SI',
        short_name: 'Auslender SI',
        description: 'Mobilni pomočnik za tuje študente v Sloveniji.',
        lang: 'sl',
        theme_color: '#173d36',
        background_color: '#f4f8f6',
        display: 'standalone',
        icons: [
          { src: 'icon-192.png', sizes: '192x192', type: 'image/png' },
          { src: 'icon-512.png', sizes: '512x512', type: 'image/png', purpose: 'any maskable' },
        ],
      },
    }),
  ],
  server: {
    host: '127.0.0.1',
    strictPort: true,
  },
  build: {
    outDir: mode === 'android' ? 'dist-android' : 'dist',
  },
}))
