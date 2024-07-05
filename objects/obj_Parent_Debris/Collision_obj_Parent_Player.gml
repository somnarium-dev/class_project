if (other.state == player_state.stun)
{
	eaten_state_requested = true;
}
else
{
	current_speed = other.current_speed;
	direction = other.direction;
}