// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_OrderAircraftPatrol", _this] call Zen_StackAdd;
private ["_vehicleArray", "_movecenter", "_blackList", "_maxx", "_speedMode", "_heliHeight", "_mpos", "_heliDirToLand", "_mposCorrected", "_vehDist", "_limitAngles"];

if !([_this, [["ARRAY", "OBJECT"], ["ARRAY", "OBJECT", "GROUP", "STRING"], ["ARRAY", "SCALAR"], ["ARRAY", "SCALAR"], ["STRING"], ["SCALAR"]], [["OBJECT", "ARRAY"], [], ["STRING"], ["SCALAR"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_vehicleArray = [(_this select 0)] call Zen_ConvertToObjectArray;
_movecenter = _this select 1;

if (typeName _vehicleArray != "ARRAY") then {
    _vehicleArray = [_vehicleArray];
};

_blackList = [];
_maxx = 1000;
_speedMode = "normal";
_heliHeight = 75;
_limitAngles = [0, 360];

if !(typeName _movecenter == "String") then {
    if (count _this > 2) then {
        _maxx = _this select 2;
    };
} else {
    if (markerShape _movecenter == "ICON") then {
        _movecenter = [_movecenter] call Zen_ConvertToPosition;
        if (count _this > 2) then {
            _maxx = _this select 2;
        };
    } else {
        if (count _this > 2) then {
            _blackList = _this select 2;
        };
    };
};

if (count _this > 3) then {
    _limitAngles = _this select 3;
};

if (count _this > 4) then {
    _speedMode = _this select 4;
};

if (count _this > 5) then {
    _heliHeight = _this select 5;
};

_vehicleArray = [([_vehicleArray] call Zen_ConvertToObjectArray)] call Zen_ArrayRemoveDead;

{
    private "_veh";
    _veh = _x;

    _mpos = [0,0,0];

    if (typeName _movecenter == "String") then {
        _mpos = [_movecenter, 0,_blackList, 1, 0, _limitAngles] call Zen_FindGroundPosition;
    } else {
        _vehDist = [_veh, _movecenter] call Zen_Find2dDistance;
        _mpos = [_movecenter, [0, _maxx], [], 1, 0, _limitAngles, 0, [1, _veh, _vehDist]] call Zen_FindGroundPosition;
    };

    _heliDirToLand = [_veh,_mpos] call Zen_FindDirection;
    _mposCorrected = [_mpos, 100, _heliDirToLand, "trig"] call Zen_ExtendPosition;

    _veh move _mposCorrected;
    _veh flyInHeight _heliHeight;
    _veh setBehaviour "aware";
    _veh setCombatMode "Red";
    _veh setSpeedMode _speedMode;
} forEach _vehicleArray;

while {(count _vehicleArray != 0)} do {
    {
        private "_veh";
        _veh = _x;
        if (!(alive _veh) || (({alive _x} count crew _veh) == 0)) then {
            _vehicleArray set [_forEachIndex, 0];
        } else {
            if ([_veh] call Zen_IsReady) then {
                _mpos = [0,0,0];
                if (typeName _movecenter == "String") then {
                    _mpos = [_movecenter, 0,_blackList, 1, 0, _limitAngles] call Zen_FindGroundPosition;
                } else {
                    _vehDist = [_veh, _movecenter] call Zen_Find2dDistance;
                    _mpos = [_movecenter, [0, _maxx], [], 1, 0, _limitAngles, 0, [1, _veh, _vehDist]] call Zen_FindGroundPosition;
                };

                _mposCorrected = [_veh, _mpos, 100] call Zen_ExtendRay;
                _veh move _mposCorrected;
                _veh flyInHeight _heliHeight;
                _veh setBehaviour "aware";
                _veh setCombatMode "Red";
                _veh setSpeedMode _speedMode;
            };
        };
    } forEach _vehicleArray;
    sleep 10;
    _vehicleArray = [_vehicleArray] call Zen_ArrayRemoveDead;
    _vehicleArray = _vehicleArray - [0];
};

call Zen_StackRemove;
if (true) exitWith {};
