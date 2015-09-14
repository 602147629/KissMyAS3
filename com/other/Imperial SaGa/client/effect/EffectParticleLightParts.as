package effect
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;

    public class EffectParticleLightParts extends EffectParticleBase
    {
        private var _rot:Number;
        private var _rotVec:Number;
        private var _friction:Number;
        private static const _TIME_TO_APPEARANCE:Number = 0.2;
        private static const _TIME_TO_DISAPPEAR:Number = 0.5;
        private static const _MAX_VEC:Number = 200;

        public function EffectParticleLightParts(param1:DisplayObjectContainer, param2:BitmapData, param3:Point, param4:Point, param5:Number, param6:Number)
        {
            var _loc_7:* = param2.clone();
            _bmp = new Bitmap(_loc_7);
            _bmp.alpha = 0;
            _pos = param3.clone();
            _vec = param4.clone();
            this._rot = 0;
            this._rotVec = param5;
            _centerPos = new Point(_bmp.width * -0.5, _bmp.height * -0.5);
            _liveTime = param6;
            _bmp.filters = [new GlowFilter(0)];
            this._friction = 0;
            param1.addChild(_bmp);
            return;
        }// end function

        public function set friction(param1:Number) : void
        {
            this._friction = param1;
            return;
        }// end function

        public function addVec(param1:Number, param2:Point) : void
        {
            _vec.x = _vec.x + param2.x * param1;
            _vec.y = _vec.y + param2.y * param1;
            if (_vec.length > _MAX_VEC)
            {
                _vec.normalize(_MAX_VEC);
            }
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            _liveTime = _liveTime - param1;
            _pos.x = _pos.x + _vec.x * param1;
            _pos.y = _pos.y + _vec.y * param1;
            this._rot = this._rot + this._rotVec;
            var _loc_2:* = new Matrix();
            _loc_2.translate(_centerPos.x, _centerPos.y);
            _loc_2.rotate(this._rot * Math.PI / 180);
            _loc_2.translate(_pos.x, _pos.y);
            _bmp.transform.matrix = _loc_2;
            var _loc_3:* = _bmp.alpha;
            if (_liveTime <= _TIME_TO_DISAPPEAR)
            {
                if (_liveTime <= 0)
                {
                    _liveTime = 0;
                    _bEnd = true;
                }
                _loc_3 = _liveTime / _TIME_TO_DISAPPEAR;
                if (_loc_3 > 1)
                {
                    _loc_3 = 1;
                }
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
            }
            else if (_bmp.alpha < 1)
            {
                _loc_3 = _loc_3 + 1 / _TIME_TO_APPEARANCE * param1;
                if (_loc_3 > 1)
                {
                    _loc_3 = 1;
                }
            }
            _bmp.alpha = _loc_3;
            _vec.x = _vec.x - _vec.x * param1 * this._friction;
            _vec.y = _vec.y - _vec.y * param1 * this._friction;
            return;
        }// end function

    }
}
