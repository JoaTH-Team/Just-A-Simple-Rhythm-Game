package backend;

import flixel.util.FlxSave;
import haxe.Exception;

class SaveManager
{
    public static var save:FlxSave;

    public static function initData() {
        save = new FlxSave();
        save.bind("game_data");

        try {
            if (save.data.options == null) {
				save.data.options = new Map<String, Dynamic>();
            }
			initSave();
        } catch (e:Exception) {
            trace(e.details());
        }
    }

	public static function setData(key:String, value:Dynamic):Void
	{
        if (save.data == null) {
            initData();
		}

		save.data.options.set(key, value);
		save.flush();
	}
	public static function getData(key:String):Dynamic
	{
		if (save.data == null)
		{
			initData();
		}

		return save.data.options.get(key);
    }

    public static function initSave() {
		save.data.options.set("Auto-Play", false);
		save.data.options.set("Anti-Aliasing", true);
		save.data.options.set("Show HUD", true);
		save.data.options.set("Overlay BG", true);
    }
}