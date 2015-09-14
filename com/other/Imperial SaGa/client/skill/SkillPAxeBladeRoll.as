package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPAxeBladeRoll extends SkillAdvanceBase
    {

        public function SkillPAxeBladeRoll(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            _targetHitType = _TARGET_HIT_TYPE_FORMATION_FRONT;
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseWait() : void
        {
            super.phaseWait();
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            SoundManager.getInstance().playSe(SoundId.SE_ROUND2);
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case "se1101":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_AXE_BRADEROLL_SPIN);
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = 0;
                        while (_loc_1 < _aTarget.length)
                        {
                            
                            _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                            addEffect(_loc_2, this.cbSetEffectPhase);
                            _loc_1++;
                        }
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

        override protected function phaseLeave() : void
        {
            _baseMc.visible = false;
            super.phaseLeave();
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_GARYU);
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

        public static function getResource() : String
        {
            return ResourcePath.SKILL_PATH + "Skill_Axe_BladeRoll.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_ROUND2, SoundId.SE_GARYU, SoundId.SE_REV_AXE_BRADEROLL_SPIN];
            return _loc_1;
        }// end function

    }
}
