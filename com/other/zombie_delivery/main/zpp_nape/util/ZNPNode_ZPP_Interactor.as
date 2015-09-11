package zpp_nape.util
{
    import flash.*;
    import zpp_nape.phys.*;

    public class ZNPNode_ZPP_Interactor extends Object
    {
        public var next:ZNPNode_ZPP_Interactor;
        public var elt:ZPP_Interactor;
        public static var zpp_pool:ZNPNode_ZPP_Interactor;

        public function ZNPNode_ZPP_Interactor() : void
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

        public function elem() : ZPP_Interactor
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
