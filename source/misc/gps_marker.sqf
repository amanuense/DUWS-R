_player_has_gps_marker = false;
private ["_markername"];

_playuid = getPlayerUID player;
_markername = format["gps%1", _playuid]; // --START CREATE MARKER--
diag_log format["creating marker: %1", _markername];

while {true} do {
	//if the player has no marker check for GPS, if the player has a GPS create the marker.
	while {!_player_has_gps_marker} do {
		//TODO find out why didn't like the sum.
		_number = assignedItems player find "ItemGPS";
		_number2 = assignedItems player find "B_UavTerminal";
		if(!_player_has_gps_marker) then {
			if (_number != -1 || _number2 != -1) then { // Check if player has a gps assigned, if yes create marker
				_markerstr = createMarker [str(_markername), getPosWorld player];
				diag_log format["creating marker: %1", _markername];
				_markerstr setMarkerShape "ICON";
				_markerstr setMarkerType "mil_arrow2";
				_markerstr setMarkerColor "ColorGreen";
				_markerstr setMarkerSize [0.3, 0.5];
				_markerstr setMarkerText format["%1",profileName];
				_player_dir = getDir player;
				_markerstr setmarkerdir _player_dir;
				_player_has_gps_marker = true;
			};	// --END CREATE MARKER--
			sleep 5;
		};
	};
	//if the player has marker update it.
	while {_player_has_gps_marker} do {
		_player_dir = getDir player;
		str(_markername) setmarkerdir _player_dir;
		str(_markername) setMarkerPos getPosWorld player;
		_number = assignedItems player find "ItemGPS";
		_number2 = assignedItems player find "B_UavTerminal";
		if (_number == -1 && _number2 == -1) then {
			_player_has_gps_marker = false;
			deletemarker str(_markername);
		};
		sleep 1;
	};
	sleep 5;
};