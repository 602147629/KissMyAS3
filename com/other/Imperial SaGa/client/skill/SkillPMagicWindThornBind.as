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

    public class SkillPMagicWindThornBind extends SkillMagicBase
    {
        private const _PHASE_BULLET:int = 20;
        private const _PHASE_HIT:int = 30;
        private var _aBullet:Array;
        private var _aMoveBullet:Array;
        private var _moveVec:Point;
        private const BULLET_INTERVAL:int = 40;
        private var _bAddEffect:Boolean;
        private var _bulletTimeCount:int;

        public function SkillPMagicWindThornBind(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
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
            var _loc_1:* = null;
            var _loc_8:* = null;
            var _loc_10:* = NaN;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (isBoss())
                {
                    _bossEffect.gotoAndPlay(_ACT_LABEL_BACK);
                }
            }
            this._aBullet = [];
            this._aMoveBullet = [];
            this._bulletTimeCount = 0;
            var _loc_2:* = _baseMc.bulletStartNullMc;
            var _loc_3:* = _skillUserDisplay.pos;
            if (_bReverse)
            {
                _loc_1 = new Point(_loc_3.x - _loc_2.x, _loc_3.y + _loc_2.y);
            }
            else
            {
                _loc_1 = new Point(_loc_3.x + _loc_2.x, _loc_3.y + _loc_2.y);
            }
            var _loc_4:* = new Point(_loc_1.x - _targetGrandPos.x, _loc_1.y - _targetGrandPos.y);
            var _loc_5:* = new Point(_loc_1.x - _targetGrandPos.x, _loc_1.y - _targetGrandPos.y).x / this.BULLET_INTERVAL;
            var _loc_6:* = _loc_4.y / _loc_5;
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_5 = -_loc_5;
            }
            var _loc_7:* = this.getSpeedVector(_loc_1, _targetGrandPos, 1000);
            var _loc_9:* = 0;
            while (_loc_9 < _loc_5)
            {
                
                if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
                {
                    _loc_1.x = _loc_1.x - this.BULLET_INTERVAL;
                    _loc_1.y = _loc_1.y - _loc_6;
                }
                else
                {
                    _loc_1.x = _loc_1.x + this.BULLET_INTERVAL;
                    _loc_1.y = _loc_1.y + _loc_6;
                }
                _loc_8 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "bullet", _loc_1, _bReverse);
                _loc_10 = Math.atan2(-_loc_7.y, -_loc_7.x);
                _loc_8.mcEffect.rotation = _loc_10 * 180 / Math.PI;
                if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
                {
                    _loc_8.mcEffect.scaleY = -1;
                }
                _loc_8.mcEffect.visible = false;
                this._aBullet.unshift(_loc_8);
                _loc_9++;
            }
            this._bAddEffect = false;
            SoundManager.getInstance().playSe(SoundId.SE_BATTLE_GROUND);
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = this;
            var _loc_8:* = this._bulletTimeCount + 1;
            _loc_7._bulletTimeCount = _loc_8;
            if (this._bulletTimeCount == 2)
            {
                if (this._aBullet.length != 0)
                {
                    _loc_3 = this._aBullet.pop();
                    _loc_3.mcEffect.visible = true;
                    _loc_3.mcEffect.gotoAndPlay("start");
                    this._aMoveBullet.push(_loc_3);
                    this._bulletTimeCount = 0;
                }
            }
            var _loc_2:* = this._aMoveBullet.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this._aMoveBullet[_loc_2].mcEffect.currentLabel == "end")
                {
                    this._aMoveBullet[_loc_2].mcEffect.gotoAndStop("1");
                    this._aMoveBullet[_loc_2].mcEffect.visible = false;
                    this._aMoveBullet[_loc_2].release();
                    this._aMoveBullet.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            if (this._aBullet.length == 0 && !this._bAddEffect && this._aMoveBullet.length <= 3)
            {
                this._bAddEffect = true;
                SoundManager.getInstance().playSe(SoundId.SE_GROUND_RUMBLE);
                _loc_4 = new EffectShake(_layer, 5, 5, 1.2);
                _effectManager.addEffect(_loc_4);
                if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren == Constant.EMPTY_ID)
                {
                    _loc_6 = new EffectShake(_battleManager.battleScreen, 5, 5, 1.2);
                    _effectManager.addEffect(_loc_6);
                }
                _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                addEffect(_loc_5, this.cbSetEffectPhase);
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
            return ResourcePath.SKILL_PATH + "Magic_Wind_ThornBind.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_GROUND, SoundId.SE_GROUND_RUMBLE];
            return _loc_1;
        }// end function

    }
}
