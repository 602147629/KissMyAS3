package battle
{
    import flash.display.*;
    import flash.geom.*;

    public class BattleCamera extends Object
    {
        private var _mc:Sprite;
        private var _pos:Point;
        private var _scale:Number;
        private var _targetPos:Point;
        private var _startPos:Point;
        private var _targetScale:Number;
        private var _startScale:Number;
        private var _waitTime:Number;
        private var _time:Number;

        public function BattleCamera()
        {
            this._mc = new Sprite();
            this.initPosition();
            return;
        }// end function

        public function get mc() : Sprite
        {
            return this._mc;
        }// end function

        public function set pos(param1:Point) : void
        {
            this._pos = param1.clone();
            return;
        }// end function

        public function set scale(param1:Number) : void
        {
            this._scale = param1;
            return;
        }// end function

        public function isMoveEnd() : Boolean
        {
            return this._targetPos == null;
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
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            if (this._targetPos != null)
            {
                this._time = this._time + param1;
                _loc_3 = this._time / this._waitTime;
                _loc_4 = new Point(this._targetPos.x - this._startPos.x, this._targetPos.y - this._startPos.y);
                this._pos.x = this._startPos.x + _loc_4.x * _loc_3;
                this._pos.y = this._startPos.y + _loc_4.y * _loc_3;
                _loc_5 = this._targetScale - this._startScale;
                this._scale = this._startScale + _loc_5 * _loc_3;
                if (this._time >= this._waitTime)
                {
                    this._pos = this._targetPos.clone();
                    this._targetPos = null;
                    this._scale = this._targetScale;
                    this._targetScale = 1;
                    this._waitTime = 0;
                    this._time = 0;
                }
            }
            var _loc_2:* = this._mc.transform.matrix;
            _loc_2.identity();
            _loc_2.translate(-this._pos.x, -this._pos.y);
            _loc_2.scale(this._scale, this._scale);
            _loc_2.translate(Constant.SCREEN_WIDTH_HALF, Constant.SCREEN_HEIGHT_HALF);
            this._mc.transform.matrix = _loc_2;
            return;
        }// end function

        public function initPosition() : void
        {
            this._pos = getDefaultPosition();
            this._scale = 1;
            return;
        }// end function

        public function moveCamera(param1:Point, param2:Number, param3:Number) : void
        {
            this._targetPos = param1.clone();
            this._startPos = this._pos.clone();
            this._targetScale = param2;
            this._startScale = this._scale;
            this._waitTime = param3;
            this._time = 0;
            return;
        }// end function

        public function moveDefaultCamera(param1:Number) : void
        {
            this.moveCamera(getDefaultPosition(), 1, param1);
            return;
        }// end function

        public static function getDefaultPosition() : Point
        {
            return new Point(Constant.SCREEN_WIDTH_HALF, Constant.SCREEN_HEIGHT_HALF);
        }// end function

    }
}
