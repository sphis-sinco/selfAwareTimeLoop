package satl.interactions;

class InteractionManager
{
	static var game(get, never):PlayState;

	static function get_game():PlayState
	{
		return PlayState.instance;
	}

	public static function getISOInteraction(iso:InteractableSpriteObject)
	{
		if (game == null)
			return;
		if (game.dialogue_box == null)
			return;

		switch (iso.id)
		{
			default:
				game.in_cutscene = true;
				game.dialogue_box.visible = true;
				game.dialogue_box.loadDialogueFiles(['dia_test']);
				game.dialogue_box.openBox();
		}
	}
}
