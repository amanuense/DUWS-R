_fob = _this select 0;
diag_log format ["add_fob_actions.sqf"];
_fob addaction ["<t color='#ff00ff'>Player stats</t>","dialog\info\info.sqf", "", 0, true, true, "", "_this == player"];
_fob addaction ["<t color='#15ff00'>Request units</t>","dialog\request.sqf", "", 0, true, true, "", "_this == player"];
if(_fob != hq_blu1) then {
	_fob addaction ["<t color='#15ff00'>Request ammobox drop(2CP)</t>","support\fob_ammobox.sqf", "", 0, true, true, "", "_this == player"];
} else {
	_fob addaction ["<t color='#ffb700'>Squad manager</t>","dialog\squad\squadmng.sqf", "", 0, true, true, "", "_this == player"];
};
_fob addaction ["<t color='#ffb700'>FOB manager</t>","dialog\fob\FOBmanageropen.sqf", "", 0, true, true, "", "_this == player"];
if (support_armory_available) then {
	_fob addaction ["<t color='#ff0066'>Armory (VA)</t>","support\bisArsenal.sqf", "", 0, true, true, "", "_this == player"];
};
_fob addaction ["<t color='#00b7ff'>Rest (wait/save)</t>","misc\savegame.sqf", "", 0, true, true, "", "_this == player"];
_fob addaction ["<t color='#ff0000'>Fortify FOB(4CP)</t>","inithq\fortifyFOB.sqf", [(getPosWorld _fob), _fob], 0, true, true, "", "_this == player"];
