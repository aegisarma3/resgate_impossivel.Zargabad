// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_OrderHelicopterLand", _this] call Zen_StackAdd;
private ["_heli", "_heliDriver", "_heliGrp", "_heliZ", "_inPos", "_heliCorrectLandPos", "_heliDirToLand", "_speedMode", "_heliPad", "_fastRope"];

if !([_this, [["OBJECT"], ["VOID"], ["STRING"], ["SCALAR"], ["BOOL"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_heli = _this select 0;
_inPos = [(_this select 1)] call Zen_ConvertToPosition;

_speedMode = "normal";
_heliZ = 40;
_fastRope = false;

if ((count _this) > 2) then {
    _speedMode = _this select 2;
};

if ((count _this) > 3) then {
    _heliZ = _this select 3;
};

if (count _this > 4) then {
    _fastRope = _this select 4;
};

_heliDriver = driver _heli;
_heliGrp = group _heliDriver;

if !(_fastRope) then {
    _heliPad = [_inPos, "Land_helipadempty_f", 0, 0, true] call Zen_SpawnVehicle;
};

{
    _x enableAI "Move";
    _x allowFleeing 0;
    _x enableAttack false;
} forEach (units _heliGrp);

_heli land "none";
_heliCorrectLandPos = [_heli, _inPos, 50] call Zen_ExtendRay;

_heli animateDoor ["door_L", 0];
_heli animateDoor ["door_R", 0];
_heli animateDoor ["doors", 0];
_heliDriver disableAI "FSM";
_heliDriver disableAI "Target";
_heliDriver disableAI "AutoTarget";

_heliDriver move _heliCorrectLandPos;
_heliGrp setBehaviour "careless";
_heliGrp setCombatMode "green";
_heliGrp setSpeedMode _speedMode;
_heli flyInHeight _heliZ;

waitUntil {
    sleep 2;
    ((unitReady _heliDriver) || !(alive _heli))
};

if (_fastRope) then {
    while {([_heli, _inPos] call Zen_Find2dDistance) > 2} do {
        _heliDirToLand = [_heli, _inPos] call Zen_FindDirection;
        _heli setVelocity [5 * (cos _heliDirToLand), 5 * (sin _heliDirToLand), 0];
    };

    _heli setVelocity [0, 0, -3];
    _heli setVectorUp [0, 0, 1];

    _heli flyInHeight 30;
    waitUntil {
        sleep 2;
        ((speed _heli < 2) && (ZEN_STD_OBJ_PZT(_heli) < 49) || !(alive _heli))
    };

    _heli land "none";
    sleep 4;
} else {
    if !(surfaceIsWater (getPosATL _heli)) then {
        _heli flyInHeight 0;
        _heli land "land";

        waitUntil {
            sleep 1;
            ((isTouchingGround _heli) || !(alive _heli))
        };

        _heli flyInHeight 0;
        _heli animateDoor ["door_L", 1];
        _heli animateDoor ["door_R", 1];
        _heli animateDoor ["doors", 1];
    } else {
        _heli land "none";

        _heli flyInHeight 4;
        _heli animateDoor ["door_L", 1];
        _heli animateDoor ["door_R", 1];
        _heli animateDoor ["doors", 1];
    };

    deleteVehicle _heliPad;
};

call Zen_StackRemove;
if (true) exitWith {};
