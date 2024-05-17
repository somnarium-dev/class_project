///@func readPlayerInput()
readPlayerInput = function()
{
	//if (!global.accept_player_input) { return; }
	//if (global.pause_during_transition) { return; }
	
	input_manager.run();
	
	input_open_pressed = open.check_pressed();
	input_open_held = open.check();
	input_open_released = open.check_released();
	
	input_accelerate_pressed = accelerate.check_pressed();
	input_accelerate_held = accelerate.check();
	input_accelerate_released = accelerate.check_released();
	
	input_reverse_pressed = reverse.check_pressed();
	input_reverse_held = reverse.check();
	input_reverse_released = reverse.check_released();
	
	input_lr = right.check_pressed() - left.check_pressed();
	
	if (input_lr != 0)
	{	
		requested_turn = clamp(requested_turn + input_lr, -1, 1);
	}
}

///MOVEMENT AND DECELERATION
///@func handlePlayerMovementAndCollision()
handlePlayerMovementAndCollision = function()
{
	determineTopSpeed();	
	
	handleAcceleration();
	
	handleHorizontalPixelAccumulation();
	handleVerticalPixelAccumulation();
	
	handleHorizontalMovement();
	handleVerticalMovement();
}

///@func determineTopSpeed()
determineTopSpeed = function()
{
	if (state == player_state.open)
	{current_top_speed = global.player_1.max_open_speed;}
	else
	{current_top_speed = global.player_1.max_speed;}
}

///@func handleAcceleration()
handleAcceleration = function()
{
	//Acceler8
	if (current_speed < current_top_speed)
	{
		var adjustment = (input_accelerate_held * global.player_1.accel_rate);
		var new_speed = current_speed + adjustment;
		
		//Cap to top speed
		if (new_speed > current_top_speed)
		{
			new_speed = current_top_speed;
		}
		
		//Update current_speed
		current_speed = new_speed;
	}
	
	//Deceler8
	if (current_speed != 0)
	{
		//if player makes no directional input
		//or player speed exceeds maximum
		if (!input_accelerate_held)
		|| (current_speed > current_top_speed)
		{
			//if player can decelerate without passing 0
			if (current_speed > global.player_1.decel_rate)
			{
				new_speed = current_speed - global.player_1.decel_rate; //current speed reduced by adjustment amount
			}
			else
			{
				new_speed = 0;
			}
			current_speed = new_speed;
		}
	}
}

///@func handleHorizontalPixelAccumulation()
handleHorizontalPixelAccumulation = function()
{
	//derive horizontal speed
	var h_speed = lengthdir_x(current_speed, direction);
	
	//accumulate and queue pixels
	horizontal_pixels_accumulated += h_speed;
	var integer_pixels = horizontal_pixels_accumulated div 1;
	horizontal_pixels_accumulated -= integer_pixels;
	horizontal_pixels_queued += integer_pixels;
	
	/*//if it's not possible to move in the queued direction,
	//clear the variables to prevent issues
	var h_sign = sign(horizontal_pixels_queued);
	var next_position_blocked = place_meeting(x+h_sign, y, obj_Parent_Collision);
	if (next_position_blocked)
	{
		horizontal_pixels_accumulated = 0;
		horizontal_pixels_queued = 0;
	}*/
}

///@func handleVerticalPixelAccumulation()
handleVerticalPixelAccumulation = function()
{
	//derive vertical speed
	var v_speed = lengthdir_y(current_speed, direction);
	
	//accumulate and queue pixels
	vertical_pixels_accumulated += v_speed;
	var integer_pixels = vertical_pixels_accumulated div 1;
	vertical_pixels_accumulated -= integer_pixels;
	vertical_pixels_queued += integer_pixels;
	
	/*//if it's not possible to move in the queued direction,
	//clear the variables to prevent issues
	var y_sign = sign(vertical_pixels_queued);
	var next_position_blocked = place_meeting(x, y+y_sign, obj_Parent_Collision);
	if (next_position_blocked)
	{
		vertical_pixels_accumulated = 0;
		vertical_pixels_queued = 0;
	}*/
}

///@func handleHorizontalMovement()
handleHorizontalMovement = function()
{
	var repetitions = abs(horizontal_pixels_queued);
	var adjustment = sign(horizontal_pixels_queued);
	
	repeat(repetitions)
	{
		if (requested_turn != 0)
		&& (alignedWithGrid())
		&& (x != last_turn_cell._x)
		{
			var requested_direction = direction - (90 * requested_turn);
			updatePlayerDirection(requested_direction);
			requested_turn = 0;
			updateLastTurnCell();
			horizontal_pixels_accumulated = 0;
			horizontal_pixels_queued = 0;
			break;
		}
		
		var next_position_blocked = place_meeting(x+adjustment, y, obj_Parent_Collision);
		
		if (next_position_blocked)
		{
			horizontal_pixels_accumulated = 0;
			horizontal_pixels_queued = 0;
			current_speed = 0;
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
	
	repeat(repetitions)
	{
		if (requested_turn != 0)
		&& (alignedWithGrid())
		&& (y != last_turn_cell._y)
		{
			var requested_direction = direction - (90 * requested_turn);
			updatePlayerDirection(requested_direction);
			requested_turn = 0;
			updateLastTurnCell();
			vertical_pixels_accumulated = 0;
			vertical_pixels_queued = 0;
			break;
		}
		
		var next_position_blocked = place_meeting(x, y+adjustment, obj_Parent_Collision);
		
		if (next_position_blocked)
		{
			vertical_pixels_accumulated = 0;
			vertical_pixels_queued = 0;
			current_speed = 0;
			break;
		}
		
		y += adjustment;
		
		vertical_pixels_queued -= adjustment;
	}
}

//Handle Sprites
///@func handleSprite()
handleSprite = function()
{
	if (state == player_state.open) {current_sprite = spr_Croc_Open_Mouth;}
	else {current_sprite = spr_Croc_Idle;}
}

//Handle Direction
///@func updatePlayerDirection(proposed_new_direction)
updatePlayerDirection = function(proposed_new_direction)
{
	var new_direction = proposed_new_direction;
	
	if (new_direction < 0) { new_direction += 360; }
	if (new_direction > 360) { new_direction -= 360; }
	
	direction = new_direction;
}

///@func updateLastTurnCell()
updateLastTurnCell = function()
{
	if (alignedWithGrid()) {last_turn_cell = {_x:x, _y:y};}
}