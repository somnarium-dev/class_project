function loadAllLevelData()
{
	global.level_data = [];

	// Level 0
	global.level_data[0] = 
	{
		time_limit: 999,
		objective_score: 2,
		music: undefined,
		next_level: 0
	}
	// Level 1
	global.level_data[1] = 
	{
		time_limit: -1,
		objective_score: 2,
		music: undefined,
		next_level: 2
	}
	// Level 2
	global.level_data[2] = 
	{
		time_limit: -1,
		objective_score: 1,
		music: undefined,
		next_level: 3
	}
}