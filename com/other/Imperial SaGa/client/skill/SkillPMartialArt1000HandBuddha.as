package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPMartialArt1000HandBuddha extends SkillAdvanceBase
    {

        public function SkillPMartialArt1000HandBuddha(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            SoundManager.getInstance().playSe(SoundId.SE_REV_MART_SENJYUKANNON_KANNON);
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
                case _EFFECT_LABEL_DAMAGE_LOOP_START:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_MART_SENJYUKANNON_PUNCH);
                    _target.setActionDamageLoop();
                    break;
                }
                case _EFFECT_LABEL_DAMAGE:
                {
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LOOP_END:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_MART_SENJYUKANNON_CHARGE);
                    _target.setActionDamageLoopRelease();
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_MART_KIDAN_DAMAGE);
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
            return ResourcePath.SKILL_PATH + "Skill_MartialArt_1000HandBuddha.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_REV_MART_SENJYUKANNON_KANNON, SoundId.SE_REV_MART_SENJYUKANNON_PUNCH, SoundId.SE_REV_MART_SENJYUKANNON_CHARGE, SoundId.SE_REV_MART_KIDAN_DAMAGE];
            return _loc_1;
        }// end function

    }
}
