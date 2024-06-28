/// @description state code
state_machine = [];

state_machine[frog_state.swim] = function()
{	
	handleSprite();
	
	readFrogInput();
	
	handleFrogMovementAndCollision();
	
}

state_machine[frog_state.still] = function()
{
	handleSprite();
	
	readFrogInput();
	
	handleFrogMovementAndCollision();
}

//=======================================================================================================
// state transition code
//=======================================================================================================
