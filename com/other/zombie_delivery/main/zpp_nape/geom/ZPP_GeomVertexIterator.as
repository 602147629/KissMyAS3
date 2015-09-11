package zpp_nape.geom
{
    import flash.*;
    import nape.geom.*;

    public class ZPP_GeomVertexIterator extends Object
    {
        public var start:ZPP_GeomVert;
        public var ptr:ZPP_GeomVert;
        public var outer:GeomVertexIterator;
        public var next:ZPP_GeomVertexIterator;
        public var forward:Boolean;
        public var first:Boolean;
        public static var zpp_pool:ZPP_GeomVertexIterator;
        public static var internal:Boolean;

        public function ZPP_GeomVertexIterator() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            next = null;
            outer = null;
            forward = false;
            first = false;
            start = null;
            ptr = null;
            ZPP_GeomVertexIterator.internal = true;
            outer = new GeomVertexIterator();
            ZPP_GeomVertexIterator.internal = false;
            return;
        }// end function

        public function free() : void
        {
            outer.zpp_inner = null;
            var _loc_1:* = null;
            start = null;
            ptr = _loc_1;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function get(param1:ZPP_GeomVert, param2:Boolean) : GeomVertexIterator
        {
            var _loc_3:* = null as ZPP_GeomVertexIterator;
            if (ZPP_GeomVertexIterator.zpp_pool == null)
            {
                _loc_3 = new ZPP_GeomVertexIterator();
            }
            else
            {
                _loc_3 = ZPP_GeomVertexIterator.zpp_pool;
                ZPP_GeomVertexIterator.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.outer.zpp_inner = _loc_3;
            _loc_3.ptr = param1;
            _loc_3.forward = param2;
            _loc_3.start = param1;
            _loc_3.first = param1 != null;
            return _loc_3.outer;
        }// end function

    }
}
