package;

import flixel.FlxObject;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import satl.Player;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var player:Player;
	public var player_campos:FlxObject;

	public var map:FlxOgmo3Loader;
	public var walls:FlxTilemap;

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

		player_campos = new FlxObject(0, 0, player.width, player.height);
		add(player_campos);

		FlxG.camera.zoom = 2;
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

		player_campos.setPosition(player.getGraphicMidpoint().x, player.getGraphicMidpoint().y - 64);
		FlxG.camera.follow(player_campos, FlxCameraFollowStyle.TOPDOWN_TIGHT, 1);
	}
}
