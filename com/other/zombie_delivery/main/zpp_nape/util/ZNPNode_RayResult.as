package zpp_nape.util
{
    import flash.*;
    import nape.geom.*;

    public class ZNPNode_RayResult extends Object
    {
        public var next:ZNPNode_RayResult;
        public var elt:RayResult;
        public static var zpp_pool:ZNPNode_RayResult;

        public function ZNPNode_RayResult() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            elt = null;
            next = null;
            return;
        }// end function

        public function free() : void
        {
            elt = null;
            return;
        }// end function

        public function elem() : RayResult
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
