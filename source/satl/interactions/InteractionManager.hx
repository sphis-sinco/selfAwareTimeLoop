package satl.interactions;

class InteractionManager
{
	public static var game(get, never):PlayState;

	public static function get_game():PlayState
	{
		return PlayState.instance;
	}

	public static function getISOInteraction(iso:InteractableSpriteObject)
	{
		if (game == null)
			return;

		switch (iso.id)
		{
			default:
				if (!Reflect.hasField(game.level_data.dialogues, iso.id))
				{
					#if DIALOGUE_TESTING_STUFFS
					game.in_cutscene = true;
					game.dialogue_box.show();
					#end
					game.dialogue_box.setDialogue('Unknown interation: ' + iso.id);
					trace(game.dialogue_box.text.text);
				}
				else
				{
					game.dialogue_box.loadDialogues(Reflect.field(game.level_data.dialogues, iso.id));
				}
		}
	}
}
