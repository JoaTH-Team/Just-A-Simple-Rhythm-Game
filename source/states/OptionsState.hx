package states;

import backend.Controls;
import backend.GameUtil;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;

class OptionsState extends BaseState
{
	var mainOptions:Array<String> = ["Controls", "Preferences"];
	var prefOptions:Array<String> = ["Auto-Play", "Anti-Aliasing", "Show HUD", "Overlay BG"];
	var controlsOptions:Array<String> = ["Gameplay", "Menu"];
	var controlsGameplay:Array<String> = ["Game Tap"];
	var controlsMenu:Array<String> = ["UI Up", "UI Down", "UI Left", "UI Right", "Accept", "Back"];

	var currentOptions:Array<String>;
    var selectedOption:Int = 0;
    var optionsGroup:FlxTypedGroup<FlxText>;
    var camFollow:FlxObject;

	var inPreferences:Bool = false;
	var inControls:Bool = false;

    override function create() {
        super.create();

		var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33C4C4C4, 0x0));
		grid.velocity.set(40, 40);
		add(grid);

        camFollow = new FlxObject(80, 0, 0, 0);
        camFollow.screenCenter(X);
        add(camFollow);

        optionsGroup = new FlxTypedGroup<FlxText>();
        add(optionsGroup);

		currentOptions = mainOptions;
		createOptions();

		FlxG.camera.follow(camFollow);
		changeSelection();
	}

	function createOptions()
	{
		optionsGroup.clear();
		for (i in 0...currentOptions.length)
		{
			var optionText:FlxText = new FlxText(20, 60 + (i * 60), 0, currentOptions[i], 20);
            optionText.ID = i;
            optionsGroup.add(optionText);
        }
		if (inPreferences)
			toggleOption();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        FlxG.camera.followLerp = GameUtil.doLerp(FlxG.camera.followLerp, 0.1, 0.5);

        if (controls.justPressed.UI_UP || controls.justPressed.UI_DOWN)
        {
            changeSelection(controls.justPressed.UI_UP ? -1 : 1);
        }

        if (controls.justPressed.BACK)
        {
			if (inPreferences || inControls)
			{
				inPreferences = false;
				currentOptions = mainOptions;
				selectedOption = 1;
				createOptions();
				changeSelection();
			}
			else
			{
				FlxG.switchState(() -> new SelectSongState());
			}
		}

        if (controls.justPressed.ACCEPT)
        {
			if (!inPreferences)
			{
				switch (currentOptions[selectedOption])
				{
					case "Preferences":
						inPreferences = true;
						currentOptions = prefOptions;
						selectedOption = 0;
						createOptions();
						changeSelection();
					case "Controls":
						inControls = true;
						currentOptions = controlsOptions;
						selectedOption = 0;
						createOptions();
						changeSelection();
				}
			}
			else if (inControls)
			{
				switch (currentOptions[selectedOption])
				{
					case "Gameplay":
						currentOptions = controlsGameplay;
						selectedOption = 0;
						createOptions();
						changeSelection();
					case "Menu":
						currentOptions = controlsMenu;
						selectedOption = 0;
						createOptions();
						changeSelection();
				}
			}
			else
			{
				switch (currentOptions[selectedOption])
				{
					case "Auto-Play":
						SaveManager.setData("Auto-Play", !SaveManager.getData("Auto-Play"));
					case "Anti-Aliasing":
						SaveManager.setData("Anti-Aliasing", !SaveManager.getData("Anti-Aliasing"));
					case "Show HUD":
						SaveManager.setData("Show HUD", !SaveManager.getData("Show HUD"));
					case "Overlay BG":
						SaveManager.setData("Overlay BG", !SaveManager.getData("Overlay BG"));
				}
				toggleOption();
            }
        }
    }

    function changeSelection(change:Int = 0) {
		selectedOption = FlxMath.wrap(selectedOption + change, 0, currentOptions.length - 1);

		for (text in optionsGroup)
		{
			text.alpha = text.ID == selectedOption ? 1 : 0.5;
			if (text.ID == selectedOption)
			{
				camFollow.y = text.y;
			}
		}
    }
	function changeKeybind(control:String)
	{
		// FlxG.keys.getIsDown()[0].ID.toString()
	}

	function toggleOption()
	{
		optionsGroup.forEach((text) ->
		{
			switch (text.ID)
			{
				case 0:
					text.text = currentOptions[0] + ": " + (if (SaveManager.getData("Auto-Play")) "On" else "Off");
				case 1:
					text.text = currentOptions[1] + ": " + (if (SaveManager.getData("Anti-Aliasing")) "On" else "Off");
				case 2:
					text.text = currentOptions[2] + ": " + (if (SaveManager.getData("Show HUD")) "On" else "Off");
				case 3:
					text.text = currentOptions[3] + ": " + (if (SaveManager.getData("Overlay BG")) "On" else "Off");
			}
		});
	}
}