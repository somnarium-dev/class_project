//Load custom methods.
event_user(0);

//Define sprites.
spr_points = spr_Placeholder_Points_HUD;
spr_timer = spr_Placeholder_Timer_HUD;
spr_level_indicator = spr_Placeholder_Level_HUD;

//Define layout.
standard_margin = 10;

standard_x_offset = standard_margin;
standard_y_offset = standard_margin;

// points display properties
updatePointsIndicatorPosition();

// timer display properties
timer_x = room_width - sprite_get_width(spr_timer) - standard_x_offset;
timer_y = y + standard_y_offset;

timer_string_width = 0;
timer_string_height = 0;

timer_value_x = timer_x + (sprite_get_width(spr_timer) / 2) - timer_string_width;
timer_value_y = timer_y + (sprite_get_height(spr_timer) / 2) - timer_string_height;

// level value display properties
setLevelIndicatorPositionAndScale();

//Internal functionality.
global.time_remaining = room_time_limit;

if (global.time_remaining < 0)
{ global.time_remaining = global.standard_time_limit; }

string_time_remaining = "";

stringifyTimeRemaining();