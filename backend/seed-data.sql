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
),
(
    1, 
    'multiple_choice', 
    'What is the correct way to declare a String variable in Java?', 
    NULL, 
    JSON_ARRAY('String name = "John";', 'int name = "John";', 'String name = John;', "String name = 'John';"), 
    0,
    'The correct syntax for declaring a String variable is: String name = "John";', 
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
),
(
    2, 
    'multiple_choice', 
    'What is the result of the following expression: 5 > 3 && 2 < 4?', 
    NULL, 
    '["true", "false", "null", "error"]', 
    0, 
    'The expression evaluates to true because both conditions (5 > 3 and 2 < 4) are true.', 
    25
);

INSERT INTO Lessons (lesson_id, title, theory_text, code_example, order_index)
VALUES (
    3, 
    'Control Flow', 
    'Control flow statements allow you to dictate the order in which code executes based on conditions. Common control flow statements include if-else statements, switch statements, and loops (for, while).', 
    'public class Main {\n    public static void main(String[] args) {\n        int number = 10;\n        if (number > 0) {\n            System.out.println("Positive number");\n        } else {\n            System.out.println("Non-positive number");\n        }\n    }\n}', 
    3
);

INSERT INTO Questions (lesson_id, question_type, question_text, code_snippet, options, correct_answer, explanation, xp_reward)
VALUES 
(
    3, 
    'multiple_choice', 
    'What will be printed if the variable "number" is set to -5 in the provided code snippet?', 
    'int number = -5;\nif (number > 0) {\n    System.out.println("Positive number");\n} else {\n    System.out.println("Non-positive number");\n}', 
    '["Positive number", "Non-positive number", "Error", "Nothing"]', 
    1, 
    'Since -5 is not greater than 0, the else block executes, printing "Non-positive number".', 
    25
),
(
    3, 
    'multiple_choice', 
    'Which control flow statement is used to execute a block of code multiple times based on a condition?', 
    NULL, 
    '["if-else", "switch", "loop", "try-catch"]', 
    2, 
    'Loops (for, while) are used to execute a block of code multiple times based on a condition.', 
    25
),
(
    3, 
    'multiple_choice', 
    'What is the purpose of an if-else statement in Java?', 
    NULL, 
    '["To declare variables", "To handle exceptions", "To make decisions based on conditions", "To define methods"]', 
    2, 
    'An if-else statement allows you to execute different blocks of code based on whether a condition is true or false.', 
    25
);

INSERT INTO Lessons (lesson_id, title, theory_text, code_example, order_index)
VALUES (
    4,
    'Loops',
    'Loops are used to execute a block of code repeatedly as long as a specified condition is true. Common types of loops in Java include for loops, while loops, and do-while loops.',
    'public class Main {\n    public static void main(String[] args) {\n        for (int i = 0; i < 5; i++) {\n            System.out.println("Iteration: " + i);\n        }\n    }\n}',
    4
);

INSERT INTO Questions (lesson_id, question_type, question_text, code_snippet, options, correct_answer, explanation, xp_reward)
VALUES 
(
    4, 
    'multiple_choice', 
    'What will be the output of the provided for loop code snippet?', 
    'for (int i = 0; i < 5; i++) {\n    System.out.println("Iteration: " + i);\n}', 
    JSON_ARRAY(
        'Iteration: 0\nIteration: 1\nIteration: 2\nIteration: 3\nIteration: 4', 
        'Iteration: 1\nIteration: 2\nIteration: 3\nIteration: 4\nIteration: 5', 
        'Error', 
        'No output'
    ), 
    0, 
    'The loop starts with i = 0 and runs while i < 5, printing the value of i in each iteration. It will print Iteration: 0 to Iteration: 4.', 
    25
),
(
    4, 
    'multiple_choice', 
    'Which type of loop guarantees that the block of code will execute at least once?', 
    NULL, 
    JSON_ARRAY('for loop', 'while loop', 'do-while loop', 'if statement'), 
    2, 
    'A do-while loop executes the block of code first and then checks the condition, ensuring it runs at least once.', 
    25
),
(
    4, 
    'multiple_choice', 
    'What is the main difference between a while loop and a do-while loop?', 
    NULL, 
    '["A while loop checks the condition before executing the block of code, while a do-while loop checks after.", "A while loop can only run once, while a do-while can run multiple times.", "A while loop is faster than a do-while loop.", "There is no difference."]', 
    0, 
    'A while loop checks the condition before executing the block of code, whereas a do-while loop executes the block first and then checks the condition.', 
    25
);

INSERT INTO Lessons (lesson_id, title, theory_text, code_example, order_index)
VALUES (
    5,
    'Arrays',
    'An array is a data structure that can hold multiple values of the same type. In Java, arrays are declared with a specific size and can be accessed using an index, starting from 0.',
    'public class Main {\n    public static void main(String[] args) {\n    int[] numbers = {1, 2, 3, 4, 5};\n        System.out.println("First number: " + numbers[0]); // Outputs 1\n    }\n}',
    5
);

