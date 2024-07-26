/// @description Initialize variables and stats.

// Inherit the parent event
event_inherited();

previous_state = state;

// Internal
collision_ignore_array = [obj_Parent_Log, obj_Parent_Rock];
check_direction = 0;

nearest_log = noone;

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