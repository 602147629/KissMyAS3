package zpp_nape.geom
{
    import flash.*;
    import nape.geom.*;

    public class ZPP_GeomPoly extends Object
    {
        public var vertices:ZPP_GeomVert;
        public var outer:GeomPoly;

        public function ZPP_GeomPoly(param1:GeomPoly = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            vertices = null;
            outer = null;
            outer = param1;
            return;
        }// end function

    }
}
