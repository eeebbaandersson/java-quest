<script setup>
import { ref } from "vue";
import { RouterLink } from "vue-router";
import { useBugHunting } from "@/composables/useBugHunting";

const { captureBug, isBugVisionActive, isBugCaptured } = useBugHunting();
const animatingBugs = ref(new Set());
const captureError = ref("");

const handleBugClick = (bugId) => {
  if (animatingBugs.value.has(bugId) || isBugCaptured(bugId)) return;

  captureError.value = "";

  if (!captureBug(bugId)) {
    captureError.value = "Could not save the capture. Please try again.";
    return;
  }

  // Start animation
  animatingBugs.value.add(bugId);
};

const arenas = ref([
  {
    id: "easy",
    title: "NOVICE",
    levelText: "EASY",
    description: "Warm up with basic logic and core fundamentals.",
    icon: "tent",
    xpReward: 10,
    link: "/arena/1",
    isUnlocked: true,
  },
  {
    id: "medium",
    title: "CHALLENGER",
    levelText: "MEDIUM",
    description: "Test your problem-solving skills with trickier algorithms.",
    icon: "tower",
    xpReward: 25,
    link: "/arena/2",
    isUnlocked: false,
  },
  {
    id: "hard",
    title: "HERO",
    levelText: "HARD",
    description: "For true Java heroes. Complex scenarios and edge cases.",
    icon: "coliseum",
    xpReward: 50,
    link: "/arena/3",
    isUnlocked: false,
  },
]);
</script>

<template>
  <div class="arena-choice-container">
    <section class="hero-section">
      <h1 class="logo-title">ARENA CHALLENGES</h1>
      <p class="hero-subtitle">
        Choose difficulty, prove your skills and collect the reward.
      </p>

      <div
        v-if="isBugVisionActive && (!isBugCaptured(2) || animatingBugs.has(2))"
        class="bug-capture-anchor"
      >
        <div
          v-if="!isBugCaptured(2)"
          class="hidden-bug"
          style="--bug-size: 30px"
          @click="handleBugClick(2)"
          title="Bug Spotted!"
        >
          <span class="badge-icon-mask icon-bug"></span>
        </div>

        <span
          v-if="animatingBugs.has(2)"
          class="xp-popup"
          @animationend="animatingBugs.delete(2)"
        >
          +25 XP
        </span>
      </div>
      <p v-if="captureError" role="alert">
        {{ captureError }}
      </p>
    </section>

    <section class="choice-section">
      <div class="choice-container">
        <RouterLink
          v-for="arena in arenas"
          :key="arena.id"
          :to="arena.isUnlocked ? arena.link : '#'"
          class="arena-card glass-card"
          :class="{
            'is-locked': !arena.isUnlocked,
            'glass-card-interactive': arena.isUnlocked,
          }"
        >
          
          <span class="xp-corner-badge">+{{ arena.xpReward }}xp</span>

          <span v-if="!arena.isUnlocked" class="lock-corner-badge">
            <span class="badge-icon-mask icon-lock"></span>
          </span>

          <span
            class="arena-icon badge-icon-mask"
            :class="`icon-${arena.icon}`"
          ></span>

          <span class="arena-subtitle">{{ arena.levelText }}</span>
          <h2>{{ arena.title }}</h2>
          <p>{{ arena.description }}</p>

          <div class="arena-btn">
            {{ arena.isUnlocked ? "Enter Arena" : "Locked" }}
          </div>
        </RouterLink>
      </div>

      <div class="back-navigation">
        <RouterLink to="/" class="back-btn">
          <span class="arrow">←</span> Back to Dashboard
        </RouterLink>
      </div>
    </section>
  </div>
</template>

<style scoped>
.arena-choice-container {
  width: 100%;
  max-width: 1000px;
  margin: 0 auto;
}

.hero-section {
  position: relative;
}

.choice-section {
  width: 100%;
  max-width: 1000px;
  text-align: center;
  margin: 0 auto;
}

.choice-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  align-items: stretch;
  gap: 1.35rem;
  margin-top: 1rem;
}

.arena-card {
  position: relative;
  padding: 2rem 1.25rem;
  min-height: 280px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  text-decoration: none;
}

