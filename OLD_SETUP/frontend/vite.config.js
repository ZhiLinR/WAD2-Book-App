import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

const API_PATH = 'http://localhost:8000'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  publicPath :"",
  server: {
    host: true,
    port: 3000,
    proxy: {
      '^/api/.+': API_PATH,
    },
    watch: {
      usePolling: true,
    },
  },
})
