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

    public class SkillPMagicHeavenMoonlightHeel extends SkillMagicBase
    {
        private var _formationPos:Point;

        public function SkillPMagicHeavenMoonlightHeel(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            super(param1, param2, param3, param4, param5, getResource());
            var _loc_6:* = ResourceManager.getInstance().createMovieClip(getResource(), "nullPosition");
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_7 = _loc_6.playerNullMc;
                this._formationPos = new Point(_loc_7.x, _loc_7.y);
            }
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_8 = _loc_6.enemyNullMc;
                this._formationPos = new Point(_loc_8.x, _loc_8.y);
            }
            if (bossEffectCreate(_BOSS_ARIA_HEAVEN))
            {
                playCastingSE();
            }
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            this._formationPos = null;
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            if (isBoss() == false)
            {
                playCastingSE();
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
                    case _ACT_LABEL_HIT:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_LIGHT_MOONLIGHTHEAL_START);
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, this._formationPos, _bReverse);
                        addEffect(_loc_1, this.cbGrandEffect);
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

        private function cbGrandEffect(param1:EffectMc, param2:String) : void
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
                case _EFFECT_LABEL_START:
                {
                    break;
                }
                case "se1001":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_HERL);
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
            return ResourcePath.SKILL_PATH + "Magic_Heaven_MoonlightHeel.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_REV_LIGHT_MOONLIGHTHEAL_START, SoundId.SE_REV_HERL];
            return _loc_1;
        }// end function

    }
}
