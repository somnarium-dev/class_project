///@func processBumpRequest()
processBumpRequest = function()
{
	if (!bump_request._enabled)
	|| (claimed_cell != noone)
	|| (eaten_state_requested)
	{return;}
	
	handleCellClaiming(bump_request._direction);
	bump_request._enabled = false;
}


///@func handleCellClaiming(_direction)
handleCellClaiming = function(_direction)
{
	var _x = lengthdir_x(global.game_tile_size, _direction);
	var _y = lengthdir_y(global.game_tile_size, _direction);
	
	if (checkForImpassable(x + _x, y + _y)){return;}
	
	claimed_cell = instance_create_layer(x + _x, y + _y, "Consumables", obj_Parent_Collision);
}

///@func releaseClaimedCell()
releaseClaimedCell = function()
{
	instance_destroy(claimed_cell);
	claimed_cell = noone;
}

///@func moveToClaimedCell()
moveToClaimedCell = function()
{
	if (claimed_cell = noone)
	|| (eaten_state_requested)
	{return;}
	
	direction = point_direction(x, y, claimed_cell.x, claimed_cell.y);
	speed = 2;
	
	if (x == claimed_cell.x)
	&& (y == claimed_cell.y)
	{
		releaseClaimedCell();
		speed = 0;
	}
}

///@func processEatRequest()
processEatRequest = function()
{
	if (eaten_state_requested)
	{
		if (claimed_cell != noone)
		{
			instance_destroy(claimed_cell);
		}
		instance_destroy();
	}
}