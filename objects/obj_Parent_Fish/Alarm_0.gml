var nearest_player = instance_nearest(x, y, obj_Parent_Player);
	
if (point_distance (x, y, nearest_player.x, nearest_player.y) < safe_range)
{
	alarm_set(0, 90);
}

behavior = fish_behavior.roaming;