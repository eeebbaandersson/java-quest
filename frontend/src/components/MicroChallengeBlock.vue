<script setup>
import { ref, computed } from "vue";
import api from "../services/api";
import xpService from "../services/xpService";

const props = defineProps({
  question: Object,
  index: Number
});

const nextQuestionEvent = defineEmits(["next-question"]);

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
    if (res.correct) {
      xpService.addXp(props.question.question_id, props.question.xp_reward);
    }
  } catch (err) {
    console.error("Failed to check answer:", err);
  } finally {
    isSubmitting.value = false;
  }
};

const goToNextQuestion = () => {
  nextQuestionEvent("next-question");
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
          :name="`question-${question.question_id}`" 
          :value="optIndex" 
          v-model="selectedAnswer" 
          :disabled="feedback?.correct"
        />
        <span>{{ option }}</span>
      </label>
    </div>

    <button 
      v-if="!feedback?.correct"
      @click="submitAnswer" 
      :disabled="selectedAnswer === null || isSubmitting" 
      class="submit-btn"
    >
      {{ isSubmitting ? "Checking..." : "Submit Answer" }}
    </button>

    <div v-if="feedback" class="feedback-box" :class="{ correct: feedback.correct, incorrect: !feedback.correct }">
      <p class="feedback-title"><strong>{{ feedback.correct ? "Correct!" : "Incorrect!" }}</strong></p>
      <p>{{ feedback.explanation }}</p>

      <button 
        v-if="feedback.correct" 
        @click="goToNextQuestion" 
        class="next-btn"
      >
        Next Question →
      </button>
    </div>
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
}

.challenge-code {
  background: rgba(0, 0, 0, 0.3);
  padding: 12px;
  border-radius: 8px;
  color: #e6edf3;
  font-family: monospace;
  margin-bottom: 1rem;
  overflow-x: auto;
  border: 1px solid rgba(255, 255, 255, 0.05);
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
  transition: all 0.2s ease;
  color: #e2e8f0;
  width: 100%;
}

.option-item:hover {
  background: rgba(255, 255, 255, 0.08);
  border-color: rgba(255, 255, 255, 0.15);
}

.option-item.active {
  border: 1px solid var(--accent-purple);
  background: var(--glow-purple);
  box-shadow: var(--glow-shadow);
}

.submit-btn {
  background: var(--accent-purple);
  color: white;
  border: none;
  padding: 12px 28px;
  border-radius: 10px;
  font-weight: 600;
  font-family: var(--font-mono);
  font-size: 0.85rem;
  letter-spacing: 0.5px;
  cursor: pointer;
  transition: all 0.2s;
  
  width: auto;
  min-width: 180px;
  display: block;
  margin: 1.5rem auto 0 auto;
}

.submit-btn:hover:not(:disabled) {
  filter: brightness(1.15);
  box-shadow: var(--glow-shadow);
}

.submit-btn:disabled {
  background: rgba(255, 255, 255, 0.08);
  color: rgba(255, 255, 255, 0.3);
  cursor: not-allowed;
  box-shadow: none;
}

.next-btn {
  background: #38a169;
  color: white;
  border: none;
  padding: 12px 20px;
  border-radius: 8px;
  font-weight: bold;
  cursor: pointer;
  transition: background 0.2s;
  width: 100%;
  margin-top: 15px;
}

.next-btn:hover {
  background: #2f855a;
}

.feedback-box {
  margin-top: 1.5rem;
  padding: 15px;
  border-radius: 8px;
}

.feedback-box.correct {
  background: rgba(56, 161, 105, 0.15);
  border: 1px solid #38a169;
  color: white;
}

.feedback-box.incorrect {
  background: rgba(229, 62, 62, 0.15);
  border: 1px solid #e53e3e;
  color: white;
}

.feedback-title {
  margin-bottom: 4px;
}

.next-btn {
  margin-top: 15px;
  background: #38a169;
}
.next-btn:hover {
  background: #2f855a;
}
</style>