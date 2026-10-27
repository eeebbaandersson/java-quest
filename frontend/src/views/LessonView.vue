<script setup>
import { ref, computed, onMounted, watch } from "vue";
import { useRoute, useRouter } from "vue-router";
import api from "../services/api";
import TheoryBlock from "../components/TheoryBlock.vue";
import CodeBlock from "../components/CodeBlock.vue";
import MicroChallengeBlock from "../components/MicroChallengeBlock.vue";

import { useBugHunting } from "@/composables/useBugHunting";
const { isBugVisionActive, isBugCaptured, captureBug } = useBugHunting();
const animatingBugs = ref(new Set());

const handleBugClick = (bugId) => {
  if (animatingBugs.value.has(bugId)) return;

  // Start animation
  animatingBugs.value.add(bugId);

  // Wait for animation to finish before bug is removed
  setTimeout(() => {
    captureBug(bugId);
    animatingBugs.value.delete(bugId);
  }, 700);
};

const route = useRoute();
const router = useRouter();

const lessonId = computed(() => route.params.id);

const lessonsData = {
  variables: {
    title: "Variables & Data Types",
    subtitle: "Learn how to store and manage data in Java.",
  },
  operators: {
    title: "Operators & Expressions",
    subtitle: "Perform arithmetic and logical operations.",
  },
  ifelse: {
    title: "Control Flow - If / Else",
    subtitle: "Control the program flow based on states.",
  },
  loops: {
    title: "Loops - For & While",
    subtitle: "Repeat code execution efficiently.",
  },
  arrays: {
    title: "Arrays",
    subtitle: "Manage ordered lists of elements.",
  },
  methods: {
    title: "Methods",
    subtitle: "Structure your application with functions and scope.",
  },
  classes: {
    title: "Classes & Objects",
    subtitle: "Build object-oriented structures in Java.",
  },
};

const currentLesson = computed(() => {
  return lessonsData[lessonId.value];
});

const lesson = ref(null);
const currentQuestion = ref(null);
const correctCount = ref(0);
const isCompleted = ref(false);
const isFinishedSession = ref(false);
const isLoading = ref(false);

let latestRequestId = 0;

const checkLocalStorageCompletion = (id) => {
  const completed = JSON.parse(
    localStorage.getItem("completed_lessons") || "{}",
  );
  isCompleted.value = !!completed[id];
};

const saveLessonCompletion = (id) => {
  const completed = JSON.parse(
    localStorage.getItem("completed_lessons") || "{}",
  );
  completed[id] = new Date().toISOString();
  localStorage.setItem("completed_lessons", JSON.stringify(completed));
  isCompleted.value = true;
};

const loadRandomQuestion = () => {
  if (!lesson.value || !lesson.value.questions) return;

  const questions = lesson.value.questions ?? [];
  if (questions.length === 0) {
    currentQuestion.value = null;
    return;
  }

  let nextQuestion;
  do {
    nextQuestion = questions[Math.floor(Math.random() * questions.length)];
  } while (
    nextQuestion.question_id === currentQuestion.value?.question_id &&
    questions.length > 1
  );

  currentQuestion.value = nextQuestion;
};

const fetchLesson = async (id) => {
  if (!id) return;

  const requestId = ++latestRequestId;
  const isCurrentRequest = () =>
    requestId === latestRequestId && route.params.id === id;

  isLoading.value = true;
  lesson.value = null;
  currentQuestion.value = null;
  correctCount.value = 0;
  isFinishedSession.value = false;

  checkLocalStorageCompletion(id);

  try {
    const data = await api.getLesson(id);

    if (!isCurrentRequest()) return;

    if (!data) {
      console.error("Lesson data is null or undefined");
      return;
    }

    lesson.value = {
      ...data.lesson,
      questions: data.questions ?? [],
    };

    loadRandomQuestion();
  } catch (err) {
    if (isCurrentRequest()) {
      console.error("Could not load lesson:", err);
      lesson.value = null;
      currentQuestion.value = null;
    }
  } finally {
    if (isCurrentRequest()) {
      isLoading.value = false;
    }
  }
};

