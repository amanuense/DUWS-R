#include "..\..\global_defines.h"

_handle = createDialog "info_radio";
waitUntil {dialog};
ctrlSetText [1211, format["%1",mission_number_of_zones_captured]];
ctrlSetText [1224, format["%1",mission_number_of_missions_done]];
ctrlSetText [14002, format["%1",WARCOM_blufor_ap]];
ctrlSetText [14003, format["%1",opfor_ap]];
ctrlSetText [14004, format["%1",missions_success]];
ctrlSetText [1802, format["%1 total experience",profileName]];
ctrlSetText [MENU_COMMAND_POINTS_BLU, format["XP: %1",experience_total]];

{
    _index = lbAdd [1551, _x];
} forEach mission_array_of_islands_captured;