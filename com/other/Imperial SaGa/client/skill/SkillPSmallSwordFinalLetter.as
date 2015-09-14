package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPSmallSwordFinalLetter extends SkillAdvanceBase
    {

        public function SkillPSmallSwordFinalLetter(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
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
            var _loc_1:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "action_front", null, _bReverse);
            addEffect(_loc_1, null, null);
            var _loc_2:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "action_grand", null, _bReverse);
            addEffect(_loc_2, null, cbBgEffectControl);
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case "se1001":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_FLURET_FINALLETTER_SWISH);
                        break;
                    }
                    case "se1101":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_FLURET_FINALLETTER_Z);
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_1, this.cbSetEffectPhase);
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
                        setPhase(_PHASE_LEAVE);
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

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_FLURET_FINALLETTER_HIT);
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
            _baseMc.visible = false;
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
            return ResourcePath.SKILL_PATH + "Skill_SmallSword_FinalLetter.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_REV_FLURET_FINALLETTER_SWISH, SoundId.SE_REV_FLURET_FINALLETTER_Z, SoundId.SE_REV_FLURET_FINALLETTER_HIT];
            return _loc_1;
        }// end function

    }
}
