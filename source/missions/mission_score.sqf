_points = _this select 0;
_mission_name = _this select 1;

reward = (_points * cp_reward_multiplier);
diag_log format ["mission_score.sqf _points = &1, cp_reward_multiplier=%2, reward=%3",_points, cp_reward_multiplier, reward];

["TaskSucceeded",["",_mission_name]] call bis_fnc_showNotification;
["cpaddedmission",[reward]] call bis_fnc_showNotification;
WARCOM_blufor_ap = WARCOM_blufor_ap + _points;
missions_success = missions_success + 1;
commandpointsblu1 = commandpointsblu1 + reward;
finishedMissionsNumber = finishedMissionsNumber + 1;
opfor_ap = opfor_ap - _points;

publicVariable "commandpointsblu1";
publicVariable "WARCOM_blufor_ap";

publicVariable "finishedMissionsNumber";
_operHandler = execVM "dialog\operative\operative_mission_complete.sqf";  
// ADD PERSISTENT STAT
_addmission = [] execVM "persistent\persistent_stats_missions_total.sqf";