function alignedWithGrid()
{
	return (x mod global.game_tile_size == 0) && (y mod global.game_tile_size == 0);
}

function increaseScore(amount)
{
	global.player_1.point_total += amount;
}