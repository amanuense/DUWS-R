#include "..\global_defines.h"
#include "..\unit_data.h"

_index = lbCurSel MENU_BLU_UNIT_REQUEST;

_skill = (blufor_ai_skill select 0);
_spawnpos = [(getPosWorld hq_blu1 select 0)-8, (getPosWorld hq_blu1 select 1)-3.5];

//select the row matching the index
_element_array = _menu_request_unit_items select _index;

//todo compileFinal

//[menu_item, string, cost, unit_type, rank, skill_modifier]
if (commandpointsblu1 >= (_element_array select 2)) then {
    hint "Unit ready !";
    commandpointsblu1 = commandpointsblu1 - (_element_array select 2);
    ctrlSetText [_element_array select 0, format["%1",commandpointsblu1]];
    _group = group player;
    (_element_array select 3) createUnit [_spawnpos, _group, "", _skill + (_element_array select 5), (_element_array select 4)] ;
} else {
    hint "Not enough command points";
};

//hint format["AI skill: %1",_skill];
publicVariable "commandpointsblu1";
//hint format["index: %1",_index];