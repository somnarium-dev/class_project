///@desc Custom methods.

///@func updateTimeRemaining()
updateTimeRemaining = function()
{
	if (global.time_remaining <= 0)
	{exit;}
	
	global.time_remaining = global.time_remaining - 1; 
	
	stringifyTimeRemaining();
	updateTimerDisplayProperties();
}

///@func stringifyTimeRemaining()
stringifyTimeRemaining = function()
{
	var time_remaining = ceil(global.time_remaining / global.game_fps);
	string_time_remaining = string(time_remaining);
}

///@func updateTimerDisplayProperties()
updateTimerDisplayProperties = function()
{
	timer_string_width = string_width(string_time_remaining);
	timer_string_height = string_height(string_time_remaining);

	//Center the display position of the timer's current value within the timer sprite.
	timer_value_x = timer_x;
	timer_value_x += (sprite_get_width(spr_timer) / 2); // Get half of the timer sprite's width.
	timer_value_x -= (timer_string_width / 2); // Move back by half of the width of the value string.
	timer_value_x = floor(timer_value_x); // Only draw to integer positions.
	
	timer_value_y = timer_y;
	timer_value_y += (sprite_get_height(spr_timer) / 2); // Get half of the timer sprite's height.
	timer_value_y -= (timer_string_height / 2); // Move upward by half of the height of the value string.
	timer_value_y = floor(timer_value_y); // Only draw to integer positions.
}

///@func drawGameHUD()
drawGameHUD = function()
{
	draw_sprite(spr_points, 0, points_x, points_y);
	draw_sprite(spr_timer, 0, timer_x, timer_y);
	draw_sprite(spr_level_indicator, 0, level_x, level_y);

	draw_set_color(c_red);
	draw_text(timer_value_x, timer_value_y, string_time_remaining);
	draw_set_color(c_white);
}