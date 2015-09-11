package nape.geom
{
    import flash.*;
    import nape.shape.*;
    import zpp_nape.geom.*;

    final public class ConvexResult extends Object
    {
        public var zpp_inner:ZPP_ConvexRayResult;

        public function ConvexResult() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (!ZPP_ConvexRayResult.internal)
            {
                throw "Error: ConvexResult cannot be instantiated derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (zpp_inner.next != null)
            {
                throw "Error: This object has been disposed of and cannot be used";
            }
            if (zpp_inner.next != null)
            {
                throw "Error: This object has been disposed of and cannot be used";
            }
            if (zpp_inner.next != null)
            {
                throw "Error: This object has been disposed of and cannot be used";
            }
            return "{ shape: " + Std.string(zpp_inner.shape) + " toi: " + zpp_inner.toiDistance + " }";
        }// end function

        public function get_toi() : Number
        {
            if (zpp_inner.next != null)
            {
                throw "Error: This object has been disposed of and cannot be used";
            }
            return zpp_inner.toiDistance;
        }// end function

        public function get_shape() : Shape
        {
            if (zpp_inner.next != null)
            {
                throw "Error: This object has been disposed of and cannot be used";
            }
            return zpp_inner.shape;
        }// end function

        public function get_position() : Vec2
        {
            if (zpp_inner.next != null)
            {
                throw "Error: This object has been disposed of and cannot be used";
            }
            return zpp_inner.position;
        }// end function

        public function get_normal() : Vec2
        {
            if (zpp_inner.next != null)
            {
                throw "Error: This object has been disposed of and cannot be used";
            }
            return zpp_inner.normal;
        }// end function

        public function dispose() : void
        {
            if (zpp_inner.next != null)
            {
                throw "Error: This object has been disposed of and cannot be used";
            }
            zpp_inner.free();
            return;
        }// end function

    }
}
