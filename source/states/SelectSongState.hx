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
import flixel.util.FlxColor;

class SelectSongState extends BaseState
{
	var songList:Array<String> = [];
    var songGroup:FlxTypedGroup<FlxText>;
    var songSelected:Int = 0;
	var camFollow:FlxObject;

    override public function create()
    {
        super.create();

		var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33C4C4C4, 0x0));
		grid.velocity.set(40, 40);
		add(grid);

		camFollow = new FlxObject(80, 0, 0, 0);
		camFollow.screenCenter(X);
		add(camFollow);

        FlxModding.reload();
		songList = GameUtil.getSongName();

        songGroup = new FlxTypedGroup<FlxText>();
        add(songGroup);

        for (i in 0...songList.length)
        {
			var songText:FlxText = new FlxText(20, 60 + (i * 60), 0, songList[i], 20);
            songText.ID = i;
            songGroup.add(songText);
        }
		changeSelection();
		FlxG.camera.follow(camFollow);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
		FlxG.camera.followLerp = GameUtil.doLerp(FlxG.camera.followLerp, 0.1, 0.5);

		if (controls.justPressed.UI_UP || controls.justPressed.UI_DOWN)
		{
			changeSelection(controls.justPressed.UI_UP ? -1 : 1);
		}

		if (controls.justPressed.ACCEPT) {}

		if (FlxG.keys.justPressed.Q)
		{
			FlxG.switchState(() -> new OptionsState());
		}
		if (FlxG.keys.justPressed.M)
		{
			FlxG.switchState(() -> new ModConfigState());
		}
    }    

    function changeSelection(change:Int = 0) {
		try
		{
			songSelected = FlxMath.wrap(songSelected + change, 0, songList.length - 1);
			for (text in songGroup)
			{
				text.alpha = text.ID == songSelected ? 1 : 0.5;
				if (text.ID == songSelected)
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