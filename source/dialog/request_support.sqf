#include "..\global_defines.h"
#include "..\unit_data.h"

_index = lbCurSel MENU_BLU_SUPPORT_REQUEST;

//all values in this switch are related to the values set on request.sqf.
diag_log format["request_support.sqf"];

_element_array = _menu_request_support_items select _index;
_menu_item     = _element_array select 0;
_text          = _element_array select 1;
_cost          = _element_array select 2;
_comm_menu     = _element_array select 3;
_is_purchased  = support_purchased select _index;

diag_log format["requested: %1, menu: %2, cost: %3", _text, _menu_item, _cost];
if (_is_purchased == 0) then {
    if (commandpointsblu1 >= _cost) then {
        diag_log format["requesting %1", _text];
        commandpointsblu1 = commandpointsblu1 - _cost;
        ctrlSetText [MENU_COMMAND_POINTS_BLU, format["%1",commandpointsblu1]];
        //this will add the item to the current player
        if !(_comm_menu == "") then { [player, _comm_menu] call BIS_fnc_addCommMenuItem; };
        lbSetColor [_menu_item, _index, [0, 1, 0, 1]];
        //announcing the var to all players
        support_purchased set [_index,1];
        publicVariable "support_purchased";

        //handle special cases
        //armory
        if (_text == "Armory") then {
            support_armory_available = true;
            hq_blu1 addaction ["<t color='#ff0066'>Armory (VA)</t>","support\bisArsenal.sqf", "", 0, true, true, "", "_this == player"];
            {
                _x addaction ["<t color='#ff0066'>Armory 2 (VA)</t>","support\bisArsenal.sqf", "", 0, true, true, "", "_this == player"];
            } count (Array_of_FOBS);
            publicVariable "support_armory_available";
            ["armory",["Armory Unlocked","Access the armory at the HQ and at the dropped supply crates"]] call bis_fnc_showNotification;
        };
        //troop training
        if (_text == "Specialized Infantry training") then {
            blufor_ai_skill = [(blufor_ai_skill select 0)+0.3,(blufor_ai_skill select 1)+0.3];
            support_specialized_training_available = true;
            publicVariable "support_specialized_training_available";
            publicVariable "blufor_ai_skill";
            ["inf_training",["Specialized Infantry training","Our troops are now more skilled in battle"]] call bis_fnc_showNotification;
        };
    } else {
        hint "Not enough command points";
    };
} else {
    hint "This support is already available";
};

publicVariable "commandpointsblu1";
