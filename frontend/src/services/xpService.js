import { ref } from "vue";

const XP_KEY = 'javaquest_xp';
const ANSWERED_KEY = 'javaquest_answered_questions';

const LEVELS = [
  { level: 1, name: "Novice", minXP: 0 },
  { level: 2, name: "Challenger", minXP: 300 },
  { level: 3, name: "Java Master", minXP: 600 },
];

function getAnsweredQuestions() {
  try {
    const parsed = JSON.parse(localStorage.getItem(ANSWERED_KEY));
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
}

function readStoredXp() {
  try {
    const value = Number(localStorage.getItem(XP_KEY));
    return Number.isFinite(value) ? value : 0;
  } catch {
    return 0;
  }
}

const totalXP = ref(readStoredXp());

function getTotalXp() {
  return totalXP.value;
}

function addXp(questionId, amount) {
  if (!Number.isFinite(amount) || amount <= 0) {
    return getTotalXp();
  }

  const answered = getAnsweredQuestions();
  if (answered.includes(questionId)) {
    return getTotalXp();
  }

  const newTotal = getTotalXp() + amount;
  try {
    answered.push(questionId);
    localStorage.setItem(ANSWERED_KEY, JSON.stringify(answered));
    localStorage.setItem(XP_KEY, newTotal);
  } catch {
    return getTotalXp();
  }
  totalXP.value = newTotal;
  return newTotal;
}

function addPoints(amount) {
  if (!Number.isFinite(amount) || amount <= 0) {
    return false;
  }

  const newTotal = getTotalXp() + amount;
  try {
    localStorage.setItem(XP_KEY, newTotal);
  } catch {
    return false;
  }
  totalXP.value = newTotal;
  return true;
}

function getLevel(xp) {
  let current = LEVELS[0];
  for (const l of LEVELS) {
    if (xp >= l.minXP) {
      current = l;
    }
  }
  return current;
}

export default { getTotalXp, addXp, addPoints, getLevel, LEVELS, totalXP };