package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillEMagicHadesTemptation extends SkillMagicBase
    {

        public function SkillEMagicHadesTemptation(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_HADES))
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
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_DARK_TEMPTATION_EFFECT);
                        _loc_3 = ResourceManager.getInstance().createMovieClip(getResource(), "nullPosition");
                        if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
                        {
                            _loc_2 = _loc_3.playerNullMc;
                            _loc_1 = new Point(_loc_2.x, _loc_2.y);
                        }
                        else
                        {
                            _loc_2 = _loc_3.enemyNullMc;
                            _loc_1 = new Point(_loc_2.x, _loc_2.y);
                        }
                        _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_ACTTION_FRONT, _loc_1, _bReverse);
                        addEffect(_loc_4, this.cbSetEffectPhase);
                        _loc_5 = _battleManager.getDamageData();
                        for each (_loc_6 in _loc_5)
                        {
                            
                            for each (_loc_7 in _aTarget)
                            {
                                
                                if (_loc_6.type == 2 && _loc_6.questUniqueId == _loc_7.questUniqueId)
                                {
                                    SoundManager.getInstance().playSe(SoundId.SE_CHARM);
                                    _loc_8 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                                    addEffect(_loc_8);
                                }
                            }
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
                    playDamageAll();
                    break;
                }
                case _ACT_LABEL_END:
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
            return ResourcePath.SKILL_ENEMY_PATH + "Magic_Hades_Temptation.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_REV_DARK_TEMPTATION_EFFECT, SoundId.SE_CHARM];
            return _loc_1;
        }// end function

    }
}
