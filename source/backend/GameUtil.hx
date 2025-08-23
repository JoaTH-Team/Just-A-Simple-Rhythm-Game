package backend;

import flixel.FlxG;
import flixel.math.FlxMath;

class GameUtil {
    /**
     * Use This function instead of `FlxMath.lerp()` to ensure the smooth lerp when the game have too high FPS
     */
    public static function doLerp(a:Float, b:Float, ratio:Float):Float {
        return FlxMath.lerp(a, b, (ratio * (FlxG.elapsed / (1 / 60))));
    }

    /**
     * Help get all song name by folder exists
     */
    public static function getSongName():Array<String> {
        var songs:Array<String> = [];
        #if sys
		if (sys.FileSystem.exists(Paths.getPath("data/songs")))
		{
			for (folder in sys.FileSystem.readDirectory(Paths.getPath("data/songs")))
			{
				if (sys.FileSystem.isDirectory(Paths.getPath("data/songs/") + folder))
				{
                    songs.push(folder);
                }
            }
        }
        #end
        return songs;
    }
}