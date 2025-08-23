package;

import flixel.FlxGame;
import flixel.system.FlxModding;
import objects.counter.Counter;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		FlxModding.init();

		// added FlxGame
		addChild(new FlxGame(0, 0, states.InitState, 144, 144, false, false));

		// added FPS
		addChild(new Counter(10, 10, 0xFFFFFF));
	}
}
