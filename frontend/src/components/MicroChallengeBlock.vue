<script setup>
import { ref, computed } from "vue";
import api from "../services/api";

const props = defineProps({
  question: Object,
  index: Number
});

const selectedAnswer = ref(null);
const feedback = ref(null);
const isSubmitting = ref(false);


const parsedOptions = computed(() => {
  const questionOptions = props.question.options;
  if (!questionOptions) return [];
  if (Array.isArray(questionOptions)) return questionOptions;
  if (typeof questionOptions === "object") return Object.values(questionOptions);
    return JSON.parse(questionOptions);
  
});

const submitAnswer = async () => {
  if (selectedAnswer.value === null) return;
  isSubmitting.value = true;
  try {
    const res = await api.checkAnswer(props.question.question_id, selectedAnswer.value);
    feedback.value = res;
  } catch (err) {
    console.error("Failed to check answer:", err);
  } finally {
    isSubmitting.value = false;
  }
};
</script>

<template>
  <div class="challenge-card">
    <div class="challenge-header">
      <h3>Micro Challenge</h3>  
    </div>
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
          :name="`question-${question.question_id}`" 
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

    <div v-if="feedback" class="feedback-box" :class="{ correct: feedback.correct, incorrect: !feedback.correct }">
      <p class="feedback-title"><strong>{{ feedback.correct ? "Correct!" : "Incorrect! " }}</strong></p>
      <p>{{ feedback.explanation }}</p>
    </div>
  </div>
</template>

<style scoped>
.challenge-card {
  background: #1a202c;
  border: 1px solid #9c31ce;
  border-radius: 16px;
  padding: 28px;
  max-width: 650px;
  margin: 2rem auto;
}


.challenge-header h3 {
  color: #fff;
  font-size: 1.2rem;
  margin: 0;
}

.xp-badge {
  background: #9c31ce;
  color: #e2e8f0;
  font-size: 0.85rem;
  padding: 4px 10px;
  border-radius: 20px;
  font-weight: bold;
}

.question-text {
  color: #e2e8f0;
  font-size: 1.05rem;
  margin-bottom: 1rem;
}

.challenge-code {
  background: #0d1117;
  padding: 12px;
  border-radius: 6px;
  color: #e6edf3;
  font-family: monospace;
  margin-bottom: 1rem;
  overflow-x: auto;
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
  background: #2d3748;
  padding: 12px 16px;
  border-radius: 6px;
  cursor: pointer;
  transition: background 0.2s;
  color: #e2e8f0;
}

.option-item:hover {
  background: #4a5568;
}

.option-item.active {
  border: 1px solid #9c31ce;
  background: #5c327b;
}

.submit-btn {
  background: #5c327b;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 6px;
  font-weight: bold;
  cursor: pointer;
  transition: background 0.2s;
}

.submit-btn:hover:not(:disabled) {
  background: #9c31ce;
}

.submit-btn:disabled {
  background: #4a5568;
  cursor: not-allowed;
  opacity: 0.6;
}

.feedback-box {
  margin-top: 1.5rem;
  padding: 15px;
  border-radius: 6px;
}

.feedback-box.correct {
  background: rgba(56, 161, 105, 0.15);
  border: 1px solid #d73ee5;
  color: white;
}

.feedback-box.incorrect {
  background: #1a202c;
  border: 1px solid #d73ee5;
  color: white;
}

.feedback-title {
  margin-bottom: 4px;
}
</style>