package menus;

class GameMenu extends Menu
{
	var strums:Array<FlxSprite> = [];

	override public function create()
	{
		super.create();
		for (i in 0...4)
		{
			var strum:FlxSprite = new FlxSprite(FlxG.width - 50 - (106 * (4 - i)), 50);
			strum.makeGraphic(1, 1, 0x84000000);
			strum.setGraphicSize(96, 96);
			strum.updateHitbox();
			strum.scrollFactor.set();
			add(strum);
			strums.push(strum);
		}
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
			Menu.switchTo(PauseMenu); // menu openOnTop
		}
	}
}
