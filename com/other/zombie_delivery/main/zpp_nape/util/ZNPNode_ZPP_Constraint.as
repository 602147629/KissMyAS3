package zpp_nape.util
{
    import flash.*;
    import zpp_nape.constraint.*;

    public class ZNPNode_ZPP_Constraint extends Object
    {
        public var next:ZNPNode_ZPP_Constraint;
        public var elt:ZPP_Constraint;
        public static var zpp_pool:ZNPNode_ZPP_Constraint;

        public function ZNPNode_ZPP_Constraint() : void
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

        public function elem() : ZPP_Constraint
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
