// playerDisconnect.sqf
if !(isServer) exitwith {};
private _filename = "fn_pDConnected";
private _player = _this select 0;
private _pID = _this select 1;
private _pName = name _player;
if (_pname == "__SERVER__") exitwith {};
private _namespaceName = [_pid, _player] call spp_fnc_getplayernamespace;

// Skip saving if player is dead - prevents spawning dead on reconnect
if (!(isNull _player) && {!(alive _player)}) exitwith {
	[2, format["Player %1 is dead, skipping save to prevent dead respawn", _pName], _filename] call spp_fnc_log;
};

// [ [123,[loadout],[pos]], [124,[loadout],[pos]] ]
private _SPlayer = [];
if !(isNull _player) then {	
	_splayer = [_player, _pID, _pname] call spp_fnc_getPlayerData;
};

[3, format["Saving to %1, data: %2", _namespaceName, _SPlayer], _filename] call spp_fnc_log;
[_namespaceName, _splayer, _filename] call spp_fnc_namespaceUpdate;

[2, format["Player Save Completed for %1", name _player]] call spp_fnc_log;
