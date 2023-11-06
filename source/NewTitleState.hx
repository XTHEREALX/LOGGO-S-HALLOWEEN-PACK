package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
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

  override function create()
  {

    #if android
    addVirtualPad(A_B);
    #end

    Paths.clearStoredMemory();
    Paths.clearUnusedMemory();

    FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

    var BG:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('mainmenu/background'));
    BG.updateHitbox();
    BG.screenCenter();
    add(BG);

  super.create();
}

override function update();
{
  if (controls.ACCEPT)
      {
	MusicBeatState.switchState(new MainMenuState());
      }

  super.update();
}
}
