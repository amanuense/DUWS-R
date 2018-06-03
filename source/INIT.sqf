#include "global_defines.h"

diag_log format ["------------------ DUWS-R START ----v2------ player: %1", profileName];

//////////////////////////////////////////////////////
//  HOW TO MANUALLY CREATE THE MISSION:
//  1)YOU MUST PLACE THE HQ LOCATION
//  2)DEFINE THE CAPTURABLE ZONES
//  -- YOU CAN ALSO JUST PUT A HQ SOMEWHERE AND LET THE ZONES BEING RANDOMLY GENERATED
//  -- YOU MUST PLACE MANUALLY THE HQ IF YOU ARE ALREADY PLACING THE ZONES BY HAND
//  3) DONT FORGET TO DEFINE THE VARIABLES BELOW. If you are ONLY placing the HQ by hand, you just need to put "hq_manually_placed" to
//     "true" instead of "false". If you are also placing the zones by hand, make "zones_manually_placed" to "true".
/////////////////////////////////////////////////////////////
//  1) In the gamelogic, for the HQ( !! MAKE ONLY ONE HQ !!): _null=[getPosWorld this] execVM "initHQ\BluHQinit.sqf"
//
//  2) In the init of gamelogic, to create a capturable enemy zone:
//      _null = ["zone name",pts awarded upon capture, zone radius,getPosWorld this,false/true,false/true] execvm "createzone.sqf";
//        "zone name": name of the zone
//        pts awarded upon capture: points you earn when you capture the zone. Also the amount of points of army power you take and receive
//          from the enemy after capture
//        zone radius: how large the zone is
//        getPosWorld this: It's the position of the zone. The gamelogic actually. You don't have to modify this.
//        false/true: if the zone is fortified or not. If the zone is fortified, there will be a bit more enemies and they will be maning
//          static defences if there are any
//        false/true: if the zone is selecting randomly a prefab base. Prefab is selected according to the zone radius. The bigger the zone,
//          the bigger the prefab asset will be chosen.
//
//  EXAMPLE, in the init of a gamelogic you have placed on the map:
//    _null=["OP Xander",20,200,getPosWorld this,true,false] execvm "initZones\createzone.sqf"
//
//  3) Define these variables:

/////////////////////////////////////////////////////////////
debugmode = false;  // Debug mode

/*functions*/
DUWS_fnc_fob = compile preprocessFileLineNumbers "misc\add_fob_actions.sqf";
spawn_vehicle_fn = compile preprocessFileLineNumbers "support\spawn_vehicle.sqf";
startup_defaults_fn = compile preprocessFileLineNumbers "dialog\startup\startup_defaults.sqf";
[] call startup_defaults_fn;

DedicatedMission = if(isDedicated) then {True} else {False};
publicVariable "DedicatedMission";

if(DedicatedMission) then { diag_log format ["running dedicated mission, all stats will be sinced with server"]; };

//check if Headlessclient is present
HC1Present = if ( isNil "HC1" )  then {False} else {True};


// you must specify if you have manually placed HQ or not. false = HQ is randomly placed, true = you have manually placed the HQ
hq_manually_placed = false;
// you must specify if you have manually placed the zones or not. false = zones are randomly generated, true = you have manually placed the zones
zones_manually_placed = false;
zones_max_dist_from_hq = 7500;
dynamic_weather_enable = true;
maually_chosen = false;

mission_array_of_islands_captured = [];
mission_number_of_zones_captured = 0;
mission_number_of_missions_done = 0;
mission_DUWS_firstlaunch = true;



// choose between "tropical" - "arid" - "temperate" - "temperate_cold" - "mediterranean"
if (isNil "weather_type") then {weather_type = "mediterranean";};
// set the skill range of ennemy AI
if (isNil "opfor_ai_skill") then {opfor_ai_skill = [0.1,0.3];};
// set the skill range of friendly AI, from 0 to 1 (0 being completely dumb)
if (isNil "blufor_ai_skill") then {blufor_ai_skill = [0.4,0.7];};
// by default enable fast travel
if (isNil "enable_fast_travel") then { enable_fast_travel = true; };
// chopper taxi (support) will fast travel (teleport) or not
if (isNil "enableChopperFastTravel") then { enableChopperFastTravel = true; };

