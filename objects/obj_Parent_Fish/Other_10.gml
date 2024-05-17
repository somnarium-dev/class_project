///@desc custom functions

///@func readFishInput()
readFishInput = function()
{
	if (current_speed != 0)
	{
		var proposed_direction = direction - (ai_input_lr * 90);
		
		if (proposed_direction < 0) { proposed_direction += 360; }
		if (proposed_direction > 360) { proposed_direction -= 360; }
		
		// make sure fish is completely on tile
		var proposed_next_x = x + lengthdir_x(1, proposed_direction);
		var proposed_next_y = y + lengthdir_y(1, proposed_direction);
		var next_position_free = !place_meeting(proposed_next_x, proposed_next_y, obj_Parent_Collision);
		
		if (next_position_free)
		{
			direction = proposed_direction;
		}
	}
}

///@func handleFishMovementAndCollision()
handleFishMovementAndCollision = function()
{
	determineFishTopSpeed();
	
	handleFishAcceleration();
	
	handleFishHorizontalPixelAccumulation();
	handleFishVerticalPixelAccumulation();
	
	handleFishHorizontalMovement();
	handleFishVerticalMovement();
}
	
///@func determineFishTopSpeed()
determineFishTopSpeed = function()
{
	if (state == fish_state.panic)
	{current_top_speed = max_panic_speed;}
	else
	{current_top_speed = max_swim_speed;}
}

///@func handleFishAcceleration()
handleFishAcceleration = function()
{
	//accelerate
	if (current_speed < current_top_speed)
	{
		var adjustment = ai_input_accelerate * accel_rate;
		var new_speed = current_speed + adjustment;
		
		//cap to top speed
		if (new_speed > current_top_speed)
		{
			new_speed = current_top_speed;
		}
	}
	
	//decelerate
	if (current_speed != 0)
	{
		if (!ai_input_accelerate)
		|| (current_speed > current_top_speed)
		{
			//if fish can decelerate without passing 0 
			if (current_speed > decel_rate)
			{
				new_speed = current_speed - decel_rate;
			}
			else 
			{
				new_speed = 0;
			}
			current_speed = new_speed;
		}
	}
}

///@func handleFishHorizontalPixelAccumulation()
handleFishHorizontalPixelAccumulation = function()
{
	// derive horizontal speed
	var h_speed = lengthdir_x(current_speed, direction);
	
	// accumulate and queue pixels
	horizontal_pixels_accumulated += h_speed;
	var integer_pixels = horizontal_pixels_accumulated div 1;
	horizontal_pixels_accumulated -= integer_pixels;
	horizontal_pixels_queued = integer_pixels;
	
	// if it is not possible to move in the queued direction, 
	// then clear the variables to prevent issues
	var h_sign = sign(horizontal_pixels_queued)
	var next_position_blocked = place_meeting(x + h_sign, y, obj_Parent_Collision);
	if (next_position_blocked)
	{
		horizontal_pixels_accumulated = 0;
		horizontal_pixels_queued = 0;
	}
}

///@func handleFishVerticalPixelAccumulation()
handleFishVerticalPixelAccumulation = function()
{
	// derive vertical speed
	var v_speed = lengthdir_y(current_speed, direction);
	
	// accumulate and queue pixels
	vertical_pixels_accumulated += v_speed;
	var integer_pixels = vertical_pixels_accumulated div 1;
	vertical_pixels_accumulated -= integer_pixels;
	vertical_pixels_queued = integer_pixels;
	
	// if it is not possible to move in the queued direction, 
	// then clear the variables to prevent issues
	var v_sign = sign(vertical_pixels_queued)
	var next_position_blocked = place_meeting(x, y + v_sign, obj_Parent_Collision);
	if (next_position_blocked)
	{
		vertical_pixels_accumulated = 0;
		vertical_pixels_queued = 0;
	}
}

///@func handleFishHorizontalMovement()
handleFishHorizontalMovement = function()
{
	var repetitions = abs(horizontal_pixels_queued);
	var adjustment = sign(horizontal_pixels_queued);
	
	repeat (repetitions)
	{
		var next_position_blocked = place_meeting(x + adjustment, y, obj_Parent_Collision);
		
		if (next_position_blocked)
		{
			horizontal_pixels_accumulated = 0;
			horizontal_pixels_queued = 0;
			break;
		}
		
		x += adjustment;
		horizontal_pixels_queued -= adjustment;
	}
}

///@func handleFishVerticalMovement()
handleFishVerticalMovement = function()
{
	var repetitions = abs(vertical_pixels_queued);
	var adjustment = sign(vertical_pixels_queued);
	
	repeat (repetitions)
	{
		var next_position_blocked = place_meeting(x, y + adjustment, obj_Parent_Collision);
		
		if (next_position_blocked)
		{
			vertical_pixels_accumulated = 0;
			vertical_pixels_queued = 0;
			break;
		}
		
		y += adjustment;
		vertical_pixels_queued -= adjustment;
	}
}

///@func handleFishFacing()
handleFishFacing = function()
{
	//handle facing direction
	if (ai_input_lr != 0) facing_direction = ai_input_lr;
	if (ai_input_ud != 0) facing_direction = ai_input_ud;
}

