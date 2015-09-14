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

    public class SkillPBowShadowPin extends SkillPositionBase
    {
        private const _PHASE_BULLET:int = 20;
        private const _PHASE_HIT:int = 30;
        private var _bulletMc:MovieClip;
        private var _bulletPos:Point;
        private var _hitTime:Number;
        private var _throwH:Number;
        private var _throwHAcc:Number;
        private var _throwHTime:Number;
        private var _speedVec:Point;
        private const _BULLET_SPEED:int = 1500;

        public function SkillPBowShadowPin(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
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

        private function phaseBullet() : void
        {
            this._bulletMc = ResourceManager.getInstance().createMovieClip(getResource(), _EFFECT_MC_BULLET);
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                this._bulletMc.scaleX = -1;
            }
            _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(this._bulletMc);
            this._bulletPos = this.getStartPosition();
            var _loc_1:* = _targetGrandPos;
            this._speedVec = getSpeedVector(this._bulletPos, _loc_1, this._BULLET_SPEED);
            this._hitTime = getHitTime(this._bulletPos, _loc_1, this._BULLET_SPEED);
            this._throwHAcc = -10;
            this._throwH = 0;
            this._throwHTime = this._hitTime / 2;
            SoundManager.getInstance().playSe(SoundId.SE_RS3_BOW_BOW);
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            if (this._hitTime > 0)
            {
                this._hitTime = this._hitTime - param1;
                _loc_2 = new Matrix();
                _loc_2.scale(param1, param1);
                _loc_3 = _loc_2.transformPoint(this._speedVec);
                this._bulletPos = this._bulletPos.add(_loc_3);
                _loc_4 = new Matrix();
                this._throwH = this._throwH + this._throwHAcc;
                this._throwHAcc = this._throwHAcc + 10 / this._throwHTime * param1;
                _loc_4.translate(0, this._throwH);
                _loc_4.translate(this._bulletPos.x, this._bulletPos.y);
                this._bulletMc.transform.matrix = _loc_4;
                if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
                {
                    this._bulletMc.scaleX = -1;
                }
                if (this._hitTime <= 0)
                {
                    _loc_5 = -30;
                    if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
                    {
                        _loc_5 = 30;
                    }
                    this._bulletMc.rotation = _loc_5;
                    _loc_6 = new EffectMc(_layer.getLayer(LayerBattle.BACKGROUND), getResource(), _EFFECT_MC_GRAND, _targetGrandPos, _bReverse);
                    addEffect(_loc_6, this.cbSetEffectPhase);
                    setPhase(this._PHASE_HIT);
                }
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_ARROW_HIT);
                    SoundManager.getInstance().playSe(SoundId.SE_AERO);
                    playDamageAll();
                    if (this._bulletMc != null && this._bulletMc.parent != null)
                    {
                        this._bulletMc.parent.removeChild(this._bulletMc);
                    }
                    this._bulletMc = null;
                    break;
                }
                case _EFFECT_LABEL_END:
                {
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
            super.controlAction();
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

        override protected function getStartPosition() : Point
        {
            var _loc_1:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = _baseMc.bulletStartNullMc;
            }
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_1 = _skillUserDisplay.effectNull;
            }
            var _loc_2:* = _skillUserDisplay.pos;
            return new Point(_loc_2.x + _loc_1.x, _loc_2.y + _loc_1.y);
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.SKILL_PATH + "Skill_Bow_ShadowPin.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_ARROW_HIT, SoundId.SE_AERO, SoundId.SE_RS3_BOW_BOW];
            return _loc_1;
        }// end function

    }
}
