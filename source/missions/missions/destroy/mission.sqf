_MissionPos = _this select 0;
// define random pos AROUND SOLDIERS. spawn markers at random.
_radius = 400;
_randompos = [(_missionpos select 0)+(random _radius)-(random _radius), (_missionpos select 1)+(random _radius)-(random _radius)];

// CREATE NAME
_mission_name = MissionNameCase3;

// CREATE MARKER (ICON)
_markername = format["resc%1%2",round(_randompos select 0),round(_randompos select 1)]; // Define marker name
_markerstr = createMarker [str(_markername), _randompos];
_markerstr setMarkerShape "ICON";
str(_markername) setMarkerType "loc_Transmitter";
str(_markername) setMarkerColor "ColorOPFOR";
str(_markername) setMarkerText "Destroy";

// CREATE MARKER (ELLIPSE ZONE)
_markername2 = format["%1%2ellipseresc",round(_randompos select 0),round(_randompos select 1)]; // Define marker name
_markerstr2 = createMarker [str(_markername2), _randompos];
_markerstr2 setMarkerShape "ELLIPSE";
str(_markername2) setMarkerBrush "SolidBorder";
str(_markername2) setMarkerColor "ColorOPFOR";
str(_markername2) setMarkerSize [_radius, _radius];
str(_markername2) setMarkerAlpha 0.3; 

// CREATE TOWER
_tower = "Land_TTowerBig_1_F" createVehicle (_missionpos);
_tower setdamage 0.85;
_tower setVectorUp [0,0,1];

// TASK AND NOTIFICATION

_taskhandle = player createSimpleTask ["taskDestroy"];
_taskhandle setSimpleTaskDescription ["We have detected a large amount of enemy trasmissions coming from this area. This is probably caused by a radio tower used by the enemy forces on the island. Destroy the tower. Be sure to take some satchels, which you can find in the armory. Armory can be unlocked at the HQ.",_mission_name,""];
_taskhandle setSimpleTaskDestination (getMarkerPos str(_markername));

/*
Parameters:
		0: BOOL or OBJECT or GROUP or SIDE or ARRAY - Task owner(s)
		1: STRING or ARRAY - Task name or array in the format [task name, parent task name]
		2: ARRAY or STRING - Task description in the format ["description", "title", "marker"] or CfgTaskDescriptions class
		3: OBJECT or ARRAY or STRING - Task destination
		4: BOOL or NUMBER or STRING - Task state (or true to set as current)
		5: NUMBER - Task priority (when automatically selecting a new current task, higher priority is selected first)
		6: BOOL - Show notification (default: true)
		7: STRING - Task type as defined in the CfgTaskTypes
		8: BOOL - Should the task being shared (default: false), if set to true, the assigned players are being counted

*/
//_tasktext = format ["We have detected a large amount of enemy trasmissions coming from this area. This is probably caused by a radio tower used by the enemy forces on the island. Destroy the tower. Be sure to take some satchels, which you can find in the armory. Armory can be unlocked at the HQ.",_mission_name];
//[group player,"taskDestroy",[_tasktext,"Destroy",_markername],_randompos,true,1,true,"destroy",true] call BIS_fnc_taskCreate

if (!ismultiplayer) then {
    execVM "misc\autoSave.sqf.sqf";
};

// CREATE PATROLS
if(!debugmode) then {
	[_missionpos, 15] execvm "support\createoppatrol.sqf"; // <-- around target
	[_randompos, _radius] execvm "support\createoppatrol.sqf";
	[_randompos, _radius] execvm "support\createopteam.sqf";
} else {
	diag_log format ["destroy mission.sqf debug mode"];
};
sleep 1;

["TaskAssigned",["",_mission_name]] call bis_fnc_showNotification;

// MISSION COMPLETED --   ATTENDRE QUE LA TOUR SOIT KO
waitUntil {sleep 1; !alive _tower};  

// remove markers
deleteMarker str(_markername2);
deleteMarker str(_markername);
player removeSimpleTask _taskhandle;
 
 // Give cookies  (bonus & notifications)
[30, _mission_name ] execVM "missions\mission_score.sqf";