///////////////////////////////////////////////////////
// initialise variables
//////////////////////////////////////////////////////
// MOST OF THE VALUES ARE BEING OVERWRITTEN BY PLAYER INPUT AT THE BEGINNING
//////////////////////////////////////////////////////



// number of missions succes(!!dont touch!!)
missions_success = 0;

// Starting CP
if (isNil "commandpointsblu1") then { commandpointsblu1 = 20; };
// STARTING ARMY POWER
if (isNil "blufor_ap") then { blufor_ap = 0; };

if (DedicatedMission) then {
    DUWSMP_CP_death_cost = paramsArray select 0; //first element
    debugmode = [false, true] select (paramsArray select 1);
    commandpointsblu1 = paramsArray select 2;
    zones_number = paramsArray select 3;
    diag_log format ["server, selected CP: %d", commandpointsblu1];
} else {
    DUWSMP_CP_death_cost = 1; //first element
    commandpointsblu1 = 60;
    zones_number = 5;
};

opfor_ap = 0;
zones_spacing = 1200; // minimum space between 2 zones (in meters) // SOON OBSOLETE
zones_max_radius = 1000;   // Determine the maximum radius a generated zone can have
zones_min_radius = 200; // Determine the minium radius a generated zone can have. SHOULD NOT BE UNDER 200.

///////////////////////////////////////////////////////
// This mission will have a harder time generating stuff if a lot of the terrain of the island is sloped, meaning that valid locations
// will be harder/take longer to find (side missions, mission init).
// Keep that in mind when tweaking the zones amount/radius value.
/////////////////////////////////////////////////////////
// preprocess the qrf file for the EH
QRF_test = compile preprocessFile "WARCOM\WARCOM_opf_qrf.sqf";
if(!DedicatedMission) then {
    _persistent_stat_script_init = [] execVM "persistent\persistent_stats_init.sqf";
    waitUntil {scriptDone _persistent_stat_script_init};
} else {
    //stub persistence when using dedicated server as it complicates things.
    _persistent_stat_script_init = [] execVM "persistent\persistent_stats_stub.sqf";
    waitUntil {scriptDone _persistent_stat_script_init};
};

//execvm "dynamic_music\dyn_music_init.sqf";

zones_created = false;
blu_hq_created = false;
can_get_mission = true;
failsafe_zones_not_found = false;
createcenter sideLogic;
LogicGroup = createGroup SideLogic;
PAPABEAR=[West,"HQ"];
locator_hq_actived = false;
fobSwitch = false; //oariasri check if this is required
player_is_choosing_hqpos = false;

if (isNil "amount_zones_created") then {
    amount_zones_created = 1; //prevent the mission from prematurely end
};

if (isNil "HQ_pos_found_generated") then {
    HQ_pos_found_generated = false;
};

if (isNil "chosen_settings") then {
    chosen_settings = false;
};

if (isNil "chosen_hq_placement") then {
    chosen_hq_placement = false;
};

if (isNil "zoneundercontrolblu") then {
    zoneundercontrolblu = 0;
};

if (isNil "amount_zones_captured") then {
    amount_zones_captured = 0;
    publicVariable "amount_zones_captured";
};

if (isNil "capturedZonesNumber") then {
    capturedZonesNumber = 0;
};

if (isNil "finishedMissionsNumber") then {
    finishedMissionsNumber = 0;
};

if (isNil "cp_reward_multiplier") then {
    cp_reward_multiplier = 1;
};

if (isNil "OvercastVar") then {
    OvercastVar = 0;
};

if (isNil "FogVar") then {
    FogVar = 0;
};

// this is a special one (if/else)
if (isNil "Array_of_FOBS") then {
    // if the player is sp or server or no fobs have been created
    Array_of_FOBS = [];
}
else /// JIP for the client
{
    //for players connecting once the mission has been started, add actions here
    {
        [_x] spawn DUWS_fnc_fob
    } count Array_of_FOBS; //count behaves similar to foreach
};

if (isNil "Array_of_FOBname") then {
    Array_of_FOBname = [];
};

if (isNil "squad_counters") then {
    //todo initialize based on the menu element size
    squad_counters = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
};

if (isNil "personal_purchased") then {
    //todo initialize based on the menu element size
    personal_purchased = [0,0,0,0,0,0];
};

if (isNil "support_purchased") then {
    //todo initialize based on the menu element size
    support_purchased = [0,0,0,0,0,0];
};

