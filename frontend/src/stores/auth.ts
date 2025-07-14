import { defineStore } from 'pinia'
import { ref } from 'vue'
import { useApi } from '@/composables/useApi'

interface User {
  id: number
  name: string
  email: string
}

interface LoginResponse {
  token: string
  user: User
}

export const useAuthStore = defineStore('auth', () => {
  const user = ref<User | null>(null)
  const token = ref<string | null>(localStorage.getItem('token'))
  const loading = ref(false)
  const api = useApi()

  const login = async (email: string, password: string) => {
    loading.value = true
    try {
      const response = await api.post<LoginResponse>('/api/auth/login', {
        email,
        password
      })
      
      const { token: newToken, user: userData } = response.data
      
      token.value = newToken
      user.value = userData
      
      localStorage.setItem('token', newToken)
      
      return response.data
    } catch (error: any) {
      throw new Error(error.response?.data?.message || 'Erro ao fazer login')
    } finally {
      loading.value = false
    }
  }

  const register = async (name: string, email: string, password: string) => {
    loading.value = true
    try {
      const response = await api.post('/api/auth/register', {
        name,
        email,
        password
      })
      
      return response.data
    } catch (error: any) {
      throw new Error(error.response?.data?.message || 'Erro ao registrar')
    } finally {
      loading.value = false
    }
  }

  const logout = () => {
    user.value = null
    token.value = null
    localStorage.removeItem('token')
  }

  const isAuthenticated = () => {
    return !!token.value && !!user.value
  }

  return {
    user,
    token,
    loading,
    login,
    register,
    logout,
    isAuthenticated
  }
}) 