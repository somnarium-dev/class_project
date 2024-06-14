/// @function alignedWithGrid
/// @description Check to see if the x and y axis align with the grid size for a particular square
/// @description Squares are 32 as set in initialize.
function alignedWithGrid()
{
	return (x mod global.game_tile_size == 0) && (y mod global.game_tile_size == 0);
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