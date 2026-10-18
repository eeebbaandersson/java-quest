const XP_KEY = 'javaquest_xp';

function getTotalXp() {
  const saved = localStorage.getItem(XP_KEY);
  return saved ? Number(saved) : 0;
}

export default { getTotalXp };