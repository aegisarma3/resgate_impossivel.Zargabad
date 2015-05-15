// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_GetTurretPaths", _this] call Zen_StackAdd;
private ["_vehicle", "_turretClass", "_turretPaths", "_turretEntry", "_j", "_i", "_subTurretEntry"];

if !([_this, [["OBJECT", "STRING"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_vehicle = _this select 0;

if (typeName _vehicle == "OBJECT") then {
    _vehicle = typeOf _vehicle;
};

_turretClass = configFile >> "CfgVehicles" >> _vehicle >> "Turrets";
_turretPaths = [];

if (isClass _turretClass) then {
    for "_i" from 0 to ((count _turretClass) - 1) do {
        _turretEntry = _turretClass select _i;
        
        if (isClass _turretEntry) then {
            _turretPaths = _turretPaths + [[_i]];
            
            _subTurretEntry = _turretEntry >> "Turrets";
            if (isClass _subTurretEntry) then {
                for "_j" from 0 to ((count _subTurretEntry) - 1) do {
                    _turretPaths = _turretPaths + [[_i, _j]];
                };
            };
        };
    };
};

call Zen_StackRemove;
(_turretPaths)