onMounted(() => {
  fetchLesson(route.params.id);
});

watch(
  () => route.params.id,
  (newId) => {
    if (newId) {
      fetchLesson(newId);
    }
  },
);

const handleNextQuestion = () => {
  correctCount.value++;

  if (correctCount.value === 3 && !isCompleted.value) {
    isFinishedSession.value = true;
    saveLessonCompletion(lessonId.value);
  } else if (!isFinishedSession.value) {
    loadRandomQuestion();
  }
};

const restartSession = () => {
  correctCount.value = 0;
  isFinishedSession.value = false;
  loadRandomQuestion();
};

const goBack = () => {
  router.push("/");
};
</script>

<template>
  <div class="lesson-container">
    <!-- HERO SECTION -->
    <section class="hero-section">
      <h1 class="logo-title">
        {{ currentLesson.title }}
        <span
          v-if="isCompleted"
          class="completed-icon-badge"
          role="img"
          aria-label="Lesson Completed"
          title="Lesson Completed"
        >
          <span class="badge-icon-mask icon-check"
          aria-hidden="true"></span>
        </span>
      </h1>
      <p class="hero-subtitle">{{ currentLesson.subtitle }}</p>
    </section>

    <p v-if="isLoading" class="loading">Loading lesson content...</p>

    <main class="lesson-section" v-if="lesson">
      <TheoryBlock :content="lesson.theory_text" />

      <CodeBlock v-if="lesson.code_example" :code="lesson.code_example" />

      <div v-if="isFinishedSession" class="completion-card">
        <h2>Congratulations Adventurer!</h2>
        <p>You have successfully completed this lesson.</p>

        <div class="completion-actions">
          <button @click="restartSession" class="redo-btn">
            Keep Practicing
          </button>
          <button @click="goBack" class="submit-btn">
            Return to Dashboard
          </button>
        </div>
      </div>

      <div class="challenges-section" v-else-if="currentQuestion">
        <div class="section-header">
          <h3>Micro Challenge</h3>
          <span class="progress-indicator" v-if="!isCompleted"
            >Completed: {{ correctCount }} / 3</span
          >
        </div>

        <MicroChallengeBlock
          :key="currentQuestion.question_id"
          :question="currentQuestion"
          :index="correctCount"
          @next-question="handleNextQuestion"
        />
      </div>

      <!-- Hidden Bugs -->
      <div
        v-if="
          lessonId === 'operators' && isBugVisionActive && !isBugCaptured(3)
        "
        class="hidden-bug lesson-bug-3"
        style="--bug-size: 24px;"
        @click="handleBugClick(3)"
        title="Bug Spotted!"
      >
        <span class="badge-icon-mask icon-bug"></span>
        <span v-if="animatingBugs.has(3)" class="xp-popup">+25 XP</span>
      </div>
      <div
        v-if="lessonId === 'arrays' && isBugVisionActive && !isBugCaptured(4)"
        class="hidden-bug lesson-bug-4"
        style="--bug-size: 28px;"
        @click="handleBugClick(4)"
        title="Bug Spotted!"
      >
        <span class="badge-icon-mask icon-bug"></span>
        <span v-if="animatingBugs.has(4)" class="xp-popup">+25 XP</span>
      </div>
    </main>
  </div>
</template>

<style scoped>
.lesson-container {
  position: relative;
  width: 100%;
  max-width: 1000px;
  margin: 0 auto;
  padding-bottom: 3rem;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.hero-section {
  text-align: center;
  position: relative;
  margin-top: 3rem;
  margin-bottom: 2rem;
}

.logo-title {
  font-size: 2.8rem;
  font-weight: 900;
  letter-spacing: 1px;
  line-height: 1.1;
  color: #ffffff;
  margin-bottom: 0.25rem;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  flex-wrap: wrap;
}

.hero-subtitle {
  color: var(--text-muted);
  font-size: 0.95rem;
}

.title-row {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.6rem;
}

.completed-icon-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: var(--accent-color);
  filter: drop-shadow(0 0 8px var(--glow-purple));
  vertical-align: middle;
}

