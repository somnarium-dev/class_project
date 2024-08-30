///@desc Behavior Machine
event_inherited();

behavior_machine[consumable_behavior.roaming] = function()
{
	removeGrassFromCollisionIgnoreArrayWhenReady();
	
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

behavior_machine[consumable_behavior.seeking_log] = function()
{
	removeGrassFromCollisionIgnoreArrayWhenReady();
	
	//Reset inputs.
	ai_input_accelerate = 1; // For now: Frog is always moving forward.
	ai_input_lr = 0;
	ai_input_panic_boost = 0;
	
	checkIfPanicked();
	// If completely aligned with a tile, change direction as dictated below.
	if (alignedWithGrid())
	{
		// If the nearest log has been reached, clear the variable containing its id
		// and advance to the resting state.
		if (nearest_log != noone)
		&& (x == nearest_log.x)
		&& (y == nearest_log.y)
		{
			nearest_log = noone;
			behavior = consumable_behavior.resting; 
		}
			
		// Otherwise, continue to seek the nearest log.
		else { aiSeekLog(); }
	}
}


behavior_machine[consumable_behavior.resting] = function()
{
	removeGrassFromCollisionIgnoreArrayWhenReady();
	
	//Reset inputs.
	ai_input_accelerate = 0; // For now: Frog is always moving forward.
	ai_input_lr = 0;
	ai_input_panic_boost = 0;
	
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