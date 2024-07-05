function LightsenInitialize()
{

}

// ----------------------
// HELPFUL FUNCTIONS
// ----------------------

//Lightsen: JSDoc for these before next merge please. :)

/// @function getCenterOfCurrentTile
/// @description Take the global size of a game tile and half it.
/// @description add the equivalent of half of the game tile size
/// @description to the current coordinates you are using to find the center of the tile.
/// @param {int} _x the x coordinate of this object
/// @param {int} _y the y coordinate of this object
function getCenterOfCurrentTile(_x, _y)
{
    var return_data =
    {
        x: 0,
        y: 0
    }
    
    var half_tile_size = floor(global.game_tile_size / 2);

    return_data.x = (floor(_x/global.game_tile_size) * global.game_tile_size) + half_tile_size;
    return_data.y = (floor(_y/global.game_tile_size) * global.game_tile_size) + half_tile_size;

	return return_data;
}

/// @function PointsNotificationDisplay
/// @description Create an instance on the HUD layer. 
/// @description place an asset next to the player, showing the
/// @description number of points the player earned from a consumable.
/// @param {int} _amount the number to display.
function PointsNotificationDisplay(_amount)
{
	instance_create_layer(obj_Parent_Player.x + 8, obj_Parent_Player.y - 8, "HUD", obj_Points_Awarded,
	{
		number_of_points_incremented: _amount,
		sprite_index: asset_get_index("spr_Points_" + string(_amount)),
		image_speed: 0,
		display_time: 100
	});
}

