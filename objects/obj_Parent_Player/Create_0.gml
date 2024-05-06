/*
Improve movement - implement momentum, turning
Collision detection
Sprite facing
Mouth opening + speed change
Eating
*/
/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//Custom Methods and State Machine.
event_user(0);
event_user(1);

//Controls
input_direction = 0;

generate_standard_inputs();

readPlayerInput();

//Movement and Collision
current_top_speed = global.player_1.max_speed;
current_speed = 0;

//Define player sprites
player_sprites = 
{
	idle: spr_Croc_Idle,
	open: spr_Croc_Open_Mouth,
	eat: spr_Croc_Eat
}

//Initialize
state = player_state.stand;
