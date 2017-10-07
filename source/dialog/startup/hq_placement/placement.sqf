waitUntil {time > 1};
//for non dedicated server, request hq placement option
if (isServer && !isDedicated) then {
	_handle = createDialog "startup_hq_placement_dialog";
	waitUntil {dialog};
	if (chosen_hq_placement or player_is_choosing_hqpos) exitWith {closeDialog 0};
};
 