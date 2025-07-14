import type { App } from 'vue'
import api from '../lib/axios'

export default {
  install: (app: App) => {
    // Injetar o Axios para uso em Composition API
    app.provide('axios', api)
    app.provide('api', api)
  }
} 