package;

import lime.app.Application;
import satl.Save;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		#if sys
		#if !debug
		Save.load();
		#end
		Save.save();

		Application.current.onExit.add(l -> Save.save());
		#end

		addChild(new FlxGame(Std.int(1280 / 4), Std.int(720 / 4), PlayState));
	}
}
