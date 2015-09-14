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

    public class SkillEMagicWindDiamondDust extends SkillMagicBase
    {

        public function SkillEMagicWindDiamondDust(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_WIND))
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
            var _loc_1:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "action_front2", _targetHitFrontPos, _bReverse);
            addEffect(_loc_1, null, cbBgEffectControl);
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
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
                        SoundManager.getInstance().playSe(SoundId.SE_SNOWSTORM);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_1, _bReverse);
                        addEffect(_loc_5, null, this.cbEffect);
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

        private function cbEffect(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            for each (_loc_4 in _aTarget)
            {
                
                _loc_5 = _loc_4.characterDisplay;
                _loc_5.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_PLAY_SE:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_BATTLE_WIND);
                    break;
                }
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
            return ResourcePath.SKILL_ENEMY_PATH + "Magic_Wind_DiamondDust.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_SNOWSTORM, SoundId.SE_BATTLE_WIND];
            return _loc_1;
        }// end function

    }
}
