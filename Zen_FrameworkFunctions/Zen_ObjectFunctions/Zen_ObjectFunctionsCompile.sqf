// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

Zen_AreInArea = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_AreInArea.sqf";
Zen_AreIndoors = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_AreIndoors.sqf";
Zen_AreInVehicle = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_AreInVehicle.sqf";
Zen_AreLocal = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_AreLocal.sqf";
Zen_AreNotInArea = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_AreNotInArea.sqf";
Zen_AreNotIndoors = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_AreNotIndoors.sqf";
Zen_AreNotInVehicle = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_AreNotInVehicle.sqf";
Zen_AreNotLocal = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_AreNotLocal.sqf";
Zen_GetAllInArea = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_GetAllInArea.sqf";
Zen_GetAllInBuilding = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_GetAllInBuilding.sqf";
Zen_GetSide = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_GetSide.sqf";
Zen_GetSideColor = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_GetSideColor.sqf";
Zen_GetTurretPaths = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_GetTurretPaths.sqf";
Zen_IsFacing = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_IsFacing.sqf";
Zen_IsReady = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_IsReady.sqf";
Zen_IsSeen = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_IsSeen.sqf";
Zen_IsVisible = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_IsVisible.sqf";
Zen_MoveAsSet = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_MoveAsSet.sqf";
Zen_MoveInVehicle = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_MoveInVehicle.sqf";
Zen_RotateAsSet = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_RotateAsSet.sqf";
Zen_SetAISkill = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_SetAISkill.sqf";
Zen_TrackGroups = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_TrackGroups.sqf";
Zen_TrackInfantry = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_TrackInfantry.sqf";
Zen_TrackVehicles = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_TrackVehicles.sqf";
Zen_TransformObject = compileFinal preprocessFileLineNumbers "Zen_FrameworkFunctions\Zen_ObjectFunctions\Zen_TransformObject.sqf";

Zen_MoveInVehicle_Cargo_MP = {
    private ["_vehicle", "_unitsArray"];

    _unitsArray = _this select 0;
    _vehicle = _this select 1;

    {
        _x assignAsCargo _vehicle;
        _x moveInCargo _vehicle;
    } forEach _unitsArray;

    if (true) exitWith {};
};

Zen_MoveInVehicle_Driver_MP = {
    private ["_vehicle", "_unit"];

    _unit = _this select 0;
    _vehicle = _this select 1;

    _unit assignAsDriver _vehicle;
    _unit moveInDriver _vehicle;

    if (true) exitWith {};
};

Zen_MoveInVehicle_Turret_MP = {
    private ["_vehicle", "_unitsArray", "_turrets", "_unit"];

    _unitsArray = _this select 0;
    _vehicle = _this select 1;
    _turrets = _this select 2;

    {
        _unit = _x;
        {
            _unit assignAsTurret [_vehicle, _x];
            _unit moveInTurret [_vehicle, _x];
            if (vehicle _unit != _unit) exitWith {};
        } forEach _turrets;
    } forEach _unitsArray;

    if (true) exitWith {};
};

Zen_TransformObject_Orient_MP = {
    private ["_vehicle", "_dir", "_setNormal"];

    _vehicle = _this select 0;
    _dir = _this select 1;
    _setNormal = _this select 2;

    sleep 0.1;
    if (_setNormal) then {
        _vehicle setVectorUp (surfaceNormal (getPosATL _vehicle));
    };

    _vehicle setDir _dir;
};

if (true) exitWith {};
