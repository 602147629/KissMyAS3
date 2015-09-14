package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class SkillPBigSwordSwallowCut extends SkillPositionBase
    {
        private var _fade:Fade;

        public function SkillPBigSwordSwallowCut(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.phaseAction();
            this._fade = new Fade(_layer.getLayer(LayerBattle.BACKGROUND));
            this._fade.maxAlpha = 0.8;
            this._fade.setFadeIn(30);
            switch(_skillUser.type)
            {
                case CharacterDisplayBase.TYPE_PLAYER:
                {
                    _loc_1 = _battleManager.getCharacter(_skillUser.questUniqueId) as BattlePlayer;
                    this.setCharacterDarkOut(_loc_1.division, _loc_1.personal.questUniqueId, true);
                    _loc_2 = _battleManager.getCharacter(_target.questUniqueId) as BattleEnemy;
                    this.setCharacterDarkOut(_loc_2.division, _loc_2.personal.questUniqueId, true);
                    break;
                }
                case CharacterDisplayBase.TYPE_ENEMY:
                {
                    _loc_2 = _battleManager.getCharacter(_skillUser.questUniqueId) as BattleEnemy;
                    this.setCharacterDarkOut(_loc_2.division, _loc_2.personal.questUniqueId, true);
                    _loc_1 = _battleManager.getCharacter(_target.questUniqueId) as BattlePlayer;
                    this.setCharacterDarkOut(_loc_1.division, _loc_1.personal.questUniqueId, true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function release() : void
        {
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            super.release();
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentFrameLabel)
                {
                    case "dark_on":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_BIGSWORD_TSUBAME_SHINE);
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_1, this.cbSetEffectPhase);
                        SoundManager.getInstance().playSe(SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK);
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
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            return;
        }// end function

        override protected function controlEnd() : void
        {
            super.controlEnd();
            return;
        }// end function

        private function setCharacterDarkOut(param1:int, param2:uint, param3:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param3)
            {
                if (param1 == BattleConstant.DIVISION_PLAYER)
                {
                    for each (_loc_4 in _battleManager.getEntryPlayer())
                    {
                        
                        if (_loc_4.personal.questUniqueId != param2)
                        {
                            _loc_4.characterAction.characterDisplay.bDarkOut = true;
                        }
                    }
                }
                if (param1 == BattleConstant.DIVISION_ENEMY)
                {
                    for each (_loc_5 in _battleManager.getEntryEnemy())
                    {
                        
                        if (_loc_5.personal.questUniqueId != param2)
                        {
                            _loc_5.characterAction.characterDisplay.bDarkOut = true;
                        }
                    }
                }
            }
            else
            {
                for each (_loc_6 in _battleManager.getEntryCharacter())
                {
                    
                    _loc_6.characterAction.characterDisplay.bDarkOut = false;
                }
            }
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.SKILL_PATH + "Skill_BigSword_SwallowCut.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK, SoundId.SE_REV_BIGSWORD_TSUBAME_SHINE];
            return _loc_1;
        }// end function

    }
}
