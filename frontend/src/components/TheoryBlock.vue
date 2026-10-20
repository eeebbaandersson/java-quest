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
  font-size: 1.05rem;
  line-height: 1.6;
  margin: 0 auto 1.5rem auto;
  max-width: 820px;
  width: 100%;
  padding: 0 1rem;
  color: var(--text-secondary);
}
</style>