if (isNil "support_armory_available") then {
    support_armory_available = false;
};

if (isNil "support_specialized_training_available") then {
    support_specialized_training_available = false;
};

player allowDamage false;


player_has_tactical_glasses = false;

//TODO add player disconnect handler.
if (!isDedicated) then {
    execVM "misc\gps_marker.sqf";
    execVM "misc\laserTarget.sqf";
    //add earplugs
    player execVM "misc\simpleEP.sqf";
};

//this action does not take effect on the client who disconencts only on server
addMissionEventHandler ["HandleDisconnect",{_this execVM "misc\gps_deinit.sqf" }];


//add respawn inventory options
[west, "WEST1"] call BIS_fnc_addRespawnInventory;
[west, "WEST2"] call BIS_fnc_addRespawnInventory;
[west, "WEST3"] call BIS_fnc_addRespawnInventory;
[west, "WEST4"] call BIS_fnc_addRespawnInventory;
[west, "WEST5"] call BIS_fnc_addRespawnInventory;
[west, "WEST6"] call BIS_fnc_addRespawnInventory;
[west, "WEST7"] call BIS_fnc_addRespawnInventory;
[west, "WEST8"] call BIS_fnc_addRespawnInventory;
[west, "WEST9"] call BIS_fnc_addRespawnInventory;

// IF MP
if (isMultiplayer) then {
    diag_log format ["environment is multiplayer"];
    diag_log format ["death cost %1", DUWSMP_CP_death_cost];

    PlayerKilledEH = player addEventHandler ["killed", {
        commandpointsblu1 = commandpointsblu1 - DUWSMP_CP_death_cost;
        publicVariable "commandpointsblu1";
        }];
    "support_specialized_training_available" addPublicVariableEventHandler {lbSetColor [MENU_BLU_SUPPORT_REQUEST, 11, [0, 1, 0, 1]];};

    //Add armoury when bought
    "support_armory_available" addPublicVariableEventHandler {
        hq_blu1 addaction ["<t color='#ff0066'>Armory (VA)</t>","support\bisArsenal.sqf", "", 0, true, true, "", "_this == player"];
        {
            _x addaction ["<t color='#ff0066'>Armory (VA)</t>","support\bisArsenal.sqf", "", 0, true, true, "", "_this == player"];
        } count (Array_of_FOBS);
        lbSetColor [MENU_BLU_SUPPORT_REQUEST, 5, [0, 1, 0, 1]];
    };

    //add public supports when bought
    "support_purchased" addPublicVariableEventHandler {
      [player, _comm_menu] remoteExec ["BIS_fnc_addCommMenuItem", -2, 1];
    };

    // change the shown CP for request dialog
    "commandpointsblu1" addPublicVariableEventHandler {ctrlSetText [1000, format["%1",commandpointsblu1]]; };

    if (isServer) then { // SERVER INIT
        diag_log format ["server init"];
        DUWS_host_start = false;
        publicVariable "DUWS_host_start";
        //diag_log format ["getting defaults"];
        //_nil = [] execVM "dialog\startup\startup_defaults.sqf";
        //oariasri
        //add override default number of zones here!
        //note modify params.hpp
        waitUntil {time > 0.1};
        DUWS_host_start = true;
        publicVariable "DUWS_host_start";

        if(isDedicated) then {
            //for dedicated server always reset the number of zones
            capturedZonesNumber = 0;
            finishedMissionsNumber = 0;
            publicVariable "capturedZonesNumber";
            publicVariable "finishedMissionsNumber";
        };
        // init High Command
        diag_log format ["server is calling hc_init.sqf"];
        _handle = [] execVM "dialog\hc_init.sqf";
        waitUntil {scriptDone _handle};
        diag_log format ["server init end"];
    } else {
        diag_log format ["not a server"];
        "capturedZonesNumber" addPublicVariableEventHandler {[] execVM "persistent\persistent_stats_zones_add.sqf";}; // change the shown CP for request dialog
        "finishedMissionsNumber" addPublicVariableEventHandler {[] execVM "persistent\persistent_stats_missions_total.sqf";}; // change the shown CP for request dialog
    };
} else {
    //init hcfor single player
    diag_log format ["singleplayer calling hc_init.sqf"];
    _handle = [] execVM "dialog\hc_init.sqf";
};

