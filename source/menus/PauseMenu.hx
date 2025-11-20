package menus;

class PauseMenu extends Menu
{
	var strums:Array<FlxSprite> = [];

	override public function create()
	{
		super.create();

		var black:FlxSprite = new FlxSprite().makeGraphic(1, 1, 0x84000000);
		black.setGraphicSize(FlxG.width, FlxG.height);
		black.updateHitbox();
		black.scrollFactor.set();
		add(black);

		var pausedTxt:FlxText = new FlxText(50, 50, -50 + FlxG.width * 0.66);
		pausedTxt.text = "paused";
		pausedTxt.setFormat(Paths.font("Minecrafter.ttf"), 64, FlxColor.WHITE, CENTER);
		pausedTxt.scrollFactor.set();
		add(pausedTxt);
	}

	override public function refresh()
	{
		FlxG.camera.follow(GameWorld.player, TOPDOWN, 0.7);
		FlxG.camera.targetOffset.x = FlxG.width / 6; // rule of thirds center offset
	}

	override public function update(elapsed:Float)
	{
		if (Controls.ACCEPT)
		{
			Menu.switchTo(GameMenu); // menu close top
		}
	}
}
