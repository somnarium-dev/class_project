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
accel_rate = 0.01;
decel_rate = 0.02;

current_top_speed = max_move_speed;

// Set danger range.
if (danger_range < 0) { danger_range = global.consumable_default.danger_range; }

// Display
//sprite_index = consumable_sprite;

// Initialize.
state = consumable_state.swim;
behavior = consumable_behavior.roaming;

/*
=========================================================================================
 ASSIGNMENT
=========================================================================================

 This object should eventually become the new consumable parent.
 ----------------------------------------------------------------------------------------
 1. Review and take notes on what functions / properties your current parent has.
 2. Determine which of those are still required, and which are not.
 3. Work as a group to rebuild those items into this object.
 4. Create child objects to represent other types of consumables over time.
 
 Q1. Some obstacles in the game can move, but the grids in obj_Grid_Controller only
	 collect data when a room starts.
	 When should the grids update to account for moving obstacles?
	 What should be responsible for those updates?

 Q2. Frogs need to avoid collisions with obstacles, but not all obstacles.
	 How can you create a grid that excludes all barriers except for grass?
	 Can you make another that excludes all barriers except for trees?
	 How can you reference these selectively?
	 
=========================================================================================
*/