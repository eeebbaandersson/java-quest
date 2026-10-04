<script setup>
import { RouterLink } from "vue-router";
</script>

<template>
  <header class="navbar">
   
    <nav class="nav-links">
      <RouterLink to="/" class="nav-item">{}</RouterLink>
      <RouterLink to="/lessons/variables" class="nav-item">Variables</RouterLink>
      <RouterLink to="/lessons/operators" class="nav-item">Operators</RouterLink>
      <RouterLink to="/lessons/ifelse" class="nav-item">If / Else</RouterLink>
      <RouterLink to="/lessons/loops" class="nav-item">Loops</RouterLink>
      <RouterLink to="/lessons/arrays" class="nav-item">Arrays</RouterLink>
      <RouterLink to="/lessons/methods" class="nav-item">Methods</RouterLink>
      <RouterLink to="/lessons/classes" class="nav-item">Classes</RouterLink>
    </nav>
  </header>
</template>

<style scoped>

.navbar {
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid var(--border-subtle);
  position: sticky;
  z-index: 100;
  font-family: var(--font-mono);
  padding: 0.5rem 1rem;
  margin: 0.5rem auto;
  width: 100%;
  max-width: 800px;
  border-radius: 14px;
}

.nav-links {
  display: flex;
  gap: 0.5rem;
 
}

.nav-item {
  text-decoration: none;
  color: rgba(255, 255, 255, 0.5);
  font-size: 0.85rem;
  padding: 0.4rem 0.8rem;
  border-radius: 8px;
  transition: all 0.2s ease;
}

.nav-item:hover {
  color: #ffffff;
  background: rgba(255, 255, 255, 0.05);
 
}

</style>