.xp-corner-badge {
  position: absolute;
  top: 16px;
  left: 16px;
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.5px;
  color: var(--accent-color);
  background: var(--glow-purple);
  border: 1px solid var(--accent-purple);
  border-radius: 12px;
  padding: 4px 10px;
  text-transform: uppercase;
  pointer-events: none;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.arena-card:hover .xp-corner-badge {
  background: var(--glow-purple);
  border-color: var(--accent-color);
  color: var(--accent-color);
}

.lock-corner-badge {
  position: absolute;
  top: 1rem;
  right: 1rem;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 28px;
  padding: 0 0.75rem; 
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid var(--border-subtle);
  color: var(--text-muted);
}

.lock-corner-badge .badge-icon-mask {
  width: 14px;
  height: 14px;
  display: inline-block;
}


.arena-card.is-locked {
  text-decoration: none;
}

.arena-card.is-locked .arena-icon {
  color: var(--text-muted);
  opacity: 0.4;
  filter: none !important;
}

.arena-card.is-locked .arena-subtitle {
  color: var(--text-muted) !important;
  opacity: 0.5;
}

.arena-card.is-locked h2 {
  color: var(--text-muted) !important;
  opacity: 0.7;
}

.arena-card.is-locked p {
  color: var(--text-muted) !important;
  opacity: 0.6;
}

.arena-card.is-locked .arena-btn {
  background: rgba(255, 255, 255, 0.02);
  border-color: var(--border-subtle);
  color: var(--text-muted);
  opacity: 0.6;
  box-shadow: none;
}


.arena-card.is-locked:hover {
  background: rgba(255, 255, 255, 0.02);
  border-color: rgba(255, 255, 255, 0.15);
  box-shadow: none;
}

.arena-card.is-locked:hover h2,
.arena-card.is-locked:hover p,
.arena-card.is-locked:hover .arena-subtitle,
.arena-card.is-locked:hover .arena-icon {
  color: var(--text-muted) !important;
  opacity: 0.7;
  filter: none;
  text-decoration: none;
}

/* --- UPPLÅSTA KORT (Standard-färger) --- */
.arena-icon {
  width: 46px;
  height: 46px;
  color: var(--accent-purple);
  margin-bottom: 0.75rem;
  opacity: 0.8;
  transition: all 0.3s ease;
}

.arena-card:not(.is-locked):hover .arena-icon {
  opacity: 1;
  filter: drop-shadow(0 0 8px var(--glow-purple));
}

.arena-subtitle {
  font-family: var(--font-mono);
  font-size: 0.7rem;
  font-weight: 600;
  color: var(--accent-purple);
  letter-spacing: 1.5px;
  margin-bottom: 0.8rem;
  opacity: 0.8;
  transition: opacity 0.3s ease;
}

.arena-card:not(.is-locked):hover .arena-subtitle {
  opacity: 1;
}

.arena-card h2 {
  font-size: 1.25rem;
  font-weight: 700;
  color: rgba(255, 255, 255, 0.75);
  letter-spacing: 1.2px;
  margin-bottom: 0.25rem;
  transition: color 0.3s ease;
}

.arena-card:not(.is-locked):hover h2 {
  color: var(--accent-color);
  opacity: 1;
}

.arena-card p {
  color: var(--text-muted);
  font-size: 0.85rem;
  line-height: 1.45;
  margin-bottom: 1.5rem;
  flex: 1;
  transition: color 0.3s ease;
}

.arena-card:not(.is-locked):hover p {
  color: rgba(255, 255, 255, 0.9);
}

.back-navigation {
  display: flex;
  justify-content: center;
  margin-top: 2.5rem;
}

.back-btn {
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
}

.back-btn:hover {
  color: #ffffff;
  background: rgba(255, 255, 255, 0.06);
  border-color: rgba(255, 255, 255, 0.15);
}

.back-btn .arrow {
  transition: transform 0.3s ease;
}

.back-btn:hover .arrow {
  transform: translateX(-3px);
}

.icon-coliseum {
  transform: translateY(8px) scale(1.18);
  transform-origin: bottom center;
}

/* -- HIDDEN BUG -- */
.bug-capture-anchor {
  position: absolute;
  top: 70%;
  right: 5%;
  transform: translateY(-50%);
  width: calc(30px + 1rem);
  height: calc(30px + 1rem);
  z-index: 10;
}

.bug-capture-anchor .hidden-bug {
  inset: 0;
}

.hidden-bug .badge-icon-mask {
  width: 30px;
  height: 30px;
}

/* TABLET (Skärmar upp till 1024px)*/
@media (max-width: 1024px) {
  .choice-section {
    max-width: 90%;
  }

  .choice-container {
    gap: 0.85rem;
  }

  .arena-card {
    padding: 2rem 1rem;
  }
}

/* MOBILE (Skärmar upp till 640px) */
@media (max-width: 640px) {
  .choice-section {
    max-width: 100%;
    padding: 0 1rem;
  }

  .choice-container {
    grid-template-columns: 1fr;
    gap: 1.25rem;
  }

  .arena-card {
    padding: 2.25rem 1.25rem 1.5rem 1.25rem;
  }

  .xp-corner-badge {
    top: 12px;
    left: 12px;
    font-size: 0.65rem;
  }
}
</style>
