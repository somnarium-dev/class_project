// Inherit the parent event
event_inherited();

// Simulated Inputs
ai_input_lr = 0;
ai_input_ud = 0;

ai_input_accelerate = 0;

//Custom Methods and State Machine.
event_user(0);
event_user(1);

//Movement and Collision
current_top_speed = global.player_1.max_speed * .5; //placeholder
current_speed = 0;

//TODO: Decouple from player stats
accel_rate = global.player_1.accel_rate * .5;
decel_rate = global.player_1.decel_rate;

horizontal_pixels_accumulated = 0;
vertical_pixels_accumulated = 0;

horizontal_pixels_queued = 0;
vertical_pixels_queued = 0;

//Define debris sprites
sprites = 
{
	still: sprite_still,
	move: sprite_move,
	eaten: sprite_eaten,
}

sprite_index = sprites.still;

//State control flags
eaten_state_requested = false;

//Initialize
state = twig_state.still;
image_speed = 0;