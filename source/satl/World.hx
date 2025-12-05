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

    public var layer:String;

	override public function new(ogmo_name:String, level_name:String, layer:String)
	{
		super();

		reload(ogmo_name, level_name, layer);
	}

	public function reload(ogmo_name:String, level_name:String, target_layer:String)
	{
		trace('Loading World Layer: ' + target_layer);
        this.layer = target_layer;

		map = new FlxOgmo3Loader('assets/data/levels/' + ogmo_name + '.ogmo', 'assets/data/levels/' + level_name + '.json');
		var tilemap_label:String = '';
		@:privateAccess
		for (layer in map.level.layers)
			if (layer?.tileset != null && layer.name == target_layer)
			{
				for (tileset in map.project.tilesets)
					if (tileset.label == layer.tileset)
						map.loadTilemap('assets/' + tileset.path.replace('../', ''), target_layer, this);
				tilemap_label = layer.tileset.toLowerCase();
				break;
			}
		follow();
		trace('    * Tilemap: ' + tilemap_label);

		for (tile in Reflect.field(Json.parse(Assets.getText('assets/data/tilesets.json')), tilemap_label) ?? [])
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
