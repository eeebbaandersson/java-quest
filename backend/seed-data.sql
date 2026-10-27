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
    'Hint: Think about which type handles whole numbers versus decimals or text.', 
    25
),
(
    1, 
    'multiple_choice', 
    'What role does this line of code play?', 
    'int score = 100;', 
    '["Creates a text variable named score", "Stores the whole number 100 in a variable named score", "Deletes the score variable", "Creates a decimal number"]', 
    1,
    'Hint: Consider what keyword declares the type and what value is assigned to the variable.', 
    25
),
(
    1, 
    'multiple_choice', 
    'What is the correct way to declare a String variable in Java?', 
    NULL, 
    JSON_ARRAY('String name = "John";', 'int name = "John";', 'String name = John;', "String name = 'John';"), 
    0,
    'Hint: Remember that text values require double quotes and the proper type name.', 
    25
),
(
    1, 
    'fill_in_the_blanks', 
    'Complete the code snippet by filling in the correct data type for text:', 
    '___ name = "Alice";', 
    '["int", "String", "boolean", "char"]', 
    1,
    'Hint: This type begins with a capital letter and represents a sequence of characters.', 
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
    'Hint: Remember that this symbol stands for division remainder, not regular division.',
    25
),
(
    2, 
    'multiple_choice', 
    'Which operator represents the logical AND operation in Java?', 
    NULL, 
    '["||", "&&", "!", "&"]', 
    1, 
    'Hint: Think of the symbol that requires both conditions to be evaluated together using doubled characters.', 
    25
),
(
    2, 
    'multiple_choice', 
    'What is the result of the following expression: 5 > 3 && 2 < 4?', 
    NULL, 
    '["true", "false", "null", "error"]', 
    0, 
    'Hint: Evaluate both sides of the logical AND operator separately.', 
    25
),
(
    2, 
    'fill_in_the_blanks', 
    'Complete the conditional expression with the correct logical operator for "AND":', 
    'if (x > 0 ___ y < 10) { /* code */ }', 
    '["||", "&&", "!", "+"]', 
    1, 
    'Hint: This operator uses a doubled symbol to evaluate if both sides are true.', 
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
    'Hint: Since -5 is not greater than 0, check which branch of the if-else statement runs.', 
    25
),
(
    3, 
    'multiple_choice', 
    'Which control flow statement is used to execute a block of code multiple times based on a condition?', 
    NULL, 
    '["if-else", "switch", "loop", "try-catch"]', 
    2, 
    'Hint: Think about constructs that repeat actions based on conditions.', 
    25
),
(
    3, 
    'multiple_choice', 
    'What is the purpose of an if-else statement in Java?', 
    NULL, 
    '["To declare variables", "To handle exceptions", "To make decisions based on conditions", "To define methods"]', 
    2, 
    'Hint: It helps the program make choices based on true or false conditions.', 
    25
),
(
    3, 
    'fill_in_the_blanks', 
    'Fill in the alternative keyword used when an "if" condition evaluates to false:', 
    'if (score >= 50) { /* pass */ } ___ { /* fail */ }', 
    '["else", "then", "switch", "loop"]', 
    0, 
    'Hint: It catches everything that falls outside the initial if condition.', 
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
    'Hint: Trace the variable i starting from its initial value and check the stop condition.', 
    25
),
(
    4, 
    'multiple_choice', 
    'Which type of loop guarantees that the block of code will execute at least once?', 
    NULL, 
    JSON_ARRAY('for loop', 'while loop', 'do-while loop', 'if statement'), 
    2, 
    'Hint: Look for the loop variant that checks its condition at the end of the block.', 
    25
),
(
    4, 
    'multiple_choice', 
    'What is the main difference between a while loop and a do-while loop?', 
    NULL, 
    '["A while loop checks the condition before executing the block of code, while a do-while loop checks after.", "A while loop can only run once, while a do-while can run multiple times.", "A while loop is faster than a do-while loop.", "There is no difference."]', 
    0, 
    'Hint: Pay attention to whether the condition is checked before or after execution.', 
    25
),
(
    4, 
    'fill_in_the_blanks', 
    'Fill in the loop condition to run the code as long as i is less than 5:', 
    'for (int i = 0; ___ ; i++) { }', 
    '["i > 5", "i = 5", "i < 5", "i != 5"]', 
    2, 
    'Hint: Think about the comparison operator used to check an upper boundary.', 
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
    'Hint: Java uses zero-based indexing for arrays and collections.', 
    25
),
(
    5, 
    'multiple_choice', 
    'How do you declare an array of integers with a size of 10 in Java?', 
    NULL, 
    '["int[] arr = new int[10];", "int arr = new int[10];", "int arr[] = new int(10);", "int arr = new int[];"]', 
    0, 
    'Hint: Look for the brackets [] paired with the new keyword and size specification.',
    25
),
(
    5, 
    'multiple_choice', 
    'What will be the output of the following code snippet?\n\nint[] numbers = {10, 20, 30};\nSystem.out.println(numbers[2]);', 
    NULL, 
    '["10", "20", "30", "Error"]', 
    2, 
    'Hint: Remember that indexing starts at 0, so index 2 is the third element.', 
    25
),
(
    5, 
    'fill_in_the_blanks', 
    'Fill in the keyword used to allocate memory when instantiating an array:', 
    'int[] numbers = ___ int[5];', 
    '["alloc", "new", "create", "init"]', 
    1, 
    'Hint: This keyword is used across Java to create objects and arrays in heap memory.', 
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
    'Hint: Methods help structure modular code so you do not have to rewrite the same logic.', 
    25
),
(
    6, 
    'multiple_choice', 
    'How do you call the add method with parameters 5 and 10 in the provided code snippet?', 
    NULL, 
    '["add(5, 10);", "add(10, 5);", "add();", "add(5);"]', 
    0, 
    'Hint: Pass the argument values inside parentheses directly after the method name.', 
    25
),
(
    6, 
    'multiple_choice', 
    'What will be the output of the following code snippet?\n\nint result = add(3, 7);\nSystem.out.println(result);', 
    NULL, 
    '["3", "7", "10", "Error"]', 
    2, 
    'Hint: Substitute the arguments into the addition logic of the method.', 
    25
),
(
    6, 
    'fill_in_the_blanks', 
    'Complete the method definition by providing the keyword used to send a value back to the caller:', 
    'public int add(int a, int b) {\n    ___ a + b;\n}', 
    '["give", "output", "return", "send"]', 
    2, 
    'Hint: This keyword exits the method and passes the computed result back.', 
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
    'Hint: Think of the class as the architectural blueprint and the object as the built house.', 
    25
),
(
    7, 
    'multiple_choice', 
    'How do you create an instance of the Car class in the provided code snippet?', 
    NULL, 
    '["Car myCar = new Car();", "Car myCar = Car();", "myCar = new Car();", "Car myCar;"]', 
    0, 
    'Hint: Use the class name followed by the variable name, new keyword, and constructor.',
    25
),
(
    7, 
    'multiple_choice', 
    'What will be the output of the following code snippet?\n\nCar myCar = new Car();\nmyCar.color = "Blue";\nmyCar.speed = 20;\nmyCar.accelerate();\nSystem.out.println(myCar.speed);', 
    NULL, 
    '["20", "30", "10", "Error"]', 
    1, 
    'Hint: Track how the accelerate method modifies the speed field starting from 20.', 
    25
),
(
    7, 
    'multiple_choice', 
    'What is the relationship between a class and an object in Java?', 
    NULL, 
    '["A class is an instance of an object", "An object is a blueprint for a class", "A class is a blueprint for creating objects", "There is no relationship"]', 
    2, 
    'Hint: Think of the class as the architectural blueprint and the object as the built house.', 
    25
),
(
    7, 
    'fill_in_the_blanks', 
    'Fill in the missing keyword to instantiate an object of the Car class:', 
    'Car myCar = ___ Car();', 
    '["null", "this", "new", "class"]', 
    2, 
    'Hint: Used alongside constructor calls to allocate a brand new object instance.', 
    25
);