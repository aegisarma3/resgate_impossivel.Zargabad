// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_OrderInfantryMove", _this] call Zen_StackAdd;
private ["_group", "_inPos", "_speedMode", "_behaviorMode"];

if !([_this, [["OBJECT", "GROUP"], ["VOID"], ["STRING"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_group = _this select 0;
_inPos = [(_this select 1)] call Zen_ConvertToPosition;

_speedMode = "normal";
_behaviorMode = "safe";

if (count _this > 2) then {
    _speedMode = _this select 2;
};

if (count _this > 3) then {
    _behaviorMode = _this select 3;
};

if (typeName _group == "OBJECT") then {
    _group = group _group;
};

_group move _inPos;
_group setBehaviour _behaviorMode;
_group setCombatMode "green";
_group setSpeedMode _speedMode;
_group allowFleeing 0;

sleep 5;

waitUntil {
    sleep 2;
    (((alive leader _group) && {(unitReady leader _group)}) || (({alive _x} count units _group) == 0))
};

_group move (getPosATL (leader _group));

call Zen_StackRemove;
if (true) exitWith {};
