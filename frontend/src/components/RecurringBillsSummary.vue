<script setup lang="ts">
import { computed } from 'vue'
import { IconArrow } from '@/components/icons'

const props = defineProps<{
  recurringBills: {
    id: string
    name: string
    amount: number
    status: string
  }[]
  currencyType: string
}>()

const groupedByStatus = computed(() => {
  const statuses = ['paid', 'soon', 'upcoming']

  return statuses.map((status) => {
    const billsWithStatus = props.recurringBills.filter((bill) => bill.status === status)
    const totalAmount = billsWithStatus.reduce((sum, bill) => sum + bill.amount, 0)

    return {
      status,
      amount: totalAmount,
      count: billsWithStatus.length,
    }
  })
})
</script>

<template>
  <section class="recurring-bills-summary">
    <h2 class="recurring-bills-summary__title">Recurring Bills</h2>
    <a href="#" class="recurring-bills-summary__see-details"
      >See Details <IconArrow :width="12" :height="12" color="#696868"
    /></a>

    <ul class="recurring-bills-summary__recurring-bills-list">
      <li
        v-for="group in groupedByStatus"
        :key="group.status"
        class="recurring-bills-summary__recurring-bills-list-item"
        :class="group.status"
      >
        <p class="recurring-bills-summary__recurring-bills-list-item-content-title">
          {{ group.status }}
        </p>
        <p class="recurring-bills-summary__recurring-bills-list-item-content-value">
          {{ group.amount.toLocaleString('pt-BR', { style: 'currency', currency: currencyType }) }}
        </p>
      </li>
    </ul>
  </section>
</template>

<style scoped lang="scss">
@import '@/assets/styles/variables.scss';
@import '@/assets/styles/mixins.scss';

.recurring-bills-summary {
  display: grid;
  grid-template-columns: calc(40% - 10px) calc(60% - 10px);
  grid-template-rows: 24px 1fr;
  padding: var(--spacing-300, 24px) var(--spacing-250, 20px);
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: flex-start;
  gap: var(--spacing-400, 32px);
  align-self: stretch;
  border-radius: var(--spacing-150, 12px);
  background: var(--color-white, #fff);

  @media screen and (min-width: 1400px) {
    grid-column: 8 / 13;
    grid-row: 7 / 14;
  }

  &__title {
    color: var(--color-grey-900, #201f24);
    font-size: var(--font-size-text-preset-2, 20px);
    font-style: normal;
    font-weight: 700;
    line-height: 120%; /* 24px */
  }
  &__see-details {
    display: flex;
    align-items: center;
    gap: var(--spacing-150, 12px);
    color: var(--color-grey-500, #696868);
    font-size: var(--font-size-text-preset-4, 14px);
    font-style: normal;
    font-weight: 400;
    line-height: 150%; /* 21px */
    text-decoration: none;
    width: auto;
    margin-left: auto;
  }

  &__recurring-bills-list {
    display: grid;
    align-items: flex-start;
    grid-template-rows: repeat(3, 61px);
    gap: var(--spacing-150, 12px);
    align-self: stretch;
    width: 100%;
    grid-column: 1 / 3;
    grid-row: 2 / 3;
    &-item {
      display: flex;
      flex-direction: row;
      justify-content: space-between;
      align-items: center;
      align-self: stretch;
      padding: var(--spacing-250, 20px) var(--spacing-200, 16px);
      border-radius: var(--spacing-100, 8px);
      background: var(--color-beige-100, #f8f4f0);

      &.paid {
        border-left: 4px solid var(--color-green, #277c78);
      }
      &.upcoming {
        border-left: 4px solid var(--color-yellow, #f2cdac);
      }
      &.soon {
        border-left: 4px solid var(--color-cyan, #82c9d7);
      }

      &-content-title {
        color: var(--color-grey-500, #696868);
        font-size: var(--font-size-text-preset-4, 14px);
        font-style: normal;
        font-weight: 400;
        line-height: 150%; /* 21px */
      }
      &-content-value {
        color: var(--color-grey-900, #201f24);
        font-size: var(--font-size-text-preset-4, 14px);
        font-style: normal;
        font-weight: 700;
        line-height: 150%; /* 21px */
      }
    }
  }
}
</style>
