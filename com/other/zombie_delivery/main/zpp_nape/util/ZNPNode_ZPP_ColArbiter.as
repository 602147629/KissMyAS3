package zpp_nape.util
{
    import flash.*;
    import zpp_nape.dynamics.*;

    public class ZNPNode_ZPP_ColArbiter extends Object
    {
        public var next:ZNPNode_ZPP_ColArbiter;
        public var elt:ZPP_ColArbiter;
        public static var zpp_pool:ZNPNode_ZPP_ColArbiter;

        public function ZNPNode_ZPP_ColArbiter() : void
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

        public function elem() : ZPP_ColArbiter
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
