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

    public class SkillPClubGrandSlam extends SkillPositionBase
    {
        private var _shake:EffectShake;
        private var _formationPos:Point;

        public function SkillPClubGrandSlam(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
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
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override public function release() : void
        {
            if (this._shake != null)
            {
                this._shake.release();
                this._shake = null;
            }
            this._formationPos = null;
            super.release();
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            var _loc_1:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), "action_front", _targetGrandPos, _bReverse);
            addEffect(_loc_1, null, cbBgEffectControl);
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
                    case _EFFECT_PLAY_SE:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_RS3_CLUB_GRAND_SLAM_SWING_DOWN_HEAVY);
                        break;
                    }
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.BACKGROUND), getResource(), _EFFECT_MC_GRAND, this._formationPos, _bReverse);
                        addEffect(_loc_1, null);
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, this._formationPos, _bReverse);
                        addEffect(_loc_2, this.cbSetEffectPhase);
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
                case _EFFECT_LABEL_SHAKE_START:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_CLUB_GRAND_SLAM_EARTHQUAKE_SOUND);
                    this._shake = new EffectShake(_layer, 5, 5, 1000);
                    _effectManager.addEffect(this._shake);
                    break;
                }
                case _EFFECT_LABEL_SHAKE_END:
                {
                    _effectManager.releaseEffect(this._shake);
                    this._shake = null;
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
            return ResourcePath.SKILL_PATH + "Skill_Club_GrandSlam.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_RS3_CLUB_GRAND_SLAM_SWING_DOWN_HEAVY, SoundId.SE_RS3_CLUB_GRAND_SLAM_EARTHQUAKE_SOUND];
            return _loc_1;
        }// end function

    }
}
