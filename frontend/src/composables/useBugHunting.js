import { ref } from 'vue';

const totalBugs = ref(5);

const capturedBugIds = ref(
    localStorage.getItem('capturedBugIds')
    ? JSON.parse(localStorage.getItem('capturedBugIds'))
    : []
);
const foundBugs = ref(capturedBugIds.value.length);

const totalXP = ref(localStorage.getItem('totalXP') ? parseInt(localStorage.getItem('totalXP')) : 0);

// Kontrollera theme vid start
const savedTheme = localStorage.getItem('theme');
const isBugVisionActive = ref(savedTheme === 'bug-vision');


if (savedTheme === 'bug-vision') {
    document.documentElement.setAttribute("data-theme", "bug-vision");
}

const trophies = ref(
    localStorage.getItem('trophies')
    ? JSON.parse(localStorage.getItem('trophies'))
    : [
        {id: 1, title: "Bug Hunter", description: "Captured all bugs hidden in the interface", isUnlocked: false, icon: "bug",}
    ]
)

export function useBugHunting() {
    const setBugVision = (active) => {
        isBugVisionActive.value = active;
        if (active) {
            document.documentElement.setAttribute("data-theme", "bug-vision");
            localStorage.setItem("theme", "bug-vision");
        } else {
            document.documentElement.removeAttribute("data-theme");
            localStorage.setItem("theme", "default");
        }
    };

    const captureBug = (bugId) => {
        if (!capturedBugIds.value.includes(bugId)) {
            capturedBugIds.value.push(bugId);
            foundBugs.value = capturedBugIds.value.length;
            totalXP.value += 25;

            if (foundBugs.value >= totalBugs.value) {
                const bugHunterTrophy = trophies.value.find(t => t.id === 1);
                if (bugHunterTrophy) {
                    bugHunterTrophy.isUnlocked = true;
                }
            }

            localStorage.setItem('capturedBugIds', JSON.stringify(capturedBugIds.value));
            localStorage.setItem('totalXP', totalXP.value);
            localStorage.setItem('trophies', JSON.stringify(trophies.value));

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
        isBugCaptured
    };
}