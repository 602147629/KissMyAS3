package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPSpearMeteorThrust extends SkillAdvanceBase
    {

        public function SkillPSpearMeteorThrust(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            _targetHitType = _TARGET_HIT_TYPE_GRAND;
            super(param1, param2, param3, param4, param5, getResource());
            _baseMc.visible = false;
            _baseMc.charaNull.weaponNull2.visible = false;
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseApproach() : void
        {
            super.phaseApproach();
            return;
        }// end function

        override protected function controlApproach() : void
        {
            super.controlApproach();
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _baseMc.visible = true;
            }
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
                    case _EFFECT_PLAY_SE:
                    {
                        if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_ROUND2);
                        }
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_RS3_SPEAR_SHOOTING_STAR_THRUST_SAVING_POWER);
                        _baseMc.charaNull.weaponNull2.visible = true;
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetGrandPos, _bReverse);
                        addEffect(_loc_1, this.cbSetEffectPhase);
                        break;
                    }
                    case "play_se2":
                    {
                        if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_AXE_SWISH);
                        }
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
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK);
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

        override protected function phaseLeave() : void
        {
            super.phaseLeave();
            _baseMc.visible = false;
            return;
        }// end function

        override protected function controlLeave() : void
        {
            super.controlLeave();
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
            return ResourcePath.SKILL_PATH + "Skill_Spear_MeteorThrust.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK, SoundId.SE_RS3_SPEAR_SHOOTING_STAR_THRUST_SAVING_POWER, SoundId.SE_AXE_SWISH, SoundId.SE_ROUND2];
            return _loc_1;
        }// end function

    }
}
