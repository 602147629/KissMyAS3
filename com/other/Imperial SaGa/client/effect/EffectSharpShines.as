package effect
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class EffectSharpShines extends EffectBase
    {
        private var _bmp:Bitmap;
        private var _baseMc:MovieClip;
        private var _aPositionMc:Array;
        private var _moveTime:Number;
        private var _waitTime:Number;
        private var _waitStartTime:Number;
        private var _bEnd:Boolean;
        private var _aUseTime:Array;
        private var _index:int;
        private var _cbEnd:Function;
        public static const RESOURCE_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "Scales01.png";

        public function EffectSharpShines(param1:DisplayObjectContainer, param2:MovieClip, param3:Array, param4:Number, param5:Function = null)
        {
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            super(null, null, null);
            this._bmp = ResourceManager.getInstance().createBitmap(RESOURCE_PATH);
            this._cbEnd = param5;
            this._baseMc = param2;
            this._aPositionMc = param3.concat();
            this._index = 0;
            this._moveTime = param4;
            this._aUseTime = [];
            var _loc_6:* = 0;
            var _loc_7:* = [];
            var _loc_8:* = 0;
            while (_loc_8 < (this._aPositionMc.length - 1))
            {
                
                _loc_11 = this._aPositionMc[_loc_8];
                _loc_12 = this._aPositionMc[(_loc_8 + 1)];
                if (_loc_11 == null || _loc_12 == null)
                {
                    break;
                }
                _loc_13 = new Point(_loc_12.x - _loc_11.x, _loc_12.y - _loc_11.y);
                _loc_14 = _loc_13.length;
                _loc_7.push(_loc_14);
                _loc_6 = _loc_6 + _loc_14;
                _loc_8++;
            }
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            while (_loc_10 < _loc_7.length)
            {
                
                _loc_9 = _loc_9 + this._moveTime * (_loc_7[_loc_10] / _loc_6);
                this._aUseTime.push(_loc_9);
                _loc_10++;
            }
            this._waitTime = 0;
            this._waitStartTime = 0;
            this.updatePosition();
            param1.addChild(this._bmp);
            this._bEnd = false;
            return;
        }// end function

        public function setWaitStartTime(param1:Number) : void
        {
            this._waitStartTime = param1;
            this._bmp.visible = false;
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
            this._aPositionMc = [];
            return;
        }// end function

        override public function isEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = 0;
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
            if (this._waitTime >= this._aUseTime[this._index])
            {
                _loc_2 = this._index + 1;
                while (_loc_2 < this._aUseTime.length)
                {
                    
                    if (this._waitTime < this._aUseTime[_loc_2])
                    {
                        this._index = _loc_2;
                        break;
                    }
                    _loc_2++;
                }
            }
            this.updatePosition();
            if (this._waitTime >= this._moveTime)
            {
                this._bEnd = true;
                if (this._cbEnd != null)
                {
                    this._cbEnd(this._aPositionMc[(this._aPositionMc.length - 1)]);
                }
            }
            return;
        }// end function

        private function updatePosition() : void
        {
            var _loc_1:* = this._waitTime;
            var _loc_2:* = this._aUseTime[this._index];
            if (this._index > 0)
            {
                _loc_1 = _loc_1 - this._aUseTime[(this._index - 1)];
                _loc_2 = _loc_2 - this._aUseTime[(this._index - 1)];
            }
            var _loc_3:* = _loc_1 / _loc_2;
            var _loc_4:* = this._baseMc.transform.concatenatedMatrix.clone();
            this._baseMc.transform.concatenatedMatrix.clone().invert();
            var _loc_5:* = this._aPositionMc[this._index];
            var _loc_6:* = this._aPositionMc[(this._index + 1)];
            if (_loc_5 == null || _loc_6 == null)
            {
                this._bEnd = true;
                return;
            }
            var _loc_7:* = new Matrix();
            _loc_7 = _loc_5.transform.concatenatedMatrix.clone();
            _loc_7.concat(_loc_4);
            var _loc_8:* = new Matrix();
            _loc_8 = _loc_6.transform.concatenatedMatrix.clone();
            _loc_8.concat(_loc_4);
            var _loc_9:* = new Point(_loc_7.tx, _loc_7.ty);
            var _loc_10:* = new Point(_loc_8.tx, _loc_8.ty);
            var _loc_11:* = new Point(_loc_10.x - _loc_9.x, _loc_10.y - _loc_9.y);
            var _loc_12:* = new Point(_loc_10.x - _loc_9.x, _loc_10.y - _loc_9.y).length;
            _loc_11.normalize(_loc_12 * _loc_3);
            var _loc_13:* = new Point((-this._bmp.bitmapData.width) * 0.5, (-this._bmp.bitmapData.height) * 0.5);
            var _loc_14:* = 90 * _loc_3;
            var _loc_15:* = new Matrix();
            new Matrix().translate(_loc_13.x, _loc_13.y);
            _loc_15.rotate(_loc_14 * Math.PI / 180);
            _loc_15.translate(_loc_9.x + _loc_11.x, _loc_9.y + _loc_11.y);
            this._bmp.transform.matrix = _loc_15;
            return;
        }// end function

    }
}
