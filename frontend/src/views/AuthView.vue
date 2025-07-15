<script setup lang="ts">
import { ref } from 'vue'
import LoginForm from '@/components/LoginForm.vue'
import RegisterForm from '@/components/RegisterForm.vue'
import { IconFinance } from '@/components/icons'

const isLogin = ref(true)

const flipCard = () => {
  isLogin.value = !isLogin.value
}
</script>

<template>
  <div class="auth-container">
    <div class="auth-header">
      <IconFinance :width="123" :height="22" color="#ffffff" />
    </div>

    <div class="flip-card" :class="{ flipped: !isLogin }">
      <div class="flip-card-inner">
        <!-- Frente (Login) -->
        <div class="flip-card-front">
          <LoginForm @switch="flipCard" />
        </div>

        <!-- Verso (Register) -->
        <div class="flip-card-back">
          <RegisterForm @switch="flipCard" />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
  @import '@/assets/styles/variables.scss';
  @import '@/assets/styles/mixins.scss';

  .auth {
    &-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: var(--spacing-300) var(--spacing-200);
      position: relative;
    }

    &-card {
      background: var(--color-white);
      border-radius: var(--spacing-150);
      padding: var(--spacing-300, 24px) var(--spacing-250, 20px);
      width: 100%;
      max-width: 560px;
    }

    &-header {
      border-radius: 0px 0px 8px 8px;
      background: var(--color-grey-900);
      display: flex;
      padding: var(--spacing-300) var(--spacing-500);
      flex-direction: column;
      justify-content: center;
      align-items: center;
      gap: var(--spacing-500);
      align-self: stretch;
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      z-index: 1;
    }
  }

  .flip {
    &-card {
      perspective: 1000px;
      width: 100%;
      max-width: 560px;
      margin-top: 80px;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 400px;

      &-inner {
        position: relative;
        width: 100%;
        height: 100%;
        transition: transform 0.8s;
        transform-style: preserve-3d;
      }

      &.flipped &-inner {
        transform: rotateY(180deg);
      }

      &-front,
      &-back {
        position: absolute;
        width: 100%;
        height: 100%;
        backface-visibility: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      &-back {
        transform: rotateY(180deg);
      }
    }
  }
</style>
