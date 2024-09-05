/// @description Initialize variables and stats.

// Inherit the parent event
event_inherited();

state = consumable_state.swim;
previous_state = state;

behavior = consumable_behavior.roaming;

// Internal
nearest_log = noone;
nearest_log_centered_coordinates = { x:-1, y:-1 };
ready_to_exit_panicked_state = false;

current_pathfinding_grid = global.current_grid_controller.solid_grid;

moving_towards_log = false;

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

snapToGrid();