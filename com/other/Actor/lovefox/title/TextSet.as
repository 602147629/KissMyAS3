package lovefox.title
{
    import flash.display.*;
    import flash.geom.*;

    public class TextSet extends Sprite
    {
        private var _msg1Array:Array;
        private var _msg2Array:Array;
        private var _direction:uint;
        private var _color:uint;
        private var _size:uint;
        public var _lineStartLen:uint;
        private var _count:uint = 0;
        private var _maxCount:uint;
        private var _over:Boolean = false;

        public function TextSet(param1:String, param2:String, param3:uint = 16777215, param4:uint = 16, param5 = 0)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_14:* = undefined;
            this._msg1Array = [];
            this._msg2Array = [];
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this._direction = param5;
            this._color = param3;
            this._size = param4;
            var _loc_13:* = this._size + 2;
            if (param5 != 2)
            {
                _loc_14 = this._size + 2;
            }
            else
            {
                _loc_14 = this._size / 2 + 2;
            }
            if (param5 != 2)
            {
                this._maxCount = 100;
            }
            else
            {
                this._maxCount = 30;
            }
            var _loc_15:* = param1.split("");
            _loc_6 = 0;
            while (_loc_6 < _loc_15.length)
            {
                
                _loc_12 = _loc_15[_loc_6];
                if (_loc_12 != " ")
                {
                    if (param5 == 0)
                    {
                        _loc_9 = _loc_6 * _loc_13 + _loc_13 / 2;
                    }
                    else if (param5 == 1)
                    {
                        _loc_9 = (-_loc_13) * _loc_15.length + _loc_6 * _loc_13 + _loc_13 / 2;
                    }
                    else if (param5 == 2)
                    {
                        _loc_9 = (-_loc_13) * _loc_15.length / 2 + _loc_6 * _loc_13 + _loc_13 / 2;
                    }
                    _loc_10 = 0;
                    _loc_7 = Text2Bitmap.toBmp(_loc_12, param3, param4, null, true, false, true);
                    _loc_8 = new Bitmap(_loc_7, PixelSnapping.AUTO, true);
                    _loc_8.x = _loc_9 - _loc_8.width / 2;
                    _loc_8.y = _loc_10;
                    _loc_8.alpha = 0;
                    addChild(_loc_8);
                    if (param5 == 2)
                    {
                        this._msg1Array.push({over:false, x:_loc_9, y:_loc_10, bmp:_loc_8, delay:Math.floor(Math.random() * 10)});
                    }
                    else
                    {
                        this._msg1Array.push({over:false, x:_loc_9, y:_loc_10, bmp:_loc_8, delay:int(Math.random() * 10)});
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            var _loc_16:* = param2.split("");
            _loc_6 = 0;
            while (_loc_6 < _loc_16.length)
            {
                
                _loc_12 = _loc_16[_loc_6];
                if (_loc_12 != " ")
                {
                    if (param5 == 0)
                    {
                        _loc_9 = _loc_6 * _loc_14 + _loc_14 / 2;
                    }
                    else if (param5 == 1)
                    {
                        _loc_9 = (-_loc_14) * _loc_16.length + _loc_6 * _loc_14 + _loc_14 / 2;
                    }
                    else if (param5 == 2)
                    {
                        _loc_9 = (-_loc_14) * _loc_16.length / 2 + _loc_6 * _loc_14 + _loc_14 / 2;
                    }
                    _loc_10 = this._size + 6;
                    _loc_11 = Math.random() * 60 - 30;
                    _loc_7 = Text2Bitmap.toBmp(_loc_12, param3, param4, null, true, false, true);
                    _loc_8 = new Bitmap(_loc_7, PixelSnapping.AUTO, true);
                    if (param5 == 2)
                    {
                        _loc_8.x = _loc_9;
                        _loc_8.y = _loc_10;
                    }
                    else
                    {
                        _loc_8.rotation = _loc_11;
                        _loc_8.x = _loc_9 - _loc_8.width / 2;
                        _loc_8.y = _loc_10 + Math.random() * 20 - 5;
                    }
                    _loc_8.alpha = 0;
                    addChild(_loc_8);
                    if (param5 == 2)
                    {
                        this._msg2Array.push({over:false, x:_loc_9, y:_loc_10, bmp:_loc_8, rotation:_loc_11, delay:int(Math.abs(_loc_6 - _loc_16.length / 2) * 2) + 5});
                    }
                    else
                    {
                        this._msg2Array.push({over:false, x:_loc_9, y:_loc_10, bmp:_loc_8, rotation:_loc_11, delay:Math.floor(Math.random() * 10)});
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            this.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            this.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            if (param5 != 2)
            {
                this._lineStartLen = Math.max(0, Math.max(_loc_13 * _loc_15.length, _loc_14 * _loc_16.length) - this._maxCount);
            }
            else
            {
                this._lineStartLen = Math.max(0, Math.max(_loc_13 * _loc_15.length, _loc_14 * _loc_16.length) - this._maxCount);
            }
            if (param5 != 2)
            {
                this.filters = [new GlowFilter(16777215, 1, 1.5, 1.5, 2, 3)];
            }
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_1 = 0;
            while (_loc_1 < this._msg1Array.length)
            {
                
                _loc_3 = this._msg1Array[_loc_1].bmp;
                _loc_3.bitmapData.dispose();
                _loc_1 = _loc_1 + 1;
            }
            _loc_1 = 0;
            while (_loc_1 < this._msg2Array.length)
            {
                
                _loc_3 = this._msg2Array[_loc_1].bmp;
                _loc_3.bitmapData.dispose();
                _loc_1 = _loc_1 + 1;
            }
            this.graphics.clear();
            this.filters = [];
            this.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            this.dispatchEvent(new Event("destroy"));
            return;
        }// end function

        public function over()
        {
            this._over = true;
            return;
        }// end function

        private function enterFrame(param1)
        {
            var _loc_3:* = undefined;
            var _loc_6:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = undefined;
            var _loc_19:* = undefined;
            var _loc_20:* = undefined;
            var _loc_21:* = undefined;
            var _loc_22:* = undefined;
            var _loc_23:* = undefined;
            var _loc_24:* = undefined;
            if (this._direction == 2)
            {
                if (this._count < (this._maxCount - 1) || this._over)
                {
                    var _loc_25:* = this;
                    var _loc_26:* = this._count + 1;
                    _loc_25._count = _loc_26;
                }
            }
            else
            {
                var _loc_25:* = this;
                var _loc_26:* = this._count + 1;
                _loc_25._count = _loc_26;
            }
            var _loc_2:* = true;
            if (this._count < this._maxCount)
            {
                if (this._direction == 2)
                {
                    _loc_3 = 0.2;
                }
                else
                {
                    _loc_3 = 0.1;
                }
                _loc_15 = 0;
                while (_loc_15 < this._msg1Array.length)
                {
                    
                    _loc_17 = this._msg1Array[_loc_15].bmp;
                    if (this._count > this._msg1Array[_loc_15].delay)
                    {
                        if (_loc_17.alpha < 1)
                        {
                            _loc_17.alpha = _loc_17.alpha + _loc_3;
                        }
                    }
                    else if (!this._msg1Array[_loc_15].over)
                    {
                        this._msg1Array[_loc_15].over = true;
                    }
                    _loc_15 = _loc_15 + 1;
                }
                _loc_15 = 0;
                while (_loc_15 < this._msg2Array.length)
                {
                    
                    _loc_17 = this._msg2Array[_loc_15].bmp;
                    if (Math.abs(_loc_17.y - this._msg2Array[_loc_15].y) > 0.01 || Math.abs(_loc_17.rotation) > 0.01 || _loc_17.alpha < 1)
                    {
                        if (this._count > this._msg2Array[_loc_15].delay)
                        {
                            if (_loc_17.alpha < 1)
                            {
                                _loc_17.alpha = _loc_17.alpha + _loc_3;
                            }
                            _loc_17.y = (this._msg2Array[_loc_15].y - _loc_17.y) / 10 + _loc_17.y;
                            _loc_17.rotation = -_loc_17.rotation / 10 + _loc_17.rotation;
                            _loc_17.x = this._msg2Array[_loc_15].x - _loc_17.width / 2;
                        }
                    }
                    else if (!this._msg2Array[_loc_15].over)
                    {
                        this._msg2Array[_loc_15].over = true;
                        _loc_17.rotation = 0;
                        _loc_17.x = this._msg2Array[_loc_15].x - _loc_17.width / 2;
                        _loc_17.y = this._msg2Array[_loc_15].y;
                    }
                    _loc_15 = _loc_15 + 1;
                }
            }
            else
            {
                if (this._direction == 2)
                {
                    _loc_3 = 0.1;
                }
                else
                {
                    _loc_3 = 0.05;
                }
                if (this._count == this._maxCount)
                {
                    this.dispatchEvent(new Event("over"));
                }
                _loc_15 = 0;
                while (_loc_15 < this._msg1Array.length)
                {
                    
                    _loc_17 = this._msg1Array[_loc_15].bmp;
                    if (this._count - this._maxCount > this._msg1Array[_loc_15].delay)
                    {
                        if (_loc_17.alpha > 0)
                        {
                            _loc_17.alpha = _loc_17.alpha - _loc_3;
                            _loc_2 = false;
                        }
                    }
                    _loc_15 = _loc_15 + 1;
                }
                _loc_15 = 0;
                while (_loc_15 < this._msg2Array.length)
                {
                    
                    _loc_17 = this._msg2Array[_loc_15].bmp;
                    if (this._count - this._maxCount > this._msg2Array[_loc_15].delay)
                    {
                        if (_loc_17.alpha > 0)
                        {
                            _loc_17.alpha = _loc_17.alpha - _loc_3;
                            _loc_2 = false;
                        }
                    }
                    _loc_15 = _loc_15 + 1;
                }
            }
            if (this._direction == 2)
            {
                if (this._count < this._maxCount)
                {
                    _loc_22 = 0.5;
                    _loc_23 = 10;
                    _loc_24 = this._maxCount * (1 - _loc_22);
                    this.filters = [new GlowFilter(39270, 1, 2, 2, 2, 3), new BlurFilter(this._maxCount - _loc_24 - this._count * _loc_22, this._maxCount - _loc_24 - this._count * _loc_22, 3)];
                }
                else if (this._count == this._maxCount)
                {
                    this.filters = [new GlowFilter(39270, 1, 2, 2, 2, 3)];
                }
            }
            this.graphics.clear();
            this.graphics.lineStyle(0, this._color, 0);
            var _loc_4:* = Math.floor(this._count + this._lineStartLen);
            var _loc_5:* = Math.floor((_loc_4 - 20) / _loc_4 * 255);
            if (this._count < this._maxCount)
            {
                _loc_6 = Math.min(1, this._count * _loc_3);
            }
            else
            {
                _loc_6 = Math.max(0, 1 - (this._count - this._maxCount) * _loc_3);
            }
            if (_loc_6 > 0)
            {
                _loc_2 = false;
            }
            var _loc_7:* = GradientType.RADIAL;
            var _loc_8:* = [this._color, this._color];
            var _loc_9:* = [_loc_6, 0];
            var _loc_10:* = [_loc_5, 255];
            var _loc_11:* = new Matrix();
            if (this._direction == 0)
            {
                _loc_12 = Math.floor((-this._size) / 2);
            }
            else if (this._direction == 1)
            {
                _loc_12 = Math.floor(-_loc_4 + this._size / 2);
            }
            else if (this._direction == 2)
            {
                _loc_12 = Math.floor((-_loc_4) / 2);
            }
            _loc_13 = Math.floor(this._size + 6);
            _loc_11.createGradientBox(_loc_4 * 1.42, 1 * 1.42, 0, (-_loc_4) * 0.21 + _loc_12, -1 * 0.21 + _loc_13);
            var _loc_14:* = SpreadMethod.PAD;
            this.graphics.beginGradientFill(_loc_7, _loc_8, _loc_9, _loc_10, _loc_11, _loc_14);
            this.graphics.drawRect(_loc_12, _loc_13, _loc_4, 1);
            this.graphics.endFill();
            if (_loc_2)
            {
                if (this._direction == 2)
                {
                    trace("allClose", getTimer());
                }
                this.destroy();
            }
            return;
        }// end function

    }
}
