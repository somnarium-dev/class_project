/// @description variables and stats

// Inherit the parent event
event_inherited();

//Simulated Inputs
ai_input_lr = 0;
ai_input_ud = 0;

ai_input_accelerate = 0;

//Movement and collision detection.
horizontal_pixels_accumulated = 0;
horizontal_pixels_queued = 0;

vertical_pixels_accumulated = 0;
vertical_pixels_queued = 0;

current_speed = 0;

//stats
current_top_speed = max_swim_speed;

//internal properties
direction = initial_direction;

// impassable check
impassable = false;

//state handling
state = fish_state.swim;

//behavior handling
behavior = fish_behavior.roaming;

// load custom functions and state code
event_user(0);
event_user(1);
event_user(2);