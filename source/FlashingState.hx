package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;
	var starsBG:FlxBackdrop;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		starsBG = new FlxBackdrop(Paths.image('starsBG'), 1, 1, true, true);
	        starsBG.setPosition(111.3, 67.95);
                starsBG.updateHitbox();
                starsBG.scrollFactor.set();
                add(starsBG);

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('FlashScreen'));
		add(bg);

                #if android
                addVirtualPad(NONE, A_B);
                #end
	}

	override function update(elapsed:Float)
	{
		starsBG.x = FlxMath.lerp(starsBG.x, starsBG.x - 0.5, CoolUtil.boundTo(elapsed * 9, 0, 1));

		if(!leftState) {
			var back:Bool = controls.BACK;
			if (controls.ACCEPT || back) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if(!back) {
					ClientPrefs.flashing = false;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('KillSound'));
					FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
						new FlxTimer().start(0.5, function (tmr:FlxTimer) {
							MusicBeatState.switchState(new NewTitleState());
						});
					});
				} else {
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new NewTitleState());
						}
					});
				}
			}
		}
		super.update(elapsed);
	}
}