//if this is the server check for placement
if (isServer) then {
    diag_log format ["this is server, check for placement"];
    //always do random HQ placement on dedicated server
    if (isDedicated) then {
        diag_log format ["dedicated server, using default placement"];
        hintsilent "running on dedicated server, randomly selecting HQ location...";
        waitUntil {time > 1};
        _nil = [] execvm "dialog\startup\hq_placement\random.sqf";
        hintsilent "randomly selecting zones location using default settings...";
        waitUntil {time > 1};
        _nil = [] execvm "dialog\startup\startup_random_start.sqf";

    }
    else {
        diag_log format ["not dedicated, querying user about placement"];
        _null = [] execVM "dialog\startup\hq_placement\placement.sqf";
        waitUntil {chosen_hq_placement};
    };
    // create random HQ in case the user want to place it randomly or for dedicated server.
    if (!hq_manually_placed && !player_is_choosing_hqpos) then {
        diag_log format ["selected random placement for HQ, executing locatorHQ.sqf"];
        hq_create = [20, 0.015] execVM "initHQ\locatorHQ.sqf";
        waitUntil {scriptDone hq_create};
    };
};

if (!isServer) then {
    diag_log format ["waiting for location of the zones."];
    // WHEN CLIENT CONNECTS INIT (might need sleep)
    waitUntil {isPlayer Player};
    hintsilent "Waiting for the host to find an HQ...";
    waitUntil {HQ_pos_found_generated && time > 0.1};

    player setpos getMarkerPos "respawn_west";

    _drawicon = [] execVM "inithq\drawIcon.sqf";
    hintsilent "Waiting for the host to select the campaign parameters...";
    waitUntil {chosen_settings};
    sleep 1;
    player setdamage 0;
    player allowDamage true;
    hintsilent format["Joined game, welcome to %1, %2", worldName, profileName];

    // init High Command
    diag_log format ["initializing HC for all players (not server"];
    _handle = [] execVM "dialog\hc_init.sqf";
    [] execVM "dialog\startup\weather_client.sqf";
}
else {
    // initialise the ressources per zone bonus
    _basepoint = [] execVM "zonescap\zonesundercontrol.sqf";
};

// init the bonuses you get when capturing zones
_basepoint = [] execVM "zonescap\zones_bonus.sqf";

// INIT the operative list
execVM "dialog\operative\operator_init.sqf";

diag_log format ["creating help for DUWS"];
// Create help for DUWS
_index = player createDiarySubject ["help","DUWS-R Manual"];
player createDiaryRecord ["help", ["Dedicated server", "when running on a dedicated server all settings will be default, in order to change this you can change them in startup_defaults.sqf (need to open the .PBO)."]];
player createDiaryRecord ["help", ["Feedback/bug report", "This version has diverged from DUWS-R, please report any issues in the workshop until a dedicated github is created."]];
player createDiaryRecord ["help", ["Export to another island", "<font color='#FF0000'>How to export to another island:</font color><br />You just need to take the .pbo file and rename it with the name of the island you want to export the mission to. You don't have anything else to do<br /><br />Example:<br />SP_DUWS-R.stratis.pbo >>> SP_DUWS-R.chernarus.pbo"]];
player createDiaryRecord ["help", ["Credits", "Many thanks goes out to everyone that worked on the original DUWS by kibot, the DUWS-R team, and Amanuense!"]];
player createDiaryRecord ["help", ["Command Points (CP)", "Command points are used to purchase vehicles, units and ask for support (like artillery or save the game outside the base). To obtain Command points, you must capture the enemy controlled zones (red zones on the map) or execute side missions. You also receive 3 command points for each zone you have under your control every 30 minutes."]];
player createDiaryRecord ["help", ["Army Power (AP)", "Army power represent the strenght of the BLUFOR forces present on the island. By capturing enemy positions and accomplishing side missions, you will add Army Power to your army. The attack waves of the BLUFOR army will become stronger."]];
player createDiaryRecord ["help", ["Experience", "By accomplishing side missions, capturing zones and islands, you will increase your experience. With experience, you will automatically unlock new abilties. Once you have an ability, a description of this ability will be available in the 'ability' tab in the briefing.<br />Capturing an island gives you <font color='#FF0000'>5 XP</font color><br />Achieving a side mission: <font color='#FF0000'>2 XP</font color><br />Capturing a zone: <font color='#FF0000'>1 XP</font color>"]];

