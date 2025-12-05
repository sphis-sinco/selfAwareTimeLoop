package satl;

import flixel.util.FlxDirectionFlags;

class Utilities
{

    public static function convertStringToDirectionFlag(s:String):FlxDirectionFlags
    {
        return switch (s)
			{
				case 'left': LEFT;
				case 'down': DOWN;
				case 'up': UP;
				case 'right': RIGHT;

				case 'ceiling': CEILING;
				case 'floor': FLOOR;
				case 'wall': WALL;
				case 'any': ANY;

				case 'none': NONE;

				default: NONE;
			};
    }
    
}