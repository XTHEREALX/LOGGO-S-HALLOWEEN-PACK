package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxG;

class ImpostorSelectState extends MusicBeatState{
    public static var freeplayCats:Array<String> = ['loggodx', 'loggoplus', 'loggodside', 'loggob3', 'loggoneo', 'loggoObjects', 'loggoneo'];
    public static var curCategory:Int = 0;
	public var NameAlpha:Alphabet;
	var grpCats:FlxTypedGroup<Alphabet>;
	var curSelected:Int = 0;
	var BG:FlxSprite;
    var categoryIcon:FlxSprite;
    override function create(){
        BG = new FlxSprite().loadGraphic(Paths.image('SelectMenu/BG'));
		BG.updateHitbox();
		BG.screenCenter();
		BG.color = 0xFF00c2ff;
		add(BG);
        categoryIcon = new FlxSprite().loadGraphic(Paths.image('SelectMenu/Categories/Logo-' + freeplayCats[curSelected].toLowerCase()));
		categoryIcon.updateHitbox();
		categoryIcon.screenCenter();
		add(categoryIcon);

        changeSelection();
        super.create();
    }

    override public function update(elapsed:Float){
        
		if (controls.UI_LEFT_P) 
			changeSelection(-1);
		if (controls.UI_RIGHT_P) 
			changeSelection(1);
		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
        if (controls.ACCEPT){
            MusicBeatState.switchState(new FreeplayState());
        }

        curCategory = curSelected;

        super.update(elapsed);
    }

    function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = freeplayCats.length - 1;
		if (curSelected >= freeplayCats.length)
			curSelected = 0;

		var bullShit:Int = 0;

		add(NameAlpha);
		categoryIcon.loadGraphic(Paths.image('SelectMenu/Categories/Logo-' + (freeplayCats[curSelected].toLowerCase())));
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
