/// @desc Level state machine

state_machine = [];

// Loading
state_machine[level_state.loading] = function()
{
	loadLevelData();
	createHUD();
	
	state = level_state.in_progress;
}

// Level In Progress
state_machine[level_state.in_progress] = function()
{
	toggleLevelPause();
	checkLevelCompletion(); 
}

// Level Complete
state_machine[level_state.complete] = function()
{ handleLevelCompletion(); }

// Level Failed
state_machine[level_state.failed] = function()
{ handleLevelFailure(); }

// Level Paused
state_machine[level_state.paused] = function()
{ toggleLevelPause(); }