<script setup lang="ts">
import { onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()

onMounted(() => {
  // Se já estiver logado, redireciona para o dashboard
  if (authStore.isAuthenticated()) {
    router.push('/dashboard')
  }
})
</script>

<template>
  <div class="home-container">
    <div class="home-content">
      <h1>Dashboard Financeiro</h1>
      <p>Gerencie suas finanças de forma simples e eficiente</p>
      
      <div class="action-buttons">
        <router-link to="/login" class="btn btn-primary">
          Fazer Login
        </router-link>
        <router-link to="/register" class="btn btn-secondary">
          Criar Conta
        </router-link>
      </div>
    </div>
  </div>
</template>

<style scoped>
.home-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20px;
}

.home-content {
  text-align: center;
  color: white;
  max-width: 600px;
}

.home-content h1 {
  font-size: 48px;
  font-weight: 700;
  margin-bottom: 20px;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

.home-content p {
  font-size: 20px;
  margin-bottom: 40px;
  opacity: 0.9;
}

.action-buttons {
  display: flex;
  gap: 20px;
  justify-content: center;
  flex-wrap: wrap;
}

.btn {
  padding: 15px 30px;
  border-radius: 8px;
  text-decoration: none;
  font-weight: 600;
  font-size: 16px;
  transition: all 0.3s ease;
  display: inline-block;
}

.btn-primary {
  background: white;
  color: #667eea;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.btn-secondary {
  background: transparent;
  color: white;
  border: 2px solid white;
}

.btn-secondary:hover {
  background: white;
  color: #667eea;
  transform: translateY(-2px);
}

@media (max-width: 768px) {
  .home-content h1 {
    font-size: 36px;
  }
  
  .home-content p {
    font-size: 18px;
  }
  
  .action-buttons {
    flex-direction: column;
    align-items: center;
  }
  
  .btn {
    width: 200px;
  }
}
</style>
