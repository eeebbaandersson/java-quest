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
  } catch {
    // Keep the current in-memory state if persistence fails.
  }
}

const totalBugs = ref(5);

const capturedBugIds = ref(
  readStored("capturedBugIds", [], value =>
      Array.isArray(value) &&
      value.every(id => 
        Number.isInteger(id) && id >= 1 && id <= totalBugs.value,
      ) &&
      new Set(value).size === value.length,
  ),
);

const foundBugs = ref(capturedBugIds.value.length);

const totalXP = ref(
  readStored("totalXP", 0, value => 
    Number.isSafeInteger(value) && value >= 0
  )
);

const savedTheme = readStored(
  "theme",
  "default",
  (value) => value === "default" || value === "bug-vision",
  (raw) => raw,
);

const isBugVisionActive = ref(savedTheme === "bug-vision");

if (isBugVisionActive.value) {
  document.documentElement.setAttribute("data-theme", "bug-vision");
}

const defaultTrophies = [
  {
    id: 1,
    title: "Bug Hunter",
    description: "Captured all bugs hidden in the interface",
    isUnlocked: false,
    icon: "bug",
  }
];

const trophies = ref(
  readStored("trophies", defaultTrophies, value =>
      Array.isArray(value) &&
      value.some(trophy => trophy?.id === 1) &&
      value.every(trophy =>
          trophy !== null &&
          typeof trophy === "object" &&
          Number.isInteger(trophy.id) &&
          typeof trophy.title === "string" &&
          typeof trophy.description === "string" &&
          typeof trophy.isUnlocked === "boolean" &&
          typeof trophy.icon === "string",
      )
  )
);

const bugHunterTrophy = trophies.value.find(trophy => trophy.id === 1);

if (bugHunterTrophy) {
  bugHunterTrophy.isUnlocked =
    capturedBugIds.value.length >= totalBugs.value;
}

export function useBugHunting() {
const setBugVision = (active) => {
    isBugVisionActive.value = active;

    if (active) {
      document.documentElement.setAttribute("data-theme", "bug-vision");
    } else {
      document.documentElement.removeAttribute("data-theme");
    }

    writeStored("theme", active ? "bug-vision" : "default", String);
  };

  const captureBug = (bugId) => {
    if (!capturedBugIds.value.includes(bugId)) {
      capturedBugIds.value.push(bugId);
      foundBugs.value = capturedBugIds.value.length;
      totalXP.value += 25;

      if (foundBugs.value >= totalBugs.value) {
        const bugHunterTrophy = trophies.value.find((t) => t.id === 1);
        if (bugHunterTrophy) {
          bugHunterTrophy.isUnlocked = true;
        }
      }

      writeStored('capturedBugIds', capturedBugIds.value);
      writeStored('totalXP', totalXP.value);
      writeStored('trophies', trophies.value);

      return true;
    }
    return false;
  };

  const isBugCaptured = (bugId) => {
    return capturedBugIds.value.includes(bugId);
  };

  return {
    totalBugs,
    foundBugs,
    totalXP,
    isBugVisionActive,
    setBugVision,
    trophies,
    captureBug,
    isBugCaptured,
  };
}
