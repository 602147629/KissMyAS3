package effect
{
    import flash.display.*;
    import flash.geom.*;

    public class EffectShake extends EffectBase
    {
        private var _target:DisplayObjectContainer;
        private var _swingWidth:int;
        private var _swingHeight:int;
        private var _waitTime:Number;
        private var _time:Number;
        private var _rot:Number;
        private var _mtx:Matrix;

        public function EffectShake(param1:DisplayObjectContainer, param2:int, param3:int, param4:Number)
        {
            this._target = param1;
            this._mtx = this._target.transform.matrix.clone();
            this._swingWidth = param2;
            this._swingHeight = param3;
            this._waitTime = param4;
            this._time = 0;
            this._rot = 0;
            super(null, null);
            return;
        }// end function

        override public function isEnd() : Boolean
        {
            return this._time >= this._waitTime;
        }// end function

        override public function release() : void
        {
            this._target.transform.matrix = this._mtx;
            this._target = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = new Matrix();
            this._time = this._time + param1;
            var _loc_3:* = this._rot * Math.PI / 180;
            _loc_2.translate(this._swingWidth * Math.cos(_loc_3), this._swingHeight * Math.sin(_loc_3));
            var _loc_4:* = this._mtx.clone();
            this._mtx.clone().concat(_loc_2);
            this._target.transform.matrix = _loc_4;
            this._rot = this._rot + 122;
            return;
        }// end function

    }
}
