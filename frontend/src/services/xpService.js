const XP_KEY = 'javaquest_xp';

function getTotalXp() {
  const saved = localStorage.getItem(XP_KEY);
  return saved ? Number(saved) : 0;
}

function addXp(amount) {
  const newTotal = getTotalXp() + amount;
  localStorage.setItem(XP_KEY, newTotal);
  return newTotal;
}

export default { getTotalXp, addXp };