package zpp_nape.space
{
    import flash.*;
    import nape.geom.*;
    import zpp_nape.geom.*;
    import zpp_nape.shape.*;

    public class ZPP_AABBNode extends Object
    {
        public var synced:Boolean;
        public var snext:ZPP_AABBNode;
        public var shape:ZPP_Shape;
        public var rayt:Number;
        public var parent:ZPP_AABBNode;
        public var next:ZPP_AABBNode;
        public var moved:Boolean;
        public var mnext:ZPP_AABBNode;
        public var height:int;
        public var first_sync:Boolean;
        public var dyn:Boolean;
        public var child2:ZPP_AABBNode;
        public var child1:ZPP_AABBNode;
        public var aabb:ZPP_AABB;
        public static var zpp_pool:ZPP_AABBNode;

        public function ZPP_AABBNode() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            first_sync = false;
            synced = false;
            snext = null;
            moved = false;
            mnext = null;
            next = null;
            rayt = 0;
            height = 0;
            child2 = null;
            child1 = null;
            parent = null;
            dyn = false;
            shape = null;
            aabb = null;
            height = -1;
            return;
        }// end function

        public function isLeaf() : Boolean
        {
            return child1 == null;
        }// end function

        public function free() : void
        {
            height = -1;
            var _loc_1:* = aabb;
            if (_loc_1.outer != null)
            {
                _loc_1.outer.zpp_inner = null;
                _loc_1.outer = null;
            }
            var _loc_2:* = null;
            _loc_1.wrap_max = null;
            _loc_1.wrap_min = _loc_2;
            _loc_1._invalidate = null;
            _loc_1._validate = null;
            _loc_1.next = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc_1;
            var _loc_3:* = null;
            parent = null;
            _loc_3 = _loc_3;
            child2 = _loc_3;
            child1 = _loc_3;
            next = null;
            snext = null;
            mnext = null;
            return;
        }// end function

        public function alloc() : void
        {
            if (ZPP_AABB.zpp_pool == null)
            {
                aabb = new ZPP_AABB();
            }
            else
            {
                aabb = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = aabb.next;
                aabb.next = null;
            }
            moved = false;
            synced = false;
            first_sync = false;
            return;
        }// end function

    }
}
