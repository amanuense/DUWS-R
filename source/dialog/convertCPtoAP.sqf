#include "..\global_defines.h"

if (commandpointsblu1 < 10) exitWith {hint "You don't have enough CP to convert into AP";};

commandpointsblu1 = commandpointsblu1 - 10;
WARCOM_blufor_ap = WARCOM_blufor_ap + 15;

ctrlSetText [MENU_COMMAND_POINTS_BLU, format["%1",commandpointsblu1]];
ctrlSetText [WARCOM_BLU_AP, format["%1",WARCOM_blufor_ap]];

publicVariable "commandpointsblu1";
publicVariable "WARCOM_blufor_ap";

hint "Conversion successful";
