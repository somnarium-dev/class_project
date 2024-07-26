/// @description Insert description here
// You can write your code in this editor

alarm_set(2, 90);

if (previous_behavior == consumable_behavior.seeking_grass)
{ behavior = consumable_behavior.seeking_log; }

if (previous_behavior == consumable_behavior.seeking_log)
{ behavior = consumable_behavior.seeking_grass; }

// i dont like this, it seesaws too much, I need edits.