package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPSmallSwordRondoSword extends SkillAdvanceBase
    {

        public function SkillPSmallSwordRondoSword(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            _targetHitType = _TARGET_HIT_TYPE_FORMATION_FRONT;
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_FLURET_ENBUKEN_KAMAE);
            }
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case "se1001":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_FLURET_ENBUKEN_SWISH);
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = 0;
                        while (_loc_1 < _aTarget.length)
                        {
                            
                            _loc_2 = _aTarget[_loc_1];
                            _loc_3 = _loc_2.characterDisplay.getEffectNullMatrix();
                            _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_2.characterDisplay.pos.add(new Point(_loc_3.tx, _loc_3.ty)), _bReverse);
                            if (_loc_1 == 0)
                            {
                                addEffect(_loc_4, this.cbSetEffectPhase);
                            }
                            else
                            {
                                addEffect(_loc_4);
                            }
                            _loc_1++;
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
                    SoundManager.getInstance().playSe(SoundId.SE_AXE);
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
            return ResourcePath.SKILL_PATH + "Skill_SmallSword_RondoSword.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_AXE, SoundId.SE_REV_FLURET_ENBUKEN_KAMAE, SoundId.SE_REV_FLURET_ENBUKEN_SWISH];
            return _loc_1;
        }// end function

    }
}
