<template>
  <div class="theory-box" v-html="content"></div>
</template>

<script setup>
defineProps({
  content: { type: String, required: true }
});
</script>

<style scoped>
.theory-box {
  font-size: 1.1rem;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}
</style>