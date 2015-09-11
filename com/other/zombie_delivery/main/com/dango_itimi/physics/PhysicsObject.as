package com.dango_itimi.physics
{
    import flash.*;
    import flash.display.*;
    import flash.geom.*;

    public class PhysicsObject extends Object
    {
        public var y:Number;
        public var x:Number;
        public var width:Number;
        public var radian:Number;
        public var height:Number;
        public var degree:Number;

        public function PhysicsObject(param1:MovieClip = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            degree = param1.rotation;
            radian = Math.PI / 180 * degree;
            param1.rotation = 0;
            var _loc_2:* = param1.getBounds(param1.parent);
            width = _loc_2.width;
            height = _loc_2.height;
            x = param1.x;
            y = param1.y;
            param1.rotation = degree;
            return;
        }// end function

        public function toString() : String
        {
            return ["x: " + x + ", ", "y: " + y + ", ", "width: " + width + ", ", "height: " + height + ", ", "degree: " + degree + ", ", "radian: " + radian + ", "].join("");
        }// end function

    }
}
