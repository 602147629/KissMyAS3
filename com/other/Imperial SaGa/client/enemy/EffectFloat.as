package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;

    public class EffectFloat extends EffectBase
    {
        protected var _bmp:Bitmap;
        protected var _pos:Point;
        protected var _vec:Point;
        protected var _liveTime:Number;
        protected var _centerPos:Point;
        private var _rot:Number;
        private var _rotVec:Number;
        private var _friction:Number;
        private static const _TIME_TO_APPEARANCE:Number = 0.2;
        private static const _TIME_TO_DISAPPEAR:Number = 0.5;
        private static const _MAX_VEC:Number = 200;

        public function EffectFloat(param1:DisplayObjectContainer, param2:BitmapData, param3:Point, param4:Point, param5:Number, param6:Number)
        {
            super(null, null, null);
            var _loc_7:* = param2.clone();
            this._bmp = new Bitmap(_loc_7);
            this._bmp.alpha = 0;
            this._pos = param3.clone();
            this._vec = param4.clone();
            this._rot = 0;
            this._rotVec = param5;
            this._centerPos = new Point(this._bmp.width * -0.5, this._bmp.height * -0.5);
            this._liveTime = param6;
            this._friction = 0;
            param1.addChild(this._bmp);
            return;
        }// end function

        public function get pos() : Point
        {
            return this._pos;
        }// end function

        public function set friction(param1:Number) : void
        {
            this._friction = param1;
            return;
        }// end function

        override public function isEnd() : Boolean
        {
            return this._liveTime <= 0;
        }// end function

        override public function release() : void
        {
            super.release();
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

        override public function control(param1:Number) : void
        {
            super.control(param1);
            this._liveTime = this._liveTime - param1;
            this._pos.x = this._pos.x + this._vec.x * param1;
            this._pos.y = this._pos.y + this._vec.y * param1;
            this._rot = this._rot + this._rotVec;
            var _loc_2:* = new Matrix();
            _loc_2.translate(this._centerPos.x, this._centerPos.y);
            _loc_2.rotate(this._rot * Math.PI / 180);
            _loc_2.translate(this._pos.x, this._pos.y);
            this._bmp.transform.matrix = _loc_2;
            var _loc_3:* = this._bmp.alpha;
            if (this._liveTime <= _TIME_TO_DISAPPEAR)
            {
                if (this._liveTime <= 0)
                {
                    this._liveTime = 0;
                }
                _loc_3 = this._liveTime / _TIME_TO_DISAPPEAR;
                if (_loc_3 > 1)
                {
                    _loc_3 = 1;
                }
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
            }
            else if (this._bmp.alpha < 1)
            {
                _loc_3 = _loc_3 + 1 / _TIME_TO_APPEARANCE * param1;
                if (_loc_3 > 1)
                {
                    _loc_3 = 1;
                }
            }
            this._bmp.alpha = _loc_3;
            this._vec.x = this._vec.x - this._vec.x * param1 * this._friction;
            this._vec.y = this._vec.y - this._vec.y * param1 * this._friction;
            return;
        }// end function

    }
}
