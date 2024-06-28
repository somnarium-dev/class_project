///@desc State Machine

state_machine = [];

state_machine[consumable_state.swim] = function()
{	
	readVirtualInput();
	handleMovementAndCollision();
}

state_machine[consumable_state.still] = function()
{
	readVirtualInput();
	handleMovementAndCollision();
}