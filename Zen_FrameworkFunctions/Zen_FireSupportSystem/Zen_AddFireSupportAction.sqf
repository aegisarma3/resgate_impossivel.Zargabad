// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_AddFireSupportAction", _this] call Zen_StackAdd;
private ["_units", "_sendPacket", "_titleString", "_supportString", "_commMenuID", "_maxCalls", "_guideObj", "_guideType", "_templateArray"];

if !([_this, [["VOID"], ["STRING"], ["STRING"], ["SCALAR"], ["OBJECT"], ["STRING"]], [], 4] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_units = [(_this select 0)] call Zen_ConvertToObjectArray;
_supportString = _this select 1;
_titleString = _this select 2;
_maxCalls = _this select 3;

if (count _this > 4) then {
    _guideObj = _this select 4;
} else {
    _guideObj = (_units select 0);
    _this set [4, _guideObj];
};

if (count _this > 5) then {
    _guideType = _this select 5;
} else {
    _guideType = "designator";
    _this set [5, _guideType];
};

_sendPacket = true;
if (count _this > 6) then {
    _sendPacket = _this select 6;
};

_templateArray = [_supportString] call Zen_GetFireSupportData;

if (!(isDedicated) && hasInterface && {player in _units}) then {
    _commMenuID = [player, "Zen_FireSupport", _titleString, (format ["0 = [_pos, '%1', %2, '%3'] call Zen_InvokeFireSupportAction;", _supportString, _guideObj, _guideType])] call BIS_fnc_addCommMenuItem;
    Zen_Fire_Support_Comm_ID_Array_Local pushBack [_supportString, _commMenuID, 0, _maxCalls];
};

if (isMultiplayer && {_sendPacket}) then {
    Zen_MP_Closure_Packet = ["Zen_AddFireSupportAction", (_this + [false])];
    publicVariable "Zen_MP_Closure_Packet";
};

call Zen_StackRemove;
if (true) exitWith {};
