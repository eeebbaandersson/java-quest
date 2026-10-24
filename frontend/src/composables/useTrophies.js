import { ref } from "vue";

function readStored(key, fallback, validate, parse = JSON.parse) {
  try {
    const raw = localStorage.getItem(key);
    if (raw === null) return fallback;

    const value = parse(raw);
    return validate(value) ? value : fallback;
  } catch {
    // Storage is unavailable, or the saved value cannot be parsed.
    return fallback;
  }
}

function writeStored(key, value, serialize = JSON.stringify) {
  try {
    localStorage.setItem(key, serialize(value));
    return true;
  } catch {
    // Keep the current in-memory state if persistence fails.
    return false;
  }
}

const defaultTrophies = [
  { id: 1, title: "Explorer", description: "Completed your first quest!", isUnlocked: false, icon: "compass" },
  { id: 2, title: "Bug Hunter", description: "Captured all bugs hidden in the interface.", isUnlocked: false, icon: "bug" },
  { id: 3, title: "Syntax Ninja", description: "Completed 3 quests.", isUnlocked: false, icon: "ninja" },
  { id: 4, title: "Novice", description: "Conquered the Easy Arena.", isUnlocked: false, icon: "helmet" },
  { id: 5, title: "Java Master", description: "Completed all quests.", isUnlocked: false, icon: "kungfu" },
  { id: 6, title: "Challenger", description: "Conquered the Medium Arena.", isUnlocked: false, icon: "helmet2" },
  { id: 7, title: "Hero", description: "Conquered the Hard Arena.", isUnlocked: false, icon: "helmet3" },
];

const trophies = ref(
  readStored("trophies", defaultTrophies, value =>
    Array.isArray(value) &&
    value.every(trophy =>
      trophy !== null &&
      typeof trophy === "object" &&
      Number.isInteger(trophy.id) &&
      typeof trophy.title === "string" &&
      typeof trophy.description === "string" &&
      typeof trophy.isUnlocked === "boolean" &&
      typeof trophy.icon === "string"
    )
  )
);

 const getCompletedLessonCount = () => {
    let lessonCompleted = {};
    try {
      const parsed = JSON.parse(localStorage.getItem("completed_lessons") || "{}");
      if (parsed && typeof parsed === "object") {
        lessonCompleted = parsed;
      }
    } catch (error) {
      console.warn("Could not read completed_lessons from localStorage", error);
    }
   
    const lessonKeys = [
      "variables",
      "operators",
      "ifelse",
      "loops",
      "arrays",
      "methods",
      "classes",
    ];

    return lessonKeys.filter(key => Boolean(lessonCompleted[key])).length;
  };

export function useTrophies() {

  const completedCount = getCompletedLessonCount();
  
  const explorerTrophy = trophies.value.find(t => t.id === 1);
  if (explorerTrophy) explorerTrophy.isUnlocked = completedCount >= 1;

  const ninjaTrophy = trophies.value.find(t => t.id === 3);
  if (ninjaTrophy) ninjaTrophy.isUnlocked = completedCount >= 3;

  const masterTrophy = trophies.value.find(t => t.id === 5);
  if (masterTrophy) masterTrophy.isUnlocked = completedCount >= 7;

  // Function to trigger the Bug Hunter trophy
  const checkBugHunter = (foundBugs, totalBugs) => {
    const bugTrophy = trophies.value.find(t => t.id === 2);
    if (bugTrophy && foundBugs >= totalBugs) {
      bugTrophy.isUnlocked = true;
      writeStored("trophies", trophies.value);
    }
  };

  return {
    trophies,
    checkBugHunter,
  };
}
