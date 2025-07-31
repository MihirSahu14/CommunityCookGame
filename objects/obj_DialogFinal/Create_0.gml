// Inherit parent dialog logic
event_inherited();

// Pull in reaction stats
var good = global.npc_reactions.Good;
var neutral = global.npc_reactions.Neutral;
var bad = global.npc_reactions.Bad;
var total = good + neutral + bad;

// Narrative reflection based on performance
var message = "";

if (total > 0) {
    if (good / total >= 0.8) {
        message = "Great job, Chef!Everyone loved the food today.You’ve made a real difference.";
    } else if (good / total >= 0.5) {
        message = "Not bad...Some folks were satisfied,but others needed more care.";
    } else {
        message = "You tried your best...But many didn't get what they needed.";
    }
} else {
    message = "No one was served today.";
}

// Add message as your dialog block
dialog_blocks = [
    [	
		"Results",
		"Good Reactions: " + string(good),
	    "Neutral Reactions: " + string(neutral),
	    "Bad Reactions: " + string(bad),
		"Press Enter to Continue"
	],
	[
		message,
		"",
		"Press Enter to Continue"
	],
	[
        "Three long days have passed in the dust and silence...And yet, your cooking spoke louder than words ever could.",
        "Every meal you served — warm or burned — carried hope. Some hearts were healed, some were simply held together.",
        "Thank you, Chef. For reminding us we’re still human.",
		"Press Enter to finish your journey."
    ]
];

// Start dialog state
dialog_index = 0;
dialog_done = false;
