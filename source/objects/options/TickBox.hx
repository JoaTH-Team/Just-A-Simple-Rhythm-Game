package objects.options;

import flixel.FlxSprite;

class TickBox extends FlxSprite
{
    public var sprTracker:FlxSprite;
	public var checked:Bool = false;
    
    public function new() {
        super();

        loadGraphic(Paths.getImages("options/tickbox"), true, 32, 32);
        animation.add("unCheck", [0]);
        animation.add("check", [1]);

        setGraphicSize(64, 64);
        scrollFactor.set();
        updateHitbox();
    }    

    override function update(elapsed:Float) {
        super.update(elapsed);

		if (sprTracker != null)
		{
			setPosition(sprTracker.x + sprTracker.width + 5, sprTracker.y + -15);
			scrollFactor.set(sprTracker.scrollFactor.x, sprTracker.scrollFactor.y);
		}        
    }

    public function toggle() {
        if (animation.name == "unCheck")
        {
            animation.play("check");
			checked = true;
        }
        else
        {
            animation.play("unCheck");
			checked = false;
        }
    }
}