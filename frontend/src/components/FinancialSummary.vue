<script setup lang="ts">
const props = defineProps<{
  currentBalance: number
  totalIncome: number
  totalExpenses: number
  currencyType: string
}>()
</script>

<template>
  <section class="financial-summary">
    <div class="financial-summary-card">
      <h3 class="financial-summary-card-title">Current Balance</h3>
      <p class="financial-summary-card-value">{{ currentBalance.toLocaleString('pt-BR', { style: 'currency', currency: currencyType }) }}</p>
    </div>
    <div class="financial-summary-card">
      <h3 class="financial-summary-card-title">Total Income</h3>
      <p class="financial-summary-card-value">{{ totalIncome.toLocaleString('pt-BR', { style: 'currency', currency: currencyType }) }}</p>
    </div>
    <div class="financial-summary-card">
      <h3 class="financial-summary-card-title">Total Expenses</h3>
      <p class="financial-summary-card-value">{{ totalExpenses.toLocaleString('pt-BR', { style: 'currency', currency: currencyType }) }}</p>
    </div>
  </section>
</template>

<style scoped lang="scss">
@import '@/assets/styles/variables.scss';
@import '@/assets/styles/mixins.scss';
.financial-summary {
  display: grid;
  grid-template-columns: 1fr;
  align-items: flex-start;
  gap: var(--spacing-150, 12px);
  align-self: stretch;
  @media screen and (min-width: 1400px) {
    grid-column: 1 / 13;
    grid-row: 2 / 3;
  }
  @include tablet {
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-300, 24px);
  }

  @include desktop {
    grid-template-columns: repeat(3, 1fr);
    gap: var(--spacing-300, 24px);
  }

  &-card {
    display: flex;
    padding: var(--spacing-250, 20px);
    flex-direction: column;
    align-items: flex-start;
    gap: 12px;
    align-self: stretch;
    border-radius: var(--spacing-150, 12px);
    background: var(--color-white, #fff);

    &:nth-child(1) {
      background: var(--color-grey-900, #201f24);

      .financial-summary-card-title {
        color: var(--color-white, #fff);
      }
      .financial-summary-card-value {
        color: var(--color-white, #fff);
      }
    }

    &-title {
      color: var(--color-grey-500, #696868);
      font-size: var(--font-size-text-preset-4, 14px);
      font-style: normal;
      font-weight: 400;
      line-height: 150%; /* 21px */
    }
    &-value {
      color: var(--color-grey-900, #201f24);
      font-size: var(--font-size-text-preset-1, 32px);
      font-style: normal;
      font-weight: 700;
      line-height: 120%; /* 38.4px */
    }
  }
}
</style>
