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
	
		//[F]: Respawn both fish.	
		if (keyboard_check_pressed(ord("F")))
		{
			instance_create_layer(512, 288, "Instances", obj_Fish_Big);
			instance_create_layer(192, 192, "Instances", obj_Fish_Small);
		}
		
		//[T]: Empty Timer instantly.
		if (keyboard_check_pressed(ord("T")))
		{ 
			if (global.level_manager.state == 1) //level in progress
			{ global.time_remaining = 0; } 
		}
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
		
		var number_of_fish = array_length(global.all_current_fish);
		
		var draw_offset = 16;
		
		var draw_x = target_id.x + draw_offset;
		var draw_y = target_id.y + draw_offset;
		
		for (var i = 0; i < number_of_fish; i++)
		{
			var this_danger_range = global.all_current_fish[i].danger_range;
			
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

///@func updateArrayOfAllFish()
updateArrayOfAllFish = function()
{
	//First, empty the all_current_fish array.
	global.all_current_fish = [];
	
	//If there are no fish, we're done.
	if (!instance_exists(obj_Parent_Fish))
	{ exit; }
	
	//Get the total number of obj_parent_fish.
	var current_number_of_fish = instance_number(obj_Parent_Fish);
	for (var i = 0; i < current_number_of_fish; i++;)
	{
		//Then, get the id of each of those fish, and store it to the array.
	    global.all_current_fish[i] = instance_find(obj_Parent_Fish,i);
	}
}

///@func displayStateOfAllFish()
displayStateOfAllFish = function()
{
	//Count the total number of fish in the global array.
	var total_fish = array_length(global.all_current_fish);
	
	//Now, for every fish, draw the current state of the fish.
	//Offset the draw by 16 on x and y to improve data display.
	for (var i = 0; i < total_fish; i++;)
	{
		//Offset by 16 on x and y to improve data display.
		var this_x = global.all_current_fish[i].x + 16;
		var this_y = global.all_current_fish[i].y - 16;
		var this_current_state = global.all_current_fish[i].state;
		var this_current_state_string = global.state_string.fish[this_current_state];
	
		draw_text(this_x, this_y, $"{this_current_state_string}");
	}
}

///@func displayBehaviorOfAllFish()
displayBehaviorOfAllFish = function()
{
	//Count the total number of fish in the global array.
	var total_fish = array_length(global.all_current_fish);
	
	//Now, for every fish, draw the current ai of the fish.
	//Offset the draw by 16 on x and y to improve data display.
	for (var i = 0; i < total_fish; i++;)
	{
		//Offset by 16 on x and y to improve data display.
		var this_x = global.all_current_fish[i].x - 16;
		var this_y = global.all_current_fish[i].y + 16;
		var this_current_behavior = global.all_current_fish[i].behavior;
		var this_current_behavior_string = global.behavior_string.fish[this_current_behavior];
	
		draw_text_color(this_x, this_y, $"{this_current_behavior_string}", c_blue, c_blue, c_blue, c_blue, 1);
	}
}