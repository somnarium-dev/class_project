
// Enable this code block to draw the collision mask underneath the fish.
/*
draw_sprite
(
	spr_Mask_Collision_Basic,
	0,
	x,
	y
);
*/

draw_sprite_ext
(
	fish_sprite,
	image_index,
	x + 16,
	y + 16,
	image_xscale,
	image_yscale,
	direction,
	image_blend,
	image_alpha
);