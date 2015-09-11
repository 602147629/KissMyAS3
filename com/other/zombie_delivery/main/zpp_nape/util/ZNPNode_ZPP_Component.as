package zpp_nape.util
{
    import flash.*;
    import zpp_nape.space.*;

    public class ZNPNode_ZPP_Component extends Object
    {
        public var next:ZNPNode_ZPP_Component;
        public var elt:ZPP_Component;
        public static var zpp_pool:ZNPNode_ZPP_Component;

        public function ZNPNode_ZPP_Component() : void
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

        public function elem() : ZPP_Component
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
