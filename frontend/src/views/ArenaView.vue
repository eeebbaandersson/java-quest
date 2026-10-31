<script setup>
import { ref, computed, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import api from "../services/api";
import xpService from "../services/xpService";
import ArenaChallenge from "../components/ArenaChallenge.vue";
import ShieldTracker from "../components/ShieldTracker.vue";

import { useTrophies } from "@/composables/useTrophies";
const { checkCarrierTrophy } = useTrophies();

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

const currentQuestion = computed(
  () => questions.value[currentIndex.value] || null,
);

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

    // Check to see if a player finished an arena with all shields remaining
    checkCarrierTrophy(shields.value, maxShields);

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
    const leave = window.confirm(
      "Are you sure? You will lose all your current challenge progress.",
    );
    if (!leave) return;
  }
  router.push("/arenachoice");
};
</script>

<template>
  <div class="arena-container">
    <!-- Loading State -->
    <div v-if="loading" class="loading-state">
      <p>Entering the Arena...</p>
    </div>

    <div v-else-if="currentQuestion" class="challenge-wrapper">

 <div class="arena-header">
  <h2>{{ arena?.level }}</h2>
  <p class="arena-subtitle">{{ arena?.description }}</p>
  
  <div class="header-info-row">
    <span class="question-counter">
      Question {{ currentIndex + 1 }} / {{ questions.length }}
    </span>

    <div class="tracker-wrapper">
      <span class="tracker-label">Shields</span>
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

      <div
        v-else-if="failedArena"
        class="completion-card glass-card result-card"
      >
        <h2>Defeated!</h2>
        <p class="summary-subtitle">
          You run out of shields. What would you like to to?
        </p>

        <div class="action-buttons">
           <button @click="router.push('/arenachoice')" class="secondary-btn">
            Return to Arenas
          </button>
          <button @click="restartArena" class="submit-btn">Try Again</button>
        </div>
      </div>

      <div
        v-else-if="isCompleted"
        class="completion-card glass-card result-card"
      >
        <h2>Congratulations!</h2>
        <p class="summary-subtitle">
          You have successfully conquered the {{ arena?.level }} arena.
        </p>

        <div class="stats-grid">
          <div class="stat-box">
            <span class="stat-label">Score</span>
            <span class="stat-value"
              >{{ correctCount }}/{{ questions.length }}</span
            >
          </div>
          <div class="stat-box">
            <span class="stat-label">Reward</span>
            <span class="stat-value">+250XP</span>
          </div>
        </div>

        <button @click="router.push('/arenachoice')" class="submit-btn">
          Return to Arenas
        </button>
      </div>
    </div>

    <div class="back-navigation">
      <button @click="confirmAndGoHome" class="back-home-btn">
        <span class="arrow">←</span> Leave Arena
      </button>
    </div>
  </div>
</template>

<style scoped>
.arena-container {
  position: relative;
  width: 100%;
  max-width: 1000px;
  margin: 2rem auto;
  padding: 0 20px;
}

.arena-header {
  position: relative; 
  display: flex; 
  flex-direction: column; 
  align-items: center; 
  text-align: center; 
  margin-bottom: 1rem;
  color: #ffffff;
  width: 100%;
}

.arena-header h2 {
  font-size: 2.5rem; 
  font-weight: 800;
  letter-spacing: -0.5px;
  line-height: 1.2;
  margin-bottom: 0.5rem;
  border-bottom: none; 
  padding-bottom: 0;
  text-transform: uppercase;
}

.arena-subtitle {
  font-size: 0.95rem;
  color: var(--text-muted);
  max-width: 600px;
  margin: 0 auto 1.5rem auto;
  line-height: 1.5;
  letter-spacing: 0.5px;
  text-align: center;
  opacity: 0.8;
}

.header-info-row {
  display: flex;
  justify-content: center; 
  align-items: center;
  gap: 2.5rem;
  width: 100%;
  max-width: 650px;
  margin: 1rem auto 0.75rem auto;
  font-family: var(--font-mono);
}

.question-counter {
  font-size: 0.85rem; 
  color: var(--text-muted);
  letter-spacing: 1px;
  text-transform: uppercase;
}

