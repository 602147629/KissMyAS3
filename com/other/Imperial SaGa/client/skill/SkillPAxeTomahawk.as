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

    public class SkillPAxeTomahawk extends SkillPositionBase
    {
        private const _PHASE_BULLET_MOVE:int = 20;
        private const _PHASE_HIT:int = 30;
        private var _bulletMc:MovieClip;
        private var _bulletPos:Point;
        private var _hitTime:Number;
        private var _throwH:Number;
        private var _throwHAcc:Number;
        private var _throwHTime:Number;
        private var _speedVec:Point;
        private const TOP_POS:int = 100;
        private const _BULLET_SPEED:int = 1000;

        public function SkillPAxeTomahawk(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override public function release() : void
        {
            if (this._bulletMc != null)
            {
                this._bulletMc.parent.removeChild(this._bulletMc);
            }
            this._bulletMc = null;
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
                case this._PHASE_BULLET_MOVE:
                {
                    this.controlBulletMove(param1);
                    break;
                }
                case _PHASE_END:
                {
                    this.controlEnd();
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
                case this._PHASE_BULLET_MOVE:
                {
                    this.phaseBulletMove();
                    break;
                }
                case _PHASE_END:
                {
                    this.phaseEnd();
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
                        setPhase(this._PHASE_BULLET_MOVE);
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

        private function phaseBulletMove() : void
        {
            this._bulletMc = ResourceManager.getInstance().createMovieClip(getResource(), _EFFECT_MC_BULLET);
            _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(this._bulletMc);
            this._bulletPos = this.getStartPosition();
            var _loc_1:* = _targetHitFrontPos.clone();
            this._speedVec = getSpeedVector(this._bulletPos, _loc_1, this._BULLET_SPEED);
            this._hitTime = getHitTime(this._bulletPos, _loc_1, this._BULLET_SPEED);
            this._throwHAcc = -30;
            this._throwH = 0;
            this._throwHTime = this._hitTime / 2;
            SoundManager.getInstance().playSe(SoundId.SE_RS3_AXE_TOMAHAWK_FLYING_AXE);
            return;
        }// end function

        private function controlBulletMove(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._hitTime > 0)
            {
                this._hitTime = this._hitTime - param1;
                _loc_2 = new Matrix();
                _loc_2.scale(param1, param1);
                _loc_3 = _loc_2.transformPoint(this._speedVec);
                this._bulletPos = this._bulletPos.add(_loc_3);
                _loc_4 = new Matrix();
                this._throwH = this._throwH + this._throwHAcc;
                this._throwHAcc = this._throwHAcc + 30 / this._throwHTime * param1;
                _loc_4.translate(0, this._throwH);
                _loc_4.translate(this._bulletPos.x, this._bulletPos.y);
                this._bulletMc.transform.matrix = _loc_4;
                if (this._hitTime <= 0)
                {
                    if (this._bulletMc != null && this._bulletMc.parent != null)
                    {
                        this._bulletMc.parent.removeChild(this._bulletMc);
                    }
                    this._bulletMc = null;
                    _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                    addEffect(_loc_5, this.cbSetEffectPhase);
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
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_AXE_TOMAHAWK_HITTING);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK);
                    playDamageAll();
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
            return ResourcePath.SKILL_PATH + "Skill_Axe_Tomahawk.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_RS3_AXE_TOMAHAWK_HITTING, SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK, SoundId.SE_RS3_AXE_TOMAHAWK_FLYING_AXE];
            return _loc_1;
        }// end function

    }
}
