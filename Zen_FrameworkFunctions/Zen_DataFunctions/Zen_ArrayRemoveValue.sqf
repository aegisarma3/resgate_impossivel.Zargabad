// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_ArrayRemoveValue", _this] call Zen_StackAdd;
private ["_array", "_value", "_i", "_index"];

if !([_this, [["ARRAY"], ["VOID"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_array = _this select 0;
_value = _this select 1;

for "_i" from 0 to 1 step 0 do {
    _index = [_value, _array] call Zen_ValueFindInArray;
    if (_index == -1) exitWith {};
    0 = [_array, _index] call Zen_ArrayRemoveIndex;
};

call Zen_StackRemove;
if (true) exitWith {};
