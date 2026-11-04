# JAVA{}QUEST

**JAVA{}QUEST** is an interactive, gamified web application designed to help learners master core Java concepts step-by-step through interactive lessons, micro-challenges, arena battles, and bug-hunting gameplay.

🌐 **Live Frontend Demo:** [https://eeebbaandersson.github.io/java-quest/](https://eeebbaandersson.github.io/java-quest/)

---

## ✨ Features

- **Lesson Quests:** Embark on a structured learning journey covering core Java syntax, primitive data types, methods, and basic classes.
- **Arena Challenges:** Put your knowledge to the test across multiple difficulty levels (*Novice*, *Challenger*, *Hero*) with interactive programming questions. P.S. Just make sure you don´t run out of shields...
- **Bug-Vision Mode:** Step into the role of a real-time debugger and hunt down hidden bugs scattered across the application interface for bonus XP.
- **Trophy & Progression System:**  Earn XP, level up your player profile and unlock prestigious trophies.
- **Gaming Aesthetic:** Built with a modern videogame inspired UI and a responsive layouts optimized for both desktop and mobile devices.


## 🛠️ Tech Stack

### Frontend
- **Framework:** Vue 3 (Composition API)
- **Routing:** Vue Router (Hash History for subdirectory hosting)
- **Build Tool:** Vite
- **Storage:** LocalStorage for client-side state, progress tracking, and fallback handling

### Backend & API
- **Runtime Environment:** Node.js
- **Server Framework:** Express.js
- **Database:** MySQL

### DevOps, Containerization & Deployment
- **Containerization:** Docker & Docker Compose (for local database & environment management)
- **CI/CD Pipeline:** GitHub Actions
- **Hosting:** GitHub Pages (Frontend client)


## 📁 Project Structure

```text
javaQuest/
├── .github/
│   └── workflows/
│       └── deploy.yml            # CI/CD deployment workflow for GitHub Pages
├── backend/
│   ├── controllers/              # Express route controllers (Arena & Lessons)
│   ├── routes/                   # API endpoint definitions
│   ├── services/                 # Database business logic
│   ├── arenaQuestions.sql        # Database queries for arena questions
│   ├── db.js                     # MySQL connection setup
│   ├── docker-compose.yml        # Docker service configuration (MySQL)
│   ├── schema.sql                # Database schema creation script
│   ├── seed-data.sql             # Initial database seed data
│   └── server.js                 # Express server entry point
└── frontend/
    ├── src/
    │   ├── assets/               # Global CSS & gaming design variables
    │   ├── components/           # UI components (ShieldTracker, BugvisionToggle, etc.)
    │   ├── composables/          # Vue composables (useBugHunting, useTrophies)
    │   ├── data/                 # Local mock fallback data (mockArenas, mockLessons)
    │   ├── router/               # Vue Router configuration
    │   ├── services/             # API integration & XP/Progress services
    │   └── views/                # Page Views (ArenaChoice, LessonView, ProfileView, etc.)
    ├── index.html
    └── vite.config.js
```

## 💻 Getting Started Locally

Follow these steps to get JavaQuest up and running on your local machine:

### Prerequisites
- [Node.js](https://nodejs.org/) (v18+)
- [Docker & Docker Desktop](https://www.docker.com/) *(recommended for running MySQL)*

---

### Step 1: Clone the Repository
```bash
    git clone https://github.com/eeebbaandersson/java-quest.git
    cd java-quest 
```

### Step 2: Set up the Backend & Database
1. Start the MySQL Docker container:
```bash
    cd backend
    docker compose up -d
```

### Initialize the Database:
Import the SQL scripts into your MySQL container (or local instance) in the following order:
- `schema.sql` (Creates database tables)
- `seed-data.sql` (Populates initial lessons & data)
- `arenaQuestions.sql` (Populates arena challenges)

Start the Backend Express server:
```bash
    npm install
    npm run dev
```

### Step 3: Start the Frontend Client
Open a new terminal window and run:
```bash
    cd frontend
    npm install
    npm run dev
```

Open http://localhost:5173/ in your browser to start playing!

--- 
## 👥 Contributors

<a href="https://github.com/eeebbaandersson/java-quest/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=eeebbaandersson/java-quest" alt="Contributors" />
</a>