.tracker-wrapper {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.tracker-label {
  font-size: 0.75rem;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 1px;
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
  background-color: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid var(--accent-color); 
  box-shadow: 0 0 20px var(--glow-purple); 
  border-radius: 18px;
  padding: 2rem;
  text-align: center;
  max-width: 655px;
  margin: 0 auto;
  width: 100%;
}

.completion-card h2 {
  color: var(--accent-color); 
  font-size: 1.75rem;
  margin-bottom: 0.5rem;
  font-weight: 800;
}

.summary-subtitle {
  color: var(--text-secondary);
  margin-bottom: 1.5rem;
  font-size: 1rem;
}

.stats-grid {
  display: flex; 
  gap: 16px; 
  justify-content: center; 
  margin-bottom: 30px;
}

.stat-box {
  background: rgba(255, 255, 255, 0.04); 
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
 font-size: 1.5rem; 
  font-weight: 700; 
  color: #fff; 
  font-family: var(--font-mono);
}

.action-buttons {
  display: flex;
  gap: 1rem;
  justify-content: center;
}

.submit-btn {
 display: inline-flex; 
  align-items: center;
  gap: 0.4rem;
  font-family: var(--font-mono);
  font-size: 0.8rem;
  font-weight: 600;
  padding: 0.6rem 1.2rem;
  border-radius: 10px;
  letter-spacing: 0.5px;
  cursor: pointer;
  transition: all 0.3s ease;
  border: 1px solid var(--border-subtle);

  background: var(--glow-purple);
  color: #ffffff;
  border-color: var(--accent-purple);
  box-shadow: var(--glow-shadow);
}

.submit-btn:hover {
  filter: brightness(1.1);
  box-shadow: var(--btn-hover-glow);
}

.secondary-btn {
  background: rgba(255, 255, 255, 0.04);
  color: var(--text-secondary);
  border: 1px solid var(--border-subtle, rgba(255, 255, 255, 0.08));
  padding: 12px 28px;
  border-radius: 10px;
  font-weight: 600;
  font-family: var(--font-mono);
  cursor: pointer;
  transition: all 0.3s ease;
}

.secondary-btn:hover {
  background: rgba(255, 255, 255, 0.08);
  color: #fff;
  border-color: var(--text-secondary);
}

.back-navigation {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 1rem;
  margin-top: 2.5rem;
}

.back-home-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  font-family: var(--font-mono);
  font-size: 0.85rem;
  font-weight: 500;
  color: var(--text-muted);
  text-decoration: none;
  padding: 0.6rem 1.25rem;
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.02);
  border: 1px solid rgba(255, 255, 255, 0.05);
  transition: all 0.3s ease;
  margin-bottom: -2rem;
}

.back-home-btn:hover {
  color: #ffffff;
  background: rgba(255, 255, 255, 0.06);
  border-color: rgba(255, 255, 255, 0.15);
}

.back-home-btn .arrow {
  transition: transform 0.3s ease;
}

.back-home-btn:hover .arrow {
  transform: translateX(-3px);
}

@media (max-width: 1200px) {
  .floating-tracker {
    position: static;
    margin-top: 1rem;
  }
}

/* MOBILE (Skärmar upp till 640px) */
@media (max-width: 640px) {
  .arena-container {
    padding: 0 12px;
    margin: 2rem auto;
  }

  .header-info-row {
    flex-direction: column;
    gap: 1rem;
    margin-top: 0.25rem;
  }
  
  .arena-header h2 {
    font-size: 2rem; 
  }

  .arena-subtitle {
    font-size: 0.85rem;
    padding: 0 10px;
  }

  .completion-card {
    padding: 1.5rem 1rem;
  }

  .stats-grid {
    flex-direction: column;
    gap: 10px;
  }

  .stat-box {
    padding: 12px 16px;
    min-width: unset;
    width: 100%;
  }

  .action-buttons {
    flex-direction: column;
    width: 100%;
  }

  .action-buttons button {
    width: 100%;
  }
  
  .submit-btn {
    width: 100%;
    justify-content: center;
  }
}
</style>
