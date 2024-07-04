/// @description Initialize variables and stats.

// Inherit the parent event
event_inherited();

//set danger range
if (danger_range < 0)
{ danger_range = global.frog_default.danger_range; }

//Define frog sprites
frog_sprites = 
{
	land: sprite_land,
	swim: sprite_swim
}

sprite_index = frog_sprites.land;

// load custom functions and state code
event_user(0);
event_user(1);
event_user(2);