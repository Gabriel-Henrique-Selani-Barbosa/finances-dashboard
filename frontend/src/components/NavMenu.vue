<script setup lang="ts">
import { ref, computed } from 'vue'
import {
  IconOverview,
  IconTransactions,
  IconBudgets,
  IconPots,
  IconRecurringBills,
  IconFinance,
  IconMinimizeMenu,
} from '@/components/icons'

const isMenuOpen = ref(false)

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value
}

// computed
const menuClass = computed(() => {
  return isMenuOpen.value ? 'nav-menu--closed' : 'nav-menu--open'
})
</script>

<template>
  <nav class="nav-menu" :class="menuClass">
    <div class="nav-menu-header">
      <IconFinance :width="123" :height="22" color="#ffffff" />
    </div>
    <router-link to="/" class="nav-menu-item">
      <IconOverview :size="24" color="#B3B3B3" />
      <span>Overview</span>
    </router-link>
    <router-link to="/transactions" class="nav-menu-item">
      <IconTransactions :size="24" color="#B3B3B3" />
      <span>Transactions</span>
    </router-link>
    <router-link to="/budgets" class="nav-menu-item">
      <IconBudgets :size="24" color="#B3B3B3" />
      <span>Budgets</span>
    </router-link>
    <router-link to="/pots" class="nav-menu-item">
      <IconPots :size="24" color="#B3B3B3" />
      <span>Pots</span>
    </router-link>
    <router-link to="/recurring-bills" class="nav-menu-item">
      <IconRecurringBills :size="24" color="#B3B3B3" />
      <span>Recurring bills</span>
    </router-link>
    <button class="nav-menu-minimize" @click="toggleMenu">
      <IconMinimizeMenu :size="24" color="#B3B3B3" />
      <span>Minimize Menu</span>
    </button>
  </nav>
</template>

<style scoped lang="scss">
@import '@/assets/styles/variables.scss';
@import '@/assets/styles/mixins.scss';

.nav-menu {
  display: flex;
  flex-direction: row;
  border-radius: var(--spacing-100) var(--spacing-100) 0px 0px;
  background: var(--color-grey-900);
  width: 100%;
  position: fixed;
  bottom: 0;
  left: 0;
  z-index: 1000;
  padding: var(--spacing-100) var(--spacing-200) 0px var(--spacing-200);
  justify-content: space-between;
  align-items: center;
  transition: width 0.3s ease-in-out, padding 0.3s ease-in-out;

  @include desktop {
    width: 300px;
    height: 100%;
    top: 0;
    border-radius: 0 var(--spacing-100) var(--spacing-100) 0;
    flex-direction: column;
    gap: 4px;
    justify-content: flex-start;
    align-items: flex-start;
    padding: 0 var(--spacing-300) 0 0;
    transition: width 0.3s ease-in-out, padding 0.3s ease-in-out;
  }

  &.nav-menu--closed {
    width: 80px;
    padding: 0 var(--spacing-100) 0 0;
    
    .nav-menu-item {
      font-size: 0;
      padding: var(--spacing-200);
      transition: font-size 0.3s ease-in-out, padding 0.3s ease-in-out;
      
      span {
        opacity: 0;
        transform: translateX(-10px);
        transition: opacity 0.3s ease-in-out, transform 0.3s ease-in-out;
      }
    }

    .nav-menu-minimize {
      font-size: 0;
      transition: font-size 0.3s ease-in-out;
      
      span {
        opacity: 0;
        transform: translateX(-10px);
        transition: opacity 0.3s ease-in-out, transform 0.3s ease-in-out;
      }
      
      svg {
        transform: rotate(180deg);
        transition: transform 0.3s ease-in-out;
      }
    }
  }

  &-header {
    display: none;
    @include desktop {
      display: flex;
      width: 100%;
      padding: var(--spacing-500) var(--spacing-400);
      margin-bottom: var(--spacing-300);
      transition: opacity 0.3s ease-in-out;
    }
  }

  &.nav-menu--closed &-header {
    opacity: 0;
  }

  &-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: var(--spacing-50);
    border-radius: 8px 8px 0px 0px;
    width: 100%;
    padding: var(--spacing-100) 0px var(--spacing-150) 0px;
    position: relative;
    overflow: hidden;
    color: var(--color-grey-300);
    font-size: 12px;
    font-weight: 700;
    line-height: 150%;
    text-decoration: none;
    transition: font-size 0.3s ease-in-out, padding 0.3s ease-in-out;

    @include desktop {
      flex-direction: row;
      align-items: center;
      gap: var(--spacing-200);
      padding: var(--spacing-200) var(--spacing-400);
      border-radius: 0 var(--spacing-200) var(--spacing-200) 0;
    }

    @include mobile {
      font-size: 0;
      gap: 0;
    }

    span {
      transition: opacity 0.3s ease-in-out, transform 0.3s ease-in-out;
    }

    &::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 0;
      background: var(--color-beige-100);
      transition: all 0.3s ease-in-out;
      z-index: -1;

      @include desktop {
        height: 100%;
        width: 0;
      }
    }

    &.router-link-active,
    &:hover {
      border-bottom: 4px solid var(--color-green);
      color: var(--color-grey-900);

      @include desktop {
        border-bottom: none;
        border-left: 4px solid var(--color-green);
      }

      &::after {
        height: 100%;

        @include desktop {
          width: 100%;
        }
      }

      svg {
        color: var(--color-green);
      }
    }
  }

  &-minimize {
    display: none;
    @include desktop {
      display: flex;
      align-items: center;
      justify-content: flex-start;
      margin: auto 0 var(--spacing-800) var(--spacing-400);
      gap: var(--spacing-200);
      width: auto;
      padding: var(--spacing-100) 0px;
      border: none;
      background: none;
      cursor: pointer;
      color: var(--color-grey-300);
      font-size: 12px;
      font-weight: 700;
      line-height: 150%;
      text-decoration: none;
      transition: font-size 0.3s ease-in-out;
    }
    
    span {
      transition: opacity 0.3s ease-in-out, transform 0.3s ease-in-out;
    }
    
    svg {
      transition: transform 0.3s ease-in-out;
    }
  }
}
</style>
