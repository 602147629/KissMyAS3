package zpp_nape.util
{
    import flash.*;
    import zpp_nape.space.*;

    public class ZNPNode_ZPP_AABBPair extends Object
    {
        public var next:ZNPNode_ZPP_AABBPair;
        public var elt:ZPP_AABBPair;
        public static var zpp_pool:ZNPNode_ZPP_AABBPair;

        public function ZNPNode_ZPP_AABBPair() : void
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

        public function elem() : ZPP_AABBPair
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
