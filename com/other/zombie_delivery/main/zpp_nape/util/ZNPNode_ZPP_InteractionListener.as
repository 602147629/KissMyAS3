package zpp_nape.util
{
    import flash.*;
    import zpp_nape.callbacks.*;

    public class ZNPNode_ZPP_InteractionListener extends Object
    {
        public var next:ZNPNode_ZPP_InteractionListener;
        public var elt:ZPP_InteractionListener;
        public static var zpp_pool:ZNPNode_ZPP_InteractionListener;

        public function ZNPNode_ZPP_InteractionListener() : void
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

        public function elem() : ZPP_InteractionListener
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
