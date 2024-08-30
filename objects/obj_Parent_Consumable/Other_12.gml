///@desc Behavior Machine

behavior_machine = [];

behavior_machine[consumable_behavior.roaming] = function()
{	
	checkIfPanicked();
	
	if (alignedWithGrid())
	{ 
		var was_blocked = aiTurnWhenBlocked();
		if (!was_blocked) { aiTurnAtRandom(); }
		consumableRequestNextCellInIntendedDirection();
		consumableUpdateTargetCoords();
	}
}

behavior_machine[consumable_behavior.panic] = function()
{
	checkIfPanicked();
	
	// If completely aligned with a tile, change direction as dictated below.
	if (alignedWithGrid())
	{
		// If the way forward is blocked, turn left or right- or turn around if that is impossible.
		// Otherwise, turn at random per variable definitions.
		var was_blocked = aiTurnWhenBlocked();
		if (!was_blocked) { aiTurnAtRandom(); }
		consumableRequestNextCellInIntendedDirection();
		consumableUpdateTargetCoords();
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
		alarm[1] = panic_state_cooldown;
	}
}
