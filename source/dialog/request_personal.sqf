#include "..\global_defines.h"
#include "..\unit_data.h"

_index = lbCurSel MENU_BLU_PERSONAL_REQUEST;

//all values in this switch are related to the values set on request.sqf.
diag_log format["request_personal.sqf"];

_element_array = _menu_request_personal_support select _index;
_menu_item     = _element_array select 0;
_text          = _element_array select 1;
_cost          = _element_array select 2;
_comm_menu     = _element_array select 3;
_is_purchased  = personal_purchased select _index;

diag_log format["requested: %1, menu: %2, cost: %3", _text, _menu_item, _cost];
if (_is_purchased == 0) then {
    if (commandpointsblu1 >= _cost) then {
        diag_log format["requesting %1", _text];
        commandpointsblu1 = commandpointsblu1 - _cost;
        ctrlSetText [MENU_COMMAND_POINTS_BLU, format["%1",commandpointsblu1]];
        //this will add the item to the current player
        if !(_comm_menu == "") then { [player, _comm_menu] call BIS_fnc_addCommMenuItem; };
        lbSetColor [_menu_item, _index, [0, 1, 0, 1]];

        personal_purchased set [_index,1];
    } else {
        hint "Not enough command points";
    };
} else {
    hint "This support is already available";
};

publicVariable "commandpointsblu1";
