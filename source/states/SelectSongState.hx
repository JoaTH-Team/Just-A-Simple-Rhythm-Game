package states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxModding;
import flixel.text.FlxText;

class SelectSongState extends BaseState
{
    var songList:Array<String> = ["so cool", "so cool 2", "so cool 3"];
    var songGroup:FlxTypedGroup<FlxText>;
    var songSelected:Int = 0;
	var camFollow:FlxObject;

    override public function create()
    {
        super.create();

		camFollow = new FlxObject(0, 0, 100, 100);
		camFollow.scrollFactor.set(0, 0);
		add(camFollow);

        FlxModding.reload();

        songGroup = new FlxTypedGroup<FlxText>();
        add(songGroup);

        for (i in 0...songList.length)
        {
			var songText:FlxText = new FlxText(10, 10 + i * 20, 0, songList[i], 24);
            songText.ID = i;
            songGroup.add(songText);
        }
		FlxG.camera.follow(camFollow);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }    

    function changeSelection(change:Int = 0) {
        songSelected = FlxMath.wrap(songSelected + change, 0, songList.length - 1);
		for (text in songGroup)
		{
			camFollow.y = camFollow.y + 20 * (text.ID - songSelected);
		}
    }
}