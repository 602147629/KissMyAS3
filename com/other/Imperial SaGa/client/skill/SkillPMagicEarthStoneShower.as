package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPMagicEarthStoneShower extends SkillMagicBase
    {

        public function SkillPMagicEarthStoneShower(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_EARTH))
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
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
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
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            switch(param2)
            {
                case "shake_start":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_GROUND_RUMBLE);
                    SoundManager.getInstance().playSe(SoundId.SE_BATTLE_GROUND);
                    _loc_3 = new EffectShake(_layer, 5, 5, 0.7);
                    _effectManager.addEffect(_loc_3);
                    if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren == Constant.EMPTY_ID)
                    {
                        _loc_4 = new EffectShake(_battleManager.battleScreen, 5, 5, 0.7);
                        _effectManager.addEffect(_loc_4);
                    }
                    break;
                }
                case _EFFECT_LABEL_DAMAGE:
                {
                    for each (_loc_5 in _aTarget)
                    {
                        
                        _loc_5.setActionDamage();
                    }
                    break;
                }
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
            return ResourcePath.SKILL_PATH + "Magic_Earth_StoneShower.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_GROUND, SoundId.SE_GROUND_RUMBLE];
            return _loc_1;
        }// end function

    }
}
