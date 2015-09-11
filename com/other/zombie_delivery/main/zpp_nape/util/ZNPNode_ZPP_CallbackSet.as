package zpp_nape.util
{
    import flash.*;
    import zpp_nape.space.*;

    public class ZNPNode_ZPP_CallbackSet extends Object
    {
        public var next:ZNPNode_ZPP_CallbackSet;
        public var elt:ZPP_CallbackSet;
        public static var zpp_pool:ZNPNode_ZPP_CallbackSet;

        public function ZNPNode_ZPP_CallbackSet() : void
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

        public function elem() : ZPP_CallbackSet
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
