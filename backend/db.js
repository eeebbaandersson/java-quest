const mysql = require('mysql2/promise'); // Inbyggdt stöd för promise + async/await
require('dotenv').config();

// createPool --> maintains a pool of active connections (shared across requests) instead of open/closing a new one for every single database query 
// process.env.xxx --> Looks for .env variables first, otherwise the fall-back value is used 
const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'secret',
    database: process.env.DB_NAME || 'javaquest_db',
    port: process.env.DB_PORT || 3306,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

module.exports = pool;