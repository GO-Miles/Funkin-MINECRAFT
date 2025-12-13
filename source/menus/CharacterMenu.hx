package menus;

class CharacterMenu extends Menu
{
	var button:Button;

	override public function create()
	{
		super.create();
		header = new Panel(LayerData.HEADER);
		header.text = "select your character";
		add(header);

		add(new Button(100, 200, 200, 100, 5, 10, "woah", null, 0xFF000000));
	}

	override public function refresh()
	{
		header.runAcrossLayers(2);
		super.refresh();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (Controls.BACK)
		{
			Menu.switchTo(AdventureMenu);
		}
		if (Controls.ACCEPT)
		{
			Menu.switchTo(GameMenu);
		}
	}
}
