// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

private ["_centerXY", "_XYSizeArray", "_markerDir", "_minAngle", "_maxAngle", "_rho", "_phi", "_radius", "_majorDir", "_minorDir", "_distMajor", "_distMinor"];

_centerXY = _this select 0;
_XYSizeArray = _this select 1;
_markerDir = _this select 2;
_minAngle = _this select 3;
_maxAngle = _this select 4;

if ((_XYSizeArray select 1) > (_XYSizeArray select 0)) then {
    _majorDir = -_markerDir;
} else {
    _majorDir = 90 - _markerDir;
};

(if ((abs (_minAngle - _maxAngle)) < 330) then {
    _rho = sqrt random 1;
    _phi = _minAngle + random (_maxAngle - _minAngle);

    if ((((_XYSizeArray select 0) / (_XYSizeArray select 1) >= 1.3) || ((_XYSizeArray select 1) / (_XYSizeArray select 0) >= 1.3)) && {(((abs ((_majorDir - _phi) % 360)) < 45) || ((abs ((_majorDir + _phi) % 360)) < 45))}) then {
        _phi = _minAngle + random (_maxAngle - _minAngle);
        if ((((_XYSizeArray select 0) / (_XYSizeArray select 1) >= 3.3) || ((_XYSizeArray select 1) / (_XYSizeArray select 0) >= 3.3)) && {(((abs ((_majorDir - _phi) % 360)) < 45) || ((abs ((_majorDir + _phi) % 360)) < 45))}) then {
            _phi = _minAngle + random (_maxAngle - _minAngle);
        };
    };

    _radius = ((_XYSizeArray select 0)*(_XYSizeArray select 1)) / sqrt ((_XYSizeArray select 1)^2 * (cos (_phi + _markerDir))^2 + (_XYSizeArray select 0)^2 * (sin (_phi + _markerDir))^2);
    ([(_centerXY select 0) + _rho * _radius * cos _phi, (_centerXY select 1) + _rho * _radius * sin _phi, 0])
} else {
    _majorDir = -_markerDir;
    _minorDir = 90 - _markerDir;

    _distMajor = (random 1) * (_XYSizeArray select 0);
    _distMinor = (random 1) * ((_XYSizeArray select 1) * sqrt (1 - (_distMajor / (_XYSizeArray select 0))^2));

    if (random 1 > 0.5) then {
        _distMajor = _distMajor * -1;
    };

    if (random 1 > 0.5) then {
        _distMinor = _distMinor * -1;
    };

    ([(_centerXY select 0) + _distMajor * cos _majorDir + _distMinor * cos _minorDir, (_centerXY select 1) + _distMajor * sin _majorDir + _distMinor * sin _minorDir, 0])
})
