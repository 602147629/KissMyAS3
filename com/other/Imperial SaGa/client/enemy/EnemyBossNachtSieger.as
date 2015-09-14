package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;

    public class EnemyBossNachtSieger extends EnemyDisplayAfterImage
    {
        private var _effectManager:EffectManager;

        public function EnemyBossNachtSieger(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            _blurPow = new Point(10, 0);
            _blurTime = 0.3;
            _blurLiveTime = 0.5;
            _blurVec = new Point(-50, -20);
            _blurColor = new ColorTransform(0.6, 0.6, 0.6, 1, 64, 48, 0, 0);
            _blurEndColor = new ColorTransform(0.2, 0.2, 0.2, 0, 64, 48, 0, 0);
            this._effectManager = new EffectManager();
            setBlurEffect();
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

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            return;
        }// end function

        public static function getResource() : Array
        {
            return [];
        }// end function

    }
}
