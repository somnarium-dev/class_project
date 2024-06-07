//-------------------------
// STATE ENUMS
//-------------------------

enum level_state
{
	loading,
	in_progress,
	complete,
	failed,
	paused
}

enum player_state
{	
	stand,
	swim,
	open,
	eat,
	reverse,
	stun
}

enum fish_state
{	
	still,
	swim,
	eaten
}

enum twig_state
{
	still,
	move,
	eaten
}

//-------------------------
// BEHAVIOR ENUMS
//-------------------------

enum fish_behavior
{
	roaming,
	panic
}

//-------------------------
// STATE STRING ARRAYS
//-------------------------

global.state_string={};

global.state_string.player = 
[
	"stand",
	"swim",
	"open",
	"eat",
	"reverse",
	"stun"
]

global.state_string.fish =
[	
	"still",
	"swim",
	"eaten"
]

global.state_string.twig =
[
	"still",
	"move",
	"eaten"
]

//-------------------------
// BEHAVIOR STRING ARRAYS
//-------------------------

global.behavior_string={};

global.behavior_string.fish =
[	
	"roaming",
	"panic"
]