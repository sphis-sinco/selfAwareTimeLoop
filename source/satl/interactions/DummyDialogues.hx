package satl.interactions;

import flixel.FlxG;

class DummyDialogues
{
	public static function dummy_dialogue_1()
	{
		InteractionManager.game.dialogue_box.loadDialogues([['hey...'], ['HEY.'], ['HEY!!!!!!!!!!'], ['WHAT THE FUCK!']]);
	}

	public static function dummy_dialogue_2()
	{
		InteractionManager.game.dialogue_box.loadDialogues([['yo'], ['huh?'], ['yoooooo!'], ['YOOOOOOOOOOO!']]);
	}
}
