package;

import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.graphics.FlxGraphic;
#if desktop
import Discord.DiscordClient;
#end
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
#if sys
import sys.FileSystem;
import sys.io.File;
#end
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.Lib;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.BitmapFilter;
import openfl.utils.Assets as OpenFlAssets;
import editors.ChartingState;
import editors.CharacterEditorState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import Note.EventNote;
import openfl.events.KeyboardEvent;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxSave;
import animateatlas.AtlasFrameMaker;
import Achievements;
import StageData;
import FunkinLua;
import DialogueBoxPsych;
import Conductor.Rating;
#if sys
import sys.FileSystem;
#end
import hscript.Interp;

#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end

using StringTools;


class SpoilerWarning extends MusicBeatSubstate { 
    private var transGradient:FlxSprite;
    private var bg:FlxSprite;
    private var text:FlxText;
    public function new() {
        super();
        init();
        tweens();
    }
    private function startCallback() { 
        new FlxTimer().start(3,function(t:FlxTimer) {
            trace("Spoiler warning done");
            FlxTween.tween(text,{x:-30,alpha:0},0.25/2,{ease:FlxEase.sineOut});
            FlxTween.tween(bg,{alpha:0},0.25/2,{ease:FlxEase.sineOut});
            FlxTween.tween(transGradient,{y:720},0.5/2,{ease:FlxEase.sineOut,onComplete:function(t:FlxTween) {
                end();
            }});
        });
    }
    function end(){
        close();
        PlayState.instance.startCountdown();
    }
    private function init() { 
        bg=new FlxSprite().makeGraphic(1280,720,FlxColor.BLACK);
        bg.screenCenter();
        add(bg);
        bg.alpha=0;
        
		transGradient = FlxGradient.createGradientFlxSprite(1280, 720, ([FlxColor.RED, 0x0]));
		transGradient.scrollFactor.set();
		add(transGradient);
        transGradient.screenCenter();
        transGradient.alpha = 0.7;
        transGradient.y += 720;
        add(transGradient);


        text = new FlxText(0,0,1280,"Spoiler Warning!!!!\n\n\nPress ESC to exit\nYou have been warned",40);
        text.alignment = FlxTextAlign.CENTER;
        text.screenCenter();
        text.setFormat(Paths.font("VetoSansCond-MediumItalic.ttf"), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(text);
        text.y+=100;
        text.x-=30;
        text.alpha=0;
    }

    override  function update(elapsed:Float) {
        if(FlxG.keys.justPressed.ESCAPE){
            MusicBeatState.switchState(MusicBeatState.lastState);
        }
    }
    private function tweens() {
        FlxTween.tween(text,{x:0,alpha:1},0.25,{ease:FlxEase.sineOut});
        FlxTween.tween(bg,{alpha:0.9},0.25,{ease:FlxEase.sineOut});
        FlxTween.tween(transGradient,{y:0},0.5,{ease:FlxEase.sineOut,onComplete:function(t:FlxTween) {
            startCallback();
        }});
    }
}