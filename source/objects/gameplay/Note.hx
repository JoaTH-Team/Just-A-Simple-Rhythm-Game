package objects.gameplay;

import flixel.FlxSprite;

class Note extends FlxSprite
{
    public function new(x:Float, y:Float) {
        super(x, y);

		loadGraphic(Paths.getImages("gameplay/note"), true, 32, 32);
        animation.add("idle", [0]);
        animation.add("pressed", [1, 2]);
        animation.add("hit", [3, 4, 5]);
    }
}