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

    public class SkillEMagicWaterWhirlpools extends SkillMagicBase
    {
        private var _formationPos:Point;

        public function SkillEMagicWaterWhirlpools(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_WATER))
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

        override public function release() : void
        {
            this._formationPos = null;
            super.release();
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
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_WATER_UZUSHIO_EFFECT);
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, this._formationPos, _bReverse);
                        addEffect(_loc_1, null, this.cbEffectPlayerControl);
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.BACK_EFFECT), getResource(), _EFFECT_MC_GRAND, this._formationPos, _bReverse);
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

        private function cbBgEffectControl1(param1:EffectMc, param2:String, param3:Number) : void
        {
            if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren != Constant.EMPTY_ID)
            {
                _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform = param1.mcEffect.bgColorMc.transform.colorTransform;
            }
            else
            {
                _battleManager.battleScreen.getChildByName("bgMc").transform.colorTransform = param1.mcEffect.bgColorMc.transform.colorTransform;
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_WATER_GUN_DAMAGE);
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

        private function cbEffectPlayerControl(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = null;
            for each (_loc_4 in _aTarget)
            {
                
                _loc_4.characterDisplay.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
                _loc_4.characterDisplay.mc.filters = param1.mcEffect.monsNull.filters;
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
            return ResourcePath.SKILL_PATH + "Magic_Water_Whirlpools.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_REV_WATER_UZUSHIO_EFFECT, SoundId.SE_REV_WATER_GUN_DAMAGE];
            return _loc_1;
        }// end function

    }
}
