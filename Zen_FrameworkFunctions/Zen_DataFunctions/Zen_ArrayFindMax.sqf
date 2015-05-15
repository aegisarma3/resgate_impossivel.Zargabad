// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_ArrayFindMax", _this] call Zen_StackAdd;
private ["_outNum", "_array"];

if !([_this, [["ARRAY"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (0)
};

_array = _this select 0;
_outNum = 0;

{
    if (typeName _x == "SCALAR") exitWith {
        _outNum = _x;
    };
} forEach _array;

{
    if (typeName _x == "SCALAR") then {
        _outNum = _x max _outNum;
    };
} forEach _array;

call Zen_StackRemove;
(_outNum)
