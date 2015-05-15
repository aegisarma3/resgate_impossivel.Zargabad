// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_SpawnHelicopter", _this] call Zen_StackAdd;
private ["_spawnPos", "_sideOrClass", "_heliClass", "_heli", "_dir", "_height"];

if !([_this, [["VOID"], ["SIDE", "ARRAY", "STRING"], ["SCALAR"], ["SCALAR"]], [[], ["STRING"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (objNull)
};

_spawnPos = [(_this select 0)] call Zen_ConvertToPosition;
_sideOrClass = _this select 1;

_dir = 0;
_height = 40;

if (count _this > 2) then {
    _height = _this select 2;
};

if (count _this > 3) then {
    _dir = _this select 3;
};

if (typeName _sideOrClass != "SIDE") then {
    _heliClass = _sideOrClass;
    if (typeName _heliClass == "ARRAY") then {
        _heliClass = [_heliClass] call Zen_ArrayGetRandom;
    };
} else {
    switch (_sideOrClass) do {
        case west: {
            _heliClass = [(["air", _sideOrClass, [(localize "str_Zen_Heli"), (localize "str_Zen_Gunship")]] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;
        };
        case east: {
            _heliClass = [(["air", _sideOrClass, [(localize "str_Zen_Heli"), (localize "str_Zen_Gunship")]] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;
        };
        case resistance: {
            _heliClass = [(["air", _sideOrClass, [(localize "str_Zen_Heli"), (localize "str_Zen_Gunship")]] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;
        };
        case civilian: {
            0 = ["Zen_SpawnHelicopter", "Civilian side has no helicopters", _this] call Zen_PrintError;
            call Zen_StackPrint;
            _heliClass = [(["air", _sideOrClass, [(localize "str_Zen_Heli"), (localize "str_Zen_Gunship")]] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;};
        default {
            _heliClass = "";
        };
    };
};

if (_heliClass == "") exitWith {
    0 = ["Zen_SpawnHelicopter", "Given classname or side is invalid", _this] call Zen_PrintError;
    call Zen_StackRemove;
    (objNull)
};

_heli = [_spawnPos, _heliClass, _height, _dir, true] call Zen_SpawnVehicle;
0 = [_heli] call Zen_SpawnVehicleCrew;

call Zen_StackRemove;
(_heli)
