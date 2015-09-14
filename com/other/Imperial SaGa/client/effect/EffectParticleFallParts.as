package effect
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;

    public class EffectParticleFallParts extends EffectParticleBase
    {
        protected var _timeToDisappear:Number;
        protected var _g:Number;
        protected var _friction:Number;
        private var _rot:Number;
        private var _rotVec:Number;
        private static const _TIME_TO_DISAPPEAR:Number = 0.5;

        public function EffectParticleFallParts(param1:DisplayObjectContainer, param2:BitmapData, param3:Point, param4:Number, param5:Number, param6:Number)
        {
            var _loc_7:* = param2.clone();
            _bmp = new Bitmap(_loc_7);
            _bmp.filters = [new BlurFilter(1, 4)];
            _pos = param3.clone();
            this._g = param4;
            this._rot = 0;
            this._rotVec = param5;
            _centerPos = new Point(_bmp.width * -0.5, _bmp.height * -0.5);
            _liveTime = param6;
            param1.addChild(_bmp);
            this._timeToDisappear = _TIME_TO_DISAPPEAR;
            this._friction = 0;
            return;
        }// end function

        public function set timeToDisappear(param1:Number) : void
        {
            this._timeToDisappear = param1;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            _liveTime = _liveTime - param1;
            _pos.x = _pos.x + _vec.x * param1;
            _pos.y = _pos.y + (_vec.y + this._g) * param1;
            this._rot = this._rot + this._rotVec;
            var _loc_2:* = new Matrix();
            _loc_2.translate(_centerPos.x, _centerPos.y);
            _loc_2.rotate(this._rot * Math.PI / 180);
            _loc_2.translate(_pos.x, _pos.y);
            _bmp.transform.matrix = _loc_2;
            var _loc_3:* = 1;
            if (_liveTime <= this._timeToDisappear)
            {
                if (_liveTime <= 0)
                {
                    _liveTime = 0;
                    _bEnd = true;
                }
                _loc_3 = _liveTime / this._timeToDisappear;
                if (_loc_3 > 1)
                {
                    _loc_3 = 1;
                }
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
            }
            _bmp.alpha = _loc_3;
            _vec.x = _vec.x - _vec.x * this._friction * param1;
            _vec.y = _vec.y - _vec.y * this._friction * param1;
            return;
        }// end function

    }
}
