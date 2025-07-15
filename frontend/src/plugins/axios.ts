import { type App } from 'vue'
import api from '@/lib/axios'

export default {
  install: (app: App) => {
    app.provide('api', api)
  }
} 