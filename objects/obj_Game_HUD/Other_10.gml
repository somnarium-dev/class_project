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
	draw_set_font(Standard_Font);
	
	timer_string_width = string_width(string_time_remaining);
	timer_string_height = string_height(string_time_remaining);

	//Center the display position of the timer's current value within the timer sprite.
	timer_value_x = timer_x;
	timer_value_x += (sprite_get_width(spr_timer) / 2); // Get half of the timer sprite's width.
	timer_value_x -= (timer_string_width) / 2; // Move back by half of the width of the value string.
	timer_value_x = floor(timer_value_x); // Only draw to integer positions.
	
	timer_value_y = timer_y;
	timer_value_y += (sprite_get_height(spr_timer) / 2); // Get half of the timer sprite's height.
	timer_value_y -= (timer_string_height) / 2; // Move upward by half of the height of the value string.
	timer_value_y = floor(timer_value_y); // Only draw to integer positions.
	
	draw_set_font(Default_Font);
}

///@func setLevelIndicatorPositionAndScale()
setLevelIndicatorPositionAndScale = function()
{
	draw_set_font(Standard_Font);
	// the box for displaying the level indicator has a width x
	// the width of the level display in pixels is y
	// z = x/y
	// if y exceeds x, multiply y by z
	
	/*
	x = 100
	y = 120
	z = ?
	
	y * z = x
	*/
	string_level_value = string_concat("Level ", global.current_level);
	
	var level_sprite_width = sprite_get_width(spr_level_indicator);
	var level_sprite_height = sprite_get_height(spr_level_indicator);
	
	var level_display_width = string_width(string_level_value);
	var level_display_height = string_height(string_level_value);
	
	var display_width = level_sprite_width - (print_margin * 2);
	
	var new_text_scale = floor((display_width / level_display_width) * 100) / 100;
	
	level_text_scale = min(1, new_text_scale);
	
	level_x = x + standard_x_offset;
	level_y = room_height - sprite_get_height(spr_level_indicator) - standard_y_offset;

	level_value_x = level_x + level_sprite_width / 2;
	level_value_y = level_y + level_sprite_height / 2;
	
	level_value_x -= (level_display_width * level_text_scale) / 2;
	level_value_y -= (level_display_height * level_text_scale) / 2;
	
	level_value_x = floor(level_value_x);
	level_value_y = floor(level_value_y);
	
	draw_set_font(Default_Font);
}

///@func updatePointsIndicatorPosition()
updatePointsIndicatorPosition = function()
{
	draw_set_font(Standard_Font);
	
	points_x = x + standard_x_offset;
	points_y = y + standard_y_offset;
	
	points_string = string(global.player_1.point_total);
	
	points_string_width = string_width(points_string);
	points_string_height = string_height(points_string);

	points_value_x = points_x + (sprite_get_width(spr_points)/2) - (points_string_width / 2);
	points_value_y = points_y + (sprite_get_height(spr_points)/2) - (points_string_height / 2);
	
	draw_set_font(Default_Font);
}

///@func drawGameHUD()
drawGameHUD = function()
{
	draw_sprite(spr_points, 0, points_x, points_y);
	draw_sprite(spr_timer, 0, timer_x, timer_y);
	draw_sprite(spr_level_indicator, 0, level_x, level_y);

	// text drawing settings
	draw_set_font(Standard_Font);
	draw_set_color(c_black);

	// draw timer value
	draw_text(timer_value_x, timer_value_y, string_time_remaining);
	
	// draw points value
	draw_text(points_value_x, points_value_y, global.player_1.point_total);
	
	// draw level value
	draw_text_transformed(level_value_x, level_value_y, string_level_value, level_text_scale, level_text_scale, 0);
	
	// reset text drawing settings to defaults
	draw_set_font(Default_Font);
	draw_set_color(c_white);
}
