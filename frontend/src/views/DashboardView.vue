<template>
  <NavMenu />
  <section class="overview-page">
    <h1 class="overview-page__title">Overview</h1>
    <FinancialSummary
      :currentBalance="4836"
      :totalIncome="3814.25"
      :totalExpenses="1700.5"
      :currencyType="'BRL'"
    />
    <PotsSummary :totalSaved="10000" :currencyType="'BRL'" :pots="pots" />
    <TransactionsSummary :transactions="transactions" :currencyType="'BRL'" />
    <BudgetsSummary :budgets="budgets" :spendingLimit="6000" :currencyType="'BRL'" />
    <RecurringBillsSummary :recurringBills="recurringBills" :currencyType="'BRL'" />
  </section>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import NavMenu from '@/components/NavMenu.vue'
import FinancialSummary from '@/components/FinancialSummary.vue'
import PotsSummary from '@/components/PotsSummary.vue'
import TransactionsSummary from '@/components/TransactionsSummary.vue'
import BudgetsSummary from '@/components/BudgetsSummary.vue'
import RecurringBillsSummary from '@/components/RecurringBillsSummary.vue'

const router = useRouter()
const authStore = useAuthStore()

const user = computed(() => authStore.user)

const handleLogout = () => {
  authStore.logout()
  router.push('/login')
}

const pots = computed(() => [
  { name: 'Pot 1', amount: 1000, color: '#277C78' },
  { name: 'Pot 2', amount: 2000, color: '#F2CDAc' },
  { name: 'Pot 3', amount: 3000, color: '#82C9D7' },
])

const transactions = computed(() => [
  {
    id: '1',
    name: 'Transaction 1',
    amount: 1000,
    date: '2025-01-01',
    image: 'https://placehold.co/150/png',
  },
  {
    id: '2',
    name: 'Transaction 2',
    amount: 2000,
    date: '2025-01-02',
    image: 'https://placehold.co/150/png',
  },
  {
    id: '3',
    name: 'Transaction 3',
    amount: 3000,
    date: '2025-01-03',
    image: 'https://placehold.co/150/png',
  },
])

const budgets = computed(() => [
  { id: '1', name: 'Budget 1', amount: 1000, currencyType: 'BRL', color: '#277C78' },
  { id: '2', name: 'Budget 2', amount: 2000, currencyType: 'BRL', color: '#F2CDAc' },
  { id: '3', name: 'Budget 3', amount: 3000, currencyType: 'BRL', color: '#82C9D7' },
])

const recurringBills = computed(() => [
  { id: '1', name: 'Recurring Bill 1', amount: 100, status: 'paid' },
  { id: '2', name: 'Recurring Bill 2', amount: 5, status: 'upcoming' },
  { id: '3', name: 'Recurring Bill 3', amount: 50, status: 'soon' },
  { id: '4', name: 'Recurring Bill 4', amount: 100, status: 'paid' },
  { id: '5', name: 'Recurring Bill 5', amount: 30, status: 'upcoming' },
  { id: '6', name: 'Recurring Bill 6', amount: 20, status: 'soon' },
  { id: '7', name: 'Recurring Bill 7', amount: 17, status: 'paid' },
  { id: '8', name: 'Recurring Bill 8', amount: 15, status: 'upcoming' },
  { id: '9', name: 'Recurring Bill 9', amount: 10, status: 'soon' },
  { id: '10', name: 'Recurring Bill 10', amount: 5, status: 'paid' },
])
</script>

<style scoped lang="scss">
@import '@/assets/styles/variables.scss';
@import '@/assets/styles/mixins.scss';

.nav-menu--closed {
  @include desktop {
    &+.overview-page {
      width: calc(100dvw - 80px);
      width: calc(100vw - 80px);
      margin-left: 80px;
    }
  }
}

.overview-page {
  display: flex;
  padding: var(--spacing-300, 24px) var(--spacing-200, 16px);
  flex-direction: column;
  align-items: center;
  gap: var(--spacing-400, 32px);
  background: var(--color-beige-100, #f8f4f0);
  height: calc(100dvh - 64px);
  height: calc(100vh - 64px);
  overflow-y: auto;

  @include desktop {
    height: 100dvh;
    height: 100vh;
    width: calc(100dvw - 300px);
    width: calc(100vw - 300px);
    margin-left: 300px;
    transition:
      width 0.3s ease-in-out,
      margin-left 0.3s ease-in-out;
  }

  @media screen and (min-width: 1400px) {
    display: grid;
    grid-template-columns: repeat(12, 1fr);
    grid-template-rows: 56px repeat(12, 1fr);
    gap: var(--spacing-300, 24px);
  }
  &__title {
    color: var(--color-grey-900, #201f24);
    font-size: var(--font-size-text-preset-1, 32px);
    font-style: normal;
    font-weight: 700;
    line-height: 120%; /* 38.4px */
    display: block;
    width: 100%;
    text-align: left;

    @media screen and (min-width: 1400px) {
      grid-column: 1 / 12;
      grid-row: 1 / 2;
    }
  }
}
</style>
