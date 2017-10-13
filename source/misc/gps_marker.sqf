_player_has_gps_marker = false;
private ["_markername"];

_playuid = getPlayerUID player;
_markername = format["gps%1", _playuid]; // --START CREATE MARKER--
diag_log format["creating marker: %1", _markername];

while {true} do {
	_player_dir = getDir player;
	//if the player has no marker check for GPS, if the player has a GPS create the marker.    
	_found = "ItemGPS" in assignedItems player;
	_found =  _found || "B_UavTerminal" in assignedItems player;
	diag_log format["gps found: %1", _found];
	if(!_player_has_gps_marker && _found) then {
		_markerstr = createMarker [str(_markername), getPosWorld player];
		diag_log format["creating marker: %1", _markername];
		_markerstr setMarkerShape "ICON";
		_markerstr setMarkerType "mil_arrow2";
		_markerstr setMarkerColor "ColorGreen";
		_markerstr setMarkerSize [0.3, 0.5];
		_markerstr setMarkerText format["%1",profileName];
		_player_has_gps_marker = true;
	};

	if(_player_has_gps_marker) then {
		if !(_found) then {
			_player_has_gps_marker = false;
			deletemarker str(_markername);
		} else {
			str(_markername) setmarkerdir _player_dir;
			str(_markername) setMarkerPos getPosWorld player;
		};
	}
	sleep 5;
};