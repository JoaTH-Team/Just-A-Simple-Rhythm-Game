package states;

import backend.GameUtil;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxModding;
import flixel.system.FlxModpack.FlxMetadataFormat;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

class CreateModsSubState extends BaseSubState
{
    var arrayList:Array<String> = ["Name", "Description", "Version", "Create Now!"];
    var arrayGroup:FlxTypedGroup<FlxText>;
    var arraySelected:Int = 0;
    var camFollow:FlxObject;

    var storedData:Map<String, Dynamic> = new Map<String, Dynamic>();

    override function create() {
        super.create();

        // pre-stored data
        storedData.set("title", "Coolest Mods");
        storedData.set("name", "coolestMods");
        storedData.set("desc", "is da coolest mods ever!!!!");
        storedData.set("version", "0.0.1");

		camFollow = new FlxObject(80, 0, 0, 0);
		camFollow.screenCenter(X);
		add(camFollow);

        var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.screenCenter();
        bg.alpha = 0.6;
        add(bg);

        arrayGroup = new FlxTypedGroup<FlxText>();
        add(arrayGroup);

        for (i in 0...arrayList.length)
        {
			var arrayText:FlxText = new FlxText(20, 60 + (i * 60), 0, arrayList[i], 20);
            arrayText.ID = i;
            arrayGroup.add(arrayText);
        }
		changeSelection();
		FlxG.camera.follow(camFollow);
    }    

    override function update(elapsed:Float) {
        super.update(elapsed);
        FlxG.camera.followLerp = GameUtil.doLerp(FlxG.camera.followLerp, 0.1, 0.5);

        if (controls.justPressed.BACK)
        {
            close();
            FlxG.switchState(() -> new ModConfigState());
        }

		if (controls.justPressed.UI_UP || controls.justPressed.UI_DOWN)
		{
			changeSelection(controls.justPressed.UI_UP ? -1 : 1);
		}

        if (controls.justPressed.ACCEPT)
        {
            switch (arrayList[arraySelected])
            {
                case "Create Now!":
                    FlxModding.create(storedData.get("title"), new BitmapData(128, 128), new FlxMetadataFormat().fromDynamicData({
                        name: storedData.get("name"),
                        version: storedData.get("version"),
                        description: storedData.get("desc"),

                        credits: [
                            {}
                        ],

                        priority: 1,
                        active: true,                        
                    }));
                    trace("Finished Creating Mods!");
            }
        }
    }

    function changeSelection(change:Int = 0) {
		arraySelected = FlxMath.wrap(arraySelected + change, 0, arrayList.length - 1);
		for (text in arrayGroup)
		{
			text.alpha = text.ID == arraySelected ? 1 : 0.5;
			if (text.ID == arraySelected)
			{
				camFollow.y = text.y;
			}
		}
    }
}