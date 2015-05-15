// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_ArrayGetNestedIndex", _this] call Zen_StackAdd;
private ["_givenSearchValue", "_givenSearchArray", "_desiredIndex", "_index", "_nestedArray", "_currentIndex"];

if !([_this, [["ARRAY"], ["VOID"], ["SCALAR"]], [], 3] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (count (_this select 0))
};

_givenSearchArray = _this select 0;
_givenSearchValue = _this select 1;
_desiredIndex = _this select 2;

scopeName "main";
_index = -1;

{
    _currentIndex = _forEachIndex;
    if (_desiredIndex != -1) then {
        if ([(_x select _desiredIndex), _givenSearchValue] call Zen_ValuesAreEqual) exitWith {
            _index = _currentIndex;
        };
    } else {
        _nestedArray = _x;
        {
            if ([_x, _givenSearchValue] call Zen_ValuesAreEqual) then {
                _index = _currentIndex;
                breakTo "main";
            };
        } forEach _nestedArray;
    };
} forEach _givenSearchArray;

call Zen_StackRemove;
(_index)
