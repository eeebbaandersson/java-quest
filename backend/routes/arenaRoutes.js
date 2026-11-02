const express = require('express');
const router = express.Router();
const arenaController = require('../controllers/arenaController');


router.post('/check', arenaController.submitAnswer);

router.get('/:id', arenaController.getArenaById);

router.post('/complete', arenaController.completeArena);

module.exports = router;