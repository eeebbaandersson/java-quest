<script setup>
import { ref } from "vue";
import { RouterLink } from "vue-router";

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
</script>

<template>
  <div class="arena-choice-container">
    <section class="hero-section">
      <h1 class="logo-title">PRACTICE ARENAS</h1>
      <p class="hero-subtitle">Select your level and earn XP for every correct answer.</p>
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
  max-width: 1050px;
  margin: 0 auto;
  min-height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 2rem 1rem;
}

.choice-container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.25rem;
  align-items: stretch;
}

.arena-card {
  position: relative;
  padding: 2.5rem 1.25rem;
  text-align: center;
}

.xp-corner-badge {
  position: absolute;
  top: 16px;
  left: 16px;
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.5px;
  color: #c084fc; 
  background: rgba(168, 85, 247, 0.12); 
  border: 1px solid rgba(168, 85, 247, 0.4); 
  border-radius: 12px; 
  padding: 4px 10px;
  text-transform: uppercase;
  pointer-events: none;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.arena-card:hover .xp-corner-badge {
  background: rgba(168, 85, 247, 0.18);
  border-color: rgba(168, 85, 247, 0.5);
  color: #c084fc; 
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
  filter: drop-shadow(0 0 8px rgba(168, 85, 247, 0.6));
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
  color: #c084fc;
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
</style>