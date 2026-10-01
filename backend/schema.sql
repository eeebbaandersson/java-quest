
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Questions;
DROP TABLE IF EXISTS Lessons;
DROP TABLE IF EXISTS User_progress;

CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255),
    total_xp INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Lessons (
    lesson_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    theory_text TEXT NOT NULL,
    code_example TEXT NOT NULL,
    order_index INT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    lesson_id INT NOT NULL,
    question_type VARCHAR(150) NOT NULL DEFAULT 'multiple_choice',
    question_text TEXT NOT NULL,
    code_snippet TEXT NULL,
    options JSON NOT NULL,
    correct_answer INT NOT NULL,
    explanation TEXT NOT NULL,
    xp_reward INT DEFAULT 25,

    FOREIGN KEY (lesson_id) REFERENCES Lessons(lesson_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS User_progress (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    lesson_id INT NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



