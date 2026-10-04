<script setup>
// Här placeras all JavaScript-logik (reaktiva variabler, funktioner, API-anrop, props, emits och imports)
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
    id: 5,
    title: "Java Master",
    description: "Completed all quests",
    isUnlocked: false,
    icon: "kungfu",
  },
  // Arena/Trophie badges:
  {
    id: 6,
    title: "Novice",
    description: "Conquered the Easy Arena",
    isUnlocked: false,
    icon: "tent", 
  },
  {
    id: 7,
    title: "Challenger",
    description: "Conquered the Medium Arena",
    isUnlocked: false,
    icon: "tower", 
  },
  {
    id: 8,
    title: "Hero",
    description: "Conquered the Hard Arena",
    isUnlocked: false,
    icon: "coliseum", 
  },

]);
</script>

<template>
  <div class="home-container">
    <!-- 1. HERO-SEKTION -->
    <section class="hero-section">
      <h1 class="logo-title"><span class="highlight">JAVA{}</span>QUEST</h1>
      <p>Level up your Java skills, one quest at a time.</p>
    </section>

    <!-- 1. STATS-SEKTION -->
    <section class="stats-section">
      <div class="stats-container">
        <div class="stats-card">
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

       <div class="stats-card">
  <p class="card-title">STATS</p>
  <div class="xp-simple-wrapper">

    <div class="xp-main-display" :class="{ active: totalXP > 0 }">
      <span class="xp-number">{{ totalXP }}</span>
      <span class="xp-unit">TOTAL XP</span>
    </div>

  
    <div class="bug-tracker-wrapper">
      <p class="bug-tracker-title"> CAPTURED BUGS</p>
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
        <div class="stats-card">
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

    <section class="arena-section">
      <RouterLink to="/arenachoice" class="arena-container">
        <span class="arena-top-icon icon-archery"></span>
        <h2>PRACTICE ARENAS</h2>
        <p>Feeling adventurous and ready to test your knowledge?</p>
        <div class="arena-btn">Choose Arena</div>
      </RouterLink>
    </section>
  </div>
</template>

<style scoped>
.hero-section {
  text-align: center;
  margin-top: 3rem;
  margin-bottom: 3rem;
}

.logo-title {
  font-size: 3.6rem;
  font-weight: 900;
  letter-spacing: 1px;
  line-height: 1.1;
  color: #ffffff;
  margin-bottom: 0.25rem;
}

.logo-title .highlight {
  color: #c084fc;
}

.hero-section p,
.arena-section p {
  color: var(--text-muted);
  font-size: 1rem;
}

.stats-section {
  width: 100%;
  max-width: 1000px;
  text-align: center;
  margin: 0 auto;
}

.stats-section h2 {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--text-secondary);
  letter-spacing: 1.5px;
  margin-bottom: 1.25rem;
}

.stats-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  align-items: stretch;
  gap: 1.25rem;
   margin-top: 1rem;
}

.stats-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid var(--border-subtle);
  border-radius: 18px;
  padding: 1.75rem 1.25rem;
  min-height: 280px;
  font-family: "JetBrains Mono", monospace;
  transition: border-color 0.3s ease, transform 0.3s ease;
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

.xp-simple-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  padding: 0.75rem;
  width: 100%;
  flex: 1;
}

.xp-main-display {
  display: flex;
  flex-direction: column;
  align-items: center;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid var(--border-subtle);
  border-radius: 16px;
  padding: 0.8rem 1.8rem;
  transition: all 0.4s ease-in-out;
}

.xp-number {
  font-size: 2.2rem;
  font-weight: 700;
  color: rgba(255, 255, 255, 0.35);
  line-height: 1;
  transition: all 0.4s ease-in-out;
}

.xp-unit {
  font-size: 0.7rem;
  color: rgba(255, 255, 255, 0.35);
  letter-spacing: 1.5px;
  margin-top: 0.3rem;
  transition: all 0.4s ease-in-out;
}

