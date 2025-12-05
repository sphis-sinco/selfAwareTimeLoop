package satl;

import flixel.util.FlxColor;
import flixel.input.keyboard.FlxKey;
import flixel.FlxSprite;

class Player extends FlxSprite
{
	public var controls = {
		left: [FlxKey.A, FlxKey.LEFT],
		down: [FlxKey.S, FlxKey.DOWN],
		up: [FlxKey.W, FlxKey.UP],
		right: [FlxKey.D, FlxKey.RIGHT],
		interact: [FlxKey.SPACE]
	};

	public var current_speed:Float = 0.0;
	public var max_speed:Float = 4.0;

	override public function new()
	{
		super();

		makeGraphic(16, 16, FlxColor.BLUE);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (current_speed > max_speed)
		{
			current_speed = max_speed;
		}
	}
}
