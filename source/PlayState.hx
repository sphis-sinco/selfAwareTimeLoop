package;

import satl.Player;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var player:Player;

	override public function create()
	{
		super.create();
		
		player = new Player();
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
