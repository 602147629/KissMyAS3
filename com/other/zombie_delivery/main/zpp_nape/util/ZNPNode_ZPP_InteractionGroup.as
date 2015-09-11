package zpp_nape.util
{
    import flash.*;
    import zpp_nape.dynamics.*;

    public class ZNPNode_ZPP_InteractionGroup extends Object
    {
        public var next:ZNPNode_ZPP_InteractionGroup;
        public var elt:ZPP_InteractionGroup;
        public static var zpp_pool:ZNPNode_ZPP_InteractionGroup;

        public function ZNPNode_ZPP_InteractionGroup() : void
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

        public function elem() : ZPP_InteractionGroup
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
