package zpp_nape.geom
{
    import flash.*;
    import zpp_nape.*;
    import zpp_nape.util.*;

    public class ZPP_SimpleSeg extends Object
    {
        public var vertices:ZPP_Set_ZPP_SimpleVert;
        public var right:ZPP_SimpleVert;
        public var prev:ZPP_SimpleSeg;
        public var node:ZPP_Set_ZPP_SimpleSeg;
        public var next:ZPP_SimpleSeg;
        public var left:ZPP_SimpleVert;
        public var id:int;
        public static var zpp_pool:ZPP_SimpleSeg;

        public function ZPP_SimpleSeg() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            node = null;
            prev = null;
            next = null;
            id = 0;
            vertices = null;
            right = null;
            left = null;
            id = ZPP_ID.ZPP_SimpleSeg();
            if (ZPP_Set_ZPP_SimpleVert.zpp_pool == null)
            {
                vertices = new ZPP_Set_ZPP_SimpleVert();
            }
            else
            {
                vertices = ZPP_Set_ZPP_SimpleVert.zpp_pool;
                ZPP_Set_ZPP_SimpleVert.zpp_pool = vertices.next;
                vertices.next = null;
            }
            vertices.lt = less_xy;
            return;
        }// end function

        public function less_xy(param1:ZPP_SimpleVert, param2:ZPP_SimpleVert) : Boolean
        {
            if (param1.x >= param2.x)
            {
                if (param1.x == param2.x)
                {
                }
            }
            return param1.y < param2.y;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null;
            right = null;
            left = _loc_1;
            prev = null;
            node = null;
            vertices.clear();
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function get(param1:ZPP_SimpleVert, param2:ZPP_SimpleVert) : ZPP_SimpleSeg
        {
            var _loc_3:* = null as ZPP_SimpleSeg;
            if (ZPP_SimpleSeg.zpp_pool == null)
            {
                _loc_3 = new ZPP_SimpleSeg();
            }
            else
            {
                _loc_3 = ZPP_SimpleSeg.zpp_pool;
                ZPP_SimpleSeg.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.left = param1;
            _loc_3.right = param2;
            _loc_3.vertices.insert(param1);
            _loc_3.vertices.insert(param2);
            return _loc_3;
        }// end function

    }
}
