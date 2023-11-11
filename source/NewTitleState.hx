package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flixel.system.FlxSound;

using StringTools;

class NewTitleState extends MusicBeatState
{
  var BG:FlxSprite;
  var starsBG:FlxBackdrop;

  override function create()
  {
    Paths.clearStoredMemory();
    Paths.clearUnusedMemory();

    starsBG = new FlxBackdrop(Paths.image('starsBG'), 1, 1, true, true);
    starsBG.setPosition(111.3, 67.95);
    starsBG.updateHitbox();
    starsBG.scrollFactor.set();
    add(starsBG);

    var BG:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('TitleScreen'));
    BG.updateHitbox();
    BG.screenCenter();
    add(BG);

    #if android
    addVirtualPad(A_B);
    #end

    FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.7);

  super.create();
}

override function update();
{

  starsBG.x = FlxMath.lerp(starsBG.x, starsBG.x - 0.5, CoolUtil.boundTo(elapsed * 9, 0, 1));
	
  if (controls.ACCEPT)
      {
	MusicBeatState.switchState(new MainMenuState());
      }

  super.update();
 }
}
