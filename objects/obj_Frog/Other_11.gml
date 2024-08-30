/// @description State Machine.
event_inherited();

state_machine[consumable_state.swim] = function()
{	
	handleSprite();
	readVirtualInput();
	handleMovementAndCollision();
	checkIfStill();
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

///@func checkIfStill()
checkIfStill = function()
{
	if (behavior == consumable_behavior.resting)
	{
		if (alignedWithGrid())
		&& (instance_place(x, y, obj_Parent_Barrier))
		{
			show_debug_message("yes")
			state = consumable_state.still;
			alarm[2] = 180;
		}
	}
}