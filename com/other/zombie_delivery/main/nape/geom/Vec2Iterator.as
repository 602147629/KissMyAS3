package nape.geom
{
    import flash.*;
    import zpp_nape.util.*;

    final public class Vec2Iterator extends Object
    {
        public var zpp_next:Vec2Iterator;
        public var zpp_inner:Vec2List;
        public var zpp_i:int;
        public var zpp_critical:Boolean;
        public static var zpp_pool:Vec2Iterator;

        public function Vec2Iterator() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_next = null;
            zpp_critical = false;
            zpp_i = 0;
            zpp_inner = null;
            if (!ZPP_Vec2List.internal)
            {
                throw "Error: Cannot instantiate " + "Vec2" + "Iterator derp!";
            }
            return;
        }// end function

        public function next() : Vec2
        {
            zpp_critical = false;
            var _loc_1:* = zpp_i;
            (zpp_i + 1);
            return zpp_inner.at(_loc_1);
        }// end function

        public function hasNext() : Boolean
        {
            zpp_inner.zpp_inner.valmod();
            var _loc_1:* = zpp_inner.zpp_gl();
            zpp_critical = true;
            if (zpp_i < _loc_1)
            {
                return true;
            }
            else
            {
                zpp_next = Vec2Iterator.zpp_pool;
                Vec2Iterator.zpp_pool = this;
                zpp_inner = null;
                return false;
            }
        }// end function

        public static function get(param1:Vec2List) : Vec2Iterator
        {
            var _loc_2:* = null as Vec2Iterator;
            var _loc_3:* = null as Vec2Iterator;
            if (Vec2Iterator.zpp_pool == null)
            {
                ZPP_Vec2List.internal = true;
                _loc_3 = new Vec2Iterator();
                ZPP_Vec2List.internal = false;
                _loc_2 = _loc_3;
            }
            else
            {
                _loc_3 = Vec2Iterator.zpp_pool;
                Vec2Iterator.zpp_pool = _loc_3.zpp_next;
                _loc_2 = _loc_3;
            }
            _loc_2.zpp_i = 0;
            _loc_2.zpp_inner = param1;
            _loc_2.zpp_critical = false;
            return _loc_2;
        }// end function

    }
}
