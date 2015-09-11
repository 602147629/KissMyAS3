package zpp_nape.util
{
    import flash.*;
    import zpp_nape.geom.*;

    public class ZNPNode_ZPP_Vec2 extends Object
    {
        public var next:ZNPNode_ZPP_Vec2;
        public var elt:ZPP_Vec2;
        public static var zpp_pool:ZNPNode_ZPP_Vec2;

        public function ZNPNode_ZPP_Vec2() : void
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

        public function elem() : ZPP_Vec2
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
