<script setup>
import { onBeforeUnmount, onMounted, ref, watch } from "vue";

const props = defineProps({
  isOpen: {
    type: Boolean,
    required: true,
  },
});

const emit = defineEmits(["close"]);
const dialog = ref(null);

const closeModal = () => emit("close");

const syncDialog = () => {
  const element = dialog.value;
  if (!element) return;

  if (props.isOpen && !element.open) {
    element.showModal();
  } else if (!props.isOpen && element.open) {
    element.close();
  }
};

onMounted(syncDialog);
watch(() => props.isOpen, syncDialog, { flush: "post" });

onBeforeUnmount(() => {
  if (dialog.value?.open) {
    dialog.value.close();
  }
});
</script>

<template>
  <dialog
    ref="dialog"
    class="info-modal-overlay"
    aria-labelledby="info-modal-title"
    @cancel.prevent="closeModal"
    @click.self="closeModal"
  >
    <div class="info-modal-card" @click.stop>
      <button
        type="button"
        class="modal-close-btn"
        aria-label="Close information"
        autofocus
        @click="closeModal"
      >
        <span aria-hidden="true">&times;</span>
      </button>

      <div class="modal-header">
        <span><span class="highlight">JAVA{}</span>QUEST</span>
      </div>

    <div class="modal-body">
        <div class="concept-item">
          <h4 class="concept-title">Quests</h4>
          <p class="modal-desc">
            Embark on a learning journey, mastering core Java concepts step-by-step through interactive lessons, micro-challenges and prestigious trophies.
          </p>
        </div>

        <div class="concept-item">
          <h4 class="concept-title">Arena Challenges</h4>
          <p class="modal-desc">
            Put your knowledge to the test in one of the arenas. Tackle rigorous programming questions, make it to the end and receive your reward.
            P.S. Just make sure to keep your shields up...
          </p>
        </div>

        <div class="concept-item">
          <h4 class="concept-title">Bug-Vision</h4>
          <p class="modal-desc">
            An interactive challenge where you step into the role of a real-time debugger. Can you spot all hidden bugs across the interface?
          </p>
        </div>
      </div>

    </div>
  </dialog>
</template>

<style scoped>
.info-modal-overlay {
  position: fixed;
  inset: 0;
  width: 100%;
  height: 100%;
  max-width: none;
  max-height: none;
  margin: 0;
  padding: 0;
  border: 0;
  background: transparent;
  color: inherit;
  box-sizing: border-box;
}

.info-modal-overlay[open] {
  display: flex;
  justify-content: center;
  align-items: center;
}

.info-modal-overlay::backdrop {
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
}

.info-modal-card {
  position: relative;
  width: 90%;
  max-width: 600px;
  max-height: calc(100dvh - 3rem); 
  padding: 36px 40px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  gap: 16px;
  margin: auto;
  background: var(--bg-modal);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border-radius: 18px;
  border: 1px solid var(--border-subtle);
  animation: modalScaleIn 0.2s ease-out;
  box-sizing: border-box;
  overflow-y: auto; 
}

.modal-header {
  font-size: 1.5rem;
  font-weight: 600;
  color: #ffffff;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid var(--border-subtle);
  text-align: center;
  margin-bottom: 0.5rem;

}

.highlight {
  color: var(--accent-color);
}

.concept-item {
  display: flex;
  flex-direction: column;
  gap: 6px;
  width: 100%;
  text-align: left; 
}

.concept-title {
  font-size: 1.05rem;
  font-weight: 600;
  color: var(--accent-color, #a855f7);
  margin: 0;
  text-transform: uppercase;
}

.modal-body {
  display: flex;
  flex-direction: column;
  gap: 20px;
  align-items: flex-start;
  width: 100%;
}

.modal-desc {
  color: var(--text-muted);
  font-size: 0.95rem;
  margin: 0;
  line-height: 1.4;
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
</style>
