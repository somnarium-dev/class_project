var nearest_player = instance_nearest(x, y, obj_Parent_Player);
	
if (point_distance (x, y, nearest_player.x, nearest_player.y) < danger_range)
{
	alarm_set(0, 90);
}

behavior = frog_behavior.roaming;