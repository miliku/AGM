// by commy2

private ["_player", "_vehicle", "_target", "_count", "_index", "_action", "_subMenu", "_statement", "_condition", "_conditionShow", "_exceptions", "_distance"];

_player = AGM_player;
_vehicle = vehicle _player;
_target = [AGM_Interaction_Target, _player] select (AGM_Interaction_MenuType % 2 == 1);

_count = count AGM_Interaction_Buttons;
_index = _this; //call AGM_Interaction_fnc_getSelectedButton;

_action = if (_index != -1 && {_index < _count}) then {
	AGM_Interaction_Buttons select _index
} else {
	["", {}, {false}, 0, [], "", "", {false}, [], 0]
};

_subMenu = _action select 4;

// back
if (_index == -1) exitWith {
	call AGM_Interaction_MainButton;
};

if (count _subMenu < 2) then {
	(findDisplay 1713999) closeDisplay 1;
	closeDialog 0;

	_statement = _action select 1;
	_condition = _action select 2;
	_conditionShow = _action select 7;
	_exceptions = _action select 8;//
	_distance = _action select 9;

	if ((_distance == 0 || {[AGM_Interaction_Target, _distance] call AGM_Interaction_fnc_isInRange}) && {[_target, _player] call _condition} && {[_target, _player] call _conditionShow}) then {
		[_target, _player] call _statement;
	};
} else {
	if (_subMenu select 1 < 1) then {
		[_subMenu select 0] call AGM_Interaction_fnc_openSubMenu;
	} else {
		[_subMenu select 0] call AGM_Interaction_fnc_openSubMenuSelf;
	};
};
