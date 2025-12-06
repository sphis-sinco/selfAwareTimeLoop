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

		switch (iso.id)
		{
			default:
				game.in_cutscene = true;
		}
	}
}
