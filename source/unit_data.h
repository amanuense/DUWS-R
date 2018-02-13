//file containing the unit data used for menu items.
//this MUST be included after #include "..\global_defines.h"


//arrays containing elements for menus
//[menu_item, string, cost, unit_type, rank, skill_modifier, comm menu]
_menu_request_unit_items = [
    [MENU_BLU_UNIT_REQUEST, "Rifleman",           2, "B_Soldier_F",        "private", 0.2],
    [MENU_BLU_UNIT_REQUEST, "Grenadier",          3, "B_Soldier_GL_F",     "private", 0.2],
    [MENU_BLU_UNIT_REQUEST, "Automatic Rifleman", 3, "B_Soldier_AR_F",     "private", 0.2],
    [MENU_BLU_UNIT_REQUEST, "AT Rifleman",        3, "B_Soldier_LAT_F",    "private", 0.2],
    [MENU_BLU_UNIT_REQUEST, "Marksman",           3, "B_soldier_AT_F",     "private", 0.2],
    [MENU_BLU_UNIT_REQUEST, "Diver",              3, "B_diver_F",          "private", 0.5],
    [MENU_BLU_UNIT_REQUEST, "Spotter",            3, "B_spotter_F",        "private", 0.5],
    [MENU_BLU_UNIT_REQUEST, "Medic",              4, "B_medic_F",          "private", 0.2],
    [MENU_BLU_UNIT_REQUEST, "AA Specialist",      4, "B_soldier_AA_F",     "private", 0.2],
    [MENU_BLU_UNIT_REQUEST, "Repair Specialist",  4, "B_soldier_repair_F", "private", 0.2],
    [MENU_BLU_UNIT_REQUEST, "AT Specialist",      4, "B_soldier_AT_F",     "private", 0.2],
    [MENU_BLU_UNIT_REQUEST, "Sniper",             4, "B_sniper_F",         "private", 0.5],
    [MENU_BLU_UNIT_REQUEST, "explosive Spec",     4, "B_soldier_exp_F",    "private", 0.5]
    ];


