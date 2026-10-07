const lessonService = require('../services/lessonService');

const lessonController = {
    async getLesson(req, res) {
        try {
            const data = await lessonService.getLessonById(req.params.id);
            if (!data) {
                return res.status(404).json({ error: 'Lesson not found' });
            }
            res.json(data);
        } catch (err) {
            console.error(err);
            res.status(500).json({ error: 'Server error' });
        }
    },

    async submitAnswer(req, res) {
        try {
                        const { questionId, selectedAnswer } = req.body ?? {};
            if (questionId == null || selectedAnswer == null) {
               return res.status(400).json({ error: 'questionId and selectedAnswer are required' });
            }
            const result = await lessonService.checkAnswer(questionId, selectedAnswer);
            
            if (!result) {
                return res.status(404).json({ error: 'Question not found' });
            }

            res.json(result);
        } catch (err) {
            console.error(err);
            res.status(500).json({ error: 'Server error' });
        }
    }
};

module.exports = lessonController;