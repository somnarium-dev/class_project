/// @description Behavior Machine

// Inherit the parent event
event_inherited();

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

behavior_machine[consumable_behavior.seeking_log] = function()
{
	//removeGrassFromCollisionIgnoreArrayWhenReady();
	
	checkIfPanicked();
	// If completely aligned with a tile, change direction as dictated below.
	if (alignedWithGrid())
	{
		// If the nearest log has been reached, clear the variable containing its id,
		// advance to the resting state, and stop moving towards the log.
		if (nearest_log != noone)
		&& (x == nearest_log_x)
		&& (y == nearest_log_y)
		{
			nearest_log = noone;
			behavior = consumable_behavior.resting; 
			moving_towards_log = false;
		}
			
		// Otherwise, continue to seek the nearest log.
		else { aiSeekLog(); }
	}
}


behavior_machine[consumable_behavior.resting] = function()
{
	//removeGrassFromCollisionIgnoreArrayWhenReady();
	
	// If completely aligned with a tile, change direction as dictated below.
	//if (alignedWithGrid())
	//{
		//alarm[2] = 180;
	//}
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
		collision_ignore_array = [obj_Parent_Log, obj_Parent_Rock, obj_Barrier_Grass];
		
		behavior = consumable_behavior.panic;
		alarm[0] = 90;
	}
}