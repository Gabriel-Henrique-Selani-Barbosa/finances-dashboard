import { createRouter, createWebHistory } from 'vue-router'
import AuthView from '../views/AuthView.vue'
import DashboardView from '../views/DashboardView.vue'
import { useAuthStore } from '@/stores/auth'
import { storeToRefs } from 'pinia'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'dashboard',
      component: DashboardView
    },
    {
      path: '/auth',
      name: 'auth',
      component: AuthView
    }
  ]
})

router.beforeEach(async (to, from, next) => {
  const authStore = useAuthStore()
  const { token, user } = storeToRefs(authStore)

  await authStore.waitForAutoLogin()

  if (token.value && user.value && to.name === 'auth') {
    return next({ name: 'dashboard' })
  }

  if ((!token.value || !user.value) && to.name === 'dashboard') {
    return next({ name: 'auth' })
  }

  next()
})

export default router
