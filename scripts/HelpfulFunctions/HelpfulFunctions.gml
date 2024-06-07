function alignedWithGrid()
{
	return (x mod global.game_tile_size == 0) && (y mod global.game_tile_size == 0);
}

function increaseScore(amount)
{
	global.player_1.point_total += amount;
}

function scaleDownToFitValue(_valueToFitWithin, _valueToScale)
{
	var _x = _valueToFitWithin;
	var _y = _valueToScale;
	var _z = 0;
	
	_z = floor((_x / _y) * 100) / 100;
	
	return min(1, _z);
}

function centerWithinSpace(_offset, _containerSize, _contentSize)
{
	var return_value = _offset;
	
	return_value += (_containerSize / 2);
	
	return_value -= (_contentSize / 2);
	
	return round(return_value);
}