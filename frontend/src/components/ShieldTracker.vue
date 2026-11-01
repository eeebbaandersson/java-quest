<script setup>
defineProps({
  shields: {
    type: Number,
    required: true,
    default: 3,
  },
  maxShields: {
    type: Number,
    default: 3,
  },
});
</script>

<template>
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
</template>

<style scoped>
.shields-row {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.3rem 0.6rem;
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.02);
  border: 1px solid var(--border-subtle, rgba(255, 255, 255, 0.05));
}

.shields {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 22px;
  height: 22px;
  border-radius: 6px;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.shields .icon-shield {
  width: 14px;
  height: 14px;
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