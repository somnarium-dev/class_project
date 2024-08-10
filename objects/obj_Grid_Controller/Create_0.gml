// Update the current grid controller to this id.
global.current_grid_controller = id;

// Create the full grid.
// The full grid is every space within the room. It does not have exclusions.
// This grid is used for the movement of frogs and flying consumables.
full_grid = mp_grid_create
(
	0, 
	0, 
	room_width / global.game_tile_size, 
	room_height / global.game_tile_size, 
	global.game_tile_size, 
	global.game_tile_size
);

// Create the solid grid.
// The solid grid marks trees, rocks, and grass as forbidden.
solid_grid = mp_grid_create
(
	0, 
	0, 
	room_width / global.game_tile_size, 
	room_height / global.game_tile_size, 
	global.game_tile_size, 
	global.game_tile_size
);

// Add only impassable objects to the grid.
for (var i = 0; i < instance_number(obj_Parent_Collision); i++)
{
	var this_instance = instance_find(obj_Parent_Collision, i);
	
	if (this_instance.impassable)
	{ mp_grid_add_instances(solid_grid, this_instance, true); }
}

