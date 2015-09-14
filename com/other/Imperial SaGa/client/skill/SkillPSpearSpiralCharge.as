package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import layer.*;
    import player.*;
    import resource.*;
    import sound.*;

    public class SkillPSpearSpiralCharge extends SkillAdvanceBase
    {
        private var _aNullMc:Array;
        private var _aArrow:Array;
        private var _aCharacter:Array;

        public function SkillPSpearSpiralCharge(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            this._aCharacter = [];
            this._aArrow = [];
            this._aNullMc = [];
            this.createMirage();
            this.setAnimationPattarn();
            _baseMc.charaNull.visible = false;
            _baseMc.charaNull2.visible = false;
            _baseMc.charaNull3.visible = false;
            _baseMc.charaNull4.visible = false;
            _baseMc.shadow.visible = false;
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
            if (_baseMc.charaNull != null)
            {
                _baseMc.charaNull.visible = true;
            }
            if (_baseMc.charaNull2 != null)
            {
                _baseMc.charaNull2.visible = true;
            }
            if (_baseMc.charaNull3 != null)
            {
                _baseMc.charaNull3.visible = true;
            }
            if (_baseMc.charaNull4 != null)
            {
                _baseMc.charaNull4.visible = true;
            }
            _baseMc.shadow.visible = true;
            SoundManager.getInstance().playSe(SoundId.SE_RS3_SPEAR_CHARGE_DASH);
            SoundManager.getInstance().playSe(SoundId.SE_ROUND2);
            super.phaseAction();
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
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_1, this.cbSetEffectPhase);
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
                        _baseMc.gotoAndStop("end");
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
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SPEAR_CHARGE_STAB_WITH_A_SPEAR);
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
            return;
        }// end function

        override protected function controlLeave() : void
        {
            _baseMc.charaNull.visible = false;
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

        override protected function setAnimationPattarn() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_skillUser.type != CharacterDisplayBase.TYPE_PLAYER)
            {
                return;
            }
            var _loc_1:* = 0;
            while (_loc_1 < this._aCharacter.length)
            {
                
                _loc_2 = this._aCharacter[_loc_1];
                if (_loc_1 == 0)
                {
                    _loc_3 = _baseMc.getChildByName("charaNull".toString()) as MovieClip;
                }
                else
                {
                    _loc_3 = _baseMc.getChildByName("charaNull" + ((_loc_1 + 1)).toString()) as MovieClip;
                }
                _loc_2.setAnimationPattern(_loc_3);
                this._aNullMc.push(_loc_3);
                _loc_1++;
            }
            return;
        }// end function

        private function createMirage() : void
        {
            var _loc_3:* = null;
            if (_skillUser.type != CharacterDisplayBase.TYPE_PLAYER)
            {
                return;
            }
            this._aCharacter.push(_skillUser.characterDisplay);
            var _loc_1:* = _skillUserDisplay as PlayerDisplay;
            var _loc_2:* = 1;
            while (_loc_2 < 4)
            {
                
                _loc_3 = new PlayerDisplay(_layer.getLayer(LayerBattle.CHARACTER), _loc_1.info.id, _loc_1.uniqueId);
                this._aCharacter.push(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.SKILL_PATH + "Skill_Spear_SpiralCharge.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_RS3_SPEAR_CHARGE_STAB_WITH_A_SPEAR, SoundId.SE_RS3_SPEAR_CHARGE_DASH, SoundId.SE_ROUND2, SoundId.SE_JUMP2];
            return _loc_1;
        }// end function

    }
}
