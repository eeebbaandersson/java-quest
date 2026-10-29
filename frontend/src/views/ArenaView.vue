<script setup>
import { ref, computed, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import api from "../services/api";
import xpService from "../services/xpService";
import ArenaChallenge from "../components/ArenaChallenge.vue";

const route = useRoute();
const router = useRouter();
const arenaId = route.params.id;

const arena = ref(null);
const questions = ref([]);
const currentIndex = ref(0);
const correctCount = ref(0);
const isCompleted = ref(false);
const loading = ref(true);

onMounted(async () => {
  try {
    const data = await api.getArenaById(arenaId);
    arena.value = data;
    questions.value = data.questions || [];
  } catch (err) {
    console.error("Failed to load arena:", err);
  } finally {
    loading.value = false;
  }
});

const currentQuestion = computed(() => questions.value[currentIndex.value] || null);

const progressPercentage = computed(() => {
  if (questions.value.length === 0) return 0;
  return (currentIndex.value / questions.value.length) * 100;
});

// Handles the event emitted from ArenaChallenge
const handleNextQuestion = ({ correct }) => {
  if (correct) {
    correctCount.value++;
  }

  if (currentIndex.value < questions.value.length - 1) {
    currentIndex.value++;
  } else {
    xpService.addXp(`arena-stage-${arenaId}`, 250);
    isCompleted.value = true;
  }
};
</script>

<template>
  <div class="arena-container">
    <div v-if="loading" class="loading-state">
      <p>Entering the Arena...</p>
    </div>

    <div v-else-if="!isCompleted && currentQuestion" class="challenge-wrapper">
      <div class="arena-header">
        <h2>{{ arena?.level }} Arena</h2>
        <span class="question-counter">
          Question {{ currentIndex + 1 }} of {{ questions.length }}
        </span>
      </div>
      
      <ArenaChallenge 
        :key="currentQuestion.arena_question_id"
        :question="currentQuestion" 
        :index="currentIndex"
        @next-question="handleNextQuestion" 
      />
    </div>

    <div v-else-if="isCompleted" class="completion-card glass-card">
      <h2>🎉 Arena Completed!</h2>
      <p class="summary-subtitle">You conquered the {{ arena?.level }} tier.</p>
      
      <div class="stats-grid">
        <div class="stat-box">
          <span class="stat-label">Score</span>
          <span class="stat-value">{{ correctCount }} / {{ questions.length }}</span>
        </div>
        <div class="stat-box">
          <span class="stat-label">Stage XP Earned</span>
          <span class="stat-value">+250 XP</span>
        </div>
      </div>

      <button @click="router.push('/arenachoice')" class="submit-btn">Return to Arenas</button>
    </div>
  </div>
</template>

<style scoped>
.arena-container { 
    max-width: 700px; 
    margin: 40px auto; 
    padding: 0 20px; 
}
.arena-header { 
    display: flex; 
    flex-direction: column; 
    align-items: center; 
    text-align: center; 
    margin-bottom: 15px; 
    color: #fff; 
}
.arena-header h2 { 
    font-size: 2.5rem; 
    font-weight: 700;
    margin-bottom: 30px; 
}
.question-counter { 
    font-family: var(--font-mono); 
    font-size: 0.9rem; 
    color: rgba(255, 255, 255, 0.6); 
}
.completion-card { 
    background: rgba(255, 255, 255, 0.03); 
    border: 1px solid rgba(255, 255, 255, 0.1); 
    border-radius: 18px; padding: 32px; 
    text-align: center; 
}
.completion-card h2 { 
    color: #fff; 
    margin-bottom: 8px; 
}
.summary-subtitle { 
    color: rgba(255, 255, 255, 0.6); 
    margin-bottom: 24px; 
}
.stats-grid { 
    display: flex; 
    gap: 16px; 
    justify-content: center; 
    margin-bottom: 30px; 
}
.stat-box { 
    background: rgba(255, 255, 255, 0.05); 
    border: 1px solid rgba(255, 255, 255, 0.08); 
    padding: 16px 24px; 
    border-radius: 12px; 
    display: flex; 
    flex-direction: column; 
    min-width: 120px; 
}
.stat-label { 
    font-size: 0.85rem; 
    color: rgba(255, 255, 255, 0.5); 
    margin-bottom: 4px; 
}
.stat-value { 
    font-size: 1.4rem; 
    font-weight: 700; 
    color: #fff; 
    font-family: var(--font-mono); 
}
.submit-btn { 
    background: var(--accent-purple, #805ad5); 
    color: white; 
    border: none; 
    padding: 12px 28px; 
    border-radius: 10px; 
    font-weight: 600; 
    font-family: var(--font-mono); 
    cursor: pointer; 
    display: block; 
    margin: 0 auto; 
}
</style>