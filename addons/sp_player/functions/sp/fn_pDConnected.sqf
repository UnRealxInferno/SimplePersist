// playerDisconnect.sqf
if !(isServer) exitwith {};
private _filename = "fn_pDConnected";
params ["_player", "_pID"];
private _pName = name _player;
if (_pName == "__SERVER__") exitwith {};
private _namespaceName = [_pID, _player] call spp_fnc_getplayernamespace;

// Clear saved data if player is dead - prevents spawning dead on reconnect
if (!(isNull _player) && {!(alive _player)}) exitwith {
	[2, format["Player %1 is dead, clearing saved data to prevent dead respawn", _pName], _filename] call spp_fnc_log;
	// Clear the player's saved data by setting empty array directly
	private _SaveSystem = profileNamespace getvariable ["SPSavelocation", 0];
	if (_SaveSystem == 1) then {
		missionProfileNamespace setVariable [_namespaceName, []];
		saveMissionProfileNamespace;
	} else {
		profileNamespace setVariable [_namespaceName, []];
		saveProfileNamespace;
	};
	[2, format["Player %1 saved data cleared", _pName], _filename] call spp_fnc_log;
};

// [ [123,[loadout],[pos]], [124,[loadout],[pos]] ]
private _sPlayer = [];
if !(isNull _player) then {	
	_sPlayer = [_player, _pID, _pName] call spp_fnc_getPlayerData;
};

[3, format["Saving to %1, data: %2", _namespaceName, _sPlayer], _filename] call spp_fnc_log;
[_namespaceName, _sPlayer, _filename] call spp_fnc_namespaceUpdate;

[2, format["Player Save Completed for %1", name _player]] call spp_fnc_log;
