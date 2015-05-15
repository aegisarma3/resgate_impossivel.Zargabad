// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_OrderInfantryPatrolBuilding", _this] call Zen_StackAdd;
private ["_units", "_centerPos", "_buildingName", "_buildingPositions", "_unitsRemove", "_patrolOutside", "_i", "_behavior"];

if !([_this, [["VOID"], ["VOID"], ["BOOL"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_units = [(_this select 0)] call Zen_ConvertToObjectArray;
_centerPos = [(_this select 1)] call Zen_ConvertToPosition;

_patrolOutside = false;
_behavior = "aware";

if (count _this > 2) then {
    _patrolOutside = _this select 2;
};

if (count _this > 2) then {
    _patrolOutside = _this select 2;
};

_buildingName = nearestBuilding _centerPos;
ZEN_STD_OBJ_CBP(_buildingPositions, _buildingName)

{
    _x doMove (_buildingName buildingPos (round (random _buildingPositions)));
    _x setUnitPos "up";
} forEach _units;

while {(count _units > 0)} do {
    _unitsRemove = [];
    {
        if !(alive _x) then {
            _unitsRemove pushBack _x;
        } else {
            (group _x) setBehaviour _behavior;
            if (unitReady _x) then {
                if (_patrolOutside && {((random 1) > 0.7)}) then {
                    _x doMove ([_buildingName, 15, (random 360)] call Zen_ExtendPosition);
                    _x setUnitPos "up";
                } else {
                    _x doMove (_buildingName buildingPos (round (random _buildingPositions)));
                    _x setUnitPos "up";
                };
            };
        };
        sleep 2;
    } forEach _units;
    _units = _units - _unitsRemove;
    sleep 2;
};

call Zen_StackRemove;
if (true) exitWith {};
