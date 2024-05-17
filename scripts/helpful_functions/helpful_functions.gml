function alignedWithGrid()
{
	return (x mod 32 == 0) && (y mod 32 == 0);
}

function increaseScore(amount)
{
	global.player_1.point_total += amount;
}