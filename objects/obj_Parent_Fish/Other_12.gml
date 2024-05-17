///@desc ai behavior machine

behavior_machine = [];

behavior_machine[fish_behavior.roaming] = function()
{
	//Reset inputs.
	ai_input_accelerate = 1; // For now: Fish are always moving forward.
	ai_input_lr = 0;
	
	// If completely aligned with a tile, change direction as dictated below.
	if (alignedWithGrid())
	{
		// If the way forward is blocked, turn left or right- or turn around if that is impossible.
		// Otherwise, turn at random per variable definitions.
		var forward_is_blocked = testFishDirectionBlocked(direction);

		if (forward_is_blocked) { aiFishTurnWhenBlocked(); }
		else { aiFishTurnAtRandom(); }
	}
}