INSERT INTO Arenas (level, description) VALUES 
('Novice', 'Basic syntax, variables, and fundamental programming concepts.'),
('Challenger', 'Control flow, loops, arrays, and standard functions.'),
('Hero', 'Advanced scope rules, hoisting, memory management, and algorithmic logic.');

-- ==========================================
-- 1. NOVICE JAVA QUESTIONS (arena_id = 1) - 10 Questions
-- ==========================================
INSERT INTO Arena_questions (arena_id, question_text, code_snippet, options, correct_answer) VALUES 
(
  1, 
  'What is the correct way to declare a main method in a Java application?', 
  NULL, 
  '["public static void main(String[] args)", "void main(String args)", "static public main(String[] arg)", "public void main()"]', 
  0
),
(
  1, 
  'Which of the following data types is used to store a single character in Java?', 
  NULL, 
  '["String", "char", "character", "text"]', 
  1
),
(
  1, 
  'What is the default value of an uninitialized int instance variable in a Java class?', 
  NULL, 
  '["null", "1", "0", "undefined"]', 
  2
),
(
  1, 
  'Which keyword is used to inherit a class in Java?', 
  NULL, 
  '["implements", "extends", "inherits", "superclass"]', 
  1
),
(
  1, 
  'What will be the output of this code snippet?', 
  'String s = \"Hello\";\ns.concat(\" World\");\nSystem.out.println(s);', 
  '[\"Hello World\", \"Hello\", \"World\", \"NullPointerException\"]', 
  1
),
(
  1, 
  'Which package is automatically imported in every Java program by default?', 
  NULL, 
  '["java.util", "java.io", "java.lang", "java.net"]', 
  2
),
(
  1, 
  'What is the extension of a compiled Java bytecode file?', 
  NULL, 
  '[\".java\", \".class\", \".jar\", \".js\"]', 
  1
),
(
  1, 
  'Which access modifier makes a variable or method accessible only within its own class?', 
  NULL, 
  '["public", "protected", "default", "private"]', 
  3
),
(
  1, 
  'How do you properly check if two string variables `str1` and `str2` have the exact same text content in Java?', 
  NULL, 
  '["str1 == str2", "str1.equals(str2)", "str1.isSame(str2)", "str1.compareTo(str2) == 1"]', 
  1
),
(
  1, 
  'Which of these is NOT a primitive data type in Java?', 
  NULL, 
  '["boolean", "int", "double", "String"]', 
  3
);

-- ==========================================
-- 2. CHALLENGER JAVA QUESTIONS (arena_id = 2) - 10 Questions
-- ==========================================
INSERT INTO Arena_questions (arena_id, question_text, code_snippet, options, correct_answer) VALUES 
(
  2, 
  'What will be the output of this code snippet utilizing wrapper caching?', 
  'Integer a = 127;\nInteger b = 127;\nInteger c = 1000;\nInteger d = 1000;\nSystem.out.println((a == b) + \" \" + (c == d));', 
  '["true true", "true false", "false false", "false true"]', 
  1
),
(
  2, 
  'Which interface must a class implement to allow its objects to be sorted using `Collections.sort()` without a custom Comparator?', 
  NULL, 
  '["Iterable", "Serializable", "Comparable", "Comparator"]', 
  2
),
(
  2, 
  'What happens when an exception is thrown inside a `try` block that has both a `catch` block and a `finally` block?', 
  NULL, 
  '["Only the catch block runs", "The finally block runs before the catch block", "The catch block runs first, then the finally block runs", "The finally block is skipped if catch handles the exception"]', 
  2
),
(
  2, 
  'What is the key difference between an `ArrayList` and a `LinkedList` in Java?', 
  NULL, 
  '["ArrayList uses a doubly-linked list; LinkedList uses a dynamic array", "ArrayList provides O(1) random access; LinkedList provides O(1) insertions/deletions when node reference is known", "LinkedList is synchronized by default; ArrayList is not", "There is no performance difference"]', 
  1
),
(
  2, 
  'What is the purpose of the `volatile` keyword in Java multi-threading?', 
  NULL, 
  '["It locks methods to prevent race conditions like synchronized", "It guarantees that changes to a variable are immediately visible to other threads (prevents CPU caching)", "It makes a variable immutable", "It deletes objects from memory automatically"]', 
  1
),
(
  2, 
  'Which collection type does NOT allow duplicate elements and guarantees unique entries based on `equals()` and `hashCode()`?', 
  NULL, 
  '["List", "Set", "Queue", "Map"]', 
  1
),
(
  2, 
  'What will this stream operation output?', 
  'List<Integer> list = Arrays.asList(1, 2, 3, 4);\nint sum = list.stream().filter(n -> n % 2 == 0).mapToInt(n -> n).sum();\nSystem.out.println(sum);', 
  '["10", "6", "4", "3"]', 
  1
),
(
  2, 
  'Can an interface in Java have method bodies?', 
  NULL, 
  '["No, all methods in an interface must be strictly abstract", "Yes, using the `default` or `static` keywords introduced in Java 8", "Yes, using the `body` keyword", "Only if the interface is marked as abstract"]', 
  1
),
(
  2, 
  'What is the primary behavior of a `HashMap` when a key collision occurs (two keys hash to the same bucket)?', 
  NULL, 
  '["The old value is instantly deleted", "An exception is thrown crashing the map", "Entries are stored in a linked list or balanced tree (Java 8+) at that bucket index", "The map automatically increases its bucket capacity to infinity"]', 
  2
),
(
  2, 
  'What is a functional interface in Java?', 
  NULL, 
  '["An interface with zero methods", "An interface containing exactly one abstract method", "An interface used exclusively for math operations", "An interface that cannot be implemented"]', 
  1
);

