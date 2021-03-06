﻿package skill
{
    import battle.*;
    import effect.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillEClubGrandSlam extends SkillPositionBase
    {

        public function SkillEClubGrandSlam(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
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
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetGrandPos, _bReverse);
                        addEffect(_loc_1, this.cbSetEffectPhase);
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.BACKGROUND), getResource(), _EFFECT_MC_GRAND, _targetGrandPos, _bReverse);
                        addEffect(_loc_2);
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
            var _loc_3:* = null;
            var _loc_4:* = null;
            switch(param2)
            {
                case "shake_start":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_CLUB_GRAND_SLAM_EARTHQUAKE_SOUND);
                    _loc_3 = new EffectShake(_layer, 5, 5, 0.7);
                    _effectManager.addEffect(_loc_3);
                    if (_layer.getLayer(LayerBattle.BACKGROUND).numChildren == Constant.EMPTY_ID)
                    {
                        _loc_4 = new EffectShake(_battleManager.battleScreen, 5, 5, 0.7);
                        _effectManager.addEffect(_loc_4);
                    }
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    playDamageAll();
                    break;
                }
                case _EFFECT_LABEL_END:
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
            return ResourcePath.SKILL_ENEMY_PATH + "Skill_Club_GrandSlam.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_RS3_CLUB_GRAND_SLAM_SWING_DOWN_HEAVY, SoundId.SE_RS3_CLUB_GRAND_SLAM_EARTHQUAKE_SOUND];
            return _loc_1;
        }// end function

    }
}
