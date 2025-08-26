package states;

import backend.GameUtil;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxModding;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class ModConfigState extends BaseState
{
    var mods:Array<String> = [];
    var modsGroup:FlxTypedGroup<FlxText>;
    var selectedMods:Int = 0;
    var camFollow:FlxObject;

    override function create() {
        super.create();

        FlxModding.reload();

		var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33C4C4C4, 0x0));
		grid.velocity.set(40, 40);
		add(grid);

        var button:FlxButton = new FlxButton(10, 10, "Create Mods", function () {
            openSubState(new CreateModsSubState());
        });
        add(button);

		camFollow = new FlxObject(80, 0, 0, 0);
		camFollow.screenCenter(X);
		add(camFollow);

        @:privateAccess
        FlxModding.mods.forEachExists(function (mem) {
            mods.push(mem.file);
        });

        modsGroup = new FlxTypedGroup<FlxText>();
        add(modsGroup);

        for (i in 0...mods.length)
        {
			var modsText:FlxText = new FlxText(20, 60 + (i * 60), 0, mods[i], 20);
            modsText.ID = i;
            modsGroup.add(modsText);
        }

        changeSelection();
		FlxG.camera.follow(camFollow);
    }    

    override function update(elapsed:Float) {
        super.update(elapsed);
        FlxG.camera.followLerp = GameUtil.doLerp(FlxG.camera.followLerp, 0.1, 0.5);

		if (controls.justPressed.UI_UP || controls.justPressed.UI_DOWN)
		{
			changeSelection(controls.justPressed.UI_UP ? -1 : 1);
		}        

        if (controls.justPressed.ACCEPT)
        {

        }

        if (controls.justPressed.BACK) {
            FlxG.switchState(() -> new SelectSongState());
        }
    }

    function changeSelection(change:Int = 0) {
		try
		{
			selectedMods = FlxMath.wrap(selectedMods + change, 0, mods.length - 1);
			for (text in modsGroup)
			{
				text.alpha = text.ID == selectedMods ? 1 : 0.5;
				if (text.ID == selectedMods)
				{
					camFollow.y = text.y;
				}
			}
		}
		catch (e:haxe.Exception)
		{
			trace(e.details());
		}
    }
}