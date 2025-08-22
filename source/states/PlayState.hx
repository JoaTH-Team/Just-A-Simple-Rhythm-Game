package states;

import flixel.FlxG;
import flixel.addons.sound.FlxRhythmConductor;
import flixel.addons.sound.FlxRhythmConductorUtil;

class PlayState extends BaseState
{
	public static var song:String = "default";

	override public function create()
	{
		super.create();

		// Reset the conductor
		FlxRhythmConductor.reset();

		FlxG.sound.playMusic(Paths.getMusic('songs/$song'), 1, false);
		FlxRhythmConductorUtil.loadMetaFromFilePath(FlxRhythmConductor.instance, Paths.getData('songs/$song-meta.json'));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
