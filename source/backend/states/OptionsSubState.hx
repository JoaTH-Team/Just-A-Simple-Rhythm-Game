package backend.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import objects.options.TickBox;

class OptionsSubState extends BaseSubState
{
    var options:Array<String> = [];
    var optionsGroup:FlxTypedGroup<FlxText>;
    var selectedOption:Int = 0;
    var camFollow:FlxObject;

    var tickBoxs:Array<TickBox> = [];
    
    override function create() {
        super.create();

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xff000000);
        // bg.alpha = 0.5;
        bg.scrollFactor.set(0, 0);
        add(bg);

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

            var icon:TickBox = new TickBox();
			icon.sprTracker = optionText;
			tickBoxs.push(icon);
			add(icon);
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
            close();
        }

        if (controls.justPressed.ACCEPT)
        {
            if (selectedOption < tickBoxs.length)
            {
                tickBoxs[selectedOption].toggle();
            }
        }
    }

    function changeSelection(change:Int = 0) {
		selectedOption = FlxMath.wrap(selectedOption + change, 0, options.length - 1);
        for (i in 0...tickBoxs.length)
		{
			tickBoxs[i].alpha = 0.6;
		}
        tickBoxs[selectedOption].alpha = 1;

		for (text in optionsGroup)
		{
			text.alpha = text.ID == selectedOption ? 1 : 0.5;
			if (text.ID == selectedOption)
			{
				camFollow.y = text.y;
			}
		}
    }

    // == OPTIONS ONLY NEED PART ==

    /**
     * Add a bool check options
     */
    function addTick(name:String, data:Dynamic):Void {
        options.push(name);
        optionsData.push(data);
    }
}