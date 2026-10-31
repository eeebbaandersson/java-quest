// const BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';

const BASE_URL = 'http://localhost:3000/api';

//Code to map lesson slugs to their corresponding numeric IDs in the database
const lessonIdMap = {
  variables: 1,
  operators: 2,
  ifelse: 3,
  loops: 4,
  arrays: 5,
  methods: 6,
  classes: 7
};

export default {
  async getLesson(slug) {
    const numericId = lessonIdMap[slug] || slug;

    const response = await fetch(`${BASE_URL}/lessons/${numericId}`);
    if (!response.ok) throw new Error("Failed to fetch lesson");
    return await response.json();
  },

  async checkAnswer(questionId, selectedAnswer) {
    const response = await fetch(`${BASE_URL}/lessons/check`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ questionId, selectedAnswer })
    });
    if (!response.ok) throw new Error("Failed to check answer");
    return await response.json();
  },

  async getArenaById(arenaId) {
    const response = await fetch(`${BASE_URL}/arena/${arenaId}`);
    if (!response.ok) throw new Error("Failed to fetch arena");
    return await response.json();
  },

  async checkArenaAnswer(questionId, selectedAnswer) {
    const response = await fetch(`${BASE_URL}/arena/check`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ questionId, selectedAnswer })
    });
    if (!response.ok) throw new Error("Failed to check arena answer");
    return await response.json();
  }
};