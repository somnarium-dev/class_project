/// @description state code
state_machine = [];

state_machine[fish_state.swim] = function()
{	
	handleFishMovementAndCollision();
	//handleFishFacing();
	
	checkIfPanicked();
	
}

state_machine[fish_state.still] = function()
{
	//handleFishFacing();
	handleFishMovementAndCollision();
	checkIfPanicked();
}

state_machine[fish_state.panic] = function()
{
	//handleFishFacing();
	handleFishMovementAndCollision();
	checkIfPanicked();
}

//=======================================================================================================
// state transition code
//=======================================================================================================

///@func checkIfPanicked()
checkIfPanicked = function()
{
	var nearest_player = instance_nearest(x, y, obj_Parent_Player);
	
	if (point_distance (x, y, nearest_player.x, nearest_player.y) < safe_range) 
	{
		state = fish_state.panic;
		alarm[0] = 90;
	}
}