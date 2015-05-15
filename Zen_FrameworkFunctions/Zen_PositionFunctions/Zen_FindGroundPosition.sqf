// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_FindGroundPosition", _this] call Zen_StackAdd;
private ["_area", "_pos", "_vars", "_mapSize"];

if !([_this, [["VOID"]], [["SCALAR"]], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([0,0,0])
};

_area = _this select 0;
_pos = [_area] call Zen_ConvertToPosition;

if (typeName _area == "STRING") then {
    if !([_area, allMapMarkers] call Zen_ValueIsInArray) then {
        0 = ["Zen_FindGroundPosition", "The given marker does not exist", _this] call Zen_PrintError;
        call Zen_StackPrint;
    } else {
        if ((markerShape _area) == "ICON") then {
            _this set [0, ([_area] call Zen_ConvertToPosition)];
            _vars = _this call Zen_GetArguments;

            if (count _vars > 0) then {
                _pos = _vars call Zen_CalculatePositionObject;
            };
        } else {
            _vars = _this call Zen_GetArguments;

            if (count _vars > 0) then {
            _pos = _vars call Zen_CalculatePositionMarker;
            };
        };
    };
} else {
    _vars = _this call Zen_GetArguments;
    
    if (count _vars > 0) then {
        _pos = _vars call Zen_CalculatePositionObject;
    };
};

_mapSize = getNumber (configFile >> "CfgWorlds" >> worldName >> "Grid" >> "offsetY");
if (_mapSize == 0) then {
    _mapSize = getNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize");
    if (_mapSize == 0) then {
        _mapSize = ((getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")) select 0) max ((getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")) select 1);
        _mapSize = _mapSize * 2;
    };
};

if ((((_pos select 0) < 0) || ((_pos select 1) < 0)) || {(((_pos select 0) > _mapSize) || ((_pos select 1) > _mapSize))}) then {
    0 = ["Zen_FindGroundPosition", "Returned position is off the map", _this] call Zen_PrintError;
    call Zen_StackPrint;
};

call Zen_StackRemove;
(_pos)
