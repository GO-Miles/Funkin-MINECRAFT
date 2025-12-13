package menus;

class CreativeMenu extends Menu
{
	var button:Button;

	override public function create()
	{
		super.create();
		header = new Panel(LayerData.HEADER);
		header.text = "create your objective";
		add(header);

		add(new Button(100, 200, 200, 100, 5, 10, "woah", null, 0xFF000000));
	}

	override public function refresh()
	{
		header.runAcrossLayers(0);
		super.refresh();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (Controls.BACK)
		{
			Menu.switchTo(MainMenu);
		}
	}
}