//[menu_item, string, cost, unit_type, rank, skill_modifier]
_menu_request_squad_items = [
    [MENU_BLU_SQUAD_REINFORCE, "Fireteam",             8, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam"),          "a" ],
    [MENU_BLU_SQUAD_REINFORCE, "Rifle Squad",         16, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad"),         "b" ],
    [MENU_BLU_SQUAD_REINFORCE, "Weapons Squad",       18, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad_Weapons"), "c" ],
    [MENU_BLU_SQUAD_REINFORCE, "AT Team",             12, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam_AT"),       "d" ],
    [MENU_BLU_SQUAD_REINFORCE, "AA Team",             15, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam_AA"),       "e" ],
    [MENU_BLU_SQUAD_REINFORCE, "SF Recon Team",       12, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_ReconPatrol"),      "f" ],
    [MENU_BLU_SQUAD_REINFORCE, "SF Recon Squad",      20, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_ReconTeam"),        "g" ],
    [MENU_BLU_SQUAD_REINFORCE, "Divers Team",         10, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "SpecOps" >> "BUS_DiverTeam"),         "h" ],
    [MENU_BLU_SQUAD_REINFORCE, "Sniper Team",         10, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_SniperTeam"),       "i" ],
    [MENU_BLU_SQUAD_REINFORCE, "Medical Team",        10, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Support" >> "BUS_Support_CLS"),       "j" ],
    [MENU_BLU_SQUAD_REINFORCE, "Motorized scouts",    28, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Motorized" >> "BUS_MotInf_Team"),     "k" ],
    [MENU_BLU_SQUAD_REINFORCE, "Mechanized squad",    46, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Mechanized" >> "BUS_MechInfSquad"),   "l" ]
    ];

//[menu_item, string, cost, unit_type]
_menu_request_vehicle_items = [
    [MENU_BLU_VEHICLE_REQUEST, "ATV",                             1, "B_Quadbike_01_F"],
    [MENU_BLU_VEHICLE_REQUEST, "SF SUV",                          2, "C_Offroad_01_F"],
    [MENU_BLU_VEHICLE_REQUEST, "Small Transport Truck 1",         4, "I_G_Offroad_01_F"],
    [MENU_BLU_VEHICLE_REQUEST, "Hunter Unarmed",                  5, "B_MRAP_01_F"],
    [MENU_BLU_VEHICLE_REQUEST, "Small Transport Truck 2",         6, "I_G_Van_01_transport_F"],
    [MENU_BLU_VEHICLE_REQUEST, "HEMTT Transport Covered",         8, "B_Truck_01_covered_F"],
    [MENU_BLU_VEHICLE_REQUEST, "Fuel Truck",                     10, "B_G_Van_01_fuel_F"],
    [MENU_BLU_VEHICLE_REQUEST, "Stomper Autonomous Recon",       10, "B_UGV_01_F"],
    [MENU_BLU_VEHICLE_REQUEST, "UAV GreyHawk w/ATG Missiles",    10, "B_UAV_02_F"],
    [MENU_BLU_VEHICLE_REQUEST, "M-900 Civilian Copter",          12, "C_Heli_Light_01_civil_F"],
    
    [MENU_BLU_VEHICLE_REQUEST, "UAV GreyHawk w/Bombs",           15, "B_UAV_02_CAS_F"],
    [MENU_BLU_VEHICLE_REQUEST, "MH-9 Hummingbird",               15, "B_Heli_Light_01_F"],
    [MENU_BLU_VEHICLE_REQUEST, "Mi-290Black Taru Sling",         18, "O_Heli_Transport_04_F"],
    [MENU_BLU_VEHICLE_REQUEST, "Hunter HMG",                     18, "B_MRAP_01_hmg_F"],
    [MENU_BLU_VEHICLE_REQUEST, "Stomper RCWS Autonomous",        20, "B_UGV_01_rcws_F"],
    [MENU_BLU_VEHICLE_REQUEST, "UH-80 Ghosthawk",                22, "B_Heli_Transport_01_F"],
    [MENU_BLU_VEHICLE_REQUEST, "Hunter GMG",                     25, "B_MRAP_01_gmg_F"],
    [MENU_BLU_VEHICLE_REQUEST, "AH-9 Pawnee",                    25, "B_Heli_Light_01_armed_F"],
    [MENU_BLU_VEHICLE_REQUEST, "IFV-6c Panther",                 25, "B_APC_Tracked_01_rcws_F"],
    [MENU_BLU_VEHICLE_REQUEST, "CH-67 Huron",                    26, "B_Heli_Transport_03_F"],
    [MENU_BLU_VEHICLE_REQUEST, "CRV-6e Bobcat",                  28, "B_APC_Tracked_01_CRV_F"],
    [MENU_BLU_VEHICLE_REQUEST, "AMV-7 Marshall",                 35, "B_APC_Wheeled_01_cannon_F"],
    [MENU_BLU_VEHICLE_REQUEST, "IFV-6c Cheetah",                 30, "B_APC_Tracked_01_AA_F"],
    [MENU_BLU_VEHICLE_REQUEST, "M2A1 Slammer",                   40, "B_MBT_01_cannon_F"],
    [MENU_BLU_VEHICLE_REQUEST, "M2A4 SlammerUP",                 40, "B_MBT_01_TUSK_F"],
    [MENU_BLU_VEHICLE_REQUEST, "AH-99 Blackfoot",                45, "B_Heli_Attack_01_F"],
    [MENU_BLU_VEHICLE_REQUEST, "BUY ONLY AT AIRPORTS A-164 CAS", 45, "B_Plane_CAS_01_F"],
    [MENU_BLU_VEHICLE_REQUEST, "MLRS Artillary",                 75, "B_MBT_01_mlrs_F"],
    [MENU_BLU_VEHICLE_REQUEST, "Scorcher Artillary",             75, "B_MBT_01_arty_F"]
    ];

//[menu_item, string, cost, comm_menu]
_menu_request_support_items = [
    [MENU_BLU_SUPPORT_REQUEST, "Boat Taxi",                      2, "boat_taxi"],
    [MENU_BLU_SUPPORT_REQUEST, "Supply drop",                    5, "ammo"],
    [MENU_BLU_SUPPORT_REQUEST, "Helicopter Taxi",                5, "helo_taxi"],
    [MENU_BLU_SUPPORT_REQUEST, "Mortar strike",                 10, "mortar"],
    [MENU_BLU_SUPPORT_REQUEST, "UAV Recon",                     10, "uav_recon"],
    [MENU_BLU_SUPPORT_REQUEST, "Spawn beacon all players",      10, ""], //do not add comm menu
    [MENU_BLU_SUPPORT_REQUEST, "Vehicle Refit",                 15, "vehicle_refit"],
    [MENU_BLU_SUPPORT_REQUEST, "JDAM strike",                   15, "jdam"],
    [MENU_BLU_SUPPORT_REQUEST, "Artillery strike",              20, "artillery"],
    [MENU_BLU_SUPPORT_REQUEST, "Airborne troops",               20, "paradrop"],
    [MENU_BLU_SUPPORT_REQUEST, "Specialized Infantry training", 20, ""],
    [MENU_BLU_SUPPORT_REQUEST, "Mk.20 II CBU",                  25, "cluster"],
    [MENU_BLU_SUPPORT_REQUEST, "Armory",                        30,  ""]
    //pflir will be removed soon.
    //[MENU_BLU_SUPPORT_REQUEST, "Personal FLIR display",         20, ""],
    ];
