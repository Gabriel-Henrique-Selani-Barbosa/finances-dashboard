<template>
  <IconBase v-bind="$props">
    <path d="M5 12h14M12 5l7 7-7 7"/>
  </IconBase>
</template>

<script setup lang="ts">
import IconBase from './IconBase.vue'

interface Props {
  size?: number | string
  width?: number | string
  height?: number | string
  color?: string
  className?: string
  viewBox?: string
}

// Definindo viewBox padrão específico para este ícone
withDefaults(defineProps<Props>(), {
  viewBox: '0 0 24 24'
})
</script> 