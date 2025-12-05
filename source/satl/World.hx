package satl;

import lime.utils.Assets;
import haxe.Json;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;

class World extends FlxTilemap
{
    public var map:FlxOgmo3Loader;

	override public function new(level_name:String)
	{
		super();

		map = new FlxOgmo3Loader('assets/data/levels/' + level_name + '.ogmo', 'assets/data/levels/' + level_name + '.json');
		@:privateAccess
		map.loadTilemap('assets/' + map.project.tilesets[0].path.split('..')[0], 'walls', this);
		follow();

		for (tile in Json.parse(Assets.getText('assets/data/tileset.json'))?.tiles ?? [])
		{
			setTileProperties(tile.id, tile?.collision);
		}
	}
}
