<template>
  <div class="auth-container">
    <div class="auth-card">
      <div class="auth-header">
        <h1>Dashboard Financeiro</h1>
        <p v-if="isLogin">Faça login para continuar</p>
        <p v-else>Registre-se para começar</p>
      </div>
      <LoginForm v-if="isLogin" @switch="isLogin = false" />
      <RegisterForm v-else @switch="isLogin = true" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import LoginForm from '@/components/LoginForm.vue'
import RegisterForm from '@/components/RegisterForm.vue'

const isLogin = ref(true)
</script>

<style scoped>
.auth-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20px;
}

.auth-card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  padding: 40px;
  width: 100%;
  max-width: 400px;
}

.auth-header {
  text-align: center;
  margin-bottom: 30px;
}

.auth-header h1 {
  color: #333;
  margin-bottom: 8px;
  font-size: 24px;
  font-weight: 600;
}

.auth-header p {
  color: #666;
  font-size: 14px;
}
</style> 