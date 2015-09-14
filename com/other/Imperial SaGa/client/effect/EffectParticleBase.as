package effect
{
    import flash.display.*;
    import flash.geom.*;

    public class EffectParticleBase extends Object
    {
        protected var _bmp:Bitmap;
        protected var _pos:Point;
        protected var _vec:Point;
        protected var _liveTime:Number;
        protected var _centerPos:Point;
        protected var _bEnd:Boolean;

        public function EffectParticleBase()
        {
            this._pos = new Point();
            this._vec = new Point();
            return;
        }// end function

        public function get pos() : Point
        {
            return this._pos;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._bmp != null)
            {
                if (this._bmp.parent)
                {
                    this._bmp.parent.removeChild(this._bmp);
                }
                if (this._bmp.bitmapData)
                {
                    this._bmp.bitmapData.dispose();
                }
            }
            this._bmp = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

    }
}
