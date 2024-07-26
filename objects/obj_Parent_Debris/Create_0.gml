// Inherit the parent event
event_inherited();

// Properties
impassable = true;

//Custom Methods
event_user(0);

//Movement and Collision
current_speed = 0;

claimed_cell = noone;

bump_request = 
{
	_enabled: false,
	_direction: 0
}

sprite_index = sprite_still;

//State control flags
eaten_state_requested = false;

//Initialize
image_speed = 0;