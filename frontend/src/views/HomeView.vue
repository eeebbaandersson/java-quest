<script setup>
import { computed, ref } from "vue";
import { RouterLink } from "vue-router";
import Navbar from "@/components/Navbar.vue";

import xpService from "@/services/xpService";

import { useBugHunting } from "@/composables/useBugHunting";
const {totalXP, foundBugs, totalBugs, captureBug, isBugVisionActive, isBugCaptured,} = useBugHunting();
const animatingBugs = ref(new Set());

const handleBugClick = (bugId) => {
  if (animatingBugs.value.has(bugId)) return;

  // Start animation
  animatingBugs.value.add(bugId);

  // Wait for animation to finish before bug is removed
  setTimeout(() => {
    captureBug(bugId);
    animatingBugs.value.delete(bugId);
  }, 700);
};


import { useTrophies } from "@/composables/useTrophies";
const { trophies } = useTrophies();

const selectedTrophy = ref(null);

const openTrophyModal = (trophie) => {
  selectedTrophy.value = trophie;
};

const closeTrophyModal = () => {
  selectedTrophy.value = null;
};

const lessons = computed(() => {
  let lessonCompleted = {};
  try {
    const parsed = JSON.parse(
      localStorage.getItem("completed_lessons") || "{}",
    );
    if (parsed && typeof parsed === "object") {
      lessonCompleted = parsed;
    }
  } catch (error) {
    console.warn("Could not read completed_lessons from localStorage", error);
  }
  return [
    {
      id: 1,
      number: "01",
      title: "Variables",
      isCompleted: !!lessonCompleted["variables"],
    },
    {
      id: 2,
      number: "02",
      title: "Operators",
      isCompleted: !!lessonCompleted["operators"],
    },
    {
      id: 3,
      number: "03",
      title: "If / Else",
      isCompleted: !!lessonCompleted["ifelse"],
    },
    {
      id: 4,
      number: "04",
      title: "Loops",
      isCompleted: !!lessonCompleted["loops"],
    },
    {
      id: 5,
      number: "05",
      title: "Arrays",
      isCompleted: !!lessonCompleted["arrays"],
    },
    {
      id: 6,
      number: "06",
      title: "Methods",
      isCompleted: !!lessonCompleted["methods"],
    },
    {
      id: 7,
      number: "07",
      title: "Classes",
      isCompleted: !!lessonCompleted["classes"],
    },
  ];
});

const currentLevelObj = computed(() => xpService.getLevel(totalXP.value));

</script>

