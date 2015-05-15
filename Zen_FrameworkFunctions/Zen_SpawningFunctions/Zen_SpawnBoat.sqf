// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_SpawnBoat", _this] call Zen_StackAdd;
private ["_spawnPos", "_sideOrClass", "_vehClass", "_vehListEast", "_vehListWest", "_vehListResistance", "_veh", "_vehListCiv", "_dir"];

if !([_this, [["VOID"], ["SIDE", "ARRAY", "STRING"], ["SCALAR"]], [[], ["STRING"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (objNull)
};

_spawnPos = [(_this select 0)] call Zen_ConvertToPosition;
_sideOrClass = _this select 1;

_dir = 0;
if (count _this > 2) then {
    _dir = _this select 2;
};

if (typeName _sideOrClass != "SIDE") then {
    _vehClass = _sideOrClass;
    if (typeName _vehClass == "ARRAY") then {
        _vehClass = [_vehClass] call Zen_ArrayGetRandom;
    };
} else {
    switch (_sideOrClass) do {
        case west: {
            _vehClass = [(["ship", _sideOrClass] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;
        };
        case east: {
            _vehClass = [(["ship", _sideOrClass] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;
        };
        case resistance: {
            _vehClass = [(["ship", _sideOrClass] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;
        };
        case civilian: {
            _vehClass = [(["ship", _sideOrClass] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;
        };
        default {
            _vehClass = "";
        };
    };
};

if (_vehClass == "") exitWith {
    0 = ["Zen_SpawnBoat", "Given classname or side is invalid", _this] call Zen_PrintError;
    call Zen_StackRemove;
    (objNull)
};

_veh = [_spawnPos, _vehClass, 0, _dir] call Zen_SpawnVehicle;
0 = [_veh] call Zen_SpawnVehicleCrew;

call Zen_StackRemove;
(_veh)
