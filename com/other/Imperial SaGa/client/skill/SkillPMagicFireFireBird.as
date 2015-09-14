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

    public class SkillPMagicFireFireBird extends SkillMagicBase
    {
        private var _formationPos:Point;

        public function SkillPMagicFireFireBird(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_FIRE))
            {
                playCastingSE();
            }
            var _loc_6:* = ResourceManager.getInstance().createMovieClip(getResource(), "nullPosition");
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_7 = _loc_6.enemyNullMc;
                this._formationPos = new Point((_loc_7.x + _loc_7.width) / 2, (_loc_7.y + _loc_7.height) / 2);
            }
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_8 = _loc_6.playerNullMc;
                this._formationPos = new Point(_loc_8.x, _loc_8.y);
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
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_ACTTION_FRONT, this._formationPos, _bReverse);
                        addEffect(_loc_1, null, this.cbBgEffectControl);
                        SoundManager.getInstance().playSe(SoundId.SE_FIRE_BIRD_APPEAR);
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

        override protected function cbBgEffectControl(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            super.cbBgEffectControl(param1, param2, param3);
            switch(param1.mcEffect.currentFrameLabel)
            {
                case "se1001":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_FIRE_BIRD_EFFECT);
                    break;
                }
                case _ACT_LABEL_HIT:
                {
                    _loc_4 = 0;
                    while (_loc_4 < _aTarget.length)
                    {
                        
                        _loc_5 = _aTarget[_loc_4];
                        _loc_6 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, _loc_5.characterDisplay.pos, _bReverse);
                        if (_loc_4 == 0)
                        {
                            addEffect(_loc_6, this.cbSetEffectPhase, cbEffectControl);
                        }
                        else
                        {
                            addEffect(_loc_6, null, cbEffectControl);
                        }
                        _loc_4++;
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
                    SoundManager.getInstance().playSe(SoundId.SE_BATTLE_FIRE);
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
            return ResourcePath.SKILL_PATH + "Magic_Fire_FireBird.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_FIRE_BIRD_APPEAR, SoundId.SE_FIRE_BIRD_EFFECT, SoundId.SE_BATTLE_FIRE];
            return _loc_1;
        }// end function

    }
}
