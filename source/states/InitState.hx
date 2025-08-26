package states;

import backend.SaveManager;
import flixel.FlxG;
import flixel.util.FlxTimer;

class InitState extends BaseState
{
    override function create() {
		super.create();
		SaveManager.initData();

        new FlxTimer().start(0.25, function(t) {
            FlxG.switchState(() -> new SelectSongState());
        });
    }
}