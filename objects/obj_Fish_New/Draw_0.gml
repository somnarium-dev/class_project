draw_sprite_ext
(
	sprite_index,
	image_index,
	x,
	y,
	1,
	1,
	direction,
	c_white,
	1
);

draw_text(x, y, $"[{x}, {y}]");
draw_text(x, y + 8, $"{path_distance_remaining}");