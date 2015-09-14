package skill
{
    import battle.*;
    import effect.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPBigSwordSnowPlowBlade extends SkillAdvanceBase
    {
        private const _HIT_WAIT_FRAME:int = 2;
        private var _hitFrame:int = 0;
        private var _hitTargetIdx:int = 0;
        private var _sortTargetList:Array;

        public function SkillPBigSwordSnowPlowBlade(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
            super(param1, param2, param3, param4, param5, getResource());
            this._sortTargetList = [];
            var _loc_6:* = 0;
            while (_loc_6 < _aTarget.length)
            {
                
                _loc_7 = _aTarget[_loc_6];
                this._sortTargetList.push({idx:_loc_6, y:_loc_7.characterDisplay.pos.y});
                _loc_6++;
            }
            this._sortTargetList.sortOn("y", Array.NUMERIC | Array.DESCENDING);
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
            SoundManager.getInstance().playSe(SoundId.SE_REV_BIGSWORD_HOSSYA_KAMAE);
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
                        SoundManager.getInstance().playSe(SoundId.SE_REV_BIGSWORD_HOSSYA_SPIN);
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_BIGSWORD_KYOUGEKI);
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
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
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
            return ResourcePath.SKILL_PATH + "Skill_BigSword_SnowPlowBlade.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_REV_BIGSWORD_HOSSYA_KAMAE, SoundId.SE_REV_BIGSWORD_HOSSYA_SPIN, SoundId.SE_REV_BIGSWORD_KYOUGEKI];
            return _loc_1;
        }// end function

    }
}
