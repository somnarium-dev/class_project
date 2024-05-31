//Listen for debug commands when the control key is held down.
if (keyboard_check(vk_control))
{
	//[G]: Toggle display of debug data.
	if (keyboard_check_pressed(ord("G")))
	{ global.debug_data_enabled = !global.debug_data_enabled; }
	
	//[OTHER KEY]: Other thing.
	//Stuff.
	
	//[F]: Respawn both fish.
	if (!global.debug_data_enabled)
	{ exit; }
	
	if (keyboard_check_pressed(ord("F")))
	{
		instance_create_layer(512, 288, "Instances", obj_Fish_Big);
		instance_create_layer(192, 192, "Instances", obj_Fish_Small);
	}
}