///MOVEMENT AND DECELERATION
///@func handleTwigMovementAndCollision()
handleTwigMovementAndCollision = function()
{
	determineTopSpeed();	
	
	handleAcceleration();
	
	handleHorizontalPixelAccumulation();
	handleVerticalPixelAccumulation();
	
	handleHorizontalMovement();
	handleVerticalMovement();
}