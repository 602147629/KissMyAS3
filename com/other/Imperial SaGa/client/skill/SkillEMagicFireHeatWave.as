package skill
{
    import battle.*;
    import effect.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillEMagicFireHeatWave extends SkillMagicBase
    {

        public function SkillEMagicFireHeatWave(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_FIRE))
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
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        if (_bReverse)
                        {
                            _loc_1 = new Point(Constant.SCREEN_WIDTH, 0);
                        }
                        else
                        {
                            _loc_1 = new Point(0, 0);
                        }
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.POPUP_MESSAGE), getResource(), _EFFECT_ACTTION_FRONT, _loc_1, _bReverse);
                        addEffect(_loc_2, this.cbSetEffect);
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

        private function cbSetEffect(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            switch(param2)
            {
                case _ACT_LABEL_HIT:
                {
                    _loc_3 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, _targetHitFrontPos, _bReverse);
                    addEffect(_loc_3, this.cbSetEffectPhase, cbEffectControl);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_START:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_FIRE_HEATWAVE_EFFECT);
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_BATTLE_FIRE);
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
            return ResourcePath.SKILL_PATH + "Magic_Fire_HeatWave.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_FIRE_HEATWAVE_EFFECT, SoundId.SE_BATTLE_FIRE];
            return _loc_1;
        }// end function

    }
}
