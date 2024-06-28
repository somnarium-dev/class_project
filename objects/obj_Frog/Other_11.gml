/// @description State Machine.
event_inherited();

state_machine[consumable_state.swim] = function()
{	
	handleSprite();
	readVirtualInput();
	handleMovementAndCollision();
}

state_machine[consumable_state.still] = function()
{
	handleSprite();
	readVirtualInput();
	handleMovementAndCollision();
}

//=======================================================================================================
// state transition code
//=======================================================================================================
