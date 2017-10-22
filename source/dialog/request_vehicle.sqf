#include "..\global_defines.h"
#include "..\unit_data.h"
_index = lbCurSel MENU_BLU_VEHICLE_REQUEST;

diag_log format["request_vehicle.sqf"];
//for the moment we won't use hq blu position since we might open vehicle spawning to FOBs
_spawnPos = getPosWorld player;
//get a safe location to spawn the vehicle.
_spawnPos = [_spawnPos, 20, 50, 3, 0, 1, 0] call BIS_fnc_findSafePos;

//[menu_item, string, cost, unit_type]
_element_array = _menu_request_vehicle_items select _index;

[_spawnPos, (_element_array select 3), (_element_array select 2)] call spawn_vehicle_fn;

publicVariable "commandpointsblu1";
