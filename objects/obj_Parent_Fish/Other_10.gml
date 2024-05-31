///@desc custom functions

///@func readFishInput()
readFishInput = function()
{
	if (current_speed != 0)
	{
		var desired_direction = direction - (ai_input_lr * 90);
		updateFishDirection(desired_direction);
		horizontal_pixels_accumulated = 0;
		vertical_pixels_accumulated = 0;
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
	if (ai_input_panic_boost == 1)
	{current_top_speed = max_panic_speed;}
	else
	{current_top_speed = max_swim_speed;}
}

///@func handleFishAcceleration()
handleFishAcceleration = function()
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

///@func handleFishHorizontalPixelAccumulation()
handleFishHorizontalPixelAccumulation = function()
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

///@func handleFishVerticalPixelAccumulation()
handleFishVerticalPixelAccumulation = function()
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

///@func updateFishDirection(proposed_new_direction)
updateFishDirection = function(proposed_new_direction)
{
	var new_direction = proposed_new_direction;
	
	if (new_direction < 0) { new_direction += 360; }
	if (new_direction > 360) { new_direction -= 360; }
	
	direction = new_direction;
}

///@func testFishDirectionBlocked(proposed_direction)
testFishDirectionBlocked = function(proposed_direction)
{
	var new_direction = proposed_direction;
	
	if (new_direction < 0) { new_direction += 360; }
	if (new_direction > 360) { new_direction -= 360; }
	
	var proposed_next_x = x + lengthdir_x(1, new_direction);
	var proposed_next_y = y + lengthdir_y(1, new_direction);
	
	return place_meeting(proposed_next_x, proposed_next_y, obj_Parent_Collision);
}

///@func handleFishFacing()
handleFishFacing = function()
{
	//handle facing direction
	if (ai_input_lr != 0) facing_direction = ai_input_lr;
	if (ai_input_ud != 0) facing_direction = ai_input_ud;
}

//=======================================================================================
// AI FUNCTIONS
//=======================================================================================

///@func aiFishTurnWhenBlocked()
aiFishTurnWhenBlocked = function()
{
	//Create array of possible directions to travel.
	var possible_directions = [];
		
	//Determine which of these directions is unblocked.
	var can_turn_left = !testFishDirectionBlocked(direction + 90);
	var can_turn_right = !testFishDirectionBlocked(direction - 90);
			
	if (can_turn_left) {array_push(possible_directions, -1);}
	if (can_turn_right) {array_push(possible_directions, 1);}
		
	var available_options = array_length(possible_directions);
		
	//If all directions are blocked, turn left.
	if (available_options == 0) { ai_input_lr = -1; }
		
	//Otherwise, select a random unblocked direction.
	else
	{
		var random_integer = irandom(available_options - 1);
		ai_input_lr = possible_directions[random_integer]; 
	}
}

///@func aiFishTurnAtRandom()
aiFishTurnAtRandom = function()
{
	if (!random_turn_available) { return; }
	
	var rolled_random_turn = (irandom_range(1, random_turn_range) <= random_turn_chance);
		
	if (rolled_random_turn)
	{
		//Create array of possible directions to travel.
		var possible_directions = [];
		
		//Determine which of these directions is unblocked.
		var can_turn_left = !testFishDirectionBlocked(direction + 90);
		var can_turn_right = !testFishDirectionBlocked(direction - 90);
			
		if (can_turn_left) {array_push(possible_directions, -1);}
		if (can_turn_right) {array_push(possible_directions, 1);}
		
		var available_options = array_length(possible_directions);
		
		//Select a random unblocked direction to turn, if there are any.
		if (available_options > 0)
		{
			var random_integer = irandom(available_options - 1);
			ai_input_lr = possible_directions[random_integer]; 
			alarm[1] = random_turn_cooldown;
			random_turn_available = false;
		}
	}
}
