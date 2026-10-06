<script setup>
import { computed } from "vue";
import { useRoute, RouterView } from "vue-router";
import Navbar from "./components/Navbar.vue";

const route = useRoute();

const showNavbar = computed(() => {
  return ["home", "lesson"].includes(route.name);
});
</script>

<template>
  <div class="app-container">
    <!-- Global Header/Navbar som alltid syns -->
     <header>
      <Navbar v-if="showNavbar" />
     </header>

    <!-- Här laddas den aktiva vyn (HomeView eller LessonView) in via RouterView-->
    <main class="main-content">
      <RouterView />
    </main>

    <!-- Footer som alltid ska synas -->
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
}

.main-content {
  flex: 1;
}
</style>
