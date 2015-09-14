package effect
{
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class EffectParticleWaterParts extends Object
    {
        private var _VANISH_WAIT_TIME:Number = 0.2;
        private var _pos:Point;
        private var _scale:Number;
        private var _alpha:Number;
        private var _vec:Point;
        private var _setLiveTime:Number;
        private var _waitTime:Number;
        private var _bEnd:Boolean;
        private var _parent:BitmapData;
        private var _particleBitmap:BitmapData = null;
        private var _g:Number;

        public function EffectParticleWaterParts(param1:BitmapData, param2:BitmapData, param3:Point, param4:Point, param5:Number)
        {
            this._parent = param1;
            this._g = param5;
            this._particleBitmap = param2.clone();
            this._pos = param3;
            this._vec = param4;
            this.setLiveTime(2, 3);
            this._alpha = 0;
            this._bEnd = false;
            this._scale = 1;
            return;
        }// end function

        public function set pos(param1:Point) : void
        {
            this._pos = param1.clone();
            return;
        }// end function

        public function get scale() : Number
        {
            return this._scale;
        }// end function

        public function set scale(param1:Number) : void
        {
            this._scale = param1;
            return;
        }// end function

        public function get vec() : Point
        {
            return this._vec;
        }// end function

        public function set vec(param1:Point) : void
        {
            this._vec = param1.clone();
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function setLiveTime(param1:Number, param2:Number) : void
        {
            this._setLiveTime = Number(Random.range(param1 * 1000, param2 * 1000)) / 1000;
            this._waitTime = this._setLiveTime;
            return;
        }// end function

        public function release() : void
        {
            if (this._particleBitmap)
            {
                this._particleBitmap.dispose();
            }
            this._particleBitmap = null;
            this._parent = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = NaN;
            this._vec.y = this._vec.y + this._g * param1;
            this._pos.x = this._pos.x + this._vec.x * param1;
            this._pos.y = this._pos.y + this._vec.y * param1;
            this._waitTime = this._waitTime - param1;
            if (this._waitTime <= this._VANISH_WAIT_TIME)
            {
                this._alpha = 1 * (this._waitTime / this._VANISH_WAIT_TIME);
                if (this._waitTime <= 0)
                {
                    this._bEnd = true;
                }
            }
            else
            {
                _loc_2 = this._setLiveTime - this._waitTime;
                this._alpha = 1 * (_loc_2 / 0.2);
            }
            if (this._alpha < 0)
            {
                this._alpha = 0;
            }
            if (this._alpha > 1)
            {
                this._alpha = 1;
            }
            return;
        }// end function

        public function draw() : void
        {
            if (this._alpha == 0)
            {
                return;
            }
            var _loc_1:* = Math.abs(this._vec.y) / 50;
            if (_loc_1 < 0.5)
            {
                _loc_1 = 0.5;
            }
            if (_loc_1 > 1.2)
            {
                _loc_1 = 1.2;
            }
            var _loc_2:* = this._scale;
            var _loc_3:* = _loc_1 * this._scale;
            var _loc_4:* = new Matrix();
            new Matrix().scale(_loc_2, _loc_3);
            _loc_4.translate((-this._particleBitmap.width) * 0.5, (-this._particleBitmap.height) * 0.5);
            _loc_4.translate(this._pos.x, this._pos.y);
            var _loc_5:* = new ColorTransform(1, 1, 1, this._alpha);
            this._parent.draw(this._particleBitmap, _loc_4, _loc_5, BlendMode.ADD);
            return;
        }// end function

    }
}
