package zpp_nape.geom
{
    import flash.*;
    import zpp_nape.util.*;

    public class ZPP_SimpleEvent extends Object
    {
        public var vertex:ZPP_SimpleVert;
        public var type:int;
        public var segment2:ZPP_SimpleSeg;
        public var segment:ZPP_SimpleSeg;
        public var node:ZPP_Set_ZPP_SimpleEvent;
        public var next:ZPP_SimpleEvent;
        public static var zpp_pool:ZPP_SimpleEvent;

        public function ZPP_SimpleEvent() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            next = null;
            node = null;
            segment2 = null;
            segment = null;
            vertex = null;
            type = 0;
            return;
        }// end function

        public function free() : void
        {
            vertex = null;
            var _loc_1:* = null;
            segment2 = null;
            segment = _loc_1;
            node = null;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function swap_nodes(event:ZPP_SimpleEvent, param2:ZPP_SimpleEvent) : void
        {
            var _loc_3:* = event.node;
            event.node = param2.node;
            param2.node = _loc_3;
            return;
        }// end function

        public static function less_xy(event:ZPP_SimpleEvent, param2:ZPP_SimpleEvent) : Boolean
        {
            if (event.vertex.x < param2.vertex.x)
            {
                return true;
            }
            else if (event.vertex.x > param2.vertex.x)
            {
                return false;
            }
            else if (event.vertex.y < param2.vertex.y)
            {
                return true;
            }
            else if (event.vertex.y > param2.vertex.y)
            {
                return false;
            }
            else
            {
                return event.type < param2.type;
            }
        }// end function

        public static function get(param1:ZPP_SimpleVert) : ZPP_SimpleEvent
        {
            var _loc_2:* = null as ZPP_SimpleEvent;
            if (ZPP_SimpleEvent.zpp_pool == null)
            {
                _loc_2 = new ZPP_SimpleEvent();
            }
            else
            {
                _loc_2 = ZPP_SimpleEvent.zpp_pool;
                ZPP_SimpleEvent.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            _loc_2.vertex = param1;
            return _loc_2;
        }// end function

    }
}
