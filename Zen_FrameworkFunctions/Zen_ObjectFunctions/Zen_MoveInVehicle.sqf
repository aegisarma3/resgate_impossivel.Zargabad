// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_MoveInVehicle", _this] call Zen_StackAdd;
private ["_unitsArray", "_vehicle", "_turrets", "_vehicleSlot"];

if !([_this, [["VOID"], ["OBJECT"], ["STRING"]], [], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_unitsArray = [(_this select 0)] call Zen_ConvertToObjectArray;
_vehicle = _this select 1;

_vehicleSlot = "cargo";

if (count _this > 2) then {
    _vehicleSlot = _this select 2;
};

if !(alive _vehicle) exitWith {
    0 = ["Zen_MoveInVehicle", "Given vehicle is destroyed or does not exist", _this] call Zen_PrintError;
    call Zen_StackPrint;
    call Zen_StackRemove;
};

switch (toLower _vehicleSlot) do {
    case "cargo": {
        if ((count _unitsArray) > ZEN_STD_OBJ_CVS(_vehicle)) then {
            0 = ["Zen_MoveInVehicle", "Given vehicle does not have enough passenger positions to hold all of the given units", _this] call Zen_PrintError;
            call Zen_StackPrint;
        };

        0 = [_unitsArray, _vehicle] call Zen_MoveInVehicle_Cargo_MP;
        Zen_MP_Closure_Packet = ["Zen_MoveInVehicle_Cargo_MP", [_unitsArray, _vehicle]];
        publicVariable "Zen_MP_Closure_Packet";
    };
    case "driver": {
        if (count _unitsArray > 1) then {
            0 = ["Zen_MoveInVehicle", "Two or more units cannot be in the driver seat", _this] call Zen_PrintError;
            call Zen_StackPrint;
        };

        0 = [(_unitsArray select 0), _vehicle] call Zen_MoveInVehicle_Driver_MP;
        Zen_MP_Closure_Packet = ["Zen_MoveInVehicle_Driver_MP", [(_unitsArray select 0), _vehicle]];
        (owner (_unitsArray select 0)) publicVariableClient "Zen_MP_Closure_Packet";
    };
    case "turret": {
        _turrets = [_vehicle] call Zen_GetTurretPaths;

        0 = [_unitsArray, _vehicle, _turrets] call Zen_MoveInVehicle_Turret_MP;
        Zen_MP_Closure_Packet = ["Zen_MoveInVehicle_Turret_MP", [_unitsArray, _vehicle, _turrets]];
        publicVariable "Zen_MP_Closure_Packet";
    };
    case "all": {
        if (count _unitsArray > 0) then {
            0 = [(_unitsArray select 0), _vehicle] call Zen_MoveInVehicle_Driver_MP;
            Zen_MP_Closure_Packet = ["Zen_MoveInVehicle_Driver_MP", [(_unitsArray select 0), _vehicle]];
            (owner (_unitsArray select 0)) publicVariableClient "Zen_MP_Closure_Packet";

            _unitsArray = [_unitsArray, "(vehicle _x != _x)"] call Zen_ArrayFilterCondition;
            if (count _unitsArray > 0) then {
                _turrets = [_vehicle] call Zen_GetTurretPaths;

                0 = [_unitsArray, _vehicle, _turrets] call Zen_MoveInVehicle_Turret_MP;
                Zen_MP_Closure_Packet = ["Zen_MoveInVehicle_Turret_MP", [_unitsArray, _vehicle, _turrets]];
                publicVariable "Zen_MP_Closure_Packet";

                _unitsArray = [_unitsArray, "(vehicle _x != _x)"] call Zen_ArrayFilterCondition;
                if (count _unitsArray > 0) then {
                    0 = [_unitsArray, _vehicle] call Zen_MoveInVehicle_Cargo_MP;
                    Zen_MP_Closure_Packet = ["Zen_MoveInVehicle_Cargo_MP", [_unitsArray, _vehicle]];
                    publicVariable "Zen_MP_Closure_Packet";
                };
            };
        };
    };
};

call Zen_StackRemove;
if (true) exitWith {};
