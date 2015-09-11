package zpp_nape.geom
{
    import flash.*;

    public class ZPP_SimplifyV extends Object
    {
        public var y:Number;
        public var x:Number;
        public var prev:ZPP_SimplifyV;
        public var next:ZPP_SimplifyV;
        public var forced:Boolean;
        public var flag:Boolean;
        public static var zpp_pool:ZPP_SimplifyV;

        public function ZPP_SimplifyV() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            forced = false;
            flag = false;
            prev = null;
            next = null;
            y = 0;
            x = 0;
            return;
        }// end function

        public function free() : void
        {
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function get(param1:ZPP_GeomVert) : ZPP_SimplifyV
        {
            var _loc_2:* = null as ZPP_SimplifyV;
            if (ZPP_SimplifyV.zpp_pool == null)
            {
                _loc_2 = new ZPP_SimplifyV();
            }
            else
            {
                _loc_2 = ZPP_SimplifyV.zpp_pool;
                ZPP_SimplifyV.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            _loc_2.x = param1.x;
            _loc_2.y = param1.y;
            _loc_2.flag = false;
            return _loc_2;
        }// end function

    }
}
