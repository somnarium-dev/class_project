/// @description Initialize variables and stats.

// Inherit the parent event
event_inherited();

// Set danger range.
if (danger_range < 0)
{ danger_range = global.fish_default.danger_range; }