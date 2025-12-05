package satl;

import flixel.FlxSprite;

class InteractableSpriteObject extends FlxSprite implements InteractableObject
{
	public dynamic function interact() {}

    public var id:String;
    public var data:Null<Dynamic> = {};

	override public function new(id:String)
	{
		super();

        this.id = id;
	}
}
