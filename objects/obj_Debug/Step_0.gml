//Listen for debug commands when the control key is held down.
if (keyboard_check(vk_control))
{
	//[G]: Toggle display of debug data.
	if (keyboard_check_pressed(ord("G")))
	{ global.debug_data_enabled = !global.debug_data_enabled; }
	
	//[OTHER KEY]: Other thing.
	//Stuff.
}