if (!isDedicated) then {
    player createDiaryRecord ["help", ["Saving the game", "You can save the game by resting at the base. Just go near the officer and select the action ""Rest"". Note that 6 hours will ellapse during that time. You can also save at any time by giving a SITREP in the support menu (0-8-1). Giving a SITREP does not make you wait, but it will cost you 1 CP for each save."]];
};
player createDiaryRecord ["help", ["Repairing/Rearming", "To repair, refuel or rearm a vehicle you need to unlock the ""vehicle refit"" support. Once you have it, you can call the support and your vehicle will be rearmed, repaired and refueled. Note that you must be close to the base to be able to use the vehicle refit."]];
player createDiaryRecord ["help", ["Support", "During the campaign you may unlock several support options at you HQ. You can access the available support in the radio menu (0-8). Note that calling for support cost CP."]];
player createDiaryRecord ["help", ["Making a FOB", "After you have captured your first zone, you'll get the ability to establish a FOB for 10 CP. A FOB allows you to rest(save) at remote locations outside the base. Establishing a FOB will also spawn some BLUFOR patrols around it and if there are enemies around it, you will be notified. To establish a FOB, you must make sure the zone around you is clear in a radius of 500 meters. Just go to the support menu and select 'Establish FOB'. A FOB will be deployed to your location."]];
player createDiaryRecord ["help", ["Side Missions", "Team leaders can request a side mission at the officer in the base. Successful side missions will not give any army power to the enemy, but will give you CP and increase your army power."]];
player createDiaryRecord ["help", ["Requesting units", "To request units, go to the officer at the base and select the action ""Request units""."]];
player createDiaryRecord ["help", ["Taking the Island", "At the beginning of the game, you are alone with your officer and only a few command points available, but as the war escalates, the BLUFOR HQ will start to launch attacks on enemy zone and will try to retake the island. You can help the main forces by assisting them in capturing the island, or you can also achieve side missions to boost the available assets of your army. It's up to you on how you want to play this campaign."]];

// Operatives
_index = player createDiarySubject ["operativehelp","Special operatives"];
player createDiaryRecord ["operativehelp", ["Skills", "<font color='#FF0000'>Aiming:</font color><br />Pretty self explanatory, how well the operative can aim, lead a target, compensante for bullet drop and manage recoil.<br /><br /><font color='#FF0000'>Reflexes:</font color><br />How fast the operator can react to a new threat and stabilize its aim.<br /><br /><font color='#FF0000'>Spotting:</font color><br />The operative ability to spot targets within it's visual or audible range, and how accurately he can spot targets.<br /><br /><font color='#FF0000'>Courage:</font color><br />Affects the morale of subordinates units of the operative, how likely they will flee, depending on what is in front of them and the squad status.<br /><br /><font color='#FF0000'>Communications:</font color><br />How quickly recognized targets are shared with the squad.<br /><br /><font color='#FF0000'>Reload speed:</font color><br />The operator's ability to switch weapon or reload quickly."]];
player createDiaryRecord ["operativehelp", ["Recruiting operatives", "Operatives can be recruited at the HQ, inside the ""request unit"" menu. When you recruit someone for the first time, you'll have to spend 5 CP. However, once an operative has been already recruited, has been ""injured""(killed) in battle, you can recruit it again for only 2 CP after a delay between 20 and 80 minutes."]];
player createDiaryRecord ["operativehelp", ["Overview", "You can recruit special operatives that will stay and progress with you for all the duration of the campaign. Some of these mens have special equipment, specialities and skills. Their skills will increase each time a zone is captured or a mission is accomplished, whether they're in your squad or not. However, when an operative is actually in the game, he will gain 10 spendable points wich can be assigned freely in any skill at the operative menu."]];

// MP notes
if (isMultiplayer) then {
    diag_log format ["MP notes"];
    player createDiaryRecord ["help", ["MP notes", "The CP pool is common for everyone.<br /><br />While most support unlocks are indivdual, the Armory and the Specialized infantry training are common, and need to be unlocked only once by a single player.<br /><br />While everybody can rest to heal, only the host can save and skip the time.<br /><br />Only the host can request side mission and finish them. However, everyone receive the persistent stats and xp bonuses."]];
    player createDiaryRecord ["help", ["Dedicated server notes", "for admins, make sure persistence is enabled, all saving is disabled when using dedicated server! familiarize yourself with admin commands such as #login, #restart and #missions."]];
    // MP notification
    [] spawn {
        waitUntil {time > 5};
        ["info",["MP Mechanics","Check the manual for the specifics of the DUWS-R in MP."]] call bis_fnc_showNotification;
    };
};

