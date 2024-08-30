///@desc Behavior Machine

behavior_machine = [];

behavior_machine[consumable_behavior.roaming] = function()
{
	consumableMockAiDirectionalMovement();
	consumableUpdateTargetCoords();
}