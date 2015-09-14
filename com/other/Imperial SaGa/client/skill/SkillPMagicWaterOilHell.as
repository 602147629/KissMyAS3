package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPMagicWaterOilHell extends SkillMagicBase
    {

        public function SkillPMagicWaterOilHell(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_WATER))
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
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case "shake_start":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_GROUND_RUMBLE);
                        _loc_1 = new EffectShake(_layer, 1, 1, 0.7);
                        _effectManager.addEffect(_loc_1);
                        if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren == Constant.EMPTY_ID)
                        {
                            _loc_3 = new EffectShake(_battleManager.battleScreen, 5, 5, 0.7);
                            _effectManager.addEffect(_loc_3);
                        }
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.BACKGROUND), getResource(), _EFFECT_MC_HIT, _targetGrandPos, _bReverse);
                        addEffect(_loc_2, this.cbSetEffectPhase);
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
                    SoundManager.getInstance().playSe(SoundId.SE_BATTLE_WATER);
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
            return ResourcePath.SKILL_PATH + "Magic_Water_OilHell.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_WATER, SoundId.SE_GROUND_RUMBLE];
            return _loc_1;
        }// end function

    }
}
