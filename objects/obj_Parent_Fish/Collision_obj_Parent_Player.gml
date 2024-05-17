if (other.state == player_state.open)
{
	global.increaseScore();
	instance_destroy(self);
}