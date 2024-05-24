state_machine = [];

state_machine[player_state.stand] = function()
{
	handleSprite();
	handlePlayerMovementAndCollision();
	
	checkIfOpen();
	checkIfSwimming();
}

state_machine[player_state.swim] = function()
{
	handleSprite();
	handlePlayerMovementAndCollision();
	
	checkIfOpen();
	checkIfSwimming();
}

state_machine[player_state.open] = function()
{
	handleSprite();
	handlePlayerMovementAndCollision();
	
	checkIfOpen();
	checkIfSwimming();
}

state_machine[player_state.reverse] = function()
{
	
}

//Transition functions
///@func checkIfSwimming()
checkIfSwimming = function()
{
	if (input_open_held) {exit;}
	if (current_speed != 0) {state = player_state.swim;}
	else {state = player_state.stand;}
}

///@func checkIfOpen()
checkIfOpen = function()
{
	if (input_open_held) {state = player_state.open;}
}