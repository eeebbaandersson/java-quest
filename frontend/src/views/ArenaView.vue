<script setup>
import { ref, computed, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import api from "../services/api";
import xpService from "../services/xpService";
import ArenaChallenge from "../components/ArenaChallenge.vue";
import ShieldTracker from "../components/ShieldTracker.vue";

const route = useRoute();
const router = useRouter();
const arenaId = route.params.id;

const arena = ref(null);
const questions = ref([]);
const currentIndex = ref(0);
const correctCount = ref(0);
const isCompleted = ref(false);
const loading = ref(true);
const shields = ref(3);
const maxShields = 3;
const failedArena = ref(false);

onMounted(async () => {
  try {
    const stage = Number(arenaId);

if (![1, 2, 3].includes(stage)) {
  await router.replace("/arenachoice");
  return;
}

if (
  stage > 1 &&
  localStorage.getItem(`arena-stage-${stage - 1}-completed`) !== "true"
) {
  await router.replace("/arenachoice");
  return;
}

const data = await api.getArenaById(arenaId);
    arena.value = data;
    questions.value = data.questions || [];
  } catch (err) {
    console.error("Failed to load arena:", err);
  } finally {
    loading.value = false;
    throw new Error("Failed to load arena data.");
  }
});

const currentQuestion = computed(() => questions.value[currentIndex.value] || null);

const handleNextQuestion = ({ correct }) => {
  if (correct) {
    correctCount.value++;
  } else {
    shields.value--;
    if (shields.value <= 0) {
      failedArena.value = true;
      return;
    }
  }

  if (currentIndex.value < questions.value.length - 1) {
    currentIndex.value++;
  } else {
    xpService.addXp(`arena-stage-${arenaId}`, 250);
    localStorage.setItem(`arena-stage-${arenaId}-completed`, "true");
    isCompleted.value = true;
  }
};

const restartArena = () => {
  shields.value = maxShields;
  currentIndex.value = 0;
  correctCount.value = 0;
  failedArena.value = false;
};

const confirmAndGoHome = () => {
  if (!isCompleted.value && !failedArena.value) {
    const leave = window.confirm("Are you sure? You will lose all your current challenge progress.");
    if (!leave) return;
  }
  router.push('/arenachoice'); 
};
</script>

<template>
  <div class="arena-container">
    <button @click="confirmAndGoHome" class="back-home-btn">
      ← Leave Arena
    </button>

    <!-- Loading State -->
    <div v-if="loading" class="loading-state">
      <p>Entering the Arena...</p>
    </div>

    <div v-else-if="currentQuestion" class="challenge-wrapper">
      <div class="arena-header">
        <h2>{{ arena?.level }} Arena</h2>
        
        <div class="header-info-row">
          <div class="side-spacer"></div>
          <span class="question-counter">
            Question {{ currentIndex + 1 }} of {{ questions.length }}
          </span>
          <div class="tracker-wrapper">
            <ShieldTracker :shields="shields" :maxShields="maxShields" />
          </div>
        </div>
      </div>

      <ArenaChallenge 
        v-if="!failedArena && !isCompleted"
        :key="currentQuestion.arena_question_id"
        :question="currentQuestion" 
        @next-question="handleNextQuestion" 
      />

      <div v-else-if="failedArena" class="completion-card glass-card result-card">
        <h2>Defeated!</h2>
        <p class="summary-subtitle">You lost all your shields. Please try again.</p>
        
        <div class="action-buttons">
          <button @click="restartArena" class="submit-btn">Try Again</button>
          <button @click="router.push('/arenachoice')" class="secondary-btn">Return to Hub</button>
        </div>
      </div>

      <div v-else-if="isCompleted" class="completion-card glass-card result-card">
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
  </div>
</template>

<style scoped>
.arena-container { 
  position: relative;
  max-width: 700px; 
  margin: 40px auto; 
  padding: 0 20px; 
}

.back-home-btn {
  position: absolute;
  top: 0;
  left: 20px;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: rgba(255, 255, 255, 0.8);
  padding: 8px 16px;
  border-radius: 8px;
  font-family: var(--font-mono);
  font-size: 0.85rem;
  cursor: pointer;
  transition: all 0.2s ease;
}

.back-home-btn:hover {
  background: rgba(255, 255, 255, 0.1);
  color: #fff;
  border-color: rgba(255, 255, 255, 0.2);
}

.arena-header { 
  display: flex; 
  flex-direction: column; 
  align-items: center; 
  text-align: center; 
  margin-bottom: 20px; 
  color: #fff; 
  width: 100%;
}

.arena-header h2 { 
  font-size: 2.5rem; 
  font-weight: 700;
  margin-bottom: 12px; 
}

.header-info-row {
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: center;
  width: 100%;
  max-width: 650px;
  margin-bottom: 5px;
}

.side-spacer {
  justify-self: start;
}

.question-counter { 
  grid-column: 2;
  font-family: var(--font-mono); 
  font-size: 0.95rem; 
  color: rgba(255, 255, 255, 0.7); 
  text-align: center;
}

.tracker-wrapper {
  grid-column: 3;
  justify-self: end;
}

.challenge-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
}

.result-card {
  width: 100%;
  max-width: 650px;
  margin-top: 10px;
}

.completion-card { 
  background: rgba(255, 255, 255, 0.03); 
  border: 1px solid rgba(255, 255, 255, 0.1); 
  border-radius: 18px; 
  padding: 32px; 
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

.action-buttons {
  display: flex;
  gap: 12px;
  justify-content: center;
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

.secondary-btn {
  background: rgba(255, 255, 255, 0.08);
  color: #fff;
  border: 1px solid rgba(255, 255, 255, 0.15);
  padding: 12px 28px;
  border-radius: 10px;
  font-weight: 600;
  font-family: var(--font-mono);
  cursor: pointer;
}
</style>