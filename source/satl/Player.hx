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

	override public function new()
	{
		super();

        makeGraphic(16, 16, FlxColor.BLUE);
	}
}
