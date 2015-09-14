package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import enemy.*;
    import flash.display.*;
    import layer.*;
    import player.*;
    import resource.*;
    import sound.*;

    public class SkillPSwordMirageBlade extends SkillAdvanceBase
    {
        private var PositionCharaAnimation:MovieClip;
        private var playerDisplay2:EnemyDisplay;
        private var _aMiraclePlayer:Array;

        public function SkillPSwordMirageBlade(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            super(param1, param2, param3, param4, param5, getResource());
            this.PositionCharaAnimation = ResourceManager.getInstance().createMovieClip(getResource(), "position_chara_act");
            this._aMiraclePlayer = [];
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_6 = _skillUserDisplay as PlayerDisplay;
                _loc_6.setAnimationPattern(this.PositionCharaAnimation);
                _layer.getLayer(LayerBattle.CHARACTER).addChild(this.PositionCharaAnimation);
                this.PositionCharaAnimation.x = this.PositionCharaAnimation.x + _loc_6.pos.x;
                this.PositionCharaAnimation.y = this.PositionCharaAnimation.y + _loc_6.pos.y;
                this.PositionCharaAnimation.gotoAndPlay("start");
                while (_loc_7 < this.PositionCharaAnimation.totalFrames)
                {
                    
                    _loc_7++;
                }
            }
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseApproach() : void
        {
            return;
        }// end function

        override protected function controlApproach() : void
        {
            setPhase(_PHASE_ACTION);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = 4;
                for each (_loc_2 in _aTarget)
                {
                    
                    _loc_3 = new MiragePlayer(_layer, _skillUserDisplay, getResource(), _loc_2, _bReverse, SoundManager, this.playDam, _loc_1);
                    this._aMiraclePlayer.push(_loc_3);
                    _loc_1 = _loc_1 + 4;
                }
            }
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_4 = 4;
                for each (_loc_5 in _aTarget)
                {
                    
                    _loc_6 = new MirageEnemy(_layer, _skillUserDisplay, getResource(), _loc_5, _bReverse, SoundManager, this.playDam, _loc_4);
                    this._aMiraclePlayer.push(_loc_6);
                    _loc_4 = _loc_4 + 4;
                }
            }
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (_bossEffect != null && isBoss())
                {
                    if (_bossEffect.currentFrameLabel == "loopEnd")
                    {
                        _bossEffect.gotoAndPlay("loopStart");
                    }
                }
            }
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = 0;
                while (_loc_1 < this._aMiraclePlayer.length)
                {
                    
                    _loc_2 = this._aMiraclePlayer[_loc_1];
                    if (_loc_2.LabelHit && _loc_2.HitEffectAdded == false)
                    {
                        this.PositionCharaAnimation.stop();
                        _loc_2.HitEffectAdded = true;
                    }
                    _loc_1++;
                }
                if (this._aMiraclePlayer.length > 0 && !this.PositionCharaAnimation.isPlaying)
                {
                    _loc_3 = true;
                    for each (_loc_4 in this._aMiraclePlayer)
                    {
                        
                        if (_loc_4.LabelEnd != true)
                        {
                            _loc_3 = false;
                        }
                    }
                    if (_loc_3 == true)
                    {
                        setPhase(_PHASE_LEAVE);
                    }
                }
            }
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_5 = 0;
                while (_loc_5 < this._aMiraclePlayer.length)
                {
                    
                    _loc_6 = this._aMiraclePlayer[_loc_5];
                    if (_loc_6.LabelHit && _loc_6.HitEffectAdded == false)
                    {
                        this.PositionCharaAnimation.stop();
                        _loc_6.HitEffectAdded = true;
                    }
                    _loc_5++;
                }
                if (this._aMiraclePlayer.length > 0 && !this.PositionCharaAnimation.isPlaying)
                {
                    _loc_7 = true;
                    for each (_loc_8 in this._aMiraclePlayer)
                    {
                        
                        if (_loc_8.LabelEnd != true)
                        {
                            _loc_7 = false;
                        }
                    }
                    if (_loc_7 == true)
                    {
                        setPhase(_PHASE_LEAVE);
                    }
                }
            }
            return;
        }// end function

        private function playDam(param1:BattleActionBase) : void
        {
            playDamage(param1);
            return;
        }// end function

        override protected function phaseLeave() : void
        {
            this.PositionCharaAnimation.gotoAndPlay("in");
            return;
        }// end function

        override protected function controlLeave() : void
        {
            if (this.PositionCharaAnimation.currentLabel == "end")
            {
                setPhase(_PHASE_END);
            }
            return;
        }// end function

        override protected function phaseEnd() : void
        {
            this.PositionCharaAnimation.visible = false;
            super.phaseEnd();
            return;
        }// end function

        override protected function controlEnd() : void
        {
            super.controlEnd();
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.SKILL_PATH + "Skill_Sword_MirageBlade.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_REV_SWORD_TSUMUJIKAZE_HIT, SoundId.SE_RS3_OLD_EMILUNE];
            return _loc_1;
        }// end function

    }
}

