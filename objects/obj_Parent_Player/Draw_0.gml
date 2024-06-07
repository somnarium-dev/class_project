/// @description Draw.
var draw_color = c_white;

if (state == player_state.stun) { draw_color = c_red; }

draw_sprite_ext
(
	sprite_index,
	image_index,
	x + 16,
	y + 16,
	image_xscale,
	image_yscale,
	direction,
	draw_color,
	image_alpha
);
