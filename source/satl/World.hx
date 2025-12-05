package satl;

import flixel.util.FlxDirectionFlags;
import lime.utils.Assets;
import haxe.Json;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;

using StringTools;

class World extends FlxTilemap
{
	public var map:FlxOgmo3Loader;

	override public function new(level_name:String)
	{
		super();

		map = new FlxOgmo3Loader('assets/data/levels/' + level_name + '.ogmo', 'assets/data/levels/' + level_name + '.json');
		@:privateAccess
		map.loadTilemap('assets/' + map.project.tilesets[0].path.replace('../', ''), 'walls', this);
		follow();

		for (tile in Json.parse(Assets.getText('assets/data/tileset.json'))?.tiles ?? [])
		{
			var collision:FlxDirectionFlags = switch (Std.string(tile?.collision).toLowerCase())
			{
				case 'left': LEFT;
				case 'down': DOWN;
				case 'up': UP;
				case 'right': RIGHT;

				case 'ceiling': CEILING;
				case 'floor': FLOOR;
				case 'wall': WALL;
				case 'any': ANY;

				case 'none': NONE;

				default: NONE;
			};

			if (tile?.id != null)
				setTileProperties(tile.id, collision);
		}
	}
}
