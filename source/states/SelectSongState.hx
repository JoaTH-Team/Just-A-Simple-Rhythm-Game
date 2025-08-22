package states;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxModding;
import flixel.text.FlxText;

class SelectSongState extends BaseState
{
    var songList:Array<String> = ["so cool", "so cool 2", "so cool 3"];
    var songGroup:FlxTypedGroup<FlxText>;
    var songSelected:Int = 0;

    override public function create()
    {
        super.create();

        FlxModding.reload();

        songGroup = new FlxTypedGroup<FlxText>();
        add(songGroup);

        for (i in 0...songList.length)
        {
            var songText:FlxText = new FlxText(10, 10 + i * 20, 200, songList[i]);
            songText.ID = i;
            songGroup.add(songText);
        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }    

    function changeSelection(change:Int = 0) {
        songSelected = FlxMath.wrap(songSelected + change, 0, songList.length - 1);
    }
}