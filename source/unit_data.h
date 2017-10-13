//file containing the unit data used for menu items.
//this MUST be included after #include "..\global_defines.h"

//arrays containing elements for menus
//[menu_item, string, cost, unit_type, rank, skill_modifier]
_menu_request_unit_items = [
	[MENU_BLU_UNIT_REQUEST, "Rifleman",           rifleman_cost,      "B_Soldier_F",        "private", 0.2],
	[MENU_BLU_UNIT_REQUEST, "Grenadier",          grenadier_cost,     "B_Soldier_GL_F",     "private", 0.2],
	[MENU_BLU_UNIT_REQUEST, "Automatic Rifleman", auto_rifleman_cost, "B_Soldier_AR_F",     "private", 0.2],
	[MENU_BLU_UNIT_REQUEST, "AT Rifleman",        AT_rifleman_cost,   "B_Soldier_LAT_F",    "private", 0.2],
	[MENU_BLU_UNIT_REQUEST, "Medic",              medic_cost,         "B_medic_F",          "private", 0.2],
	[MENU_BLU_UNIT_REQUEST, "AA Specialist",      AA_spec_cost,       "B_soldier_AA_F",     "private", 0.2],
	[MENU_BLU_UNIT_REQUEST, "Repair Specialist",  repair_spec_cost,   "B_soldier_repair_F", "private", 0.2],
	[MENU_BLU_UNIT_REQUEST, "AT Specialist",      AT_spec_cost,       "B_soldier_AT_F",     "private", 0.2],
	[MENU_BLU_UNIT_REQUEST, "Diver",              diver_cost,         "B_diver_F",          "private", 0.5],
	[MENU_BLU_UNIT_REQUEST, "Marksman",           marksman_cost,      "B_soldier_AT_F",     "private", 0.2],
	[MENU_BLU_UNIT_REQUEST, "Sniper",             sniper_cost,        "B_sniper_F",         "private", 0.5],
	[MENU_BLU_UNIT_REQUEST, "Spotter",            spotter_cost,       "B_spotter_F",        "private", 0.5],
	[MENU_BLU_UNIT_REQUEST, "explosive Spec",     explosive_spec_cost,"B_soldier_exp_F",    "private", 0.5]
	];


//[menu_item, string, cost, unit_type, rank, skill_modifier]
_menu_request_squad_items = [
	[MENU_BLU_SQUAD_REINFORCE, "Fireteam",            fireteam_cost,      (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam"),          "a" ],
	[MENU_BLU_SQUAD_REINFORCE, "Rifle Squad",         riflesquad_cost,    (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad"),         "b" ],
	[MENU_BLU_SQUAD_REINFORCE, "Weapons Squad",       weaponssquad_cost,  (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad_Weapons"), "c" ],
	[MENU_BLU_SQUAD_REINFORCE, "AT Team",             atteam_cost,        (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam_AT"),       "d" ],
	[MENU_BLU_SQUAD_REINFORCE, "AA Team",             aateam_cost,        (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam_AA"),       "e" ],
	[MENU_BLU_SQUAD_REINFORCE, "SF Recon Team",       recon_team_cost,    (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_ReconPatrol"),      "f" ],
	[MENU_BLU_SQUAD_REINFORCE, "SF Recon Squad",      recon_squad_cost,   (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_ReconTeam"),        "g" ],
	[MENU_BLU_SQUAD_REINFORCE, "Divers Team",         diver_team_cost,    (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "SpecOps" >> "BUS_DiverTeam"),         "h" ],
	[MENU_BLU_SQUAD_REINFORCE, "Sniper Team",         sniperteam_cost,    (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_SniperTeam"),       "i" ],
	[MENU_BLU_SQUAD_REINFORCE, "Medical Team",        medicalteam_cost,   (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Support" >> "BUS_Support_CLS"),       "j" ],
	[MENU_BLU_SQUAD_REINFORCE, "Motorized scouts",    motoscouts_cost,    (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Motorized" >> "BUS_MotInf_Team"),     "k" ],
	[MENU_BLU_SQUAD_REINFORCE, "Mechanized squad",    mechanized_cost,    (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Mechanized" >> "BUS_MechInfSquad"),   "l" ]	
	];
	

