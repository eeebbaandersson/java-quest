<script setup>
import { ref, computed, onMounted, watch } from "vue";
import { useRoute, useRouter } from "vue-router";
import api from "../services/api";
import TheoryBlock from "../components/TheoryBlock.vue";
import CodeBlock from "../components/CodeBlock.vue";
import MicroChallengeBlock from "../components/MicroChallengeBlock.vue";

import { useBugHunting } from "@/composables/useBugHunting";
const { isBugVisionActive, isBugCaptured, captureBug } = useBugHunting();

const handleBugClick = (bugId) => {
  captureBug(bugId);
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
    subtitle:
      "Structure your application with functions and scope.",
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
  const completed = JSON.parse(localStorage.getItem("completed_lessons") || "{}");
  isCompleted.value = !!completed[id];
};

const saveLessonCompletion = (id) => {
  const completed = JSON.parse(localStorage.getItem("completed_lessons") || "{}");
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
  } while (nextQuestion.question_id === currentQuestion.value?.question_id && questions.length > 1);

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
      questions: data.questions ?? []
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

watch(() => route.params.id, (newId) => {
  if (newId) {
    fetchLesson(newId);
  }
});


const handleNextQuestion = () => {
  correctCount.value++;

  if (correctCount.value === 3 && !isCompleted.value) {
    isFinishedSession.value = true;
    saveLessonCompletion(lessonId.value);
  } else if(!isFinishedSession.value) {
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
    <section class="lesson-hero">
      <h1 class="lesson-title">{{ currentLesson.title }}</h1>
      <p class="lesson-subtitle">{{ currentLesson.subtitle }}</p>

      <div v-if="isCompleted" class="status-badge">
        ✓ Lesson Completed
      </div>
    </section>

    <p v-if="isLoading" class="loading">Loading lesson content...</p>
    
    <main class="lesson-section" v-if="lesson">
       <TheoryBlock :content="lesson.theory_text" />
       <CodeBlock v-if="lesson.code_example" :code="lesson.code_example" />
       
       <div v-if="isFinishedSession" class="completion-card">
         <h2>Congratulations Adventurer!</h2>
         <p>You have successfully completed this lesson.</p>
         <div class="completion-actions">
           <button @click="restartSession" class="redo-btn">Practice More Random Questions</button>
           <button @click="goBack" class="submit-btn">Return to Dashboard</button>
         </div>
       </div>

       
       <div class="challenges-section" v-else-if="currentQuestion">
         <div class="progress-bar-text" v-if="!isCompleted">
           <span>Completed Microchallenges: {{ correctCount }} / 3</span>
         </div>

         <MicroChallengeBlock 
           :key="currentQuestion.question_id"
           :question="currentQuestion"
           :index="correctCount"
           @next-question="handleNextQuestion"
         />
       </div>

       <div 
         v-if="lessonId === 'operators' && isBugVisionActive && !isBugCaptured(3)" 
         class="hidden-bug lesson-bug-3" 
         @click="handleBugClick(3)"
         title="Bug Spotted!"
       >
         <span class="badge-icon-mask icon-bug"></span>
       </div>
        <div 
         v-if="lessonId === 'arrays' && isBugVisionActive && !isBugCaptured(4)" 
         class="hidden-bug lesson-bug-4" 
         @click="handleBugClick(4)"
         title="Bug Spotted!"
       >
         <span class="badge-icon-mask icon-bug"></span>
       </div>
    </main>
  </div>
</template>

<style scoped>
.lesson-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 20px;
  color: #ffffff;
}

.back-btn {
  background: transparent;
  border: 1px solid #4a5568;
  color: #cbd5e0;
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
  margin-bottom: 2rem;
}

.back-btn:hover {
  background: #2d3748;
}

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
  color: #a0aec0;
  font-size: 1rem;
}

.status-badge {
  display: inline-block;
  background: rgba(56, 161, 105, 0.2);
  border: 1px solid #38a169;
  color: #9ae6b4;
  padding: 6px 14px;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: bold;
  margin-top: 1rem;
}

.loading {
  text-align: center;
  color: #a0aec0;
  font-size: 1.2rem;
  margin-top: 3rem;
}

.progress-bar-text {
  font-size: 0.9rem;
  color: #a0aec0;
  margin-bottom: 0.75rem;
  font-weight: bold;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.completion-card {
  background: rgba(56, 161, 105, 0.15);
  border: 1px solid #38a169;
  border-radius: 12px;
  padding: 30px;
  text-align: center;
  margin-top: 2rem;
}

.completion-card h2 {
  color: #9ae6b4;
  font-size: 2rem;
  margin-bottom: 10px;
}

.completion-card p {
  color: #e2e8f0;
  margin-bottom: 20px;
  font-size: 1.1rem;
}

.completion-actions {
  display: flex;
  gap: 12px;
  justify-content: center;
}

.submit-btn, .redo-btn {
  padding: 12px 24px;
  border-radius: 8px;
  font-weight: bold;
  cursor: pointer;
  border: none;
}

.submit-btn {
  background: #38a169;
  color: white;
}
.submit-btn:hover {
  background: #2f855a;
}

.redo-btn {
  background: #2d3748;
  color: #e2e8f0;
  border: 1px solid #4a5568;
}
.redo-btn:hover {
  background: #4a5568;
}

/* --  HIDDEN BUGS -- */ 
.hidden-bug {
  position: absolute;             
  cursor: pointer;
  color: var(--accent-purple);
  opacity: 0.35;
  transition: all 0.2s ease;
  padding: 0.5rem;
  z-index: 10;
}

.hidden-bug:hover {
  opacity: 1;
  filter: drop-shadow(0 0 8px var(--glow-purple));
}

.lesson-bug-3 {
  top: 1.5rem;
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


</style>