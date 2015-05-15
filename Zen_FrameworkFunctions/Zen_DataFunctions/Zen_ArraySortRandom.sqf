// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_ArraySortRandom", _this] call Zen_StackAdd;
private ["_array", "_returnArray", "_randomIndex"];

if !([_this, [["ARRAY"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (_this select 0)
};

_array =+ (_this select 0);
_returnArray = [];

for "_i" from 0 to (count _array - 1) do {
    _randomIndex = ZEN_STD_ARR_RI(_array);
    _returnArray pushBack (_array select _randomIndex);
    ZEN_STD_ARR_UR(_array, _randomIndex)
};

call Zen_StackRemove;
(_returnArray)
