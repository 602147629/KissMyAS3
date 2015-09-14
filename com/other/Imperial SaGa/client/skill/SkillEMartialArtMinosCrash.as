package skill
{
    import battle.*;
    import effect.*;
    import enemy.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillEMartialArtMinosCrash extends SkillPositionBase
    {
        private var offset:Point;

        public function SkillEMartialArtMinosCrash(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            var _loc_1:* = _targetDisplay.getEffectNullMatrix();
            this.offset = new Point(_loc_1.tx, _loc_1.ty);
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "hit_chara", _targetHitFrontPos, _bReverse);
                        addEffect(_loc_1, null, this.cbEffectTranslateControl);
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_2, this.cbSetEffectPhase);
                        _loc_3 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, _targetGrandPos, _bReverse);
                        addEffect(_loc_3);
                        for each (_loc_4 in _aTarget)
                        {
                            
                            _loc_4.characterDisplay.setAnimDamage();
                        }
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

        private function cbEffectTranslateControl(param1:EffectMc, param2:String, param3:Number) : void
        {
            var _loc_4:* = new Matrix();
            new Matrix().translate(-this.offset.x, -this.offset.y);
            _loc_4.concat(param1.mcEffect.monsNull.transform.matrix);
            _loc_4.translate(this.offset.x, this.offset.y);
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
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_MART_KIDAN_DAMAGE);
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_MART_KUUKINAGE_DAMAGE);
                    playDamageAll();
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
            return ResourcePath.SKILL_ENEMY_PATH + "Skill_MartialArt_MinosCrash.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_REV_MART_KIDAN_DAMAGE, SoundId.SE_REV_MART_KUUKINAGE_DAMAGE];
            return _loc_1;
        }// end function

    }
}
