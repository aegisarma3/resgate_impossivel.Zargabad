// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_OrderFastRope", _this] call Zen_StackAdd;
private ["_heli", "_offsetL", "_rope", "_heliPosition", "_heliGround", "_ropeThread", "_buildings", "_height", "_testCan"];

if !([_this, [["OBJECT"], ["VOID"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_heli = _this select 0;
_units = [(_this select 1)] call Zen_ConvertToObjectArray;

if (count _this > 2) then {
    if ((isPlayer (_units select 0)) && {((_units select 0) == leader group (_units select 0))}) then {
        {
            if (!(_x in _units) && !(isPlayer _x) && (_x in _heli) && (_x in assignedCargo _heli)) then {
                _units pushBack _x;
            };
        } forEach (units group (_units select 0));
    };
};

switch (typeOf _heli) do {
    case "O_Heli_Light_02_unarmed_F": {
        _offsetL = [-1.4, 1.4, -25];
    };
    case "O_Heli_Light_02_F": {
        _offsetL = [-1.4, 1.4, -25];
    };
    case "B_Heli_Transport_01_F": {
        _offsetL = [-0.9, 3, -24.5];
    };
    case "B_Heli_Transport_01_camo_F": {
        _offsetL = [-0.9, 3, -24.5];
    };
    case "O_Heli_Attack_02_F": {
        _offsetL = [-1.2, 1.5, -24.5];
    };
    case "O_Heli_Attack_02_black_F": {
        _offsetL = [-1.2, 1.5, -24.5];
    };
    case "I_Heli_Transport_02_F": {
        _offsetL = [-0.1, -5.1, -26];
    };
    case "B_Heli_Light_01_F": {
        _offsetL = [-1.2, 0.5,-25.45];
    };
    case "I_Heli_light_03_F": {
        _offsetL = [-1.35, 3.5, -25.5];
    };
    case "I_Heli_light_03_unarmed_F": {
        _offsetL = [-1.35, 3.5, -25.5];
    };
    default {
        _offsetL = [-1, 1.5, -25];
    };
};

_heli animateDoor ["door_L", 1];
_heli animateDoor ["doors", 1];
_heliPosition = getPosATL _heli;

_testCan = [_heliPosition, "Land_Can_Dented_F", ((_heliPosition select 2) - 3)] call Zen_SpawnVehicle;
waitUntil {
    sleep 0.1;
    ((((velocity _testCan) select 2) > -0.05) || (ZEN_STD_OBJ_PZS(_testCan) < 0.25))
};

_height = ZEN_STD_OBJ_PZT(_testCan);

sleep 2;

_rope = createVehicle ["land_rope_f", [0,0,0], [], 0, "CAN_COLLIDE"];
_rope enableSimulation false;
_rope disableCollisionWith _heli;
_rope setDir (getDir _heli);
_rope attachTo [_heli, _offsetL];

_heliGround =+ _heliPosition;
_heliGround set [2, 0];
_heliPosition set [2, (_heliPosition select 2) - 3];
_buildings = lineIntersectsWith [_heliPosition, _heliGround, _heli, _heli];

{
    _rope disableCollisionWith _x;
} forEach (_buildings + _units);

{
    _ropeThread = [_heli, _x, _rope, _height] spawn Zen_FastRope;
    Zen_MP_Closure_Packet = ["Zen_FastRope", [_heli, _x, _rope, _height]];
    (owner _x) publicVariableClient "Zen_MP_Closure_Packet";

    waitUntil {
        sleep 0.25;
        _heli land "none";
        if !(isPlayer (driver _heli)) then {
            _heli setVelocity [0,0,0];
            _heli setVectorUp [0,0,1];
        };
        ((scriptDone _ropeThread) || !(alive _x)) || !(alive _heli)
    };
} forEach _units;

_heli setVelocity [0,0,2];
deleteVehicle _rope;
_heli animateDoor ["door_L", 0];
_heli animateDoor ["doors", 0];

call Zen_StackRemove;
if (true) exitWith {};
