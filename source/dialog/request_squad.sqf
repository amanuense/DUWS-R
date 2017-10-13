#include "..\global_defines.h"
#include "..\unit_data.h"

//TODO parametrize this file!!!

_index = lbCurSel MENU_BLU_SQUAD_REINFORCE;

_spawnPos = getPosWorld hq_blu1;
_spawnPos = [_spawnPos, 10, 50, 3, 0, 1, 0] call BIS_fnc_findSafePos;

_element_array = _menu_request_squad_items select _index;

_groupid = 0;

//[menu_item, string, cost, unit_type, group_prefix]
_cost = (_element_array select 2);
_grouptype = (_element_array select 3);
 if (commandpointsblu1 >= _cost) then {
	commandpointsblu1 = commandpointsblu1 - _cost;
	ctrlSetText [MENU_COMMAND_POINTS_BLU, format["%1",commandpointsblu1]];
	
	_group = [_spawnPos, WEST, _grouptype, [], [], blufor_ai_skill] call BIS_fnc_spawnGroup;
	player hcsetgroup [_group,""];	
	_groupid = (squad_counters select _index) + 1;
	squad_counters set [_index, _groupid ]; //increase counter
	_group setGroupId [format["%1 %2", (_element_array select 4), _groupid]];
	hint "Squad ready !\nAccess it with [L.CTRL - SPACE]";
 } else {
	 hint "Not enough command points";
 };

publicVariable "commandpointsblu1";