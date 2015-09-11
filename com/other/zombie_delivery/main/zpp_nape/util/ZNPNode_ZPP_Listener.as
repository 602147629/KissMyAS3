package zpp_nape.util
{
    import flash.*;
    import zpp_nape.callbacks.*;

    public class ZNPNode_ZPP_Listener extends Object
    {
        public var next:ZNPNode_ZPP_Listener;
        public var elt:ZPP_Listener;
        public static var zpp_pool:ZNPNode_ZPP_Listener;

        public function ZNPNode_ZPP_Listener() : void
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

        public function elem() : ZPP_Listener
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
