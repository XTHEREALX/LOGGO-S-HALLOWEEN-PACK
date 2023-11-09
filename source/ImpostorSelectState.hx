package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.FlxG;

class ImpostorSelectState extends MusicBeatState{
public static var freeplayCats:Array<String> = ['loggodx', 'loggoplus', 'loggodside', 'loggob3', 'loggoneo', 'loggoObjects', 'loggoneo'];
public static var curCategory:Int = 0;
var grpCats:FlxTypedGroup<Alphabet>;
var curSelected:Int = 0;
var starsBG:FlxBackdrop;
var BG:FlxSprite;
var categoryIcon:FlxSprite;
    override function create(){

	Paths.clearStoredMemory();
	Paths.clearUnusedMemory();
	
        starsBG = new FlxBackdrop(Paths.image('starsBG'), 1, 1, true, true);
	starsBG.setPosition(111.3, 67.95);
        starsBG.antialiasing = true;
        starsBG.updateHitbox();
        starsBG.scrollFactor.set();
        add(starsBG);

	BG = new FlxSprite().loadGraphic(Paths.image('SelectMenu/Border'));
	BG.screenCenter();
	add(BG);

        categoryIcon = new FlxSprite().loadGraphic(Paths.image('SelectMenu/Categories/logo-' + freeplayCats[curSelected].toLowerCase()));
	categoryIcon.updateHitbox();
	categoryIcon.screenCenter();
	add(categoryIcon);

	#if android
        addVirtualPad(FULL, A_B);
        #end

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

	starsBG.x = FlxMath.lerp(starsBG.x, starsBG.x - 0.5, CoolUtil.boundTo(elapsed * 9, 0, 1));

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

		categoryIcon.loadGraphic(Paths.image('SelectMenu/Categories/logo-' + (freeplayCats[curSelected].toLowerCase())));
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
