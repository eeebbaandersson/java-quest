<script setup>
import { ref, computed } from "vue";
import api from "../services/api";

const props = defineProps({
  question: Object,
  index: Number
});

const nextQuestionEvent = defineEmits(["next-question"]);

const selectedAnswer = ref(null);
const isSubmitting = ref(false);

const parsedOptions = computed(() => {
  const questionOptions = props.question.options;
  if (!questionOptions) return [];
  if (Array.isArray(questionOptions)) return questionOptions;
  if (typeof questionOptions === "object") return Object.values(questionOptions);
  try {
    return JSON.parse(questionOptions);
  } catch {
    return [];
  }
});

const submitAnswer = async () => {
  if (selectedAnswer.value === null || isSubmitting.value) return;
  isSubmitting.value = true;
  
  try {
    const res = await api.checkArenaAnswer(props.question.arena_question_id, selectedAnswer.value);
    nextQuestionEvent("next-question", { correct: res.correct });
    selectedAnswer.value = null;
  } catch (err) {
    console.error("Failed to check arena answer:", err);
    nextQuestionEvent("next-question", { correct: false });
  } finally {
    isSubmitting.value = false;
  }
};
</script>

<template>
  <div class="challenge-card glass-card">
    <p class="question-text">{{ question.question_text }}</p>

    <pre v-if="question.code_snippet" class="challenge-code"><code>{{ question.code_snippet }}</code></pre>

    <div class="options-list">
      <label 
        v-for="(option, optIndex) in parsedOptions" 
        :key="optIndex" 
        class="option-item"
        :class="{ active: selectedAnswer === optIndex }"
      >
        <input 
          type="radio" 
          :name="`arena-question-${question.arena_question_id}`" 
          :value="optIndex" 
          v-model="selectedAnswer" 
        />
        <span>{{ option }}</span>
      </label>
    </div>

    <button 
      @click="submitAnswer" 
      :disabled="selectedAnswer === null || isSubmitting" 
      class="submit-btn"
    >
      {{ isSubmitting ? "Checking..." : "Submit Answer" }}
    </button>
  </div>
</template>

<style scoped>
.challenge-card {
  max-width: 650px;
  margin: 0 auto;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 18px;
  backdrop-filter: blur(10px);
  padding: 28px;
}

.question-text {
  color: #e2e8f0;
  font-size: 1.05rem;
  margin-bottom: 1rem;
  text-align: left;
}

.challenge-code {
  background: rgba(0, 0, 0, 0.3);
  padding: 12px;
  border-radius: 8px;
  color: #e6edf3;
  font-family: monospace;
  margin-bottom: 1rem;
  overflow-x: auto;
  text-align: left;
}

.options-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-bottom: 1.5rem;
}

.option-item {
  display: flex;
  align-items: center;
  gap: 12px;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.06);
  padding: 12px 16px;
  border-radius: 8px;
  cursor: pointer;
  color: #e2e8f0;
  text-align: left;
  width: 100%;
}

.option-item:hover {
  background: rgba(255, 255, 255, 0.08);
  border-color: rgba(255, 255, 255, 0.15);
}

.option-item.active {
  border: 1px solid var(--accent-purple);
  background: var(--glow-purple);
}

.submit-btn {
  background: var(--accent-purple);
  color: white;
  border: none;
  padding: 12px 28px;
  border-radius: 10px;
  font-weight: 600;
  font-family: var(--font-mono);
  cursor: pointer;
  display: block;
  margin: 1.5rem auto 0 auto;
}

.submit-btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}
</style>