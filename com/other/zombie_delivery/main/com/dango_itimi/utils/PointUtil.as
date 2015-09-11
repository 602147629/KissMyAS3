package com.dango_itimi.utils
{

    public class PointUtil extends Object
    {

        public function PointUtil() : void
        {
            return;
        }// end function

        public static function convert(param1) : Object
        {
            return {x:param1.x, y:param1.y};
        }// end function

        public static function create(param1:Number, param2:Number) : Object
        {
            return {x:param1, y:param2};
        }// end function

        public static function clone(param1:Object) : Object
        {
            return {x:param1.x, y:param1.y};
        }// end function

        public static function lengthSqr(param1:Object) : Number
        {
            return param1.x * param1.x + param1.y * param1.y;
        }// end function

        public static function getLength(param1:Object) : Number
        {
            return Math.sqrt(param1.x * param1.x + param1.y * param1.y);
        }// end function

        public static function angle(param1:Object) : Number
        {
            return Math.atan2(param1.y, param1.x);
        }// end function

        public static function angleBetween(param1:Object, param2:Object) : Number
        {
            return Math.atan2(param1.y - param2.y, param1.x - param2.x);
        }// end function

        public static function distanceSqr(param1:Object, param2:Object) : Number
        {
            var _loc_3:* = param1.x - param2.x;
            var _loc_4:* = param1.y - param2.y;
            return _loc_3 * _loc_3 + _loc_4 * _loc_4;
        }// end function

        public static function distance(param1:Object, param2:Object) : Number
        {
            var _loc_3:* = param1.x - param2.x;
            var _loc_4:* = param1.y - param2.y;
            return Math.sqrt(_loc_3 * _loc_3 + _loc_4 * _loc_4);
        }// end function

        public static function dot(param1:Object, param2:Object) : Number
        {
            return param1.x * param2.x + param1.y * param2.y;
        }// end function

        public static function cross(param1:Object, param2:Object) : Number
        {
            return param1.x * param2.y - param1.y * param2.x;
        }// end function

        public static function equals(param1:Object, param2:Object) : Boolean
        {
            if (param1.x == param2.x)
            {
            }
            return param1.y == param2.y;
        }// end function

        public static function nearEquals(param1:Object, param2:Object, param3:Object = undefined) : Boolean
        {
            if (param3 == null)
            {
                param3 = 0;
            }
            var _loc_4:* = Math.abs(param1.x - param2.x);
            var _loc_5:* = Math.abs(param1.y - param2.y);
            if (_loc_4 <= param3)
            {
            }
            return _loc_5 <= param3;
        }// end function

        public static function gt(param1:Object, param2:Object) : Boolean
        {
            if (param1.x > param2.x)
            {
            }
            return param1.y > param2.y;
        }// end function

        public static function gte(param1:Object, param2:Object) : Boolean
        {
            if (param1.x >= param2.x)
            {
            }
            return param1.y >= param2.y;
        }// end function

        public static function lt(param1:Object, param2:Object) : Boolean
        {
            if (param1.x < param2.x)
            {
            }
            return param1.y < param2.y;
        }// end function

        public static function lte(param1:Object, param2:Object) : Boolean
        {
            if (param1.x <= param2.x)
            {
            }
            return param1.y <= param2.y;
        }// end function

        public static function polar(param1:Number, param2:Number) : Object
        {
            return {x:param1 * Math.cos(param2), y:param1 * Math.sin(param2)};
        }// end function

        public static function add(param1:Object, param2:Object) : Object
        {
            return {x:param1.x + param2.x, y:param1.y + param2.y};
        }// end function

        public static function sub(param1:Object, param2:Object) : Object
        {
            return {x:param1.x - param2.x, y:param1.y - param2.y};
        }// end function

        public static function mul(param1:Object, param2:Number) : Object
        {
            return {x:param1.x * param2, y:param1.y * param2};
        }// end function

        public static function div(param1:Object, param2:Number) : Object
        {
            return {x:param1.x / param2, y:param1.y / param2};
        }// end function

        public static function abs(param1:Object) : Object
        {
            return {x:Math.abs(param1.x), y:Math.abs(param1.y)};
        }// end function

        public static function opposite(param1:Object) : Object
        {
            return {x:-param1.x, y:-param1.y};
        }// end function

        public static function perpendicular(param1:Object) : Object
        {
            return {x:-param1.y, y:param1.x};
        }// end function

        public static function normalize(param1:Object, param2:Object = undefined) : Object
        {
            if (param2 == null)
            {
                param2 = 1;
            }
            var _loc_3:* = param2 / Math.sqrt(param1.x * param1.x + param1.y * param1.y);
            return {x:param1.x * _loc_3, y:param1.y * _loc_3};
        }// end function

        public static function interpolate(param1:Object, param2:Object, param3:Number) : Object
        {
            return {x:(param2.x - param1.x) * param3 + param1.x, y:(param2.y - param1.y) * param3 + param1.y};
        }// end function

        public static function pivot(param1:Object, param2:Object, param3:Number) : Object
        {
            var _loc_4:* = param1.x - param2.y;
            var _loc_5:* = param1.y - param2.y;
            var _loc_6:* = Math.sqrt(_loc_4 * _loc_4 + _loc_5 * _loc_5);
            var _loc_7:* = Math.atan2(_loc_5, _loc_4) + param3;
            return {x:param2.x + _loc_6 * Math.cos(param3), y:param2.y + _loc_6 * Math.sin(param3)};
        }// end function

        public static function project(param1:Object, param2:Object) : Object
        {
            var _loc_3:* = 1 / (Math.sqrt(param1.x * param1.x + param1.y * param1.y) * Math.sqrt(param2.x * param2.x + param2.y * param2.y));
            var _loc_4:* = (param1.x * param2.x + param1.y * param2.y) * _loc_3;
            return {x:param2.x * _loc_4, y:param2.y * _loc_4};
        }// end function

    }
}
