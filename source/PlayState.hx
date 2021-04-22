package;

import Icon;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import haxe.io.Path;
import lime.utils.Assets;

using StringTools;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();
		createIconGrid();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		checkDesc();
	}

	var columnsGrid:Float = 5;
	var rowsGrid:Float = 5;
	var curRow:Float = 0;
	var curColumn:Float = 0;
	var iconSprite:FlxSprite;
	var chrSprite:Icon;
	var characters:Array<Float> = [];
	var characterList:Array<String> = CoolUtil.coolTextFile(AssetPaths.characters__txt);
	var characterDescriptionList:Array<String> = CoolUtil.coolTextFile(Paths.txt("characterInfo"));

	public function createIconGrid()
	{
		//	Reads the text file to get list of Characters in the game
		for (character in characterList)
		{
			characters.push(characterList.indexOf(character, 0));
			trace(character + ' Loaded!');
		}

		// Loads Sprite for IconOverlay
		for (i in 0...characters.length)
		{
			if (curColumn > columnsGrid)
			{
				curColumn = 0;
				curRow++;
			}

			// Creates Character Icon
			chrSprite = new Icon(characterList[i], curColumn, curRow);
			chrSprite.x = 10 + 150 * curColumn;
			chrSprite.y = 10 + 200 * curRow;

			// Creates Overlay
			iconSprite = new FlxSprite(10 + 150 * curColumn, 10 + 200 * curRow);
			iconSprite.loadGraphic(AssetPaths.IconOverlay__png);

			add(chrSprite);
			add(iconSprite);
			trace(i);

			curColumn++;
		}
	}

	public function checkDesc()
	{
		if (FlxG.mouse.overlaps(chrSprite))
		{
			trace(chrSprite.desc);
		}
	}
}
