if (other.state == player_state.open)
{
	global.increaseScore(point_value);
	PointsNotificationDisplay(5);
	instance_destroy();
	// points display to go here
}