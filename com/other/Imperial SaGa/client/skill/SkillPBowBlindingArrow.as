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

    public class SkillPBowBlindingArrow extends SkillPositionBase
    {
        private const _PHASE_BULLET_MOVE:int = 20;
        private var _topBulletMc:MovieClip;
        private var _bulletPos:Point;
        private var _hitTime:Number;
        private var _throwH:Number;
        private var _throwHAccTop:Number;
        private var _throwHTime:Number;
        private var _speedVec:Point;
        private const _BULLET_SPEED:int = 1000;
        private var _underBulletMc:MovieClip;
        private var _throwHAccUnder:Number;
        private var _throwHUnder:Number;
        private var _bulletPosUnder:Point;

        public function SkillPBowBlindingArrow(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override public function release() : void
        {
            if (this._topBulletMc != null)
            {
                this._topBulletMc.parent.removeChild(this._topBulletMc);
            }
            this._topBulletMc = null;
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
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_BULLET:
                    {
                        setPhase(this._PHASE_BULLET_MOVE);
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
            this._topBulletMc = ResourceManager.getInstance().createMovieClip(getResource(), _EFFECT_MC_BULLET);
            _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(this._topBulletMc);
            this._bulletPos = this.getStartPosition();
            var _loc_1:* = _targetFacePos.clone();
            this._speedVec = getSpeedVector(this._bulletPos, _loc_1, this._BULLET_SPEED);
            this._hitTime = getHitTime(this._bulletPos, _loc_1, this._BULLET_SPEED);
            this._throwHAccTop = -15;
            this._throwH = 0;
            this._throwHTime = this._hitTime / 2;
            this._underBulletMc = ResourceManager.getInstance().createMovieClip(getResource(), _EFFECT_MC_BULLET);
            _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(this._underBulletMc);
            this._bulletPosUnder = this.getStartPosition();
            this._throwHAccUnder = 15;
            this._throwHUnder = 0;
            SoundManager.getInstance().playSe(SoundId.SE_RS3_BOW_BOW);
            return;
        }// end function

        private function controlBulletMove(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._hitTime > 0)
            {
                this._hitTime = this._hitTime - param1;
                _loc_2 = new Matrix();
                _loc_2.scale(param1, param1);
                _loc_3 = _loc_2.transformPoint(this._speedVec);
                this._bulletPos = this._bulletPos.add(_loc_3);
                _loc_4 = new Matrix();
                this._throwH = this._throwH + this._throwHAccTop;
                this._throwHAccTop = this._throwHAccTop + 15 / this._throwHTime * param1;
                _loc_4.translate(0, this._throwH);
                _loc_4.translate(this._bulletPos.x, this._bulletPos.y);
                this._topBulletMc.transform.matrix = _loc_4;
                if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
                {
                    this._topBulletMc.scaleX = -1;
                }
                _loc_5 = new Matrix();
                _loc_5.scale(param1, param1);
                _loc_6 = _loc_2.transformPoint(this._speedVec);
                this._bulletPosUnder = this._bulletPos.add(_loc_6);
                _loc_7 = new Matrix();
                this._throwHUnder = this._throwHUnder + this._throwHAccUnder;
                this._throwHAccUnder = this._throwHAccUnder - 15 / this._throwHTime * param1;
                _loc_7.translate(0, this._throwHUnder);
                _loc_7.translate(this._bulletPos.x, this._bulletPos.y);
                this._underBulletMc.transform.matrix = _loc_7;
                if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
                {
                    this._underBulletMc.scaleX = -1;
                }
                if (this._hitTime <= 0)
                {
                    if (this._topBulletMc != null && this._topBulletMc.parent != null)
                    {
                        this._topBulletMc.parent.removeChild(this._topBulletMc);
                        this._underBulletMc.parent.removeChild(this._underBulletMc);
                    }
                    this._topBulletMc = null;
                    _loc_8 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetFacePos, _bReverse);
                    addEffect(_loc_8, this.cbSetEffectPhase);
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
                    playDamageAll();
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
            return ResourcePath.SKILL_PATH + "Skill_Bow_BlindingArrow.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_ARROW_HIT, SoundId.SE_RS3_BOW_BOW];
            return _loc_1;
        }// end function

    }
}
