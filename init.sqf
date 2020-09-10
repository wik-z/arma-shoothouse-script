Shoothouse_playing = false; // true if the shoothouse game is on!
Shoothouse_allow_ff = false; // true if friendly fire should be on

Shoothouse_blue_team_players = [];
Shoothouse_red_team_players = [];


// function to be called when the game starts
Shoothouse_start_game = {
	Shoothouse_playing = true;
	publicVariable 'Shoothouse_playing';

	{ 
		_x setObjectTextureGlobal [0, '#(rgb,8,8,3)color(0,0,1,1)'];
	} forEach Shoothouse_blue_team_players;

	{ 
		_x setObjectTextureGlobal [0, '#(rgb,8,8,3)color(1,0,0,1)'];
	} forEach Shoothouse_red_team_players;

	[true] execVM 'handleGameStateChange.sqf';
};

// function to be called when the game ends
Shoothouse_stop_game = {
	Shoothouse_playing = false;
	publicVariable 'Shoothouse_playing';
	
	[false] execVM 'handleGameStateChange.sqf';
};


Shoothouse_player_join_team = {
	params ['_unit', '_team'];

	_unit setVariable ['Shoothouse_team', _team, true];


	if (_team == 'RED') then {
		Shoothouse_red_team_players pushBack _unit;
		publicVariable 'Shoothouse_red_team_players';
	} else {
		Shoothouse_blue_team_players pushBack _unit;
		publicVariable 'Shoothouse_blue_team_players';
	};
};
