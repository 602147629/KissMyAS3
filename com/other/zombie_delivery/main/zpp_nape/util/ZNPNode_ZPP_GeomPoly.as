package zpp_nape.util
{
    import flash.*;
    import zpp_nape.geom.*;

    public class ZNPNode_ZPP_GeomPoly extends Object
    {
        public var next:ZNPNode_ZPP_GeomPoly;
        public var elt:ZPP_GeomPoly;
        public static var zpp_pool:ZNPNode_ZPP_GeomPoly;

        public function ZNPNode_ZPP_GeomPoly() : void
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

        public function elem() : ZPP_GeomPoly
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
