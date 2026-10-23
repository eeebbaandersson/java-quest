<script setup>
import { computed } from "vue";
import { RouterLink } from "vue-router";
import xpService from "@/services/xpService";
import { useBugHunting } from "@/composables/useBugHunting";
import progressService from "@/services/progressService";

const { totalXP, captureBug, isBugVisionActive, isBugCaptured } = useBugHunting();

const handleBugClick = (bugId) => {
  captureBug(bugId);
};

const levels = xpService.LEVELS;

const handleReset = () => {
  const confirmed = window.confirm(
    "Are you sure? All XP, captured bugs, trophies and completed lessons will be reset."
  );
  if (!confirmed) return;

  if (progressService.resetProgress()) {
    window.location.reload();
  } else {
    window.alert("Could not reset progress. Please try again.");
  }
};

const currentLevelObj = computed(() => xpService.getLevel(totalXP.value));

const progressPercentage = computed(() => {
  const maxXP = levels[levels.length - 1].minXP; // 600
  if (totalXP.value < maxXP) {
    return Math.min((totalXP.value / maxXP) * 100, 94);
  }
  return 100;
});
</script>

<template>
  <section class="info-section">
    <div class="info-container">
      <!-- Player Stats -->
      <div class="info-card glass-card">
        <p class="card-title">PLAYER INFO</p>
        <div class="card-body">
          <div class="stats-row">
            <div class="xp-display">
              <span class="xp-number glow-text">{{ totalXP }}</span>
              <span class="xp-unit">TOTAL XP</span>
            </div>
            <div class="xp-display">
              <span class="xp-number">{{ currentLevelObj.level }}</span>
              <span class="xp-unit">CURRENT LEVEL</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Level Progression -->
      <div class="info-card glass-card">
        <p class="card-title">LEVEL PROGRESSION</p>
        <div class="card-body">
          <div class="progression-wrapper">
            <div class="progress-track-container">
              <div class="progress-bar-bg">
                <div
                  class="progress-bar-fill"
                  :style="{ width: progressPercentage + '%' }"
                ></div>
              </div>

              <div class="milestones">
                <div
                  v-for="l in levels"
                  :key="l.level"
                  class="milestone-node"
                  :class="{
                    active: totalXP > l.minXP || currentLevelObj.level > l.level,
                    current: currentLevelObj.level === l.level,
                  }"
                >
                  <div class="milestone-icon-wrapper">
                    <span
                      class="badge-icon-mask icon-mushroom milestone-mushroom"
                    ></span>
                  </div>
                  <div class="track-dot"></div>
                  <span class="milestone-label">Lvl {{ l.level }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="back-navigation">
      <RouterLink to="/" class="back-btn">
        <span class="arrow">←</span> Back to Dashboard
      </RouterLink>
      <button type="button" class="reset-btn" @click="handleReset">
        Reset progress
      </button>
    </div>

     <div
        v-if="isBugVisionActive && !isBugCaptured(5)"
        class="interactive-bug hidden-bug"
        @click="handleBugClick(5)"
        title="Bug Spotted!"
      >
        <span class="badge-icon-mask icon-bug"></span>
      </div>
  </section>
</template>

<style scoped>
.info-section {
  position: relative;  
  width: 100%;
  max-width: 1000px;
  text-align: center;
  margin: 0 auto;
  padding: 2rem 1rem;
  min-height: calc(100vh - 120px); 
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.info-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  align-items: stretch;
  gap: 1.25rem;
  margin-top: 1rem; 
}

.info-card {
  padding: 1.75rem 1.25rem;
  min-height: 280px;
  font-family: var(--font-mono);
  background: var(--bg-card, rgba(255, 255, 255, 0.03));
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid var(--border-subtle);
  border-radius: 16px;
  display: flex;
  flex-direction: column;
}

.card-title {
  font-weight: 600;
  color: var(--text-muted);
  font-size: 0.85rem;
  text-transform: uppercase;
  letter-spacing: 1px;
  margin-bottom: 1.25rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid var(--border-subtle);
  text-align: center;
}

.card-body {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
}

.stats-row {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  align-items: center;
  gap: 0.75rem;
  width: 100%;
}

.xp-display {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border: 1px solid var(--border-subtle);
  border-radius: 14px;
  padding: 1.4rem 0.5rem;
  background: rgba(255, 255, 255, 0.01);
  transition: all 0.4s ease-in-out;
}

.xp-number {
  font-size: 1.8rem;
  font-weight: 700;
  color: #f3e8ff;
  line-height: 1;
}

.glow-text {
  text-shadow: 0 0 10px rgba(192, 132, 252, 0.5);
}

.xp-unit {
  font-size: 0.6rem;
  color: rgba(255, 255, 255, 0.7);
  letter-spacing: 1px;
  margin-top: 0.4rem;
  white-space: nowrap;
}

/* Progression & Milestones */
.progression-wrapper {
  width: 100%;
}

.progress-track-container {
  position: relative;
  width: 100%;
  max-width: 320px;
  margin: 0 auto;
  padding: 0 1rem;
}

.progress-bar-bg {
  position: absolute;
  top: 42px;
  left: 18%;
  right: 18%;
  height: 4px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 2px;
  z-index: 1;
}

.progress-bar-fill {
  height: 100%;
  background: var(--accent-color);
  border-radius: 2px;
  transition: width 0.6s cubic-bezier(0.16, 1, 0.3, 1);
  z-index: 2;
}

.milestones {
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  z-index: 3;
  width: 100%;
}

.milestone-node {
  display: flex;
  flex-direction: column;
  align-items: center;
  opacity: 0.4;
  transition: all 0.3s ease;
  flex: 1;
  text-align: center;
}

.milestone-icon-wrapper {
  height: 32px; 
  display: flex;
  align-items: flex-end;
  justify-content: center;
  margin-bottom: 10px;
  transition: all 0.3s ease;
}

.badge-icon-mask {
  display: inline-block;
  background-color: currentColor;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;
  -webkit-mask-position: center;
  mask-position: center;
  -webkit-mask-size: contain;
  mask-size: contain;
  width: 24px;
  height: 24px;
  transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.icon-mushroom {
  -webkit-mask-image: url("@/assets/icons/mushroom.svg");
  mask-image: url("@/assets/icons/mushroom.svg");
}

.milestone-mushroom {
  color: var(--text-muted);
  transition: all 0.3s ease;
}

.milestone-node.active,
.milestone-node.current {
  opacity: 1;
}

.milestone-node.current .badge-icon-mask {
  transform: scale(1.35);
  transform-origin: bottom center;
  filter: drop-shadow(0 0 6px var(--accent-color)) drop-shadow(0 0 12px var(--accent-color));
}

.milestone-node.current .milestone-mushroom {
   color: #ffffff;
}

.milestone-node.current .milestone-label {
  color: #ffffff;
  font-weight: 600;
}

.track-dot {
  position: absolute;
  top: 40px;
  width: 8px;
  height: 8px;
  background-color: var(--border-subtle);
  border-radius: 50%;
  z-index: 4;
  transition: all 0.3s ease;
}

.milestone-node.active .track-dot,
.milestone-node.current .track-dot {
  background-color: var(--accent-color);
  transform: scale(1.2);
}

.milestone-label {
  font-size: 0.72rem;
  color: var(--text-muted);
  letter-spacing: 0.5px;
  white-space: nowrap;
  margin-top: 10px;
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

/* -- HIDDEN BUG -- */
.hidden-bug {
  position: absolute;
  top: 24rem;
  left: 10%;

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

/* TABLET (Skärmar upp till 1024px) */
@media (max-width: 1024px) {
  .info-section {
    max-width: 800px;
    padding: 1.5rem 1rem;
  }
}

/* MOBILE (Skärmar upp till 640px) */
@media (max-width: 640px) {
  .info-section {
    min-height: auto;
    padding: 1rem 1rem;
    justify-content: flex-start;
  }

  .info-container {
    grid-template-columns: 1fr; 
    gap: 1rem;
    margin-top: 1rem;
  }

  .info-card {
    min-height: auto;
    padding: 1.25rem 1rem;
  }

  .stats-row {
    gap: 0.5rem;
  }

  .xp-display {
    padding: 1rem 0.5rem;
  }

  .xp-number {
    font-size: 1.5rem;
  }

  .back-navigation {
    margin-top: 1.5rem;
  }
}
</style>