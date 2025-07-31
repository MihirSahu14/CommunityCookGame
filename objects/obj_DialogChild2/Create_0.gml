// Inherit parent logic
event_inherited();

// Calculate totals
var good = global.npc_reactions.Good;
var neutral = global.npc_reactions.Neutral;
var bad = global.npc_reactions.Bad;

var total = good + neutral + bad;

// Decide the message
var message = "";

if (total > 0) {
    if (good / total >= 0.8) {
        message = "Great job, Chef!Everyone loved the food today.You’ve made a real difference.";
    } else if (good / total >= 0.5) {
        message = "Not bad...Some folks were satisfied,but others needed more care.";
    } else {
        message = "You tried your best...But many didn't get what they needed.Let’s do better tomorrow.";
    }
} else {
    message = "No one was served today.\nLet’s work harder tomorrow.";
}

// Add message as your dialog block
dialog_blocks = [
    ["Results",
	"Good Reactions: " + string(good),
    "Neutral Reactions: " + string(neutral),
    "Bad Reactions: " + string(bad),
	"Press Enter to Continue"
	],
	[message,
	"",
	"Press Enter to Continue to the next Day"],
];

// Reset progression
dialog_index = 0;
dialog_done = false;
