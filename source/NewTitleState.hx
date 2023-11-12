package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import options.GraphicsSettingsSubState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.Assets;

class NewTitleState extends MusicBeatState{
var starsBG:FlxBackdrop;
var BG:FlxSprite;

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

	#if android
  addVirtualPad(NONE, A_B);
  #end

  super.create();
}

    override public function update(elapsed:Float){
        if (controls.ACCEPT){
            FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
            FlxG.camera.flash(ClientPrefs.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1);
			    	FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
            MusicBeatState.switchState(new MainMenuState());
        }

	      starsBG.x = FlxMath.lerp(starsBG.x, starsBG.x - 0.5, CoolUtil.boundTo(elapsed * 9, 0, 1));

        super.update(elapsed);
    }
}
