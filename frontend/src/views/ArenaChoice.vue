<script setup>
import { ref } from "vue";
import { RouterLink } from "vue-router";
import { useBugHunting } from "@/composables/useBugHunting";

const { captureBug, isBugVisionActive, isBugCaptured } = useBugHunting();

const arenas = ref([
  {
    id: "easy",
    title: "NOVICE",
    levelText: "EASY",
    description: "Warm up with basic logic and fundamentals.",
    icon: "tent",
    xpReward: 10,
    link: "/practice/easy",
  },
  {
    id: "medium",
    title: "CHALLENGER",
    levelText: "MEDIUM",
    description: "Test your problem-solving skills with trickier algorithms.",
    icon: "tower",
    xpReward: 25,
    link: "/practice/medium",
  },
  {
    id: "hard",
    title: "HERO",
    levelText: "HARD",
    description: "For true Java heroes. Complex scenarios and edge cases.",
    icon: "coliseum",
    xpReward: 50,
    link: "/practice/hard",
  },
]);

const handleBugClick = (bugId) => {
  captureBug(bugId);
};
</script>

<template>
  <div class="arena-choice-container">
    <section class="hero-section">
      <h1 class="logo-title">PRACTICE ARENAS</h1>
      <p class="hero-subtitle">
        Select your level and earn XP for every correct answer.
      </p>

      <div
        v-if="isBugVisionActive && !isBugCaptured(2)"
        class="interactive-bug hidden-bug"
        @click="handleBugClick(2)"
        title="Bug Spotted!"
      >
        <span class="badge-icon-mask icon-bug"></span>
      </div>
    </section>

    <section class="choice-section">
      <div class="choice-container">
        <RouterLink
          v-for="arena in arenas"
          :key="arena.id"
          :to="arena.link"
          class="arena-card glass-card glass-card-interactive"
        >
          <span class="xp-corner-badge">+{{ arena.xpReward }}xp</span>
          <span
            class="arena-icon badge-icon-mask"
            :class="`icon-${arena.icon}`"
          ></span>

          <span class="arena-subtitle">{{ arena.levelText }}</span>
          <h2>{{ arena.title }}</h2>
          <p>{{ arena.description }}</p>

          <div class="arena-btn">Enter Arena</div>
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
  padding: 2.5rem 1.25rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
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

.arena-icon {
  width: 46px;
  height: 46px;
  color: var(--accent-purple);
  margin-bottom: 0.75rem;
  opacity: 0.8;
  transition: all 0.3s ease;
}

.arena-card:hover .arena-icon {
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

.arena-card:hover .arena-subtitle {
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

.arena-card:hover h2 {
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

.arena-card:hover p {
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
.hidden-bug {
  position: absolute;
  top: 11rem;
  right: 27rem;
  cursor: pointer;
  color: var(--accent-purple);
  opacity: 0.35;
  transition: all 0.2s ease;
  padding: 0.5rem;
  z-index: 10;
}

.hidden-bug:hover {
  opacity: 1;
  /* transform: scale(1.1); */
  filter: drop-shadow(0 0 8px var(--glow-purple));
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
