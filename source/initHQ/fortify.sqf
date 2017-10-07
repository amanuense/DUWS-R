_centerPos = _this select 0;
_hq = _this select 1;

diag_log format["fortify.sqf"];


_forty_spawn = {
	_name = _this select 0;
	_center = _this select 1;
	_offset = _this select 2;

	_newx = (_center select 0) + (_offset select 0);
	_newy = (_center select 1) + (_offset select 1);
	_newz = (_offset select 2);

	_new = createVehicle [_name, [0,0,0], [], 0, "NONE"];
	_new allowdamage false;
	_new setpos [_newx, _newy, _newz];
	_new setdamage 0;
	_new
};

_groupGuard = createGroup WEST;

_aaPod = ["B_static_AA_F",_centerPos,[0,0,3.109]] call _forty_spawn;
_hqGuard1 = _groupGuard createUnit ["B_Soldier_F", _centerPos, [], 0, "FORM"]; 
_hqGuard1 moveinGunner _aaPod;

// GMG
_gl1Pod = ["B_GMG_01_high_F",_centerPos,[-7,6,0]] call _forty_spawn;
_hqGuard1 = _groupGuard createUnit ["B_Soldier_F", _centerPos, [], 0, "FORM"]; 
_hqGuard1 moveinGunner _gl1Pod;
_gl1Pod setDir( _centerPos getDir getPosWorld _gl1Pod); //try to situate this guy radially

// GMG
_atPod3 = ["B_GMG_01_high_F",_centerPos,[7,8,0]] call _forty_spawn;
_hqGuard1 = _groupGuard createUnit ["B_Soldier_F", _centerPos, [], 0, "FORM"]; 
_hqGuard1 moveinGunner _atPod3;
_atPod3 setDir( _centerPos getDir getPosWorld _atPod3); //try to situate this guy radially

// AT
_atPod1 = ["B_static_AT_F",_centerPos,[-7,-8,0]] call _forty_spawn;
_hqGuard1 = _groupGuard createUnit ["B_Soldier_F", _centerPos, [], 0, "FORM"]; 
_hqGuard1 moveinGunner _atPod1;
_atPod1 setDir( _centerPos getDir getPosWorld _atPod1); //try to situate this guy radially

// HMG
_atPod2 = ["B_HMG_01_high_F",_centerPos,[8,-7,0]] call _forty_spawn;
_hqGuard1 = _groupGuard createUnit ["B_Soldier_F", _centerPos, [], 0, "FORM"]; 
_hqGuard1 moveinGunner _atPod2;
_atPod2 setDir( _centerPos getDir getPosWorld _atPod2); //try to situate this guy radially

// LIGHTS
["Land_Camping_Light_F",_centerPos,[0,0,2]] call _forty_spawn;
["Land_Camping_Light_F",_centerPos,[5.5,-5.5,0]] call _forty_spawn;
["Land_Camping_Light_F",_centerPos,[-5.5,3.5,0]] call _forty_spawn;
["Land_Camping_Light_F",_centerPos,[5.5,3.5,0]] call _forty_spawn;
["Land_Camping_Light_F",_centerPos,[-5.5,-5.5,0]] call _forty_spawn;
["Land_Camping_Light_F",_centerPos,[-2.75,-2.75,0]] call _forty_spawn;
["Land_Camping_Light_F",_centerPos,[-2.75,2.75,0]] call _forty_spawn;
["Land_Camping_Light_F",_centerPos,[2.75,2.75,0]] call _forty_spawn;
["Land_Camping_Light_F",_centerPos,[-2.75,-2.75,1]] call _forty_spawn;

sleep 60;
_atPod1 allowdamage true;
_atPod2 allowdamage true;
_atPod3 allowdamage true;
_gl1Pod allowdamage true;
_aaPod allowdamage true;


_hq addAction ["<t color='#ff0066'>Replace Defences (20CP)</t>", "initHQ\refortify.sqf", [_aaPod, _gl1Pod, _atPod1, _atPod2, _atPod3, _centerPos, _hq], 0, true, true, "", "_this == player"];