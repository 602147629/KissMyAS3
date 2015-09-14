package skill
{
    import battle.*;
    import effect.*;
    import flash.display.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPAxeHeelCut extends SkillAdvanceBase
    {
        private var PositionCharaAnimation:MovieClip;

        public function SkillPAxeHeelCut(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            _targetHitType = _TARGET_HIT_TYPE_GRAND;
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
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
                        SoundManager.getInstance().playSe(SoundId.SE_REV_AXE_KAKATO_REVERSE);
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetGrandPos, _bReverse);
                        addEffect(_loc_1, this.setEffectPhase);
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

        private function setEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_AXE);
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
            return ResourcePath.SKILL_PATH + "Skill_Axe_HeelCut.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_REV_AXE_KAKATO_REVERSE, SoundId.SE_AXE];
            return _loc_1;
        }// end function

    }
}
