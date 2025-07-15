<template>
  <svg
    :width="width"
    :height="height"
    :viewBox="computedViewBox"
    :fill="fill"
    :stroke="stroke"
    :stroke-width="strokeWidth"
    :class="className"
    xmlns="http://www.w3.org/2000/svg"
  >
    <slot />
  </svg>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  width?: number | string
  height?: number | string
  viewBox?: string
  fill?: string
  stroke?: string
  strokeWidth?: number | string
  className?: string
}

const props = withDefaults(defineProps<Props>(), {
  width: 24,
  height: 24,
  fill: 'currentColor',
  stroke: 'none',
  strokeWidth: 1,
  className: ''
})

const computedViewBox = computed(() => {
  if (props.viewBox) {
    return props.viewBox
  }

  const w = typeof props.width === 'number' ? props.width : 24
  const h = typeof props.height === 'number' ? props.height : 24

  if (w === h) {
    return `0 0 ${w} ${h}`
  }

  return `0 0 ${w} ${h}`
})
</script>

<style scoped lang="scss">
svg {
  display: inline-block;
  vertical-align: middle;
  flex-shrink: 0;
}
</style> 