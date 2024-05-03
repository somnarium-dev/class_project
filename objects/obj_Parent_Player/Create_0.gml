/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//Custom Methods and State Machine.
event_user(0);
event_user(1);

//Controls
generate_standard_inputs();

readPlayerInput();

//Define player sprites
player_sprites = 
{
	idle: spr_Croc_Idle,
	open: spr_Croc_Open_Mouth,
	eat: spr_Croc_Eat
}

//Initialize
state = player_state.stand;
