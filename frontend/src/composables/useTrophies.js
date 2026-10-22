import { computed, ref } from "vue";
import { useBugHunting } from "@/composables/useBugHunting";

export function useTrophies() {
  const { trophies: bugHuntingTrophies } = useBugHunting();

  const getCompletedLessonCount = () => {
    let lessonCompleted = {};
    try {
      const parsed = JSON.parse(
        localStorage.getItem("completed_lessons") || "{}",
      );
      if (parsed && typeof parsed === "object") {
        lessonCompleted = parsed;
      }
    } catch (error) {
      console.warn("Could not read completed_lessons from localStorage", error);
    }

    // Returns the amount of true/completed lessons
    return Object.values(lessonCompleted).filter(Boolean).length;
  };

  const trophies = computed(() => {
    const completedCount = getCompletedLessonCount();

    return [
      {
        id: 1,
        title: "Explorer",
        description: "Completed your first quest!",
        isUnlocked: completedCount >= 1,
        icon: "compass",
      },
      {
        id: 2,
        title: "Bug Hunter",
        description: "Captured all bugs hidden in the interface",
        isUnlocked: bugHuntingTrophies.value.find((trophy) => trophy.id === 1) ?.isUnlocked ?? false,
        icon: "bug",
      },
      {
        id: 3,
        title: "Syntax Ninja",
        description: "Completed 3 quests",
        isUnlocked: completedCount >= 3,
        icon: "ninja",
      },
      {
        id: 4,
        title: "Novice",
        description: "Conquered the Easy Arena",
        isUnlocked: false,
        icon: "helmet",
      },
      {
        id: 5,
        title: "Java Master",
        description: "Completed all quests",
        isUnlocked: completedCount >= 7,
        icon: "kungfu",
      },
      {
        id: 6,
        title: "Challenger",
        description: "Conquered the Medium Arena",
        isUnlocked: false,
        icon: "helmet2",
      },
      {
        id: 7,
        title: "Hero",
        description: "Conquered the Hard Arena",
        isUnlocked: false,
        icon: "helmet3",
      },
    ];
  });

  return {
    trophies,
  };
}
