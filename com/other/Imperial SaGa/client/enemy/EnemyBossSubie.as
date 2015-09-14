package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossSubie extends EnemyDisplay
    {
        private var _WAIT_EFFECT:Number = 2;
        private var _effectManager:EffectManager;
        private var _effectWaitTime:Number;
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_SWF_PATH + "Effect_Subie_EF00.swf";

        public function EnemyBossSubie(param1:DisplayObjectContainer, param2:int, param3:int)
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
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.control(param1);
            this._effectWaitTime = this._effectWaitTime - param1;
            if (this._effectWaitTime <= 0)
            {
                this._effectWaitTime = this._WAIT_EFFECT + Random.range(0, 20) * 0.1;
                if (_mc.currentLabel != _LABEL_DEAD && _mc.currentLabel != _LABEL_ATTACK && _mc.currentLabel != _LABEL_MAGIC)
                {
                    _loc_2 = new EffectMc(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _EFFECT_PATH, "effectFrontMc", new Point());
                    this._effectManager.addEffect(_loc_2);
                    _loc_3 = new EffectMc(_layer.getLayer(LayerCharacter.BACK_EFFECT), _EFFECT_PATH, "effectBackMc", new Point());
                    this._effectManager.addEffect(_loc_3);
                }
            }
            if (this._effectManager)
            {
                this._effectManager.control(param1);
            }
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_SUBIER_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SUBIER_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SUBIER_ATTACK_LAST);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SUBIER_MAGIC_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SUBIER_MAGIC_SWISH);
            }
            if (_labelAnimDetail == "se2003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SUBIER_MAGIC_RISE);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            return [_EFFECT_PATH];
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_SUBIER_ATTACK_START, SoundId.SE_REV_SUBIER_ATTACK_SWISH, SoundId.SE_REV_SUBIER_ATTACK_LAST, SoundId.SE_REV_SUBIER_MAGIC_START, SoundId.SE_REV_SUBIER_MAGIC_SWISH, SoundId.SE_REV_SUBIER_MAGIC_RISE];
        }// end function

    }
}
