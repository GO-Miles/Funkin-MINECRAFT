package menus;

class GameMenu extends Menu
{
	var strums:Array<FlxSprite> = [];

	override public function create()
	{
		super.create();

		var areaPadding:Int = 50;
		var padding:Int = 10;
		var playAreaRatio:Float = 0.33;
		var playAreaWidth:Float = (-areaPadding * 2) + FlxG.width * playAreaRatio;
		var calcSize:Float = (playAreaWidth - (padding * 3)) / 4;

		var black:FlxSprite = new FlxSprite((FlxG.width - playAreaWidth) - areaPadding - padding, areaPadding - padding).makeGraphic(1, 1, 0x84000000);
		black.setGraphicSize(playAreaWidth + padding * 2, calcSize + padding * 2);
		black.updateHitbox();
		black.scrollFactor.set();
		add(black);

		for (i in 0...4)
		{
			var strum:FlxSprite = new FlxSprite((-areaPadding + FlxG.width - playAreaWidth) + (calcSize * i) + (padding * i), areaPadding);
			strum.makeGraphic(1, 1, 0x84000000);
			strum.setGraphicSize(calcSize, calcSize);
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

	override public function close()
	{
		FlxG.camera.targetOffset.x = 0;
		super.close();
	}

	override public function update(elapsed:Float)
	{
		if (Controls.ACCEPT)
		{
			Menu.switchTo(PauseMenu); // menu openOnTop
		}
	}
}
