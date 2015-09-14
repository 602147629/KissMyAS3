package skill
{
    import battle.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class SkillPMagicHeavenMoonGlow extends SkillMagicBase
    {
        private var _fade:Fade;
        private var getBgMc:Boolean = false;

        public function SkillPMagicHeavenMoonGlow(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
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
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_LIGHT_MOONGROW_EFFECT);
                        _loc_2 = _baseMc.bulletStartNullMc;
                        _loc_3 = _skillUserDisplay.pos;
                        if (_bReverse)
                        {
                            _loc_1 = new Point(_loc_3.x - _loc_2.x, _loc_3.y + _loc_2.y);
                        }
                        else
                        {
                            _loc_1 = new Point(_loc_3.x + _loc_2.x, _loc_3.y + _loc_2.y);
                        }
                        _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _ACT_LABEL_START_FRONT, _loc_1, _bReverse);
                        addEffect(_loc_4, this.cbSetEffect);
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
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            switch(param2)
            {
                case _ACT_LABEL_HIT:
                {
                    _loc_3 = 0;
                    while (_loc_3 < _aTarget.length)
                    {
                        
                        _loc_4 = _aTarget[_loc_3];
                        skillUserPosMove(_loc_4);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _buffTargetDisPlay, _bReverse);
                        if (_loc_3 == 0)
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_CHARM);
                            addEffect(_loc_5, this.cbSetEffectPhase);
                        }
                        else
                        {
                            addEffect(_loc_5);
                        }
                        _loc_3++;
                    }
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
            return ResourcePath.SKILL_PATH + "Magic_Heaven_MoonGlow.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_CHARM, SoundId.SE_REV_LIGHT_MOONGROW_EFFECT];
            return _loc_1;
        }// end function

    }
}
