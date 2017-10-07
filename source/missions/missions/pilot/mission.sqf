_MissionPos = _this select 0;
_initpos = getPosWorld hq_blu1;
// define random pos AROUND TARGET. spawn markers at random.
_radius = 175;
_randompos = [(_missionpos select 0)+(random _radius)-(random _radius), (_missionpos select 1)+(random _radius)-(random _radius)];

// CREATE NAME
_mission_name = MissionNameCase4;

// CREATE MARKER (ICON)
_markername = format["pilot%1%2",round(_randompos select 0),round(_randompos select 1)]; // Define marker name
_markerstr = createMarker [str(_markername), _randompos];
_markerstr setMarkerShape "ICON";
str(_markername) setMarkerType "mil_unknown";
str(_markername) setMarkerColor "ColorYellow";
str(_markername) setMarkerText "Crash";
str(_markername) setMarkerSize [1, 1];

// CREATE MARKER (ELLIPSE ZONE)
_markername2 = format["%1%2ellipsetarget",round(_randompos select 0),round(_randompos select 1)]; // Define marker name
_markerstr2 = createMarker [str(_markername2), _randompos];
_markerstr2 setMarkerShape "ELLIPSE";
str(_markername2) setMarkerBrush "SolidBorder";
str(_markername2) setMarkerColor "ColorYellow";
str(_markername2) setMarkerSize [_radius, _radius];
str(_markername2) setMarkerAlpha 0.5;

// CREATE PATROLS
if(!debugmode) then {
	sleep 1;
	[_randompos, _radius] execvm "support\createoppatrol.sqf";
	[_randompos, _radius] execvm "support\createoppatrol.sqf";
	[_randompos, _radius] execvm "support\createoppatrol.sqf";
	[_randompos, _radius] execvm "support\createopteam.sqf";
}else{
	diag_log format ["pilot mission.sqf debug mode"];
};

// CREATE WRECK
_choppa = "Land_Wreck_Heli_Attack_01_F" createVehicle (_missionpos);

_group = createGroup west; // CREATE PILOT
_pilot = _group createUnit ["B_Helipilot_F", [_missionpos select 0, (_missionpos select 1)+2], [], 0, "FORM"];
_pilot setcaptive true; 
_pilot switchMove "acts_CrouchingIdleRifle01";

// TASK AND NOTIFICATION
_taskhandle = player createSimpleTask ["taskPilot"];
_taskhandle setSimpleTaskDescription ["One of our AH-99 helicopters has been downed somewhere around this area. We have reports that the pilot is still alive. You must find him and bring him back to base.",_mission_name,""];
_taskhandle setSimpleTaskDestination (getMarkerPos str(_markername));

if (!ismultiplayer) then {
    execVM "misc\autoSave.sqf.sqf";
};

["TaskAssigned",["",_mission_name]] call bis_fnc_showNotification;

// PLAYER IS WITH THE PILOT --
waitUntil {sleep 1; (player distance _pilot)<6 OR !(alive _pilot)};

// CHECK IF PILOT ALIVE
if (alive _pilot) then {
	_pilot setcaptive false;
	_pilot switchMove "AidlPknlMstpSrasWrflDnon_AI";
	[_pilot] joinSilent player;
	titleText ["Thanks sir, this place is crawling with OPFOR forces, bring me back to main base", "PLAIN DOWN"];
};

// PLAYER IS AT BASE WITH PILOT OR PILOT DEAD --
waitUntil {sleep 1; (_pilot distance _initpos)<50 OR !(alive _pilot)};

// remove markers
deleteMarker str(_markername2);
deleteMarker str(_markername);
player removeSimpleTask _taskhandle;


// CHECK IF PILOT ALIVE
if (!(alive _pilot)) exitWith {
	diag_log format ["pilot is dead, task failed."];
	["TaskFailed",["","The pilot is dead"]] call bis_fnc_showNotification;
};


sleep 1;

titleText ["Home, sweet home! Thanks for the rescue.", "PLAIN DOWN"];
//make sure the pilot leaves the vehicle
if (vehicle _pilot != _pilot) then {
	if (speed (vehicle _pilot) > 0) then {
		titleText ["please stop the vehicle so I can dismount.", "PLAIN DOWN"];
	};
	waitUntil{ sleep 5; speed (vehicle _pilot) == 0 }; 

	titleText ["thanks, wait until I step out of the vehicle.", "PLAIN DOWN"];
	_pilot action ["GetOut", vehicle _pilot];
	sleep 5;
};
deleteVehicle _pilot;

// Give cookies  (bonus & notifications)
[20, _mission_name ] execVM "missions\mission_score.sqf";