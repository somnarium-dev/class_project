/// @description State Machine

// Inherit the parent event
event_inherited();

state_machine[consumable_state.swim] = function()
{	
	consumableHandlePathAcceleration();
	handleSprite();
	checkIfStill();
}

state_machine[consumable_state.still] = function()
{
	handleSprite();
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
			state = consumable_state.still;
			alarm[2] = 180;
		}
	}
}