package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPSpearWindmillCounterInit extends SkillPositionBase
    {

        public function SkillPSpearWindmillCounterInit(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
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
                        if (_skillUserDisplay.type == CharacterDisplayBase.TYPE_PLAYER)
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_ROUND2);
                        }
                        else
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_JUMP3);
                        }
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
            return ResourcePath.SKILL_PATH + "Skill_Spear_Windmill.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_ROUND2, SoundId.SE_JUMP3];
            return _loc_1;
        }// end function

        public static function getDefenceMcName() : String
        {
            return "defense_Windmill";
        }// end function

    }
}