import battle.*;

import character.*;

import effect.*;

import enemy.*;

import flash.display.*;

import layer.*;

import player.*;

import resource.*;

import sound.*;

class MiragePlayer extends Object
{
    public var MobIn:MovieClip;
    public var playerDisplay:PlayerDisplay;
    private var timer:int;
    private var MobInDifTime:int;
    private var _ATTACK_MOTION_PATH:String;
    private var _layer:LayerBattle;
    public var LabelHit:Boolean;
    public var LabelEnd:Boolean;
    public var HitEffectAdded:Boolean;
    private var effectMc:EffectMc;
    private var weaponMc:MovieClip;

    function MiragePlayer(param1:LayerBattle, param2:CharacterDisplayBase, param3:String, param4:BattleActionBase, param5:Boolean, param6:Class, param7:Function, param8:int)
    {
        var SoundPlayed:Boolean;
        var startJump:Function;
        var effectcontrol:Function;
        var layer:* = param1;
        var _skillUserDisplay:* = param2;
        var ATTACK_MOTION_PATH:* = param3;
        var target:* = param4;
        var _bReverse:* = param5;
        var soundmanager:* = param6;
        var damageFunc:* = param7;
        var MobInDifTime:* = param8;
        startJump = function (event:Event) : void
        {
            if (MobInDifTime == timer)
            {
                MobIn.gotoAndPlay("start");
                MobIn.charaNull.gotoAndPlay("start");
            }
            if (MobIn.isPlaying)
            {
                switch(MobIn.currentLabel)
                {
                    case "hit":
                    {
                        LabelHit = true;
                        if (HitEffectAdded == false)
                        {
                            effectMc = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, "hit_front", target.characterDisplay.pos, _bReverse);
                            HitEffectAdded = true;
                            effectMc.mcEffect.addEventListener(Event.ENTER_FRAME, effectcontrol);
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            var _loc_3:* = timer + 1;
            timer = _loc_3;
            return;
        }// end function
        ;
        effectcontrol = function (event:Event) : void
        {
            switch(effectMc.mcEffect.currentLabel)
            {
                case "damageLast":
                {
                    if (SoundPlayed == false)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_SWORD_TSUMUJIKAZE_HIT);
                        damageFunc(target);
                        SoundPlayed = true;
                    }
                    ;
                }
                case "end":
                {
                    LabelEnd = true;
                    effectMc.mcEffect.removeEventListener(Event.ENTER_FRAME, effectcontrol);
                    if (MobIn != null && MobIn.parent != null)
                    {
                        MobIn.removeEventListener(Event.ENTER_FRAME, startJump);
                        MobIn.parent.removeChild(MobIn);
                    }
                    MobIn = null;
                    if (playerDisplay != null)
                    {
                        playerDisplay.release();
                    }
                    if (weaponMc != null)
                    {
                        weaponMc = null;
                    }
                }
                default:
                {
                    ;
                }
            }
            return;
        }// end function
        ;
        this._ATTACK_MOTION_PATH = ATTACK_MOTION_PATH;
        this._layer = layer;
        this.LabelHit = false;
        this.LabelEnd = false;
        this.HitEffectAdded = false;
        this.effectMc = null;
        var pDisplay:* = _skillUserDisplay as PlayerDisplay;
        var playerId:* = pDisplay.info.id;
        this.MobIn = ResourceManager.getInstance().createMovieClip(this._ATTACK_MOTION_PATH, "advance_chara_act") as MovieClip;
        this.weaponMc = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Weapons.swf", "weapon_Sword1");
        this.MobIn.charaNull.weaponNull.addChild(this.weaponMc);
        this.playerDisplay = new PlayerDisplay(this._layer.getLayer(LayerBattle.CHARACTER), playerId, Constant.EMPTY_ID);
        this.playerDisplay.pos = target.characterDisplay.pos;
        this.MobIn.x = this.MobIn.x + target.characterDisplay.pos.x;
        this.MobIn.y = this.MobIn.y + target.characterDisplay.pos.y;
        this.playerDisplay.setAnimationPattern(this.MobIn.charaNull);
        this._layer.getLayer(LayerBattle.CHARACTER).addChild(this.MobIn);
        this.MobIn.addEventListener(Event.ENTER_FRAME, startJump);
        SoundPlayed;
        return;
    }// end function

    public function release() : void
    {
        return;
    }// end function

}


import battle.*;

import character.*;

import effect.*;

import enemy.*;

import flash.display.*;

import layer.*;

import player.*;

import resource.*;

import sound.*;

class MirageEnemy extends Object
{
    public var MobIn:MovieClip;
    public var playerDisplay:EnemyDisplay;
    private var timer:int;
    private var MobInDifTime:int;
    private var _ATTACK_MOTION_PATH:String;
    private var _layer:LayerBattle;
    public var LabelHit:Boolean;
    public var LabelEnd:Boolean;
    public var HitEffectAdded:Boolean;
    private var effectMc:EffectMc;
    private var weaponMc:MovieClip;

