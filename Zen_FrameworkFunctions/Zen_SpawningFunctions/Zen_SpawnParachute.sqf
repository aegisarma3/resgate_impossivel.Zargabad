// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_SpawnParachute", _this] call Zen_StackAdd;
private ["_object", "_parachute", "_height"];

if !([_this, [["OBJECT"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_object = _this select 0;

_parachute = createVehicle ["B_Parachute_02_F", getPosATL _object, [], 0, "CAN_COLLIDE"];
_parachute setPosATL getPosATL _object;

_object enableSimulation false;
_height = ZEN_STD_OBJ_BBZ(_object) / 2;
_height = _height max 1.2;

sleep 2;
_object attachTo [_parachute, [0, 0, -_height]];
_object enableSimulation true;
_parachute setMass (getMass _object + getMass _parachute);

_testCan = [_object, "Land_Can_Dented_F", (ZEN_STD_OBJ_PZT(_object) - 3), 0, true] call Zen_SpawnVehicle;
waitUntil {
    sleep 0.1;
    ((((velocity _testCan) select 2) > -0.05) || (ZEN_STD_OBJ_PZS(_testCan) < 0.25))
};

_stopHeight = ZEN_STD_OBJ_PZT(_testCan);
sleep 2;

waitUntil {
    sleep 0.2;
    ((ZEN_STD_OBJ_PZT(_object) < (_height + _stopHeight)) || (ZEN_STD_OBJ_PZS(_object) < 1))
};

_object allowDamage false;
detach _object;
//0 = [_object, "SmokeShellBlue"] call Zen_SpawnVehicle;
//0 = [_object, "B_IRStrobe"] call Zen_SpawnVehicle;

sleep 1;
_object allowDamage true;

call Zen_StackRemove;
if (true) exitWith {};
