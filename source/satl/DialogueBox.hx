package satl;

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

	override public function new(dialogue:String)
	{
		super();

        box = new FlxSprite();
        add(box);

        box.makeGraphic(Std.int(FlxG.width / 2), Std.int(FlxG.height / 4), FlxColor.WHITE);

        text = new FlxText(0, 0, box.width, dialogue);
        add(text);
	}
}
