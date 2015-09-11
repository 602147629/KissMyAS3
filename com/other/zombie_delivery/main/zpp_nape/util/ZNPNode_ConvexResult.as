package zpp_nape.util
{
    import flash.*;
    import nape.geom.*;

    public class ZNPNode_ConvexResult extends Object
    {
        public var next:ZNPNode_ConvexResult;
        public var elt:ConvexResult;
        public static var zpp_pool:ZNPNode_ConvexResult;

        public function ZNPNode_ConvexResult() : void
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

        public function elem() : ConvexResult
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
