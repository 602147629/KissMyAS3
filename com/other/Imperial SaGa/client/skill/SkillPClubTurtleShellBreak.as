package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPClubTurtleShellBreak extends SkillAdvanceBase
    {

        public function SkillPClubTurtleShellBreak(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            _targetHitType = _TARGET_HIT_TYPE_GRAND;
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            var _loc_1:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "action_front", _targetGrandPos, _bReverse);
            addEffect(_loc_1, null, cbBgEffectControl);
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
                        SoundManager.getInstance().playSe(SoundId.SE_REV_AXE_SKYDRIVE_JUMP);
                        break;
                    }
                    case "se1101":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_CLUB_KAME_FALL);
                        break;
                    }
                    case "se1201":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_CLUB_KAME_HIT);
                        break;
                    }
                    case "se1301":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_CLUB_KAME_CHARGE);
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetGrandPos, _bReverse);
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
                    SoundManager.getInstance().playSe(SoundId.SE_REV_CLUB_KAME_BREAK);
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
            return ResourcePath.SKILL_PATH + "Skill_Club_TurtleShellBreak.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_REV_AXE_SKYDRIVE_JUMP, SoundId.SE_REV_CLUB_KAME_FALL, SoundId.SE_REV_CLUB_KAME_HIT, SoundId.SE_REV_CLUB_KAME_CHARGE, SoundId.SE_REV_CLUB_KAME_BREAK];
            return _loc_1;
        }// end function

    }
}
