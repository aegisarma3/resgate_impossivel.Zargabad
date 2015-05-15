// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_TransformObject", _this] call Zen_StackAdd;
private ["_obj", "_pos", "_heightChange", "_dir", "_isNormal", "_setNormal"];

if !([_this, [["OBJECT"], ["VOID"], ["SCALAR"], ["SCALAR"], ["BOOL"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (objNull)
};

_obj = _this select 0;
_pos = [(_this select 1)] call Zen_ConvertToPosition;

_heightChange = 0;
_dir = getDir _obj;
_isNormal = false;

if (count _this > 2) then {
    _heightChange = _this select 2;
};

if (count _this > 3) then {
    _dir = _this select 3;
};

if (count _this > 4) then {
    _isNormal = _this select 4;
};

if (surfaceIsWater _pos) then {
    _pos set [2, ((_pos select 2) + _heightChange) max (getTerrainHeightASL _pos)];
} else {
    _pos set [2, ((_pos select 2) + _heightChange) max 0.02];
};

_obj setPosATL _pos;
_setNormal = (_isNormal && {!(_obj isKindOf "Man")});

if (local _obj) then {
    0 = [_obj, _dir, _setNormal] spawn Zen_TransformObject_Orient_MP;
} else {
    Zen_MP_Closure_Packet = ["Zen_TransformObject_Orient_MP", [_obj, _dir, _setNormal]];
    (owner _obj) publicVariableClient "Zen_MP_Closure_Packet";
};

call Zen_StackRemove;
if (true) exitWith {};
