package zpp_nape.geom
{
    import flash.*;

    public class ZPP_MarchPair extends Object
    {
        public var spanr:ZPP_MarchSpan;
        public var span2:ZPP_MarchSpan;
        public var span1:ZPP_MarchSpan;
        public var pr:ZPP_GeomVert;
        public var pd:ZPP_GeomVert;
        public var p2:ZPP_GeomVert;
        public var p1:ZPP_GeomVert;
        public var okeyr:int;
        public var okey2:int;
        public var okey1:int;
        public var next:ZPP_MarchPair;
        public var keyr:int;
        public var key2:int;
        public var key1:int;
        public static var zpp_pool:ZPP_MarchPair;

        public function ZPP_MarchPair() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            next = null;
            spanr = null;
            span2 = null;
            span1 = null;
            pd = null;
            okeyr = 0;
            keyr = 0;
            pr = null;
            okey2 = 0;
            key2 = 0;
            p2 = null;
            okey1 = 0;
            key1 = 0;
            p1 = null;
            return;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null;
            pd = null;
            _loc_1 = _loc_1;
            pr = _loc_1;
            _loc_1 = _loc_1;
            p2 = _loc_1;
            p1 = _loc_1;
            var _loc_2:* = null;
            spanr = null;
            _loc_2 = _loc_2;
            span2 = _loc_2;
            span1 = _loc_2;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
