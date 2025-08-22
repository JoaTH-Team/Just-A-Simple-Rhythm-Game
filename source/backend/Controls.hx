package backend;

import flixel.addons.input.FlxControls;
import flixel.input.keyboard.FlxKey;

enum Action {
	UI_LEFT;
	UI_DOWN;
	UI_RIGHT;
	UI_UP;

	GAME_LEFT;
	GAME_DOWN;
	GAME_RIGHT;
	GAME_UP;

	ACCEPT;
	BACK;
}

class Controls extends FlxControls<Action>
{
	function getDefaultMappings():ActionMap<Action>
	{
		return [
			Action.UI_LEFT => [FlxKey.LEFT],
			Action.UI_DOWN => [FlxKey.DOWN],
			Action.UI_RIGHT => [FlxKey.RIGHT],
			Action.UI_UP => [FlxKey.UP],
			Action.GAME_LEFT => [FlxKey.LEFT],
			Action.GAME_DOWN => [FlxKey.DOWN],
			Action.GAME_RIGHT => [FlxKey.RIGHT],
			Action.GAME_UP => [FlxKey.UP],
			Action.ACCEPT => [FlxKey.ENTER],
			Action.BACK => [FlxKey.ESCAPE]
		];
	}
}