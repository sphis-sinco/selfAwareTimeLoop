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

	override public function new(ogmo_name:String, level_name:String)
	{
		super();

		reload(ogmo_name, level_name);
	}

	public function reload(ogmo_name:String, level_name:String)
	{
		trace('Loading level: ' + level_name);

		map = new FlxOgmo3Loader('assets/data/levels/' + ogmo_name + '.ogmo', 'assets/data/levels/' + level_name + '.json');
		var tilemap_label:String = '';
		@:privateAccess
		for (layer in map.level.layers)
			if (layer?.tileset != null && layer.name == 'walls')
			{
				for (tileset in map.project.tilesets)
					if (tileset.label == layer.tileset)
						map.loadTilemap('assets/' + tileset.path.replace('../', ''), 'walls', this);
				tilemap_label = layer.tileset.toLowerCase();
				break;
			}
		follow();
		trace('Tilemap: ' + tilemap_label);

		for (tile in Reflect.field(Json.parse(Assets.getText('assets/data/tileset.json')), tilemap_label) ?? [])
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
