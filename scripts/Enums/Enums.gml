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
	swim,
	panic
}

enum fish_behavior
{
	roaming
}