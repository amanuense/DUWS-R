_arguments = _this select 3;
_missionPos = _arguments select 0;
_mission_name = _arguments select 1;
_markername = _arguments select 2;
_markername2 = _arguments select 3;

_action = _this select 2;
_object = _this select 0;

hint "Sabotage done";

private "_taskhandle";

// generate variable name for task
_VARtaskgeneratedName = format["tsksabot%1%2",round(_MissionPos select 0),round(_Missionpos select 1)];

// recall variable and inject it into handle
call compile format["_taskhandle = %1",_VARtaskgeneratedName];

_object removeAction _action;

player removeSimpleTask _taskhandle;

deleteMarker str(_markername2);
deleteMarker str(_markername);

// Give cookies  (bonus & notifications)
reward = (20 * cp_reward_multiplier);
["TaskSucceeded",["",_mission_name]] call bis_fnc_showNotification;
["cpaddedmission",[reward]] call bis_fnc_showNotification;
WARCOM_blufor_ap = WARCOM_blufor_ap + 20;
commandpointsblu1 = commandpointsblu1 + reward;
missions_success = missions_success + 1;
publicVariable "commandpointsblu1";
publicVariable "WARCOM_blufor_ap";
finishedMissionsNumber = finishedMissionsNumber + 1;
publicVariable "finishedMissionsNumber";

// ADD PERSISTENT STAT
_addmission = [] execVM "persistent\persistent_stats_missions_total.sqf";