package zpp_nape.util
{
    import flash.*;
    import zpp_nape.callbacks.*;

    public class ZNPNode_ZPP_ConstraintListener extends Object
    {
        public var next:ZNPNode_ZPP_ConstraintListener;
        public var elt:ZPP_ConstraintListener;
        public static var zpp_pool:ZNPNode_ZPP_ConstraintListener;

        public function ZNPNode_ZPP_ConstraintListener() : void
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

        public function elem() : ZPP_ConstraintListener
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
