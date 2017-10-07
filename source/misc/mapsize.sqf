__mapsize = worldSize;
diag_log format ["Mapsize = %1", __mapsize];
half_of_map = __mapsize/2;
center_of_map = [half_of_map, half_of_map];

publicVariable "center_of_map";
publicVariable "half_of_map";