package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillESwordGekikenha extends SkillPositionBase
    {

        public function SkillESwordGekikenha(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
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
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = 0;
                        while (_loc_1 < _aTarget.length)
                        {
                            
                            _loc_2 = _aTarget[_loc_1];
                            if (_loc_1 == 0)
                            {
                                _loc_3 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_2.characterDisplay.pos, _bReverse);
                                addEffect(_loc_3, this.cbSetEffectPhase);
                            }
                            else
                            {
                                _loc_3 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_2.characterDisplay.pos, _bReverse);
                                addEffect(_loc_3);
                            }
                            _loc_1++;
                        }
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
                    SoundManager.getInstance().playSe(SoundId.SE_REV_SWORD_HAYABUSAGIRI);
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
            return ResourcePath.SKILL_ENEMY_PATH + "Skill_Sword_Gekikenha.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_REV_SWORD_HAYABUSAGIRI];
            return _loc_1;
        }// end function

    }
}
