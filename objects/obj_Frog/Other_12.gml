///@desc Behavior Machine
event_inherited();

behavior_machine[consumable_behavior.seeking_log] = function()
{
	//Reset inputs.
	ai_input_accelerate = 1; // For now: Frog is always moving forward.
	ai_input_lr = 0;
	ai_input_panic_boost = 0;
	
	checkIfPanicked()
	
	// If completely aligned with a tile, change direction as dictated below.
	if (alignedWithGrid())
	{
		aiSeekLog();
	}
}

behavior_machine[consumable_behavior.seeking_grass] = function()
{
	//Reset inputs.
	ai_input_accelerate = 1; // For now: Frog is always moving forward.
	ai_input_lr = 0;
	ai_input_panic_boost = 0;
	
	checkIfPanicked()
	
	// If completely aligned with a tile, change direction as dictated below.
	if (alignedWithGrid())
	{
		aiSeekLog(); //to be altered to grass later once aiseeklog is working perfectly.
	}
}

behavior_machine[consumable_behavior.resting] = function()
{
	//Reset inputs.
	ai_input_accelerate = 0; // For now: Frog is always moving forward.
	ai_input_lr = 0;
	ai_input_panic_boost = 0;
	
	// If completely aligned with a tile, change direction as dictated below.
	if (alignedWithGrid())
	{
		alarm[2] = 90;
	}
}
//=======================================================================================================
// behavior transition code
//=======================================================================================================

///@func checkIfPanicked()
checkIfPanicked = function()
{
	var nearest_player = instance_nearest(x, y, obj_Parent_Player);
	
	if (point_distance(x, y, nearest_player.x, nearest_player.y) < danger_range) 
	{
		process_collision_detection = false;
		behavior = consumable_behavior.panic;
		alarm[0] = 90;
	}
}