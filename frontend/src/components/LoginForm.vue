<template>
  <form @submit.prevent="handleLogin" class="login-form">
    <div class="form-group">
      <label for="email">Email</label>
      <input
        id="email"
        v-model="email"
        type="email"
        placeholder="Digite seu email"
        required
      />
    </div>
    <div class="form-group">
      <label for="password">Senha</label>
      <input
        id="password"
        v-model="password"
        type="password"
        placeholder="Digite sua senha"
        required
      />
    </div>
    <button type="submit" :disabled="loading" class="login-button">
      {{ loading ? 'Entrando...' : 'Entrar' }}
    </button>
    <div class="login-footer">
      <p>Não tem uma conta? <a href="#" @click.prevent="$emit('switch')">Registre-se</a></p>
    </div>
    <div v-if="error" class="error-message">
      {{ error }}
    </div>
  </form>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const emit = defineEmits(['switch'])
const router = useRouter()
const authStore = useAuthStore()

const email = ref('')
const password = ref('')
const loading = ref(false)
const error = ref('')

const handleLogin = async () => {
  loading.value = true
  error.value = ''
  try {
    await authStore.login(email.value, password.value)
    router.push('/dashboard')
  } catch (err: any) {
    error.value = err.message || 'Erro ao fazer login'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-form {
  margin-bottom: 20px;
}
.form-group {
  margin-bottom: 20px;
}
.form-group label {
  display: block;
  margin-bottom: 8px;
  color: #333;
  font-weight: 500;
  font-size: 14px;
}
.form-group input {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #e1e5e9;
  border-radius: 8px;
  font-size: 14px;
  transition: border-color 0.3s ease;
  box-sizing: border-box;
}
.form-group input:focus {
  outline: none;
  border-color: #667eea;
}
.login-button {
  width: 100%;
  padding: 12px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: opacity 0.3s ease;
}
.login-button:hover:not(:disabled) {
  opacity: 0.9;
}
.login-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}
.login-footer {
  text-align: center;
  margin-top: 20px;
}
.login-footer p {
  color: #666;
  font-size: 14px;
}
.login-footer a {
  color: #667eea;
  text-decoration: none;
  font-weight: 500;
}
.login-footer a:hover {
  text-decoration: underline;
}
.error-message {
  background: #fee;
  color: #c33;
  padding: 12px;
  border-radius: 8px;
  margin-top: 20px;
  text-align: center;
  font-size: 14px;
}
</style> 