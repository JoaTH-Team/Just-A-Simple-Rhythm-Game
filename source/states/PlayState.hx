package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.addons.sound.FlxRhythmConductor;
import flixel.addons.sound.FlxRhythmConductorUtil;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import objects.gameplay.Note;

class PlayState extends BaseState
{
	public static var song:String = "default";

	public var noteGroup:FlxTypedGroup<Note>;
	public var camHUD:FlxCamera;

	override public function create()
	{
		super.create();

		// Reset the conductor
		FlxRhythmConductor.reset();

		// Some HUD Setup
		camHUD = new FlxCamera();
		camHUD.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(camHUD, false);

		noteGroup = new FlxTypedGroup<Note>();
		add(noteGroup);

		for (i in 0...4)
		{
			var note = new Note((FlxG.width / 2) - (180) + (i * 60), FlxG.height / 2);
			noteGroup.add(note);
		}

		FlxG.sound.playMusic(Paths.getMusic('songs/$song'), 1, false);
		FlxRhythmConductorUtil.loadMetaFromFilePath(FlxRhythmConductor.instance, Paths.getData('songs/$song-meta.json'));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
