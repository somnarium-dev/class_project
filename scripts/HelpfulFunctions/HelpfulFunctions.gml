/// @function alignedWithGrid
/// @description Check to see if the x and y axis align with the grid size for a particular square
/// @description Squares are 32 as set in initialize.
function alignedWithGrid()
{
	var _x = x - 16;
	var _y = y - 16;
	
	return (_x mod global.game_tile_size == 0) && (_y mod global.game_tile_size == 0);
}

/// @function increaseScore
/// @description Increase and display the global.player_1.point_total number.
/// @param {int} amount the final number to display after incrementing.
function increaseScore(amount)
{
	global.player_1.point_total += amount;
}

/// @function scaleDownToFitValue
/// @description Compare two numbers. the first is the dimension of a container, the second is the
/// @description same dimension but of it's contents. function finds the percentage of the second
/// @description number that best fits within the first.
/// @param {int} _valueToFitWithin The width or height in number of pixels of the chosen container.
/// @param {int} _valueToScale The same dimension as the previous parameter, in number of pixels of the contents.
function scaleDownToFitValue(_valueToFitWithin, _valueToScale)
{
	var _x = _valueToFitWithin;
	var _y = _valueToScale;
	var _z = 0;
	
	_z = floor((_x / _y) * 100) / 100;
	
	return min(1, _z);
}

/// @function centerWithinSpace
/// @description center the content within the chosen space, by offsetting from the edges.
/// @description This is done by setting an offset value, taking the size of the container,
/// @description and the size of the content. This function halves the size of the container,
/// @description adds it to the offset, then subtracts half of the size of the contents.
/// @description This should center the contents within the container.
/// @param {int} _offset  a set value to use an an offset.
/// @param {int} _containerSize the size in pixels of the container in a chosen dimension.
/// @param {int} _contentSize the size in pixels of the content in the same dimension.
function centerWithinSpace(_offset, _containerSize, _contentSize)
{
	var return_value = _offset;
	
	return_value += (_containerSize / 2);
	
	return_value -= (_contentSize / 2);
	
	return round(return_value);
}

/// @function getCenterOfCurrentTile
/// @description Take the global size of a game tile and half it.
/// Add the equivalent of half of the game tile size
/// to the current coordinates you are using to find the center of the tile.
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
/// @description Create an instance of obj_Points_Awarded on the HUD layer 
/// to display a score increase to the player.
/// @param {int} _amount the number to display.
function PointsNotificationDisplay(_amount)
{
	var half_tile_size = floor(global.game_tile_size / 2);
	var quarter_tile_size = floor(global.game_tile_size / 4);
	
	var create_x = obj_Parent_Player.x + half_tile_size;
	var create_y = obj_Parent_Player.y - quarter_tile_size;
	
	instance_create_layer(create_x, create_y, "HUD", obj_Points_Awarded,
	{
		number_of_points_incremented: _amount,
		sprite_index: asset_get_index("spr_Points_" + string(_amount)),
		image_speed: 0,
		max_display_time: 100
	});
}

/// @function turnTowardsDirection
/// @description Determine the difference between the current direction and a target direction,
/// and return a new angle that is a set number of degrees closer toward the target.
/// @param {real} _target_direction The direction to turn toward.
/// @param {real} _turn_degrees The number of degrees to turn toward that direction. Unexpected outcomes may result if a number of degrees is provided that exceeds the difference between the current and target directions.
/// @return {real}
function turnTowardsDirection(_target_direction, _turn_degrees)
{
	var return_data = direction;
	
	var angle_direction = dsin(_target_direction - direction);
	
	if (angle_direction > 0) { return_data += _turn_degrees; }
	if (angle_direction < 0) { return_data -= _turn_degrees; }
	
	return return_data;
}

/// @function pathGetPercentageDistanceRemaining()
/// @description Returns distance not yet traveled as a percentage of a path's total distance.
/// Returns -1 if no path is defined.
/// @return {real}
function pathGetPercentageDistanceRemaining()
{
	if (current_path == undefined) { return -1; }
	
	var path_distance_remaining = path_get_length(current_path) * (1 - path_position);
	var path_max_distance = path_get_length(current_path);
	var path_percentage_remaining = path_distance_remaining / path_max_distance;
	
	return path_percentage_remaining * 100;
}

/// @function snapToGrid()
/// @description Moves object to grid if it doesn't align
function snapToGrid()
{
	if (alignedWithGrid()) {return;}
	
	var half_cell = floor(global.game_tile_size/2);
	
	var _x_cell = x div global.game_tile_size;
	var _y_cell = y div global.game_tile_size;
	
	var _x_corrected = (_x_cell * global.game_tile_size) + half_cell;
	var _y_corrected = (_y_cell * global.game_tile_size) + half_cell;
	
	x = _x_corrected;
	y = _y_corrected;
	
	
}