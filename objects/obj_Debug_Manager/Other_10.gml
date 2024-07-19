///@desc Custom Methods

///@func takeDebugInput()
takeDebugInput = function()
{
	//Listen for debug commands when the control key is held down.
	if (keyboard_check(vk_control))
	{
		//[G]: Toggle display of debug data.
		if (keyboard_check_pressed(ord("G")))
		{ global.debug_data_enabled = !global.debug_data_enabled; }
	
		//[OTHER KEY]: Other thing.
		//Stuff.
	
		//[F]: Respawn both fish and frog.	
		if (keyboard_check_pressed(ord("F")))
		{
			instance_create_layer(512, 288, "Consumables", obj_Fish_Big);
			instance_create_layer(192, 192, "Consumables", obj_Fish_Small);
			instance_create_layer(480, 96, "Consumables", obj_Frog);
		}
		
		//[T]: Empty Timer instantly.
		if (keyboard_check_pressed(ord("T")))
		{ 
			if (global.level_manager.state == 1) //level in progress
			{ global.time_remaining = 0; } 
		}
		
		//[P]: Add 1 point to the points total.
		if (keyboard_check_pressed(ord("P")))
		{ 
			if (global.level_manager.state == 1) //level in progress
			{ increaseScore(1) } 
		}
		
		//[TAB]: Restart the game.
		if (keyboard_check_pressed(vk_tab))
		{ game_restart(); }
		
	}
}

///@func displayCrocodileCurrentSpeed()
displayCrocodileCurrentSpeed = function()
{
	if (global.player_1.current_id != noone)
	&& (instance_exists(global.player_1.current_id))
	{
		var target_id = global.player_1.current_id;
		
		//Offset by 16 on x and y to improve data display.
		var this_x = target_id.x + 16;
		var this_y = target_id.y - 32;
		var this_current_speed = target_id.current_speed;
	
		draw_text(this_x, this_y, $"{this_current_speed}");
	}
} 

///@func displayCrocodileCurrentState()
displayCrocodileCurrentState = function()
{
	if (global.player_1.current_id != noone)
	&& (instance_exists(global.player_1.current_id))
	{
		var target_id = global.player_1.current_id;
		
		//Offset by 16 on x and y to improve data display.
		var this_x = target_id.x + 16;
		var this_y = target_id.y - 16;
		var this_current_state = target_id.state;
		var this_current_state_string = global.state_string.player[this_current_state];
	
		draw_text_color(this_x, this_y, $"{this_current_state_string}", c_blue, c_blue, c_blue, c_blue, 1);
	}
} 

///@func displayCrocodileDangerRanges()
displayCrocodileDangerRanges = function()
{
	//If there are no fish, we're done.
	if (!instance_exists(obj_Parent_Fish))
	{ exit; }
	
	if (global.player_1.current_id != noone)
	&& (instance_exists(global.player_1.current_id))
	{
		var target_id = global.player_1.current_id;
		
		var danger_ranges = [];
		
		var number_of_fish = array_length(global.all_current_consumables);
		
		var draw_offset = 16;
		
		var draw_x = target_id.x + draw_offset;
		var draw_y = target_id.y + draw_offset;
		
		for (var i = 0; i < number_of_fish; i++)
		{
			var this_danger_range = global.all_current_consumables[i].danger_range;
			
			var is_unique_range = !array_contains(danger_ranges, this_danger_range);
			
			if (is_unique_range)
			{
				draw_circle_color
				(
					draw_x,
					draw_y,
					this_danger_range,
					c_red,
					c_red,
					true
				);
			}
		}
	}
}

///@func updateArrayOfAllConsumables()
updateArrayOfAllConsumables = function()
{
	//First, empty the all_current_consumables array.
	global.all_current_consumables = [];
	
	//If there are no fish, we're done.
	if (!instance_exists(obj_Parent_Consumable))
	{ exit; }
	
	//Get the total number of obj_parent_consumable.
	var current_number_of_consumables = instance_number(obj_Parent_Consumable);
	for (var i = 0; i < current_number_of_consumables; i++;)
	{
		//Then, get the id of each of those consumables, and store it to the array.
	    global.all_current_consumables[i] = instance_find(obj_Parent_Consumable,i);
	}
}

///@func displayStateOfAllConsumables()
displayStateOfAllConsumables = function()
{
	//Count the total number of consumables in the global array.
	var total_consumables = array_length(global.all_current_consumables);
	
	//Now, for every consumable, draw the current state of the consumable.
	//Offset the draw by 16 on x and y to improve data display.
	for (var i = 0; i < total_consumables; i++;)
	{
		//Offset by 16 on x and y to improve data display.
		var this_x = global.all_current_consumables[i].x + 16;
		var this_y = global.all_current_consumables[i].y - 16;
		var this_current_state = global.all_current_consumables[i].state;
		var this_current_state_string = global.state_string.consumable[this_current_state];
	
		draw_text(this_x, this_y, $"{this_current_state_string}");
	}
}

///@func dispolayBehaviorOfAllConsumables()
dispolayBehaviorOfAllConsumables = function()
{
	//Count the total number of consumables in the global array.
	var total_consumables = array_length(global.all_current_consumables);
	
	//Now, for every consumable, draw the current behavior of the consumable.
	//Offset the draw by 16 on x and y to improve data display.
	for (var i = 0; i < total_consumables; i++;)
	{
		//Offset by 16 on x and y to improve data display.
		var this_x = global.all_current_consumables[i].x - 16;
		var this_y = global.all_current_consumables[i].y + 16;
		var this_current_behavior = global.all_current_consumables[i].behavior;
		var this_current_behavior_string = global.behavior_string.consumable[this_current_behavior];
	
		draw_text_color(this_x, this_y, $"{this_current_behavior_string}", c_blue, c_blue, c_blue, c_blue, 1);
	}
}