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

    public class SkillPBigSwordChaoticFlowerfall extends SkillAdvanceBase
    {
        private var _formationPos:Point;

        public function SkillPBigSwordChaoticFlowerfall(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
            _targetHitType = _TARGET_HIT_TYPE_GRAND;
            super(param1, param2, param3, param4, param5, getResource());
            var _loc_6:* = ResourceManager.getInstance().createMovieClip(getResource(), "nullPosition");
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_7 = _loc_6.playerNullMc;
                this._formationPos = new Point(_loc_7.x, _loc_7.y);
            }
            else
            {
                _loc_7 = _loc_6.enemyNullMc;
                this._formationPos = new Point(_loc_7.x, _loc_7.y);
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
            var _loc_1:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "action_front", this._formationPos, _bReverse);
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
                    case "se1001":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_BIGSWORD_SETSUGEKKA_BRIZARD);
                        break;
                    }
                    case "se1101":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_BIGSWORD_SETSUGEKKA_YUKI);
                        break;
                    }
                    case "se1201":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_BIGSWORD_SETSUGEKKA_TSUKI);
                        break;
                    }
                    case "se1301":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_BIGSWORD_SETSUGEKKA_SWORD);
                        break;
                    }
                    case "se1401":
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_BIGSWORD_SETSUGEKKA_HANA);
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, _targetGrandPos, false);
                        addEffect(_loc_1, this.cbSetEffectPhase);
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
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE:
                {
                    _target.setActionDamage();
                    break;
                }
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

        public static function getResource() : String
        {
            return ResourcePath.SKILL_PATH + "Skill_BigSword_ChaoticFlowerfall.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_REV_BIGSWORD_SETSUGEKKA_BRIZARD, SoundId.SE_REV_BIGSWORD_SETSUGEKKA_YUKI, SoundId.SE_REV_BIGSWORD_SETSUGEKKA_TSUKI, SoundId.SE_REV_BIGSWORD_SETSUGEKKA_SWORD, SoundId.SE_REV_BIGSWORD_SETSUGEKKA_HANA];
            return _loc_1;
        }// end function

    }
}
