// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_CalculatePositionMarker", _this] call Zen_StackAdd;
private ["_area", "_min", "_water", "_road", "_pos", "_isGood", "_roadDist", "_minAngle", "_maxAngle", "_markerDir", "_markerSizeArray", "_markerCenterXY", "_markerShape", "_i", "_exit", "_nearestRoad", "_roads", "_areaArea", "_iterationCount"];

_area = _this select 0;
_min = _this select 1;
_water = _this select 3;
_road = _this select 4;
_roadDist = _this select 5;
_minAngle = _this select 6;
_maxAngle = _this select 7;

_markerDir = markerDir _area;
_markerSizeArray = getMarkerSize _area;
_markerCenterXY = getMarkerPos _area;
_markerShape = markerShape _area;

_pos = [0,0,0];
_exit = false;

0 = [_this, 2, 0] call Zen_ArrayInsert;

if (_road == 2) then {
    if (_markerShape == "ellipse") then {
        _roads = _markerCenterXY nearRoads ((_markerSizeArray select 0) max (_markerSizeArray select 1));
    } else {
        _roads = _markerCenterXY nearRoads (_markerSizeArray distance [0,0]);
    };

    if (count _roads > 0) then {
        _nearestRoad = [_roads, _area] call Zen_FindMinDistance;
        if !([_nearestRoad, _markerCenterXY, _markerSizeArray, _markerDir, _markerShape] call Zen_IsPointInPoly) then {
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
    ([_area] call Zen_ConvertToPosition)
};

if (_water > 0) then {
    if (_water == 1) then {
        _exit = !([_markerCenterXY, (_markerSizeArray distance [0,0]), "land"] call Zen_IsNearTerrain);
    } else {
        _exit = !([_markerCenterXY, (_markerSizeArray distance [0,0]), "water"] call Zen_IsNearTerrain);
    };

    if (_exit) then {
        0 = ["Zen_FindGroundPosition", "No valid position possible, water preference impossible", _this] call Zen_PrintError;
        call Zen_StackPrint;
    };
};

if (_exit) exitWith {
    call Zen_StackRemove;
    ([_area] call Zen_ConvertToPosition)
};

if (_markerShape == "Ellipse") then {
    _areaArea = ([_markerSizeArray] call Zen_ArrayFindAverage)^2 * pi;
} else {
    _areaArea = 4 * (_markerSizeArray select 0) * (_markerSizeArray select 1);
};

_iterationCount = ((round (_areaArea * (abs (_maxAngle - _minAngle)) / 100 / pi / 360)) max 10) min 1000;
for "_i" from 1 to _iterationCount step 1 do {
    _isGood = true;

    switch (_markerShape) do {
        case "ICON": {
            _pos = [(getMarkerPos _area select 0),(getMarkerPos _area select 1),0];
        };
        case "RECTANGLE": {
            _pos = [_markerCenterXY, _markerSizeArray, _markerDir, _minAngle, _maxAngle] call Zen_PositionRectangle;
        };
        case "ELLIPSE": {
            _pos = [_markerCenterXY, _markerSizeArray, _markerDir, _minAngle, _maxAngle] call Zen_PositionEllipse;
        };
    };

    if (_road in [1, 2]) then {
        _roads = _pos nearRoads _roadDist;
        if (count _roads > 0) then {
            _pos = ([([_roads] call Zen_ArrayGetRandom)] call Zen_ConvertToPosition);
        };
    };

    _this set [25, _pos];
    _isGood = [_pos, _markerCenterXY, _markerSizeArray, _markerDir, _markerShape] call Zen_IsPointInPoly;

    if (_isGood) then {
        _isGood = _this call Zen_CheckPosition;
    };

    if (_isGood) exitWith {};
    if (_i == 1000) then {
        0 = ["Zen_FindGroundPosition", "No valid position found", _this] call Zen_PrintError;
        call Zen_StackPrint;
    };

    if !(_isGood) then {
        _pos = [_area] call Zen_ConvertToPosition;
    };
};

call Zen_StackRemove;
(_pos)
