// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LightsenInitialize()
{
		global.frog_default = 
	{	
		danger_range: 96,
	}
	
	enum frog_state
	{	
		still,
		swim,
		eaten
	}
	
	//-------------------------
	// BEHAVIOR ENUMS
	//-------------------------

	enum frog_behavior
	{
		roaming,
		seeking_log,
		panic
	}
	
	//-------------------------
	// STATE STRING ARRAYS
	//-------------------------

	global.state_string.frog = 
	[
		"still",
		"swim",
		"eaten"
	]
	
	//-------------------------
	// BEHAVIOR STRING ARRAYS
	//-------------------------

	global.behavior_string.frog =
	[	
		"roaming",
		"seeking_log",
		"panic"
	]
}

// ----------------------
// HELPFUL FUNCTIONS
// ----------------------
function getCenterOfCurrentTile(_x, _y)
{
    var return_data =
    {
        x: 0,
        y: 0
    }
    
    half_tile_size = floor(global.game_tile_size / 2);

    return_data.x = (floor(_x/global.game_tile_size) * global.game_tile_size) + half_tile_size;
    return_data.y = (floor(_y/global.game_tile_size) * global.game_tile_size) + half_tile_size;

	return return_data;
}

function PointsNotificationDisplay(amount)
{
	//if (!instance_exists(obj_Parent_Fish))
	//{ exit; }
	switch (amount)
	{
		case 1:
			instance_create_layer(obj_Parent_Player.x + 8, obj_Parent_Player.y - 8, "HUD", obj_Points_Awarded, {number_of_points_incremented: 1});
			sprite_index = spr_Points_1;
			image_speed = 0;
			break;
	 
		case 2:
			instance_create_layer(obj_Parent_Player.x + 8, obj_Parent_Player.y - 8, "HUD", obj_Points_Awarded, {number_of_points_incremented: 2});
			sprite_index = spr_Points_2;
			image_speed = 0;
			break;
		
		case 3:
			instance_create_layer(obj_Parent_Player.x + 8, obj_Parent_Player.y - 8, "HUD", obj_Points_Awarded, {number_of_points_incremented: 3});
			sprite_index = spr_Points_3;
			image_speed = 0;
			break;
			
		case 4:
			instance_create_layer(obj_Parent_Player.x + 8, obj_Parent_Player.y - 8, "HUD", obj_Points_Awarded, {number_of_points_incremented: 4});
			sprite_index = spr_Points_4;
			image_speed = 0;
			break;
		
		case 5:
			instance_create_layer(obj_Parent_Player.x + 8, obj_Parent_Player.y - 8, "HUD", obj_Points_Awarded, {number_of_points_incremented: 5});
			sprite_index = spr_Points_5;
			image_speed = 0;
			break;
	}
}

