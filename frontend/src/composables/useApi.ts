import { inject } from 'vue'
import type { AxiosInstance } from 'axios'

export function useApi(): AxiosInstance {
  const api = inject<AxiosInstance>('api')
  
  if (!api) {
    throw new Error('API não está disponível. Verifique se o plugin do Axios foi registrado.')
  }
  
  return api
}

// Alias para manter consistência
export function useAxios(): AxiosInstance {
  return useApi()
} 