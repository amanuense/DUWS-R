_position = _this select 0;
_size = _this select 1;

diag_log format["fob.sqf"];

if (commandpointsblu1 < 10) exitWith {
	diag_log format["not enough points"];
	["info",["Not enough command points","Not enough Command Points (10CP required)"]] call bis_fnc_showNotification;
	sleep 15;
	_art = [player,"fob_support"] call BIS_fnc_addCommMenuItem;
};

// REGARDE SI LA ZONE EST OK
Hint "Requesting a FOB...";
player sidechat "Requesting a FOB on my position...";

_trg=createTrigger["EmptyDetector",_position];
_trg setTriggerArea[_size,_size,0,false];
_trg setTriggerActivation["EAST","PRESENT",true];
_trg setTriggerStatements["this", "", ""];
sleep 10;
_amountOPFOR = count list _trg;

deleteVehicle _trg;

if (_amountOPFOR > 0) exitWith {
	diag_log format["This position is not clear from enemies"];
	Hint "This position is not clear from enemies";
	PAPABEAR sidechat "Request denied. Enemies are too close to this position."; 
	sleep 15;
	_art = [player,"fob_support"] call BIS_fnc_addCommMenuItem;
};

// try to find a pos, if no pos is found exit the script
_foundPickupPos = [_position, 0,50,10,0,0.2,0,[],[[0,0],[0,0]]] call BIS_fnc_findSafePos; // find a valid pos
if (0 == _foundPickupPos select 0 && 0 == _foundPickupPos select 1) exitWith {
	diag_log format["No valid FOB pos nearby"];
	hint "No valid FOB pos nearby\nTry to go near a flat, object free zone."; 
	sleep 5; 
	_art = [player,"fob_support"] call BIS_fnc_addCommMenuItem;
	};

// LA ZONE EST OK

commandpointsblu1 = commandpointsblu1 - 10;
publicVariable "commandpointsblu1";
PAPABEAR sidechat "Roger that, the FOB is being deployed...";

_fobname = [1] call compile preprocessFile "misc\random_name.sqf";
// create marker on FOB
_markername = format["fob%1%2",round (_foundPickupPos select 0),round (_foundPickupPos select 1)]; // Define marker name
diag_log format["fob %1 %2 ", _fobname,_markername];
//hint _markername;
_markerstr = createMarker [str(_markername), _foundPickupPos];
_markerstr setMarkerShape "ICON";
str(_markername) setMarkerType "loc_Bunker";
str(_markername) setMarkerColor "ColorBLUFOR";
str(_markername) setMarkerText format["FOB %1",_fobname];
str(_markername) setMarkerSize [2.5, 2.5];

sleep 5;

_fob = "Land_Cargo_HQ_V1_F" createVehicle _foundPickupPos;

[_fob] remoteExec ['DUWS_fnc_fob',[0,-2] select isDedicated,true];


[_foundPickupPos, _size] execvm "support\createpatrol.sqf";
[_foundPickupPos, _size] execvm "support\createpatrol.sqf";
[_foundPickupPos, _size] execvm "support\createpatrol.sqf";

PAPABEAR sidechat "The FOB has been deployed.";

_handle = [_foundPickupPos, _fob] execVM "initHQ\guardsFOB.sqf";


// CREATE ZONE NOTIFICATION TRIGGER
_size = 75;
_trg23=createTrigger["EmptyDetector",_foundPickupPos];
_trg23 triggerAttachVehicle [player];
_trg23 setTriggerArea[_size,_size,0,false];
_trg23 setTriggerActivation["VEHICLE","PRESENT",true];
_trg23 setTriggerStatements["this", format["[""FOB %1"",thislist] execvm 'misc\enterlocation.sqf'",_fobname], ""];

// warning trigger when an enemy approaches the camp
_trgWarning=createTrigger["EmptyDetector",_foundPickupPos];
_trgWarning setTriggerArea[300,300,0,false];
_trgWarning setTriggerActivation["EAST","PRESENT",true];
_trgWarning setTriggerStatements["this",format["PAPABEAR sidechat 'This is HQ, enemies have been reported around FOB %1'",_fobname], ""];

//ADD THE FOB TO Array_of_FOBS
fobSwitch = true; // tell that this is the player who created the FOB (to avoid variableEventHandler to trigger)
diag_log format["adding FOB to the FOB list"];
Array_of_FOBS = Array_of_FOBS + [_fob];
publicVariable "Array_of_FOBS";

Array_of_FOBname = Array_of_FOBname + [_fobname];
publicVariable "Array_of_FOBname";

if(!isDedicated) then {
	sleep 1;
	saveGame;
	sleep 1;
};

sleep 600;
diag_log format["_art = [player,_fob_support_] call BIS_fnc_addCommMenuItem;"];
_art = [player,"fob_support"] call BIS_fnc_addCommMenuItem;

// Land_Cargo_HQ_V1_F
