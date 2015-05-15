// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_FrameworkLibrary.sqf"
#define INSERT_CUTOFF 7
#define EVAL(X) (X call _comparator)
#define COMP(X, Y) ([X, Y] call _comparator)

_Zen_stack_Trace = ["Zen_ArraySort", _this] call Zen_StackAdd;
private ["_array", "_comparator", "_insertionSort", "_shellSort", "_quickSort", "_sortedArray"];

if !([_this, [["ARRAY"], ["CODE"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_array = _this select 0;

_comparator = {if ((_this select 0) < (_this select 1)) exitWith {-1}; (if ((_this select 0) == (_this select 1)) then {0} else {1})};

if (count _this > 1) then {
    _comparator = _this select 1;
};

_insertionSort = {
    private ["_i", "_j", "_valueOrder", "_count", "_array", "_value"];

    _array = _this;
    if (count _array < 2) exitWith {};

    _count = count _array - 1;

    for "_i" from 1 to _count step 1 do {
        _value = _array select _i;
        for [{_j = _i}, {_j >= 1}, {_j = _j - 1}] do {
            if (COMP(_value, (_array select (_j - 1))) > 0) exitWith {};
            _array set [_j, _array select (_j - 1)];
        };

        _array set [_j, _value];
    };
    if (true) exitWith {};
};

/* 
_shellSort = {
    private ["_gaps", "_i", "_j", "_valueOrder", "_count", "_array"];

    _array = _this;
    _gaps = [701, 301, 132, 57, 23, 10, 4, 1];
    _count = count _array - 1;

    {
        for "_i" from _x to _count step 1 do {
            if (_i <= _count) then {
                _value = _array select _i;
                _valueOrder = EVAL(_value);
                for [{_j = _i}, {_j >= _x}, {_j = _j - _x}] do {
                    if (COMP(_valueOrder, (_array select (_j - 1))) > 0) exitWith {};
                    _array set [_j, _array select (_j - _x)];
                };

                _array set [_j, _value];
            };
        };
    } forEach _gaps;
    if (true) exitWith {};
};
// */

_quickSort = {
    private ["_array", "_pivot", "_less", "_greater", "_equal", "_pivotOrder"];

    _array = _this;

    _pivotArray = [_array select 0, _array select (count _array - 1), _array select ((count _array) / 2)];
    0 = [_pivotArray] call _insertionSort;
    _pivot = _pivotArray select 1;

    _less = [];
    _equal = [];
    _greater = [];

    {
        switch (COMP(_x, _pivot)) do {
            case -1: {
                _less pushBack _x;
            };
            case 0: {
                _equal pushBack _x;
            };
            case 1: {
                _greater pushBack _x;
            };
        };

    } forEach _array;

    if (count _less < INSERT_CUTOFF) then {
        0 = _less call _insertionSort;
    } else {
        _less = _less call _quickSort;
    };

    if (count _greater < INSERT_CUTOFF) then {
        0 = _greater call _insertionSort;
    } else {
        _greater = _greater call _quickSort;
    };

    (_less + _equal + _greater)
};

// 0 = _array call _shellSort;
// 0 = _array call _insertionSort;

_sortedArray = _array call _quickSort;
// 0 = [_array, _sortedArray] call Zen_ArrayCopy;

call Zen_StackRemove;
(_sortedArray)
