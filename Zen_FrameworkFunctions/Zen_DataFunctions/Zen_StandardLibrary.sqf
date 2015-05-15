// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#define ZEN_STD_ARR_RI(A) (floor random count A)
#define ZEN_STD_ARR_RE(A) (A select (floor random count A))
#define ZEN_STD_ARR_UR(A, I) \
    A set [I, A select (count A - 1)]; \
    A resize (count A - 1);

#define ZEN_STD_OBJ_CBP(V, B) \
    V = 0; \
    for "_i" from 0 to 100 do { \
        if ((B buildingPos V) isEqualTo [0,0,0]) exitWith {}; \
        V = V + 1; \
    }; \
    V = V - 1;

#define ZEN_STD_OBJ_CVS(V) (getNumber (configFile >> "CfgVehicles" >> (typeOf V) >> "transportSoldier"))
#define ZEN_STD_OBJ_DVC(V) \
    { \
        deleteVehicle _x; \
    } forEach (crew V + [V]);

#define ZEN_STD_OBJ_PZT(O) ((getPosATL O) select 2)
#define ZEN_STD_OBJ_PZS(O) ((getPosASL O) select 2)
#define ZEN_STD_OBJ_VIA(V) ((getArray (configFile >> "CfgVehicles" >> typeOf V >> "weapons")) > 0)

#define ZEN_STD_PRS_GAD(V, I, D) \
    if (count _this > I) then { \
        V = _this select I; \
    } else { \
        V = D; \
    };

#define ZEN_STD_PRS_GOA(V, I) \
    if (count _this > I) then { \
        V = _this select I; \
    };

#define ZEN_STD_OBJ_BBX(O) abs ((((boundingBoxReal O) select 0) select 0) - (((boundingBoxReal O) select 1) select 0))
#define ZEN_STD_OBJ_BBY(O) abs ((((boundingBoxReal O) select 0) select 1) - (((boundingBoxReal O) select 1) select 1))
#define ZEN_STD_OBJ_BBZ(O) abs ((((boundingBoxReal O) select 0) select 2) - (((boundingBoxReal O) select 1) select 2))
