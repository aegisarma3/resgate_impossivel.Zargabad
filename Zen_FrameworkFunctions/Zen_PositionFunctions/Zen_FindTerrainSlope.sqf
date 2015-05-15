// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

_Zen_stack_Trace = ["Zen_FindTerrainSlope", _this] call Zen_StackAdd;
private ["_center", "_normalVector", "_h2d", "_phi", "_normalAngle"];

if !([_this, [["VOID"]], [], 1] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    (0)
};

_center = [(_this select 0)] call Zen_ConvertToPosition;

_normalVector = surfaceNormal _center;
_h2d = ([(_normalVector select 0), (_normalVector select 1)] distance [0,0]) max 0.00000001;

_phi = atan((_normalVector select 2) / _h2d);
_normalAngle = 90 - _phi;

call Zen_StackRemove;
(_normalAngle)
