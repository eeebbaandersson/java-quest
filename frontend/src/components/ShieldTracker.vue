<script setup>
defineProps({
  shields: {
    type: Number,
    required: true,
    default: 2,
  },
  maxShields: {
    type: Number,
    default: 3,
  },
});
</script>

<template>
  <div class="shield-tracker-container">
    <div class="tracker-label">ARENA SHIELDS</div>
    <div class="shields-row">
      <div
        v-for="index in maxShields"
        :key="index"
        class="shields"
        :class="{ 'is-lost': index > shields }"
      >
        <span class="badge-icon-mask icon-shield"></span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.shield-tracker-container {
  display: inline-flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 0.8rem 1.2rem;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.02);
  border: 1px solid var(--border-subtle, rgba(255, 255, 255, 0.06));
  margin-top: 2rem;
}

.tracker-label {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  font-weight: 600;
  letter-spacing: 1.2px;
  color: var(--text-muted);
}

.shields-row {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.4rem 0.8rem;
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.02);
  border: 1px solid var(--border-subtle, rgba(255, 255, 255, 0.05));
}

.shields {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  border-radius: 8px;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.shields .icon-shield {
  width: 16px;
  height: 16px;
  color: var(--accent-purple);
  opacity: 1;
  filter: drop-shadow(0 0 6px var(--glow-purple));
  transition: all 0.3s ease;
}

.shields.is-lost .icon-shield {
  color: var(--text-muted);
  opacity: 0.2;
  filter: none;
  transform: scale(0.9);
}
</style>