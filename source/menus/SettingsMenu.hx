package menus;

import blockUI.LayerData;
import blockUI.Panel;
import flixel.tweens.FlxEase;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;

using StringTools;

class SettingsMenu extends Menu
{
	var bg:FlxSprite;

	public static var fromPlayState:Bool = false;

	var options:Array<String> = [' Gameplay ', ' Graphics ', ' Controls ', ' Offsets '];
	var grpOptions:Array<FlxText>;

	static var curSelection(default, set):Int = 0;

	// var header:Panel;

	@:noCompletion
	static function set_curSelection(value:Int):Int
	{
		if (value != curSelection)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.3);
			if (value > 3)
				value = 0;
			if (value < 0)
				value = 3;
		}

		return curSelection = value;
	}

	function openSelectedSubstate(label:String)
	{
		switch (label)
		{
			case ' Controls ':
				Menu.switchTo(ControlSettings);
			case ' Graphics ':
				Menu.switchTo(GraphicSettings);
			case ' Gameplay ':
				Menu.switchTo(GameplaySettings);
			case ' Offsets ':
				Menu.switchTo(OffsetSettings);
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create()
	{
		#if desktop
		DiscordClient.changePresence("Options", null);
		#end

		grpOptions = new Array<FlxText>();

		// persistentDraw = persistentUpdate = false;

		bg = new FlxSprite(0, 0);
		bg.makeGraphic(1, 1, FlxColor.BLACK).setGraphicSize(FlxG.width, FlxG.height);
		bg.updateHitbox();
		bg.scrollFactor.set();
		bg.alpha = 0;
		add(bg);

		for (i in 0...options.length)
		{
			var optionText:FlxText = new FlxText(0, 200 + (100 * i), 0, options[i]);
			optionText.setFormat(Paths.font("Monocraft.ttf"), 48, FlxG.camera.bgColor, CENTER, OUTLINE, 0xffffffff);
			optionText.ID = i;
			optionText.borderSize = 4;
			optionText.screenCenter(X);
			optionText.alpha = 0;
			grpOptions.push(optionText);
			add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '[', true);
		selectorLeft.alpha = 0;
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, ']', true);
		selectorRight.alpha = 0;
		add(selectorRight);

		header = new Panel(LayerData.HEADER);
		header.text = "choose your preferences";
		add(header);

		curSelection = curSelection;
		updateItems();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function refresh()
	{
		if (Menu.previous is MainMenu)
		{
			header.runAcrossLayers();
			bg.alpha = 0;

			FlxTween.tween(bg, {alpha: 0.6}, 0.5);

			selectorLeft.alpha = 0;
			selectorRight.alpha = 0;

			for (i in 0...grpOptions.length)
			{
				grpOptions[i].alpha = 0;
				FlxTween.tween(grpOptions[i], {alpha: 1}, 0.1, {startDelay: i * 0.1});
				if (curSelection == i)
				{
					FlxTween.tween(selectorLeft, {alpha: 1}, 0.1, {startDelay: i * 0.1});
					FlxTween.tween(selectorRight, {alpha: 1}, 0.1, {startDelay: i * 0.1});
				}
			}
		}
		else
		{
			bg.alpha = 0.6;
		}
	}

	override function close()
	{
		super.close();
		// header.text = "choose your preferences";
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.UI_UP_P)
		{
			curSelection--;
			updateItems();
		}
		if (Controls.UI_DOWN_P)
		{
			curSelection++;
			updateItems();
		}

		for (item in grpOptions)
			if (FlxG.mouse.overlaps(item, this.camera))
			{
				if (item.ID != curSelection)
				{
					if (FlxG.mouse.deltaY != 0)
					{
						curSelection = item.ID;
						updateItems();
					}
				}
				else if (FlxG.mouse.justPressed)
					openSelectedSubstate(options[curSelection]);
			}

		if (Controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'), 0.3);

			header.runAcrossLayers(1);

			for (i in 0...grpOptions.length)
			{
				FlxTween.tween(grpOptions[i], {alpha: 0}, 0.1, {startDelay: i * 0.1});
				if (curSelection == i)
				{
					FlxTween.tween(selectorLeft, {alpha: 0}, 0.1, {startDelay: i * 0.1});
					FlxTween.tween(selectorRight, {alpha: 0}, 0.1, {startDelay: i * 0.1});
				}
			}

			FlxTween.tween(bg, {alpha: 0}, 0.5,
				{
					onComplete: function(twn)
					{
						if (PlayState.instance != null && SettingsMenu.fromPlayState)
						{ // Check if player came from playstate.
							FlxG.sound.music.volume = 0.0;
							LoadingState.stage = PlayState.SONG.stage;
							// LoadingState.loadAndSwitchState(new PlayState());
							Menu.switchTo(MainMenu);
							FlxG.sound.music.volume = 0;
							SettingsMenu.fromPlayState = false;
						}
						else
						{ // No? Then return to the main menu.
							Conductor.bpm = 100;
							Menu.switchTo(MainMenu);
						}
					}
				});
		}
		else if (Controls.ACCEPT)
			openSelectedSubstate(options[curSelection]);
	}

	function updateItems()
	{
		for (item in grpOptions)
		{
			item.alpha = 0.6;
			if (item.ID == curSelection)
			{
				item.alpha = 1;
				selectorLeft.x = item.x - selectorLeft.width + 30;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width - 30;
				selectorRight.y = item.y;
			}
		}
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}
