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
	
	var timer_string =
	{
		full_width: string_width(string_time_remaining),
		full_height: string_height(string_time_remaining),
		scaled_width: 0,
		scaled_height: 0
	}
	
	var sprite_width_less_margins = timer_sprite_width - (print_margin_timer * 2);
	
	timer_text_scale = scaleDownToFitValue(sprite_width_less_margins, timer_string.full_width);
	
	timer_string.scaled_width = timer_string.full_width * timer_text_scale;
	timer_string.scaled_height = timer_string.full_height * timer_text_scale;
	
	timer_value_x = centerWithinSpace(timer_x, timer_sprite_width, timer_string.scaled_width);
	timer_value_y = centerWithinSpace(timer_y, timer_sprite_height, timer_string.scaled_height);
	
	draw_set_font(Default_Font);
}

///@func setLevelIndicatorPositionAndScale()
setLevelIndicatorPositionAndScale = function()
{
	draw_set_font(Standard_Font);

	string_level_value = string_concat("Level ", global.current_level);
	
	var level_string =
	{
		full_width: string_width(string_level_value),
		full_height: string_height(string_level_value),
		scaled_width: 0,
		scaled_height: 0
	}
	
	var sprite_width_less_margins = level_sprite_width - (print_margin_level * 2);
	
	level_text_scale = scaleDownToFitValue(sprite_width_less_margins, level_string.full_width);
	
	level_string.scaled_width = level_string.full_width * level_text_scale;
	level_string.scaled_height = level_string.full_height * level_text_scale;
	
	level_value_x = centerWithinSpace(level_x, level_sprite_width, level_string.scaled_width);
	level_value_y = centerWithinSpace(level_y, level_sprite_height, level_string.scaled_height);
	
	draw_set_font(Default_Font);
}

///@func updatePointsIndicatorPosition()
updatePointsIndicatorPosition = function()
{
	draw_set_font(Standard_Font);
	
	var point_total = string(global.player_1.point_total);
	
	var points_string =
	{
		full_width: string_width(point_total),
		full_height: string_height(point_total),
		scaled_width: 0,
		scaled_height: 0
	}
	
	// The font scaling is only handled on the horizontal axis.
	// Because of this, a single digit will hit the top and bottom of the sprite even with a margin.
	// To fix this, scaling would need to account for width and height, and take the lesser of the two.
	// This will require a bit of overhaul, and should be handled as a low priority task.
	
	// - Bianka 2024.06.07
	var sprite_width_less_margins = points_sprite_width - (print_margin_timer * 2);
	
	// Interim Fix / Kludge: Flat scale down of 20%.
	sprite_width_less_margins *= .8;
	
	points_text_scale = scaleDownToFitValue(sprite_width_less_margins, points_string.full_width);
	
	points_string.scaled_width = points_string.full_width * points_text_scale;
	points_string.scaled_height = points_string.full_height * points_text_scale;
	
	points_value_x = centerWithinSpace(points_x, points_sprite_width, points_string.scaled_width);
	points_value_y = centerWithinSpace(points_y, points_sprite_height, points_string.scaled_height);
	
	draw_set_font(Default_Font);
}

///@func drawGameHUD()
drawGameHUD = function()
{
	// Draw sprites.
	draw_sprite(sprite_points, 0, points_x, points_y); // Points.
	draw_sprite(sprite_timer, 0, timer_x, timer_y); // Timer.
	draw_sprite(sprite_level, 0, level_x, level_y); // Level.

	// Adjust draw settings.
	draw_set_font(Standard_Font);
	draw_set_color(c_black);

	// Draw values.
	draw_text_transformed(points_value_x, points_value_y, global.player_1.point_total, points_text_scale, points_text_scale, 0); // Points.
	draw_text_transformed(timer_value_x, timer_value_y, string_time_remaining, timer_text_scale, timer_text_scale, 0); // Timer.
	draw_text_transformed(level_value_x, level_value_y, string_level_value, level_text_scale, level_text_scale, 0); // Level.
	
	// Reset text drawing settings to defaults.
	draw_set_font(Default_Font);
	draw_set_color(c_white);
}
