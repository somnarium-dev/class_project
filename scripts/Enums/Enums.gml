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
	stun,
	push
}

enum consumable_state
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

enum consumable_behavior
{
	roaming,
	seeking_log,
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
	"stun",
	"push"
]

global.state_string.consumable = 
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


global.behavior_string.consumable =
[	
	"roaming",
	"seeking_log",
	"panic"
]