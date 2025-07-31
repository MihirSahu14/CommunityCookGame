// Child object: Define the dialogue blocks and handle text advancement

// Inherit from the parent first (copies the parent's Create Event)
event_inherited();

// Define the lines you want for this specific dialog, grouped into blocks of 6 lines each
dialog_blocks = [
    [
        "You're the new one, huh? Heard they're sending someone to run the food pantry. Thought they'd given up on this town.",
        "A traveler came in once, same as you. They looked at the city... saw nothing but ruins. But they didn't turn away.",
        "You've got three days to prove this town still has a chance—to feed, to care, to rebuild.",
        "The pantry's all we've got left now. It's up to you to make something of it... or this town won’t survive much longer.",
        "Press ENTER to continue"

    ],
	[
        "Start by checking the Help Guide it's in the bottom left corner of the kitchen.",
        "Learn the stations, manage your time, and cook what this community truly needs.",
        "We may not have much, but we've still got heart. Now go on, Chef. They're counting on you.",
        "Press ENTER to begin your first day."	
    ],
];

// Optionally, you can reset variables if you like
dialog_index = 0;  // Start from the first block
dialog_done = false;