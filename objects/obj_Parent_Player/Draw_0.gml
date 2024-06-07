/// @description Draw.

//-----------------------------------------------------------
// Temporary code: Blend red when stunned.
// Remove when stunned animation is implemented.
//-----------------------------------------------------------
image_blend = c_white;
if (state == player_state.stun) { image_blend = c_red; }
//-----------------------------------------------------------

draw_sprite_ext
(
	sprite_index,
	image_index,
	x + 16,
	y + 16,
	image_xscale,
	image_yscale,
	direction,
	image_blend,
	image_alpha
);
