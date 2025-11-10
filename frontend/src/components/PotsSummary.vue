<script setup lang="ts">
import { ref, computed } from 'vue'
import { IconArrow, IconPots } from '@/components/icons'
const props = defineProps<{
  totalSaved: number
  currencyType: string
  pots: {
    name: string
    amount: number
    color: string
  }[]
}>()
</script>

<template>
  <section class="pots-summary">
    <h2 class="pots-summary__title">Pots</h2>
    <a href="#" class="pots-summary__see-details"
      >See Details <IconArrow :width="12" :height="12" color="#696868"
    /></a>

    <div class="pots-summary__total-saved">
      <IconPots :size="48" :width="48" :height="48" color="#277C78" />
      <div class="pots-summary__total-saved-content">
        <p class="pots-summary__total-saved-content-title">Total Saved</p>
        <p class="pots-summary__total-saved-content-value" :style="{ '--char-count':  totalSaved.toLocaleString('pt-BR', { style: 'currency', currency: currencyType }).length }">
          {{ totalSaved.toLocaleString('pt-BR', { style: 'currency', currency: currencyType }) }}
        </p>
      </div>
    </div>

    <ul class="pots-summary__pots-list">
      <li v-for="pot in pots" :key="pot.name" class="pots-summary__pots-list-item" :style="{ '--before-bg-color': pot.color }">
        <p class="pots-summary__pots-list-item-content-title">{{ pot.name }}</p>
        <p class="pots-summary__pots-list-item-content-value">
          {{ pot.amount.toLocaleString('pt-BR', { style: 'currency', currency: currencyType }) }}
        </p>
      </li>
    </ul>
  </section>
</template>

<style scoped lang="scss">
@import '@/assets/styles/variables.scss';
@import '@/assets/styles/mixins.scss';

.pots-summary {
  display: flex;
  padding: var(--spacing-300, 24px) var(--spacing-250, 20px);
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  gap: var(--spacing-250, 20px);
  align-self: stretch;
  border-radius: var(--spacing-150, 12px);
  background: var(--color-white, #fff);
  @include tablet {
    display: grid;
    grid-template-columns: calc(40% - 10px) calc(60% - 10px);
    grid-template-rows: 24px 1fr;
  }
  @include desktop {
    display: grid;
    grid-template-columns: calc(40% - 10px) calc(60% - 10px);
    grid-template-rows: 24px 1fr;
  }
  @media screen and (min-width: 1400px) {
    grid-column: 1 / 8;
    grid-row: 3 / 6;
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
  &__total-saved {
    display: flex;
    padding: var(--spacing-200, 16px);
    align-items: center;
    gap: var(--spacing-200, 16px);
    align-self: stretch;
    width: 100%;
    border-radius: var(--spacing-150, 12px);
    background: var(--color-beige-100, #f8f4f0);
    &-content {
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      gap: 11px;
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

        @include tablet {
          font-size: calc(32px - (var(--char-count) * .45px));
        }
        @include desktop {
          font-size: calc(32px - (var(--char-count) * .45px));
        }
        @media screen and (min-width: 1400px) {
          font-size: calc(32px - (var(--char-count) * 1px));
        }
      }
    }
  }
  &__pots-list {
    width: 100%;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-200, 16px);
    &-item {
      display: flex;
      flex-direction: column;
      gap: var(--spacing-50, 4px);
      align-items: flex-start;
      align-self: stretch;
      padding-left: var(--spacing-200, 16px);
      position: relative;
      &::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        width: 5px;
        height: 100%;
        background: var(--before-bg-color);
        border-radius: var(--spacing-100, 8px);
      }

      &-content-title {
        color: var(--color-grey-500, #696868);
        font-size: var(--font-size-text-preset-5, 12px);
        font-style: normal;
        font-weight: 400;
        line-height: 150%; /* 18px */
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
