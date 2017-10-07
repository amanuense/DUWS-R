// usage: [position, radius] execvm ""support\createoppatrol.sqf"
// radius: 50 for patrol inside and around base, 500 for medium lenght skirmish, 1300 for island

_position = _this select 0;
_radius   = _this select 1;

diag_log format["support\createopwpteam.sqf"];
// hint format["%1",_position];
_safePosition = [_position, 10, 50, 3, 0, 1, 0] call BIS_fnc_findSafePos;
_group = [_safePosition, EAST, ["O_Soldier_TL_F","O_Soldier_AA_F","O_Soldier_AT_F"],[],[],opfor_ai_skill] call BIS_fnc_spawnGroup;
_patrolRadius = round(_radius/2);
[_group, _safePosition, _patrolradius] call bis_fnc_taskPatrol;

//_skill = skill leader _group;
//player globalchat format["%1",_skill]; 
// ADD QRF eventhandler
_EH = leader _group addEventHandler ["Fired", {[_this select 0] spawn QRF_test}];