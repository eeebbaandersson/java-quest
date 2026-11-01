const PROGRESS_KEYS = [
  'javaquest_xp',
  'javaquest_answered_questions',
  'capturedBugIds',
  'trophies',
  'completed_lessons',
  'arena-stage-1-completed',
  'arena-stage-2-completed',
  'arena-stage-3-completed',
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