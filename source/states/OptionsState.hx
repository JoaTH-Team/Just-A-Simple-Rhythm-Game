package states;

import backend.GameUtil;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;

class OptionsState extends BaseState
{
    var options:Array<String> = ["Controls", "Gameplay"];
    var selectedOption:Int = 0;
    var optionsGroup:FlxTypedGroup<FlxText>;
    var camFollow:FlxObject;

    override function create() {
        super.create();

        camFollow = new FlxObject(80, 0, 0, 0);
        camFollow.screenCenter(X);
        add(camFollow);

        optionsGroup = new FlxTypedGroup<FlxText>();
        add(optionsGroup);

        for (i in 0...options.length)
        {
            var optionText:FlxText = new FlxText(20, 60 + (i * 60), 0, options[i], 20);
            optionText.ID = i;
            optionsGroup.add(optionText);
        }

        FlxG.camera.follow(camFollow);
        changeSelection();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        FlxG.camera.followLerp = GameUtil.doLerp(FlxG.camera.followLerp, 0.1, 0.5);

        if (controls.justPressed.UI_UP || controls.justPressed.UI_DOWN)
        {
            changeSelection(controls.justPressed.UI_UP ? -1 : 1);
        }

        if (controls.justPressed.BACK)
        {
            FlxG.switchState(() -> new SelectSongState());
        }

        if (controls.justPressed.ACCEPT)
        {
            switch (options[selectedOption])
            {
                case "Gameplay":
                    openSubState(new states.options.GameplaySubState());
            }
        }
    }

    function changeSelection(change:Int = 0) {
		selectedOption = FlxMath.wrap(selectedOption + change, 0, options.length - 1);
		for (text in optionsGroup)
		{
			text.alpha = text.ID == selectedOption ? 1 : 0.5;
			if (text.ID == selectedOption)
			{
				camFollow.y = text.y;
			}
		}
    }
}