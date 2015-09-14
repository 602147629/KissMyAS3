package skill
{
    import battle.*;
    import effect.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillPMagicFireFrameWhip extends SkillMagicBase
    {
        private var animPattern:MovieClip;
        private var normalColorTransform:ColorTransform;

        public function SkillPMagicFireFrameWhip(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_FIRE))
            {
                playCastingSE();
            }
            this.animPattern = ResourceManager.getInstance().createMovieClip(getResource(), "action_front");
            this.animPattern.bgColorMc.play();
            this.animPattern.addEventListener(Event.ENTER_FRAME, this.BgEffect);
            this.normalColorTransform = _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform;
            _baseMc.addChild(this.animPattern);
            this.animPattern.play();
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        private function BgEffect(event:Event) : void
        {
            var _loc_2:* = MovieClip(event.target);
            _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform = _loc_2.bgColorMc.transform.colorTransform;
            if (_battleManager.battleScreen != null && _battleManager.battleScreen.getChildAt(0) != null)
            {
                _battleManager.battleScreen.getChildAt(0).transform.colorTransform = _loc_2.bgColorMc.transform.colorTransform;
            }
            if (_loc_2.currentFrame >= _loc_2.totalFrames)
            {
                _loc_2.removeEventListener(Event.ENTER_FRAME, this.BgEffect);
            }
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
                        _loc_1 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_1, this.cbSetEffectPhase);
                        _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.BACK_EFFECT), getResource(), _EFFECT_MC_GRAND, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_2);
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
                    SoundManager.getInstance().playSe(SoundId.SE_SWISH);
                    SoundManager.getInstance().playSe(SoundId.SE_BATTLE_FIRE);
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
            this.animPattern.removeEventListener(Event.ENTER_FRAME, this.BgEffect);
            _layer.getLayer(LayerBattle.BACKGROUND).transform.colorTransform = this.normalColorTransform;
            if (_battleManager.battleScreen != null && _battleManager.battleScreen.getChildAt(0) != null)
            {
                _battleManager.battleScreen.getChildAt(0).transform.colorTransform = this.normalColorTransform;
            }
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
            return ResourcePath.SKILL_PATH + "Magic_Fire_FrameWhip.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_SWISH, SoundId.SE_BATTLE_FIRE];
            return _loc_1;
        }// end function

    }
}
