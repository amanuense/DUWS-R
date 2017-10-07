// Super simple auto-save script.
enableSaving false;
sleep 0.1;
if (!isDedicated) then {
	saveGame;
};
enableSaving true;
