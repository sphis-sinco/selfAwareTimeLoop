package;

import satl.Utilities;
import flixel.util.FlxColor;
import flixel.FlxBasic;
import satl.InteractableSpriteObject;
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
	public var entities:FlxTypedGroup<FlxBasic>;
	public var level_data:LevelData;

	override public function new(?ogmo:String = 'main', ?level:String = 'start')
	{
		super();

		level_data = Json.parse(Assets.getText('assets/data/levels/' + level + '-data.json'));
		trace('Loading level: ' + level);

		player = new Player();

		tilemaps = new FlxTypedGroup<World>();
		add(tilemaps);

		entities = new FlxTypedGroup<FlxBasic>();
		add(entities);

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

		if (entity.name == 'interactable_sprite_object')
		{
			if (entity.values?.id == null)
				return;

			var interactable_sprite_object:InteractableSpriteObject = new InteractableSpriteObject(entity.values.id);
			Reflect.deleteField(entity.values, 'id');

			interactable_sprite_object.setPosition(entity.x, entity.y);

			if (entity.values?.has_image ?? false && entity.values?.image_path != null)
			{
				interactable_sprite_object.loadGraphic('assets/' + entity.values?.image_path.replace('../', '').replace('proj:', '').replace('lvl:', ''));
			}
			else
			{
				var color = entity.values?.graphic_color.substring(0, entity.values?.graphic_color.length - 2);
				// trace(color);
				interactable_sprite_object.makeGraphic(16, 16, FlxColor.fromString(color) ?? FlxColor.RED);
			}

			interactable_sprite_object.data = entity.values;

			trace('Created I.S.O. with id: ' + interactable_sprite_object.id);
			for (field in Reflect.fields(interactable_sprite_object.data))
				trace('  * ' + field + ': ' + Reflect.field(interactable_sprite_object.data, field));

			entities.add(interactable_sprite_object);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		player.update(elapsed);
		for (tilemap in tilemaps.members)
			for (layer in level_data?.layers ?? [])
				if (layer.collision && layer.name == tilemap.layer)
					FlxG.collide(player, tilemap);

		for (entity in entities)
		{
			var iso:InteractableSpriteObject = cast entity;

			if (iso != null)
			{
				if (player.overlaps(iso) && FlxG.keys.anyJustReleased(player.merged_controls.interaction))
				{
					iso.interact();
				}

				if (iso.data.can_move)
					FlxG.collide(player, iso);
			}
		}

		player_campos.setPosition(player.getGraphicMidpoint().x, player.getGraphicMidpoint().y);
		FlxG.camera.follow(player_campos, FlxCameraFollowStyle.TOPDOWN_TIGHT, 1);
	}
}
