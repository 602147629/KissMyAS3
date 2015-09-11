package zpp_nape.geom
{
    import flash.*;
    import zpp_nape.*;
    import zpp_nape.util.*;

    public class ZPP_SimpleVert extends Object
    {
        public var y:Number;
        public var x:Number;
        public var node:ZPP_Set_ZPP_SimpleVert;
        public var next:ZPP_SimpleVert;
        public var links:ZPP_Set_ZPP_SimpleVert;
        public var id:int;
        public var forced:Boolean;
        public static var zpp_pool:ZPP_SimpleVert;

        public function ZPP_SimpleVert() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            node = null;
            next = null;
            id = 0;
            links = null;
            y = 0;
            x = 0;
            forced = false;
            id = ZPP_ID.ZPP_SimpleVert();
            if (ZPP_Set_ZPP_SimpleVert.zpp_pool == null)
            {
                links = new ZPP_Set_ZPP_SimpleVert();
            }
            else
            {
                links = ZPP_Set_ZPP_SimpleVert.zpp_pool;
                ZPP_Set_ZPP_SimpleVert.zpp_pool = links.next;
                links.next = null;
            }
            links.lt = ZPP_SimpleVert.less_xy;
            return;
        }// end function

        public function free() : void
        {
            links.clear();
            node = null;
            forced = false;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function less_xy(param1:ZPP_SimpleVert, param2:ZPP_SimpleVert) : Boolean
        {
            if (param1.y >= param2.y)
            {
                if (param1.y == param2.y)
                {
                }
            }
            return param1.x < param2.x;
        }// end function

        public static function swap_nodes(param1:ZPP_SimpleVert, param2:ZPP_SimpleVert) : void
        {
            var _loc_3:* = param1.node;
            param1.node = param2.node;
            param2.node = _loc_3;
            return;
        }// end function

        public static function get(param1:Number, param2:Number) : ZPP_SimpleVert
        {
            var _loc_3:* = null as ZPP_SimpleVert;
            if (ZPP_SimpleVert.zpp_pool == null)
            {
                _loc_3 = new ZPP_SimpleVert();
            }
            else
            {
                _loc_3 = ZPP_SimpleVert.zpp_pool;
                ZPP_SimpleVert.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.x = param1;
            _loc_3.y = param2;
            return _loc_3;
        }// end function

    }
}
