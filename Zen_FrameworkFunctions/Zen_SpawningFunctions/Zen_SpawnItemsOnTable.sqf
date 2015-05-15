// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_SpawnItemsOnTable", _this] call Zen_StackAdd;
private ["_tableArray", "_table", "_item", "_itemClassname", "_itemArray", "_itemClassArray"];

if !([_this, [["ARRAY"], ["ARRAY"]], [["STRING"], ["OBJECT"]], 2] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
    ([])
};

_itemClassArray = _this select 0;
_tableArray = _this select 1;
_itemArray = [];

{
    _itemClassname = _x;
    _table = _tableArray select _forEachIndex;
    _tableMaxHeight = ZEN_STD_OBJ_BBZ(_table);

    _item = createVehicle [_itemClassname, (getPosATL _table), [], 0, "NONE"];
    0 = [_item, _table, _tableMaxHeight, (random 360), true] call Zen_TransformObject;
    _item enableSimulation false;

    _itemArray pushBack _item;
} forEach _itemClassArray;

call Zen_StackRemove;
(_itemArray)
