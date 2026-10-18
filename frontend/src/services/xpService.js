const XP_KEY = 'javaquest_xp';
const ANSWERED_KEY = 'javaquest_answered_questions';

function getAnsweredQuestions() {
  const saved = localStorage.getItem(ANSWERED_KEY);
  return saved ? JSON.parse(saved) : [];
}

function getTotalXp() {
  const saved = localStorage.getItem(XP_KEY);
  return saved ? Number(saved) : 0;
}

function addXp(questionId, amount) {
  const answered = getAnsweredQuestions();
  if (answered.includes(questionId)) {
    return getTotalXp();
  }

  const newTotal = getTotalXp() + amount;
  localStorage.setItem(XP_KEY, newTotal);
  answered.push(questionId);
  localStorage.setItem(ANSWERED_KEY, JSON.stringify(answered));
  return newTotal;
}

export default { getTotalXp, addXp };