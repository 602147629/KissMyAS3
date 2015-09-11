package zpp_nape.geom
{
    import flash.*;

    public class ZPP_CutVert extends Object
    {
        public var vert:ZPP_GeomVert;
        public var value:Number;
        public var used:Boolean;
        public var rank:int;
        public var prev:ZPP_CutVert;
        public var posy:Number;
        public var posx:Number;
        public var positive:Boolean;
        public var parent:ZPP_CutVert;
        public var next:ZPP_CutVert;
        public static var zpp_pool:ZPP_CutVert;

        public function ZPP_CutVert() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            used = false;
            rank = 0;
            parent = null;
            positive = false;
            value = 0;
            vert = null;
            posy = 0;
            posx = 0;
            next = null;
            prev = null;
            return;
        }// end function

        public function free() : void
        {
            vert = null;
            parent = null;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function path(param1:ZPP_GeomVert) : ZPP_CutVert
        {
            var _loc_2:* = null as ZPP_CutVert;
            if (ZPP_CutVert.zpp_pool == null)
            {
                _loc_2 = new ZPP_CutVert();
            }
            else
            {
                _loc_2 = ZPP_CutVert.zpp_pool;
                ZPP_CutVert.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            _loc_2.vert = param1;
            _loc_2.parent = _loc_2;
            _loc_2.rank = 0;
            _loc_2.used = false;
            return _loc_2;
        }// end function

    }
}
