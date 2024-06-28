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
		// If the way forward is blocked, turn left or right- or turn around if that is impossible.
		// Otherwise, turn at random per variable definitions.
		var forward_is_blocked = testDirectionBlocked(direction);

		if (forward_is_blocked) { aiTurnWhenBlocked(); }
		else { aiTurnAtRandom(); }
	}
}