INSERT INTO Questions (lesson_id, question_type, question_text, code_snippet, options, correct_answer, explanation, xp_reward)
VALUES 
(
    5, 
    'multiple_choice', 
    'What is the index of the first element in an array in Java?', 
    NULL, 
    '["0", "1", "-1", "Depends on the array size"]', 
    0, 
    'In Java, arrays are zero-indexed, meaning the first element is at index 0.', 
    25
),
(
    5, 
    'multiple_choice', 
    'How do you declare an array of integers with a size of 10 in Java?', 
    NULL, 
    '["int[] arr = new int[10];", "int arr = new int[10];", "int arr[] = new int(10);", "int arr = new int[];"]', 
    0, 
    'The correct syntax to declare an array of integers with a size of 10 is: int[] arr = new int[10];', 
    25
),
(
    5, 
    'multiple_choice', 
    'What will be the output of the following code snippet?\n\nint[] numbers = {10, 20, 30};\nSystem.out.println(numbers[2]);', 
    NULL, 
    '["10", "20", "30", "Error"]', 
    2, 
    'The code accesses the third element of the array (index 2), which is 30.', 
    25
);

INSERT INTO Lessons (lesson_id, title, theory_text, code_example, order_index)
VALUES (
    6,
    'Methods',
    'A method is a block of code that performs a specific task and can be called upon when needed. Methods can take parameters, return values, and help organize code into reusable sections.',
    'public class Main {\n    public static void main(String[] args) {\n        int result = add(5, 10);\n        System.out.println("Sum: " + result); // Outputs 15\n    }\n\n    public static int add(int a, int b) {\n        return a + b;\n    }\n}',
    6
);

INSERT INTO Questions (lesson_id, question_type, question_text, code_snippet, options, correct_answer, explanation, xp_reward)
VALUES 
(
    6, 
    'multiple_choice', 
    'What is the purpose of a method in Java?', 
    NULL, 
    '["To store data", "To perform a specific task and can be reused", "To create variables", "To handle exceptions"]', 
    1, 
    'A method is a block of code that performs a specific task and can be called upon when needed, promoting code reusability.', 
    25
),
(
    6, 
    'multiple_choice', 
    'How do you call the add method with parameters 5 and 10 in the provided code snippet?', 
    NULL, 
    '["add(5, 10);", "add(10, 5);", "add();", "add(5);"]', 
    0, 
    'The correct way to call the add method with parameters 5 and 10 is: add(5, 10);', 
    25
),
(
    6, 
    'multiple_choice', 
    'What will be the output of the following code snippet?\n\nint result = add(3, 7);\nSystem.out.println(result);', 
    NULL, 
    '["3", "7", "10", "Error"]', 
    2, 
    'The add method takes two integers (3 and 7), adds them together, and returns the result (10), which is then printed.', 
    25
);

INSERT INTO Lessons (lesson_id, title, theory_text, code_example, order_index)
VALUES (
    7,
    'Classes & Objects',
    'In Java, a class is a blueprint for creating objects. An object is an instance of a class that can have attributes (fields) and behaviors (methods). Classes encapsulate data and functionality, promoting modularity and reusability.',
    'public class Car {\n    String color;\n    int speed;\n\n    public void accelerate() {\n        speed += 10;\n    }\n\n    public static void main(String[] args) {\n        Car myCar = new Car();\n        myCar.color = "Red";\n        myCar.speed = 0;\n        myCar.accelerate();\n        System.out.println("Car color: " + myCar.color + ", Speed: " + myCar.speed); // Outputs Red, Speed: 10\n    }\n}',
    7
);

INSERT INTO Questions (lesson_id, question_type, question_text, code_snippet, options, correct_answer, explanation, xp_reward)
VALUES 
(
    7, 
    'multiple_choice', 
    'What is the relationship between a class and an object in Java?', 
    NULL, 
    '["A class is an instance of an object", "An object is a blueprint for a class", "A class is a blueprint for creating objects", "There is no relationship"]', 
    2, 
    'A class serves as a blueprint for creating objects, which are instances of that class.', 
    25
),
(
    7, 
    'multiple_choice', 
    'How do you create an instance of the Car class in the provided code snippet?', 
    NULL, 
    '["Car myCar = new Car();", "Car myCar = Car();", "myCar = new Car();", "Car myCar;"]', 
    0, 
    'The correct syntax to create an instance of the Car class is: Car myCar = new Car();', 
    25
),
(
    7, 
    'multiple_choice', 
    'What will be the output of the following code snippet?\n\nCar myCar = new Car();\nmyCar.color = "Blue";\nmyCar.speed = 20;\nmyCar.accelerate();\nSystem.out.println(myCar.speed);', 
    NULL, 
    '["20", "30", "10", "Error"]', 
    1, 
    'The accelerate method increases the speed by 10. Starting from 20, after calling accelerate(), the speed becomes 30.', 
    25
);