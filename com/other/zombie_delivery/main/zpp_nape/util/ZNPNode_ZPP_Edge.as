package zpp_nape.util
{
    import flash.*;
    import zpp_nape.shape.*;

    public class ZNPNode_ZPP_Edge extends Object
    {
        public var next:ZNPNode_ZPP_Edge;
        public var elt:ZPP_Edge;
        public static var zpp_pool:ZNPNode_ZPP_Edge;

        public function ZNPNode_ZPP_Edge() : void
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

        public function elem() : ZPP_Edge
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
