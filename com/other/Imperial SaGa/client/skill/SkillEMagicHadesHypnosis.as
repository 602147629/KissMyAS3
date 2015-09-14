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

    public class SkillEMagicHadesHypnosis extends SkillMagicBase
    {
        private const _HIT_WAIT_FRAME:int = 2;
        private var _isHitEffect:Boolean;
        private var _hitFrame:int = 0;
        private var _hitTargetIdx:int = 0;
        private var _formationPos:Point;

        public function SkillEMagicHadesHypnosis(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
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
            if (bossEffectCreate(_BOSS_ARIA_HADES))
            {
                playCastingSE();
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
            this._isHitEffect = false;
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
                        this._hitFrame = 0;
                        SoundManager.getInstance().playSe(SoundId.SE_BATTLE_SPACE);
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_ACTTION_FRONT, this._formationPos, _bReverse);
                        addEffect(_loc_1, null);
                        this._isHitEffect = true;
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
            if (this._isHitEffect)
            {
                var _loc_5:* = this;
                var _loc_6:* = this._hitFrame - 1;
                _loc_5._hitFrame = _loc_6;
                if (this._hitFrame <= 0)
                {
                    _loc_2 = _aTarget[this._hitTargetIdx];
                    _loc_3 = _loc_2.characterDisplay.getEffectNullMatrix();
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_2.characterDisplay.pos.add(new Point(_loc_3.tx, _loc_3.ty)), _bReverse);
                    var _loc_5:* = this;
                    var _loc_6:* = this._hitTargetIdx + 1;
                    _loc_5._hitTargetIdx = _loc_6;
                    if (this._hitTargetIdx >= _aTarget.length)
                    {
                        addEffect(_loc_4, this.cbSetEffectPhase);
                        this._hitFrame = 0;
                        this._isHitEffect = false;
                    }
                    else
                    {
                        addEffect(_loc_4);
                        this._hitFrame = this._hitFrame + this._HIT_WAIT_FRAME;
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
            return ResourcePath.SKILL_ENEMY_PATH + "Magic_Hades_Hypnosis.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_BATTLE_SPACE];
            return _loc_1;
        }// end function

    }
}
