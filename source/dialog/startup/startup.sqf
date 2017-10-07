//only show the startup dialog for the host. for dedicated used defaults.
if (!isDedicated) then {
	_handle = createDialog "startup_dialog";
	waitUntil {_handle};
};
[] call startup_defaults_fn;
