// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_OrderInsertion", _this] call Zen_StackAdd;
private ["_vehicle", "_posArray", "_units", "_speed", "_heliZ", "_landScript", "_moveFunction", "_cargoSeats", "_fastRope"];

if !([_this, [["OBJECT"], ["VOID"], ["VOID"], ["STRING"], ["SCALAR"], ["BOOL"]], [], 3] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_vehicle = _this select 0;
_posArray = _this select 1;
_units = [(_this select 2)] call Zen_ConvertToObjectArray;

_speed = "normal";
_heliZ = 40;
_fastRope = false;

if (count _this > 3) then {
    _speed = _this select 3;
};

if (count _this > 4) then {
    _heliZ = _this select 4;
};

if (count _this > 5) then {
    _fastRope = _this select 5;
};

if (typeName _posArray == "ARRAY") then {
    if ((typeName (_posArray select 0)) == "SCAlAR") then {
        _posArray = [_posArray];
    };
} else {
    _posArray = [_posArray];
};

{
    _posArray set [_forEachIndex, ([_x] call Zen_ConvertToPosition)];
} forEach _posArray;

if (_vehicle isKindOf "AIR") then {
    _moveFunction = "Zen_OrderHelicopterLand";
} else {
    _moveFunction = "Zen_OrderVehicleMove";
};

_cargoSeats = ZEN_STD_OBJ_CVS(_vehicle);

{
    _landScript = [_vehicle, _x, _speed, _heliZ, _fastRope] spawn (missionNamespace getVariable _moveFunction);

    waitUntil {
        sleep 2;
        scriptDone _landScript;
    };

    if (_forEachIndex == ((count _posArray) - 1) && ((count _posArray) > 1)) exitWith {};
    _vehicle engineOn true;
    (driver _vehicle) disableAI "move";

    if (_fastRope) then {
        0 = [_vehicle, _units] spawn Zen_OrderFastRope;
    } else {
        _units orderGetIn false;
        {
            unassignVehicle _x;
            _x leaveVehicle _vehicle;
            _x enableAI "move";
            _x disableCollisionWith _vehicle;
        } forEach _units;
    };

    _stop = [] spawn {};
    if (_vehicle isKindOf "Air") then {
        _stop = _vehicle spawn {
            _dir = [vectorDir _this, vectorUp _this];
            waitUntil {
                if (ZEN_STD_OBJ_PZT(_this) < 0.5) then {
                    _this setVectorDirAndUp _dir;
                    _this setVelocity [0,0,-0.2];
                };
                (false)
            };
        };
    };

    _fastRope = false;
    waitUntil {
        sleep 2;
        ((([_units, _vehicle]) call Zen_AreNotInVehicle) || ((_vehicle emptyPositions "cargo") == _cargoSeats) || !(alive _vehicle))
    };

    sleep 4;
    terminate _stop;
} forEach _posArray;

{
    _x enableAI "move";
} forEach (crew _vehicle);

call Zen_StackRemove;
if (true) exitWith {};
