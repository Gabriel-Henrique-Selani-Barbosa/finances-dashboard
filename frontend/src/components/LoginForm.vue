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

<template>
  <div class="auth-card">
  <form @submit.prevent="handleLogin" class="login-form">
    <h2>Login</h2>
    <div class="form-group">
      <label for="email" class="form-label">Email</label>
      <input
        id="email"
        v-model="email"
        type="email"
        class="form-input"
        :class="{ 'form-input--error': error }"
        required
      />
      <label for="password" class="form-label">Senha</label>
      <input
        id="password"
        v-model="password"
        type="password"
        class="form-input"
        :class="{ 'form-input--error': error }"
        required
      />
    </div>
    <button type="submit" :disabled="loading" class="form-button">
      <span v-if="loading" class="loading"></span>
      {{ loading ? 'Entrando...' : 'Login' }}
    </button>
    <div class="login-footer">
      <p>Need to create an account? <a href="#" @click.prevent="$emit('switch')">Sign up</a></p>
    </div>
    <div v-if="error" class="alert alert--error">
      {{ error }}
    </div>
    </form>
  </div>
</template>



<style scoped lang="scss">
@import '@/assets/styles/variables.scss';
@import '@/assets/styles/mixins.scss';

.login-form {
  display: flex;
  flex-direction: column;
  gap: var(--spacing-400);

  h2 {
    color: var(--color-grey-900);
    font-size: 32px;
    font-weight: 700;
    line-height: 120%;
  }
}

.form {
  &-group {
    display: flex;
    flex-direction: column;
  }

  &-label {
    color: var(--color-grey-500);
    font-size: 12px;
    font-weight: 700;
    line-height: 150%;
    margin-bottom: 4px;

    &[for="password"] {
      margin-top: var(--spacing-200);
    }
  }

  &-input {
    border-radius: var(--spacing-100);
    border: 1px solid var(--color-beige-500);
    background: var(--color-white); 
    color: var(--color-grey-500);
    font-size: 16px;
    font-weight: 400;
    line-height: 120%;
    display: flex;
    padding: var(--spacing-150) var(--spacing-250);
    align-items: center;
    gap: var(--spacing-200);
    align-self: stretch;
    
  }

  &-button {
    border-radius: var(--spacing-100);
    background: var(--color-grey-900);
    padding: var(--spacing-150) var(--spacing-250);
    align-self: stretch;  
    color: var(--color-white);
    font-size: 14px;
    font-weight: 700;
    line-height: 150%;
    appearance: none;
    border: none;
  }
}

.login-footer {
  text-align: center;
  display: flex;
  gap: 5px;
  
  p {
    color: var(--color-grey-500);
    font-size: 14px;
    font-weight: 400;
    line-height: 150%;
  }
  
  a {
    color: var(--color-grey-900);
    font-size: 14px;
    font-weight: 700;
    line-height: 150%;
    text-decoration: underline;
  }
}
</style> 