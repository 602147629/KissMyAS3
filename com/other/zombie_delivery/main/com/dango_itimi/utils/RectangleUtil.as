package com.dango_itimi.utils
{
    import flash.*;

    public class RectangleUtil extends Object
    {
        public var y:Number;
        public var x:Number;
        public var width:Number;
        public var right:Number;
        public var height:Number;
        public var bottom:Number;

        public function RectangleUtil(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            width = param3;
            height = param4;
            setPosition(param1, param2);
            return;
        }// end function

        public function toString() : String
        {
            return "w:" + width + ", h:" + height + ", x:" + x + ", y:" + y;
        }// end function

        public function setY(param1:Number) : void
        {
            y = param1;
            bottom = param1 + height;
            return;
        }// end function

        public function setX(param1:Number) : void
        {
            x = param1;
            right = param1 + width;
            return;
        }// end function

        public function setPosition(param1:Number, param2:Number) : void
        {
            setX(param1);
            setY(param2);
            return;
        }// end function

        public function hitTestPoint(param1:Number, param2:Number) : Boolean
        {
            if (x <= param1)
            {
            }
            if (y <= param2)
            {
            }
            if (right >= param1)
            {
            }
            return bottom >= param2;
        }// end function

        public function hitTestObject(param1:RectangleUtil) : Boolean
        {
            if (x > param1.right)
            {
                return false;
            }
            if (right < param1.x)
            {
                return false;
            }
            if (y > param1.bottom)
            {
                return false;
            }
            if (bottom < param1.y)
            {
                return false;
            }
            return true;
        }// end function

        public function clone() : RectangleUtil
        {
            return new RectangleUtil(x, y, width, height);
        }// end function

        public function addY(param1:Number) : void
        {
            y = y + param1;
            bottom = bottom + param1;
            return;
        }// end function

        public function addX(param1:Number) : void
        {
            x = x + param1;
            right = right + param1;
            return;
        }// end function

        public static function convert(param1:Object) : RectangleUtil
        {
            return new RectangleUtil(param1.x, param1.y, param1.width, param1.height);
        }// end function

    }
}
