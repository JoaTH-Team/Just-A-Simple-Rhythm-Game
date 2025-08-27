package backend;

import flixel.FlxG;
import flixel.math.FlxMath;
import lime.utils.Assets;

using StringTools;

class GameUtil {
    /**
     * Use This function instead of `FlxMath.lerp()` to ensure the smooth lerp when the game have too high FPS
     */
    public static function doLerp(a:Float, b:Float, ratio:Float):Float {
        return FlxMath.lerp(a, b, (ratio * (FlxG.elapsed / (1 / 60))));
	}

	/**
	 * Get a file array string
	 */
	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}
		return daList;
	}
}