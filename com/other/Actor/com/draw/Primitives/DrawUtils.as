package com.draw.Primitives
{
    import flash.display.*;

    public class DrawUtils extends Object
    {

        public function DrawUtils()
        {
            return;
        }// end function

        public static function dashLineToPattern(param1:Shape, param2:Number, param3:Number, param4:Number, param5:Number, param6:Array) : void
        {
            var _loc_7:* = param4 - param2;
            var _loc_8:* = param5 - param3;
            var _loc_9:* = Math.sqrt(_loc_7 * _loc_7 + _loc_8 * _loc_8);
            var _loc_10:* = Math.sqrt(_loc_7 * _loc_7 + _loc_8 * _loc_8) / (param6[0] + param6[1]);
            var _loc_11:* = param6[0] / (param6[0] + param6[1]);
            var _loc_12:* = _loc_7 / _loc_10 * _loc_11;
            var _loc_13:* = _loc_7 / _loc_10 - _loc_12;
            var _loc_14:* = _loc_8 / _loc_10 * _loc_11;
            var _loc_15:* = _loc_8 / _loc_10 - _loc_14;
            param1.graphics.moveTo(param2, param3);
            while (_loc_9 > 0)
            {
                
                param2 = param2 + _loc_12;
                param3 = param3 + _loc_14;
                _loc_9 = _loc_9 - param6[0];
                if (_loc_9 < 0)
                {
                    param2 = param4;
                    param3 = param5;
                }
                param1.graphics.lineTo(param2, param3);
                param2 = param2 + _loc_13;
                param3 = param3 + _loc_15;
                param1.graphics.moveTo(param2, param3);
                _loc_9 = _loc_9 - param6[1];
            }
            param1.graphics.moveTo(param4, param5);
            return;
        }// end function

        public static function arcTo(param1:Shape, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_14:* = 0;
            if (Math.abs(param5) > 360)
            {
                param5 = 360;
            }
            var _loc_10:* = Math.ceil(Math.abs(param5) / 45);
            var _loc_11:* = param5 / _loc_10;
            var _loc_12:* = (-param5 / _loc_10 / 180) * Math.PI;
            var _loc_13:* = (-param4 / 180) * Math.PI;
            _loc_8 = param2 - Math.cos(_loc_13) * param6;
            _loc_9 = param3 - Math.sin(_loc_13) * param7;
            if (_loc_10 > 0)
            {
                param1.graphics.moveTo(param2, param3);
                _loc_14 = 0;
                while (_loc_14 < _loc_10)
                {
                    
                    _loc_13 = _loc_13 + _loc_12;
                    param1.graphics.curveTo(_loc_8 + Math.cos(_loc_13 - _loc_12 / 2) * (param6 / Math.cos(_loc_12 / 2)), _loc_9 + Math.sin(_loc_13 - _loc_12 / 2) * (param7 / Math.cos(_loc_12 / 2)), _loc_8 + Math.cos(_loc_13) * param6, _loc_9 + Math.sin(_loc_13) * param7);
                    _loc_14++;
                }
            }
            return;
        }// end function

        public static function burst(param1:Shape, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = 0) : void
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = 0;
            if (param4 >= 2)
            {
                _loc_8 = Math.PI * 2 / param4;
                _loc_9 = _loc_8 / 2;
                _loc_10 = _loc_8 / 4;
                _loc_11 = param7 / 180 * Math.PI;
                param1.graphics.moveTo(param2 + Math.cos(_loc_11) * param6, param3 - Math.sin(_loc_11) * param6);
                _loc_12 = 1;
                while (_loc_12 <= param4)
                {
                    
                    param1.graphics.curveTo(param2 + Math.cos(_loc_11 + _loc_8 * _loc_12 - _loc_10 * 3) * (param5 / Math.cos(_loc_10)), param3 - Math.sin(_loc_11 + _loc_8 * _loc_12 - _loc_10 * 3) * (param5 / Math.cos(_loc_10)), param2 + Math.cos(_loc_11 + _loc_8 * _loc_12 - _loc_9) * param5, param3 - Math.sin(_loc_11 + _loc_8 * _loc_12 - _loc_9) * param5);
                    param1.graphics.curveTo(param2 + Math.cos(_loc_11 + _loc_8 * _loc_12 - _loc_10) * (param5 / Math.cos(_loc_10)), param3 - Math.sin(_loc_11 + _loc_8 * _loc_12 - _loc_10) * (param5 / Math.cos(_loc_10)), param2 + Math.cos(_loc_11 + _loc_8 * _loc_12) * param6, param3 - Math.sin(_loc_11 + _loc_8 * _loc_12) * param6);
                    _loc_12++;
                }
            }
            return;
        }// end function

        public static function gear(param1:Shape, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = 0, param8:Number = 0, param9:Number = 0) : void
        {
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            if (param4 >= 2)
            {
                _loc_10 = Math.PI * 2 / param4;
                _loc_11 = _loc_10 / 4;
                _loc_12 = param7 / 180 * Math.PI;
                param1.graphics.moveTo(param2 + Math.cos(_loc_12) * param6, param3 - Math.sin(_loc_12) * param6);
                _loc_13 = 1;
                while (_loc_13 <= param4)
                {
                    
                    param1.graphics.lineTo(param2 + Math.cos(_loc_12 + _loc_10 * _loc_13 - _loc_11 * 3) * param5, param3 - Math.sin(_loc_12 + _loc_10 * _loc_13 - _loc_11 * 3) * param5);
                    param1.graphics.lineTo(param2 + Math.cos(_loc_12 + _loc_10 * _loc_13 - _loc_11 * 2) * param5, param3 - Math.sin(_loc_12 + _loc_10 * _loc_13 - _loc_11 * 2) * param5);
                    param1.graphics.lineTo(param2 + Math.cos(_loc_12 + _loc_10 * _loc_13 - _loc_11) * param6, param3 - Math.sin(_loc_12 + _loc_10 * _loc_13 - _loc_11) * param6);
                    param1.graphics.lineTo(param2 + Math.cos(_loc_12 + _loc_10 * _loc_13) * param6, param3 - Math.sin(_loc_12 + _loc_10 * _loc_13) * param6);
                    _loc_13++;
                }
                if (param8 >= 2)
                {
                    if (param9 == 0)
                    {
                        param9 = param5 / 3;
                    }
                    _loc_10 = Math.PI * 2 / param8;
                    param1.graphics.moveTo(param2 + Math.cos(_loc_12) * param9, param3 - Math.sin(_loc_12) * param9);
                    _loc_14 = 1;
                    while (_loc_14 <= param8)
                    {
                        
                        param1.graphics.lineTo(param2 + Math.cos(_loc_12 + _loc_10 * _loc_14) * param9, param3 - Math.sin(_loc_12 + _loc_10 * _loc_14) * param9);
                        _loc_14++;
                    }
                }
            }
            return;
        }// end function

        public static function polygon(param1:Shape, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 0) : void
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = 0;
            var _loc_7:* = Math.abs(param4);
            if (Math.abs(param4) >= 2)
            {
                _loc_8 = Math.PI * 2 / param4;
                _loc_9 = param6 / 180 * Math.PI;
                param1.graphics.moveTo(param2 + Math.cos(_loc_9) * param5, param3 - Math.sin(_loc_9) * param5);
                _loc_10 = 1;
                while (_loc_10 <= _loc_7)
                {
                    
                    param1.graphics.lineTo(param2 + Math.cos(_loc_9 + _loc_8 * _loc_10) * param5, param3 - Math.sin(_loc_9 + _loc_8 * _loc_10) * param5);
                    _loc_10++;
                }
            }
            return;
        }// end function

        public static function star(param1:Shape, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = 0) : void
        {
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = 0;
            var _loc_8:* = Math.abs(param4);
            if (Math.abs(param4) >= 2)
            {
                _loc_9 = Math.PI * 2 / param4;
                _loc_10 = _loc_9 / 2;
                _loc_11 = param7 / 180 * Math.PI;
                param1.graphics.moveTo(param2 + Math.cos(_loc_11) * param6, param3 - Math.sin(_loc_11) * param6);
                _loc_12 = 1;
                while (_loc_12 <= _loc_8)
                {
                    
                    param1.graphics.lineTo(param2 + Math.cos(_loc_11 + _loc_9 * _loc_12 - _loc_10) * param5, param3 - Math.sin(_loc_11 + _loc_9 * _loc_12 - _loc_10) * param5);
                    param1.graphics.lineTo(param2 + Math.cos(_loc_11 + _loc_9 * _loc_12) * param6, param3 - Math.sin(_loc_11 + _loc_9 * _loc_12) * param6);
                    _loc_12++;
                }
            }
            return;
        }// end function

        public static function wedge(param1:Shape, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void
        {
            var _loc_12:* = 0;
            var _loc_13:* = NaN;
            param1.graphics.moveTo(param2, param3);
            if (Math.abs(param5) > 360)
            {
                param5 = 360;
            }
            var _loc_8:* = Math.ceil(Math.abs(param5) / 45);
            var _loc_9:* = param5 / _loc_8;
            var _loc_10:* = (-param5 / _loc_8 / 180) * Math.PI;
            var _loc_11:* = (-param4 / 180) * Math.PI;
            if (_loc_8 > 0)
            {
                param1.graphics.lineTo(param2 + Math.cos(param4 / 180 * Math.PI) * param6, param3 + Math.sin((-param4) / 180 * Math.PI) * param7);
                _loc_12 = 0;
                while (_loc_12 < _loc_8)
                {
                    
                    _loc_11 = _loc_11 + _loc_10;
                    _loc_13 = _loc_11 - _loc_10 / 2;
                    param1.graphics.curveTo(param2 + Math.cos(_loc_13) * (param6 / Math.cos(_loc_10 / 2)), param3 + Math.sin(_loc_13) * (param7 / Math.cos(_loc_10 / 2)), param2 + Math.cos(_loc_11) * param6, param3 + Math.sin(_loc_11) * param7);
                    _loc_12++;
                }
                param1.graphics.lineTo(param2, param3);
            }
            return;
        }// end function

    }
}
