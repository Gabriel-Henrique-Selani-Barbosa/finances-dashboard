<template>
  <IconBase v-bind="$props">
    <path d="M21 12V7H5a2 2 0 0 1 0-4h14v4"/>
    <path d="M3 5v14a2 2 0 0 0 2 2h16v-5"/>
    <path d="M18 12a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2h4v-6h-4z"/>
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