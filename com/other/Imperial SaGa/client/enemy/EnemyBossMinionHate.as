package enemy
{
    import flash.display.*;
    import flash.geom.*;

    public class EnemyBossMinionHate extends EnemyDisplayAfterImage
    {

        public function EnemyBossMinionHate(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            _blurPow = new Point(30, 30);
            _blurTime = 2.2;
            _blurLiveTime = 2.8;
            _blurVec = new Point(0, 0);
            _blurColor = new ColorTransform(1, 1, 1, 1, 64, 64, 64, 0);
            _blurEndColor = new ColorTransform(1, 1, 1, 0, 64, 64, 64, 0);
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
