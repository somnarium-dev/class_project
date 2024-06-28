/// @description Draw level sprites.

draw_self();
if ( state == level_state.paused )
{ 
	getScreenSpaceEffectCoordinates();
	draw_sprite(spr_Menu_Pause, 0, screen_effect_x, screen_effect_y); 
}