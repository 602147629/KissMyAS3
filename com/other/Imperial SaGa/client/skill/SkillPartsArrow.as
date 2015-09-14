package skill
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;

    public class SkillPartsArrow extends Object
    {
        private var _mc:MovieClip;
        private var _pos:Point;
        private var _vec:Point;
        private var _w:int;
        private var _hitWaitTime:Number;
        private var _bHitWait:Boolean;
        private var _bHit:Boolean;
        private var _bEnd:Boolean;
        private var _angle:int = 0;
        private var _hitWiat:Number;

        public function SkillPartsArrow(param1:DisplayObjectContainer, param2:MovieClip, param3:Point, param4:Point)
        {
            this._mc = param2;
            this._pos = param3.clone();
            this._vec = param4.clone();
            if (this._vec.length > 0)
            {
                this._mc.filters = [new BlurFilter(4, 0, BitmapFilterQuality.LOW)];
            }
            this._w = this._mc.width;
            var _loc_5:* = Math.atan2(-this._vec.y, -this._vec.x);
            this._mc.rotation = _loc_5 * 180 / Math.PI;
            param1.addChild(this._mc);
            this._mc.x = this._pos.x;
            this._mc.y = this._pos.y;
            this._bEnd = false;
            this._bHit = false;
            this._bHitWait = false;
            this._hitWaitTime = 0;
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function get pos() : Point
        {
            return this._pos;
        }// end function

        public function get vec() : Point
        {
            return this._vec;
        }// end function

        public function get bHit() : Boolean
        {
            return this._bHit;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._pos.x = this._pos.x + this._vec.x * param1;
            this._pos.y = this._pos.y + this._vec.y * param1;
            this._mc.x = this._pos.x;
            this._mc.y = this._pos.y;
            if (this._vec.x < 0 && this._pos.x + this._w < 0)
            {
                this._bEnd = true;
            }
            if (this._vec.x >= 0 && this._pos.x - this._w >= Constant.SCREEN_WIDTH)
            {
                this._bEnd = true;
            }
            if (this._vec.y < 0 && this._pos.y < 0)
            {
                this._bEnd = true;
            }
            if (this._vec.y > 0 && this._pos.y >= Constant.SCREEN_HEIGHT)
            {
                this._bEnd = true;
            }
            if (this._bHitWait)
            {
                this._hitWaitTime = this._hitWaitTime - param1;
                if (this._hitWaitTime <= 0)
                {
                    this._hitWaitTime = 0;
                    this._bHit = true;
                    this._bEnd = true;
                }
            }
            return;
        }// end function

        public function controlCurve(param1:Number, param2:Boolean, param3:int, param4:int) : void
        {
            this._angle = this._angle + param3;
            if (param2)
            {
                this._pos.x = this._pos.x - param4 * Math.cos(Math.PI / 180 * this._angle);
                this._pos.y = this._pos.y + param4 * Math.sin(Math.PI / 180 * this._angle);
            }
            else
            {
                this._pos.x = this._pos.x + param4 * Math.cos(Math.PI / 180 * this._angle);
                this._pos.y = this._pos.y + param4 * Math.sin(Math.PI / 180 * this._angle);
            }
            this._mc.x = this._pos.x;
            this._mc.y = this._pos.y;
            if (this._vec.x < 0 && this._pos.x + this._w < 0)
            {
                this._bEnd = true;
            }
            if (this._vec.x >= 0 && this._pos.x - this._w >= Constant.SCREEN_WIDTH)
            {
                this._bEnd = true;
            }
            if (this._vec.y < 0 && this._pos.y < 0)
            {
                this._bEnd = true;
            }
            if (this._vec.y > 0 && this._pos.y >= Constant.SCREEN_HEIGHT)
            {
                this._bEnd = true;
            }
            if (this._bHitWait)
            {
                this._hitWaitTime = this._hitWaitTime - param1;
                if (this._hitWaitTime <= 0)
                {
                    this._hitWaitTime = 0;
                    this._bHit = true;
                    this._bEnd = true;
                }
            }
            return;
        }// end function

        public function getHitTime() : int
        {
            if (this._hitWiat / 3 > this._hitWaitTime)
            {
                return 2;
            }
            if (this._hitWiat / 3 * 2 > this._hitWaitTime)
            {
                return 1;
            }
            return 0;
        }// end function

        public function setHitMake(param1:Number) : void
        {
            this._bHitWait = true;
            this._hitWaitTime = param1;
            this._hitWiat = this._hitWaitTime;
            return;
        }// end function

    }
}
