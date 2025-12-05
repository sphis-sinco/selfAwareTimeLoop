package satl;

import flixel.FlxSprite;

class InteractableSpriteObject extends FlxSprite implements InteractableObject
{
	public dynamic function interact() {}

    public var id:String;

	override public function new(id:String)
	{
		super();

        this.id = id;
	}
}
