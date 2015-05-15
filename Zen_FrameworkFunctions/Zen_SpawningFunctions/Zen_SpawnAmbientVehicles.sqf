// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_SpawnAmbientVehicles", _this] call Zen_StackAdd;
private ["_center", "_distance", "_numCarsRange", "_townMarkers", "_carPos", "_carType", "_car", "_carClasses", "_carsMin", "_carsMax", "_numCars", "_carObjs", "_roadDir"];

if !([_this, [["VOID"], ["SCALAR"], ["ARRAY", "SCALAR"]], [[], [], ["SCALAR"]], 3] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([objNull])
};

_center = [(_this select 0)] call Zen_ConvertToPosition;
_distance = _this select 1;
_numCarsRange = _this select 2;
_townMarkers = [["NameVillage", "NameCity", "NameCityCapital"]] call Zen_ConfigGetLocations;

if (typeName _numCarsRange != "ARRAY") then {
    _numCarsRange = [_numCarsRange, _numCarsRange];
};

_carsMin = _numCarsRange select 0;
_carsMax = _numCarsRange select 1;

_carClasses = ["car", civilian] call Zen_ConfigGetVehicleClasses;
_carObjs = [];

{
    if (([_x, _center] call Zen_Find2dDistance) < _distance) then {
        _numCars = [_carsMin, _carsMax, true] call Zen_FindInRange;
        for "_i" from 1 to _numCars do {
            _carPos = [_x, 0, 0, 1, [1, 500]] call Zen_FindGroundPosition;
            _carType = [_carClasses] call Zen_ArrayGetRandom;

            _roadDir = [_carPos] call Zen_FindRoadDirection;
            _car = [[_carPos, 4, _roadDir + 90, "trig"] call Zen_ExtendPosition, _carType, 0, 90 - _roadDir] call Zen_SpawnVehicle;
            _carObjs pushBack _car;
        };
    };

    deleteMarker _x;
} forEach _townMarkers;

call Zen_StackRemove;
(_carObjs)
