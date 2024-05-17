///@desc ai behavior machine

behavior_machine = [];

behavior_machine[fish_behavior.roaming] = function()
{
	ai_input_lr = irandom(2) - 1;
	ai_input_accelerate = 1;
}