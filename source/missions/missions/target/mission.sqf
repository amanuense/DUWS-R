_MissionPos = _this select 0;
// define random pos AROUND TARGET. spawn markers at random.
_radius = 175;
_randompos = [(_missionpos select 0)+(random _radius)-(random _radius), (_missionpos select 1)+(random _radius)-(random _radius)];

// CREATE NAME
_mission_name = MissionNameCase2;

// CREATE MARKER (ICON)
_markername = format["target%1%2",round(_randompos select 0),round(_randompos select 1)]; // Define marker name
_markerstr = createMarker [str(_markername), _randompos];
_markerstr setMarkerShape "ICON";
str(_markername) setMarkerType "selector_selectedEnemy";
str(_markername) setMarkerColor "ColorOPFOR";
str(_markername) setMarkerText "Assassinate";
str(_markername) setMarkerSize [1, 1];

// CREATE MARKER (ELLIPSE ZONE)
_markername2 = format["%1%2ellipsetarget",round(_randompos select 0),round(_randompos select 1)]; // Define marker name
_markerstr2 = createMarker [str(_markername2), _randompos];
_markerstr2 setMarkerShape "ELLIPSE";
str(_markername2) setMarkerBrush "SolidBorder";
str(_markername2) setMarkerColor "ColorOPFOR";
str(_markername2) setMarkerSize [_radius, _radius];
str(_markername2) setMarkerAlpha 0.5;

// CREATE PATROLS
sleep 1;
if(!debugmode) then {
	[_missionpos, 15] execvm "support\createoppatrol.sqf"; // <-- around target
	[_randompos, _radius] execvm "support\createoppatrol.sqf";
	[_randompos, _radius] execvm "support\createoppatrol.sqf";
	[_randompos, _radius] execvm "support\createopteam.sqf";
	"O_MRAP_02_F" createVehicle ([(_missionpos select 0)+(random 10),(_missionpos select 1)+(random 10)]);
} else {
	diag_log format ["target mission.sqf debug mode"];
};
_group = createGroup east;
_target = _group createUnit ["O_officer_F", _missionpos, [], 0, "FORM"]; 
_unit = _group createUnit ["O_soldier_F", _missionpos, [], 0, "FORM"];
_unit = _group createUnit ["O_soldier_F", _missionpos, [], 0, "FORM"];

// TASK AND NOTIFICATION
_taskhandle = player createSimpleTask ["taskTarget"];
_taskhandle setSimpleTaskDescription ["A high enemy target has been spotted somewhere in this location. Hunt him down.",_mission_name,""];
_taskhandle setSimpleTaskDestination (getMarkerPos str(_markername));

if (!ismultiplayer) then {
    execVM "misc\autoSave.sqf.sqf";
};

["TaskAssigned",["",_mission_name]] call bis_fnc_showNotification;

waitUntil {sleep 2; !alive _target};  // MISSION COMPLETED --

// remove markers
deleteMarker str(_markername2);
deleteMarker str(_markername);

player removeSimpleTask _taskhandle;

sleep 1;

// Give cookies  (bonus & notifications)
[20, _mission_name ] execVM "missions\mission_score.sqf";


