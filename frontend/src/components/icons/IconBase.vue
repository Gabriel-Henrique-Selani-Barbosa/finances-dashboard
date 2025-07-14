<template>
  <svg
    :width="finalWidth"
    :height="finalHeight"
    :class="className"
    :style="{ color: color }"
    :viewBox="finalViewBox"
    fill="currentColor"
    xmlns="http://www.w3.org/2000/svg"
  >
    <slot />
  </svg>
</template>

<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  size?: number | string
  width?: number | string
  height?: number | string
  color?: string
  className?: string
  viewBox?: string
}

const props = withDefaults(defineProps<Props>(), {
  size: 24,
  color: 'currentColor',
  className: ''
})

const finalWidth = computed(() => {
  return props.width || props.size
})

const finalHeight = computed(() => {
  return props.height || props.size
})

const finalViewBox = computed(() => {
  // Se viewBox foi explicitamente fornecido, usa ele
  if (props.viewBox) {
    return props.viewBox
  }
  
  // Caso contrário, calcula baseado no width e height
  const width = Number(finalWidth.value)
  const height = Number(finalHeight.value)
  
  // Se width e height são iguais, usa viewBox quadrado
  if (width === height) {
    return `0 0 ${width} ${height}`
  }
  
  // Se são diferentes, mantém a proporção
  return `0 0 ${width} ${height}`
})
</script>

<style scoped lang="scss">
svg {
  display: inline-block;
  vertical-align: middle;
  flex-shrink: 0;
}
</style> 