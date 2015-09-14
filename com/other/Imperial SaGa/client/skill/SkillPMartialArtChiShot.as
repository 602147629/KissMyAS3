package skill
{
    import battle.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPMartialArtChiShot extends SkillPositionBase
    {
        private const _PHASE_BULLET:int = 20;
        private const _PHASE_HIT:int = 30;
        private var _seIndex:int = 0;
        private var _aBullet:Array;
        private const _ARROW_SPEED:int = 1000;

        public function SkillPMartialArtChiShot(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
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
                    case _EFFECT_PLAY_SE:
                    {
                        var _loc_1:* = this;
                        _loc_1._seIndex = this._seIndex + 1;
                        SoundManager.getInstance().playSe(getSeIdList()[this._seIndex++]);
                        break;
                    }
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
            this._aBullet = [];
            var _loc_1:* = ResourceManager.getInstance().createMovieClip(getResource(), _EFFECT_MC_BULLET);
            var _loc_2:* = getStartPosition();
            var _loc_3:* = getSpeedVector(_loc_2, _targetHitFrontPos, this._ARROW_SPEED);
            var _loc_4:* = getHitTime(_loc_2, _targetHitFrontPos, this._ARROW_SPEED);
            var _loc_5:* = new SkillPartsArrow(_layer.getLayer(LayerBattle.FRONT_EFFECT), _loc_1, _loc_2, _loc_3);
            new SkillPartsArrow(_layer.getLayer(LayerBattle.FRONT_EFFECT), _loc_1, _loc_2, _loc_3).setHitMake(_loc_4);
            this._aBullet.push(_loc_5);
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

        private function phaseHit() : void
        {
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_BLOW_PUNCH);
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

        private function controlHit() : void
        {
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
            return ResourcePath.SKILL_PATH + "Skill_MartialArt_ChiShot.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_REV_MART_KIDAN_CHARGE, SoundId.SE_RS3_AXE_WOOD_SPLITTING_DYNAMIC_HIGH_JUMP, SoundId.SE_RS3_BLOW_PUNCH];
            return _loc_1;
        }// end function

    }
}
