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
    subtitle:
      "Learn how to store and manage data in Java.",
  },
  operators: {
    title: "Operators & Expressions",
    subtitle: "Perform arithmetic and logical operations.",
  },
  ifelse: {
    title: "Control Flow - If / Else",
    subtitle:
      "Control the program flow based on states.",
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
const isLoading = ref(false);

let latestRequestId = 0;

const fetchLesson = async (id) => {
  if (!id) return;

  const requestId = ++latestRequestId;
  const isCurrentRequest = () =>
    requestId === latestRequestId && route.params.id === id;

  isLoading.value = true;

  try {
    const data = await api.getLesson(id);

    if (!isCurrentRequest()) return;

    if (!data) {
      console.error("Lesson data is null or undefined");
      return;
    }

    lesson.value = data.lesson;

    const questions = data.questions ?? [];
    currentQuestion.value = questions.length
      ? questions[Math.floor(Math.random() * questions.length)]
      : null;
  } catch (err) {
    if (isCurrentRequest()) {
      console.error("Could not load lesson:", err);
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

    <main class="lesson-section" v-if="lesson">
      <!-- Space to later add lesson components -->
       <TheoryBlock :content="lesson.theory_text" />
       <CodeBlock v-if="lesson.code_example" :code="lesson.code_example" />
      

       <div class="challenges-section" v-if="currentQuestion">
         <MicroChallengeBlock 
           :question="currentQuestion"
           :index="0"
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
  position: relative;       
  display: flex;
  flex-direction: column;
  align-items: center;    
  width: 100%;
  max-width: 1000px;        
  margin: 0 auto;           
  padding-bottom: 4rem;

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
  color: var(--text-muted);
  font-size: 1rem;
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
