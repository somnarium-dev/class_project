if (sprite_index == player_sprites.eat)
{ 
	if (state == player_state.eat) { eat_state_completed = true; }
	if (state == player_state.stun) { stun_state_completed = true; }
}