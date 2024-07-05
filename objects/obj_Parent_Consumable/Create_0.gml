// Inherit the parent event
event_inherited();

// Simulated Inputs
ai_input_lr = 0;
ai_input_ud = 0;
ai_input_panic_boost = 0;

ai_input_accelerate = 0;

// Movement and collision detection.
horizontal_pixels_accumulated = 0;
horizontal_pixels_queued = 0;

vertical_pixels_accumulated = 0;
vertical_pixels_queued = 0;

current_speed = 0;

// Stats
current_top_speed = max_swim_speed;
//accel_rate = 0.2;

// Internal properties
direction = initial_direction;
random_turn_available = true;
impassable = false;

// Initialize.
state = consumable_state.swim;
behavior = consumable_behavior.roaming;