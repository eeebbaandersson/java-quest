import mockLessons from "@/data/mockLessons.json";

const BASE_URL =  'http://localhost:3000/api';

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

    try {
       const response = await fetch(`${BASE_URL}/lessons/${numericId}`);
    if (!response.ok) throw new Error("Failed to fetch lesson");
    return await response.json();
    } catch (error) {
      console.warn(`[Fallback] Backend unreachable. Using mock data for lessons: ${slug}`);
      return mockLessons.lessons[slug] || null;
    }
  },

  
  async checkAnswer(questionId, selectedAnswer) {
    try {
      const response = await fetch(`${BASE_URL}/lessons/check`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ questionId, selectedAnswer })
    });
    if (!response.ok) throw new Error("Failed to check answer");
    return await response.json();
    } catch (error) {
      console.warn("[Fallback] Backend unreachable for checkAnswer. Validating answer locally against mock data.");

      // Looks for question with correct ID in mockLessons
      let foundQuestion = null;
      for (const lessonKey of Object.keys(mockLessons.lessons)) {
        const questions = mockLessons.lessons[lessonKey].questions || [];
        const match = questions.find(q => q.question_id === questionId);
        if (match) {
          foundQuestion = match;
          break;
        }
      }

      if (!foundQuestion) {
        throw new Error(`Question with ID ${questionId} not found in mock data.`);
      }

      // Validate answer against correct_answer 
      const isCorrect = foundQuestion.correct_answer === selectedAnswer;

      return {
        correct: isCorrect,
        explanation: foundQuestion.explanation,
        xp_reward: foundQuestion.xp_reward || 25
      };
    }
  },

  async getArenaById(arenaId) {
    try {
       const response = await fetch(`${BASE_URL}/arena/${arenaId}`);
    if (!response.ok) throw new Error("Failed to fetch arena");
    return await response.json();
    } catch (error) {
      console.warn(`[Fallback] Backend unreachable. Using mock data for arena: ${arenaId}`);
      // return mockArenas[arenaId] || null;
    }
  },

  async checkArenaAnswer(questionId, selectedAnswer) {
    try {
       const response = await fetch(`${BASE_URL}/arena/check`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ questionId, selectedAnswer })
    });
    if (!response.ok) throw new Error("Failed to check arena answer");
    return await response.json();
    } catch (error) {
      console.warn("[Fallback] Backend unreachable for checkArenaAnswer.")
      throw error;
    }
  }
};