<script setup lang="ts">
import { ref, computed } from 'vue'
import { IconArrow, IconPots } from '@/components/icons'

const props = defineProps<{
  transactions: {
    id: string
    name: string
    amount: number
    date: string
    image: string
  }[]
  currencyType: string
}>()
</script>

<template>
  <section class="transactions-summary">
    <h2 class="transactions-summary__title">Transactions</h2>
    <a href="#" class="transactions-summary__see-details"
      >View All <IconArrow :width="12" :height="12" color="#696868"
    /></a>
    <ul class="transactions-summary__transactions-list">
      <li
        v-for="transaction in transactions"
        :key="transaction.id"
        class="transactions-summary__transactions-list-item"
      >
        <img
          :src="transaction.image"
          :alt="transaction.name"
          class="transactions-summary__transactions-list-item-image"
        />
        <p class="transactions-summary__transactions-list-item-content-title">
          {{ transaction.name }}
        </p>
        <div class="transactions-summary__transactions-list-item-content-amount">
          <p class="transactions-summary__transactions-list-item-content-amount-value">
            {{
              transaction.amount.toLocaleString('pt-BR', {
                style: 'currency',
                currency: currencyType,
              })
            }}
          </p>
          <p class="transactions-summary__transactions-list-item-content-amount-date">
            {{ transaction.date }}
          </p>
        </div>
      </li>
    </ul>
  </section>
</template>

<style scoped lang="scss">
@import '@/assets/styles/variables.scss';
@import '@/assets/styles/mixins.scss';
.transactions-summary {
  display: grid;
  grid-template-columns: calc(40% - 10px) calc(60% - 10px);
  grid-template-rows: 24px 1fr;
  padding: var(--spacing-300, 24px) var(--spacing-250, 20px);
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: flex-start;
  gap: var(--spacing-100, 8px);
  align-self: stretch;
  border-radius: var(--spacing-150, 12px);
  background: var(--color-white, #fff);

  @media screen and (min-width: 1400px) {
    grid-column: 1 / 8;
    grid-row: 6 / 14;
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
  &__transactions-list {
    width: 100%;
    display: grid;
    grid-template-columns: repeat(1, 1fr);
    background: #f2f2f2;
    gap: 1px;
    grid-column: 1 / 3;
    grid-row: 2 / 3;
    &-item {
      display: flex;
      flex-direction: row;
      gap: 16px;
      padding: 24px 0;
      background: var(--color-white, #fff);
      &-image {
        width: 32px;
        height: 32px;
        border-radius: 100%;
      }
      &-content-title {
        color: var(--color-grey-900, #201f24);
        font-size: var(--font-size-text-preset-4, 14px);
        font-style: normal;
        font-weight: 700;
        line-height: 150%; /* 21px */
      }
      &-content-amount {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        gap: var(--spacing-100, 8px);
        margin-left: auto;
        &-value {
          color: var(--color-green, #277c78);
          text-align: right;
          font-size: var(--font-size-text-preset-4, 14px);
          font-style: normal;
          font-weight: 700;
          line-height: 150%; /* 21px */
        }
        &-date {
          color: var(--color-grey-500, #696868);
          text-align: right;
          font-size: var(--font-size-text-preset-5, 12px);
          font-style: normal;
          font-weight: 400;
          line-height: 150%; /* 18px */
        }
      }
    }
  }
}
</style>
