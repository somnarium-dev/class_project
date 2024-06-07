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

global.behavior_string={};

global.behavior_string.fish =
[	
	"roaming",
	"panic"
]

global.state_string.twig =
[
	"still",
	"move",
	"eaten"
]

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

enum fish_behavior
{
	roaming,
	panic
}

enum twig_state
{
	still,
	move,
	eaten
}