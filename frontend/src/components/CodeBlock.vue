<template>
  <div class="code-box">
    <pre><code>{{ code }}</code></pre>
  </div>
</template>

<script setup>
defineProps({
  code: { type: String, required: true }
});
</script>

<style scoped>
.code-box {
  background: #1e1e1e;
  color: #dcdcdc;
  padding: 15px;
  border-radius: 8px;
  margin: 15px 0;
  font-family: monospace;
  overflow-x: auto;
}
</style>