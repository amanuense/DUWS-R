// usage: [position, radius] execvm "createpatrol.sqf"
// radius: 50 for patrol inside and around base, 500 for medium lenght skirmish, 1300 for island

_position = _this select 0;
_radius   = _this select 1;

diag_log format["createpatrolsqf"];
_safePosition = [_position, 10, 50, 3, 0, 1, 0] call BIS_fnc_findSafePos;
_group = [_safePosition, WEST, ["B_Soldier_TL_F","B_Soldier_F"]] call BIS_fnc_spawnGroup;
_patrolRadius = round(_radius/3);
[_group, _safePosition, _patrolRadius] call bis_fnc_taskPatrol;