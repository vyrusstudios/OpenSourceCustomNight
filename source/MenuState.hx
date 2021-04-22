package;

import Icon;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.io.Path;
import lime.utils.Assets;

using StringTools;

class MenuState extends FlxState
{
	var goBTN:FlxSprite;

	// Info Box
	var animatronicSelected:Bool = false;
	var infoBox:FlxSprite;
	var info:FlxText;

	override public function create()
	{
		super.create();
		createIconGrid();

		goBTN = new FlxSprite();
		goBTN.loadGraphic(Paths.image("ui/mainMenu/go_deselected"));
		goBTN.setGraphicSize(200, 0);
		goBTN.x = 1050;
		goBTN.y = 490;
		add(goBTN);

		infoBox = new FlxSprite(2000, 2000);
		infoBox.loadGraphic(Paths.image("ui/mainMenu/infoBox"));
		add(infoBox);

		info = new FlxText(infoBox.x + 4, infoBox.y + 2, 316, "Animatronic: Info", 10, false);
		info.x = infoBox.x + 4;
		info.y = infoBox.y + 2;
		info.color = FlxColor.WHITE;
		add(info);
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
	var chrSprites:Array<Icon> = [];
	var characters:Array<Float> = [];
	var characterList:Array<String> = CoolUtil.coolTextFile(AssetPaths.characters__txt);
	var characterDescriptionList:Array<String> = CoolUtil.coolTextFile(Paths.txt("characterInfo"));

	public function createIconGrid()
	{
		//	Reads the text file to get list of Characters in the game
		for (character in characterList)
		{
			characters.push(characterList.indexOf(character, 0));
			chrSprites.push(new Icon(character, curColumn, curRow));

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
			chrSprites[i].x = 5 + 100 * curColumn;
			chrSprites[i].y = 5 + 150 * curRow;

			// Creates Overlay
			iconSprite = new FlxSprite(5 + 100 * curColumn, 5 + 150 * curRow);
			iconSprite.loadGraphic(AssetPaths.IconOverlay__png);
			iconSprite.setGraphicSize(100, 150);
			iconSprite.antialiasing = true;

			add(chrSprites[i]);
			add(iconSprite);
			trace(i);

			curColumn++;
		}
	}

	public function checkDesc()
	{
		info.x = infoBox.x + 4;
		info.y = infoBox.y + 2;

		if (FlxG.mouse.justPressed)
		{
			for (chrSprite in chrSprites)
			{
				if (FlxG.mouse.overlaps(chrSprite))
				{
					chrSprite.SetDesc();
					infoBox.x = chrSprite.x + 100;
					infoBox.y = chrSprite.y + 150;
					info.text = chrSprite.desc;
				}
			}
		}
	}
}
