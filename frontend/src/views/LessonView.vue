<script setup>
import { computed } from "vue";
import { useRoute, useRouter } from "vue-router";

const route = useRoute();
const router = useRouter();

// Hämtar :id från URL (t.ex. 'variables' eller '1')
const lessonId = computed(() => route.params.id);

const lessonsData = {
  variables: {
    number: "01",
    title: "Variables & Data Types",
    subtitle:
      "Learn how to store and manage data in Java.",
    progress: "0 / 3",
  },
  operators: {
    number: "02",
    title: "Operators & Expressions",
    subtitle: "Perform arithmetic and logical operations.",
    progress: "0 / 3",
  },
  ifelse: {
    number: "03",
    title: "Control Flow - If / Else",
    subtitle:
      "Control the program flow based on states.",
    progress: "0 / 3",
  },
  loops: {
    number: "04",
    title: "Loops - For & While",
    subtitle: "Repeat code execution efficiently.",
    progress: "0 / 3",
  },
  arrays: {
    number: "05",
    title: "Arrays",
    subtitle: "Manage ordered lists of elements.",
    progress: "0 / 3",
  },
  methods: {
    number: "06",
    title: "Methods",
    subtitle:
      "Structure your application with functions and scope.",
    progress: "0 / 3",
  },
  classes: {
    number: "07",
    title: "Classes & Objects",
    subtitle: "Build object-oriented structures in Java.",
    progress: "0 / 3",
  },
};

const currentLesson = computed(() => {
  return lessonsData[lessonId.value];
});

const goBack = () => {
  router.push("/");
};
</script>

<template>
  <div class="lesson-container">
    <!-- 2. HERO SEKTION -->
    <section class="lesson-hero">
      <h1 class="lesson-title">{{ currentLesson.title }}</h1>
      <p class="lesson-subtitle">{{currentLesson.subtitle}}</p>
    </section>

    <main class="lesson-section">
      <!-- Space to later add lesson components -->
    </main>
  </div>
</template>

<style scoped>
.lesson-hero {
  text-align: center;
  margin-top: 2rem;
  margin-bottom: 3.5rem;
}

.lesson-title {
  font-size: 2.5rem;
  font-weight: 900;
  letter-spacing: 1px;
  line-height: 1.1;
  color: #ffffff;
  margin-bottom: 0.25rem;
}

.lesson-subtitle {
  color: var(--text-muted);
  font-size: 1rem;
}
</style>
