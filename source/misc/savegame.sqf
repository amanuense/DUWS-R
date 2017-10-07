{deleteVehicle _x} forEach allDeadMen;
{_x setdammage 0} forEach units group player;
player setdammage 0;
hint "You and your squad members have been fully healed";
skiptime 6;
sleep 0.3;
if (isServer && !isDedicated) then {
    saveGame;
    sleep 2;
    [] execVM "misc\bottom_right_message.sqf";
};