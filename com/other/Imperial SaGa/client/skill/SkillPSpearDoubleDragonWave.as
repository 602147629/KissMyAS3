package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPSpearDoubleDragonWave extends SkillAdvanceBase
    {
        private const _HIT_WAIT_FRAME:int = 2;
        private var _hitFrame:int = 0;
        private var _hitTargetIdx:int = 0;
        private var _sortTargetList:Array;

        public function SkillPSpearDoubleDragonWave(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
            super(param1, param2, param3, param4, param5, getResource());
            this._sortTargetList = [];
            var _loc_6:* = 0;
            while (_loc_6 < _aTarget.length)
            {
                
                _loc_7 = _aTarget[_loc_6];
                this._sortTargetList.push({idx:_loc_6, x:_loc_7.characterDisplay.pos.x});
                _loc_6++;
            }
            this._sortTargetList.sortOn("x", Array.NUMERIC | Array.DESCENDING);
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override public function release() : void
        {
            this._sortTargetList = null;
            super.release();
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            var _loc_1:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "action_front", null, _bReverse);
            addEffect(_loc_1, null, cbBgEffectControl);
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SPEAR_SOURYUUHA_KAMAE);
            }
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case "se1001":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_SPEAR_SOURYUUHA_DRAGON1);
                        break;
                    }
                    case "se1002":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_SPEAR_SOURYUUHA_DRAGON2);
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        this._hitFrame = _baseMc.currentFrame;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (this._hitFrame > 0 && this._hitFrame <= _baseMc.currentFrame)
            {
                _loc_1 = _aTarget[this._sortTargetList[this._hitTargetIdx].idx];
                _loc_2 = _loc_1.characterDisplay.getEffectNullMatrix();
                _loc_3 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_1.characterDisplay.pos.add(new Point(_loc_2.tx, _loc_2.ty)), _bReverse);
                var _loc_4:* = this;
                var _loc_5:* = this._hitTargetIdx + 1;
                _loc_4._hitTargetIdx = _loc_5;
                if (this._hitTargetIdx >= _aTarget.length)
                {
                    addEffect(_loc_3, this.cbSetEffectPhase);
                    this._hitFrame = 0;
                }
                else
                {
                    addEffect(_loc_3);
                    this._hitFrame = this._hitFrame + this._HIT_WAIT_FRAME;
                }
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE:
                {
                    for each (_loc_3 in _aTarget)
                    {
                        
                        _loc_3.characterDisplay.setAnimDamage();
                    }
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK);
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SPEAR_NORMAL_ATTACK);
                    playDamageAll();
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    setPhase(_PHASE_LEAVE);
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
            return ResourcePath.SKILL_PATH + "Skill_Spear_DoubleDragonWave.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_REV_SPEAR_SOURYUUHA_KAMAE, SoundId.SE_REV_SPEAR_SOURYUUHA_DRAGON1, SoundId.SE_REV_SPEAR_SOURYUUHA_DRAGON2, SoundId.SE_RS3_BIGSWORD_NORMAL_ATTACK, SoundId.SE_RS3_SPEAR_NORMAL_ATTACK];
            return _loc_1;
        }// end function

    }
}
