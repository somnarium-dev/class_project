// Inherit the parent event
event_inherited();

// Load custom methods.
event_user(0);
event_user(1);
event_user(2);

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

collision_ignore_array = [];

// Stats
current_top_speed = max_move_speed;
accel_rate = 0.2;

// Set danger range.
if (danger_range < 0) { danger_range = global.consumable_default.danger_range; }

// Display
sprite_index = consumable_sprite;

// Internal properties
direction = initial_direction;
random_turn_available = true;
impassable = false;
is_paused = false;

// Initialize.
state = consumable_state.swim;
behavior = consumable_behavior.roaming;