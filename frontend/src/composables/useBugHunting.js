import { ref } from "vue";
import xpService from "@/services/xpService";
import { useTrophies } from "@/composables/useTrophies";

const { checkBugHunter } = useTrophies();

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

const totalXP = xpService.totalXP;

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

if (foundBugs.value >= totalBugs.value) {
  checkBugHunter(foundBugs.value, totalBugs.value);
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

      if (!writeStored('capturedBugIds', capturedBugIds.value)) {
        capturedBugIds.value.pop();
        foundBugs.value = capturedBugIds.value.length;
        return false;
      }

      xpService.addPoints(25);

      if (foundBugs.value >= totalBugs.value) {
       checkBugHunter(foundBugs.value, totalBugs.value);
      }

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
    captureBug,
    isBugCaptured,
  };
}
