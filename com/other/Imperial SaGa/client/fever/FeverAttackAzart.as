package fever
{
    import battle.*;
    import effect.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import layer.*;
    import player.*;
    import resource.*;
    import skill.*;
    import sound.*;
    import utility.*;

    public class FeverAttackAzart extends FeverAttackBase
    {
        private const _PHASE_TIMELINE_START:int = 3;
        private const _PHASE_JUMP_START:int = 1;
        private const _PHASE_PRAY:int = 2;
        private const _PHASE_MOB_IN:int = 10;
        private const _PHASE_END:int = 99;
        private var _aArcher:Array;
        private var _phase:int;
        private var _effectManager:EffectManager;
        private var _aBaseMc:Array;
        private var _aAttackMc:Array;
        private var _aMobMc:Array;
        private var _aMobInMC:Array;
        private var _aMobCharaPosition:Array;
        private var _aMobStayMC:Array;
        private var _aPT_chara:Array;
        private var LT_chara:MovieClip;
        private var _aAttackableChara:Array;
        private const _HIDE_INTERVAL:Number = 0.5;
        private var _hideTimer:Number;
        private var _preAttackMc:MovieClip;
        private var _timelineMC:MovieClip;
        private var _effectMc:EffectMc;
        private var pt_effect:MovieClip;
        private var _aFormationCharaDisplay:Array;
        private var _ATTACK_INTERVAL:Number = 0.15;
        private var _attackTimer:Number;
        private var _aWaitUnit:Array;
        private var _bHitMotion:Boolean;
        private var _playerFomationRect:Rectangle;
        private var _aBullet:Array;
        private var _aBulletMC:Array;
        private var _aEntryPlayer:Array;
        private const _PRE_ATTACK_FOMATION_INDEX:int = 3;
        private const _PRE_ATTACK_WAIT:Number = 0.5;
        private const _BULLET_SPEED:int = 650;
        private var _bFinish:Boolean;
        private var _abFinish:Array;
        private var Shake1:EffectShake;
        private var ShakeBg1:EffectShake;
        private var Shake2:EffectShake;
        private var ShakeBg2:EffectShake;
        private var Shake3:EffectShake;
        private var ShakeBg3:EffectShake;
        private var StopMagic:Boolean;
        private var T:Number;
        public var controlT:Number;
        private var FevercbHit:Function;
        private var _isMobSePlay:Boolean = false;
        private var _mobInSe2Timer:Number = 0;
        private var _isMobHitSePlay:Boolean = false;
        private var effectMc:EffectBase;
        private var _aNullMc:Array;
        private var _formationActMc:MovieClip;
        private var _aCharaPriority:Array;
        public static const _ATTACK_MOTION_PATH:String = ResourcePath.CHARGE_EFFECT_PATH + "ChargeEffect_Other.swf";
        private static const _FORMATION_POSITION_PATH:String = ResourcePath.BATTLE_PATH + "UI_BattleMain.swf";
        public static const MOBIN_SEPLAY_INTERVAL:Number = 0.3;
        public static var _isMobChantSePlay:Boolean = false;
        public static var _hitSeSmallPlayNum:int = 0;
        public static var _hitSeBigPlayNum:int = 0;

        public function FeverAttackAzart(param1:LayerBattle, param2:BattleManager, param3:Array, param4:Function)
        {
            var _loc_6:* = null;
            this._aWaitUnit = [];
            this._aCharaPriority = [];
            super(param1, param2, param3, param4);
            this.FevercbHit = sendHit;
            this._effectManager = new EffectManager();
            this._aFormationCharaDisplay = [];
            this.StopMagic = false;
            var _loc_5:* = _battleManager.getEntryPlayer();
            for each (_loc_6 in _loc_5)
            {
                
                _loc_6.characterAction.characterDisplay.backupParent();
            }
            this._aAttackableChara = [];
            this._aBaseMc = [];
            this._aAttackMc = [];
            this._aMobMc = [];
            this._aMobInMC = [];
            this._aMobCharaPosition = [];
            this._aMobStayMC = [];
            this._aPT_chara = [];
            this._aBulletMC = [];
            this._abFinish = [];
            this._aWaitUnit = [];
            this._aWaitUnit = Random.shuffleArray(_aSupportPlayerId);
            this._aEntryPlayer = _battleManager.getEntryPlayer();
            this.LT_chara = new MovieClip();
            this._isMobSePlay = false;
            this._mobInSe2Timer = 0;
            this._isMobHitSePlay = false;
            _isMobChantSePlay = false;
            _hitSeSmallPlayNum = 0;
            _hitSeBigPlayNum = 0;
            this.setPhase(this._PHASE_TIMELINE_START);
            return;
        }// end function

        override public function release() : void
        {
            this._aWaitUnit = null;
            this._aAttackableChara = null;
            this._aAttackMc = null;
            this._aBaseMc = null;
            _aSupportPlayerId = null;
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._effectManager.control(param1);
            if (this._timelineMC.currentFrameLabel == "PT_move01")
            {
                this.setPhase(this._PHASE_JUMP_START);
            }
            if (this._timelineMC.currentFrameLabel == "PT_loop")
            {
                this.startPTloop();
            }
            if (this._timelineMC.currentFrameLabel == "MOB_In")
            {
                this.setPhase(this._PHASE_MOB_IN);
            }
            if (this._timelineMC.currentFrameLabel == "MOB_out")
            {
                for each (_loc_2 in this._aMobStayMC)
                {
                    
                    if (_loc_2.parent)
                    {
                        _loc_2.parent.removeChild(_loc_2);
                    }
                    _loc_2 = null;
                }
                this._aMobStayMC = [];
                _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[1]);
                _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[3]);
                _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[0]);
                _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[2]);
                _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[4]);
            }
            if (this._timelineMC.currentFrameLabel == "PT_move02")
            {
                for each (_loc_3 in this._aBaseMc)
                {
                    
                    if (_loc_3.parent)
                    {
                        _loc_3.parent.removeChild(_loc_3);
                    }
                    _loc_3 = null;
                }
                this._aBaseMc = [];
                this.setPhase(this._PHASE_END);
            }
            if (this._timelineMC.currentFrameLabel == "Tornado_Start")
            {
                this.effectHit_front_Tornado();
            }
            if (this._timelineMC.currentFrameLabel == "hellfire_start")
            {
                this.effectHit_grand_HellFire();
            }
            if (this._timelineMC.currentFrameLabel == "StoneShower_Start01")
            {
                this.effectHit_grand_StoneShower();
            }
            if (this._timelineMC.currentFrameLabel == "StoneShower_Start02")
            {
                this.effectHit_grand_StoneShower();
            }
            if (this._timelineMC.currentFrameLabel == "StoneShower_Start03")
            {
                this.effectHit_grand_StoneShower();
            }
            if (this._timelineMC.currentFrameLabel == "shake_start01")
            {
                this.Shake1 = this.effectEfect_Shake();
                this.ShakeBg1 = this.effectShakeBg();
            }
            if (this._timelineMC.currentFrameLabel == "shake_end01")
            {
                this._effectManager.releaseEffect(this.Shake1);
                this._effectManager.releaseEffect(this.ShakeBg1);
            }
            if (this._timelineMC.currentFrameLabel == "shake_start02")
            {
                this.Shake2 = this.effectEfect_Shake();
                this.ShakeBg2 = this.effectShakeBg();
            }
            if (this._timelineMC.currentFrameLabel == "shake_end02")
            {
                this._effectManager.releaseEffect(this.Shake2);
                this._effectManager.releaseEffect(this.ShakeBg2);
            }
            if (this._timelineMC.currentFrameLabel == "shake_start03")
            {
                this.Shake3 = this.effectEfect_Shake();
                this.ShakeBg3 = this.effectShakeBg();
            }
            if (this._timelineMC.currentFrameLabel == "shake_end03")
            {
                this._effectManager.releaseEffect(this.Shake3);
                this._effectManager.releaseEffect(this.ShakeBg3);
            }
            if (this._timelineMC.currentFrameLabel == "lightning_start01")
            {
                this.effectHit_grand_Lightning();
            }
            if (this._timelineMC.currentFrameLabel == "lightning_start02")
            {
                this.effectHit_grand_Lightning();
            }
            if (this._timelineMC.currentFrameLabel == "lightning_start03")
            {
                this.effectHit_grand_Lightning();
            }
            if (this._timelineMC.currentFrameLabel == "PT_skill_start")
            {
                this.effectPt_effect();
            }
            if (this._timelineMC.currentFrameLabel == "PT_effect_end")
            {
                this.pt_effect.gotoAndPlay("out");
            }
            if (this._timelineMC.currentFrameLabel == "PT_pause_start")
            {
            }
            if (this._timelineMC.currentFrameLabel == "PT_skill_effect_Start")
            {
                this.effectFormation_hit_grand();
            }
            if (this._timelineMC.currentFrameLabel == "PT_pause_start")
            {
                for each (_loc_4 in this._aBaseMc)
                {
                    
                    _loc_4.gotoAndPlay("pause");
                }
            }
            if (this._timelineMC.currentFrameLabel == "LD_start")
            {
                this.startLT();
            }
            if (this._timelineMC.currentFrameLabel == "LD_skill_start")
            {
                if (this.LT_chara !== null)
                {
                    this.LT_chara.gotoAndPlay("skill");
                }
            }
            if (this._timelineMC.currentFrameLabel == "MOB_skill_end")
            {
                this.StopMagic = true;
            }
            switch(this._phase)
            {
                case this._PHASE_TIMELINE_START:
                {
                    this.controlTimeLineStart();
                    break;
                }
                case this._PHASE_JUMP_START:
                {
                    this.controlJumpStart();
                    break;
                }
                case this._PHASE_MOB_IN:
                {
                    this.controlMobIn(param1);
                    break;
                }
                case this._PHASE_END:
                {
                    this.controlEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_TIMELINE_START:
                    {
                        this.phaseTimeLineStart();
                        break;
                    }
                    case this._PHASE_JUMP_START:
                    {
                        this.phaseJumpStart();
                        break;
                    }
                    case this._PHASE_PRAY:
                    {
                        this.phasePray();
                        break;
                    }
                    case this._PHASE_MOB_IN:
                    {
                        this.phaseMobIn();
                        break;
                    }
                    case this._PHASE_END:
                    {
                        this.phaseEnd();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseTimeLineStart() : void
        {
            var bg:MovieClip;
            var listener:Function;
            listener = function (event:Event) : void
            {
                var _loc_2:* = MovieClip(event.target);
                bg.transform.colorTransform = _loc_2.bgColorMc.transform.colorTransform;
                if (_loc_2.currentFrame >= _loc_2.totalFrames)
                {
                    _loc_2.removeEventListener(Event.ENTER_FRAME, listener);
                }
                return;
            }// end function
            ;
            this._timelineMC = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "TimeLine");
            this.effectMc = new EffectBase(_layer.getLayer(LayerBattle.BACK_EFFECT), this._timelineMC, new Point(0, 0));
            this._timelineMC.gotoAndPlay("start");
            this.effectMc.mcEffect.addEventListener(Event.ENTER_FRAME, listener);
            bg = _battleManager.battleScreen.getChildAt(0) as MovieClip;
            return;
        }// end function

        private function controlTimeLineStart() : void
        {
            return;
        }// end function

        private function phaseJumpStart() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = ResourceManager.getInstance().createMovieClip(_FORMATION_POSITION_PATH, "BattleMainMc");
            var _loc_2:* = _loc_1.allMoveMc.formationCaraNull;
            this._playerFomationRect = new Rectangle(_loc_2.x, _loc_2.y, _loc_2.width, _loc_2.height);
            this._formationActMc = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "advance_formation_act");
            this._formationActMc.x = this._formationActMc.x + this._playerFomationRect.x;
            this._formationActMc.y = this._formationActMc.y + this._playerFomationRect.y;
            this._aNullMc = [this._formationActMc.charaNull1, this._formationActMc.charaNull2, this._formationActMc.charaNull3, this._formationActMc.charaNull4, this._formationActMc.charaNull5];
            var _loc_3:* = _battleManager.getEntryPlayer();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4].characterAction.characterDisplay as PlayerDisplay;
                _loc_6 = this._aNullMc[_loc_4];
                _loc_5.setAnimation(PlayerDisplay.LABEL_JUMP);
                _loc_5.setTargetPoint(_loc_6.localToGlobal(new Point()), 0);
                _loc_6.gotoAndStop("stop");
                this._aBaseMc.push(_loc_6);
                _loc_4++;
            }
            SoundManager.getInstance().playSe(SoundId.SE_JUMP1);
            return;
        }// end function

        private function controlJumpStart() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = true;
            if (bMoveing() == false)
            {
                for each (_loc_2 in this._aBaseMc)
                {
                    
                    switch(_loc_2.currentFrameLabel)
                    {
                        case "stop":
                        {
                            _loc_2.parent.removeChild(_loc_2);
                            break;
                        }
                        default:
                        {
                            _loc_1 = false;
                            break;
                            break;
                        }
                    }
                }
                if (_loc_1)
                {
                    this._aBaseMc = [];
                    this.setPhase(this._PHASE_PRAY);
                }
            }
            return;
        }// end function

        private function phasePray() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this._aBaseMc = [];
            var _loc_1:* = _battleManager.getEntryPlayer();
            var _loc_2:* = 1;
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(_FORMATION_POSITION_PATH, "BattleMainMc");
            var _loc_4:* = _loc_3.allMoveMc.formationCaraNull;
            this._playerFomationRect = new Rectangle(_loc_4.x, _loc_4.y, _loc_4.width, _loc_4.height);
            var _loc_5:* = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "advance_formation_act");
            ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "advance_formation_act").x = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "advance_formation_act").x + this._playerFomationRect.x;
            _loc_5.y = _loc_5.y + this._playerFomationRect.y;
            for each (_loc_6 in _loc_1)
            {
                
                _loc_7 = _loc_5.getChildByName("charaNull" + _loc_2) as MovieClip;
                (_loc_5.getChildByName("charaNull" + _loc_2) as MovieClip).x = _loc_7.x + this._formationActMc.x;
                _loc_7.y = _loc_7.y + this._formationActMc.y;
                _loc_8 = new Point(_loc_7.x, _loc_7.y);
                _loc_6.characterAction.characterDisplay.pos = _loc_8.clone();
                _loc_9 = _loc_6.characterAction.characterDisplay as PlayerDisplay;
                _loc_9.setAnimationPattern(_loc_7);
                _loc_6.setPosition(_loc_8);
                if (_loc_7.weaponNull)
                {
                    _loc_10 = ResourceManager.getInstance().createMovieClip(_WEAPON_PATH, SkillManager.getInstance().getWeaponClassNameFromSkillType(SkillConstant.SKILL_TYPE_AX));
                    _loc_10.gotoAndStop(1);
                    _loc_7.weaponNull.addChild(_loc_10);
                }
                if (_loc_6 == _loc_1[0])
                {
                    this.LT_chara = _loc_7;
                    this._aBaseMc.push(_loc_7);
                }
                if (_loc_6 != _loc_1[0])
                {
                    this._aPT_chara.push(_loc_7);
                    this._aBaseMc.push(_loc_7);
                }
                _loc_2++;
            }
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[2]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[4]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[0]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[1]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[3]);
            this._hideTimer = this._HIDE_INTERVAL;
            return;
        }// end function

        private function controlPray(param1:Number) : void
        {
            return;
        }// end function

        private function startPTloop() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBaseMc)
            {
                
                _loc_1.gotoAndPlay("loop");
            }
            return;
        }// end function

        private function PT_pause_start() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBaseMc)
            {
                
                _loc_1.gotoAndPlay("pause");
            }
            return;
        }// end function

        private function startLT() : void
        {
            if (this.LT_chara !== null)
            {
                this.LT_chara.gotoAndPlay("start");
            }
            return;
        }// end function

        private function PT_skill_start() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPT_chara)
            {
                
                _loc_1.gotoAndPlay("skill");
            }
            return;
        }// end function

        private function phaseMobIn() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = 1;
            while (_loc_1 <= 9)
            {
                
                _loc_4 = new MobInPlayer(_loc_1, _layer, this._formationActMc, this._aWaitUnit, _ATTACK_MOTION_PATH, this.StopMagic, _targetPosition, this._effectManager, this._timelineMC, _targetDisplay, this.FevercbHit, this._aCharaPriority);
                this._aMobMc.push(_loc_4);
                this._aCharaPriority.push(_loc_4.MobIn);
                _loc_1++;
            }
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[1]);
            this._aCharaPriority.push(this._aBaseMc[1]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[3]);
            this._aCharaPriority.push(this._aBaseMc[3]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[0]);
            this._aCharaPriority.push(this._aBaseMc[0]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[2]);
            this._aCharaPriority.push(this._aBaseMc[2]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[4]);
            this._aCharaPriority.push(this._aBaseMc[4]);
            var _loc_2:* = 10;
            while (_loc_2 <= 18)
            {
                
                _loc_5 = new MobInPlayer(_loc_2, _layer, this._formationActMc, this._aWaitUnit, _ATTACK_MOTION_PATH, this.StopMagic, _targetPosition, this._effectManager, this._timelineMC, _targetDisplay, this.FevercbHit, this._aCharaPriority);
                this._aMobMc.push(_loc_5);
                this._aCharaPriority.push(_loc_5.MobIn);
                _loc_2++;
            }
            for each (_loc_3 in this._aCharaPriority)
            {
                
                for each (_loc_6 in this._aCharaPriority)
                {
                    
                    if (_loc_3 != null && _loc_6 != null && _loc_3.parent != null && _loc_6.parent != null)
                    {
                        if (_loc_3.y < _loc_6.y && _loc_3.parent.getChildIndex(_loc_3) > _loc_6.parent.getChildIndex(_loc_6))
                        {
                            _loc_7 = _loc_3.parent as Sprite;
                            _loc_7.swapChildren(_loc_3, _loc_6);
                        }
                    }
                }
            }
            SoundManager.getInstance().playSe(SoundId.SE_JUMP2);
            this._mobInSe2Timer = MOBIN_SEPLAY_INTERVAL;
            return;
        }// end function

        private function controlMobIn(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._isMobSePlay == false)
            {
                if (this._mobInSe2Timer > 0)
                {
                    this._mobInSe2Timer = this._mobInSe2Timer - param1;
                }
                else
                {
                    SoundManager.getInstance().playSe(SoundId.SE_JUMP1);
                    this._isMobSePlay = true;
                }
            }
            if (this._isMobHitSePlay == false)
            {
                for each (_loc_2 in this._aMobMc)
                {
                    
                    if (_loc_2.phase == MobInPlayer.PHASE_MAGIC_START && this._isMobHitSePlay == false)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_FEVER_GEN_MOB_HIT);
                        this._isMobHitSePlay = true;
                    }
                }
            }
            if (this._aMobMc != null && this._aMobMc.length > 0)
            {
                for each (_loc_3 in this._aMobMc)
                {
                    
                    if (_loc_3.fireball != null)
                    {
                        _loc_3.fireball.controlFinishShotMove(param1);
                    }
                    if (_loc_3.watergun != null)
                    {
                        _loc_3.watergun.controlFinishShotMove(param1);
                    }
                }
            }
            return;
        }// end function

        private function phaseJumpOut() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_1:* = _battleManager.getEntryPlayer();
            for each (_loc_2 in _loc_1)
            {
                
                _loc_6 = _loc_2.characterAction.characterDisplay as PlayerDisplay;
                (_loc_2.characterAction.characterDisplay as PlayerDisplay).setTargetJump(_loc_6.backupPosition);
            }
            _loc_3 = ResourceManager.getInstance().createMovieClip(_FORMATION_POSITION_PATH, "BattleMainMc");
            _loc_4 = _loc_3.allMoveMc.formationCaraNull;
            this._playerFomationRect = new Rectangle(_loc_4.x, _loc_4.y, _loc_4.width, _loc_4.height);
            this._formationActMc = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "advance_formation_act");
            this._formationActMc.x = this._formationActMc.x + this._playerFomationRect.x;
            this._formationActMc.y = this._formationActMc.y + this._playerFomationRect.y;
            this._aNullMc = [this._formationActMc.charaNull1, this._formationActMc.charaNull2, this._formationActMc.charaNull3, this._formationActMc.charaNull4, this._formationActMc.charaNull5];
            _loc_5 = 0;
            while (_loc_5 < _loc_1.length)
            {
                
                _loc_7 = _loc_1[_loc_5].characterAction.characterDisplay as PlayerDisplay;
                _loc_8 = this._aNullMc[_loc_5];
                _loc_7.setAnimation(PlayerDisplay.LABEL_JUMP);
                _loc_7.setTargetPoint(_loc_8.localToGlobal(new Point()), 0);
                _loc_8.gotoAndStop("stop");
                this._aBaseMc.push(_loc_8);
                _loc_5++;
            }
            return;
        }// end function

        private function controlJumpOut() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = true;
            if (bMoveing() == false)
            {
                for each (_loc_2 in this._aBaseMc)
                {
                    
                    switch(_loc_2.currentFrameLabel)
                    {
                        case "stop":
                        {
                            _loc_2.parent.removeChild(_loc_2);
                            break;
                        }
                        default:
                        {
                            _loc_1 = false;
                            break;
                            break;
                        }
                    }
                }
                if (_loc_1)
                {
                    this._aBaseMc = [];
                    this.setPhase(this._PHASE_PRAY);
                }
            }
            return;
        }// end function

        private function phaseMobOut() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[1]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[3]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[0]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[2]);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._aBaseMc[4]);
            for each (_loc_1 in this._aMobStayMC)
            {
                
                _loc_1.parent.removeChild(_loc_1);
                _loc_1 = null;
            }
            this._aMobStayMC = [];
            this._aMobCharaPosition = [];
            for each (_loc_2 in this._aFormationCharaDisplay)
            {
                
                _loc_3 = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "Mob_Out") as MovieClip;
                _loc_3.x = _loc_3.x + (this._formationActMc.x + _loc_2.pos.x);
                _loc_3.y = _loc_3.y + (this._formationActMc.y + _loc_2.pos.y);
                _loc_2.setAnimSideDash();
                _loc_2.setAnimationPattern(_loc_3);
                _loc_2.setTargetPoint(new Point(Math.round(Math.random() * 500), Math.round(Math.random() * 500)), 1.5);
                _layer.getLayer(LayerBattle.CHARACTER).addChild(_loc_3);
                _loc_3.gotoAndPlay("start");
                this._aBaseMc.push(_loc_3);
            }
            return;
        }// end function

        private function controlMobOut() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aBaseMc)
            {
                
                switch(_loc_2.currentFrameLabel)
                {
                    case "end":
                    {
                        _loc_1++;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (_loc_1 >= this._aBaseMc.length)
            {
                if (this._hideTimer > 0)
                {
                }
                else
                {
                    for each (_loc_3 in this._aBaseMc)
                    {
                        
                        if (_loc_3.parent)
                        {
                            _loc_3.parent.removeChild(_loc_3);
                        }
                        _loc_3 = null;
                    }
                    this._aBaseMc = [];
                }
            }
            return;
        }// end function

        private function phaseEnd() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = _battleManager.getEntryPlayer();
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = _loc_2.characterAction.characterDisplay as PlayerDisplay;
                _loc_3.setTargetJump(_loc_3.backupPosition);
            }
            SoundManager.getInstance().playSe(SoundId.SE_JUMP1);
            return;
        }// end function

        private function controlEnd() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = true;
            var _loc_2:* = _battleManager.getEntryPlayer();
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = _loc_3.characterAction.characterDisplay as PlayerDisplay;
                if (_loc_4.bMoveing)
                {
                    _loc_1 = false;
                }
            }
            if (_loc_1)
            {
                _bEnd = true;
            }
            return;
        }// end function

        private function effectHit_grand_Lightning() : void
        {
            var randomLightningPath:String;
            var _effectLightning:EffectMc;
            var frameListener:Function;
            frameListener = function (event:Event) : void
            {
                var _loc_2:* = MovieClip(event.target);
                if (_loc_2.currentFrameLabel == "damage")
                {
                    sendHit();
                    playHitSe(SoundId.SE_REV_FEVER_GEN_BIG_THUNDER);
                }
                if (_loc_2.currentFrameLabel == "damageLast")
                {
                    sendHit();
                    _effectLightning.mcEffect.removeEventListener(Event.ENTER_FRAME, frameListener);
                }
                return;
            }// end function
            ;
            var randomLightning:* = Random.range(1, 2);
            switch(randomLightning)
            {
                case 1:
                {
                    randomLightningPath;
                    break;
                }
                case 2:
                {
                    randomLightningPath;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _effectLightning = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, randomLightningPath, _targetDisplay.pos, false);
            this._effectManager.addEffect(_effectLightning);
            _effectLightning.mcEffect.gotoAndPlay("start");
            _effectLightning.mcEffect.addEventListener(Event.ENTER_FRAME, frameListener);
            return;
        }// end function

        private function effectHit_grand_StoneShower() : void
        {
            var _effectStoneShower:EffectMc;
            var frameListener:Function;
            frameListener = function (event:Event) : void
            {
                var _loc_2:* = MovieClip(event.target);
                if (_loc_2.currentFrameLabel == "damage")
                {
                    sendHit();
                    FeverAttackAzart.playHitSe(SoundId.SE_BATTLE_GROUND);
                }
                if (_loc_2.currentFrameLabel == "damageLast")
                {
                    sendHit();
                    _effectStoneShower.mcEffect.removeEventListener(Event.ENTER_FRAME, frameListener);
                }
                return;
            }// end function
            ;
            _effectStoneShower = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, "hit_grand_StoneShower", _targetPosition, false);
            this._effectManager.addEffect(_effectStoneShower);
            _effectStoneShower.mcEffect.gotoAndPlay("start");
            _effectStoneShower.mcEffect.addEventListener(Event.ENTER_FRAME, frameListener);
            return;
        }// end function

        private function effectHit_grand_HellFire() : void
        {
            var _effectStoneShower:EffectMc;
            var frameListener:Function;
            frameListener = function (event:Event) : void
            {
                var _loc_2:* = MovieClip(event.target);
                if (_loc_2.currentFrameLabel == "damage")
                {
                    sendHit();
                    FeverAttackAzart.playHitSe(SoundId.SE_REV_FEVER_GEN_BIG_FIRE);
                }
                if (_loc_2.currentFrameLabel == "damageLast")
                {
                    sendHit();
                    _effectStoneShower.mcEffect.removeEventListener(Event.ENTER_FRAME, frameListener);
                }
                return;
            }// end function
            ;
            _effectStoneShower = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, "hit_grand_HellFire", _targetDisplay.pos, false);
            this._effectManager.addEffect(_effectStoneShower);
            _effectStoneShower.mcEffect.gotoAndPlay("start");
            _effectStoneShower.mcEffect.addEventListener(Event.ENTER_FRAME, frameListener);
            return;
        }// end function

        private function effectHit_front_Tornado() : void
        {
            var _effectStoneShower:EffectMc;
            var frameListener:Function;
            frameListener = function (event:Event) : void
            {
                var _loc_2:* = MovieClip(event.target);
                if (_loc_2.currentFrameLabel == "damage")
                {
                    sendHit();
                    playHitSe(SoundId.SE_REV_FEVER_GEN_BIG_WIND);
                }
                if (_loc_2.currentFrameLabel == "damageLast")
                {
                    sendHit();
                    _effectStoneShower.mcEffect.removeEventListener(Event.ENTER_FRAME, frameListener);
                }
                return;
            }// end function
            ;
            _effectStoneShower = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, "hit_front_Tornado", _targetDisplay.pos, false);
            this._effectManager.addEffect(_effectStoneShower);
            _effectStoneShower.mcEffect.gotoAndPlay("start");
            _effectStoneShower.mcEffect.addEventListener(Event.ENTER_FRAME, frameListener);
            return;
        }// end function

        private function effectEfect_Shake() : EffectShake
        {
            var _loc_1:* = new EffectShake(_layer.parent, 6, 6, 10000);
            this._effectManager.addEffect(_loc_1);
            return _loc_1;
        }// end function

        private function effectShakeBg() : EffectShake
        {
            var _loc_1:* = new EffectShake(_battleManager.battleScreen, 6, 6, 10000);
            this._effectManager.addEffect(_loc_1);
            return _loc_1;
        }// end function

        private function effectPt_effect() : void
        {
            this.PT_skill_start();
            this.pt_effect = this._formationActMc.pt_effect;
            this.pt_effect.x = this._aEntryPlayer[0].characterAction.characterDisplay.pos.x;
            this.pt_effect.y = this._aEntryPlayer[0].characterAction.characterDisplay.pos.y;
            _layer.getLayer(LayerBattle.BACK_EFFECT).addChild(this.pt_effect);
            this.pt_effect.gotoAndPlay("start");
            SoundManager.getInstance().playSe(SoundId.SE_REV_FEVER_GEN_PARTY_CHANT);
            return;
        }// end function

        private function effectFormation_hit_grand() : void
        {
            var formation_hit_grand:EffectMc;
            var frameListener:Function;
            frameListener = function (event:Event) : void
            {
                var _loc_2:* = MovieClip(event.target);
                var _loc_3:* = _loc_2.localToGlobal(new Point(_loc_2.monsNull.x, _loc_2.monsNull.y));
                var _loc_4:* = _targetDisplay.info.bNotDamageMove;
                if (!_targetDisplay.info.bNotDamageMove)
                {
                    _targetDisplay.pos = new Point(_targetDisplay.pos.x, _loc_3.y);
                }
                if (_loc_2.currentFrameLabel == "damage")
                {
                    sendHit();
                }
                if (_loc_2.currentFrameLabel == "damageLast")
                {
                    sendHit();
                    formation_hit_grand.mcEffect.removeEventListener(Event.ENTER_FRAME, frameListener);
                }
                return;
            }// end function
            ;
            formation_hit_grand = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, "Formation_hit_grand", _targetDisplay.pos, false);
            this._effectManager.addEffect(formation_hit_grand);
            formation_hit_grand.mcEffect.addEventListener(Event.ENTER_FRAME, frameListener);
            formation_hit_grand.mcEffect.gotoAndPlay("start");
            SoundManager.getInstance().playSe(SoundId.SE_REV_FEVER_GEN_PARTY_HIT);
            return;
        }// end function

        private function BgEffect() : void
        {
            var oldColorTransform:ColorTransform;
            var newColorTransform:ColorTransform;
            var timerHandler:Function;
            var completeHandler:Function;
            timerHandler = function (event:TimerEvent) : void
            {
                if (_layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform == oldColorTransform)
                {
                    _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform = newColorTransform;
                }
                else
                {
                    _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform = oldColorTransform;
                }
                return;
            }// end function
            ;
            completeHandler = function (event:TimerEvent) : void
            {
                _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform = oldColorTransform;
                return;
            }// end function
            ;
            var delay:uint;
            var repeat:uint;
            var myTimer:* = new Timer(delay, repeat);
            oldColorTransform = _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform;
            newColorTransform = new ColorTransform(1, 1, 1, 1, 250, 250, 250, 250);
            myTimer.start();
            _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform = newColorTransform;
            myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
            myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
            return;
        }// end function

        protected function cbBgEffectControl(param1:EffectMc, param2:String, param3:Number) : void
        {
            if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren != Constant.EMPTY_ID)
            {
                _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform = param1.mcEffect.bgColorMc.transform.colorTransform;
            }
            else
            {
                _battleManager.battleScreen.getChildByName("bgMc").transform.colorTransform = param1.mcEffect.bgColorMc.transform.colorTransform;
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            _loc_1.push(_ATTACK_MOTION_PATH);
            _loc_1.push(_FORMATION_POSITION_PATH);
            _loc_1.push(FeverAttackBase._WEAPON_PATH);
            _loc_1.push(EffectFeverHit.getResourcePath());
            return _loc_1;
        }// end function

        public static function getSeId() : Array
        {
            var _loc_1:* = [SoundId.SE_BATTLE_FIRE, SoundId.SE_BATTLE_GROUND, SoundId.SE_BATTLE_WIND, SoundId.SE_JUMP1, SoundId.SE_JUMP2, SoundId.SE_REV_FEVER_GEN_BIG_FIRE, SoundId.SE_REV_FEVER_GEN_BIG_THUNDER, SoundId.SE_REV_FEVER_GEN_BIG_WATER, SoundId.SE_REV_FEVER_GEN_BIG_WIND, SoundId.SE_REV_FEVER_GEN_MOB_CHANT, SoundId.SE_REV_FEVER_GEN_MOB_HIT, SoundId.SE_REV_FEVER_GEN_PARTY_CHANT, SoundId.SE_REV_FEVER_GEN_PARTY_HIT, SoundId.SE_REV_WATER_GUN_HIT];
            _loc_1 = _loc_1.concat(EffectFeverHit.getSeId());
            return _loc_1;
        }// end function

        public static function playHitSe(param1:int) : void
        {
            switch(param1)
            {
                case SoundId.SE_REV_WATER_GUN_HIT:
                case SoundId.SE_BATTLE_GROUND:
                case SoundId.SE_BATTLE_WIND:
                {
                    if (_hitSeSmallPlayNum < 2)
                    {
                        var _loc_3:* = _hitSeSmallPlayNum + 1;
                        _hitSeSmallPlayNum = _loc_3;
                        SoundManager.getInstance().playSeCallBack(param1, cbHitSeSmallPlay);
                    }
                    break;
                }
                case SoundId.SE_REV_FEVER_GEN_BIG_FIRE:
                case SoundId.SE_REV_FEVER_GEN_BIG_WATER:
                case SoundId.SE_REV_FEVER_GEN_BIG_THUNDER:
                case SoundId.SE_REV_FEVER_GEN_BIG_WIND:
                {
                    if (_hitSeBigPlayNum < 1)
                    {
                        var _loc_3:* = _hitSeBigPlayNum + 1;
                        _hitSeBigPlayNum = _loc_3;
                        SoundManager.getInstance().playSeCallBack(param1, cbHitSeBigPlay);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function cbHitSeSmallPlay() : void
        {
            var _loc_2:* = _hitSeSmallPlayNum - 1;
            _hitSeSmallPlayNum = _loc_2;
            return;
        }// end function

        public static function cbHitSeBigPlay() : void
        {
            var _loc_2:* = _hitSeBigPlayNum - 1;
            _hitSeBigPlayNum = _loc_2;
            return;
        }// end function

    }
}

import battle.*;

import effect.*;

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.utils.*;

import layer.*;

import player.*;

import resource.*;

import skill.*;

import sound.*;

import utility.*;

class MobInPlayer extends Object
{
    private var _phase:int = 0;
    public var MobIn:MovieClip;
    public var Jumped:Boolean;
    public var MobInPoint:Point;
    public var fireball:FireBall;
    public var watergun:WaterGun;
    private var playerDisplay:PlayerDisplay;
    private var timer:int;
    private var MobInDifTime:int;
    private var _ATTACK_MOTION_PATH:String;
    private var _formationActMc:MovieClip;
    private var _layer:LayerBattle;
    private var attacMobBuild:Boolean = false;
    private var stopmagic:Boolean = false;
    private var stay:Boolean = false;
    private var wind:Boolean = false;
    private var _effectManager:EffectManager;
    private var _targetDisplay:EnemyDisplay;
    private var magic_type:int;
    private var sendHit:Function;
    private var ChildIndex:int;
    private var _isMobSePlay:Boolean = false;
    private var _mobInSe2Timer:Number = 0;
    public static const PHASE_MOB_IN_PREP:int = 0;
    public static const PHASE_MOB_IN:int = 1;
    public static const PHASE_MAGIC_START:int = 2;

    function MobInPlayer(param1:int, param2:LayerBattle, param3:MovieClip, param4:Array, param5:String, param6:Boolean, param7:Point, param8:EffectManager, param9:MovieClip, param10:EnemyDisplay, param11:Function, param12:Array)
    {
        var startJump:Function;
        var startMagic:Function;
        var i:* = param1;
        var layer:* = param2;
        var formationActMc:* = param3;
        var aSupportPlayerId:* = param4;
        var ATTACK_MOTION_PATH:* = param5;
        var StopMagic:* = param6;
        var _targetPosition:* = param7;
        var effectManager:* = param8;
        var _timelineMC:* = param9;
        var targetDisplay:* = param10;
        var cbHit:* = param11;
        var _aCharaPriority:* = param12;
        startJump = function (event:Event) : void
        {
            if (MobInDifTime == timer)
            {
                MobIn.gotoAndPlay("start");
                MobIn.addEventListener(Event.ENTER_FRAME, startMagic);
                _phase = PHASE_MOB_IN;
            }
            var _loc_3:* = timer + 1;
            timer = _loc_3;
            return;
        }// end function
        ;
        startMagic = function (event:Event) : void
        {
            var _loc_2:* = false;
            if (_timelineMC.currentFrameLabel == "MOB_skill_end")
            {
                stopmagic = true;
            }
            if (MobIn.currentFrameLabel == "end" && stopmagic == true && stay == false)
            {
                MobIn.gotoAndStop("stay");
                stay = true;
            }
            if (MobIn.isPlaying !== true && attacMobBuild == false)
            {
                ChildIndex = MobIn.parent.getChildIndex(MobIn);
                MobIn.parent.removeChild(MobIn);
                buildAttacMob();
                attacMobBuild = true;
                MobIn.gotoAndPlay("start");
            }
            if (MobIn.currentFrameLabel == "bullet" && stay == false)
            {
                _phase = PHASE_MAGIC_START;
                if (FeverAttackAzart._isMobChantSePlay == false)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_FEVER_GEN_MOB_CHANT);
                    FeverAttackAzart._isMobChantSePlay = true;
                }
                switch(magic_type)
                {
                    case 0:
                    {
                        break;
                    }
                    case 5:
                    {
                        watergun = new WaterGun(new Point(MobIn.x, MobIn.y), MobIn, _targetPosition, _layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, _effectManager, cbHit);
                        break;
                    }
                    case 10:
                    {
                        fireball = new FireBall(new Point(MobIn.x, MobIn.y), MobIn, _targetPosition, _layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, _effectManager, cbHit);
                        break;
                    }
                    case 11:
                    {
                        break;
                    }
                    case 12:
                    {
                        phaseHit_front_Wind();
                        break;
                    }
                    case 16:
                    {
                        break;
                    }
                    case 22:
                    {
                        break;
                    }
                    default:
                    {
                        fireball = new FireBall(new Point(MobIn.x, MobIn.y), MobIn, _targetPosition, _layer.getLayer(LayerBattle.FRONT_EFFECT), _ATTACK_MOTION_PATH, _effectManager, cbHit);
                        break;
                        break;
                    }
                }
            }
            if (MobIn.currentFrameLabel == "end" && stay == false)
            {
                if (!stopmagic)
                {
                    MobIn.gotoAndPlay("start");
                }
            }
            if (_timelineMC.currentFrameLabel == "MOB_out")
            {
                MobOut();
            }
            return;
        }// end function
        ;
        var buildAttacMob:* = function () : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            switch(magic_type)
            {
                case 0:
                {
                    MobIn = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_Fire") as MovieClip;
                    break;
                }
                case 5:
                {
                    MobIn = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_Water") as MovieClip;
                    break;
                }
                case 10:
                {
                    MobIn = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_Fire") as MovieClip;
                    break;
                }
                case 11:
                {
                    MobIn = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_Earth") as MovieClip;
                    break;
                }
                case 12:
                {
                    MobIn = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_Wind") as MovieClip;
                    break;
                }
                case 16:
                {
                    MobIn = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_Heaven") as MovieClip;
                    break;
                }
                case 22:
                {
                    MobIn = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_Hades") as MovieClip;
                    break;
                }
                default:
                {
                    MobIn = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "position_Fire") as MovieClip;
                    break;
                    break;
                }
            }
            playerDisplay.setAnimationPattern(MobIn);
            MobIn.x = MobIn.x + (_formationActMc.x + playerDisplay.pos.x);
            MobIn.y = MobIn.y + (_formationActMc.y + playerDisplay.pos.y);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(MobIn);
            _aCharaPriority.push(MobIn);
            Jumped = true;
            attacMobBuild = true;
            for each (_loc_1 in _aCharaPriority)
            {
                
                for each (_loc_2 in _aCharaPriority)
                {
                    
                    if (_loc_1 != null && _loc_2 != null && _loc_1.parent != null && _loc_2.parent != null)
                    {
                        if (_loc_1.y < _loc_2.y && _loc_1.parent.getChildIndex(_loc_1) > _loc_2.parent.getChildIndex(_loc_2))
                        {
                            _loc_3 = _loc_1.parent as Sprite;
                            _loc_3.swapChildren(_loc_1, _loc_2);
                        }
                    }
                }
            }
            return;
        }// end function
        ;
        var MobOut:* = function () : void
        {
            MobIn.parent.removeChild(MobIn);
            MobIn.removeEventListener(Event.ENTER_FRAME, startMagic);
            MobIn = ResourceManager.getInstance().createMovieClip(_ATTACK_MOTION_PATH, "Mob_Out");
            MobIn.x = MobIn.x + (_formationActMc.x + playerDisplay.pos.x);
            MobIn.y = MobIn.y + (_formationActMc.y + playerDisplay.pos.y);
            playerDisplay.setAnimSideDash();
            playerDisplay.setAnimationPattern(MobIn);
            playerDisplay.setTargetPoint(new Point(Math.round(Math.random() * 500), Math.round(Math.random() * 500)), 1.5);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(MobIn);
            MobIn.gotoAndPlay("start");
            return;
        }// end function
        ;
        this.sendHit = cbHit;
        this._ATTACK_MOTION_PATH = ATTACK_MOTION_PATH;
        this._formationActMc = formationActMc;
        this._layer = layer;
        this._effectManager = effectManager;
        this._targetDisplay = targetDisplay;
        var MobInPos:* = ResourceManager.getInstance().createMovieClip(this._ATTACK_MOTION_PATH, "advance_formation_act") as MovieClip;
        this.MobIn = ResourceManager.getInstance().createMovieClip(this._ATTACK_MOTION_PATH, "Mob_In") as MovieClip;
        this.Jumped = false;
        var MobCharaPosition:* = MobInPos.getChildByName("mob_Null" + i) as MovieClip;
        var playerId:* = aSupportPlayerId.pop();
        this.playerDisplay = new PlayerDisplay(this._layer.getLayer(LayerBattle.CHARACTER), playerId, Constant.EMPTY_ID);
        this.magic_type = this.playerDisplay.info.magicType;
        this.playerDisplay.pos = new Point(MobCharaPosition.x, MobCharaPosition.y);
        this.MobIn.x = this.MobIn.x + (this._formationActMc.x + MobCharaPosition.x);
        this.MobIn.y = this.MobIn.y + (this._formationActMc.y + MobCharaPosition.y);
        this.playerDisplay.setAnimSideDash();
        this.playerDisplay.setAnimationPattern(this.MobIn);
        aSupportPlayerId.unshift(playerId);
        this._layer.getLayer(LayerBattle.CHARACTER).addChild(this.MobIn);
        this.timer = 1;
        this.MobInDifTime = Random.range(1, 10);
        this.MobIn.addEventListener(Event.ENTER_FRAME, startJump);
        return;
    }// end function

    public function get phase() : int
    {
        return this._phase;
    }// end function

    private function phaseHit_front_Wind() : void
    {
        var _effectWind:EffectMc;
        var frameListener:Function;
        frameListener = function (event:Event) : void
        {
            var _loc_2:* = MovieClip(event.target);
            if (_loc_2.currentFrameLabel == "damage")
            {
                sendHit();
            }
            if (_loc_2.currentFrameLabel == "damageLast")
            {
                sendHit();
                _effectWind.mcEffect.removeEventListener(Event.ENTER_FRAME, frameListener);
            }
            return;
        }// end function
        ;
        var randomWind:* = Random.range(1, 4);
        if (randomWind == 1)
        {
            _effectWind = new EffectMc(this._layer.getLayer(LayerBattle.FRONT_EFFECT), this._ATTACK_MOTION_PATH, "hit_front_Wind00", this._targetDisplay.pos, false);
        }
        if (randomWind == 2)
        {
            _effectWind = new EffectMc(this._layer.getLayer(LayerBattle.FRONT_EFFECT), this._ATTACK_MOTION_PATH, "hit_front_Wind01", this._targetDisplay.pos, false);
        }
        if (randomWind == 3)
        {
            _effectWind = new EffectMc(this._layer.getLayer(LayerBattle.FRONT_EFFECT), this._ATTACK_MOTION_PATH, "hit_front_Wind02", this._targetDisplay.pos, false);
        }
        if (randomWind == 4)
        {
            _effectWind = new EffectMc(this._layer.getLayer(LayerBattle.FRONT_EFFECT), this._ATTACK_MOTION_PATH, "hit_front_Wind03", this._targetDisplay.pos, false);
        }
        this._effectManager.addEffect(_effectWind);
        _effectWind.mcEffect.gotoAndPlay("start");
        _effectWind.mcEffect.addEventListener(Event.ENTER_FRAME, frameListener);
        return;
    }// end function

}

