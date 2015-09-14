package effect
{
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class EffectAfterImagePut extends EffectBase
    {
        private const _BLUR_TIME:Number = 0.05;
        private const _BLUR_LIVE_TIME:Number = 0.3;
        private const _BLUR_W:int = 4;
        private const _BLUR_H:int = 2;
        private var _target:DisplayObjectContainer;
        private var _aParts:Array;
        private var _time:Number;
        private var _scaleAdd:Number;
        private var _blurTime:Number;
        private var _blurLiveTime:Number;
        private var _vec:Point;
        private var _colorTransform:ColorTransform;
        private var _endColorTransform:ColorTransform;
        private var _blurW:int;
        private var _blurH:int;
        private var _blendMode:String;
        private var _bStop:Boolean;

        public function EffectAfterImagePut(param1:DisplayObjectContainer, param2:DisplayObjectContainer)
        {
            this._scaleAdd = 0;
            this._blurW = this._BLUR_W;
            this._blurH = this._BLUR_H;
            var _loc_3:* = new MovieClip();
            super(param1, _loc_3);
            this._target = param2;
            this._aParts = [];
            this._time = 0;
            this._blurTime = this._BLUR_TIME;
            this._blurLiveTime = this._BLUR_LIVE_TIME;
            this._vec = new Point();
            this._colorTransform = null;
            this._blendMode = BlendMode.NORMAL;
            this._bStop = false;
            return;
        }// end function

        public function get scaleAdd() : Number
        {
            return this._scaleAdd;
        }// end function

        public function set scaleAdd(param1:Number) : void
        {
            this._scaleAdd = param1;
            return;
        }// end function

        public function set blurTime(param1:Number) : void
        {
            this._blurTime = param1;
            return;
        }// end function

        public function set blurLiveTime(param1:Number) : void
        {
            this._blurLiveTime = param1;
            return;
        }// end function

        public function set vec(param1:Point) : void
        {
            this._vec = param1;
            return;
        }// end function

        public function set colorTransform(param1:ColorTransform) : void
        {
            this._colorTransform = param1;
            return;
        }// end function

        public function set endColorTransform(param1:ColorTransform) : void
        {
            this._endColorTransform = param1;
            return;
        }// end function

        public function setBlur(param1:int, param2:int) : void
        {
            this._blurW = param1;
            this._blurH = param2;
            return;
        }// end function

        public function set blendMode(param1:String) : void
        {
            this._blendMode = param1;
            return;
        }// end function

        public function set bStop(param1:Boolean) : void
        {
            this._bStop = param1;
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            super.release();
            for each (_loc_1 in this._aParts)
            {
                
                _loc_1.release();
            }
            this._aParts = [];
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            super.control(param1);
            this._time = this._time - param1;
            if (this._time < 0 && this._bStop == false)
            {
                this._time = this._blurTime;
                _loc_3 = new EffectAfterImagePutParts(this._target, this._blurLiveTime);
                _loc_3.addBlur(this._blurW, this._blurH);
                _loc_3.vecAdd = this._vec;
                _loc_3.scaleAdd = this._scaleAdd;
                _loc_3.blendMode = this._blendMode;
                if (this._colorTransform != null)
                {
                    _loc_3.transform.colorTransform = this._colorTransform;
                }
                this._aParts.push(_loc_3);
                _mcEffect.addChild(_loc_3);
            }
            var _loc_2:* = this._aParts.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_4 = this._aParts[_loc_2];
                _loc_4.control(param1);
                if (this._colorTransform != null && this._endColorTransform != null && !ColorTransformUtil.isMatchColorTransform(this._colorTransform, this._endColorTransform))
                {
                    _loc_5 = ColorTransformUtil.interpolateTransform(this._colorTransform, this._endColorTransform, (this._blurTime - _loc_4.time) / this._blurTime);
                    _loc_4.transform.colorTransform = _loc_5;
                }
                if (_loc_4.bEnd)
                {
                    _loc_4.release();
                    this._aParts.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

    }
}
