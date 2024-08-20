// Load custom methods.
event_user(0);
event_user(1);
event_user(2);

// Internal.
is_paused = false;
random_turn_available = true;

// Movement.
intended_direction = 0;					// The direction behavior *wants* to move along.

requested_coords = { _x: -1, _y: -1 };	// Where behavior *wants* to go.
target_coords = { _x: -1, _y: -1 };		// Where state *is* going.

current_path = undefined;				// The path being used to guide state along, right now. Undefined when no clear path to target_coords exists.

// Stats.
current_top_speed = max_move_speed;

// Set danger range.
if (danger_range < 0) { danger_range = global.consumable_default.danger_range; }

// Display
sprite_index = consumable_sprite;

// Initialize.
state = consumable_state.swim;
behavior = consumable_behavior.roaming;