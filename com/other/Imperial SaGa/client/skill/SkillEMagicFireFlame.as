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

    public class SkillEMagicFireFlame extends SkillMagicBase
    {
        private const _PHASE_BULLET:int = 20;
        private const _PHASE_HIT:int = 30;
        private var _aBullet:Array;
        private var _aMoveBullet:Array;
        private var _waitTime:Number;
        private const WAIT_INTERVAL:Number = 0.01;
        private const BULLET_SPEED:int = 1000;
        private var _isPlay:Boolean = false;

        public function SkillEMagicFireFlame(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_FIRE))
            {
                playCastingSE();
            }
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override public function release() : void
        {
            this._aMoveBullet = null;
            this._aBullet = null;
            super.release();
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
                        setPhase(this._PHASE_BULLET);
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

        private function phaseBullet() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (isBoss())
                {
                    _bossEffect.gotoAndPlay(_ACT_LABEL_BACK);
                }
            }
            this._aBullet = [];
            var _loc_1:* = getMagicBulletStartNull(_skillUserDisplay.faceNull);
            for each (_loc_7 in _aTarget)
            {
                
                _loc_5 = _loc_7.characterDisplay.getEffectNullMatrix();
                _loc_6 = _loc_7.characterDisplay.pos.add(new Point(_loc_5.tx, _loc_5.ty));
                _loc_2 = this.getSpeedVector(_loc_1, _loc_6, this.BULLET_SPEED);
                _loc_3 = this.getHitTime(_loc_1, _loc_6, this.BULLET_SPEED);
                _loc_4 = {vec:_loc_2, time:_loc_3, pos:_loc_1, targetAction:_loc_7};
                this._aBullet.push(_loc_4);
            }
            this._aMoveBullet = [];
            this._waitTime = this.WAIT_INTERVAL;
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (this._waitTime > 0)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0)
                {
                    if (this._aBullet.length > 0)
                    {
                        _loc_4 = this._aBullet.pop();
                        _loc_5 = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
                        _loc_6 = new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_5, _loc_4.pos, _loc_4.vec);
                        _loc_6.setHitMake(_loc_4.time);
                        _loc_2 = {bullet:_loc_6, targetAction:_loc_4.targetAction};
                        this._aMoveBullet.push(_loc_2);
                        this._waitTime = this.WAIT_INTERVAL;
                    }
                }
            }
            var _loc_3:* = this._aMoveBullet.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_2 = this._aMoveBullet[_loc_3];
                _loc_7 = _loc_2.bullet;
                _loc_8 = _loc_2.targetAction;
                _loc_7.control(param1);
                if (_loc_7.bHit)
                {
                    if (_loc_8)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_BATTLE_FIRE);
                        _loc_9 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_8.characterDisplay.pos, _bReverse);
                        if (this._aBullet.length == 0 && this._isPlay == false)
                        {
                            this._isPlay = true;
                            addEffect(_loc_9, this.cbSetEffectPhase);
                        }
                        else
                        {
                            addEffect(_loc_9);
                        }
                        _loc_10 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, _loc_8.characterDisplay.pos, _bReverse);
                        addEffect(_loc_10);
                    }
                    _loc_7.release();
                    this._aMoveBullet.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
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
            return ResourcePath.SKILL_ENEMY_PATH + "Magic_Fire_Flame.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_FIRE];
            return _loc_1;
        }// end function

    }
}
