var adjust = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);

target_direction += adjust * -90;

requested_coords = { _x: mouse_x, _y: mouse_y };