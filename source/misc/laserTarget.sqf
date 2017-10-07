diag_log format["laserTarget.sqf"];

//TODO add possibility of drawing only if player gas tactical glasses.
//TODO make distance configurable.
//TODO check if there is a way to reduce the overhead caused by the forEach
laser_handler_added = false;


//infinite loop to check if player has tactical glasses
while{true} do {
    //the check is performed every 10 seconds
    sleep 5;
    player_has_tactical_glasses = false;
    if(["G_Tactical_Black", "G_Tactical_Clear"] find goggles player > -1) then {
        player_has_tactical_glasses = true;
    };
    
    if(!player_has_tactical_glasses && laser_handler_added) then {
        if(debugmode) then { hintsilent format ["removing laser marker"]; };
        laser_handler_added = false;
        ["laser_marker", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
    };

    if(player_has_tactical_glasses && !laser_handler_added) then {
        laser_handler_added = true;
        if(debugmode) then { hintsilent format ["adding laser marker"]; };
        ["laser_marker", "onEachFrame", {
                {
                    drawIcon3D ["\A3\ui_f\data\map\markers\military\destroy_CA.paa", [1,0,0,1], _x, 0.5, 0.5, 0, "", 0, 0, "TahomaB", "center", true];
                } forEach nearestObjects [position player,["LaserTarget"], 1000];
        }] call BIS_fnc_addStackedEventHandler;
    };
};