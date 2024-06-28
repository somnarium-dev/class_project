///@desc Behavior Machine

behavior_machine = [];

behavior_machine[consumable_behavior.roaming] = function()
{
	//Reset inputs.
	ai_input_accelerate = 1; // For now: Always moving forward.
	ai_input_lr = 0;
	ai_input_panic_boost = 0;
	
	checkIfPanicked()
	
	// If completely aligned with a tile, change direction as dictated below.
	if (alignedWithGrid())
	{
		// If the way forward is blocked, turn left or right- or turn around if that is impossible.
		// Otherwise, turn at random per variable definitions.
		var forward_is_blocked = testDirectionBlocked(direction);

		if (forward_is_blocked) { aiTurnWhenBlocked(); }
		else { aiTurnAtRandom(); }
	}
}

behavior_machine[consumable_behavior.panic] = function()
{
	//Reset inputs.
	ai_input_accelerate = 1; // For now: Always moving forward.
	ai_input_lr = 0;
	ai_input_panic_boost = 1;
	
	// If completely aligned with a tile, change direction as dictated below.
	if (alignedWithGrid())
	{
		// If the way forward is blocked, turn left or right- or turn around if that is impossible.
		// Otherwise, turn at random per variable definitions.
		var forward_is_blocked = testDirectionBlocked(direction);

		if (forward_is_blocked) { aiTurnWhenBlocked(); }
		else { aiTurnAtRandom(); }
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
		behavior = consumable_behavior.panic;
		alarm[0] = 90;
	}
}
