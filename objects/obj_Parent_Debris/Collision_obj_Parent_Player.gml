/// @description Insert description here
// You can write your code in this editor
if (other.state == player_state.stun)
{
	eaten_state_requested = true;
}
else
{
	//ai_input_accelerate = 1;
	current_speed = other.current_speed;
	direction = other.direction;
}