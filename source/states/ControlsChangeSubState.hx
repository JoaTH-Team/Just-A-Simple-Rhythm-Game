package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;

class ControlsChangeSubState extends BaseSubState
{
    override function create() {
        super.create();

        var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.screenCenter();
        bg.alpha = 0.6;
        add(bg);
    }   
    
    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.P) // test change, change GAME_TAP to other key
        {
            controls.remove(GAME_TAP, FlxKey.ANY);
            SaveManager.save.data.options.set("game-tap", FlxKey.P);
            controls.add(GAME_TAP, SaveManager.save.data.options.get("game-tap"));
            trace(SaveManager.save.data.options.get("game-tap"));
            trace(controls.listInputsFor(GAME_TAP));
        }
    
        if (FlxG.keys.justPressed.ESCAPE)
            close();
    }
}