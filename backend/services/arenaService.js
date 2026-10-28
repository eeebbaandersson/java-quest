const db = require('../db');

const arenaService = {
    async getArenaById(arenaId) {
        const [arenas] = await db.query('SELECT * FROM Arenas WHERE arena_id = ?', [arenaId]);
        if (arenas.length === 0) return null;

        const [questions] = await db.query(
            'SELECT arena_question_id, question_text, code_snippet, options FROM Arena_questions WHERE arena_id = ?', 
            [arenaId]
        );

        return { ...arenas[0], questions };
    },

    async checkArenaAnswer(arenaQuestionId, selectedAnswer) {
        const [rows] = await db.query('SELECT correct_answer FROM Arena_questions WHERE arena_question_id = ?', [arenaQuestionId]);
        if (rows.length === 0) return null;
        const isCorrect = Number(selectedAnswer) === Number(rows[0].correct_answer);

        return {
            correct: isCorrect
        };
    }
};

module.exports = arenaService;