-- ==========================================
-- 3. HERO JAVA QUESTIONS (arena_id = 3) - 10 Questions
-- ==========================================
INSERT INTO Arena_questions (arena_id, question_text, code_snippet, options, correct_answer) VALUES 
(
  3, 
  'What will be the output or behavior of executing this code involving class initialization order?', 
  'class Parent {\n    static { System.out.print(\"A\"); }\n    { System.out.print(\"B\"); }\n    public Parent() { System.out.print(\"C\"); }\n}\nclass Child extends Parent {\n    static { System.out.print(\"D\"); }\n    { System.out.print(\"E\"); }\n    public Child() { System.out.print(\"F\"); }\n}\npublic class Main {\n    public static void main(String[] args) {\n        new Child();\n    }\n}', 
  '["ABCDEF", "ADBCEF", "DAEBCF", "BCEADF"]', 
  1
),
(
  3, 
  'How does Java’s Garbage Collector handle objects referenced only by a `WeakReference`?', 
  NULL, 
  '["They are never collected until the application shuts down", "They are collected during the next garbage collection cycle regardless of available heap memory", "They are collected only when the JVM runs critically low on memory", "They are promoted to the old generation pool"]', 
  1
),
(
  3, 
  'What is the purpose of the `happens-before` relationship in the Java Memory Model (JMM)?', 
  NULL, 
  '["It enforces that code execution order matches written line numbers strictly", "It guarantees that memory writes by one statement are visible to another statement, preventing instruction reordering issues in concurrent execution", "It dictates which thread starts first", "It optimizes compiler byte size"]', 
  1
),
(
  3, 
  'What is the structural difference between a `ThreadLocal` variable and a standard shared variable in multi-threaded environments?', 
  NULL, 
  '["ThreadLocal provides a separate, isolated copy of the variable for each individual thread accessing it", "ThreadLocal automatically synchronizes writes across all CPU cores", "ThreadLocal stores variables directly in CPU registers", "There is no difference; it is an alias for synchronized"]', 
  0
),
(
  3, 
  'What is bytecode weaving in the context of Java frameworks like AspectJ or Spring AOP?', 
  NULL, 
  '["Compiling Java source code into machine code via JIT", "Modifying existing class bytecode bytes (either at compile-time, load-time, or runtime) to inject cross-cutting behavior like logging or transactions", "Encrypting jar files to prevent decompilation", "A memory optimization technique for garbage collection"]', 
  1
),
(
  3, 
  'What happens when you call `intern()` on a dynamically created `String` object in Java?', 
  NULL, 
  '["It creates a deep copy of the string on the heap", "It checks if the string exists in the JVM String Pool; if so, it returns a reference to that pooled instance, otherwise it adds it to the pool", "It converts the string to lowercase UTF-8 format", "It forces the string to be garbage collected"]', 
  1
),
(
  3, 
  'What is the main advantage of using Java NIO (Non-blocking I/O) Channels and Buffers over traditional IO Streams?', 
  NULL, 
  '["NIO automatically encrypts all network packets", "NIO allows multiplexed, non-blocking asynchronous operations where a single thread can manage multiple active network connections", "NIO uses zero memory allocation", "NIO bypasses the operating system kernel entirely"]', 
  1
),
(
  3, 
  'In the Java Concurrency package, what does a `CountDownLatch` do?', 
  NULL, 
  '["It acts as a mutual exclusion lock like a semaphore with a count of 1", "It allows one or more threads to wait until a set of operations being performed in other threads completes", "It counts how many threads have deadlocked", "It automatically terminates background worker threads"]', 
  1
),
(
  3, 
  'What is the core difference between `ClassNotFoundException` and `NoClassDefFoundError` in Java?', 
  NULL, 
  '["ClassNotFoundException is a checked exception thrown when an application tries to load a class by name at runtime but it cannot be found; NoClassDefFoundError is an unchecked error thrown when a class was present at compile-time but missing at runtime", "ClassNotFoundException only occurs in multithreaded environments", "NoClassDefFoundError can be caught using a standard catch block safely", "They are exact synonyms"]', 
  0
),
(
  3, 
  'What is a `Spliterator` introduced in Java 8 primarily designed to achieve?', 
  NULL, 
  '["Splitting text strings into regex arrays", "Traversing and partitioning elements of a source (especially for parallel stream processing and data splitting)", "Splitting database transactions into smaller threads", "Replacing standard iterators in legacy codebases"]', 
  1
);