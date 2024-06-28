function handlePauseTransition()
{
	
	// When the object is paused,
	// stop animating.
	
	if ( !is_paused )
	&& ( global.level_manager.state == level_state.paused )
	{ 
		stored_sprite_index = sprite_index;
		stored_image_index = image_index;
		stored_image_speed = image_speed;
		
		image_speed = 0;
		
		is_paused = true;
	}
	
	// When unpaused, continue.
	if ( is_paused )
	&& ( global.level_manager.state != level_state.paused )
	{
		sprite_index = stored_sprite_index;
		image_index = stored_image_index;
		image_speed = stored_image_speed;
		
		is_paused = false;
	}
}