<template>
  <div class="home-container">
    <!-- HERO-SEKTION -->
    <section class="hero-section java-quest">
      <h1 class="logo-title"><span class="highlight">JAVA{}</span>QUEST</h1>
      <p class="hero-subtitle">
        Level up your Java skills, one quest at a time.
      </p>
    </section>

    <header class="app-header">
      <Navbar />
    </header>

    <!-- STATS-SEKTION -->
    <section class="stats-section">
      <div class="stats-container">
        <div class="stats-card glass-card">
          <p class="card-title">QUESTS</p>
          <div class="badges-wrapper">
            <RouterLink
              v-for="lesson in lessons"
              :key="lesson.id"
              :to="`/lessons/${lesson.title.toLowerCase().replace(/[^a-z0-9]/g, '')}`"
              class="badge"
              :class="{ completed: lesson.isCompleted }"
              :aria-label="lesson.title"
            >
              {{ lesson.number }}
            </RouterLink>
          </div>
        </div>

        <div class="stats-card glass-card">
          <p class="card-title">STATS</p>
          <div class="xp-simple-wrapper">
            <div class="stats-row">
              <div class="xp-display" :class="{ active: totalXP > 0 }">
                <span class="xp-number">{{ totalXP }}</span>
                <span class="xp-unit">TOTAL XP</span>
              </div>

              <div class="xp-display">
                <span class="xp-number">{{ currentLevelObj.level }}</span>
                <span class="xp-unit">LEVEL</span>
              </div>
            </div>
            <div class="bug-tracker-wrapper">
              <p class="bug-tracker-title">
                CAPTURED BUGS ({{ foundBugs }}/{{ totalBugs }})
              </p>
              <div class="bug-icons-row">
                <span
                  v-for="index in totalBugs"
                  :key="index"
                  class="bug-badge"
                  :class="{ found: index <= foundBugs }"
                  :title="index <= foundBugs ? 'Bug captured!' : 'Hidden bug'"
                >
                  <span class="badge-icon-mask icon-bug"></span>
                </span>
              </div>
            </div>
          </div>
        </div>

        <div class="stats-card glass-card">
          <p class="card-title">TROPHIES</p>
          <div class="badges-wrapper">
            <span v-for="trophie in trophies" :key="trophie.id" class="badge" :class="{ unlocked: trophie.isUnlocked }" @click="openTrophyModal(trophie)" >
              {{ trophie.title }}
              <span v-if="trophie.icon" class="badge-icon-mask" :class="`icon-${trophie.icon}`"></span>
            </span>
          </div>
        </div>
      </div>
    </section>

    <!-- ARENA-SEKTION -->
    <section class="arena-section">
      <RouterLink
        to="/arenachoice"
        class="arena-container glass-card glass-card-interactive"
      >
        <span class="arena-top-icon badge-icon-mask icon-archery"></span>
        <h2>PRACTICE ARENAS</h2>
        <p>Feeling adventurous and ready to test your knowledge?</p>
        <div class="arena-btn">Choose Arena</div>
      </RouterLink>
    </section>

    <div
      v-if="isBugVisionActive && !isBugCaptured(1)"
      class="hidden-bug home-bug"
       style="--bug-size: 30px;"
      @click="handleBugClick(1)"
      title="Bug Spotted!"
    >
      <span class="badge-icon-mask icon-bug"></span>
      <span v-if="animatingBugs.has(1)" class="xp-popup">+25 XP</span>
    </div>

    <!-- TROPHY MODAL -->
    <div v-if="selectedTrophy" class="trophy-modal-overlay" @click="closeTrophyModal">
      <div class="trophy-modal-card" @click.stop>
        <button class="modal-close-btn" @click="closeTrophyModal">
          &times;
        </button>
        <div class="modal-header">
          <span> {{ selectedTrophy.title }} </span>
        </div>
        <div class="modal-body">
          <p class="modal-desc">{{ selectedTrophy.description }}</p>

          <span class="modal-status-badge" :class="selectedTrophy.isUnlocked ? 'unlocked-status' : 'locked-status'">
            <template v-if="!selectedTrophy.isUnlocked">
              <span class="badge-icon-mask icon-lock"></span> 
            </template>
            <template v-else>
               <span>Unlocked</span>
              <span class="badge-icon-mask icon-check2"></span>
             
            </template>
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>

.home-container {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  max-width: 1000px;
  margin: 0 auto;
}

/* To reduce spacing below logo-/subtitle text */
.java-quest {
  margin-bottom: 2rem;
}

.stats-section {
  width: 100%;
  max-width: 1000px;
  text-align: center;
  margin: 0 auto;
}

.stats-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  align-items: stretch;
  gap: 1.35rem;
  margin-top: 1rem;
}

.stats-card {
  padding: 2rem 1.25rem;
  min-height: 280px;
  font-family: var(--font-mono);
}

.card-title {
  font-weight: 600;
  color: var(--text-muted);
  font-size: 0.85rem;
  text-transform: uppercase;
  letter-spacing: 1px;
  margin-bottom: 1rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid var(--border-subtle);
  text-align: center;
}

.badges-wrapper {
  display: flex;
  flex-wrap: wrap;
  gap: 0.6rem;
  justify-content: center;
  align-content: flex-start;
  padding-top: 0.75rem;
  width: 100%;
  flex: 1;
}

.badge .badge-icon-mask {
  width: 14px;
  height: 14px;
  margin-left: 0.2rem;
}

.xp-simple-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  padding: 0.5rem 0;
  width: 100%;
  flex: 1;
}

.stats-row {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  gap: 0.6rem;
  width: 85%;
  margin: 0 auto;
}

.xp-display {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  border: 1px solid var(--border-subtle);
  border-radius: 14px;
  padding: 1.1rem 0.5rem;
  transition: all 0.4s ease-in-out;
}

.xp-number {
  font-size: 1.6rem;
  font-weight: 700;
  color: rgba(255, 255, 255, 0.35);
  line-height: 1;
  transition: all 0.4s ease-in-out;
}

.xp-unit {
  font-size: 0.58rem;
  color: rgba(255, 255, 255, 0.35);
  letter-spacing: 1px;
  margin-top: 0.35rem;
  transition: all 0.4s ease-in-out;
}

.xp-display.active {
  background: var(--glow-purple);
  border-color: var(--accent-purple);
  box-shadow: 0 0 10px var(--glow-purple);
}

