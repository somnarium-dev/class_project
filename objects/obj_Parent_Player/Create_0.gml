/*
Collision detection
Mouth opening + speed change

Movement Mechanics:
Have to move to turn - able to reverse
*/

// Inherit the parent event
event_inherited();

//Custom Methods and State Machine.
event_user(0);
event_user(1);

//Movement and Collision
current_top_speed = global.player_1.max_speed;
current_speed = 0;

horizontal_pixels_accumulated = 0;
vertical_pixels_accumulated = 0;

horizontal_pixels_queued = 0;
vertical_pixels_queued = 0;

//Define player sprites
player_sprites = 
{
	idle: sprite_idle,
	open: sprite_open,
	eat: sprite_eat,
	stun: sprite_stun
}

sprite_index = player_sprites.idle;

//State control flags
eat_state_requested = false;
eat_state_completed = false;
stun_state_requested = false;
stun_state_completed = false;

//Initialize
state = player_state.stand;
image_speed = 0;

switch (player_index)
{
	case 1:
		global.player_1.current_id = id;
		break;
}

//Controls
input_direction = 0;
requested_turn = 0;
last_turn_cell = {_x:-1, _y:-1};

generate_standard_inputs();

readPlayerInput();