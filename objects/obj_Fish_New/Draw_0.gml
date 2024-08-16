// Pathfinding needs to be able to use subpixel positions in order to work properly (I believe).
// As such, to prevent rendering errors, we use a rounded x and y for drawing.

// Notice: We are not offsetting here anymore.
// This is because for pathfinding and image rotation to work correctly,
// we have to have to align with the center of each grid cell anyway. 
var draw_x = round(x);
var draw_y = round(y);

draw_sprite_ext
(
	sprite_index,
	image_index,
	draw_x,
	draw_y,
	image_xscale,
	image_yscale,
	direction,
	image_blend,
	image_alpha
);

// Current coordinates and percentage of path remaining.
// You can delete these lines, they're just here for educational purposes.
draw_text(x, y, $"[{x}, {y}]");
draw_text(x, y + 8, $"{pathGetPercentageDistanceRemaining()}%");