INSERT INTO Lessons (title, theory_text, code_example, order_index) 
VALUES (
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