.xp-main-display.active {
  background: rgba(168, 85, 247, 0.08);
  border-color: var(--accent-purple);
  box-shadow: 0 0 15px rgba(168, 85, 247, 0.25);
}

.xp-main-display.active .xp-number {
  color: #f3e8ff;
  text-shadow: 0 0 10px var(--accent-purple);
}

.xp-main-display.active .xp-unit {
  color: rgba(255, 255, 255, 0.7);
}

.sub-label {
  color: rgba(255, 255, 255, 0.4);
}

.sub-value {
  color: #c084fc;
  font-weight: 600;
}

.bug-tracker-wrapper {
  margin-top: 1.2rem;
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
  color:var(--accent-purple);
}

.bug-badge .badge-icon-mask {
  width: 16px;
  height: 16px;
}

.badge-icon-mask {
  width: 14px;
  height: 14px;
  display: inline-block;
  background-color: currentColor;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;
  -webkit-mask-position: center;
  mask-position: center;
  -webkit-mask-size: contain;
  mask-size: contain;
}

.arena-section {
  width: 100%;
 max-width: 655px;
  margin: 1.25rem auto 0 auto;
}

.arena-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  text-decoration: none;
  background-color: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid var(--border-subtle);
  border-radius: 18px;
  padding: 1.5rem 1.25rem 1.6rem 1.25rem;
  transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1);
  cursor: pointer;
}

.arena-container:hover {
  background: rgba(168, 85, 247, 0.04);
  border-color: var(--accent-purple);
  box-shadow: 0 0 20px rgba(168, 85, 247, 0.2);
}

.arena-top-icon {
  width: 32px;
  height: 32px;
  display: inline-block;
  background-color: var(--accent-purple);
  opacity: 0.75;
  margin-bottom: 0.35rem;
  transition: all 0.3s ease;
  
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;
  -webkit-mask-position: center;
  mask-position: center;
  -webkit-mask-size: contain;
  mask-size: contain;
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

.arena-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  font-family: "JetBrains Mono", monospace;
  font-size: 0.8rem;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.8);
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.1);
  padding: 0.5rem 1.1rem;
  border-radius: 10px;
  letter-spacing: 0.5px;
  transition: all 0.3s ease;
}

.arena-container:hover .arena-tag {
  opacity: 1;
}

.arena-container:hover h2 {
  color: #c084fc;
  opacity: 1;
}

.arena-container:hover .arena-btn {
  background: var(--accent-purple);
  color: #ffffff;
  border-color: var(--accent-purple);
  box-shadow: 0 0 12px rgba(168, 85, 247, 0.4);
}

.icon-compass {
  -webkit-mask-image: url("@/assets/icons/compass.svg");
  mask-image: url("@/assets/icons/compass.svg");
}

.icon-bug {
  -webkit-mask-image: url("@/assets/icons/bug.svg");
  mask-image: url("@/assets/icons/bug.svg");
}

.icon-ninja {
  -webkit-mask-image: url("@/assets/icons/ninja.svg");
  mask-image: url("@/assets/icons/ninja.svg");
}

.icon-star {
  -webkit-mask-image: url("@/assets/icons/star.svg");
  mask-image: url("@/assets/icons/star.svg");
}

.icon-kungfu {
  -webkit-mask-image: url("@/assets/icons/kungfu.svg");
  mask-image: url("@/assets/icons/kungfu.svg");
}

.icon-archery {
  -webkit-mask-image: url("@/assets/icons/archery.svg");
  mask-image: url("@/assets/icons/archery.svg");
}

.icon-tent {
  -webkit-mask-image: url("@/assets/icons/tent.svg");
  mask-image: url("@/assets/icons/tent.svg");
}

.icon-tower {
  -webkit-mask-image: url("@/assets/icons/tower.svg");
  mask-image: url("@/assets/icons/tower.svg");
}

.icon-coliseum {
  -webkit-mask-image: url("@/assets/icons/coliseum.svg");
  mask-image: url("@/assets/icons/coliseum.svg");
}
</style>
