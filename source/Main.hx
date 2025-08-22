package;

import flixel.FlxGame;
import flixel.system.FlxModding;
import haxe.ui.HaxeUIApp;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		FlxModding.init();

		// added FlxGame
		addChild(new FlxGame(0, 0, states.InitState, 999, 999, false, false));

		// added FPS
		addChild(new FPS(10, 10, 0xFFFFFF));
	}
}
