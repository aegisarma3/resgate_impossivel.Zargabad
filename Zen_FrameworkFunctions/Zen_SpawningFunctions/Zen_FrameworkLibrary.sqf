// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#define ZEN_FMW_MP_REA(F, A) \
    Zen_MP_Closure_Packet = [F, A]; \
    publicVariable "Zen_MP_Closure_Packet"; \
    A call missionNamespace getVariable F;

#define ZEN_FMW_MP_REC(F, A, O) \
    if (local O) then { \
        A call missionNamespace getVariable F; \
    } else { \
        Zen_MP_Closure_Packet = [F, A]; \
        (owner O) publicVariableClient "Zen_MP_Closure_Packet"; \
    };

#define ZEN_FMW_MP_RED(F, A) \
    Zen_MP_Closure_Packet = [F, A]; \
    publicVariable "Zen_MP_Closure_Packet"; \
    if !(isDedicated) then { \
        A call missionNamespace getVariable F; \
    };

#define ZEN_FMW_MP_RES(F, A) \
    if (isServer) then { \
        A call missionNamespace getVariable F; \
    } else { \
        Zen_MP_Closure_Packet = [F, A]; \
        publicVariableServer "Zen_MP_Closure_Packet"; \
    };

#define ZEN_FMW_MTH_DL2(A, B, D) (([A, B] call Zen_Find2dDistance) < D)
#define ZEN_FMW_MTH_DG3(A, B, D) ((([A] call Zen_ConvertToPosition) distance ([B] call Zen_ConvertToPosition)) > D)
#define ZEN_FMW_MTH_DG2(A, B, D) (([A, B] call Zen_Find2dDistance) > D)
#define ZEN_FMW_MTH_DL3(A, B, D) ((([A] call Zen_ConvertToPosition) distance ([B] call Zen_ConvertToPosition)) < D)
#define ZEN_FMW_MTH_RPC(C, R) ([C, random R, random 360] call Zen_ExtendPosition)

#define ZEN_FMW_MSC_EEV(F, D) \
    0 = [F, D, _this] call Zen_PrintError; \
    call Zen_StackPrint; \
    call Zen_StackRemove;

#define ZEN_FMW_MSC_EEA(F, D, V) \
    0 = [F, D, _this] call Zen_PrintError; \
    call Zen_StackPrint; \
    call Zen_StackRemove; \
    V

#define ZEN_FMW_MSC_ES(F, D) \
    0 = [F, D, _this] call Zen_PrintError; \
    call Zen_StackPrint; 

#define ZEN_FMW_ZAS_AL {if (count (_this select 0) < count (_this select 1)) exitWith {-1}; (if (count (_this select 0) == count (_this select 1)) then {0} else {1})}
#define ZEN_FMW_ZAS_ANS {_2a = toArray (_this select 1); _c = 0; {if (_x < (_2a select _forEachIndex)) exitWith {_c = -1}; if (_x > (_2a select _forEachIndex)) exitWith {_c = 1};} forEach (toArray (_this select 0)); (_c)}
#define ZEN_FMW_ZAS_DFN(C) (compile format ["if ((_this select 0) distance %1 > (_this select 1) distance %1) exitWith {-1}; (if ((_this select 0) distance %1 == (_this select 1) distance %1) then {0} else {1})", C])
#define ZEN_FMW_ZAS_DNF(C) (compile format ["if ((_this select 0) distance %1 < (_this select 1) distance %1) exitWith {-1}; (if ((_this select 0) distance %1 == (_this select 1) distance %1) then {0} else {1})", C])
#define ZEN_FMW_ZAS_IIA(I) (compile format["if (((_this select 0) select %1) < ((_this select 1) select %1)) exitWith {-1}; (if (((_this select 0) select %1) == ((_this select 1) select %1)) then {0} else {1})", I])
#define ZEN_FMW_ZAS_SL {if (count toArray (_this select 0) < count toArray (_this select 1)) exitWith {-1}; (if (count toArray (_this select 0) == count toArray (_this select 1)) then {0} else {1})}
