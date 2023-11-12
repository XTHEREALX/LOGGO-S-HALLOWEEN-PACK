package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.FlxG;

class NewTitleState extends MusicBeatState{
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

	BG = new FlxSprite().loadGraphic(Paths.image('TitleScreen'));
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

	starsBG.x = FlxMath.lerp(starsBG.x, starsBG.x - 0.5, CoolUtil.boundTo(elapsed * 9, 0, 1));

        super.update(elapsed);
    }
}
