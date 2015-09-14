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

    public class SkillPMagicEarthCrack extends SkillMagicBase
    {
        private var _shake:EffectShake;
        private var _formationPos1:Point;
        private var _formationPos2:Point;
        private var _formationPos3:Point;
        private var decidedPos:Point;

        public function SkillPMagicEarthCrack(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            super(param1, param2, param3, param4, param5, getResource());
            var _loc_6:* = ResourceManager.getInstance().createMovieClip(getResource(), "nullPosition");
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_7 = _loc_6.enemyNull1Mc;
                _loc_8 = _loc_6.enemyNull2Mc;
                _loc_9 = _loc_6.enemyNull3Mc;
            }
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_7 = _loc_6.playerNull1Mc;
                _loc_8 = _loc_6.playerNull2Mc;
                _loc_9 = _loc_6.playerNull3Mc;
            }
            this._formationPos1 = new Point(_loc_7.x, _loc_7.y);
            this._formationPos2 = new Point(_loc_8.x, _loc_8.y);
            this._formationPos3 = new Point(_loc_9.x, _loc_9.y);
            var _loc_10:* = _aTarget[0];
            var _loc_11:* = Point.distance(_loc_10.characterDisplay.pos, this._formationPos1);
            var _loc_12:* = Point.distance(_loc_10.characterDisplay.pos, this._formationPos2);
            var _loc_13:* = Point.distance(_loc_10.characterDisplay.pos, this._formationPos3);
            if (_loc_11 < _loc_12 && _loc_11 < _loc_13)
            {
                this.decidedPos = this._formationPos1;
            }
            if (_loc_12 < _loc_11 && _loc_12 < _loc_13)
            {
                this.decidedPos = this._formationPos2;
            }
            if (_loc_13 < _loc_11 && _loc_13 < _loc_12)
            {
                this.decidedPos = this._formationPos3;
            }
            if (bossEffectCreate(_BOSS_ARIA_EARTH))
            {
                playCastingSE();
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
            var _loc_2:* = null;
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_EARTH_CRACK);
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.BACK_EFFECT), getResource(), _EFFECT_MC_GRAND, this.decidedPos, _bReverse);
                        addEffect(_loc_1, this.cbSetEffectPhase);
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, this.decidedPos, _bReverse);
                        addEffect(_loc_2, this.cbSetEffectShakePhase);
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
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SPEAR_NORMAL_ATTACK);
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

        private function cbSetEffectShakePhase(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_SHAKE_START:
                {
                    this._shake = new EffectShake(_layer, 5, 5, 1000);
                    _effectManager.addEffect(this._shake);
                    if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren == Constant.EMPTY_ID)
                    {
                        _loc_3 = new EffectShake(_battleManager.battleScreen, 5, 5, 0.7);
                        _effectManager.addEffect(_loc_3);
                    }
                    break;
                }
                case _EFFECT_LABEL_SHAKE_END:
                {
                    _effectManager.releaseEffect(this._shake);
                    this._shake = null;
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
            return ResourcePath.SKILL_PATH + "Magic_Earth_Crack.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_REV_EARTH_CRACK, SoundId.SE_RS3_SPEAR_NORMAL_ATTACK];
            return _loc_1;
        }// end function

    }
}
