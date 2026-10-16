<script setup>
import { computed } from "vue";
import { useRoute, RouterView, RouterLink } from "vue-router";
import Navbar from "./components/Navbar.vue";
import BugvisionToggle from "./components/BugvisionToggle.vue";

const route = useRoute();

const showNavbar = computed(() => {
  return ["home", "lesson", "arenachoice", "profile"].includes(route.name);
});

const showProfileLink = computed(() => {
  return ["home", "lesson", "arenachoice", "profile"].includes(route.name);
});
</script>

<template>
  <div class="app-container">
    
    <div v-if="showProfileLink" class="header-actions">
      <BugvisionToggle />
      <RouterLink to="/profile" class="global-icon-btn glass-card" title="Profile">
        <span class="badge-icon-mask icon-user"></span>
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

.header-actions {
position: absolute;
  top: 0.8rem;
  right: 1.5rem;
  z-index: 1000;
  display: flex;
  align-items: center; 
  gap: 0.85rem;
}


.global-icon-btn {
display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;  
  height: 34px; 
  color: rgba(255, 255, 255, 0.6); 
  text-decoration: none;
  border-radius: 10px; 
  border: 1px solid var(--border-subtle);
  background: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
  box-sizing: border-box;
}

.global-icon-btn:hover{
  color: #ffffff;
  background: rgba(255, 255, 255, 0.08); 
  border-color: rgba(255, 255, 255, 0.25);
}


.global-icon-btn .badge-icon-mask {
 width: 16px;
  height: 16px;
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
  .header-actions {
    display: none; 
  }
}
</style>