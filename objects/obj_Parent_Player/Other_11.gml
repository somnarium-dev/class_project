state_machine = [];

state_machine[player_state.stand] = function()
{
	handlePlayerMovementAndCollision();
	checkIfSwimming();
}

state_machine[player_state.swim] = function()
{
	handlePlayerMovementAndCollision();
	checkIfSwimming();
}

state_machine[player_state.open] = function()
{
	handlePlayerMovementAndCollision();
}

state_machine[player_state.eat] = function()
{
	
}

//Transition functions
///@func checkIfSwimming()
checkIfSwimming = function()
{
	if (current_speed != 0) {state = player_state.swim;}
	else {state = player_state.stand;}
}