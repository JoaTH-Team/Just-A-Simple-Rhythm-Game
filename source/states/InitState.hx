package states;

import flixel.FlxG;
import flixel.util.FlxTimer;
import haxe.ui.Toolkit;

class InitState extends BaseState
{
    override function create() {
        super.create();

        // Init Haxe UI Toolkit
        Toolkit.init();
        new FlxTimer().start(0.25, function(t) {
            FlxG.switchState(() -> new SelectSongState());
        });
    }
}