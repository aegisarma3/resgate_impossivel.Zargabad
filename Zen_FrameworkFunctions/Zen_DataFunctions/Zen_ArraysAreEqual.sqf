// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_ArraysAreEqual", _this] call Zen_StackAdd;
private ["_array1", "_array0"];

if !([_this, [["ARRAY"], ["ARRAY"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (false)
};

_array0 = _this select 0;
_array1 = _this select 1;

call Zen_StackRemove;
(_array0 isEqualTo _array1)
