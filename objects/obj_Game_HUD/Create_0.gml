//Load custom methods.
event_user(0);

//Define layout.
standard_margin = 10;

standard_x_offset = standard_margin;
standard_y_offset = standard_margin;

points_sprite_width = sprite_get_width(sprite_points);
points_sprite_height = sprite_get_height(sprite_points);
timer_sprite_width = sprite_get_width(sprite_timer);
timer_sprite_height = sprite_get_height(sprite_timer);
level_sprite_width = sprite_get_width(sprite_level);
level_sprite_height = sprite_get_height(sprite_level);

points_x = x + standard_x_offset;
points_y = y + standard_y_offset;

timer_x = room_width - timer_sprite_width - standard_x_offset;
timer_y = y + standard_y_offset;

level_x = standard_x_offset;
level_y = room_height - level_sprite_height - standard_y_offset;

// Initialize.
string_time_remaining = "";

updatePointsIndicatorPosition();

global.time_remaining = room_time_limit;

if (global.time_remaining < 0)
{ global.time_remaining = global.standard_time_limit; }

updateTimeRemaining();
updatePointsIndicatorPosition();

setLevelIndicatorPositionAndScale();