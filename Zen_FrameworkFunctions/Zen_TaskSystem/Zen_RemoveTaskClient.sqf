// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

if (count Zen_Task_Array_Local == 0) exitWith {};

_Zen_stack_Trace = ["Zen_RemoveTaskClient", _this] call Zen_StackAdd;
private ["_nameString", "_units", "_unit", "_taskArray", "_localTaskData", "_taskIndex", "_tasksRemoved"];

if !([_this, [["STRING"], ["ARRAY"]], [[], ["OBJECT"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;
_units = _this select 1;

if (count _units == 0) exitWith {
    call Zen_StackRemove;
};

_localTaskData = [_nameString] call Zen_GetTaskDataLocal;
_taskArray = _localTaskData select 1;
_tasksRemoved = [];

{
    _unit = _x;
    {
        if (_x in simpleTasks _unit) then {
            _unit removeSimpleTask _x;
            _tasksRemoved pushBack _x;
        };
    } forEach _taskArray;
} forEach _units;

_taskArray = [_taskArray, _tasksRemoved] call Zen_ArrayFilterValues;
_taskIndex = [Zen_Task_Array_Local, _nameString, 0] call Zen_ArrayGetNestedIndex;

if (_taskIndex == -1) then {
    _taskIndex = count Zen_Task_Array_Local;
};

Zen_Task_Array_Local set [_taskIndex, [_nameString, _taskArray]];
0 = [] call Zen_CleanLocalTaskArray;

if ((!isDedicated && hasInterface) && {(player in _units)}) then {
    0 = ["TaskRemoved", ["", (([_nameString] call Zen_GetTaskDataGlobal) select 5)]] call bis_fnc_showNotification;
};

call Zen_StackRemove;
if (true) exitWith {};
