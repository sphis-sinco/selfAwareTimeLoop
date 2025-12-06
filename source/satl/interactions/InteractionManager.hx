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
				#if DIALOGUE_TESTING_STUFFS
				game.in_cutscene = true;
				game.dialogue_box.show();
				#end
				game.dialogue_box.setDialogue('Unkown interation: ' + iso.id);
				trace(game.dialogue_box.text.text);
		}
	}
}
