if (other.state == player_state.open)
{
	global.increase_score();
	instance_destroy(self);
}