package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPBigSwordTripleCut extends SkillAdvanceBase
    {
        private var target:BattleActionBase;
        private var targetDisplay:CharacterDisplayBase;
        private var effectMtx:Matrix;

        public function SkillPBigSwordTripleCut(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseApproach() : void
        {
            super.phaseApproach();
            return;
        }// end function

        override protected function controlApproach() : void
        {
            super.controlApproach();
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_1, this.setHitEffectPhase);
                        break;
                    }
                    case "hit2":
                    {
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, _targetDisplay.pos, _bReverse);
                        addEffect(_loc_2, this.setEffectPhase);
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
                        setPhase(_PHASE_LEAVE);
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function setHitEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE:
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
                    _target.setActionDamage();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
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

        override protected function phaseLeave() : void
        {
            super.phaseLeave();
            return;
        }// end function

        override protected function controlLeave() : void
        {
            super.controlLeave();
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
            return ResourcePath.SKILL_PATH + "Skill_BigSword_TripleCut.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK, SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK, SoundId.SE_JUMP2];
            return _loc_1;
        }// end function

    }
}
