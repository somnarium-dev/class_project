function LightsenInitialize()
{

}

function turnTowardsDirection(_target_direction, _turn_degrees)
{
	var return_data = direction;
	
	var angle_direction = dsin(_target_direction - direction);
	
	if (angle_direction > 0) { return_data += _turn_degrees; }
	if (angle_direction < 0) { return_data -= _turn_degrees; }
	
	return return_data;
}