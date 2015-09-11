package zpp_nape.space
{
    import flash.*;
    import zpp_nape.geom.*;
    import zpp_nape.shape.*;

    public class ZPP_SweepData extends Object
    {
        public var shape:ZPP_Shape;
        public var prev:ZPP_SweepData;
        public var next:ZPP_SweepData;
        public var aabb:ZPP_AABB;
        public static var zpp_pool:ZPP_SweepData;

        public function ZPP_SweepData() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            aabb = null;
            shape = null;
            prev = null;
            next = null;
            return;
        }// end function

        public function gt(param1:ZPP_SweepData) : Boolean
        {
            return aabb.minx > param1.aabb.minx;
        }// end function

        public function free() : void
        {
            prev = null;
            shape = null;
            aabb = null;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
