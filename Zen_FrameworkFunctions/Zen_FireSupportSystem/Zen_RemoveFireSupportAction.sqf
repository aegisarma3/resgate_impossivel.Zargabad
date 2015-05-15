// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_RemoveFireSupportAction", _this] call Zen_StackAdd;
private ["_nameString", "_index", "_sendPacket", "_commMenuID", "_units"];

if !([_this, [["STRING"], ["BOOL"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_nameString = _this select 0;
_units = [+allUnits] call Zen_ArrayRemoveNonLocal;

_sendPacket = true;
if (count _this > 2) then {
    _sendPacket = _this select 2;
};

_index = [Zen_Fire_Support_Comm_ID_Array_Local, _nameString, 0] call Zen_ArrayGetNestedIndex;

if (_index == -1) exitWith {
    0 = ["Zen_RemoveFireSupportAction", "Given action does not exist", _this] call Zen_PrintError;
    call Zen_StackPrint;
    call Zen_StackRemove;
};

while {true} do {
    _commMenuID = (Zen_Fire_Support_Comm_ID_Array_Local select _index) select 1;
    {
        0 = [_x, _commMenuID] spawn BIS_fnc_removeCommMenuItem;
    } forEach _units;

    0 = [Zen_Fire_Support_Comm_ID_Array_Local, _index] call Zen_ArrayRemoveIndex;

    _index = [Zen_Fire_Support_Comm_ID_Array_Local, _nameString, 0] call Zen_ArrayGetNestedIndex;
    if (_index == -1) exitWith {};
};

if (isMultiplayer && {_sendPacket}) then {
    Zen_MP_Closure_Packet = ["Zen_RemoveFireSupportAction", (_this + [false])];
    publicVariable "Zen_MP_Closure_Packet";
};

call Zen_StackRemove;
if (true) exitWith {};
