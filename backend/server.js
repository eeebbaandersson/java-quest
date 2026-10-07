require('dotenv').config(); // To handle .env files
const express = require('express');
const cors = require('cors');
const db = require('./db');
const lessonRoutes = require('./routes/lessonRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true}));
app.use(express.static('public')); // To access public folder in Vue Vite frontend

// Future routes will go here
app.use('/api/lessons', lessonRoutes);


// Call to verify database connection using minimal SQL-query
app.get('/api/health', async (req, res) => {
    try {
        const [rows]  = await db.query('SELECT 1 + 1 AS result');
        res.json({ status: 'ok', database: 'connected', result: rows[0].result });
    } catch (error) {
        res.status(500).json({ status: 'error', message: error.message });
    }
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`)
});