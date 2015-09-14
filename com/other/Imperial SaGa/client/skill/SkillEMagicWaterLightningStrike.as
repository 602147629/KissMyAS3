package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class SkillEMagicWaterLightningStrike extends SkillMagicBase
    {
        private var EFFECT_NAME:Array;
        private var count:int = 0;

        public function SkillEMagicWaterLightningStrike(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            this.EFFECT_NAME = ["hit_grand1", "hit_grand2", "hit_grand3"];
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_WATER))
            {
                playCastingSE();
            }
            this.count = 0;
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
            var _loc_1:* = 0;
            var _loc_2:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = Random.range(0, 2);
                        SoundManager.getInstance().playSe(SoundId.SE_ELECTRIC_SHOCK);
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), this.EFFECT_NAME[_loc_1], _targetHitFrontPos, _bReverse);
                        addEffect(_loc_2, this.cbSetEffectPhase1, this.cbEffectControl1);
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

        private function cbEffectControl1(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = _aTarget[0];
            var _loc_5:* = _aTarget[0].characterDisplay;
            _aTarget[0].characterDisplay.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            return;
        }// end function

        private function cbSetEffectPhase1(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = _aTarget[this.count];
                    playDamage(_loc_3);
                    if (_aTarget.length > 1)
                    {
                        _loc_4 = Random.range(0, 2);
                        var _loc_6:* = this;
                        var _loc_7:* = this.count + 1;
                        _loc_6.count = _loc_7;
                        SoundManager.getInstance().playSe(SoundId.SE_ELECTRIC_SHOCK);
                        setTarget(_aTarget[1]);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), this.EFFECT_NAME[_loc_4], _targetHitFrontPos, _bReverse);
                        addEffect(_loc_5, this.cbSetEffectPhase2, this.cbEffectControl2);
                    }
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    if (_aTarget.length <= 1)
                    {
                        _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
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

        private function cbEffectControl2(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = _aTarget[1];
            var _loc_5:* = _aTarget[1].characterDisplay;
            _aTarget[1].characterDisplay.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            return;
        }// end function

        private function cbSetEffectPhase2(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = _aTarget[this.count];
                    playDamage(_loc_3);
                    if (_aTarget.length > 2)
                    {
                        _loc_4 = Random.range(0, 2);
                        var _loc_6:* = this;
                        var _loc_7:* = this.count + 1;
                        _loc_6.count = _loc_7;
                        SoundManager.getInstance().playSe(SoundId.SE_ELECTRIC_SHOCK);
                        setTarget(_aTarget[2]);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), this.EFFECT_NAME[_loc_4], _targetHitFrontPos, _bReverse);
                        addEffect(_loc_5, this.cbSetEffectPhase3, this.cbEffectControl3);
                    }
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    if (_aTarget.length <= 2)
                    {
                        _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
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

        private function cbEffectControl3(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = _aTarget[2];
            var _loc_5:* = _aTarget[2].characterDisplay;
            _aTarget[2].characterDisplay.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            return;
        }// end function

        private function cbSetEffectPhase3(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = _aTarget[this.count];
                    playDamage(_loc_3);
                    if (_aTarget.length > 3)
                    {
                        _loc_4 = Random.range(0, 2);
                        var _loc_6:* = this;
                        var _loc_7:* = this.count + 1;
                        _loc_6.count = _loc_7;
                        SoundManager.getInstance().playSe(SoundId.SE_ELECTRIC_SHOCK);
                        setTarget(_aTarget[3]);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), this.EFFECT_NAME[_loc_4], _targetHitFrontPos, _bReverse);
                        addEffect(_loc_5, this.cbSetEffectPhase4, this.cbEffectControl4);
                    }
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    if (_aTarget.length <= 3)
                    {
                        _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
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

        private function cbEffectControl4(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = _aTarget[3];
            var _loc_5:* = _aTarget[3].characterDisplay;
            _aTarget[3].characterDisplay.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            return;
        }// end function

        private function cbSetEffectPhase4(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = _aTarget[this.count];
                    playDamage(_loc_3);
                    if (_aTarget.length > 4)
                    {
                        _loc_4 = Random.range(0, 2);
                        var _loc_6:* = this;
                        var _loc_7:* = this.count + 1;
                        _loc_6.count = _loc_7;
                        SoundManager.getInstance().playSe(SoundId.SE_ELECTRIC_SHOCK);
                        setTarget(_aTarget[4]);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), this.EFFECT_NAME[_loc_4], _targetHitFrontPos, _bReverse);
                        addEffect(_loc_5, this.cbSetEffectPhase5, this.cbEffectControl5);
                    }
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    if (_aTarget.length <= 4)
                    {
                        _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
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

        private function cbEffectControl5(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = _aTarget[4];
            var _loc_5:* = _aTarget[4].characterDisplay;
            _aTarget[4].characterDisplay.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            return;
        }// end function

        private function cbSetEffectPhase5(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = _aTarget[this.count];
                    playDamage(_loc_3);
                    if (_aTarget.length > 5)
                    {
                        _loc_4 = Random.range(0, 2);
                        var _loc_6:* = this;
                        var _loc_7:* = this.count + 1;
                        _loc_6.count = _loc_7;
                        SoundManager.getInstance().playSe(SoundId.SE_ELECTRIC_SHOCK);
                        setTarget(_aTarget[5]);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), this.EFFECT_NAME[_loc_4], _targetHitFrontPos, _bReverse);
                        addEffect(_loc_5, this.cbSetEffectPhase6, this.cbEffectControl6);
                    }
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    if (_aTarget.length <= 5)
                    {
                        _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
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

        private function cbEffectControl6(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = _aTarget[5];
            var _loc_5:* = _aTarget[5].characterDisplay;
            _aTarget[5].characterDisplay.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            return;
        }// end function

        private function cbSetEffectPhase6(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = _aTarget[this.count];
                    playDamage(_loc_3);
                    if (_aTarget.length > 6)
                    {
                        _loc_4 = Random.range(0, 2);
                        var _loc_6:* = this;
                        var _loc_7:* = this.count + 1;
                        _loc_6.count = _loc_7;
                        SoundManager.getInstance().playSe(SoundId.SE_ELECTRIC_SHOCK);
                        setTarget(_aTarget[6]);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), this.EFFECT_NAME[_loc_4], _targetHitFrontPos, _bReverse);
                        addEffect(_loc_5, this.cbSetEffectPhase7, this.cbEffectControl7);
                    }
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    if (_aTarget.length <= 6)
                    {
                        _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
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

        private function cbEffectControl7(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = _aTarget[6];
            var _loc_5:* = _aTarget[6].characterDisplay;
            _aTarget[6].characterDisplay.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            return;
        }// end function

        private function cbSetEffectPhase7(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = _aTarget[this.count];
                    playDamage(_loc_3);
                    if (_aTarget.length > 7)
                    {
                        _loc_4 = Random.range(0, 2);
                        var _loc_6:* = this;
                        var _loc_7:* = this.count + 1;
                        _loc_6.count = _loc_7;
                        SoundManager.getInstance().playSe(SoundId.SE_ELECTRIC_SHOCK);
                        setTarget(_aTarget[7]);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), this.EFFECT_NAME[_loc_4], _targetHitFrontPos, _bReverse);
                        addEffect(_loc_5, this.cbSetEffectPhase8, this.cbEffectControl8);
                    }
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    if (_aTarget.length <= 7)
                    {
                        _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
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

        private function cbEffectControl8(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = _aTarget[7];
            var _loc_5:* = _aTarget[7].characterDisplay;
            _aTarget[7].characterDisplay.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            return;
        }// end function

        private function cbSetEffectPhase8(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = _aTarget[this.count];
                    playDamage(_loc_3);
                    if (_aTarget.length > 8)
                    {
                        _loc_4 = Random.range(0, 2);
                        var _loc_6:* = this;
                        var _loc_7:* = this.count + 1;
                        _loc_6.count = _loc_7;
                        SoundManager.getInstance().playSe(SoundId.SE_ELECTRIC_SHOCK);
                        setTarget(_aTarget[8]);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), this.EFFECT_NAME[_loc_4], _targetHitFrontPos, _bReverse);
                        addEffect(_loc_5, this.cbSetEffectPhase9, this.cbEffectControl9);
                    }
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    if (_aTarget.length <= 8)
                    {
                        _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
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

        private function cbEffectControl9(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = _aTarget[8];
            var _loc_5:* = _aTarget[8].characterDisplay;
            _aTarget[8].characterDisplay.mc.transform.colorTransform = param1.mcEffect.monsNull.transform.colorTransform;
            return;
        }// end function

        private function cbSetEffectPhase9(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = _aTarget[this.count];
                    playDamage(_loc_3);
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
            return ResourcePath.SKILL_ENEMY_PATH + "Magic_Water_LightningStrike.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_SPACE, SoundId.SE_ELECTRIC_SHOCK];
            return _loc_1;
        }// end function

    }
}
