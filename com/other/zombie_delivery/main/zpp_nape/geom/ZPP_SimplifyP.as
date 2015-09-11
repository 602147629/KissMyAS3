package zpp_nape.geom
{
    import flash.*;

    public class ZPP_SimplifyP extends Object
    {
        public var next:ZPP_SimplifyP;
        public var min:ZPP_SimplifyV;
        public var max:ZPP_SimplifyV;
        public static var zpp_pool:ZPP_SimplifyP;

        public function ZPP_SimplifyP() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            max = null;
            min = null;
            next = null;
            return;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null;
            max = null;
            min = _loc_1;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function get(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV) : ZPP_SimplifyP
        {
            var _loc_3:* = null as ZPP_SimplifyP;
            if (ZPP_SimplifyP.zpp_pool == null)
            {
                _loc_3 = new ZPP_SimplifyP();
            }
            else
            {
                _loc_3 = ZPP_SimplifyP.zpp_pool;
                ZPP_SimplifyP.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.min = param1;
            _loc_3.max = param2;
            return _loc_3;
        }// end function

    }
}
