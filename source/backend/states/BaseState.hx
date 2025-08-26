package backend.states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import openfl.system.System;

class BaseState extends FlxState
{
	var controls:Controls;

    override function create() {
        super.create();
		controls = new Controls();
		FlxG.inputs.addInput(controls);
		// Try call `gc` for memory stuff
		System.gc();
    }
}