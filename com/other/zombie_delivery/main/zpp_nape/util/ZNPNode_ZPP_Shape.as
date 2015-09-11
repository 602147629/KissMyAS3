package zpp_nape.util
{
    import flash.*;
    import zpp_nape.shape.*;

    public class ZNPNode_ZPP_Shape extends Object
    {
        public var next:ZNPNode_ZPP_Shape;
        public var elt:ZPP_Shape;
        public static var zpp_pool:ZNPNode_ZPP_Shape;

        public function ZNPNode_ZPP_Shape() : void
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

        public function elem() : ZPP_Shape
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
