package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPMagicWaterSquall extends SkillMagicBase
    {

        public function SkillPMagicWaterSquall(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
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
            var _loc_3:* = 0;
            var _loc_4:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        _loc_3 = 0;
                        while (_loc_3 < _aTarget.length)
                        {
                            
                            _loc_4 = _aTarget[_loc_3];
                            _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.POPUP_MESSAGE), getResource(), _EFFECT_MC_HIT, _loc_4.characterDisplay.pos, _bReverse);
                            addEffect(_loc_1, null, cbEffectControl);
                            _loc_3++;
                        }
                        _targetHitFrontPos.x = Constant.SCREEN_WIDTH_HALF;
                        _targetHitFrontPos.y = Constant.SCREEN_HEIGHT_HALF;
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_ACTTION_FRONT, _targetHitFrontPos, _bReverse);
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
            var _loc_3:* = 0;
            var _loc_4:* = null;
            switch(param2)
            {
                case "se1101":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_WATER_SQUALL_RAIN);
                    break;
                }
                case _EFFECT_LABEL_DAMAGE:
                {
                    _loc_3 = 0;
                    while (_loc_3 < _aTarget.length)
                    {
                        
                        _loc_4 = _aTarget[_loc_3];
                        _loc_4.setActionDamage();
                        _loc_3++;
                    }
                    break;
                }
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
            return ResourcePath.SKILL_PATH + "Magic_Water_Squall.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_WATER, SoundId.SE_REV_WATER_SQUALL_RAIN];
            return _loc_1;
        }// end function

    }
}
