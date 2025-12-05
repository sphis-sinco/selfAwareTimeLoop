package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(Std.int(1280 / 4), Std.int(720 / 4), PlayState));
	}
}
