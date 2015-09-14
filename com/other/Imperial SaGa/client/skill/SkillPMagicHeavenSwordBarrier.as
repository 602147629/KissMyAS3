package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import layer.*;
    import player.*;
    import resource.*;
    import sound.*;

    public class SkillPMagicHeavenSwordBarrier extends SkillMagicBase
    {

        public function SkillPMagicHeavenSwordBarrier(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
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
                        skillUserPosMove(_aTarget[0], _EFFECT_MC_GRAND);
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.BACKGROUND), getResource(), _EFFECT_MC_HIT, _buffTargetDisPlay, _bReverse);
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
            switch(param2)
            {
                case _EFFECT_LABEL_START:
                {
                    if (_skillUser.questUniqueId == _target.questUniqueId)
                    {
                        _baseMc.visible = false;
                    }
                    if (_target.type == CharacterDisplayBase.TYPE_PLAYER)
                    {
                        _targetDisplay.mc.visible = false;
                        _loc_3 = _targetDisplay as PlayerDisplay;
                        _loc_4 = new PlayerDisplay(_target.characterDisplay.effectNull, _loc_3.info.id, _target.questUniqueId);
                        _loc_4.setAnimationPattern(param1.mcEffect.charaNull);
                    }
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_LIGHT_SWORDBARRIER_HIT);
                    playDamageAll();
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    _targetDisplay.mc.visible = true;
                    _baseMc.visible = true;
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
            return ResourcePath.SKILL_PATH + "Magic_Heaven_SwordBarrier.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_REV_LIGHT_SWORDBARRIER_HIT];
            return _loc_1;
        }// end function

    }
}
