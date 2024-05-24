///@desc Custom Methods

///@func displayCrocodileCurrentSpeed()
displayCrocodileCurrentSpeed = function()
{
	if (global.current_player_instance != noone)
	&& (instance_exists(global.current_player_instance))
	{
		//Offset by 16 on x and y to improve data display.
		var this_x = global.current_player_instance.x + 16;
		var this_y = global.current_player_instance.y - 16;
		var this_current_speed = global.current_player_instance.current_speed;
	
		draw_text(this_x, this_y, $"{this_current_speed}");
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