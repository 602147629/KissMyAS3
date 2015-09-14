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

    public class SkillPAxeFlyby extends SkillPositionBase
    {
        private var mtx:Matrix;
        private const _PHASE_BULLET:int = 20;
        private const _PHASE_HIT:int = 30;
        private var frontMc:EffectMc;
        private var _aBullet:Array;
        private var _arrow:SkillPartsArrow;
        private var _moveVec:Point;
        private const _SHOT_SPEED:int = 1500;

        public function SkillPAxeFlyby(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
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
            var _loc_1:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = _skillUserDisplay as PlayerDisplay;
                _loc_1.setAnimationPattern(_baseMc);
            }
            _baseMc.gotoAndPlay(_ACT_LABEL_START);
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_AXE_SKYDRIVE_JUMP);
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
                    case _ACT_LABEL_END:
                    {
                        break;
                    }
                    case "bgColorMc":
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                setPhase(this._PHASE_BULLET);
            }
            return;
        }// end function

        private function phaseBullet() : void
        {
            this._aBullet = [];
            var _loc_1:* = ResourceManager.getInstance().createMovieClip(getResource(), _EFFECT_MC_BULLET);
            var _loc_2:* = this.getStartPosition();
            var _loc_3:* = getSpeedVector(_loc_2, _targetHitFrontPos, this._SHOT_SPEED);
            var _loc_4:* = getHitTime(_loc_2, _targetHitFrontPos, this._SHOT_SPEED);
            this._arrow = new SkillPartsArrow(_layer.getLayer(LayerBattle.FRONT_EFFECT), _loc_1, _loc_2, _loc_3);
            this._arrow.setHitMake(_loc_4);
            this._aBullet.push(this._arrow);
            SoundManager.getInstance().playSe(SoundId.SE_RS3_AXE_TOMAHAWK_FLYING_AXE);
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = this._aBullet.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aBullet[_loc_2];
                _loc_3.control(param1);
                if (_loc_3.bHit)
                {
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                    addEffect(_loc_4, this.cbSetEffectPhase);
                    _loc_3.release();
                    this._aBullet.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            if (this._aBullet.length == 0)
            {
                setPhase(this._PHASE_HIT);
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_AXE_NORMAL_ATTACK_2);
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_AXE_NORMAL_ATTACK_2);
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
            return ResourcePath.SKILL_PATH + "Skill_Axe_Flyby.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_REV_AXE_SKYDRIVE_JUMP, SoundId.SE_RS3_AXE_TOMAHAWK_FLYING_AXE, SoundId.SE_RS3_AXE_NORMAL_ATTACK_2];
            return _loc_1;
        }// end function

    }
}
