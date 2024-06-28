/// @desc Custom Methods

///@func loadLevelData()
loadLevelData = function()
{
	var this_level_index = 0;
	var total_number_of_levels = array_length(global.level_data) - 1;
	
	if (global.current_level <= total_number_of_levels) { this_level_index = global.current_level; }
	
	var data = global.level_data[this_level_index];
	
	level_time_limit = data.time_limit * global.game_fps;
	level_score_target = data.objective_score;
	level_music = data.music;
	next_level = data.next_level;
}

///@func createHUD()
createHUD = function()
{
	room_hud = instance_create_layer(0, 0, "HUD", obj_Game_HUD, {room_time_limit: level_time_limit});
}

///@func checkLevelCompletion()
checkLevelCompletion = function()
{
	var level_is_complete = false;
	var level_is_failed = false;
	
	// when no time is remaining, complete the level if...
	if (global.time_remaining < 1)
	{	
		// level score objective is met.
		if (level_score_target > 0)
		{ 
			if (global.player_1.point_total >= level_score_target) 
			{ level_is_complete = true; }
			
			else { level_is_failed = true; }
		}
	}

	if (level_is_complete) { state = level_state.complete; }
	else if (level_is_failed) { state = level_state.failed; }
}

///@func handleLevelCompletion()
handleLevelCompletion = function()
{
	// disable player control
	// display victory notification
	// play victory jingle
	// delay x seconds
	// go to next level
	global.player_1.point_total = 0;
	global.current_level = next_level;
	//room_goto(next_level); not yet implemented.
	room_goto(room);
	
	state = level_state.loading;
}

///@func handleLevelFailure()
handleLevelFailure = function()
{
	// disable player control
	// display failure notification
	// play failure jingle
	// delay x seconds
	// reduce lives by 1
	// restart level or game over
	
	game_end();
}

///@func toggleLevelPause()
toggleLevelPause = function()
{
	if ( keyboard_check_pressed(vk_escape) )
	{ 
		if ( state == level_state.in_progress )
		{ state = level_state.paused; }
		
		else if ( state == level_state.paused )
		{ state = level_state.in_progress; }
	}
}

///@func getScreenSpaceEffectCoordinates()
getScreenSpaceEffectCoordinates = function()
{
	screen_effect_x = room_width / 2;
	screen_effect_y = room_height / 2;
	
	// The game does not currently utilise a camera.
	// Because of this, we cannot yet implement positioning
	// of screen space effects relative to the camera's point of view.
	// This is a job for later.
	
	// When the camera is implemented, 
	// screen_effect_x will need to equal
	// the camera's x position plus half of the viewpoint width.
	// Y will be set similarly.
}