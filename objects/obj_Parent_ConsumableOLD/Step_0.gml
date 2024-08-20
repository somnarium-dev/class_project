handlePauseTransition();

if ( global.level_manager.state == level_state.paused )
{ exit; }

behavior_machine[behavior]();
state_machine[state]();