
mission_number_of_zones_captured = (mission_number_of_zones_captured + 1);

//when using dedicated missions do not keep track of zones captured in profile.
if(!DedicatedMission && !debugmode) then {
	profileNamespace setVariable ["profile_number_of_zones_captured", mission_number_of_zones_captured]; 
	saveProfileNamespace; // sauvegarde le profil
};

if (isMultiplayer) then {
	//make sure to broadcast the number of captured zones.
	if (isServer) then {
		capturedZonesNumber = capturedZonesNumber + 1;
		publicVariable "capturedZonesNumber";
	};
};
