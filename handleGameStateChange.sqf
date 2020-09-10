params ['_isGameOn']; 


Shoothouse_DamageHandler = {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

	// if friendly fire is allowed and teams are not the same, set as surrendered
	if (Shoothouse_allow_ff) then {
		[_unit, true] call ACE_captives_fnc_setSurrendered; // comes with ACE3
	} else {
		if ((_unit getVariable 'Shoothouse_team') != (_instigator getVariable 'Shoothouse_team')) then {
			[_unit, true] call ACE_captives_fnc_setSurrendered;
		};
	};
};

_playerList = Shoothouse_red_team_players + Shoothouse_blue_team_players;

if (_isGameOn) then {
	// when the game starts, prepare the event handlers
	// go through the list of players and see which ones are local (AI OR CURRENT PLAYER) and do the same as the above to them
	{   
		if (local _x) then {
			_x allowDamage false;
			_handlerId = _x addEventHandler ["HandleDamage", Shoothouse_DamageHandler]; 
			_x setVariable ['Shoothouse_damageHandlerId', _handlerId];
		};
	} forEach _playerList; 

	// You can put a ton of other scripts that should run locally too!
	// Like, you might want to play a starting sound here (it will run for all players though, remember about that)
	// Etc etc

	hint 'GAME START!';

} else {
	hint 'END EX!';

	// when the game ends, clean up
	{ 
		if (local _x) then {
			[_x, false] call ACE_captives_fnc_setSurrendered;
			_x allowDamage true;

			_handlerId = _x getVariable ['Shoothouse_damageHandlerId', -1];

			if (_handlerId != -1) then {
				_x removeEventHandler ['HandleDamage', _handlerId];
				_X setVariable ['Shoothouse_damageHandlerId', nil];
			};		
		};
	} forEach _playerList; 
};