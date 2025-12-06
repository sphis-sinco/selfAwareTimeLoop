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
			case 'dummy_dialogue_1':
				DummyDialogues.dummy_dialogue_1();
			case 'dummy_dialogue_2':
				DummyDialogues.dummy_dialogue_2();

			default:
				#if DIALOGUE_TESTING_STUFFS
				game.in_cutscene = true;
				game.dialogue_box.show();
				#end
				game.dialogue_box.setDialogue('Unknown interation: ' + iso.id);
				trace(game.dialogue_box.text.text);
		}
	}
}
