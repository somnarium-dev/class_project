///MOVEMENT AND DECELERATION
///@func handleTwigMovementAndCollision()
handleTwigMovementAndCollision = function()
{	
	handleAcceleration();
	
	handleHorizontalPixelAccumulation();
	handleVerticalPixelAccumulation();
	
	handleHorizontalMovement();
	handleVerticalMovement();
}


///@func handleAcceleration()
handleAcceleration = function()
{
	var adjustment = 0;
	var new_speed = 0;
	
	//Accelerate
	if (current_speed < current_top_speed)
	{
		adjustment = ai_input_accelerate * accel_rate;
		new_speed = current_speed + adjustment;
		
		//Cap to top speed.
		if (new_speed > current_top_speed) { new_speed = current_top_speed; }
		
		current_speed = new_speed;
	}
	
	//Decelerate.
	if (current_speed != 0)
	{
		if (!ai_input_accelerate)
		|| (current_speed > current_top_speed)
		{
			//If fish can decelerate without passing 0, decelerate.
			if (current_speed > decel_rate) { new_speed = current_speed - decel_rate; }
			else { new_speed = 0; }
			
			current_speed = new_speed;
		}
	}
}

///@func handleHorizontalPixelAccumulation()
handleHorizontalPixelAccumulation = function()
{
	// Derive horizontal speed.
	var h_speed = lengthdir_x(current_speed, direction);
	
	// Accumulate and queue pixels.
	horizontal_pixels_accumulated += h_speed;
	var integer_pixels = horizontal_pixels_accumulated div 1;
	horizontal_pixels_accumulated -= integer_pixels;
	horizontal_pixels_queued = integer_pixels;
	
	// If it is not possible to move in the queued direction, 
	// Then clear the variables to prevent issues.
	var h_sign = sign(horizontal_pixels_queued)
	var next_position_blocked = place_meeting(x + h_sign, y, obj_Parent_Collision);
	if (next_position_blocked)
	{
		horizontal_pixels_accumulated = 0;
		horizontal_pixels_queued = 0;
	}
}

///@func handleVerticalPixelAccumulation()
handleVerticalPixelAccumulation = function()
{
	// Derive vertical speed.
	var v_speed = lengthdir_y(current_speed, direction);
	
	// Accumulate and queue pixels.
	vertical_pixels_accumulated += v_speed;
	var integer_pixels = vertical_pixels_accumulated div 1;
	vertical_pixels_accumulated -= integer_pixels;
	vertical_pixels_queued = integer_pixels;
	
	// If it is not possible to move in the queued direction, 
	// Then clear the variables to prevent issues.
	var v_sign = sign(vertical_pixels_queued)
	var next_position_blocked = place_meeting(x, y + v_sign, obj_Parent_Collision);
	if (next_position_blocked)
	{
		vertical_pixels_accumulated = 0;
		vertical_pixels_queued = 0;
	}
}

///@func handleHorizontalMovement()
handleHorizontalMovement = function()
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

///@func handleVerticalMovement()
handleVerticalMovement = function()
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