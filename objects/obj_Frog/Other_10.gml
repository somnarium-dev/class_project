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
			var grass_layer_id = layer_tilemap_get_id("Grass");
			var tile_coords = getCenterOfCurrentTile(x, y);
			if (tilemap_get_at_pixel(grass_layer_id, tile_coords.x, tile_coords.y))
				{	sprite_index = frog_sprites.land;
					image_speed = 1;
				}
			else
				{	sprite_index = frog_sprites.swim;
					image_speed = 1;
				}
			break;
		
		default:
			sprite_index = frog_sprites.land;
			image_speed = 1;
			break;
	}
}