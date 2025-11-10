<script setup lang="ts">
import { computed } from 'vue'
import { IconArrow } from '@/components/icons'
import { Doughnut } from 'vue-chartjs'
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js'

ChartJS.register(ArcElement, Tooltip, Legend)

const props = defineProps<{
  budgets: {
    id: string
    name: string
    amount: number
    currencyType: string
    color: string
  }[]
  spendingLimit: number
  currencyType?: string
}>()

const chartData = computed(() => ({
  labels: props.budgets.map((budget) => budget.name),
  datasets: [
    {
      data: props.budgets.map((budget) => budget.amount),
      backgroundColor: props.budgets.map((budget) => budget.color),
      borderWidth: 0,
    },
  ],
}))

// Plugin para adicionar texto no centro do donut
const centerTextPlugin = {
  id: 'centerText',
  beforeDraw: (chart: any) => {
    const ctx = chart.ctx
    const chartArea = chart.chartArea
    const centerX = (chartArea.left + chartArea.right) / 2
    const centerY = (chartArea.top + chartArea.bottom) / 2

    ctx.save()

    const totalSpent = props.budgets.reduce((sum, b) => sum + b.amount, 0)
    const currencyType = props.currencyType || props.budgets[0]?.currencyType || 'BRL'

    const formattedSpent = totalSpent.toLocaleString('pt-BR', {
      style: 'currency',
      currency: currencyType,
      minimumFractionDigits: 0,
      maximumFractionDigits: 0,
    })

    const formattedLimit = props.spendingLimit.toLocaleString('pt-BR', {
      style: 'currency',
      currency: currencyType,
      minimumFractionDigits: 0,
      maximumFractionDigits: 0,
    })

    // Texto principal (valor gasto)
    ctx.font = 'bold 32px sans-serif'
    ctx.fillStyle = '#201f24'
    ctx.textAlign = 'center'
    ctx.textBaseline = 'middle'
    ctx.fillText(formattedSpent, centerX, centerY - 8)

    // Texto secundário (limite)
    ctx.font = '400 14px sans-serif'
    ctx.fillStyle = '#696868'
    ctx.fillText(`of ${formattedLimit} limit`, centerX, centerY + 20)

    ctx.restore()
  },
}

const chartOptions = computed(() => ({
  responsive: true,
  maintainAspectRatio: false,
  cutout: '70%',
  plugins: {
    legend: {
      display: false,
    },
    tooltip: {
      callbacks: {
        label: function (context: any) {
          const budget = props.budgets[context.dataIndex]
          const total = props.budgets.reduce((sum, b) => sum + b.amount, 0)
          const percentage = ((budget.amount / total) * 100).toFixed(1)
          return `${budget.name}: ${budget.amount.toLocaleString('pt-BR', {
            style: 'currency',
            currency: budget.currencyType,
          })} (${percentage}%)`
        },
      },
    },
  },
}))
</script>

<template>
  <section class="budgets-summary">
    <h2 class="budgets-summary__title">Budgets</h2>
    <a href="#" class="budgets-summary__see-details"
      >See Details <IconArrow :width="12" :height="12" color="#696868"
    /></a>
    <div class="budgets-summary__graph">
      <Doughnut :data="chartData" :options="chartOptions" :plugins="[centerTextPlugin]" />
    </div>
    <ul class="budgets-summary__budgets-list">
      <li
        v-for="budget in budgets"
        :key="budget.id"
        class="budgets-summary__budgets-list-item"
        :style="{ '--before-bg-color': budget.color }"
      >
        <p class="budgets-summary__budgets-list-item-content-title">{{ budget.name }}</p>
        <p class="budgets-summary__budgets-list-item-content-value">
          {{
            budget.amount.toLocaleString('pt-BR', {
              style: 'currency',
              currency: budget.currencyType,
            })
          }}
        </p>
      </li>
    </ul>
  </section>
</template>

<style scoped lang="scss">
@import '@/assets/styles/variables.scss';
@import '@/assets/styles/mixins.scss';

.budgets-summary {
  display: grid;
  grid-template-columns: calc(80% - 10px) calc(20% - 10px);
  grid-template-rows: 24px 1fr;
  padding: var(--spacing-300, 24px) var(--spacing-250, 20px);
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: flex-start;
  gap: var(--spacing-200, 16px);
  align-self: stretch;
  border-radius: var(--spacing-150, 12px);
  background: var(--color-white, #fff);

  @media screen and (min-width: 1400px) {
    grid-template-columns: calc(70% - 10px) calc(30% - 10px);
    grid-column: 8 / 13;
    grid-row: 3 / 7;
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

  &__graph {
    width: 100%;
    height: 300px;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;

    canvas {
      max-width: 280px;
      max-height: 280px;
    }
  }

  &__budgets-list {
    width: 100%;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-200, 16px);
    @include tablet {
      grid-template-columns: 1fr;
    }
    @include desktop {
      grid-template-columns: 1fr;
    }
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
