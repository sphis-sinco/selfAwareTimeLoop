package satl;

import satl.LevelData.DialogueLine;
import flixel.util.typeLimit.OneOfTwo;
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
        if (dialogue == null)
            return;

		text.text = dialogue;

		voice_line.stop();

		if (dialogue_sound != null)
		{
			voice_line.loadStream('assets/sounds/dialogue/' + dialogue_sound + '.wav');
			voice_line.play();
		}
	}

	public function hide()
	{
		text.visible = false;
		box.visible = false;

		voice_line.pause();
	}

	public function show()
	{
		text.visible = true;
		box.visible = true;

		voice_line.play();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (box.visible)
		{
			dialogueUpdate();
		}
	}

	public dynamic function dialogueUpdate() {}

	public function loadDialogues(dia:Array<DialogueLine>)
	{
		if (PlayState.instance == null)
			return;
		if (PlayState.instance.player == null)
			return;

		var index = 0;

		PlayState.instance.in_cutscene = true;
		show();

		dialogueUpdate = () ->
		{
			if (FlxG.keys.anyJustReleased(PlayState.instance.player.controls.proceed))
				index++;

			var dialogue_action_tags:Array<String> = dia[index]?.tags;

			if (dialogue_action_tags != null)
				for (tag in dialogue_action_tags)
					if (!Save.action_tags.contains(tag))
					{
						index++;
						break;
					}

			if (index >= dia.length || dia[index] == null)
			{
				hide();
				PlayState.instance.in_cutscene = false;
			}

			if (text.text != dia[index]?.line)
				setDialogue(dia[index]?.line, dia[index]?.sound);
		};
	}
}
