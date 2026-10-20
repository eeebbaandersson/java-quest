<template>
  <div class="code-box">
    <div class="terminal-header">
      <span class="dot red"></span>
      <span class="dot yellow"></span>
      <span class="dot green"></span>
      <span class="terminal-title">Main.java</span>
    </div>
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
  background-color: rgba(18, 18, 22, 0.7);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid var(--border-subtle);
  color: #e2e8f0;
  padding: 1.25rem 1.5rem;
  border-radius: 18px;
  margin: 0 auto 1.5rem auto;
  max-width: 820px;
  width: 100%;
  font-family: var(--font-mono);
  overflow-x: auto;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
  transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1);
}

.terminal-header {
  display: flex;
  align-items: center;
  gap: 6px;
  margin-bottom: 1rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);
}

.dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
}

.dot.red { background-color: #ff5f56; }
.dot.yellow { background-color: #ffbd2e; }
.dot.green { background-color: #27c93f; }

.terminal-title {
  margin-left: 8px;
  font-size: 0.75rem;
  color: var( --accent-purple);
  letter-spacing: 0.5px;
}

.code-box pre {
  margin: 0;
  white-space: pre-wrap;
  word-break: break-word;
  font-size: 0.88rem;
}
</style>