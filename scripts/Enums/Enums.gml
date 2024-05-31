global.state_string={};

global.state_string.player = 
[
	"stand",
	"swim",
	"open",
	"eat",
	"reverse"
]

global.state_string.fish =
[	
	"still",
	"swim",
]

global.behavior_string={};

global.behavior_string.fish =
[	
	"roaming",
	"panic"
]

enum player_state
{	
	stand,
	swim,
	open,
	eat,
	reverse
}

enum fish_state
{	
	still,
	swim
}

enum fish_behavior
{
	roaming,
	panic
}