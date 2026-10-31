<script setup>
defineProps({
    isOpen: {
        type: Boolean,
        required: true,
    },
});

const emit = defineEmits(['close']);

const closeModal = () => {
    emit('close');
};
</script>

<template>
    <!-- INFO MODAL -->
    <div
    v-if="isOpen"
      class="info-modal-overlay"
      @click="closeModal"
    >
      <div class="info-modal-card" @click.stop>
        <button class="modal-close-btn" @click="closeModal">
          &times;
        </button>
        <div class="modal-header">
          <span> JAVAQUEST </span>
        </div>
        <div class="modal-body">
          <p class="modal-desc">A decription of the concepts in the app is coming here shortly...</p>
          <p class="modal-desc">Quests/lessons</p>
          <p class="modal-desc">Arena Challenges</p>
          <p class="modal-desc">BUG-VISION</p>
        </div>
      </div>
    </div>
</template>

<style scoped>
.info-modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  transition: all 0.3s ease-in-out;
}

.info-modal-card {
  position: relative;
  width: 90%;
  max-width: 600px;
  padding: 36px 32px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  gap: 16px;
  margin: 3rem;
  background: var(--bg-modal);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border-radius: 18px;
  border: 1px solid var(--border-subtle);
  animation: modalScaleIn 0.2s ease-out;
}

.modal-header {
  font-size: 1.1rem;
  font-weight: 600;
  color: #ffffff;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid var(--border-subtle);
  text-align: center;
}

.modal-close-btn {
  position: absolute;
  top: 12px;
  right: 14px;
  background: none;
  border: none;
  color: #aaa;
  font-size: 22px;
  cursor: pointer;
  padding: 4px;
  line-height: 1;
  transition: color 0.2s ease;
}

.modal-body {
  display: flex;
  flex-direction: column;
  gap: 12px;
  align-items: center;
  width: 100%;
}

.modal-desc {
  color: var(--text-muted);
  font-size: 0.95rem;
  margin: 0;
}
</style>