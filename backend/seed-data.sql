DROP TABLE IF EXISTS Questions;
DROP TABLE IF EXISTS Lessons;

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
INSERT INTO Lessons (lesson_id, title, theory_text, code_example, order_index) 
VALUES (
    1,
    'Variables',
    'In Java, a variable is a container for storing data values. To create a variable, you must specify its type and assign a value to it using the equals sign (=). Common types include int for whole numbers and String for text.',
    'public class Main {\n    public static void main(String[] args) {\n        int age = 25;\n        String name = "Alice";\n        System.out.println(name + " is " + age);\n    }\n}',
    1
);

INSERT INTO Questions (lesson_id, question_type, question_text, code_snippet, options, correct_answer, explanation, xp_reward) 
VALUES 
(
    1, 
    'multiple_choice', 
    'Which data type is best suited for storing a whole number like 67?', 
    NULL, 
    '["String", "int", "boolean", "double"]', 
    1,
    'The "int" data type stores integers (whole numbers) without decimals.', 
    25
),
(
    1, 
    'multiple_choice', 
    'What role does this line of code play?', 
    'int score = 100;', 
    '["Creates a text variable named score", "Stores the whole number 100 in a variable named score", "Deletes the score variable", "Creates a decimal number"]', 
    1,
    'int score = 100; declares an integer variable named score and assigns the value 100 to it.', 
    25
);
INSERT INTO Lessons (lesson_id, title, theory_text, code_example, order_index) 
VALUES (
    2, 
    'Operators & Expressions', 
    'Operators are special symbols used to perform operations on variables and values. In Java, arithmetic operators handle math (+, -, *, /, %), relational operators compare values (==, >, <), and logical operators evaluate boolean conditions (&&, ||, !).', 
    'public class Main {\n    public static void main(String[] args) {\n        int a = 10;\n        int b = 3;\n        int remainder = a % b;\n        System.out.println("Remainder: " + remainder); // 1\n    }\n}', 
    2
);

INSERT INTO Questions (lesson_id, question_type, question_text, code_snippet, options, correct_answer, explanation, xp_reward) 
VALUES 
(
    2, 
    'multiple_choice', 
    'What is the output of the modulus operator in this expression?', 
    'int result = 10 % 3;', 
    '["3", "1", "0", "3.33"]', 
    1, 
    'The modulus operator (%) returns the remainder of a division. 10 divided by 3 is 3 with a remainder of 1.', 
    25
),
(
    2, 
    'multiple_choice', 
    'Which operator represents the logical AND operation in Java?', 
    NULL, 
    '["||", "&&", "!", "&"]', 
    1, 
    'The logical AND operator is represented by two ampersands (&&). It returns true only if both sides are true.', 
    25
);