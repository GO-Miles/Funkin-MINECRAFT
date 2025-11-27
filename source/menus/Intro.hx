package menus;

class Intro extends Menu
{
	var strums:Array<FlxSprite> = [];

	override public function create()
	{
		super.create();

		GameWorld.BG.visible = false;
		GameWorld.FG.visible = false;
		GameWorld.player.visible = false;
	}

	override public function close()
	{
		super.close();
		GameWorld.BG.visible = true;
		GameWorld.FG.visible = true;
		GameWorld.player.visible = true;
	}

	override public function update(elapsed:Float)
	{
		if (Controls.ACCEPT)
		{
			Menu.switchTo(TitleMenu);
		}
	}
}
