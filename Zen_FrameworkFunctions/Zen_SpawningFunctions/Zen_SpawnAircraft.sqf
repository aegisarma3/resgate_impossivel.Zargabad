// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_SpawnAircraft", _this] call Zen_StackAdd;
private ["_spawnPos", "_sideOrClass", "_aircraftClass", "_aircraft", "_dir", "_height"];

if !([_this, [["VOID"], ["SIDE", "ARRAY", "STRING"], ["SCALAR"], ["SCALAR"]], [[], ["STRING"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (objNull)
};

_spawnPos = [(_this select 0)] call Zen_ConvertToPosition;
_sideOrClass = _this select 1;

_dir = 0;
_height = 300;

if (count _this > 2) then {
    _height = _this select 2;
};

if (count _this > 3) then {
    _dir = _this select 3;
};

if (typeName _sideOrClass != "SIDE") then {
    _aircraftClass = _sideOrClass;
    if (typeName _aircraftClass == "ARRAY") then {
        _aircraftClass = [_aircraftClass] call Zen_ArrayGetRandom;
    };
} else {
    switch (_sideOrClass) do {
        case west: {
            _aircraftClass = [([["air", "autonomous"], _sideOrClass, [(localize "str_Zen_UAV"), (localize "str_Zen_Jet")]] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;
        };
        case east: {
            _aircraftClass = [([["air", "autonomous"], _sideOrClass, [(localize "str_Zen_UAV"), (localize "str_Zen_Jet")]] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;
        };
        case resistance: {
            _aircraftClass = [([["air", "autonomous"], _sideOrClass, [(localize "str_Zen_UAV"), (localize "str_Zen_Jet")]] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;
        };
        case civilian: {
            0 = ["Zen_SpawnAircraft", "Civilian side has no planes or UAV's", _this] call Zen_PrintError;
            call Zen_StackPrint;
            _aircraftClass = [([["air", "autonomous"], _sideOrClass, [(localize "str_Zen_UAV"), (localize "str_Zen_Jet")]] call Zen_ConfigGetVehicleClasses)] call Zen_ArrayGetRandom;};
        default {
            _aircraftClass = "";
        };
    };
};

if (_aircraftClass == "") exitWith {
    0 = ["Zen_SpawnAircraft", "Given classname or side is invalid", _this] call Zen_PrintError;
    call Zen_StackRemove;
    (objNull)
};

_aircraft = [_spawnPos, _aircraftClass, _height, _dir, true] call Zen_SpawnVehicle;
0 = [_aircraft] call Zen_SpawnVehicleCrew;

if (_height > 3) then {
    _aircraft setVelocity [100 * sin _dir, 100 * cos _dir, 5];
};

call Zen_StackRemove;
(_aircraft)
