// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_GiveLoadout", _this] call Zen_StackAdd;
private ["_units", "_kits", "_side"];

if !([_this, [["VOID"], ["SIDE", "STRING"], ["ARRAY", "STRING"]], [[], [], ["STRING"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_units = _this select 0;
_side = _this select 1;

_kits = [];
if (count _this > 2) then {
    _kits = _this select 2;
    _kits = [_kits];
};

if (typeName _side == "SIDE") then {
    switch (_side) do {
        case west: {
            0 = ([_units] + _kits) call Zen_GiveLoadoutBlufor;
        };
        case east: {
            0 = ([_units] + _kits) call Zen_GiveLoadoutOpfor;
        };
        case resistance: {
            0 = ([_units] + _kits) call Zen_GiveLoadoutIndfor;
        };
        case civilian: {
            0 = [_units, "civilian"] call Zen_GiveLoadoutBlufor;
        };
        default {
            0 = ["Zen_GiveLoadout", "Invalid side given", _this] call Zen_PrintError;
            call Zen_StackPrint;
        };
    };
} else {
    0 = ([_units] + _kits) call Zen_GiveLoadoutCustom;
};

call Zen_StackRemove;
if (true) exitWith {};
