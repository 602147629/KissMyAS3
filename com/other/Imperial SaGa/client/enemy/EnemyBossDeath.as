package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossDeath extends EnemyDisplay
    {
        private var _WAIT_EFFECT:Number = 2;
        private var _effectManager:EffectManager;
        private var _effectWaitTime:Number;
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_SWF_PATH + "Effect_Des_EF00.swf";

        public function EnemyBossDeath(param1:DisplayObjectContainer, param2:int, param3:int)
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
            super.control(param1);
            this._effectWaitTime = this._effectWaitTime - param1;
            if (this._effectWaitTime <= 0)
            {
                this._effectWaitTime = this._WAIT_EFFECT + Random.range(0, 20) * 0.1;
                if (_mc.currentLabel != _LABEL_DEAD && _mc.currentLabel != _LABEL_ATTACK && _mc.currentLabel != _LABEL_MAGIC)
                {
                    _loc_2 = new EffectMc(_layer.getLayer(LayerCharacter.BACK_EFFECT), _EFFECT_PATH, "effectBackMc", new Point());
                    this._effectManager.addEffect(_loc_2);
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_DES_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_DES_ATTACK_TAME);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_DES_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se1004")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_DES_ATTACK_LAND);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_DES_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_DES_MAGIC_TAME);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            return [_EFFECT_PATH];
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_DES_ATTACK_START, SoundId.SE_REV_DES_ATTACK_TAME, SoundId.SE_REV_DES_ATTACK_SWISH, SoundId.SE_REV_DES_ATTACK_LAND, SoundId.SE_REV_DES_ATTACK_START, SoundId.SE_REV_DES_MAGIC_TAME];
        }// end function

    }
}
