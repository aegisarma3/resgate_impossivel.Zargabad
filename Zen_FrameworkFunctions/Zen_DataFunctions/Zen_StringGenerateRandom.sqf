// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_StringGenerateRandom", _this] call Zen_StackAdd;
private ["_count", "_string", "_i", "_ch"];

if !([_this, [["SCALAR"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ("")
};

_count = _this select 0;

_string = [];
for "_i" from 1 to _count do {
    _ch = floor (33 + random 93);
    if !(_ch in [34, 39]) then {
        _string set [(_i - 1), _ch];
    } else {
        _i = _i - 1;
    };
};

call Zen_StackRemove;
(toString _string)
