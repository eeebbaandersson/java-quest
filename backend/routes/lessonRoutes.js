const express = require('express');
const router = express.Router();
const lessonController = require('../controllers/lessonController');

//POST /api/questions/check
router.post('/check', lessonController.submitAnswer);

//GET /api/lessons/:id
router.get('/:id', lessonController.getLesson);



module.exports = router;