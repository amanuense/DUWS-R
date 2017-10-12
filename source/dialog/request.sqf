#include "..\global_defines.h"


_handle = createDialog "ressourceheader";
waitUntil {dialog};
ctrlSetText [MENU_COMMAND_POINTS_BLU, format["%1",commandpointsblu1]];
ctrlSetText [MENU_ZONES_CONTROL_BLU, format["%1",zoneundercontrolblu]];
ctrlSetText [1002, format["%1",WARCOM_blufor_ap]];

// UNITS  
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "Rifleman(2CP)"];                  // 0
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "Grenadier(3CP)"];                 // 1
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "Automatic Rifleman(3CP)"];        // 2
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "AT Rifleman(3CP)"];               // 3
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "Medic(4CP)"];                     // 4
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "AA Specialist(4CP)"];             // 5
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "Repair Specialist(4CP)"];         // 6
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "AT Specialist(4CP)"];             // 7
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "SF Diver(3CP)"];                  // 8
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "Marksman(3CP)"];                  // 9
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "Sniper(4CP)"];                    // 10
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "Spotter(3CP)"];                   // 11
_index = lbAdd [MENU_BLU_UNIT_REQUEST, "Explosive specialist(4CP)"];      // 12
lbSetCurSel [MENU_BLU_UNIT_REQUEST, 0];

// SQUADS  
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "Fireteam(8CP)"];                   // 0
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "Rifle Squad(16CP)"];               // 1
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "Weapons Squad(18CP)"];             // 2
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "AT Team(12CP)"];                   // 3
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "AA Team(15CP)"];                   // 4
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "SF Recon Team(12CP)"];             // 5
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "SF Recon Squad(20CP)"];            // 6
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "Divers Team(12CP)"];               // 7
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "Sniper Team(8CP)"];                // 8
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "Medical Team(10CP)"];              // 9
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "Motorized scouts(28CP)"];          // 10
_index0 = lbAdd [MENU_BLU_SQUAD_REINFORCE, "Mechanized squad(46CP)"];          // 11
lbSetCurSel [MENU_BLU_SQUAD_REINFORCE, 0];

// VEHICLES
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "Small Transport Truck 1 (seats 6 - 4CP)"];       // 0
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "Small Transport Truck 2 (seats 9 - 6CP)"];       // 1
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "Hunter Unarmed(5CP)"];                           // 2
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "Hunter HMG(18CP)"];                              // 3
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "Hunter GMG(25CP)"];                              // 4
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "AMV-7 Marshall(35CP)"];                          // 5
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "HEMTT Transport Covered(8CP)"];                  // 6
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "AH-9 Pawnee (25CP)"];                            // 7
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "AH-99 Blackfoot(45CP)"];                         // 8
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "MH-9 Hummingbird(15CP)"];                        // 9
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "M-900 Civilian Copter(12CP)"];                   // 10
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "Mi-290Black Taru Sling(18CP)"];                  // 11
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "UH-80 Ghosthawk(22CP)"];                         // 12
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "CH-67 Huron(26CP)"];                             // 13
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "IFV-6c Panther(25CP)"];                          // 14
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "ATV(1CP)"];                                      // 15
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "IFV-6c Cheetah(30CP)"];                          // 16
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "M2A1 Slammer(40CP)"];                            // 17
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "CRV-6e Bobcat(28CP)"];                           // 18
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "SF SUV(2CP)"];                                   // 19
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "MLRS Artillary (75CP)"];                         // 20
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "Scorcher Artillary (75CP)"];                     // 21
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "Fuel Truck (10CP)"];                             // 22
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "BUY ONLY AT AIRPORTS A-164 CAS(45CP)"];          // 23
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "M2A4 SlammerUP(40CP)"];                          // 24
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "Stomper RCWS Autonomous(20CP)"];                 // 25
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "Stomper Autonomous Recon(10CP)"];                // 26
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "UAV GreyHawk w/ATG Missiles(15CP)"];             // 27
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "UAV GreyHawk w/Bombs(15CP)"];                    // 28
_index1 = lbAdd [MENU_BLU_VEHICLE_REQUEST, "UAV Darter(5CP)"];                               // 29
lbSetCurSel [MENU_BLU_VEHICLE_REQUEST, 0];

// Supports  !!! CHECK TO ADD AT INIT
index_support_supply      = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Supply drop(5CP)"];                      // 0
index_support_arty        = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Artillery strike(20CP)"];                // 1
index_support_mortar      = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Mortar strike(10CP)"];                   // 2
index_support_paradrop    = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Airborne troops(20CP)"];                 // 3
index_support_jdam        = lbAdd [MENU_BLU_SUPPORT_REQUEST, "JDAM strike(15CP)"];                     // 4
index_support_armory      = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Armory(8CP)"];                           // 5
index_support_pFLIR       = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Personal FLIR display(20CP)"];           // 6
index_support_uavrecon    = lbAdd [MENU_BLU_SUPPORT_REQUEST, "UAV Recon(10CP)"];                       // 7
index_support_refit       = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Vehicle Refit(3CP)"];                    // 8
index_support_helotaxi    = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Helicopter Taxi(3CP)"];                  // 9
index_support_cluster     = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Mk.20 II CBU(25CP)"];                    // 10
index_support_training    = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Specialized Infantry training(20CP)"];   // 11
index_support_boattaxi    = lbAdd [MENU_BLU_SUPPORT_REQUEST, "Boat Taxi(2CP)"];                        // 12

//  lbSetCurSel [MENU_BLU_SUPPORT_REQUEST, 0];
if (support_supplydrop_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 0, [0, 1, 0, 1]];
};
if (support_arty_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 1, [0, 1, 0, 1]];
};
if (support_mortar_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 2, [0, 1, 0, 1]];
};
if (support_paradrop_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 3, [0, 1, 0, 1]];
};
if (support_jdam_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 4, [0, 1, 0, 1]];
};
if (support_armory_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 5, [0, 1, 0, 1]];
};
if (support_pflir_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 6, [0, 1, 0, 1]];
};
if (support_uav_recon_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 7, [0, 1, 0, 1]];
};
if (support_veh_refit_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 8, [0, 1, 0, 1]];
};
if (support_helotaxi_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 9, [0, 1, 0, 1]];
};
if (support_cluster_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 10, [0, 1, 0, 1]];
};
if (support_specialized_training_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 11, [0, 1, 0, 1]];
};
if (support_boattaxi_available) then {
    lbSetColor [MENU_BLU_SUPPORT_REQUEST, 12, [0, 1, 0, 1]];
};
