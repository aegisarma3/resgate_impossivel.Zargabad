// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_RotateAsSet", _this] call Zen_StackAdd;
private ["_moveObjects", "_avgCenter", "_moveMarkers", "_newPos", "_rotateAngle"];

if !([_this, [["VOID"], ["SCALAR"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_moveEntities = _this select 0;
_rotateAngle = _this select 1;

if (typeName _moveEntities != "ARRAY") then {
    _moveEntities = [_moveEntities];
};

_moveMarkers = [_moveEntities, ""] call Zen_ArrayGetType;
_moveObjects = [_moveEntities] call Zen_ConvertToObjectArray;

0 = [_moveObjects, _moveMarkers] call Zen_ArrayAppendNested;
_avgCenter = _moveObjects call Zen_FindAveragePosition;

{
    _newPos = [_avgCenter, ([_avgCenter, _x] call Zen_Find2dDistance), (([_avgCenter, _x] call Zen_FindDirection) - _rotateAngle), "trig", 0] call Zen_ExtendPosition;
    if (typeName _x == "STRING") then {
        _x setMarkerPos _newPos;
    } else {
        0 = [_x, _newPos, 0.2, (getDir _x), true] call Zen_TransformObject;
    };
} forEach _moveObjects;

call Zen_StackRemove;
if (true) exitWith {};
