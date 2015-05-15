// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_SpawnInfantryGarrison", _this] call Zen_StackAdd;
private ["_centerPos", "_buildingName", "_buildingPositions", "_guardsGroup", "_i"];

if !([_this, [["VOID"], ["SIDE"], ["SCALAR", "ARRAY", "STRING"], ["SCALAR", "ARRAY"], ["STRING"], ["STRING"], ["ARRAY"]], [[], [], ["SCALAR"], ["SCALAR"]], 4] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (grpNull)
};

_centerPos = [(_this select 0)] call Zen_ConvertToPosition;

_buildingName = nearestBuilding _centerPos;
ZEN_STD_OBJ_CBP(_buildingPositions, _buildingName)

if (_buildingPositions == -1) exitWith {
    0 = ["Zen_SpawnInfantryGarrison", "Nearest building has no garrison points", _this] call Zen_PrintError;
    call Zen_StackPrint;
    call Zen_StackRemove;
    (_guardsGroup)
};

_guardsGroup = ([([_buildingName, 15, random 360] call Zen_ExtendPosition)] + ([_this, 1] call Zen_ArrayGetIndexedSlice)) call Zen_SpawnInfantry;

{
    for "_i" from 1 to 20 do {
        0 = [_x, (_buildingName buildingPos ([0, _buildingPositions, true] call Zen_FindInRange)), 0.02, (random 360)] call Zen_TransformObject;
        if ([_x] call Zen_AreIndoors) exitWith {};
    };
    _x setUnitPosWeak "up";
    doStop _x;
} forEach (units _guardsGroup);

call Zen_StackRemove;
(_guardsGroup)
