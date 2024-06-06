/// @desc Level state machine

state_machine = [];

// loading
state_machine[0] = function()
{
	loadLevelData();
	createHUD();
	
	state = 1;
}
// level in progress
state_machine[1] = function()
{
	checkLevelCompletion();
}
// level complete
state_machine[2] = function()
{
	handleLevelCompletion();
}
// level failed
state_machine[3] = function()
{
	handleLevelFailure();
}
// level paused
state_machine[4] = function()
{
	
}