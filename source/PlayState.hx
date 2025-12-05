package;

import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import satl.Player;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var player:Player;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	override public function create()
	{
		super.create();

		player = new Player();

		map = new FlxOgmo3Loader('assets/data/levels/dummy.ogmo', 'assets/data/levels/dummy.json');
		walls = map.loadTilemap('assets/images/tilemap.png', 'walls');
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		add(walls);

		map.loadEntities(placeEntities, 'entities');
		add(player);

		FlxG.camera.zoom = 4;
	}

	public function placeEntities(entity:EntityData)
	{
		if (entity.name == 'player')
			player.setPosition(entity.x, entity.y);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		player.update(elapsed);

		FlxG.collide(player, walls);
		FlxG.camera.follow(player, TOPDOWN, 1);
	}
}
