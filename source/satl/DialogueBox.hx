package satl;

import flixel.tweens.FlxTween;
import flixel.sound.FlxSound;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class DialogueBox extends FlxTypedSpriteGroup<FlxSprite>
{
	public var box:FlxSprite;
	public var text:FlxText;

	public var voice_line:FlxSound;

	override public function new(dialogue:String)
	{
		super();

		box = new FlxSprite();
		add(box);

		box.makeGraphic(Std.int(FlxG.width / 2), Std.int(FlxG.height / 4), FlxColor.WHITE);

		text = new FlxText(0, 0, box.width, dialogue);
		text.color = FlxColor.BLACK;
		add(text);

		voice_line = new FlxSound();
	}

	public function setDialogue(dialogue:String, ?dialogue_sound:String = null)
	{
		text.text = dialogue;

        voice_line.stop();

		if (dialogue_sound != null)
		{
			voice_line.loadStream('assets/sounds/dialogue/' + dialogue_sound + '.wav');
            voice_line.play();
		}
	}
}