    function MirageEnemy(param1:LayerBattle, param2:CharacterDisplayBase, param3:String, param4:BattleActionBase, param5:Boolean, param6:Class, param7:Function, param8:int)
    {
        var SoundPlayed:Boolean;
        var startJump:Function;
        var effectcontrol:Function;
        var layer:* = param1;
        var _skillUserDisplay:* = param2;
        var ATTACK_MOTION_PATH:* = param3;
        var target:* = param4;
        var _bReverse:* = param5;
        var soundmanager:* = param6;
        var damageFunc:* = param7;
        var MobInDifTime:* = param8;
        startJump = function (event:Event) : void
        {
            if (MobInDifTime == timer)
            {
                MobIn.gotoAndPlay("start");
                MobIn.charaNull.gotoAndPlay("start");
            }
            if (MobIn != null && MobIn.isPlaying)
            {
                switch(MobIn.currentLabel)
                {
                    case "hit":
                    {
                        LabelHit = true;
                        if (HitEffectAdded == false)
                        {
                            effectMc = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, "hit_front", target.characterDisplay.pos, _bReverse);
                            HitEffectAdded = true;
                            effectMc.mcEffect.addEventListener(Event.ENTER_FRAME, effectcontrol);
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            var _loc_3:* = timer + 1;
            timer = _loc_3;
            return;
        }// end function
        ;
        effectcontrol = function (event:Event) : void
        {
            switch(effectMc.mcEffect.currentLabel)
            {
                case "damageLast":
                {
                    if (SoundPlayed == false)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_SWORD_TSUMUJIKAZE_HIT);
                        damageFunc(target);
                        SoundPlayed = true;
                    }
                    ;
                }
                case "end":
                {
                    LabelEnd = true;
                    effectMc.mcEffect.removeEventListener(Event.ENTER_FRAME, effectcontrol);
                    if (MobIn != null && MobIn.parent != null)
                    {
                        MobIn.removeEventListener(Event.ENTER_FRAME, startJump);
                        MobIn.parent.removeChild(MobIn);
                    }
                    MobIn = null;
                }
                default:
                {
                    ;
                }
            }
            return;
        }// end function
        ;
        this._ATTACK_MOTION_PATH = ATTACK_MOTION_PATH;
        this._layer = layer;
        this.LabelHit = false;
        this.LabelEnd = false;
        this.HitEffectAdded = false;
        this.effectMc = null;
        var pDisplay:* = _skillUserDisplay as EnemyDisplay;
        var playerId:* = pDisplay.info.id;
        this.MobIn = ResourceManager.getInstance().createMovieClip(this._ATTACK_MOTION_PATH, "advance_chara_act") as MovieClip;
        this.weaponMc = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Weapons.swf", "weapon_Sword1");
        this.MobIn.x = this.MobIn.x + target.characterDisplay.pos.x;
        this.MobIn.y = this.MobIn.y + target.characterDisplay.pos.y;
        this.MobIn.addEventListener(Event.ENTER_FRAME, startJump);
        SoundPlayed;
        return;
    }// end function

    public function release() : void
    {
        return;
    }// end function

}

