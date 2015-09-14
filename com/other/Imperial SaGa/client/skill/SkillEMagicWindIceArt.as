package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillEMagicWindIceArt extends SkillMagicBase
    {
        private const _PHASE_BULLET_CREATE:int = 20;
        private const _PHASE_BULLET:int = 30;
        private const _PHASE_HIT:int = 40;
        private var _createBullet:EffectMc;
        private var _aBullet:Array;
        private var _aMoveBullet:Array;
        private var _moveVec:Point;
        private var _waitTime:Number;
        private const WAIT_INTERVAL:Number = 0.1;
        private const BULLET_SPEED:int = 2500;
        private var _bAddEffect:Boolean;
        private var _aArrowX:Array;
        private var _aArrowY:Array;
        private var _hitCount:int = 0;
        private var _bulletCount:int = 0;

        public function SkillEMagicWindIceArt(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            this._aArrowX = [-20, 0, 30, 0];
            this._aArrowY = [50, -50, 30, 0];
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_WIND))
            {
                playCastingSE();
            }
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function selectControl(param1:Number) : void
        {
            switch(_phase)
            {
                case _PHASE_WAIT:
                {
                    controlWait();
                    break;
                }
                case _PHASE_ACTION:
                {
                    this.controlAction();
                    break;
                }
                case _PHASE_END:
                {
                    this.controlEnd();
                    break;
                }
                case this._PHASE_BULLET_CREATE:
                {
                    this.controlBulletCreate();
                    break;
                }
                case this._PHASE_BULLET:
                {
                    this.controlBullet(param1);
                    break;
                }
                case this._PHASE_HIT:
                {
                    this.controlHit();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function selectPhase() : void
        {
            switch(_phase)
            {
                case _PHASE_WAIT:
                {
                    phaseWait();
                    break;
                }
                case _PHASE_ACTION:
                {
                    this.phaseAction();
                    break;
                }
                case _PHASE_END:
                {
                    this.phaseEnd();
                    break;
                }
                case this._PHASE_BULLET_CREATE:
                {
                    this.phaseBulletCreate();
                    break;
                }
                case this._PHASE_BULLET:
                {
                    this.phaseBullet();
                    break;
                }
                case this._PHASE_HIT:
                {
                    this.phaseHit();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            if (isBoss() == false)
            {
                playCastingSE();
            }
            return;
        }// end function

        override protected function controlAction() : void
        {
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_BULLET:
                    {
                        setPhase(this._PHASE_BULLET_CREATE);
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
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

        private function phaseBulletCreate() : void
        {
            var _loc_1:* = getMagicBulletStartNull(_baseMc.bulletStartNullMc);
            this._createBullet = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _ACT_LABEL_START_FRONT, _loc_1, _bReverse);
            addEffect(this._createBullet);
            SoundManager.getInstance().playSe(SoundId.SE_REV_WIND_ICEJAVVELIN_EFFECT);
            return;
        }// end function

        private function controlBulletCreate() : void
        {
            if (this._createBullet.mcEffect.currentLabel == _ACT_LABEL_BULLET)
            {
                setPhase(this._PHASE_BULLET);
            }
            return;
        }// end function

        private function phaseBullet() : void
        {
            var _loc_5:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (isBoss())
                {
                    _bossEffect.gotoAndPlay(_ACT_LABEL_BACK);
                }
            }
            this._aBullet = [];
            var _loc_1:* = getMagicBulletStartNull(_baseMc.bulletStartNullMc);
            var _loc_2:* = this.getSpeedVector(_loc_1, _targetHitFrontPos, this.BULLET_SPEED);
            var _loc_3:* = this.getHitTime(_loc_1, _targetHitFrontPos, this.BULLET_SPEED);
            var _loc_4:* = 0;
            while (_loc_4 < 4)
            {
                
                _loc_5 = {vec:_loc_2, time:_loc_3, pos:_loc_1};
                this._aBullet.push(_loc_5);
                _loc_4++;
            }
            this._aMoveBullet = [];
            this._waitTime = this.WAIT_INTERVAL;
            this._bAddEffect = false;
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (this._waitTime > 0)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0)
                {
                    if (this._aBullet.length > 0)
                    {
                        _loc_3 = this._aBullet.pop();
                        _loc_4 = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
                        _loc_5 = new Point(this._aArrowX[this._bulletCount], this._aArrowY[this._bulletCount]);
                        _loc_6 = new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_4, _loc_3.pos, _loc_3.vec.add(_loc_5));
                        _loc_6.setHitMake(_loc_3.time);
                        this._aMoveBullet.push(_loc_6);
                        this._waitTime = this.WAIT_INTERVAL;
                        var _loc_10:* = this;
                        var _loc_11:* = this._bulletCount + 1;
                        _loc_10._bulletCount = _loc_11;
                    }
                }
            }
            var _loc_2:* = this._aMoveBullet.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_7 = this._aMoveBullet[_loc_2];
                _loc_7.control(param1);
                if (_loc_7.bHit)
                {
                    var _loc_10:* = this;
                    var _loc_11:* = this._hitCount + 1;
                    _loc_10._hitCount = _loc_11;
                    SoundManager.getInstance().playSe(SoundId.SE_REV_WIND_ICEJAVVELIN_HIT);
                    if (this._hitCount == 4)
                    {
                        _loc_8 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_8, this.cbSetEffectPhase);
                    }
                    else
                    {
                        _loc_9 = new Point(_targetHitFrontPos.x + this._aArrowX[(this._hitCount - 1)], _targetHitFrontPos.y + this._aArrowY[(this._hitCount - 1)]);
                        _loc_8 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_9, _bReverse);
                        addEffect(_loc_8);
                    }
                    _targetDisplay.setAnimDamage();
                    _loc_7.release();
                    this._aMoveBullet.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            if (this._aBullet.length == 0 && this._aMoveBullet.length == 0)
            {
                setPhase(this._PHASE_HIT);
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    playDamageAll();
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseHit() : void
        {
            return;
        }// end function

        private function controlHit() : void
        {
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_END:
                    {
                        setPhase(_PHASE_END);
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

        override protected function phaseEnd() : void
        {
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
            return ResourcePath.SKILL_ENEMY_PATH + "Magic_Wind_IceArt.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_REV_WIND_ICEJAVVELIN_EFFECT, SoundId.SE_REV_WIND_ICEJAVVELIN_HIT];
            return _loc_1;
        }// end function

    }
}
