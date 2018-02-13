_target = _this select 0;

_location = getPosWorld _target;

if (commandpointsblu1<2) exitWith  
{
  ["info",["Not enough command points","Not enough Command Points (2CP required)"]] call bis_fnc_showNotification;
};
commandpointsblu1 = commandpointsblu1 - 2;
publicVariable "commandpointsblu1";

hint "A supply crate has been dropped near the FOB";

_parachute = "Steerable_Parachute_F" CreateVehicle _location;
_parachute setPos [_location select 0, _location select 1, (_location select 2)+50];

_ammo = "B_supplyCrate_F" CreateVehicle [_location select 0,_location select 1,(_location select 2)+20];
_ammo attachTo [_parachute,[0,0,0]];

_ammo addMagazineCargo ["30Rnd_65x39_caseless_mag", 70];
_ammo addMagazineCargo ["30Rnd_65x39_caseless_mag_Tracer", 70];
_ammo addMagazineCargo ["100Rnd_65x39_caseless_mag", 70];
_ammo addMagazineCargo ["100Rnd_65x39_caseless_mag_tracer", 70];
_ammo addMagazineCargo ["1Rnd_HE_Grenade_shell", 90];
_ammo addMagazineCargo ["UGL_FlareRed_F", 70];
_ammo addMagazineCargo ["UGL_FlareGreen_F", 70];
_ammo addMagazineCargo ["1Rnd_Smoke_Grenade_shell", 70];
_ammo addMagazineCargo ["1Rnd_SmokeRed_Grenade_shell", 70];
_ammo addMagazineCargo ["1Rnd_SmokeBlue_Grenade_shell", 70];
_ammo addMagazineCargo ["NLAW_F", 70];
_ammo addMagazineCargo ["Chemlight_green", 70];

_ammo addBackpackCargo ["B_AssaultPack_khk",10];

waitUntil {sleep 1; getPosWorld _ammo select 2<0.2};
_smoke = "SmokeShellGreen" CreateVehicle (getPosWorld _ammo);
["info",["Supply delivered","The supply crate has been marked with green smokes"]] call bis_fnc_showNotification;