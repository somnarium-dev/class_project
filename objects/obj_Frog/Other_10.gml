///@desc Custom Methods
event_inherited();

//Handle Sprites
///@func handleSprite()
handleSprite = function()
{
	switch (state)
	{
		case consumable_state.still:
			sprite_index = frog_sprites.land;
			image_speed = 0;
			break;
	 
		case consumable_state.swim:
			if (instance_place(x, y, obj_Parent_Barrier))
			{	
				sprite_index = frog_sprites.land;
				image_speed = 1;
			}
			else
			{	
				sprite_index = frog_sprites.swim;
				image_speed = 1;
			}
			break;
		
		default:
			sprite_index = frog_sprites.land;
			image_speed = 1;
			break;
	}
}

///@func enableCollisionDetectionIfRequested()
enableCollisionDetectionIfRequested = function()
{
	if (request_enable_collision_detection)
	{
		process_collision_detection = true;
		if (checkForImpassable(x, y))
		{ process_collision_detection = false; }
		
		else
		{ request_enable_collision_detection = false; }
	}
}