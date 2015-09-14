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

    public class SkillPMagicEarthStoneBullet extends SkillMagicBase
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
        private const BULLET_SPEED:int = 1500;
        private var _bAddEffect:Boolean;
        private var count:int = 0;
        private var _hitCount:int = 0;

        public function SkillPMagicEarthStoneBullet(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_EARTH))
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
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_1 = _baseMc.bulletStartNullMc;
            _loc_2 = _skillUserDisplay.pos;
            if (_bReverse)
            {
                _loc_3 = new Point(_loc_2.x - _loc_1.x, _loc_2.y + _loc_1.y);
            }
            else
            {
                _loc_3 = new Point(_loc_2.x + _loc_1.x, _loc_2.y + _loc_1.y);
            }
            this._createBullet = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _ACT_LABEL_START_FRONT, _loc_3, _bReverse);
            addEffect(this._createBullet);
            SoundManager.getInstance().playSe(SoundId.SE_GUSTAV_FIRE);
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
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (isBoss())
                {
                    _bossEffect.gotoAndPlay(_ACT_LABEL_BACK);
                }
            }
            this._aBullet = [];
            _loc_1 = _baseMc.bulletStartNullMc;
            _loc_2 = _skillUserDisplay.pos;
            if (_bReverse)
            {
                _loc_3 = new Point(_loc_2.x - _loc_1.x, _loc_2.y + _loc_1.y);
            }
            else
            {
                _loc_3 = new Point(_loc_2.x + _loc_1.x, _loc_2.y + _loc_1.y);
            }
            _loc_5 = this.getSpeedVector(_loc_3, _targetHitFrontPos, this.BULLET_SPEED);
            _loc_6 = this.getHitTime(_loc_3, _targetHitFrontPos, this.BULLET_SPEED);
            _loc_4 = {vec:_loc_5, time:_loc_6, pos:_loc_3};
            this._aBullet.push(_loc_4);
            _loc_3 = new Point(_loc_3.x, _loc_3.y + this._createBullet.mcEffect.bulletStartNull2Mc.y);
            _loc_5 = this.getSpeedVector(_loc_3, _targetHitFrontPos, this.BULLET_SPEED);
            _loc_6 = this.getHitTime(_loc_3, _targetHitFrontPos, this.BULLET_SPEED);
            _loc_4 = {vec:_loc_5, time:_loc_6, pos:_loc_3};
            this._aBullet.unshift(_loc_4);
            this._aMoveBullet = [];
            this._bAddEffect = false;
            var _loc_7:* = 0;
            while (_loc_7 < 2)
            {
                
                _loc_8 = this._aBullet.pop();
                _loc_9 = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
                _loc_10 = new Point(0, 0);
                _loc_11 = new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_9, _loc_8.pos.add(_loc_10), _loc_8.vec);
                if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
                {
                    _loc_11.mc.scaleY = -1;
                }
                _loc_11.setHitMake(_loc_8.time);
                this._aMoveBullet.push(_loc_11);
                _loc_7++;
            }
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = this._aMoveBullet.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aMoveBullet[_loc_2];
                if (_loc_2 == 1 && this.count > 6)
                {
                    _loc_3.control(param1);
                }
                if (_loc_2 == 0)
                {
                    _loc_3.control(param1);
                }
                if (_loc_3.bHit)
                {
                    var _loc_5:* = this;
                    var _loc_6:* = this._hitCount + 1;
                    _loc_5._hitCount = _loc_6;
                    if (this._hitCount == 1)
                    {
                        _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_4);
                        this._bAddEffect = true;
                    }
                    else
                    {
                        _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_4, this.cbSetEffectPhase);
                        SoundManager.getInstance().playSe(SoundId.SE_BATTLE_GROUND);
                    }
                    _loc_3.release();
                    this._aMoveBullet.splice(_loc_2, 1);
                }
                var _loc_5:* = this;
                var _loc_6:* = this.count + 1;
                _loc_5.count = _loc_6;
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
            return ResourcePath.SKILL_PATH + "Magic_Earth_StoneBullet.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_GUSTAV_FIRE, SoundId.SE_BATTLE_GROUND];
            return _loc_1;
        }// end function

    }
}
