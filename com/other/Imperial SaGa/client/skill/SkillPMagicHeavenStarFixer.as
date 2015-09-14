package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class SkillPMagicHeavenStarFixer extends SkillMagicBase
    {
        private var _fade:Fade;

        public function SkillPMagicHeavenStarFixer(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_HEAVEN))
            {
                playCastingSE();
            }
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            if (isBoss() == false)
            {
                playCastingSE();
            }
            var _loc_1:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_ACTTION_FRONT, _targetHitFrontPos, _bReverse);
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
                    case _ACT_LABEL_HIT:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_LIGHT_STARFIXER);
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, _targetGrandPos, _bReverse);
                        addEffect(_loc_1, this.cbSetEffectPhase);
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

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    playDamageAll();
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
                    break;
                }
                default:
                {
                    break;
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
            return ResourcePath.SKILL_PATH + "Magic_Heaven_StarFixer.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_REV_LIGHT_STARFIXER];
            return _loc_1;
        }// end function

    }
}
