package zpp_nape.geom
{
    import flash.*;
    import nape.geom.*;

    public class ZPP_Mat23 extends Object
    {
        public var ty:Number;
        public var tx:Number;
        public var outer:Mat23;
        public var next:ZPP_Mat23;
        public var d:Number;
        public var c:Number;
        public var b:Number;
        public var a:Number;
        public var _invalidate:Object;
        public static var zpp_pool:ZPP_Mat23;

        public function ZPP_Mat23() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            next = null;
            _invalidate = null;
            ty = 0;
            tx = 0;
            d = 0;
            c = 0;
            b = 0;
            a = 0;
            outer = null;
            return;
        }// end function

        public function wrapper() : Mat23
        {
            var _loc_1:* = null as ZPP_Mat23;
            if (outer == null)
            {
                outer = new Mat23();
                _loc_1 = outer.zpp_inner;
                _loc_1.next = ZPP_Mat23.zpp_pool;
                ZPP_Mat23.zpp_pool = _loc_1;
                outer.zpp_inner = this;
            }
            return outer;
        }// end function

        public function setas(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
        {
            tx = param5;
            ty = param6;
            a = param1;
            b = param2;
            c = param3;
            d = param4;
            return;
        }// end function

        public function set(param1:ZPP_Mat23) : void
        {
            setas(param1.a, param1.b, param1.c, param1.d, param1.tx, param1.ty);
            return;
        }// end function

        public function invalidate() : void
        {
            if (_invalidate != null)
            {
                _invalidate();
            }
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

        public static function get() : ZPP_Mat23
        {
            var _loc_1:* = null as ZPP_Mat23;
            if (ZPP_Mat23.zpp_pool == null)
            {
                _loc_1 = new ZPP_Mat23();
            }
            else
            {
                _loc_1 = ZPP_Mat23.zpp_pool;
                ZPP_Mat23.zpp_pool = _loc_1.next;
                _loc_1.next = null;
            }
            return _loc_1;
        }// end function

        public static function identity() : ZPP_Mat23
        {
            var _loc_1:* = ZPP_Mat23.get();
            _loc_1.setas(1, 0, 0, 1, 0, 0);
            return _loc_1;
        }// end function

    }
}
