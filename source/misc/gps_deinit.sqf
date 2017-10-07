_puid = _this select 2;
diag_log format["deleting marker: %1", format["gps%1", _puid]];
deletemarker str(format["gps%1", _puid]);
//delete body
_thePlayer = missionNamespace getVariable format["%1", _this select 0];
if(!isNil("_thePlayer")) then {
	if(!isPlayer _thePlayer) then {
		deleteVehicle _thePlayer;
	};
};