package zpp_nape.geom
{
    import flash.*;

    public class ZPP_CutInt extends Object
    {
        public var virtualint:Boolean;
        public var vertex:Boolean;
        public var time:Number;
        public var start:ZPP_GeomVert;
        public var path1:ZPP_CutVert;
        public var path0:ZPP_CutVert;
        public var next:ZPP_CutInt;
        public var end:ZPP_GeomVert;
        public static var zpp_pool:ZPP_CutInt;

        public function ZPP_CutInt() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            path1 = null;
            start = null;
            end = null;
            path0 = null;
            vertex = false;
            virtualint = false;
            time = 0;
            next = null;
            return;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null;
            start = null;
            end = _loc_1;
            var _loc_2:* = null;
            path1 = null;
            path0 = _loc_2;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function get(param1:Number, param2:ZPP_GeomVert = undefined, param3:ZPP_GeomVert = undefined, param4:ZPP_CutVert = undefined, param5:ZPP_CutVert = undefined, param6:Boolean = false, param7:Boolean = false) : ZPP_CutInt
        {
            var _loc_8:* = null as ZPP_CutInt;
            if (ZPP_CutInt.zpp_pool == null)
            {
                _loc_8 = new ZPP_CutInt();
            }
            else
            {
                _loc_8 = ZPP_CutInt.zpp_pool;
                ZPP_CutInt.zpp_pool = _loc_8.next;
                _loc_8.next = null;
            }
            _loc_8.virtualint = param6;
            _loc_8.end = param2;
            _loc_8.start = param3;
            _loc_8.path0 = param4;
            _loc_8.path1 = param5;
            _loc_8.time = param1;
            _loc_8.vertex = param7;
            return _loc_8;
        }// end function

    }
}
