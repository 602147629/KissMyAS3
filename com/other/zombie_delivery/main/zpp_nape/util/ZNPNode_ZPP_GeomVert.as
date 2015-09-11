package zpp_nape.util
{
    import flash.*;
    import zpp_nape.geom.*;

    public class ZNPNode_ZPP_GeomVert extends Object
    {
        public var next:ZNPNode_ZPP_GeomVert;
        public var elt:ZPP_GeomVert;
        public static var zpp_pool:ZNPNode_ZPP_GeomVert;

        public function ZNPNode_ZPP_GeomVert() : void
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

        public function elem() : ZPP_GeomVert
        {
            return elt;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
