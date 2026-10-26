const PROGRESS_KEYS = [
  'javaquest_xp',
  'javaquest_answered_questions',
  'capturedBugIds',
  'trophies',
  'completed_lessons',
];

function resetProgress() {
  try {
    for (const key of PROGRESS_KEYS) {
      localStorage.removeItem(key);
    }
    return true;
  } catch {
    return false;
  }
}

export default { resetProgress };