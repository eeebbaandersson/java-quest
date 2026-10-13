<script setup>
import { computed } from "vue";
import { useRoute, RouterView, RouterLink } from "vue-router";
import Navbar from "./components/Navbar.vue";

const route = useRoute();

const showNavbar = computed(() => {
  return ["home", "lesson", "arenachoice"].includes(route.name);
});

const showProfileLink = computed(() => {
  return ["home", "lesson", "arenachoice"].includes(route.name);
});

</script>

<template>
  <div class="app-container">
    <div v-if="showProfileLink" class="global-actions">
      <RouterLink to="/profile" class="global-btn glass-card">
        <span class="badge-icon-mask icon-user"></span>
        Profile
      </RouterLink>
    </div>

   
    <header class="app-header">
      <Navbar v-if="showNavbar" />
    </header>

    <!-- Huvudinnehåll -->
    <main class="main-content">
      <RouterView />
    </main>

    <!-- Footer -->
     <footer>
      <p></p>
     </footer>
  </div>
</template>

<style scoped>
.app-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  position: relative; 
}

.global-actions {
  position: absolute;
  top: 0.8rem;
  right: 1.5rem;
  z-index: 1000;
}

.global-btn {
  display: inline-flex;
  align-items: center;
  flex-direction: row; 
  gap: 0.5rem;
  font-family: var(--font-mono);
  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.5); 
  text-decoration: none;
  padding: 0.5rem 1rem;
  border-radius: 12px; 
  border: 1px solid var(--border-subtle);
  background: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  transition: all 0.2s ease;
}

.global-btn:hover,
.global-btn.router-link-active {
  color: #ffffff;
  background: rgba(255, 255, 255, 0.06); 
  border-color: var(--border-subtle);
}

.global-btn.router-link-active {
  color: #c084fc; 
}

.global-btn .badge-icon-mask {
  width: 14px;
  height: 14px;
}


.app-header {
  width: 100%;
  display: flex;
  justify-content: center;
  position: relative;
  z-index: 100;
}

.main-content {
  flex: 1;
}

@media (max-width: 1199px) {
  .global-actions {
    display: none; 
  }
}
</style>