/// @function checkForImpassable
/// @description Populate impassable_list with all instances of obj_parent_collision at the provided coordinates.
/// If any of these instances has an impassable property set to true, this will return that a collision is detected.
/// Any instances the caller is already inside of will be ignored.
/// Likewise any instances with an object_index found in collision_ignore_array will also be ignored.
/// @param {int} _x The x coordinate to check.
/// @param {int} _y The y coordinate to check.
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
		
		// If this object is in the collision ignore array, skip it.
		var this_object_is_ignored = false;
		
		for (var ii = 0; ii < array_length(collision_ignore_array); ii++)
		{
			if (this_object.object_index == collision_ignore_array[ii])
			|| (object_is_ancestor(this_object.object_index, collision_ignore_array[ii]))
			{
				this_object_is_ignored = true;
				break;
			}
		}
		
		// otherwise check if impassable.
		if (this_object.impassable)
		&& (!this_object_is_ignored)
		{ 
			return true; 
		}
	}
	return false;
}