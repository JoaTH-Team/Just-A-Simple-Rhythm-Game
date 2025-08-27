package backend;

import flixel.FlxG;
import flixel.addons.input.FlxControlInputType;
import flixel.addons.input.FlxControls;
import flixel.input.keyboard.FlxKey;

enum Action {
	// UI Actions
	UI_LEFT;
	UI_DOWN;
	UI_RIGHT;
	UI_UP;

	// Game Actions
	GAME_TAP;

	// Global Actions
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
			Action.GAME_TAP => [FlxKey.SPACE],
			Action.ACCEPT => [FlxKey.ENTER],
			Action.BACK => [FlxKey.ESCAPE]
		];
	}
}