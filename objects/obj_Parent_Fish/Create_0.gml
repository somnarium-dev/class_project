/// @description Initialize variables and stats.

// Inherit the parent event
event_inherited();

//set danger range
if (danger_range < 0)
{ danger_range = global.fish_default.danger_range; }

// Set initial sprite.
sprite_index = fish_sprite;

// load custom functions and state code
event_user(0);
event_user(1);
event_user(2);