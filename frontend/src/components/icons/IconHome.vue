<template>
  <IconBase v-bind="$props">
    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
    <polyline points="9,22 9,12 15,12 15,22"/>
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