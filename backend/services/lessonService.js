const db = require('../db');

const lessonService = {
    async getLessonById(lessonId) {
        const [lessons] = await db.query('SELECT * FROM Lessons WHERE lesson_id = ?', [lessonId]);
        if (lessons.length === 0) return null;

        const [questions] = await db.query(
            'SELECT question_id, question_text, code_snippet, options, xp_reward FROM Questions WHERE lesson_id = ?', 
            [lessonId]
        );

        return {
            lesson: lessons[0],
            questions: questions
        };
    },

    async checkAnswer(questionId, selectedAnswer) {
        const [rows] = await db.query('SELECT correct_answer, explanation FROM Questions WHERE question_id = ?', [questionId]);
        if (rows.length === 0) return null;

        const isCorrect = Number(selectedAnswer) === Number(rows[0].correct_answer);

        return {
            correct: isCorrect,
            explanation: rows[0].explanation
        };
    }
};

module.exports = lessonService;