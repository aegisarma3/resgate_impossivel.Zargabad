// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_FastRope", _this] call Zen_StackAdd;
private ["_heli", "_unit", "_rope", "_height", "_ropePoint", "_unitHeight", "_heliVelocity", "_nearBuilding"];

if !([_this, [["OBJECT"], ["OBJECT"], ["OBJECT"], ["SCALAR"]], [], 4] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_heli = _this select 0;
_unit = _this select 1;
_rope = _this select 2;
_height = _this select 3;

if ((local _unit) && {(_unit in _heli)}) then {
    unassignVehicle _unit;
    _unit action ["eject", _heli];

    0 = [_unit, _unit, -2, (getDir _unit)] call Zen_TransformObject;
    _ropePoint = 22;

    waitUntil {
        if !(isPlayer (driver _heli)) then {
            _heli setVelocity [0,0,0];
            _heli setVectorUp [0,0,1];
        };

        _unit allowDamage false;
        _unit switchMove "commander_apctracked3_out";
        _unit setVelocity [0, 0, 0];
        _unit attachTo [_rope, [0, 0, _ropePoint]];
        _ropePoint = _ropePoint - 2;

        _nearBuilding = false;
        _unitHeight = ZEN_STD_OBJ_PZT(_unit);

        if ((abs (_unitHeight - _height)) < 3) then {
            _nearBuilding = true;
        };

        sleep 0.25;
        ((_unitHeight < 3) || (ZEN_STD_OBJ_PZS(_unit) < 3) || _nearBuilding || ((_heli distance _unit) > 51))
    };

    _heliVelocity = velocity _heli;
    _heliVelocity set [2, -1];

    detach _unit;
    _unit setVelocity _heliVelocity;

    if !(isPlayer _unit) then {
        _unit doMove ([_unit, 5, getDir _unit] call Zen_ExtendPosition);
    };

    unassignVehicle _unit;
} else {
    waitUntil {
        sleep 0.5;
        ((isTouchingGround _unit) || ZEN_STD_OBJ_PZS(_unit) < 1)
    };
};

_unit switchMove "";
_unit allowDamage true;
call Zen_StackRemove;
if (true) exitWith {};
