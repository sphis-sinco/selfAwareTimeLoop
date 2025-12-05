package satl;

import flixel.FlxG;
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

	public var merged_controls:Dynamic;

	public var current_speed:Float = 0.0;
	public var speed_acceleration:Float = 0.1;
	public var max_speed:Float = 4.0;

	override public function new()
	{
		super();
		initMergedControls();

		makeGraphic(16, 16, FlxColor.BLUE);
	}

	public function initMergedControls()
	{
		var merged_movement:Array<FlxKey> = [];
		var merged_interaction:Array<FlxKey> = [];

		for (key in controls.left)
			merged_movement.push(key);
		for (key in controls.down)
			merged_movement.push(key);
		for (key in controls.up)
			merged_movement.push(key);
		for (key in controls.right)
			merged_movement.push(key);

		for (key in controls.interact)
			merged_interaction.push(key);

		merged_controls = {
			movement: merged_movement,
			interaction: merged_interaction
		};
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyPressed(merged_controls.movement))
		{
			current_speed *= speed_acceleration;

			if (FlxG.keys.anyPressed(controls.left))
				this.x -= current_speed;
			else if (FlxG.keys.anyPressed(controls.down))
				this.x += current_speed;
			else if (FlxG.keys.anyPressed(controls.up))
				this.y -= current_speed;
			else if (FlxG.keys.anyPressed(controls.right))
				this.x += current_speed;
		}

		if (current_speed > max_speed)
			current_speed = max_speed;
	}
}
