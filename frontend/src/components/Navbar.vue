<script setup>
import { ref } from "vue";
import { RouterLink } from "vue-router";

const isMenuOpen = ref(false);

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value;
};

const closeMenu = () => {
  isMenuOpen.value = false;
};
</script>

<template>
  <header class="navbar-wrapper">
    <nav class="nav-container">
     
      <button 
        id="menu-toggle-btn" 
        class="menu-toggle-btn glass-card" 
        @click="toggleMenu"
      >
        <span></span>
        <span></span>
        <span></span>
      </button>

     
      <div class="nav-links" :class="{ active: isMenuOpen }">
        <RouterLink to="/" class="nav-item home-item" @click="closeMenu">{}</RouterLink>
        <RouterLink to="/lessons/variables" class="nav-item" @click="closeMenu">Variables</RouterLink>
        <RouterLink to="/lessons/operators" class="nav-item" @click="closeMenu">Operators</RouterLink>
        <RouterLink to="/lessons/ifelse" class="nav-item" @click="closeMenu">If / Else</RouterLink>
        <RouterLink to="/lessons/loops" class="nav-item" @click="closeMenu">Loops</RouterLink>
        <RouterLink to="/lessons/arrays" class="nav-item" @click="closeMenu">Arrays</RouterLink>
        <RouterLink to="/lessons/methods" class="nav-item" @click="closeMenu">Methods</RouterLink>
        <RouterLink to="/lessons/classes" class="nav-item" @click="closeMenu">Classes</RouterLink>
        
        <RouterLink to="/profile" class="nav-item profile-mobile-item" @click="closeMenu">
          <span class="badge-icon-mask icon-user"></span> Profile
        </RouterLink>
      </div>
    </nav>
  </header>
</template>

<style scoped> 
/* --- DESKTOP-FIRST STANDARD (Stora skärmar från 1200px och uppåt) --- */
.navbar-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid var(--border-subtle);
  position: sticky;
  top: 0.5rem;
  z-index: 100;
  font-family: var(--font-mono);
  padding: 0.5rem 1rem;
  margin: 0.5rem auto;
  width: 100%;
  max-width: 1000px;
  border-radius: 14px;
}

.nav-container {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  position: relative;
}


.menu-toggle-btn {
  display: none;
}

.nav-links {
  display: flex;
  position: static;
  flex-direction: row;
  justify-content: center;
  border: none;
  width: 100%;
  padding: 0;
  gap: 0.5rem;
  background-color: transparent;
  backdrop-filter: none;
  -webkit-backdrop-filter: none;
  box-shadow: none;
}

.nav-item {
  text-decoration: none;
  color: rgba(255, 255, 255, 0.5);
  font-size: 0.85rem;
  padding: 0.4rem 0.8rem;
  border-radius: 8px;
  transition: all 0.2s ease;
  width: auto;
}

.nav-item:hover {
  color: #ffffff;
}

.home-item:hover {
  color: #c084fc;
}

.profile-mobile-item {
  display: none; 
}


/* --- MOBILE & TABLET OVERRIDES (Skärmar upp till 1199px) --- */
@media (max-width: 1199px) {
  .navbar-wrapper {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    background: transparent;
    border: none;
    position: sticky;
    top: 0.8rem;
    padding: 0;
    margin: 0.5rem auto;
    width: 100%;
    max-width: 1000px;
  }

  .nav-container {
    justify-content: flex-end;
    padding-right: 1.5rem;
  }

  .menu-toggle-btn {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    width: 38px;
    height: 38px;
    background: rgba(255, 255, 255, 0.02);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border: 1px solid var(--border-subtle);
    border-radius: 12px;
    cursor: pointer;
    padding: 10px 8px;
    position: relative;
    z-index: 101;
    transition: all 0.2s ease;
  }

  .menu-toggle-btn:hover {
    background: rgba(255, 255, 255, 0.06);
  }

  .menu-toggle-btn span {
    width: 100%;
    height: 2px;
    background-color: rgba(255, 255, 255, 0.7);
    border-radius: 2px;
    transition: all 0.3s ease;
    pointer-events: none;
  }

  .nav-links {
    display: none;
    position: absolute;
    top: calc(100% + 0.5rem);
    right: 1.5rem;
    width: 220px;
    background-color: var(--bg-main, #121315);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    padding: 1.25rem 1rem;
    border: 1px solid var(--border-subtle);
    border-radius: 14px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
  }

  .nav-links.active {
    display: flex;
  }

  .nav-item {
    font-size: 0.9rem;
    width: 100%;
    text-align: center;
  }

  .nav-item:hover {
    background: rgba(255, 255, 255, 0.04);
  }

  .profile-mobile-item {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    color: #c084fc;
    border-top: 1px solid var(--border-subtle);
    margin-top: 0.25rem;
    padding-top: 0.75rem;
    justify-content: center;
  }
}
</style>