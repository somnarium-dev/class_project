/// @description Insert description here
// You can write your code in this editor

var nearest_player = instance_nearest(x, y, obj_Parent_Player);
	
if (point_distance (x, y, nearest_player.x, nearest_player.y) < danger_range)
{
	alarm_set(0, 90);
}

behavior = consumable_behavior.seeking_log; // EDITED FROM ROAMING