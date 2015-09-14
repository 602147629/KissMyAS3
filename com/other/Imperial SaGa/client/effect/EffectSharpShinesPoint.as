package effect
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import resource.*;
    import utility.*;

    public class EffectSharpShinesPoint extends EffectBase
    {
        private const _SCALE_IN_RATE:Number = 0.5;
        private const _SCALE_OUT_RATE:Number = 0.5;
        private var _bmp:Bitmap;
        private var _baseMc:MovieClip;
        private var _positionMc:MovieClip;
        private var _shineTime:Number;
        private var _waitTime:Number;
        private var _waitStartTime:Number;
        private var _bEnd:Boolean;
        private var _rotate:Number;
        public static const RESOURCE_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "Scales01.png";

        public function EffectSharpShinesPoint(param1:DisplayObjectContainer, param2:MovieClip, param3:MovieClip, param4:Number)
        {
            super(null, null, null);
            this._bmp = ResourceManager.getInstance().createBitmap(RESOURCE_PATH);
            this._baseMc = param2;
            this._positionMc = param3;
            this._shineTime = param4;
            this._waitTime = 0;
            this._rotate = 0;
            this._waitStartTime = 0;
            this.updatePosition();
            param1.addChild(this._bmp);
            this._bEnd = false;
            return;
        }// end function

        public function setWaitStartTime(param1:Number) : void
        {
            this._waitStartTime = param1;
            if (this._waitStartTime > 0)
            {
                this._bmp.visible = false;
            }
            return;
        }// end function

        public function setGlowFilter(param1:int, param2:int, param3:int) : void
        {
            this._bmp.filters = [new GlowFilter(ColorARGB.RGBtoHex(param1, param2, param3), 1, 4, 4)];
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._bmp)
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
            this._positionMc = null;
            return;
        }// end function

        override public function isEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        override public function control(param1:Number) : void
        {
            if (this._bEnd)
            {
                return;
            }
            if (this._waitStartTime > 0)
            {
                this._waitStartTime = this._waitStartTime - param1;
                if (this._waitStartTime <= 0)
                {
                    this._waitStartTime = 0;
                    this._bmp.visible = true;
                }
                else
                {
                    return;
                }
            }
            super.control(param1);
            this._waitTime = this._waitTime + param1;
            this._rotate = this._rotate + 360 * param1;
            this.updatePosition();
            if (this._waitTime >= this._shineTime)
            {
                this._bEnd = true;
            }
            return;
        }// end function

        private function updatePosition() : void
        {
            var _loc_1:* = this._shineTime * this._SCALE_IN_RATE;
            var _loc_2:* = this._waitTime;
            var _loc_3:* = _loc_2 < _loc_1;
            if (_loc_3 == false)
            {
                _loc_2 = this._waitTime - _loc_1;
                _loc_1 = this._shineTime * this._SCALE_OUT_RATE;
            }
            var _loc_4:* = _loc_2 / _loc_1;
            var _loc_5:* = _loc_2 / _loc_1;
            if (_loc_3 == false)
            {
                _loc_5 = 1 - _loc_4;
                if (_loc_5 < 0)
                {
                    _loc_5 = 0;
                }
            }
            var _loc_6:* = this._baseMc.transform.concatenatedMatrix.clone();
            this._baseMc.transform.concatenatedMatrix.clone().invert();
            var _loc_7:* = this._positionMc;
            if (this._positionMc == null)
            {
                this._bEnd = true;
                return;
            }
            var _loc_8:* = new Matrix();
            _loc_8 = _loc_7.transform.concatenatedMatrix.clone();
            _loc_8.concat(_loc_6);
            var _loc_9:* = new Point(_loc_8.tx, _loc_8.ty);
            var _loc_10:* = new Point((-this._bmp.bitmapData.width) * 0.5, (-this._bmp.bitmapData.height) * 0.5);
            var _loc_11:* = new Matrix();
            new Matrix().translate(_loc_10.x, _loc_10.y);
            _loc_11.rotate(this._rotate * Math.PI / 180);
            _loc_11.scale(_loc_5, _loc_5);
            _loc_11.translate(_loc_9.x, _loc_9.y);
            this._bmp.transform.matrix = _loc_11;
            return;
        }// end function

    }
}
