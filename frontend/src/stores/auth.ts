import { defineStore } from 'pinia'
import { ref } from 'vue'
import axios from 'axios'

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

  // Configurar axios com token
  if (token.value) {
    axios.defaults.headers.common['Authorization'] = `Bearer ${token.value}`
  }

  const login = async (email: string, password: string) => {
    loading.value = true
    try {
      const response = await axios.post<LoginResponse>('http://localhost:3000/api/auth/login', {
        email,
        password
      })
      
      const { token: newToken, user: userData } = response.data
      
      token.value = newToken
      user.value = userData
      
      localStorage.setItem('token', newToken)
      axios.defaults.headers.common['Authorization'] = `Bearer ${newToken}`
      
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
      const response = await axios.post('http://localhost:3000/api/auth/register', {
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
    delete axios.defaults.headers.common['Authorization']
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