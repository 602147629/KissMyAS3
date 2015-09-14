package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPSwordTsumujiWind extends SkillPositionBase
    {
        private const _PHASE_WIND:int = 20;
        private const _PHASE_LOOP:int = 30;
        private var _moveVec:Point;
        private var _effectMtx:Matrix;
        private var _targetCount:int = 0;
        private var _effectMc:EffectMc;
        private var _effectActionMc:EffectMc;
        private var targetVec:Point;
        private var _ARROW_SPEED:int = 20;

        public function SkillPSwordTsumujiWind(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            var _loc_6:* = _skillUserDisplay.pos;
            _baseMc.x = _loc_6.x;
            _baseMc.y = _loc_6.y;
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
                case this._PHASE_WIND:
                {
                    this.controlWind(param1);
                    break;
                }
                case this._PHASE_LOOP:
                {
                    this.controlLoop();
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
                case this._PHASE_WIND:
                {
                    this.phaseWind();
                    break;
                }
                case this._PHASE_LOOP:
                {
                    this.phaseLoop();
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
                    case _ACT_LABEL_HIT:
                    {
                        setPhase(this._PHASE_WIND);
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

        private function phaseWind() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            _target = _aTarget[this._targetCount];
            _targetDisplay = _target.characterDisplay;
            this._effectMtx = _targetDisplay.getEffectNullMatrix();
            if (!this._effectMc)
            {
                this._effectMc = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "action_grand", _targetGrandPos, _bReverse);
                addEffect(this._effectMc, this.afSetEffectPhase);
                SoundManager.getInstance().playSe(SoundId.SE_BATTLE_WIND);
            }
            if (this._effectMc && this._targetCount > 0)
            {
                _loc_2 = _aTarget[(this._targetCount - 1)];
                _loc_3 = _loc_2.characterDisplay;
                _loc_1 = _loc_3.pos;
                setTarget(_aTarget[this._targetCount]);
                _loc_4 = _targetDisplay.getEffectNullMatrix();
                _loc_5 = _targetGrandPos.add(new Point(_loc_4.tx, _loc_4.ty));
                this.targetVec = new Point(_loc_5.x - _loc_1.x, _loc_5.y - _loc_1.y);
                _loc_6 = this.targetVec.length;
                this.targetVec.normalize(1);
                _loc_7 = new Matrix();
                _loc_7.scale(this._ARROW_SPEED, this._ARROW_SPEED);
                this.targetVec = _loc_7.transformPoint(this.targetVec);
            }
            return;
        }// end function

        private function controlWind(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._effectMc && this._targetCount > 0)
            {
                _loc_2 = this._effectMc.mcEffect.transform.matrix;
                _loc_2.translate(this.targetVec.x, 0);
                this._effectMc.mcEffect.transform.matrix = _loc_2;
            }
            return;
        }// end function

        private function phaseLoop() : void
        {
            var _loc_1:* = _targetDisplay.getEffectNullMatrix();
            var _loc_2:* = _targetGrandPos.add(new Point(_loc_1.tx, _loc_1.ty));
            this._moveVec = _loc_2.subtract(new Point(this._effectMc.mcEffect.x, this._effectMc.mcEffect.y));
            if (_aTarget.length != (this._targetCount + 1))
            {
                _target = _aTarget[this._targetCount];
                var _loc_3:* = this;
                var _loc_4:* = this._targetCount + 1;
                _loc_3._targetCount = _loc_4;
            }
            else
            {
                this._effectMc.mcEffect.gotoAndPlay("loopout");
            }
            return;
        }// end function

        private function controlLoop() : void
        {
            var _loc_1:* = null;
            if (!this._effectMc.isEnd())
            {
                if (this._effectMc.mcEffect.currentLabel == "loop")
                {
                    setPhase(this._PHASE_WIND);
                }
                if (this._effectMc.mcEffect.currentLabel == "loopout")
                {
                    _loc_1 = this._effectMc.mcEffect.transform.matrix;
                    if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
                    {
                        _loc_1.translate(-16, 0);
                    }
                    else
                    {
                        _loc_1.translate(16, 0);
                    }
                    this._effectMc.mcEffect.transform.matrix = _loc_1;
                }
            }
            return;
        }// end function

        private function afSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _ACT_LABEL_HIT:
                {
                    this._effectActionMc = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetGrandPos.add(new Point(this._effectMtx.tx, this._effectMtx.ty)), _bReverse);
                    addEffect(this._effectActionMc, this.hfSetEffectPhase);
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    setPhase(_PHASE_END);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function hfSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
                    playDamage(_target);
                    setPhase(this._PHASE_LOOP);
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    this._effectActionMc.release();
                    break;
                }
                default:
                {
                    break;
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
            return ResourcePath.SKILL_PATH + "Skill_Sword_TsumujiWind.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK, SoundId.SE_BATTLE_WIND];
            return _loc_1;
        }// end function

    }
}
