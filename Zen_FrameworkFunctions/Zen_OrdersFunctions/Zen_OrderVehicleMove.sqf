// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_OrderVehicleMove", _this] call Zen_StackAdd;
private ["_vehicle", "_inPos", "_speedMode", "_vehicleDriver", "_vehicleGrp", "_height"];

if !([_this, [["OBJECT"], ["VOID"], ["STRING"], ["SCALAR"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_vehicle = _this select 0;
_inPos = [(_this select 1)] call Zen_ConvertToPosition;

_speedMode = "normal";
_height = 50;

if (count _this > 2) then {
    _speedMode = _this select 2;
};

if (count _this > 3) then {
    _height = _this select 3;
};

_vehicleDriver = driver _vehicle;
_vehicleGrp = group (driver _vehicle);

_vehicle land "none";

_vehicleDriver enableAI "Move";
_vehicleDriver allowFleeing 0;

if (_vehicle isKindOf "air") then {
    _inPos = [_vehicle, _inPos, 75] call Zen_ExtendRay;
};

(group _vehicleDriver) move _inPos;

_vehicleGrp setBehaviour "safe";
_vehicleGrp setCombatMode "green";
_vehicleGrp setSpeedMode _speedMode;

if (_vehicle isKindOf "AIR") then {
    _vehicle flyInHeight _height;
    _vehicleGrp setBehaviour "careless";

    _vehicleDriver disableAI "FSM";
    _vehicleDriver disableAI "Target";
    _vehicleDriver disableAI "AutoTarget";
};

sleep 5;

waitUntil {
    sleep 2;
    (([_vehicle] call Zen_IsReady) || ((([_vehicle, _inPos] call Zen_Find2dDistance) < 25) && (speed _vehicle < 1)) || !(alive _vehicle) || !(canMove _vehicle) || ((_vehicle isKindOf "SHIP") && ((getTerrainHeightASL getPosATL _vehicle) > -1)))
};

_vehicleDriver enableAI "Move";
_vehicle move (getPosATL _vehicle);

call Zen_StackRemove;
if (true) exitWith {};
