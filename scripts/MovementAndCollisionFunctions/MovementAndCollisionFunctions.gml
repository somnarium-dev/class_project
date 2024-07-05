//I AM HUNGRY FEED ME JSDOC
function checkForImpassable(_x, _y)
{
	if (!process_collision_detection) { return false; }
	
	ds_list_clear(impassable_list);
	
	var _num = instance_place_list(_x, _y, obj_Parent_Collision, impassable_list, true);
	
	for (var i = 0; i < _num; i++)
	{
		var this_object = impassable_list[|i];
		
		//this is to make sure we can't get stuck inside of objects.
		if (instance_place(x, y, this_object))
		{ continue; }
		
		if (this_object.impassable)
		{
			return true;
		}
	}
	
	return false;
}