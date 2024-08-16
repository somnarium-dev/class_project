handlePauseTransition();

if (is_paused) { return; }

behavior_machine[behavior]();
state_machine[state]();