///@desc Handle being eaten.
if (other.state == player_state.open)
{
	global.increaseScore(point_value);
	PointsNotificationDisplay(point_value);
	instance_destroy();
}