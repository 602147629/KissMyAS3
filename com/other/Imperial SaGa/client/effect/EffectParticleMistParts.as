package effect
{
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class EffectParticleMistParts extends Object
    {
        private var _VANISH_WAIT_TIME:Number = 1;
        private var _pos:Point;
        private var _offset:Point;
        private var _scale:Number;
        private var _bReverse:Boolean;
        private var _bSmoothing:Boolean;
        private var _alpha:Number;
        private var _vec:Point;
        private var _vecFriction:Number;
        private var _rot:Number;
        private var _rotAdd:Number;
        private var _waitTime:Number;
        private var _bEnd:Boolean;
        private var _parent:BitmapData;
        private var _mistBitmap:BitmapData = null;
        private var _setLiveTime:Number;
        private var _vanishWaitTime:Number;
        private var _maxAlpha:Number;
        private var _blendMode:String;
        private var _drawMultR:Number;
        private var _drawMultG:Number;
        private var _drawMultB:Number;
        private var _offsetColorR:int;
        private var _offsetColorG:int;
        private var _offsetColorB:int;

        public function EffectParticleMistParts(param1:BitmapData, param2:BitmapData, param3:Point, param4:Number)
        {
            this._vecFriction = 0;
            this._parent = param1;
            this._mistBitmap = param2.clone();
            this._pos = param3.clone();
            this._vec = new Point(0, param4);
            this._vec.x = Random.range(0, 50) - 25;
            this.setLiveTime(0.5, 1);
            this._scale = Random.range(100, 150) * 0.01;
            this._bReverse = false;
            this._bSmoothing = false;
            this._alpha = 0;
            this._maxAlpha = 1;
            this._rot = 0;
            this._rotAdd = Random.range(0, 50) - 25;
            this._blendMode = BlendMode.ADD;
            this.setDrawMultColor(1, 1, 1);
            this.setOffsetColor(0, 0, 0);
            this._vanishWaitTime = this._VANISH_WAIT_TIME;
            this._bEnd = false;
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

        public function get bReverse() : Boolean
        {
            return this._bReverse;
        }// end function

        public function set bReverse(param1:Boolean) : void
        {
            this._bReverse = param1;
            return;
        }// end function

        public function get bSmoothing() : Boolean
        {
            return this._bSmoothing;
        }// end function

        public function set bSmoothing(param1:Boolean) : void
        {
            this._bSmoothing = param1;
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

        public function set vecFriction(param1:Number) : void
        {
            this._vecFriction = param1;
            return;
        }// end function

        public function get rotAdd() : Number
        {
            return this._rotAdd;
        }// end function

        public function set rotAdd(param1:Number) : void
        {
            this._rotAdd = param1;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function set vanishWaitTime(param1:Number) : void
        {
            this._vanishWaitTime = param1;
            return;
        }// end function

        public function set maxAlpha(param1:Number) : void
        {
            this._maxAlpha = param1;
            return;
        }// end function

        public function set blendMode(param1:String) : void
        {
            this._blendMode = param1;
            return;
        }// end function

        public function setDrawMultColor(param1:Number, param2:Number, param3:Number) : void
        {
            this._drawMultR = param1;
            this._drawMultG = param2;
            this._drawMultB = param3;
            return;
        }// end function

        public function setOffsetColor(param1:int, param2:int, param3:int) : void
        {
            this._offsetColorR = param1;
            this._offsetColorG = param2;
            this._offsetColorB = param3;
            return;
        }// end function

        public function setLiveTime(param1:Number, param2:Number) : void
        {
            this._setLiveTime = Number(Random.range(param1 * 1000, param2 * 1000)) / 1000;
            this._waitTime = this._setLiveTime;
            return;
        }// end function

        public function release() : void
        {
            if (this._mistBitmap)
            {
                this._mistBitmap.dispose();
            }
            this._mistBitmap = null;
            this._parent = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = NaN;
            this._pos.x = this._pos.x + this._vec.x * param1;
            this._pos.y = this._pos.y + this._vec.y * param1;
            this._rot = this._rot + this._rotAdd;
            this._waitTime = this._waitTime - param1;
            if (this._waitTime <= this._vanishWaitTime)
            {
                this._alpha = 1 * (this._waitTime / this._vanishWaitTime);
                if (this._waitTime <= 0)
                {
                    this._bEnd = true;
                }
            }
            else
            {
                _loc_2 = this._setLiveTime - this._waitTime;
                this._alpha = this._maxAlpha * ((this._setLiveTime - this._waitTime) / this._vanishWaitTime);
            }
            if (this._alpha < 0)
            {
                this._alpha = 0;
            }
            if (this._alpha > this._maxAlpha)
            {
                this._alpha = this._maxAlpha;
            }
            this._vec.x = this._vec.x - this._vec.x * this._vecFriction * param1;
            this._vec.y = this._vec.y - this._vec.y * this._vecFriction * param1;
            return;
        }// end function

        public function draw() : void
        {
            if (this._alpha == 0)
            {
                return;
            }
            var _loc_1:* = new Matrix();
            _loc_1.translate((-this._mistBitmap.width) * 0.5, (-this._mistBitmap.height) * 0.5);
            if (this._bReverse)
            {
                _loc_1.scale(-this._scale, this._scale);
            }
            else
            {
                _loc_1.scale(this._scale, this._scale);
            }
            _loc_1.rotate(this._rot * Math.PI / 180);
            _loc_1.translate(this._pos.x, this._pos.y);
            var _loc_2:* = new ColorTransform(this._drawMultR, this._drawMultG, this._drawMultB, this._alpha);
            _loc_2.redOffset = this._offsetColorR;
            _loc_2.greenOffset = this._offsetColorG;
            _loc_2.blueOffset = this._offsetColorB;
            this._parent.draw(this._mistBitmap, _loc_1, _loc_2, this._blendMode, null, this._bSmoothing);
            return;
        }// end function

        public static function createFireBitmap(param1:Number) : BitmapData
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = new Matrix();
            _loc_3.createGradientBox(param1, param1, 0, 0, 0);
            var _loc_4:* = _loc_2.graphics;
            _loc_2.graphics.beginGradientFill(GradientType.RADIAL, [16744448, 16711680], [1, 0], [0, 255], _loc_3);
            _loc_4.drawCircle(param1 * 0.5, param1 * 0.5, param1);
            _loc_4.endFill();
            _loc_3.identity();
            _loc_3.translate(0, 0);
            var _loc_5:* = new BitmapData(param1, param1, true, 0);
            new BitmapData(param1, param1, true, 0).draw(_loc_2, _loc_3);
            return _loc_5;
        }// end function

    }
}
