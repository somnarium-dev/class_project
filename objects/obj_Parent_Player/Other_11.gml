state_machine = [];

state_machine[player_state.stand] = function()
{
	handleSprite();
	handlePlayerMovementAndCollision();
	
	checkNextStateAfterStanding();
}

state_machine[player_state.swim] = function()
{
	handleSprite();
	handlePlayerMovementAndCollision();
	
	checkNextStateAfterSwimming();
}

state_machine[player_state.open] = function()
{
	handleSprite();
	handlePlayerMovementAndCollision();
	
	checkNextStateAfterOpen();
}

state_machine[player_state.reverse] = function()
{
	handleSprite();
	handlePlayerMovementAndCollision();
	
	checkNextStateAfterReverse();
}

state_machine[player_state.eat] = function()
{
	handleSprite();
	handlePlayerMovementAndCollision();
	
	checkNextStateAfterEat();
}

state_machine[player_state.stun] = function()
{
	handleSprite();
	handlePlayerMovementAndCollision();
	
	checkNextStateAfterStun();
}

//Transition functions
///@func checkNextStateAfterStanding()
checkNextStateAfterStanding = function()
{
	if (input_open_held) { state = player_state.open; }
	else if (current_speed > 0) { state = player_state.swim; }
	else if (current_speed < 0) { state = player_state.reverse; }
}

///@func checkNextStateAfterSwimming()
checkNextStateAfterSwimming = function()
{
	if (input_open_held) { state = player_state.open; }
	else if (current_speed == 0) { state = player_state.stand; }
	else if (current_speed < 0) { state = player_state.reverse; }
}

///@func checkNextStateAfterOpen()
checkNextStateAfterOpen = function()
{
	if (eat_state_requested)
	{ 
		state = player_state.eat;
		eat_state_requested = false;
	}
	else if (stun_state_requested)
	{
		state = player_state.stun;
		stun_state_requested = false;
	}
	else if (current_speed < 0) { state = player_state.reverse; }
	else if (!input_open_held)
	{
		if (current_speed > 0) { state = player_state.swim; }
		else if (current_speed == 0) { state = player_state.stand; }
	}
}

///@func checkNextStateAfterReverse()
checkNextStateAfterReverse = function()
{
	if (current_speed == 0) { state = player_state.stand; }
	else if (current_speed > 0) { state = player_state.swim; }
}

///@func checkNextStateAfterEat()
checkNextStateAfterEat = function()
{
	if (eat_state_completed)
	{
		state = player_state.stand;
		eat_state_completed = false;
	}
}

///@func checkNextStateAfterStun()
checkNextStateAfterStun = function()
{
	if (stun_state_completed)
	{
		state = player_state.stand;
		stun_state_completed = false;
	}
}