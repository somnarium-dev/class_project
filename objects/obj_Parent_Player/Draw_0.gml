/// @description Draw.

draw_self();


draw_sprite_ext
(
	current_sprite,
	image_index,
	x + 16,
	y + 16,
	image_xscale,
	image_yscale,
	direction,
	image_blend,
	image_alpha
);


// Enable the section below to print the object's state to the screen.
//draw_text(x + 16, y - 16, global.state_string.player[state]);
draw_text(x + 16, y - 16, $"{current_speed}");
