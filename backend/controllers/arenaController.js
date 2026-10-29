const arenaService = require('../services/arenaService');

const arenaController = {
    async getArenaById(req, res) {
        try {
            const data = await arenaService.getArenaById(req.params.id);
            if (!data) {
                return res.status(404).json({ error: 'Arena not found' });
            }
            res.json(data);
        } catch (err) {
            console.error(err);
            res.status(500).json({ error: 'Server error' });
        }
    },

    async submitAnswer(req, res) {
        try {
                        const { questionId, selectedAnswer } = req.body;
            if (questionId == null || selectedAnswer == null) {
               return res.status(400).json({ error: 'questionId and selectedAnswer are required' });
            }
            const result = await arenaService.checkAnswer(questionId, selectedAnswer);
            
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

module.exports = arenaController;