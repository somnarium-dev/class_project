/// @description state code
state_machine = [];

state_machine[fish_state.swim] = function()
{	
	readFishInput();
	
	handleFishMovementAndCollision();
	
}

state_machine[fish_state.still] = function()
{
	readFishInput();
	
	handleFishMovementAndCollision();
}

//=======================================================================================================
// state transition code
//=======================================================================================================
