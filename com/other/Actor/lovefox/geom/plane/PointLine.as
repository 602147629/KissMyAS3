package lovefox.geom.plane
{

    public class PointLine extends Object
    {
        public var _x:Number;
        public var _y:Number;
        public var _a:Object;
        public var _type:String;

        public function PointLine(param1, param2 = null, param3 = null)
        {
            if (param2 != null)
            {
                this._x = param1;
                this._y = param2;
                this._a = param3;
            }
            else
            {
                this._x = param1._x;
                this._y = param1._y;
                this._a = param1._a;
            }
            if (this._a == null)
            {
                this._type = "point";
            }
            else
            {
                this._type = "line";
            }
            return;
        }// end function

        public static function line(param1, param2) : Object
        {
            var _loc_3:* = Math.atan2(param2._y - param1._y, param2._x - param1._x);
            return {_x:param1._x, _y:param1._y, _a:_loc_3};
        }// end function

        public static function intersect(param1, param2) : Object
        {
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_3:* = Math.tan(param1._a);
            var _loc_4:* = Math.tan(param2._a);
            var _loc_5:* = param1._x;
            var _loc_6:* = param1._y;
            var _loc_7:* = param2._x;
            var _loc_8:* = param2._y;
            if (_loc_3 != _loc_4)
            {
                if (_loc_3 == 0)
                {
                    _loc_9 = (_loc_6 - _loc_8) / _loc_4 + _loc_7;
                    _loc_10 = _loc_6;
                }
                else if (isNaN(_loc_3))
                {
                    _loc_9 = _loc_5;
                    _loc_10 = _loc_4 * (_loc_5 - _loc_7) + _loc_8;
                }
                else if (_loc_4 == 0)
                {
                    _loc_9 = (_loc_8 - _loc_6) / _loc_3 + _loc_5;
                    _loc_10 = _loc_8;
                }
                else if (isNaN(_loc_4))
                {
                    _loc_9 = _loc_7;
                    _loc_10 = _loc_3 * (_loc_7 - _loc_5) + _loc_6;
                }
                else
                {
                    _loc_9 = (_loc_3 * _loc_5 - _loc_4 * _loc_7 - _loc_6 + _loc_8) / (_loc_3 - _loc_4);
                    _loc_10 = (_loc_7 - _loc_5 + _loc_6 / _loc_3 - _loc_8 / _loc_4) / (1 / _loc_3 - 1 / _loc_4);
                }
            }
            else
            {
                _loc_9 = Number.NaN;
                _loc_10 = Number.NaN;
            }
            return {_x:_loc_9, _y:_loc_10};
        }// end function

        public static function bisect(param1, param2) : Object
        {
            var _loc_3:* = (param1._x + param2._x) / 2;
            var _loc_4:* = (param1._y + param2._y) / 2;
            var _loc_5:* = Math.atan2(param2._y - param1._y, param2._x - param1._x) + Math.PI / 2;
            return {_x:_loc_3, _y:_loc_4, _a:_loc_5};
        }// end function

        public static function parallel(param1, param2) : Object
        {
            return {_x:param1._x, _y:param1._y, _a:param2._a};
        }// end function

        public static function ptLineDistance(param1, param2) : Object
        {
            var _loc_3:* = {_x:param1._x, _y:param1._y, _a:param2._a + Math.PI / 2};
            var _loc_4:* = intersect(param2, _loc_3);
            return distance(param1, _loc_4);
        }// end function

        public static function symmetry(param1, param2) : Object
        {
            var _loc_3:* = {_x:param1._x, _y:param1._y, _a:param2._a + Math.PI / 2};
            var _loc_4:* = intersect(param2, _loc_3);
            return {_x:_loc_4._x * 2 - param1._x, _y:_loc_4._y * 2 - param1._y};
        }// end function

        public static function leash(param1, param2, param3, param4 = null) : Object
        {
            var _loc_6:* = undefined;
            var _loc_5:* = Math.sqrt(Math.pow(param2._y - param1._y, 2) + Math.pow(param2._x - param1._x, 2));
            if (Math.sqrt(Math.pow(param2._y - param1._y, 2) + Math.pow(param2._x - param1._x, 2)) <= param3)
            {
                return param1;
            }
            if (param4 != null)
            {
                if (param4.toLowerCase() == "x" && Math.abs(param1._x - param2._x) < param3)
                {
                    _loc_6 = Math.sqrt(Math.pow(param3, 2) - Math.pow(param1._x - param2._x, 2));
                    if (param1._y - param2._y < 0)
                    {
                        _loc_6 = -_loc_6;
                    }
                    return {_x:param1._x, _y:param2._y + _loc_6};
                }
                else if (param4.toLowerCase() == "y" && Math.abs(param1._y - param2._y) < param3)
                {
                    _loc_6 = Math.sqrt(Math.pow(param3, 2) - Math.pow(param1._y - param2._y, 2));
                    if (param1._x - param2._x < 0)
                    {
                        _loc_6 = -_loc_6;
                    }
                    return {_x:param2._x + _loc_6, _y:param1._y};
                }
            }
            else
            {
                return {_x:param2._x + (param1._x - param2._x) * param3 / _loc_5, _y:param2._y + (param1._y - param2._y) * param3 / _loc_5};
            }
            return null;
        }// end function

        public static function midpoint(param1, param2) : Object
        {
            return {_x:param1._x + param2._x / 2, _y:param1._y + param2._y / 2};
        }// end function

        public static function distance(param1, param2) : Number
        {
            return Math.sqrt(Math.pow(param2._y - param1._y, 2) + Math.pow(param2._x - param1._x, 2));
        }// end function

        public static function angle(param1, param2) : Number
        {
            var _loc_3:* = Math.atan2(param2._y - param1._y, param2._x - param1._x);
            return _loc_3;
        }// end function

        public static function ptSymmetry(param1, param2) : Object
        {
            return {_x:param2._x * 2 - param1._x, _y:param2._y * 2 - param1._y};
        }// end function

        public static function ptAngel(param1, param2, param3) : Number
        {
            var _loc_4:* = angle(param1, param3);
            var _loc_5:* = angle(param2, param3);
            var _loc_6:* = _loc_4 - _loc_5;
            while (_loc_6 < 0)
            {
                
                _loc_6 = _loc_6 + Math.PI * 2;
            }
            while (_loc_6 > Math.PI * 2)
            {
                
                _loc_6 = _loc_6 - Math.PI * 2;
            }
            if (_loc_6 > Math.PI)
            {
                _loc_6 = Math.PI * 2 - _loc_6;
            }
            return _loc_6;
        }// end function

        public static function radian(param1, param2, param3) : Number
        {
            return Math.PI - ptAngel(param1, param2, param3);
        }// end function

    }
}
