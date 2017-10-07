_index = lbCurSel 2102;

diag_log format["request_vehicle.sqf"];
//for the moment we won't use hq blu position since we might open vehicle spawning to FOBs
_spawnPos = getPosWorld player;
//get a safe location to spawn the vehicle.
_spawnPos = [_spawnPos, 20, 50, 3, 0, 1, 0] call BIS_fnc_findSafePos;

//defined were added for readability
#define offroad_cost 4
#define van_cost 6
#define mrap_cost 5
#define hmg_mrap_cost 18
#define gmg_mrap_cost 25
#define apc_cost 35
#define truck_cost 8
#define pawnee_cost 25
#define blackfoot_cost 45
#define hummingbird_cost 15
#define M900_cost 12
#define heli_trasnport_cost 18
#define heli_trasnport2_cost 22
#define heli_trasnport3_cost 26
#define apc_rcws_cost 25
#define quad_cost 1
#define apc_aaf_cost 30
#define mbt_cost 40
#define apc_crv_cost 28
#define SUV_offroad_cost 2
#define mbt_mrls_cost 75
#define mbt_arty_cost 75
#define van_fuel_cost 10
#define cas_plane_cost 45
#define mbt_tusk_cost 40
#define uvg_rcws_cost 20
#define uvg_cost 10
#define UAV_cost 15
#define UAV2_cost 5


switch (_index) do {
	case 0: { _vehic = [_spawnPos, "I_G_Offroad_01_F", offroad_cost] call spawn_vehicle_fn; };
	case 1: { _vehic = [_spawnPos, "I_G_Van_01_transport_F", van_cost] call spawn_vehicle_fn; };
	case 2: { _vehic = [_spawnPos, "B_MRAP_01_F", mrap_cost] call spawn_vehicle_fn; };
	case 3: { _vehic = [_spawnPos, "B_MRAP_01_hmg_F", hmg_mrap_cost] call spawn_vehicle_fn; };
	case 4: { _vehic = [_spawnPos, "B_MRAP_01_gmg_F", gmg_mrap_cost] call spawn_vehicle_fn; };
	case 5: { _vehic = [_spawnPos, "B_APC_Wheeled_01_cannon_F", apc_cost] call spawn_vehicle_fn; };
	case 6: { _vehic = [_spawnPos, "B_Truck_01_covered_F", truck_cost] call spawn_vehicle_fn; };
	case 7: { _vehic = [_spawnPos, "B_Heli_Light_01_armed_F", pawnee_cost] call spawn_vehicle_fn; };
	case 8: { _vehic = [_spawnPos, "B_Heli_Attack_01_F", blackfoot_cost] call spawn_vehicle_fn; };
	case 9: { _vehic = [_spawnPos, "B_Heli_Light_01_F", hummingbird_cost] call spawn_vehicle_fn; };
	case 10: { _vehic = [_spawnPos, "C_Heli_Light_01_civil_F", M900_cost] call spawn_vehicle_fn; };
	case 11: { _vehic = [_spawnPos, "O_Heli_Transport_04_F", heli_trasnport_cost] call spawn_vehicle_fn; };
	case 12: { _vehic = [_spawnPos, "B_Heli_Transport_01_F", heli_trasnport2_cost] call spawn_vehicle_fn; };
	case 13: { _vehic = [_spawnPos, "B_Heli_Transport_03_F", heli_trasnport3_cost] call spawn_vehicle_fn; };
	case 14: { _vehic = [_spawnPos, "B_APC_Tracked_01_rcws_F", apc_rcws_cost] call spawn_vehicle_fn; };
	case 15: { _vehic = [_spawnPos, "B_Quadbike_01_F", quad_cost] call spawn_vehicle_fn; };
	case 16: { _vehic = [_spawnPos, "B_APC_Tracked_01_AA_F", apc_aaf_cost] call spawn_vehicle_fn; };
	case 17: { _vehic = [_spawnPos, "B_MBT_01_cannon_F", mbt_cost] call spawn_vehicle_fn; };
	case 18: { _vehic = [_spawnPos, "B_APC_Tracked_01_CRV_F", apc_crv_cost] call spawn_vehicle_fn; };
	case 19: {
		_vehic = [_spawnPos, "C_Offroad_01_F", SUV_offroad_cost] call spawn_vehicle_fn;
		if !(isNil _vehic) then {
			sleep 1;
			_vehic setObjectTexture [0, "#(argb,8,8,3)color(0.141,0.118,0.082,1)"];
			_vehic animate ["Hidepolice", 1];
			_vehic animate ["Hideservices", 1];
			_vehic animate ["Hidebackpacks", 0];
			_vehic animate ["Hidebumper1", 0];
			_vehic animate ["Hidebumper2", 0];
			_vehic animate ["Hideconstruction", 0];
			_vehic animate ["Hidedoor1", 1];
			_vehic animate ["Hidedoor2", 1];
			_vehic animate ["Hidedoor3", 1];
			_vehic animate ["Hideglass2", 1];
		};
	};
	case 20: { _vehic = [_spawnPos, "B_MBT_01_mlrs_F", mbt_mrls_cost] call spawn_vehicle_fn; };
	case 21: { _vehic = [_spawnPos, "B_MBT_01_arty_F", mbt_arty_cost] call spawn_vehicle_fn; };
	case 22: { _vehic = [_spawnPos, "B_G_Van_01_fuel_F", van_fuel_cost] call spawn_vehicle_fn; };
	case 23: { _vehic = [_spawnPos, "B_Plane_CAS_01_F", cas_plane_cost] call spawn_vehicle_fn; };
	case 24: { _vehic = [_spawnPos, "B_MBT_01_TUSK_F", mbt_tusk_cost] call spawn_vehicle_fn; };
	case 25: { _vehic = [_spawnPos, "B_UGV_01_rcws_F", uvg_rcws_cost] call spawn_vehicle_fn; };
	case 26: { _vehic = [_spawnPos, "B_UGV_01_F", uvg_cost] call spawn_vehicle_fn; };
	case 27: { _vehic = [_spawnPos, "B_UAV_02_F", UAV_cost] call spawn_vehicle_fn; };
	case 28: { _vehic = [_spawnPos, "B_UAV_02_CAS_F", UAV_cost] call spawn_vehicle_fn; };
	case 29: { _vehic = [_spawnPos, "B_UAV_01_F", UAV2_cost] call spawn_vehicle_fn; };
};

publicVariable "commandpointsblu1";
