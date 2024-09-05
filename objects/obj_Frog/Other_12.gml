/// @description Behavior Machine

// Inherit the parent event
event_inherited();

behavior_machine[consumable_behavior.roaming] = function()
{	
	checkIfPanicked();
	
	if (alignedWithGrid())
	{ 
		resetGridWhenInWater();

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
		&& (x == nearest_log_centered_coordinates.x)
		&& (y == nearest_log_centered_coordinates.y)
		{
			nearest_log = noone;
			behavior = consumable_behavior.resting;
			show_debug_message("i am at rest");
			alarm[2] = 180;
			moving_towards_log = false;
		}
			
		// Otherwise, continue to seek the nearest log.
		else { aiSeekLog(); }
	}
}

behavior_machine[consumable_behavior.resting] = function()
{
	snapToGrid();
	//frog gets a break, waits for alarm to end.
}

behavior_machine[consumable_behavior.panic] = function()
{
	checkIfPanicked();
	
	// If completely aligned with a tile, change direction as dictated below.
	if (alignedWithGrid())
	{	
		if (ready_to_exit_panicked_state)
		{ 
			behavior = consumable_behavior.seeking_log; 
			ready_to_exit_panicked_state = false;
			exit;
		}
		
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
	&& (alignedWithGrid())
	{	
		behavior = consumable_behavior.panic;
		
		current_pathfinding_grid = global.current_grid_controller.full_grid;
		
		alarm[1] = panic_state_cooldown;
	}
}