.completed-icon-badge .badge-icon-mask {
  width: 32px;
  height: 32px;
}

.status-badge {
  display: inline-block;
  background-color: rgba(74, 222, 128, 0.1);
  border: 1px solid var(--accent-purple);
  color: var(--accent-color);
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: bold;
  margin-bottom: 0.75rem;
  font-family: var(--font-mono);
  box-shadow: 0 0 10px var(--glow-purple);
}

.lesson-section {
  width: 100%;
  max-width: 1000px;
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
}

.loading {
  text-align: center;
  color: var(--text-muted);
  font-size: 1.1rem;
  margin-top: 3rem;
  font-family: var(--font-mono);
}

.progress-bar-text {
  font-size: 0.85rem;
  color: var(--text-muted);
  margin-bottom: 0.75rem;
  font-weight: bold;
  text-transform: uppercase;
  letter-spacing: 1px;
  font-family: var(--font-mono);
  text-align: center;
}

.completion-card {
  background-color: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid var(--accent-purple);
  box-shadow: 0 0 20px var(--glow-purple);
  border-radius: 18px;
  padding: 2rem;
  text-align: center;
  max-width: 655px;
  margin: 0 auto;
  width: 100%;
}

.completion-card h2 {
  color: var(--accent-color);
  font-size: 1.75rem;
  margin-bottom: 0.5rem;
}

.completion-card p {
  color: var(--text-secondary);
  margin-bottom: 1.5rem;
  font-size: 1rem;
}

.completion-actions {
  display: flex;
  gap: 1rem;
  justify-content: center;
}

.submit-btn,
.redo-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  font-family: var(--font-mono);
  font-size: 0.8rem;
  font-weight: 600;
  padding: 0.6rem 1.2rem;
  border-radius: 10px;
  letter-spacing: 0.5px;
  cursor: pointer;
  transition: all 0.3s ease;
  border: 1px solid var(--border-subtle);
}

.submit-btn {
  background: var(--glow-purple);
  color: #ffffff;
  border-color: var(--accent-purple);
  box-shadow: var(--glow-shadow);
}

.submit-btn:hover {
  background: var(--accent-purple);
  box-shadow: 0 0 20px var(--glow-purple);
}

.redo-btn {
  background: rgba(255, 255, 255, 0.04);
  color: var(--text-secondary);
}

.redo-btn:hover {
  background: rgba(255, 255, 255, 0.08);
  color: #ffffff;
  border-color: var(--text-secondary);
}

.section-header {
  text-align: center;
  margin-bottom: 1.25rem;
}

.section-header h3 {
  font-size: 1.3rem;
  font-weight: 800;
  color: #ffffff;
  letter-spacing: 0.5px;
  margin-bottom: 0.3rem;
}

.progress-indicator {
  font-size: 0.8rem;
  color: var(--text-muted);
  font-family: var(--font-mono);
  text-transform: uppercase;
  letter-spacing: 1px;
}

/* -- HIDDEN BUGS -- */
.lesson-bug-3 {
  top: 1rem;
  right: 2rem;
}
.lesson-bug-3 .badge-icon-mask {
  width: 24px;
  height: 24px;
}

.lesson-bug-4 {
  bottom: 2rem;
  left: 1rem;
}
.lesson-bug-4 .badge-icon-mask {
  width: 28px;
  height: 28px;
}

@media (max-width: 768px) {
  .lesson-container {
    padding-left: 1.25rem;
    padding-right: 1.25rem;
  }

  .logo-title {
    font-size: 2.2rem;
  }

  .hero-section {
    margin-top: 1.5rem;
    margin-bottom: 1.5rem;
  }
}

</style>
