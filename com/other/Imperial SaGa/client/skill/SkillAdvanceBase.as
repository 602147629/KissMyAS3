package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import player.*;
    import resource.*;
    import sound.*;

    public class SkillAdvanceBase extends SkillPositionBase
    {
        protected var _PHASE_APPROACH:int = 9;
        protected var _PHASE_LEAVE:int = 90;
        protected var _skillUserMc:MovieClip;
        protected var _bHitPos:Boolean;
        protected var _targetHitType:int;
        protected var _nullPosMc:MovieClip;
        static const _TARGET_HIT_TYPE_FRONT:int = 0;
        static const _TARGET_HIT_TYPE_GRAND:int = 1;
        static const _TARGET_HIT_TYPE_FORMATION_FRONT:int = 2;

        public function SkillAdvanceBase(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager, param6:String)
        {
            super(param1, param2, param3, param4, param5, param6);
            this._skillUserMc = _baseMc.charaNull;
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function createBaseMc(param1:String) : void
        {
            _baseMc = ResourceManager.getInstance().createMovieClip(param1, "advance_chara_act");
            _layer.getLayer(LayerBattle.CHARACTER).addChild(_baseMc);
            if (this._targetHitType == _TARGET_HIT_TYPE_FORMATION_FRONT)
            {
                this._nullPosMc = ResourceManager.getInstance().createMovieClip(param1, "nullPosition");
            }
            return;
        }// end function

        override protected function setBasePosition() : void
        {
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            this._nullPosMc = null;
            return;
        }// end function

        override protected function selectControl(param1:Number) : void
        {
            switch(_phase)
            {
                case _PHASE_WAIT:
                {
                    this.controlWait();
                    break;
                }
                case this._PHASE_APPROACH:
                {
                    this.controlApproach();
                    break;
                }
                case _PHASE_ACTION:
                {
                    controlAction();
                    break;
                }
                case this._PHASE_LEAVE:
                {
                    this.controlLeave();
                    break;
                }
                case _PHASE_END:
                {
                    controlEnd();
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
                case this._PHASE_APPROACH:
                {
                    this.phaseApproach();
                    break;
                }
                case _PHASE_ACTION:
                {
                    this.phaseAction();
                    break;
                }
                case this._PHASE_LEAVE:
                {
                    this.phaseLeave();
                    break;
                }
                case _PHASE_END:
                {
                    phaseEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function controlWait() : void
        {
            if (_bNeedWait == false || _monsterMc == null)
            {
                setPhase(this._PHASE_APPROACH);
                return;
            }
            if (_monsterMc.currentFrameLabel == "attack")
            {
                setPhase(this._PHASE_APPROACH);
            }
            return;
        }// end function

        protected function phaseApproach() : void
        {
            this.setAnimationApproech();
            return;
        }// end function

        protected function controlApproach() : void
        {
            if (this.bCheckMoving == false)
            {
                setPhase(_PHASE_ACTION);
            }
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            this._skillUserMc.gotoAndPlay(_ACT_LABEL_START);
            return;
        }// end function

        protected function phaseLeave() : void
        {
            _baseMc.visible = false;
            this.backToDefaultPosition();
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                SoundManager.getInstance().playSe(SoundId.SE_JUMP2);
            }
            return;
        }// end function

        protected function controlLeave() : void
        {
            if (this.bCheckMoving == false)
            {
                setPhase(_PHASE_END);
            }
            return;
        }// end function

        protected function get bCheckMoving() : Boolean
        {
            var _loc_1:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = _skillUserDisplay as PlayerDisplay;
                return _loc_1.bMoveing;
            }
            return false;
        }// end function

        override protected function setAnimationPattarn() : void
        {
            var _loc_1:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = _skillUserDisplay as PlayerDisplay;
                _loc_1.setAnimationPattern(this._skillUserMc);
            }
            return;
        }// end function

        protected function setAnimationApproech() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = _skillUserDisplay as PlayerDisplay;
                _loc_1.setAnimSideDash();
                switch(this._targetHitType)
                {
                    case _TARGET_HIT_TYPE_GRAND:
                    {
                        _loc_2 = new Point(_targetGrandPos.x + this._skillUserMc.x, _targetGrandPos.y + this._skillUserMc.y);
                        break;
                    }
                    case _TARGET_HIT_TYPE_FORMATION_FRONT:
                    {
                        _loc_3 = this._nullPosMc.enemyNullMc;
                        _loc_2 = new Point(_loc_3.x + this._skillUserMc.x, _loc_3.y + this._skillUserMc.y);
                        break;
                    }
                    case _TARGET_HIT_TYPE_FRONT:
                    {
                    }
                    default:
                    {
                        _loc_2 = new Point(_targetHitFrontPos.x + this._skillUserMc.x, _targetHitFrontPos.y + this._skillUserMc.y);
                        break;
                        break;
                    }
                }
                _loc_1.setTargetPoint(_loc_2, 0.3);
            }
            return;
        }// end function

        override protected function setTarget(param1:BattleActionBase) : void
        {
            var _loc_2:* = null;
            super.setTarget(param1);
            switch(this._targetHitType)
            {
                case _TARGET_HIT_TYPE_GRAND:
                {
                    _baseMc.x = _targetGrandPos.x;
                    _baseMc.y = _targetGrandPos.y;
                    break;
                }
                case _TARGET_HIT_TYPE_FORMATION_FRONT:
                {
                    _loc_2 = this._nullPosMc.enemyNullMc;
                    if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
                    {
                        _loc_2 = this._nullPosMc.playerNullMc;
                    }
                    else
                    {
                        _loc_2 = this._nullPosMc.enemyNullMc;
                    }
                    _baseMc.x = _loc_2.x;
                    _baseMc.y = _loc_2.y;
                    break;
                }
                case _TARGET_HIT_TYPE_FRONT:
                {
                }
                default:
                {
                    _baseMc.x = _targetHitFrontPos.x;
                    _baseMc.y = _targetHitFrontPos.y;
                    break;
                    break;
                }
            }
            return;
        }// end function

        protected function backToDefaultPosition() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = _skillUserDisplay as PlayerDisplay;
                _loc_2 = new Point(_baseMc.x, _baseMc.y);
                _loc_1.pos = _loc_2.add(new Point(this._skillUserMc.x, this._skillUserMc.y));
                _loc_1.setTargetJump(_loc_1.backupPosition);
            }
            return;
        }// end function

    }
}
