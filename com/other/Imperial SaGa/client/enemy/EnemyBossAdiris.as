package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class EnemyBossAdiris extends EnemyDisplay
    {
        private var _WAIT_EFFECT:Number = 1.6;
        private var _EFFECT_MAX:int = 4;
        private var _effectManager:EffectManager;
        private var _effectWaitTime:Number;
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_SWF_PATH + "Effect_Adiris_EF00.swf";

        public function EnemyBossAdiris(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._effectManager = new EffectManager();
            this._effectWaitTime = this._WAIT_EFFECT;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (this._effectManager)
            {
                this._effectManager.control(param1);
            }
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.controlAnim(param1);
            if (_mc.monster.currentFrameLabel == "ef1001" && this._effectManager.getEffectNum() < this._EFFECT_MAX)
            {
                _loc_2 = new EffectMc(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _EFFECT_PATH, "effectFrontMc", new Point());
                this._effectManager.addEffect(_loc_2);
                _loc_3 = new EffectMc(_layer.getLayer(LayerCharacter.BACK_EFFECT), _EFFECT_PATH, "effectBackMc", new Point());
                this._effectManager.addEffect(_loc_3);
            }
            this.playSeMotion();
            return;
        }// end function

        private function playSeMotion() : void
        {
            if (_bLabelAnimDetailChange == false)
            {
                return;
            }
            if (_labelAnimDetail == "se1001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_ADILIS_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_ADILIS_ATTACK_WING);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_ADILIS_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_ADILIS_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_ADILIS_MAGIC_WING);
            }
            if (_labelAnimDetail == "se2003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_ADILIS_MAGIC_SWISH);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [_EFFECT_PATH];
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_ADILIS_ATTACK_START, SoundId.SE_ADILIS_ATTACK_WING, SoundId.SE_ADILIS_ATTACK_SWISH, SoundId.SE_ADILIS_ATTACK_START, SoundId.SE_ADILIS_MAGIC_WING, SoundId.SE_ADILIS_MAGIC_SWISH];
        }// end function

    }
}
