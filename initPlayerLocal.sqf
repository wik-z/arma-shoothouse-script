
// INSTRUCTOR'S ACTIONS
COMPUTER addAction ['Start Shoothouse Game', {
	call Shoothouse_start_game;
}, nil, 1.5, true, true, '', '!Shoothouse_playing'];

COMPUTER addAction ['Stop Shoothouse Game', {
	call Shoothouse_stop_game;
}, nil, 1.5, true, true, '', 'Shoothouse_playing'];


// PLAYER ACTIONS
COMPUTER addAction ['Join Team RED', {
	params ['_target', '_caller'];

	[_caller, 'RED'] call Shoothouse_player_join_team;
}, nil, 1.5, true, true, '', 'player != INSTRUCTOR && (player getVariable ["Shoothouse_team", ""]) == ""'];


COMPUTER addAction ['Join Team BLUE', {
	params ['_target', '_caller'];

	[_caller, 'BLUE'] call Shoothouse_player_join_team;
}, nil, 1.5, true, true, '', 'player != INSTRUCTOR && (player getVariable ["Shoothouse_team", ""]) == ""'];


'Shoothouse_playing' addPublicVariableEventHandler {
	params ['_name', '_value'];

	[_value] execVM 'handleGameStateChange.sqf';
};