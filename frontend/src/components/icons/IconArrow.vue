<template>
  <IconBase
    :width="width"
    :height="height"
    :viewBox="viewBox"
    :fill="fill"
    :stroke="stroke"
    :stroke-width="strokeWidth"
    :className="className"
  >
    <path d="M7 17L17 7M17 7H7M17 7V17" />
  </IconBase>
</template>

<script setup lang="ts">
import IconBase from './IconBase.vue'

interface Props {
  width?: number | string
  height?: number | string
  viewBox?: string
  fill?: string
  stroke?: string
  strokeWidth?: number | string
  className?: string
}

defineProps<Props>()
</script> 