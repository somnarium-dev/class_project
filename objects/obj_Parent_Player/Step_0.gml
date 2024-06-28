handlePauseTransition();

if ( global.level_manager.state == level_state.paused )
{ exit; }

state_machine[state]();