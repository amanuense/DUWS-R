
diag_log format["spawn_beacon.sqf"];

if (commandpointsblu1 < 1) exitWith {
    ["info",["spawn_beacon","Not enough Command Points (1CP)"]] call bis_fnc_showNotification;
};

_playerpos = [getPosWorld player, 5, 15, 1, 0, 1, 0] call BIS_fnc_findSafePos;

// CREATE MARKER (ICON)
_markername = format["beacon%1",profileName]; // Define marker name
_markerstr = createMarker [str(_markername), _playerpos];
_markerstr setMarkerShape "ICON";
str(_markername) setMarkerType "mil_unknown";
str(_markername) setMarkerColor "ColorYellow";
str(_markername) setMarkerText format["spawn_%1",profileName];
str(_markername) setMarkerSize [1, 1];

_my_respawn = [West, _playerpos, profileName] call BIS_fnc_addRespawnPosition;

//keep marker for 15 min
_sleeptime = 60*15;
if (debugmode) then {
    _sleeptime = 60;
}
sleep _sleeptime;


deleteMarker str(_markername);
_my_respawn call BIS_fnc_removeRespawnPosition;