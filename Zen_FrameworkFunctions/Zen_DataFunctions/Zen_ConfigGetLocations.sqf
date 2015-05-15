// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_ConfigGetLocations", _this] call Zen_StackAdd;
private ["_locMarkers", "_locTypes", "_locConfig", "_locClass", "_locType", "_radiusX", "_radiusY", "_locPos", "_locMk", "_i"];

if !([_this, [["STRING", "ARRAY"]], [["STRING"]], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_locTypes = _this select 0;

_locMarkers = [];
_locConfig = configFile >> "CfgWorlds" >> worldName >> "Names";

for "_i" from 0 to (count _locConfig - 1) do {
    _locClass = _locConfig select _i;
    _locType = getText (_locClass >> "type");

    if ([_locType, _locTypes] call Zen_ValueIsInArray) then {
        _radiusX = getNumber (_locClass >> "radiusB");
        _radiusY = getNumber (_locClass >> "radiusA");
        _locPos = getArray (_locClass >> "position");

        _locMk = [_locPos, "", "colorBlack", [_radiusX, _radiusY], "ellipse", 0, 0] call Zen_SpawnMarker;
        _locMarkers pushBack _locMk;
    };
};

call Zen_StackRemove;
(_locMarkers)
