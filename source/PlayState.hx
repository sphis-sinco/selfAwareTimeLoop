package;

import flixel.util.FlxSort;
import flixel.addons.editors.ogmo.FlxOgmo3Loader.EntityData;
import satl.LevelData;
import lime.utils.Assets;
import haxe.Json;
import flixel.group.FlxGroup.FlxTypedGroup;
import satl.World;
import flixel.FlxObject;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import satl.Player;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var player:Player;
	public var player_campos:FlxObject;

	public var tilemaps:FlxTypedGroup<World>;
	public var level_data:LevelData;

	override public function new(?ogmo:String = 'main', ?level:String = 'start')
	{
		super();

		level_data = Json.parse(Assets.getText('assets/data/levels/' + level + '-data.json'));
		trace('Loading level: ' + level);

		player = new Player();

		tilemaps = new FlxTypedGroup<World>();
		add(tilemaps);

		level_data.layers.sort((l1, l2) ->
		{
			return FlxSort.byValues(FlxSort.DESCENDING, l1.layer, l2.layer);
		});

		for (layer in level_data.layers)
		{
			var tilemap = new World(ogmo, level, layer.name);
			tilemaps.add(tilemap);

			if (layer.has_entities)
				tilemap.map.loadEntities(placeEntities, 'entities');
		}

		add(player);
	}

	override public function create()
	{
		super.create();

		player_campos = new FlxObject(0, 0, player.width, player.height);
		add(player_campos);

		// FlxG.camera.zoom = 2;
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
		for (tilemap in tilemaps.members)
			for (layer in level_data?.layers ?? [])
				if (layer.collision && layer.name == tilemap.layer)
					FlxG.collide(player, tilemap);

		player_campos.setPosition(player.getGraphicMidpoint().x, player.getGraphicMidpoint().y);
		FlxG.camera.follow(player_campos, FlxCameraFollowStyle.TOPDOWN_TIGHT, 1);
	}
}
