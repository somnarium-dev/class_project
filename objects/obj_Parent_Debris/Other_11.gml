state_machine = [];

state_machine[twig_state.still] = function()
{
	handleTwigMovementAndCollision();
	
	checkNextStateAfterStill();
}

state_machine[twig_state.move] = function()
{
	handleTwigMovementAndCollision();
	
	checkNextStateAfterMove();
}

state_machine[twig_state.eaten] = function()
{
	handleTwigMovementAndCollision();
	
	endEatenState();
}

//Transition functions
///@func checkNextStateAfterStill()
checkNextStateAfterStill = function()
{
	if (current_speed != 0) { state = twig_state.move; }
	else if (eaten_state_requested)
	{
		state = twig_state.eaten;
		eaten_state_requested = false;
	}
}

///@func checkNextStateAfterMove()
checkNextStateAfterMove = function()
{
	if (current_speed == 0) { state = twig_state.still; }
	else if (eaten_state_requested) 
	{
		state = twig_state.eaten;
		eaten_state_requested = false;
	}
}
	
///@func endEatenState()
endEatenState = function()
{
	instance_destroy(); //Kill yourself, NOW
}