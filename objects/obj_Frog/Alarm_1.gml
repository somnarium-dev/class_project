/// @description panic cooldown
var nearest_player = instance_nearest(x, y, obj_Parent_Player);
	
if (point_distance (x, y, nearest_player.x, nearest_player.y) < danger_range)
{
	alarm_set(1, panic_state_cooldown);
}

ready_to_exit_panicked_state = true;