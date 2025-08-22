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
                save.data.options = new Array<String>();
                save.data.options[0] = "";
            }
        } catch (e:Exception) {
            trace(e.details());
        }
    }

    public static function setData(key:String, value:Dynamic):Void {
        if (save.data == null) {
            initData();
        }
        if (value == false) {
            save.data.options.remove(value);
        } else if (value == true) {
            if (!save.data.options.contains(key)) {
                save.data.options.push(key);
            }
        }
        save.flush();
    }

    public static function initSave() {
        save.data.options.push("Uncapped FPS");
    }
}