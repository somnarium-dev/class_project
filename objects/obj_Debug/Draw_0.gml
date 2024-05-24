if (!global.debug_data_enabled)
{ exit; }

//Show croc's current speed next to its head.
if (global.current_player_instance != noone)
&& (instance_exists(global.current_player_instance))
{
	//Offset by 16 on x and y to improve data display.
	var this_x = global.current_player_instance.x + 16;
	var this_y = global.current_player_instance.y - 16;
	var this_current_speed = global.current_player_instance.current_speed;
	
	draw_text(this_x, this_y, $"{this_current_speed}");
}