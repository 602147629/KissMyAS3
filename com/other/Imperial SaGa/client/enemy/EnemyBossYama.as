package enemy
{
    import flash.display.*;
    import flash.geom.*;

    public class EnemyBossYama extends EnemyDisplayAfterImage
    {

        public function EnemyBossYama(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            _blurPow = new Point(10, 15);
            _blurTime = 1.2;
            _blurLiveTime = 1.8;
            _blurVec = new Point(0, -10);
            _blurColor = new ColorTransform(1, 1, 1, 1, 32, 0, 32, 0);
            _blurEndColor = new ColorTransform(1, 1, 1, 0, 0, 32, 0, 0);
            _bBlurFront = false;
            _blendMode = BlendMode.SUBTRACT;
            setBlurEffect();
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            return;
        }// end function

    }
}
