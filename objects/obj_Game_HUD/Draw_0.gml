// draw the hud placeholder sprites
// offset/margin of 10
// the 74 and 42 are just the width/height of the given sprite
// (64 and 42 respectively) + 10 for the margin
var x_offset = x+10;
var y_offset = y+10;
draw_sprite_stretched(spr_Placeholder_Points_HUD,-1, x_offset, y_offset, 64, 64);
draw_sprite_stretched(spr_Placeholder_Timer_HUD, -1, room_width-74, y_offset, 64, 64);
draw_sprite(spr_Placeholder_Level_HUD, -1, x_offset, room_height-42);