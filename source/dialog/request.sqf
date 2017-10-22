#include "..\global_defines.h"
#include "..\unit_data.h"


_handle = createDialog "ressourceheader";
waitUntil {dialog};
ctrlSetText [MENU_COMMAND_POINTS_BLU, format["%1",commandpointsblu1]];
ctrlSetText [MENU_ZONES_CONTROL_BLU, format["%1",zoneundercontrolblu]];
ctrlSetText [WARCOM_BLU_AP, format["%1",WARCOM_blufor_ap]];

//TODO compile or move to other file
//TODO possible optimization is to remove menu_item from the array
add_menu_items = {
    _array     = _this select 0;
    {
        lbAdd [ (_x select 0), format ["%1(%2 CP)", (_x select 1), (_x select 2)] ];
    }forEach _array;
    lbSetCurSel [(_array select 0) select 0, 0];
};


//this code adds all elements to the menu
[_menu_request_unit_items]    call add_menu_items;
[_menu_request_squad_items]   call add_menu_items;
[_menu_request_vehicle_items] call add_menu_items;
[_menu_request_support_items] call add_menu_items;

//requested support items require a different color
{
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, _forEachIndex, [1, 0, 0, 1]];
}forEach _menu_request_support_items;