//make sure to add sitrep to all formation leaders
//oariasri
if (isFormationLeader player) then {
    diag_log format ["player is formation leader, add sitrep"];
    _sitrep = [player,"sitrep"] call BIS_fnc_addCommMenuItem;
};

// create mission victory script //SPAWN BEGIN
diag_log format ["create victory script"];
[] spawn {
    // CREATE MAIN OBJECTIVE
    capture_island_obj = player createSimpleTask ["taskIsland"];
    capture_island_obj setSimpleTaskDescription ["The ennemy is controlling the island, we must take it back! Capture every zone under enemy control and the mission will succeed.<br />You can let your BLUFOR forces take the island by themselves and help them getting a bigger army by accomplishing side missions. Or you can capture the zones yourself and do all the big work. As the campaign progress, the war will escalate and the armies will get stronger and start to use bigger guns.<br />To capture a zone, you need to have more units inside the zone than the enemy.<br /><br />It's up to you on how you want to play this.<br />Good luck, soldier!","Take the island",""];

    // WAIT UNTIL ALL ZONES ARE CAPTURED
    waitUntil {sleep 1; amount_zones_created > 0};
    diag_log format ["zoneundercontrolblu = %1, amount_zones_created = %2", zoneundercontrolblu, amount_zones_created];
    waitUntil {sleep 3; (zoneundercontrolblu >= amount_zones_created);}; // Toutes les zones sont capturées
    persistent_stat_script_win = [] execVM "persistent\persistent_stats_win.sqf";
    ["TaskSucceeded",["","Island captured!"]] call bis_fnc_showNotification;
    capture_island_obj setTaskState "Succeeded";
    sleep 3;
    ["island_captured_win",true,true] call BIS_fnc_endMission;
};

if (zones_manually_placed) then {
    waitUntil {!isNil ("Array_of_OPFOR_zones")};
    sleep 1;
    _warcom_init = [Array_of_OPFOR_zones, getPosWorld hq_blu1, [0,0,0], blufor_ap, opfor_ap, 2700,blufor_ai_skill,opfor_ai_skill, 1500] execVM "WARCOM\WARCOM_init.sqf";
};

if (mission_DUWS_firstlaunch) then {
    diag_log format ["first launch stuff"];
    waitUntil {chosen_settings};
    sleep 8;
    ["info",["Buying troops","Go talk to your commander to buy troops and vehicles with CP"]] call bis_fnc_showNotification;
    sleep 2.5;
    ["info",["Command points","Acquire more CP by capturing enemy areas or accomplishing side missions"]] call bis_fnc_showNotification;

    sleep 15;
    ["info",["RESTING AND HEALING","Save the game and heal by resting at the base"]] call bis_fnc_showNotification;

    sleep 15;
    // SITREP
    ["sitrepinfo",["SITREP","You can also save the game by giving a SITREP"]] call bis_fnc_showNotification;

    sleep 20;
    ["info",["DUWS Manual","Check the manual in the briefing for more info"]] call bis_fnc_showNotification;

    if(!DedicatedMission) then {
        profileNamespace setVariable ["profile_DUWS_firstlaunch", false];
        saveProfileNamespace;
    };
};

if(!isMultiplayer) then {
    diag_log format ["removing unused players"];
    //Cleanup unused players.
    for[{_x = 1},{_x <= 20},{_x = _x + 1}] do {
        _thePlayer = missionNamespace getVariable format["player%1", _x];
        if(!isNil("_thePlayer")) then {
            if(!isPlayer _thePlayer) then {
                deleteVehicle _thePlayer;
            };
        };
    };
};

//Loading player position and gear.
//TODO: Add bought supports.
/*
if(isServer) then
{
    execVM "persistent\missionSpecific\saveFuncs.sqf";
    waitUntil {!isNil "saveFuncsLoaded"};

    execVM "persistent\missionSpecific\loadAccount.sqf";
};
*/
