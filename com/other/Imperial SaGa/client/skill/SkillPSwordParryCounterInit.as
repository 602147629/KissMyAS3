package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPSwordParryCounterInit extends SkillPositionBase
    {

        public function SkillPSwordParryCounterInit(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
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
                    case _ACT_LABEL_HIT:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_PARRY);
                        playDamageAll();
                        break;
                    }
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

        public static function getResource() : String
        {
            return ResourcePath.SKILL_PATH + "Skill_Sword_Parry.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_RS3_SWORD_PARRY];
            return _loc_1;
        }// end function

        public static function getDefenceMcName() : String
        {
            return "defense_Parry";
        }// end function

    }
}
