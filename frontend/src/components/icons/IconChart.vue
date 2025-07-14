<template>
  <IconBase v-bind="$props">
    <line x1="18" y1="20" x2="18" y2="10"/>
    <line x1="12" y1="20" x2="12" y2="4"/>
    <line x1="6" y1="20" x2="6" y2="14"/>
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

defineProps<Props>()
</script> 