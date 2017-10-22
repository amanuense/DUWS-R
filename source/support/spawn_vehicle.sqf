#include "..\global_defines.h"

_pos  = _this select 0;
_name = _this select 1;
_cost = _this select 2;

_vehic = nil;

_spawn_marker = {
    _spawnPos = _this select 0;
    _markername = str(format ["%1%2",_spawnPos select 0,_spawnPos select 1]);
    _markerstr = createMarker [_markername, _spawnPos];
    _markerstr setMarkerShape "ICON";
    _markerstr setMarkerType "hd_dot";
    _markerstr setMarkerColor "ColorBlue";
    _markerstr setMarkerSize [1, 1];
    _markerstr setMarkerText "vehicle";
    sleep 60;
    deletemarker _markerstr;
};

if (commandpointsblu1 >= _cost) then {
    hint "Vehicle ready! check map for location";
    commandpointsblu1 = commandpointsblu1 - _cost;
    ctrlSetText [MENU_COMMAND_POINTS_BLU, format["%1",commandpointsblu1]];
    //spawning the vehicle in 0.0.0 then moving it is faster than spawning it in a specific location.
    _vehic = _name createVehicle [0,0,0];
    _vehic setPos (_pos);
    //create a marker for the new vehicle
    [_pos] spawn _spawn_marker;
} else {
    hint "Not enough command points";
};
_vehic