.xp-display.active .xp-number {
  color: #f3e8ff;
  text-shadow: 0 0 10px var(--accent-purple);
}

.xp-display.active .xp-unit {
  color: rgba(255, 255, 255, 0.7);
}

.bug-tracker-wrapper {
  margin-top: 1.25rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.4rem;
}

.bug-tracker-title {
  font-size: 0.65rem;
  color: var(--text-muted);
  letter-spacing: 1px;
  text-transform: uppercase;
}

.bug-icons-row {
  display: flex;
  gap: 0.2rem;
  border-radius: 14px;
  background: transparent;
  border: 1px solid var(--border-subtle);
  color: rgba(255, 255, 255, 0.25);
  transition: all 0.3s ease;
}

.bug-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  transition: all 0.3s ease;
}

.bug-badge.found {
  background: transparent;
  color: var(--accent-purple);
}

.bug-badge .badge-icon-mask {
  width: 16px;
  height: 16px;
}

.arena-section {
  width: 100%;
  max-width: 655px;
  margin: 1.35rem auto 0 auto;
}

.arena-container {
  padding: 1.5rem 1.25rem 1.6rem 1.25rem;
  text-align: center;
}

.arena-top-icon {
  width: 32px;
  height: 32px;
  color: var(--accent-purple);
  opacity: 0.75;
  margin-bottom: 0.35rem;
  transition: all 0.3s ease;
}

.arena-container:hover .arena-top-icon {
  opacity: 1;
  filter: drop-shadow(0 0 8px var(--glow-purple));
}

.arena-container h2 {
  font-size: 1.35rem;
  font-weight: 700;
  color: rgba(255, 255, 255, 0.7);
  letter-spacing: 1.5px;
  margin-bottom: 0.35rem;
  transition: color 0.3s ease;
}

.arena-container:hover h2 {
  color: var(--accent-color);
}

.arena-container p {
  color: var(--text-muted);
  font-size: 0.88rem;
  line-height: 1.4;
  margin-bottom: 1rem;
  transition: color 0.3s ease;
}

.arena-container:hover p {
  color: rgba(255, 255, 255, 0.9);
}

/* -- HIDDEN BUG -- */
.home-bug {
  bottom: 4rem;
  left: 1rem;
}

.hidden-bug .badge-icon-mask {
  width: 30px;
  height: 30px;
}


.app-header {
  width: 100%;
  display: flex;
  justify-content: center;
  position: relative;
  z-index: 100;
}

.trophy-modal-overlay {
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

.trophy-modal-card {
  position: relative;
  width: 90%;
  max-width: 360px;
  padding: 28px 20px 20px 20px;
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
  padding-bottom: 0.75rem;
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

.modal-status-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.45rem 1rem;
  border-radius: 12px;
  font-size: 0.8rem;
  font-weight: 500;
  font-family: var(--font-mono);
  margin-top: 0.5rem;
}

.modal-status-badge .badge-icon-mask {
  width: 14px;
  height: 14px;
  display: inline-block;
  vertical-align: middle;
  position: relative;
  top: -1.5px;
}

.unlocked-status {
  background: rgba(46, 204, 113, 0.2);
  color: #2ecc71;
   border: 1px solid #2ecc71;
}

.locked-status {
  background: rgba(255, 255, 255, 0.04);
  color: var(--text-muted);
  border: 1px solid var(--border-subtle);
}

@keyframes modalScaleIn {
  from {
    transform: scale(0.9);
    opacity: 0;
  }
  to {
    transform: scale(1);
    opacity: 1;
  }
}

/* TABLET (Skärmar upp till 1024px) */
@media (max-width: 1024px) {
  .stats-section {
    max-width: 90%;
  }

  .stats-container {
    gap: 0.85rem;
  }

  .stats-card {
    padding: 1.25rem 0.75rem;
  }

  .stats-row {
    width: 100%;
    gap: 0.4rem;
  }
}

/* MOBILE (Skärmar upp till 640px) */
@media (max-width: 640px) {
  .stats-section {
    max-width: 100%;
    padding: 0 1rem;
  }

  .stats-container {
    grid-template-columns: 1fr;
    gap: 1.25rem;
  }

  .stats-card {
    min-height: auto;
    padding: 1.5rem 1rem;
  }

  .arena-section {
    max-width: 100%;
    padding: 0 1rem;
  }
}
</style>
