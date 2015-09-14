package quest
{
    import flash.display.*;
    import flash.geom.*;

    public class QuestCamera extends Object
    {
        private var _mc:Sprite;
        private var _pos:Point;
        private var _scrollPos:Point;
        private var _scrollMin:Point;
        private var _scrollMax:Point;
        private var _scale:Number;
        private var _bTarget:Boolean;
        private var _targetPos:Point;
        private var _targetScale:Number;
        private var _waitTime:Number;
        private var _time:Number;

        public function QuestCamera()
        {
            this._mc = new Sprite();
            this._pos = new Point();
            this._scrollPos = new Point();
            this._scale = 1;
            this._scrollMin = new Point();
            this._scrollMax = new Point();
            this._bTarget = false;
            this._targetPos = new Point();
            this._targetScale = 1;
            this._waitTime = 0;
            this._time = 0;
            return;
        }// end function

        public function get mc() : Sprite
        {
            return this._mc;
        }// end function

        public function get pos() : Point
        {
            return this._pos;
        }// end function

        public function get scrollPos() : Number
        {
            return this._scrollPos.y;
        }// end function

        public function set scale(param1:Number) : void
        {
            this._scale = param1;
            return;
        }// end function

        public function release() : void
        {
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._bTarget == false)
            {
                _loc_2 = new Point(this._scrollPos.x - this._pos.x, this._scrollPos.y - this._pos.y);
                this._pos.x = this._pos.x + _loc_2.x * 0.5;
                this._pos.y = this._pos.y + _loc_2.y * 0.5;
            }
            if (this._pos.x < this._scrollMin.x)
            {
                this._pos.x = this._scrollMin.x;
            }
            if (this._pos.y < this._scrollMin.y)
            {
                this._pos.y = this._scrollMin.y;
            }
            if (this._pos.x > this._scrollMax.x)
            {
                this._pos.x = this._scrollMax.x;
            }
            if (this._pos.y > this._scrollMax.y)
            {
                this._pos.y = this._scrollMax.y;
            }
            var _loc_3:* = new Matrix();
            _loc_3.translate(-this._pos.x, -this._pos.y);
            _loc_3.scale(this._scale, this._scale);
            _loc_3.translate(0, Constant.SCREEN_HEIGHT_HALF);
            this._mc.transform.matrix = _loc_3;
            return;
        }// end function

        public function setScrollMinMax(param1:Point, param2:Point) : void
        {
            this._scrollMin = param1.clone();
            this._scrollMax = param2.clone();
            return;
        }// end function

        public function moveCamera(param1:Point) : void
        {
            this._pos = param1;
            return;
        }// end function

        public function movePosition(param1:Number, param2:Number) : void
        {
            this._scrollPos.x = param1;
            this._scrollPos.y = param2;
            return;
        }// end function

        public function changePosition(param1:Number, param2:Number) : void
        {
            this._scrollPos.x = param1;
            this._scrollPos.y = param2;
            this._pos.x = param1;
            this._pos.y = param2;
            var _loc_3:* = new Matrix();
            _loc_3.translate(-param1, -param2);
            _loc_3.scale(this._scale, this._scale);
            _loc_3.translate(0, Constant.SCREEN_HEIGHT_HALF);
            this._mc.transform.matrix = _loc_3;
            return;
        }// end function

    }
}
