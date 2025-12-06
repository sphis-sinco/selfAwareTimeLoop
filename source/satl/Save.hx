package satl;

#if sys
import sys.FileSystem;
import sys.io.File;
#end
import haxe.Json;

class Save
{
	#if sys
	public static function save()
	{
		File.saveContent('assets/data/save.json', Json.stringify({
			action_tags: action_tags
		}));
	}

	public static function load()
	{
		if (!FileSystem.exists('assets/data/save.json'))
			return;

		var save_file:Dynamic = Json.parse(File.getContent('assets/data/save.json'));

		action_tags = save_file.action_tags;
	}
	#end

	public static var action_tags:Array<String> = [];

	public static function addActionTag(tag:String)
	{
		if (!action_tags.contains(tag))
		{
			trace('Added tag: ' + tag);
			action_tags.push(tag);
		}
	}
}
