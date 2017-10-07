_fobpos = _this select 0;
diag_log format["teleporting player"];

player setpos _fobpos;
hint format["%1",_fobpos];