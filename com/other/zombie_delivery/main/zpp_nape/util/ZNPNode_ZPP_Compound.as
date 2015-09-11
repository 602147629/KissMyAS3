package zpp_nape.util
{
    import flash.*;
    import zpp_nape.phys.*;

    public class ZNPNode_ZPP_Compound extends Object
    {
        public var next:ZNPNode_ZPP_Compound;
        public var elt:ZPP_Compound;
        public static var zpp_pool:ZNPNode_ZPP_Compound;

        public function ZNPNode_ZPP_Compound() : void
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

        public function elem() : ZPP_Compound
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
