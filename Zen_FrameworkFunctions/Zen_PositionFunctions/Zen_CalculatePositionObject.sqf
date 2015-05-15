// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_CalculatePositionObject", _this] call Zen_StackAdd;
private ["_area", "_min", "_max", "_water", "_isGood", "_pos", "_i", "_minAngle", "_maxAngle", "_road", "_roadDist", "_exit", "_nearestRoad", "_furthestRoad", "_roads", "_dist", "_iterationCount"];

_area = _this select 0;
_min = _this select 1;
_max = _this select 2;
_water = _this select 4;
_road = _this select 5;
_roadDist = _this select 6;
_minAngle = _this select 7;
_maxAngle = _this select 8;

_pos = [0,0,0];
_exit = false;

if (_road == 2) then {
    _roads = _area nearRoads _max;
    _furthestRoad = [_roads, _area] call Zen_FindMaxDistance;

    if (count _roads > 0) then {
        _dist = [_furthestRoad, _area] call Zen_Find2dDistance;
        if (_dist < _min) then {
            0 = ["Zen_FindGroundPosition", "No valid position possible, no roads within area", _this] call Zen_PrintError;
            call Zen_StackPrint;
            _exit = true;
        };
    } else {
        0 = ["Zen_FindGroundPosition", "No valid position possible, no roads within area", _this] call Zen_PrintError;
        call Zen_StackPrint;
        _exit = true;
    };
};

if (_exit) exitWith {
    call Zen_StackRemove;
    (_area)
};

if (_water > 0) then {
    if (_water == 1) then {
        _exit = !([_area, _max, "land"] call Zen_IsNearTerrain);
    } else {
        _exit = !([_area, _max, "water"] call Zen_IsNearTerrain);
    };

    if (_exit) then {
        0 = ["Zen_FindGroundPosition", "No valid position possible, water preference impossible", _this] call Zen_PrintError;
        call Zen_StackPrint;
    };
};

if (_exit) exitWith {
    call Zen_StackRemove;
    (_area)
};

_iterationCount = ((round (((_max^2 * pi) - (_min^2 * pi)) * (abs (_maxAngle - _minAngle)) / 100 / pi / 360)) max 10) min 1000;
for "_i" from 1 to _iterationCount step 1 do {
    _isGood = true;

    _pos = [_area,_min,_max,_minAngle,_maxAngle] call Zen_PositionObject;

    if (_road in [1, 2]) then {
        _roads = _pos nearRoads _roadDist;
        if (count _roads > 0) then {
            _pos = ([([_roads] call Zen_ArrayGetRandom)] call Zen_ConvertToPosition);
        };
    };

    _dist = [_area, _pos] call Zen_Find2dDistance;
    _isGood = (_dist <= _max) && (_dist >= _min);

    _this set [25, _pos];
    if (_isGood) then {
        _isGood = _this call Zen_CheckPosition;
    };

    if (_isGood) exitWith {};
    if (_i == 1000) then {
        0 = ["Zen_FindGroundPosition", "No valid position found", _this] call Zen_PrintError;
        call Zen_StackPrint;
    };

    if !(_isGood) then {
        _pos = _area;
    };
};

call Zen_StackRemove;
(_pos)
