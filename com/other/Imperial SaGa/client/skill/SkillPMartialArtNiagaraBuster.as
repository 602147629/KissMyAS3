package skill
{
    import battle.*;
    import effect.*;
    import enemy.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPMartialArtNiagaraBuster extends SkillAdvanceBase
    {
        private var _isFollow:Boolean = false;
        private var _isFollow2:Boolean = false;
        private var _offset:Point;
        private var _nullActCharaMc:MovieClip;

        public function SkillPMartialArtNiagaraBuster(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            _targetHitType = _TARGET_HIT_TYPE_GRAND;
            super(param1, param2, param3, param4, param5, getResource());
            this._nullActCharaMc = ResourceManager.getInstance().createMovieClip(getResource(), "chara_act_null");
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            var _loc_1:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "action_front", null, _bReverse);
            addEffect(_loc_1, null, cbBgEffectControl);
            var _loc_2:* = _targetDisplay.getEffectNullMatrix();
            this._offset = new Point(_loc_2.tx, _loc_2.ty);
            this._nullActCharaMc.gotoAndPlay(_ACT_LABEL_START);
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
                        SoundManager.getInstance().playSe(SoundId.SE_JUMP1016);
                        break;
                    }
                    case "se1101":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_MART_NIAGARA_FALL);
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetGrandPos, _bReverse);
                        addEffect(_loc_1, this.cbSetEffectPhase);
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, _targetGrandPos, _bReverse);
                        addEffect(_loc_2);
                        _loc_3 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "hit_chara", _targetHitFrontPos, _bReverse);
                        addEffect(_loc_3, null, this.cbEffecttranslateControl);
                        SoundManager.getInstance().playSe(SoundId.SE_MART_NIAGARA_UP);
                        break;
                    }
                    case "positionMoveStart":
                    {
                        this._isFollow = true;
                        break;
                    }
                    case "positionMoveEnd":
                    {
                        this._isFollow = false;
                        this._isFollow2 = true;
                        _skillUserMc.y = 0;
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
                        setPhase(_PHASE_LEAVE);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (this._isFollow2)
            {
                _skillUserMc.x = this._nullActCharaMc.charaNull.x;
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_MART_NIAGARA_HIT);
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

        private function cbEffecttranslateControl(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = new Matrix();
            new Matrix().translate(-this._offset.x, -this._offset.y);
            _loc_4.concat(param1.mcEffect.monsNull.transform.matrix);
            _loc_4.translate(this._offset.x, this._offset.y);
            var _loc_5:* = _targetDisplay as EnemyDisplay;
            var _loc_6:* = true;
            if (_loc_5 && _loc_5.info.bNotDamageMove)
            {
                _loc_6 = false;
            }
            if (_loc_6)
            {
                _targetDisplay.mc.transform.matrix = _loc_4;
            }
            if (this._isFollow)
            {
                _skillUserMc.y = param1.mcEffect.monsNull.y - 90;
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
            return ResourcePath.SKILL_PATH + "Skill_MartialArt_NiagaraBuster.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_JUMP1016, SoundId.SE_MART_NIAGARA_UP, SoundId.SE_MART_NIAGARA_FALL, SoundId.SE_MART_NIAGARA_HIT];
            return _loc_1;
        }// end function

    }
}
