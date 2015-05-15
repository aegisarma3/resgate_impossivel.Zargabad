// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

{
    _cleanUnitsArray = [(_x select 1)] call Zen_ArrayRemoveDuplicates;
    if (count _cleanUnitsArray == 0) then {
        Zen_Task_Array_Global set [_forEachIndex, 0];
    } else {
        Zen_Task_Array_Global set [_forEachIndex, _cleanUnitsArray];
    };
} forEach Zen_Task_Array_Global;

Zen_Task_Array_Global = Zen_Task_Array_Global - [0];
publicVariable "Zen_Task_Array_Global";

if (true) exitWith {};
