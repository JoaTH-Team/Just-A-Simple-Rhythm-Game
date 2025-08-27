package states;

import backend.GameUtil;
import flixel.FlxG;
import flixel.addons.sound.FlxRhythmConductor;
import flixel.addons.sound.FlxRhythmConductorUtil;
import flixel.group.FlxGroup.FlxTypedGroup;
import objects.gameplay.Note;

using flixel.addons.sound.FlxRhythmConductorUtil;

class PlayState extends BaseState
{
	public static var song:String = "default";
	public var note:Note;
	public var notes:FlxTypedGroup<Note>;

	override public function create()
	{
		super.create();

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		persistentUpdate = persistentDraw = true;

		FlxG.camera.zoom = 1;

		notes = new FlxTypedGroup<Note>();
		add(notes);

		note = new Note(0, 0);
		note.screenCenter(Y);
		note.x += 100;
		add(note);

		FlxRhythmConductor.reset();
		FlxG.sound.playMusic(Paths.getMusic('songs/$song/song'), 1, false);
		FlxRhythmConductor.instance.onBeatHit.add((beat:Int, backward:Bool) ->
		{
			FlxG.camera.zoom += 0.015;
		});
		FlxRhythmConductor.instance.loadMetaFromFilePath(Paths.getMusic('songs/$song/song'));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.camera.zoom = GameUtil.doLerp(1, FlxG.camera.zoom, 0.95);

		FlxRhythmConductor.instance.update(null);
	}
}
