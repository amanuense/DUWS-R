//when using the stub we initialize the variables to 0 as this is not needed for dedicated.
mission_array_of_islands_captured = 0;
mission_number_of_zones_captured = 0;
mission_number_of_missions_done = 0;
mission_DUWS_firstlaunch = true;


// Lance l'init de l'xp
_handle = [] execVM "persistent\experience\experience_init.sqf";
waitUntil {scriptDone _handle};
