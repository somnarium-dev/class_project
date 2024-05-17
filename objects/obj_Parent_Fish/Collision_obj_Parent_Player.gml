if (other.state == player_state.open)
{
	global.increaseScore(point_value);
	instance_destroy();
}