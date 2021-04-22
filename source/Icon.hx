package;

import flixel.FlxSprite;

using StringTools;

class Icon extends FlxSprite
{
	public var desc:String = '';

	var characterDescriptionList:Array<String> = CoolUtil.coolTextFile(AssetPaths.characterInfo__txt);

	public function new(character:String, curColumn:Float, curRow:Float)
	{
		super();

		new FlxSprite(10 + 150 * curColumn, 10 + 200 * curRow);
		loadGraphic(Paths.image("icons/" + character + "Icon"));

		for (i in 0...characterDescriptionList.length)
		{
			if (characterDescriptionList[i].startsWith(character))
			{
				desc = characterDescriptionList[i];
			}
		}
	}
}
