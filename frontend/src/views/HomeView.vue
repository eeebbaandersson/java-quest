<script setup>
import { ref } from "vue";
import { RouterLink } from "vue-router";

const lessons = ref([
  { id: 1, title: "Variables", isCompleted: true },
  { id: 2, title: "Operators", isCompleted: true },
  { id: 3, title: "If / Else", isCompleted: false },
  { id: 4, title: "Loops", isCompleted: false },
  { id: 5, title: "Arrays", isCompleted: false },
  { id: 6, title: "Methods", isCompleted: false },
  { id: 7, title: "Classes", isCompleted: false },
]);

const totalXP = ref(150);
const userLevel = 1;
const totalBugs = 5;
const foundBugs = ref(1);

const trophies = ref([
  {
    id: 1,
    title: "Explorer",
    description: "Completed your first quest!",
    isUnlocked: true,
    icon: "compass",
  },
  {
    id: 2,
    title: "Bug Hunter",
    description: "Captured all bugs hidden in the interface",
    isUnlocked: false,
    icon: "bug",
  },
  {
    id: 3,
    title: "Syntax Ninja",
    description: "Completed 3 quests",
    isUnlocked: false,
    icon: "ninja",
  },
  {
    id: 4,
    title: "Novice",
    description: "Conquered the Easy Arena",
    isUnlocked: false,
    icon: "tent",
  },
  {
    id: 5,
    title: "Java Master",
    description: "Completed all quests",
    isUnlocked: false,
    icon: "kungfu",
  },
  {
    id: 6,
    title: "Challenger",
    description: "Conquered the Medium Arena",
    isUnlocked: false,
    icon: "tower",
  },
  {
    id: 7,
    title: "Hero",
    description: "Conquered the Hard Arena",
    isUnlocked: false,
    icon: "coliseum",
  },
]);
</script>

<template>
  <div class="home-container">
    <!-- HERO-SEKTION -->
    <section class="hero-section">
      <h1 class="logo-title"><span class="highlight">JAVA{}</span>QUEST</h1>
      <p class="hero-subtitle">Level up your Java skills, one quest at a time.</p>
    </section>

    <!-- STATS-SEKTION -->
    <section class="stats-section">
      <div class="stats-container">
        <div class="stats-card glass-card">
          <p class="card-title">QUEST MAP</p>
          <div class="badges-wrapper">
            <RouterLink
              v-for="lesson in lessons"
              :key="lesson.id"
              :to="`/lessons/${lesson.title.toLowerCase().replace(/[^a-z0-9]/g, '')}`"
              class="badge"
              :class="{ completed: lesson.isCompleted }"
            >
              {{ lesson.title }}
            </RouterLink>
          </div>
        </div>

        <div class="stats-card glass-card">
          <p class="card-title">PLAYER STATS</p>
          <div class="xp-simple-wrapper">
            <div class="stats-row">
              <div class="xp-display" :class="{ active: totalXP > 0 }">
                <span class="xp-number">{{ totalXP }}</span>
                <span class="xp-unit">TOTAL XP</span>
              </div>

              <div class="xp-display">
                <span class="xp-number">{{ userLevel }}</span>
                <span class="xp-unit">LEVEL</span>
              </div>
            </div>
            <div class="bug-tracker-wrapper">
              <p class="bug-tracker-title">CAPTURED BUGS</p>
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
            <span
              v-for="trophie in trophies"
              :key="trophie.id"
              class="badge"
              :class="{ unlocked: trophie.isUnlocked }"
              :title="trophie.description"
            >
              {{ trophie.title }}
              <span
                v-if="trophie.icon"
                class="badge-icon-mask"
                :class="`icon-${trophie.icon}`"
              ></span>
            </span>
          </div>
        </div>
      </div>
    </section>

    <!-- ARENA-SEKTION -->
    <section class="arena-section">
      <RouterLink to="/arenachoice" class="arena-container glass-card glass-card-interactive">
        <span class="arena-top-icon badge-icon-mask icon-archery"></span>
        <h2>PRACTICE ARENAS</h2>
        <p>Feeling adventurous and ready to test your knowledge?</p>
        <div class="arena-btn">Choose Arena</div>
      </RouterLink>
    </section>
  </div>
</template>

<style scoped>
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
  gap: 1.25rem;
  margin-top: 1rem;
}

.stats-card {
  padding: 1.75rem 1.25rem;
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
  background: rgba(168, 85, 247, 0.08);
  border-color: var(--accent-purple);
  box-shadow: 0 0 15px rgba(168, 85, 247, 0.25);
}

.xp-display.active .xp-number {
  color: #f3e8ff;
  text-shadow: 0 0 10px var(--accent-purple);
}

.xp-display.active .xp-unit {
  color: rgba(255, 255, 255, 0.7);
}

.bug-tracker-wrapper {
  margin-top: 1rem;
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
  margin: 1.25rem auto 0 auto;
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
  filter: drop-shadow(0 0 8px rgba(168, 85, 247, 0.6));
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
  color: #c084fc;
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