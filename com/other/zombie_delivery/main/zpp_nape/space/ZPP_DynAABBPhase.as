package zpp_nape.space
{
    import flash.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_DynAABBPhase extends ZPP_Broadphase
    {
        public var treeStack2:ZNPList_ZPP_AABBNode;
        public var treeStack:ZNPList_ZPP_AABBNode;
        public var syncs:ZPP_AABBNode;
        public var stree:ZPP_AABBTree;
        public var pairs:ZPP_AABBPair;
        public var openlist:ZNPList_ZPP_AABBNode;
        public var moves:ZPP_AABBNode;
        public var failed:BodyList;
        public var dtree:ZPP_AABBTree;
        public static var FATTEN:Number;
        public static var VEL_STEPS:Number;

        public function ZPP_DynAABBPhase(param1:ZPP_Space = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            openlist = null;
            failed = null;
            treeStack2 = null;
            treeStack = null;
            moves = null;
            syncs = null;
            pairs = null;
            dtree = null;
            stree = null;
            space = param1;
            is_sweep = false;
            dynab = this;
            stree = new ZPP_AABBTree();
            dtree = new ZPP_AABBTree();
            return;
        }// end function

        public function sync_broadphase() : void
        {
            var _loc_1:* = null as ZPP_AABBNode;
            var _loc_2:* = null as ZPP_Shape;
            var _loc_3:* = null as ZPP_AABBTree;
            var _loc_4:* = null as ZPP_AABBNode;
            var _loc_5:* = null as ZPP_AABBNode;
            var _loc_6:* = null as ZPP_AABBNode;
            var _loc_7:* = null as ZPP_AABBNode;
            var _loc_8:* = null as ZPP_AABB;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = null as ZPP_AABBNode;
            var _loc_11:* = null as ZPP_AABBNode;
            var _loc_12:* = 0;
            var _loc_13:* = null as ZPP_AABBNode;
            var _loc_14:* = null as ZPP_AABBNode;
            var _loc_15:* = null as ZPP_AABB;
            var _loc_16:* = null as ZPP_AABB;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = null as ZPP_Circle;
            var _loc_20:* = null as ZPP_Polygon;
            var _loc_21:* = NaN;
            var _loc_22:* = null as ZPP_Vec2;
            var _loc_23:* = null as ZPP_Vec2;
            var _loc_24:* = null as ZPP_Vec2;
            var _loc_25:* = null as ZPP_Vec2;
            var _loc_26:* = NaN;
            var _loc_27:* = null as ZPP_Vec2;
            var _loc_28:* = null as ZPP_Body;
            var _loc_29:* = false;
            var _loc_30:* = null as ZPP_AABB;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = null as ZPP_AABB;
            space.validation();
            if (syncs != null)
            {
                if (moves == null)
                {
                    _loc_1 = syncs;
                    while (_loc_1 != null)
                    {
                        
                        _loc_2 = _loc_1.shape;
                        if (!_loc_1.first_sync)
                        {
                            if (_loc_1.dyn)
                            {
                                _loc_3 = dtree;
                            }
                            else
                            {
                                _loc_3 = stree;
                            }
                            if (_loc_1 == _loc_3.root)
                            {
                                _loc_3.root = null;
                            }
                            else
                            {
                                _loc_4 = _loc_1.parent;
                                _loc_5 = _loc_4.parent;
                                if (_loc_4.child1 == _loc_1)
                                {
                                    _loc_6 = _loc_4.child2;
                                }
                                else
                                {
                                    _loc_6 = _loc_4.child1;
                                }
                                if (_loc_5 != null)
                                {
                                    if (_loc_5.child1 == _loc_4)
                                    {
                                        _loc_5.child1 = _loc_6;
                                    }
                                    else
                                    {
                                        _loc_5.child2 = _loc_6;
                                    }
                                    _loc_6.parent = _loc_5;
                                    _loc_7 = _loc_4;
                                    _loc_7.height = -1;
                                    _loc_8 = _loc_7.aabb;
                                    if (_loc_8.outer != null)
                                    {
                                        _loc_8.outer.zpp_inner = null;
                                        _loc_8.outer = null;
                                    }
                                    _loc_9 = null;
                                    _loc_8.wrap_max = _loc_9;
                                    _loc_8.wrap_min = _loc_9;
                                    _loc_8._invalidate = null;
                                    _loc_8._validate = null;
                                    _loc_8.next = ZPP_AABB.zpp_pool;
                                    ZPP_AABB.zpp_pool = _loc_8;
                                    _loc_10 = null;
                                    _loc_7.parent = _loc_10;
                                    _loc_10 = _loc_10;
                                    _loc_7.child2 = _loc_10;
                                    _loc_7.child1 = _loc_10;
                                    _loc_7.next = null;
                                    _loc_7.snext = null;
                                    _loc_7.mnext = null;
                                    _loc_7.next = ZPP_AABBNode.zpp_pool;
                                    ZPP_AABBNode.zpp_pool = _loc_7;
                                    _loc_7 = _loc_5;
                                    while (_loc_7 != null)
                                    {
                                        
                                        if (_loc_7.child1 != null)
                                        {
                                        }
                                        if (_loc_7.height < 2)
                                        {
                                            _loc_7 = _loc_7;
                                        }
                                        else
                                        {
                                            _loc_10 = _loc_7.child1;
                                            _loc_11 = _loc_7.child2;
                                            _loc_12 = _loc_11.height - _loc_10.height;
                                            if (_loc_12 > 1)
                                            {
                                                _loc_13 = _loc_11.child1;
                                                _loc_14 = _loc_11.child2;
                                                _loc_11.child1 = _loc_7;
                                                _loc_11.parent = _loc_7.parent;
                                                _loc_7.parent = _loc_11;
                                                if (_loc_11.parent != null)
                                                {
                                                    if (_loc_11.parent.child1 == _loc_7)
                                                    {
                                                        _loc_11.parent.child1 = _loc_11;
                                                    }
                                                    else
                                                    {
                                                        _loc_11.parent.child2 = _loc_11;
                                                    }
                                                }
                                                else
                                                {
                                                    _loc_3.root = _loc_11;
                                                }
                                                if (_loc_13.height > _loc_14.height)
                                                {
                                                    _loc_11.child2 = _loc_13;
                                                    _loc_7.child2 = _loc_14;
                                                    _loc_14.parent = _loc_7;
                                                    _loc_8 = _loc_7.aabb;
                                                    _loc_15 = _loc_10.aabb;
                                                    _loc_16 = _loc_14.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_8 = _loc_11.aabb;
                                                    _loc_15 = _loc_7.aabb;
                                                    _loc_16 = _loc_13.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_17 = _loc_10.height;
                                                    _loc_18 = _loc_14.height;
                                                    _loc_7.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                    _loc_17 = _loc_7.height;
                                                    _loc_18 = _loc_13.height;
                                                    _loc_11.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                }
                                                else
                                                {
                                                    _loc_11.child2 = _loc_14;
                                                    _loc_7.child2 = _loc_13;
                                                    _loc_13.parent = _loc_7;
                                                    _loc_8 = _loc_7.aabb;
                                                    _loc_15 = _loc_10.aabb;
                                                    _loc_16 = _loc_13.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_8 = _loc_11.aabb;
                                                    _loc_15 = _loc_7.aabb;
                                                    _loc_16 = _loc_14.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_17 = _loc_10.height;
                                                    _loc_18 = _loc_13.height;
                                                    _loc_7.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                    _loc_17 = _loc_7.height;
                                                    _loc_18 = _loc_14.height;
                                                    _loc_11.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                }
                                                _loc_7 = _loc_11;
                                            }
                                            else if (_loc_12 < -1)
                                            {
                                                _loc_13 = _loc_10.child1;
                                                _loc_14 = _loc_10.child2;
                                                _loc_10.child1 = _loc_7;
                                                _loc_10.parent = _loc_7.parent;
                                                _loc_7.parent = _loc_10;
                                                if (_loc_10.parent != null)
                                                {
                                                    if (_loc_10.parent.child1 == _loc_7)
                                                    {
                                                        _loc_10.parent.child1 = _loc_10;
                                                    }
                                                    else
                                                    {
                                                        _loc_10.parent.child2 = _loc_10;
                                                    }
                                                }
                                                else
                                                {
                                                    _loc_3.root = _loc_10;
                                                }
                                                if (_loc_13.height > _loc_14.height)
                                                {
                                                    _loc_10.child2 = _loc_13;
                                                    _loc_7.child1 = _loc_14;
                                                    _loc_14.parent = _loc_7;
                                                    _loc_8 = _loc_7.aabb;
                                                    _loc_15 = _loc_11.aabb;
                                                    _loc_16 = _loc_14.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_8 = _loc_10.aabb;
                                                    _loc_15 = _loc_7.aabb;
                                                    _loc_16 = _loc_13.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_17 = _loc_11.height;
                                                    _loc_18 = _loc_14.height;
                                                    _loc_7.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                    _loc_17 = _loc_7.height;
                                                    _loc_18 = _loc_13.height;
                                                    _loc_10.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                }
                                                else
                                                {
                                                    _loc_10.child2 = _loc_14;
                                                    _loc_7.child1 = _loc_13;
                                                    _loc_13.parent = _loc_7;
                                                    _loc_8 = _loc_7.aabb;
                                                    _loc_15 = _loc_11.aabb;
                                                    _loc_16 = _loc_13.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_8 = _loc_10.aabb;
                                                    _loc_15 = _loc_7.aabb;
                                                    _loc_16 = _loc_14.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_17 = _loc_11.height;
                                                    _loc_18 = _loc_13.height;
                                                    _loc_7.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                    _loc_17 = _loc_7.height;
                                                    _loc_18 = _loc_14.height;
                                                    _loc_10.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                }
                                                _loc_7 = _loc_10;
                                            }
                                            else
                                            {
                                                _loc_7 = _loc_7;
                                            }
                                        }
                                        _loc_10 = _loc_7.child1;
                                        _loc_11 = _loc_7.child2;
                                        _loc_8 = _loc_7.aabb;
                                        _loc_15 = _loc_10.aabb;
                                        _loc_16 = _loc_11.aabb;
                                        if (_loc_15.minx < _loc_16.minx)
                                        {
                                            _loc_8.minx = _loc_15.minx;
                                        }
                                        else
                                        {
                                            _loc_8.minx = _loc_16.minx;
                                        }
                                        if (_loc_15.miny < _loc_16.miny)
                                        {
                                            _loc_8.miny = _loc_15.miny;
                                        }
                                        else
                                        {
                                            _loc_8.miny = _loc_16.miny;
                                        }
                                        if (_loc_15.maxx > _loc_16.maxx)
                                        {
                                            _loc_8.maxx = _loc_15.maxx;
                                        }
                                        else
                                        {
                                            _loc_8.maxx = _loc_16.maxx;
                                        }
                                        if (_loc_15.maxy > _loc_16.maxy)
                                        {
                                            _loc_8.maxy = _loc_15.maxy;
                                        }
                                        else
                                        {
                                            _loc_8.maxy = _loc_16.maxy;
                                        }
                                        _loc_12 = _loc_10.height;
                                        _loc_17 = _loc_11.height;
                                        _loc_7.height = 1 + (_loc_12 > _loc_17 ? (_loc_12) : (_loc_17));
                                        _loc_7 = _loc_7.parent;
                                    }
                                }
                                else
                                {
                                    _loc_3.root = _loc_6;
                                    _loc_6.parent = null;
                                    _loc_7 = _loc_4;
                                    _loc_7.height = -1;
                                    _loc_8 = _loc_7.aabb;
                                    if (_loc_8.outer != null)
                                    {
                                        _loc_8.outer.zpp_inner = null;
                                        _loc_8.outer = null;
                                    }
                                    _loc_9 = null;
                                    _loc_8.wrap_max = _loc_9;
                                    _loc_8.wrap_min = _loc_9;
                                    _loc_8._invalidate = null;
                                    _loc_8._validate = null;
                                    _loc_8.next = ZPP_AABB.zpp_pool;
                                    ZPP_AABB.zpp_pool = _loc_8;
                                    _loc_10 = null;
                                    _loc_7.parent = _loc_10;
                                    _loc_10 = _loc_10;
                                    _loc_7.child2 = _loc_10;
                                    _loc_7.child1 = _loc_10;
                                    _loc_7.next = null;
                                    _loc_7.snext = null;
                                    _loc_7.mnext = null;
                                    _loc_7.next = ZPP_AABBNode.zpp_pool;
                                    ZPP_AABBNode.zpp_pool = _loc_7;
                                }
                            }
                        }
                        else
                        {
                            _loc_1.first_sync = false;
                        }
                        _loc_8 = _loc_1.aabb;
                        if (!space.continuous)
                        {
                            if (_loc_2.zip_aabb)
                            {
                                if (_loc_2.body != null)
                                {
                                    _loc_2.zip_aabb = false;
                                    if (_loc_2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                    {
                                        _loc_19 = _loc_2.circle;
                                        if (_loc_19.zip_worldCOM)
                                        {
                                            if (_loc_19.body != null)
                                            {
                                                _loc_19.zip_worldCOM = false;
                                                if (_loc_19.zip_localCOM)
                                                {
                                                    _loc_19.zip_localCOM = false;
                                                    if (_loc_19.type == ZPP_Flags.id_ShapeType_POLYGON)
                                                    {
                                                        _loc_20 = _loc_19.polygon;
                                                        if (_loc_20.lverts.next == null)
                                                        {
                                                            throw "Error: An empty polygon has no meaningful localCOM";
                                                        }
                                                        if (_loc_20.lverts.next.next == null)
                                                        {
                                                            _loc_20.localCOMx = _loc_20.lverts.next.x;
                                                            _loc_20.localCOMy = _loc_20.lverts.next.y;
                                                        }
                                                        else if (_loc_20.lverts.next.next.next == null)
                                                        {
                                                            _loc_20.localCOMx = _loc_20.lverts.next.x;
                                                            _loc_20.localCOMy = _loc_20.lverts.next.y;
                                                            _loc_21 = 1;
                                                            _loc_20.localCOMx = _loc_20.localCOMx + _loc_20.lverts.next.next.x * _loc_21;
                                                            _loc_20.localCOMy = _loc_20.localCOMy + _loc_20.lverts.next.next.y * _loc_21;
                                                            _loc_21 = 0.5;
                                                            _loc_20.localCOMx = _loc_20.localCOMx * _loc_21;
                                                            _loc_20.localCOMy = _loc_20.localCOMy * _loc_21;
                                                        }
                                                        else
                                                        {
                                                            _loc_20.localCOMx = 0;
                                                            _loc_20.localCOMy = 0;
                                                            _loc_21 = 0;
                                                            _loc_22 = _loc_20.lverts.next;
                                                            _loc_23 = _loc_22;
                                                            _loc_22 = _loc_22.next;
                                                            _loc_24 = _loc_22;
                                                            _loc_22 = _loc_22.next;
                                                            while (_loc_22 != null)
                                                            {
                                                                
                                                                _loc_25 = _loc_22;
                                                                _loc_21 = _loc_21 + _loc_24.x * (_loc_25.y - _loc_23.y);
                                                                _loc_26 = _loc_25.y * _loc_24.x - _loc_25.x * _loc_24.y;
                                                                _loc_20.localCOMx = _loc_20.localCOMx + (_loc_24.x + _loc_25.x) * _loc_26;
                                                                _loc_20.localCOMy = _loc_20.localCOMy + (_loc_24.y + _loc_25.y) * _loc_26;
                                                                _loc_23 = _loc_24;
                                                                _loc_24 = _loc_25;
                                                                _loc_22 = _loc_22.next;
                                                            }
                                                            _loc_22 = _loc_20.lverts.next;
                                                            _loc_25 = _loc_22;
                                                            _loc_21 = _loc_21 + _loc_24.x * (_loc_25.y - _loc_23.y);
                                                            _loc_26 = _loc_25.y * _loc_24.x - _loc_25.x * _loc_24.y;
                                                            _loc_20.localCOMx = _loc_20.localCOMx + (_loc_24.x + _loc_25.x) * _loc_26;
                                                            _loc_20.localCOMy = _loc_20.localCOMy + (_loc_24.y + _loc_25.y) * _loc_26;
                                                            _loc_23 = _loc_24;
                                                            _loc_24 = _loc_25;
                                                            _loc_22 = _loc_22.next;
                                                            _loc_27 = _loc_22;
                                                            _loc_21 = _loc_21 + _loc_24.x * (_loc_27.y - _loc_23.y);
                                                            _loc_26 = _loc_27.y * _loc_24.x - _loc_27.x * _loc_24.y;
                                                            _loc_20.localCOMx = _loc_20.localCOMx + (_loc_24.x + _loc_27.x) * _loc_26;
                                                            _loc_20.localCOMy = _loc_20.localCOMy + (_loc_24.y + _loc_27.y) * _loc_26;
                                                            _loc_21 = 1 / (3 * _loc_21);
                                                            _loc_26 = _loc_21;
                                                            _loc_20.localCOMx = _loc_20.localCOMx * _loc_26;
                                                            _loc_20.localCOMy = _loc_20.localCOMy * _loc_26;
                                                        }
                                                    }
                                                    if (_loc_19.wrap_localCOM != null)
                                                    {
                                                        _loc_19.wrap_localCOM.zpp_inner.x = _loc_19.localCOMx;
                                                        _loc_19.wrap_localCOM.zpp_inner.y = _loc_19.localCOMy;
                                                    }
                                                }
                                                _loc_28 = _loc_19.body;
                                                if (_loc_28.zip_axis)
                                                {
                                                    _loc_28.zip_axis = false;
                                                    _loc_28.axisx = Math.sin(_loc_28.rot);
                                                    _loc_28.axisy = Math.cos(_loc_28.rot);
                                                }
                                                _loc_19.worldCOMx = _loc_19.body.posx + (_loc_19.body.axisy * _loc_19.localCOMx - _loc_19.body.axisx * _loc_19.localCOMy);
                                                _loc_19.worldCOMy = _loc_19.body.posy + (_loc_19.localCOMx * _loc_19.body.axisx + _loc_19.localCOMy * _loc_19.body.axisy);
                                            }
                                        }
                                        _loc_21 = _loc_19.radius;
                                        _loc_26 = _loc_19.radius;
                                        _loc_19.aabb.minx = _loc_19.worldCOMx - _loc_21;
                                        _loc_19.aabb.miny = _loc_19.worldCOMy - _loc_26;
                                        _loc_19.aabb.maxx = _loc_19.worldCOMx + _loc_21;
                                        _loc_19.aabb.maxy = _loc_19.worldCOMy + _loc_26;
                                    }
                                    else
                                    {
                                        _loc_20 = _loc_2.polygon;
                                        if (_loc_20.zip_gverts)
                                        {
                                            if (_loc_20.body != null)
                                            {
                                                _loc_20.zip_gverts = false;
                                                _loc_20.validate_lverts();
                                                _loc_28 = _loc_20.body;
                                                if (_loc_28.zip_axis)
                                                {
                                                    _loc_28.zip_axis = false;
                                                    _loc_28.axisx = Math.sin(_loc_28.rot);
                                                    _loc_28.axisy = Math.cos(_loc_28.rot);
                                                }
                                                _loc_22 = _loc_20.lverts.next;
                                                _loc_23 = _loc_20.gverts.next;
                                                while (_loc_23 != null)
                                                {
                                                    
                                                    _loc_24 = _loc_23;
                                                    _loc_25 = _loc_22;
                                                    _loc_22 = _loc_22.next;
                                                    _loc_24.x = _loc_20.body.posx + (_loc_20.body.axisy * _loc_25.x - _loc_20.body.axisx * _loc_25.y);
                                                    _loc_24.y = _loc_20.body.posy + (_loc_25.x * _loc_20.body.axisx + _loc_25.y * _loc_20.body.axisy);
                                                    _loc_23 = _loc_23.next;
                                                }
                                            }
                                        }
                                        if (_loc_20.lverts.next == null)
                                        {
                                            throw "Error: An empty polygon has no meaningful bounds";
                                        }
                                        _loc_22 = _loc_20.gverts.next;
                                        _loc_20.aabb.minx = _loc_22.x;
                                        _loc_20.aabb.miny = _loc_22.y;
                                        _loc_20.aabb.maxx = _loc_22.x;
                                        _loc_20.aabb.maxy = _loc_22.y;
                                        _loc_23 = _loc_20.gverts.next.next;
                                        while (_loc_23 != null)
                                        {
                                            
                                            _loc_24 = _loc_23;
                                            if (_loc_24.x < _loc_20.aabb.minx)
                                            {
                                                _loc_20.aabb.minx = _loc_24.x;
                                            }
                                            if (_loc_24.x > _loc_20.aabb.maxx)
                                            {
                                                _loc_20.aabb.maxx = _loc_24.x;
                                            }
                                            if (_loc_24.y < _loc_20.aabb.miny)
                                            {
                                                _loc_20.aabb.miny = _loc_24.y;
                                            }
                                            if (_loc_24.y > _loc_20.aabb.maxy)
                                            {
                                                _loc_20.aabb.maxy = _loc_24.y;
                                            }
                                            _loc_23 = _loc_23.next;
                                        }
                                    }
                                }
                            }
                        }
                        _loc_15 = _loc_2.aabb;
                        _loc_8.minx = _loc_15.minx - 3;
                        _loc_8.miny = _loc_15.miny - 3;
                        _loc_8.maxx = _loc_15.maxx + 3;
                        _loc_8.maxy = _loc_15.maxy + 3;
                        if (_loc_2.body.type == ZPP_Flags.id_BodyType_STATIC ? (_loc_29 = false, _loc_1.dyn = _loc_29, _loc_29) : (_loc_29 = !_loc_2.body.component.sleeping, _loc_1.dyn = _loc_29, _loc_29))
                        {
                            _loc_3 = dtree;
                        }
                        else
                        {
                            _loc_3 = stree;
                        }
                        if (_loc_3.root == null)
                        {
                            _loc_3.root = _loc_1;
                            _loc_3.root.parent = null;
                        }
                        else
                        {
                            _loc_15 = _loc_1.aabb;
                            _loc_4 = _loc_3.root;
                            while (_loc_4.child1 != null)
                            {
                                
                                _loc_5 = _loc_4.child1;
                                _loc_6 = _loc_4.child2;
                                _loc_16 = _loc_4.aabb;
                                _loc_21 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                _loc_16 = ZPP_AABBTree.tmpaabb;
                                _loc_30 = _loc_4.aabb;
                                if (_loc_30.minx < _loc_15.minx)
                                {
                                    _loc_16.minx = _loc_30.minx;
                                }
                                else
                                {
                                    _loc_16.minx = _loc_15.minx;
                                }
                                if (_loc_30.miny < _loc_15.miny)
                                {
                                    _loc_16.miny = _loc_30.miny;
                                }
                                else
                                {
                                    _loc_16.miny = _loc_15.miny;
                                }
                                if (_loc_30.maxx > _loc_15.maxx)
                                {
                                    _loc_16.maxx = _loc_30.maxx;
                                }
                                else
                                {
                                    _loc_16.maxx = _loc_15.maxx;
                                }
                                if (_loc_30.maxy > _loc_15.maxy)
                                {
                                    _loc_16.maxy = _loc_30.maxy;
                                }
                                else
                                {
                                    _loc_16.maxy = _loc_15.maxy;
                                }
                                _loc_16 = ZPP_AABBTree.tmpaabb;
                                _loc_26 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                _loc_31 = 2 * _loc_26;
                                _loc_32 = 2 * (_loc_26 - _loc_21);
                                _loc_16 = ZPP_AABBTree.tmpaabb;
                                _loc_30 = _loc_5.aabb;
                                if (_loc_15.minx < _loc_30.minx)
                                {
                                    _loc_16.minx = _loc_15.minx;
                                }
                                else
                                {
                                    _loc_16.minx = _loc_30.minx;
                                }
                                if (_loc_15.miny < _loc_30.miny)
                                {
                                    _loc_16.miny = _loc_15.miny;
                                }
                                else
                                {
                                    _loc_16.miny = _loc_30.miny;
                                }
                                if (_loc_15.maxx > _loc_30.maxx)
                                {
                                    _loc_16.maxx = _loc_15.maxx;
                                }
                                else
                                {
                                    _loc_16.maxx = _loc_30.maxx;
                                }
                                if (_loc_15.maxy > _loc_30.maxy)
                                {
                                    _loc_16.maxy = _loc_15.maxy;
                                }
                                else
                                {
                                    _loc_16.maxy = _loc_30.maxy;
                                }
                                if (_loc_5.child1 == null)
                                {
                                    _loc_16 = ZPP_AABBTree.tmpaabb;
                                    _loc_33 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2 + _loc_32;
                                }
                                else
                                {
                                    _loc_16 = _loc_5.aabb;
                                    _loc_34 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                    _loc_16 = ZPP_AABBTree.tmpaabb;
                                    _loc_35 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                    _loc_33 = _loc_35 - _loc_34 + _loc_32;
                                }
                                _loc_16 = ZPP_AABBTree.tmpaabb;
                                _loc_30 = _loc_6.aabb;
                                if (_loc_15.minx < _loc_30.minx)
                                {
                                    _loc_16.minx = _loc_15.minx;
                                }
                                else
                                {
                                    _loc_16.minx = _loc_30.minx;
                                }
                                if (_loc_15.miny < _loc_30.miny)
                                {
                                    _loc_16.miny = _loc_15.miny;
                                }
                                else
                                {
                                    _loc_16.miny = _loc_30.miny;
                                }
                                if (_loc_15.maxx > _loc_30.maxx)
                                {
                                    _loc_16.maxx = _loc_15.maxx;
                                }
                                else
                                {
                                    _loc_16.maxx = _loc_30.maxx;
                                }
                                if (_loc_15.maxy > _loc_30.maxy)
                                {
                                    _loc_16.maxy = _loc_15.maxy;
                                }
                                else
                                {
                                    _loc_16.maxy = _loc_30.maxy;
                                }
                                if (_loc_6.child1 == null)
                                {
                                    _loc_16 = ZPP_AABBTree.tmpaabb;
                                    _loc_34 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2 + _loc_32;
                                }
                                else
                                {
                                    _loc_16 = _loc_6.aabb;
                                    _loc_35 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                    _loc_16 = ZPP_AABBTree.tmpaabb;
                                    _loc_36 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                    _loc_34 = _loc_36 - _loc_35 + _loc_32;
                                }
                                if (_loc_31 < _loc_33)
                                {
                                }
                                if (_loc_31 < _loc_34)
                                {
                                    break;
                                    continue;
                                }
                                if (_loc_33 < _loc_34)
                                {
                                    _loc_4 = _loc_5;
                                    continue;
                                }
                                _loc_4 = _loc_6;
                            }
                            _loc_5 = _loc_4;
                            _loc_6 = _loc_5.parent;
                            if (ZPP_AABBNode.zpp_pool == null)
                            {
                                _loc_7 = new ZPP_AABBNode();
                            }
                            else
                            {
                                _loc_7 = ZPP_AABBNode.zpp_pool;
                                ZPP_AABBNode.zpp_pool = _loc_7.next;
                                _loc_7.next = null;
                            }
                            if (ZPP_AABB.zpp_pool == null)
                            {
                                _loc_7.aabb = new ZPP_AABB();
                            }
                            else
                            {
                                _loc_7.aabb = ZPP_AABB.zpp_pool;
                                ZPP_AABB.zpp_pool = _loc_7.aabb.next;
                                _loc_7.aabb.next = null;
                            }
                            _loc_7.moved = false;
                            _loc_7.synced = false;
                            _loc_7.first_sync = false;
                            _loc_7.parent = _loc_6;
                            _loc_16 = _loc_7.aabb;
                            _loc_30 = _loc_5.aabb;
                            if (_loc_15.minx < _loc_30.minx)
                            {
                                _loc_16.minx = _loc_15.minx;
                            }
                            else
                            {
                                _loc_16.minx = _loc_30.minx;
                            }
                            if (_loc_15.miny < _loc_30.miny)
                            {
                                _loc_16.miny = _loc_15.miny;
                            }
                            else
                            {
                                _loc_16.miny = _loc_30.miny;
                            }
                            if (_loc_15.maxx > _loc_30.maxx)
                            {
                                _loc_16.maxx = _loc_15.maxx;
                            }
                            else
                            {
                                _loc_16.maxx = _loc_30.maxx;
                            }
                            if (_loc_15.maxy > _loc_30.maxy)
                            {
                                _loc_16.maxy = _loc_15.maxy;
                            }
                            else
                            {
                                _loc_16.maxy = _loc_30.maxy;
                            }
                            _loc_7.height = _loc_5.height + 1;
                            if (_loc_6 != null)
                            {
                                if (_loc_6.child1 == _loc_5)
                                {
                                    _loc_6.child1 = _loc_7;
                                }
                                else
                                {
                                    _loc_6.child2 = _loc_7;
                                }
                                _loc_7.child1 = _loc_5;
                                _loc_7.child2 = _loc_1;
                                _loc_5.parent = _loc_7;
                                _loc_1.parent = _loc_7;
                            }
                            else
                            {
                                _loc_7.child1 = _loc_5;
                                _loc_7.child2 = _loc_1;
                                _loc_5.parent = _loc_7;
                                _loc_1.parent = _loc_7;
                                _loc_3.root = _loc_7;
                            }
                            _loc_4 = _loc_1.parent;
                            while (_loc_4 != null)
                            {
                                
                                if (_loc_4.child1 != null)
                                {
                                }
                                if (_loc_4.height < 2)
                                {
                                    _loc_4 = _loc_4;
                                }
                                else
                                {
                                    _loc_10 = _loc_4.child1;
                                    _loc_11 = _loc_4.child2;
                                    _loc_12 = _loc_11.height - _loc_10.height;
                                    if (_loc_12 > 1)
                                    {
                                        _loc_13 = _loc_11.child1;
                                        _loc_14 = _loc_11.child2;
                                        _loc_11.child1 = _loc_4;
                                        _loc_11.parent = _loc_4.parent;
                                        _loc_4.parent = _loc_11;
                                        if (_loc_11.parent != null)
                                        {
                                            if (_loc_11.parent.child1 == _loc_4)
                                            {
                                                _loc_11.parent.child1 = _loc_11;
                                            }
                                            else
                                            {
                                                _loc_11.parent.child2 = _loc_11;
                                            }
                                        }
                                        else
                                        {
                                            _loc_3.root = _loc_11;
                                        }
                                        if (_loc_13.height > _loc_14.height)
                                        {
                                            _loc_11.child2 = _loc_13;
                                            _loc_4.child2 = _loc_14;
                                            _loc_14.parent = _loc_4;
                                            _loc_16 = _loc_4.aabb;
                                            _loc_30 = _loc_10.aabb;
                                            _loc_37 = _loc_14.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_16 = _loc_11.aabb;
                                            _loc_30 = _loc_4.aabb;
                                            _loc_37 = _loc_13.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_17 = _loc_10.height;
                                            _loc_18 = _loc_14.height;
                                            _loc_4.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                            _loc_17 = _loc_4.height;
                                            _loc_18 = _loc_13.height;
                                            _loc_11.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                        }
                                        else
                                        {
                                            _loc_11.child2 = _loc_14;
                                            _loc_4.child2 = _loc_13;
                                            _loc_13.parent = _loc_4;
                                            _loc_16 = _loc_4.aabb;
                                            _loc_30 = _loc_10.aabb;
                                            _loc_37 = _loc_13.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_16 = _loc_11.aabb;
                                            _loc_30 = _loc_4.aabb;
                                            _loc_37 = _loc_14.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_17 = _loc_10.height;
                                            _loc_18 = _loc_13.height;
                                            _loc_4.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                            _loc_17 = _loc_4.height;
                                            _loc_18 = _loc_14.height;
                                            _loc_11.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                        }
                                        _loc_4 = _loc_11;
                                    }
                                    else if (_loc_12 < -1)
                                    {
                                        _loc_13 = _loc_10.child1;
                                        _loc_14 = _loc_10.child2;
                                        _loc_10.child1 = _loc_4;
                                        _loc_10.parent = _loc_4.parent;
                                        _loc_4.parent = _loc_10;
                                        if (_loc_10.parent != null)
                                        {
                                            if (_loc_10.parent.child1 == _loc_4)
                                            {
                                                _loc_10.parent.child1 = _loc_10;
                                            }
                                            else
                                            {
                                                _loc_10.parent.child2 = _loc_10;
                                            }
                                        }
                                        else
                                        {
                                            _loc_3.root = _loc_10;
                                        }
                                        if (_loc_13.height > _loc_14.height)
                                        {
                                            _loc_10.child2 = _loc_13;
                                            _loc_4.child1 = _loc_14;
                                            _loc_14.parent = _loc_4;
                                            _loc_16 = _loc_4.aabb;
                                            _loc_30 = _loc_11.aabb;
                                            _loc_37 = _loc_14.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_16 = _loc_10.aabb;
                                            _loc_30 = _loc_4.aabb;
                                            _loc_37 = _loc_13.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_17 = _loc_11.height;
                                            _loc_18 = _loc_14.height;
                                            _loc_4.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                            _loc_17 = _loc_4.height;
                                            _loc_18 = _loc_13.height;
                                            _loc_10.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                        }
                                        else
                                        {
                                            _loc_10.child2 = _loc_14;
                                            _loc_4.child1 = _loc_13;
                                            _loc_13.parent = _loc_4;
                                            _loc_16 = _loc_4.aabb;
                                            _loc_30 = _loc_11.aabb;
                                            _loc_37 = _loc_13.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_16 = _loc_10.aabb;
                                            _loc_30 = _loc_4.aabb;
                                            _loc_37 = _loc_14.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_17 = _loc_11.height;
                                            _loc_18 = _loc_13.height;
                                            _loc_4.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                            _loc_17 = _loc_4.height;
                                            _loc_18 = _loc_14.height;
                                            _loc_10.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                        }
                                        _loc_4 = _loc_10;
                                    }
                                    else
                                    {
                                        _loc_4 = _loc_4;
                                    }
                                }
                                _loc_10 = _loc_4.child1;
                                _loc_11 = _loc_4.child2;
                                _loc_12 = _loc_10.height;
                                _loc_17 = _loc_11.height;
                                _loc_4.height = 1 + (_loc_12 > _loc_17 ? (_loc_12) : (_loc_17));
                                _loc_16 = _loc_4.aabb;
                                _loc_30 = _loc_10.aabb;
                                _loc_37 = _loc_11.aabb;
                                if (_loc_30.minx < _loc_37.minx)
                                {
                                    _loc_16.minx = _loc_30.minx;
                                }
                                else
                                {
                                    _loc_16.minx = _loc_37.minx;
                                }
                                if (_loc_30.miny < _loc_37.miny)
                                {
                                    _loc_16.miny = _loc_30.miny;
                                }
                                else
                                {
                                    _loc_16.miny = _loc_37.miny;
                                }
                                if (_loc_30.maxx > _loc_37.maxx)
                                {
                                    _loc_16.maxx = _loc_30.maxx;
                                }
                                else
                                {
                                    _loc_16.maxx = _loc_37.maxx;
                                }
                                if (_loc_30.maxy > _loc_37.maxy)
                                {
                                    _loc_16.maxy = _loc_30.maxy;
                                }
                                else
                                {
                                    _loc_16.maxy = _loc_37.maxy;
                                }
                                _loc_4 = _loc_4.parent;
                            }
                        }
                        _loc_1.synced = false;
                        _loc_1.moved = true;
                        _loc_1.mnext = _loc_1.snext;
                        _loc_1.snext = null;
                        _loc_1 = _loc_1.mnext;
                    }
                    _loc_4 = syncs;
                    syncs = moves;
                    moves = _loc_4;
                }
                else
                {
                    while (syncs != null)
                    {
                        
                        _loc_4 = syncs;
                        syncs = _loc_4.snext;
                        _loc_4.snext = null;
                        _loc_1 = _loc_4;
                        _loc_2 = _loc_1.shape;
                        if (!_loc_1.first_sync)
                        {
                            if (_loc_1.dyn)
                            {
                                _loc_3 = dtree;
                            }
                            else
                            {
                                _loc_3 = stree;
                            }
                            if (_loc_1 == _loc_3.root)
                            {
                                _loc_3.root = null;
                            }
                            else
                            {
                                _loc_4 = _loc_1.parent;
                                _loc_5 = _loc_4.parent;
                                if (_loc_4.child1 == _loc_1)
                                {
                                    _loc_6 = _loc_4.child2;
                                }
                                else
                                {
                                    _loc_6 = _loc_4.child1;
                                }
                                if (_loc_5 != null)
                                {
                                    if (_loc_5.child1 == _loc_4)
                                    {
                                        _loc_5.child1 = _loc_6;
                                    }
                                    else
                                    {
                                        _loc_5.child2 = _loc_6;
                                    }
                                    _loc_6.parent = _loc_5;
                                    _loc_7 = _loc_4;
                                    _loc_7.height = -1;
                                    _loc_8 = _loc_7.aabb;
                                    if (_loc_8.outer != null)
                                    {
                                        _loc_8.outer.zpp_inner = null;
                                        _loc_8.outer = null;
                                    }
                                    _loc_9 = null;
                                    _loc_8.wrap_max = _loc_9;
                                    _loc_8.wrap_min = _loc_9;
                                    _loc_8._invalidate = null;
                                    _loc_8._validate = null;
                                    _loc_8.next = ZPP_AABB.zpp_pool;
                                    ZPP_AABB.zpp_pool = _loc_8;
                                    _loc_10 = null;
                                    _loc_7.parent = _loc_10;
                                    _loc_10 = _loc_10;
                                    _loc_7.child2 = _loc_10;
                                    _loc_7.child1 = _loc_10;
                                    _loc_7.next = null;
                                    _loc_7.snext = null;
                                    _loc_7.mnext = null;
                                    _loc_7.next = ZPP_AABBNode.zpp_pool;
                                    ZPP_AABBNode.zpp_pool = _loc_7;
                                    _loc_7 = _loc_5;
                                    while (_loc_7 != null)
                                    {
                                        
                                        if (_loc_7.child1 != null)
                                        {
                                        }
                                        if (_loc_7.height < 2)
                                        {
                                            _loc_7 = _loc_7;
                                        }
                                        else
                                        {
                                            _loc_10 = _loc_7.child1;
                                            _loc_11 = _loc_7.child2;
                                            _loc_12 = _loc_11.height - _loc_10.height;
                                            if (_loc_12 > 1)
                                            {
                                                _loc_13 = _loc_11.child1;
                                                _loc_14 = _loc_11.child2;
                                                _loc_11.child1 = _loc_7;
                                                _loc_11.parent = _loc_7.parent;
                                                _loc_7.parent = _loc_11;
                                                if (_loc_11.parent != null)
                                                {
                                                    if (_loc_11.parent.child1 == _loc_7)
                                                    {
                                                        _loc_11.parent.child1 = _loc_11;
                                                    }
                                                    else
                                                    {
                                                        _loc_11.parent.child2 = _loc_11;
                                                    }
                                                }
                                                else
                                                {
                                                    _loc_3.root = _loc_11;
                                                }
                                                if (_loc_13.height > _loc_14.height)
                                                {
                                                    _loc_11.child2 = _loc_13;
                                                    _loc_7.child2 = _loc_14;
                                                    _loc_14.parent = _loc_7;
                                                    _loc_8 = _loc_7.aabb;
                                                    _loc_15 = _loc_10.aabb;
                                                    _loc_16 = _loc_14.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_8 = _loc_11.aabb;
                                                    _loc_15 = _loc_7.aabb;
                                                    _loc_16 = _loc_13.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_17 = _loc_10.height;
                                                    _loc_18 = _loc_14.height;
                                                    _loc_7.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                    _loc_17 = _loc_7.height;
                                                    _loc_18 = _loc_13.height;
                                                    _loc_11.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                }
                                                else
                                                {
                                                    _loc_11.child2 = _loc_14;
                                                    _loc_7.child2 = _loc_13;
                                                    _loc_13.parent = _loc_7;
                                                    _loc_8 = _loc_7.aabb;
                                                    _loc_15 = _loc_10.aabb;
                                                    _loc_16 = _loc_13.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_8 = _loc_11.aabb;
                                                    _loc_15 = _loc_7.aabb;
                                                    _loc_16 = _loc_14.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_17 = _loc_10.height;
                                                    _loc_18 = _loc_13.height;
                                                    _loc_7.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                    _loc_17 = _loc_7.height;
                                                    _loc_18 = _loc_14.height;
                                                    _loc_11.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                }
                                                _loc_7 = _loc_11;
                                            }
                                            else if (_loc_12 < -1)
                                            {
                                                _loc_13 = _loc_10.child1;
                                                _loc_14 = _loc_10.child2;
                                                _loc_10.child1 = _loc_7;
                                                _loc_10.parent = _loc_7.parent;
                                                _loc_7.parent = _loc_10;
                                                if (_loc_10.parent != null)
                                                {
                                                    if (_loc_10.parent.child1 == _loc_7)
                                                    {
                                                        _loc_10.parent.child1 = _loc_10;
                                                    }
                                                    else
                                                    {
                                                        _loc_10.parent.child2 = _loc_10;
                                                    }
                                                }
                                                else
                                                {
                                                    _loc_3.root = _loc_10;
                                                }
                                                if (_loc_13.height > _loc_14.height)
                                                {
                                                    _loc_10.child2 = _loc_13;
                                                    _loc_7.child1 = _loc_14;
                                                    _loc_14.parent = _loc_7;
                                                    _loc_8 = _loc_7.aabb;
                                                    _loc_15 = _loc_11.aabb;
                                                    _loc_16 = _loc_14.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_8 = _loc_10.aabb;
                                                    _loc_15 = _loc_7.aabb;
                                                    _loc_16 = _loc_13.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_17 = _loc_11.height;
                                                    _loc_18 = _loc_14.height;
                                                    _loc_7.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                    _loc_17 = _loc_7.height;
                                                    _loc_18 = _loc_13.height;
                                                    _loc_10.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                }
                                                else
                                                {
                                                    _loc_10.child2 = _loc_14;
                                                    _loc_7.child1 = _loc_13;
                                                    _loc_13.parent = _loc_7;
                                                    _loc_8 = _loc_7.aabb;
                                                    _loc_15 = _loc_11.aabb;
                                                    _loc_16 = _loc_13.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_8 = _loc_10.aabb;
                                                    _loc_15 = _loc_7.aabb;
                                                    _loc_16 = _loc_14.aabb;
                                                    if (_loc_15.minx < _loc_16.minx)
                                                    {
                                                        _loc_8.minx = _loc_15.minx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.minx = _loc_16.minx;
                                                    }
                                                    if (_loc_15.miny < _loc_16.miny)
                                                    {
                                                        _loc_8.miny = _loc_15.miny;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.miny = _loc_16.miny;
                                                    }
                                                    if (_loc_15.maxx > _loc_16.maxx)
                                                    {
                                                        _loc_8.maxx = _loc_15.maxx;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxx = _loc_16.maxx;
                                                    }
                                                    if (_loc_15.maxy > _loc_16.maxy)
                                                    {
                                                        _loc_8.maxy = _loc_15.maxy;
                                                    }
                                                    else
                                                    {
                                                        _loc_8.maxy = _loc_16.maxy;
                                                    }
                                                    _loc_17 = _loc_11.height;
                                                    _loc_18 = _loc_13.height;
                                                    _loc_7.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                    _loc_17 = _loc_7.height;
                                                    _loc_18 = _loc_14.height;
                                                    _loc_10.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                                }
                                                _loc_7 = _loc_10;
                                            }
                                            else
                                            {
                                                _loc_7 = _loc_7;
                                            }
                                        }
                                        _loc_10 = _loc_7.child1;
                                        _loc_11 = _loc_7.child2;
                                        _loc_8 = _loc_7.aabb;
                                        _loc_15 = _loc_10.aabb;
                                        _loc_16 = _loc_11.aabb;
                                        if (_loc_15.minx < _loc_16.minx)
                                        {
                                            _loc_8.minx = _loc_15.minx;
                                        }
                                        else
                                        {
                                            _loc_8.minx = _loc_16.minx;
                                        }
                                        if (_loc_15.miny < _loc_16.miny)
                                        {
                                            _loc_8.miny = _loc_15.miny;
                                        }
                                        else
                                        {
                                            _loc_8.miny = _loc_16.miny;
                                        }
                                        if (_loc_15.maxx > _loc_16.maxx)
                                        {
                                            _loc_8.maxx = _loc_15.maxx;
                                        }
                                        else
                                        {
                                            _loc_8.maxx = _loc_16.maxx;
                                        }
                                        if (_loc_15.maxy > _loc_16.maxy)
                                        {
                                            _loc_8.maxy = _loc_15.maxy;
                                        }
                                        else
                                        {
                                            _loc_8.maxy = _loc_16.maxy;
                                        }
                                        _loc_12 = _loc_10.height;
                                        _loc_17 = _loc_11.height;
                                        _loc_7.height = 1 + (_loc_12 > _loc_17 ? (_loc_12) : (_loc_17));
                                        _loc_7 = _loc_7.parent;
                                    }
                                }
                                else
                                {
                                    _loc_3.root = _loc_6;
                                    _loc_6.parent = null;
                                    _loc_7 = _loc_4;
                                    _loc_7.height = -1;
                                    _loc_8 = _loc_7.aabb;
                                    if (_loc_8.outer != null)
                                    {
                                        _loc_8.outer.zpp_inner = null;
                                        _loc_8.outer = null;
                                    }
                                    _loc_9 = null;
                                    _loc_8.wrap_max = _loc_9;
                                    _loc_8.wrap_min = _loc_9;
                                    _loc_8._invalidate = null;
                                    _loc_8._validate = null;
                                    _loc_8.next = ZPP_AABB.zpp_pool;
                                    ZPP_AABB.zpp_pool = _loc_8;
                                    _loc_10 = null;
                                    _loc_7.parent = _loc_10;
                                    _loc_10 = _loc_10;
                                    _loc_7.child2 = _loc_10;
                                    _loc_7.child1 = _loc_10;
                                    _loc_7.next = null;
                                    _loc_7.snext = null;
                                    _loc_7.mnext = null;
                                    _loc_7.next = ZPP_AABBNode.zpp_pool;
                                    ZPP_AABBNode.zpp_pool = _loc_7;
                                }
                            }
                        }
                        else
                        {
                            _loc_1.first_sync = false;
                        }
                        _loc_8 = _loc_1.aabb;
                        if (!space.continuous)
                        {
                            if (_loc_2.zip_aabb)
                            {
                                if (_loc_2.body != null)
                                {
                                    _loc_2.zip_aabb = false;
                                    if (_loc_2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                    {
                                        _loc_19 = _loc_2.circle;
                                        if (_loc_19.zip_worldCOM)
                                        {
                                            if (_loc_19.body != null)
                                            {
                                                _loc_19.zip_worldCOM = false;
                                                if (_loc_19.zip_localCOM)
                                                {
                                                    _loc_19.zip_localCOM = false;
                                                    if (_loc_19.type == ZPP_Flags.id_ShapeType_POLYGON)
                                                    {
                                                        _loc_20 = _loc_19.polygon;
                                                        if (_loc_20.lverts.next == null)
                                                        {
                                                            throw "Error: An empty polygon has no meaningful localCOM";
                                                        }
                                                        if (_loc_20.lverts.next.next == null)
                                                        {
                                                            _loc_20.localCOMx = _loc_20.lverts.next.x;
                                                            _loc_20.localCOMy = _loc_20.lverts.next.y;
                                                        }
                                                        else if (_loc_20.lverts.next.next.next == null)
                                                        {
                                                            _loc_20.localCOMx = _loc_20.lverts.next.x;
                                                            _loc_20.localCOMy = _loc_20.lverts.next.y;
                                                            _loc_21 = 1;
                                                            _loc_20.localCOMx = _loc_20.localCOMx + _loc_20.lverts.next.next.x * _loc_21;
                                                            _loc_20.localCOMy = _loc_20.localCOMy + _loc_20.lverts.next.next.y * _loc_21;
                                                            _loc_21 = 0.5;
                                                            _loc_20.localCOMx = _loc_20.localCOMx * _loc_21;
                                                            _loc_20.localCOMy = _loc_20.localCOMy * _loc_21;
                                                        }
                                                        else
                                                        {
                                                            _loc_20.localCOMx = 0;
                                                            _loc_20.localCOMy = 0;
                                                            _loc_21 = 0;
                                                            _loc_22 = _loc_20.lverts.next;
                                                            _loc_23 = _loc_22;
                                                            _loc_22 = _loc_22.next;
                                                            _loc_24 = _loc_22;
                                                            _loc_22 = _loc_22.next;
                                                            while (_loc_22 != null)
                                                            {
                                                                
                                                                _loc_25 = _loc_22;
                                                                _loc_21 = _loc_21 + _loc_24.x * (_loc_25.y - _loc_23.y);
                                                                _loc_26 = _loc_25.y * _loc_24.x - _loc_25.x * _loc_24.y;
                                                                _loc_20.localCOMx = _loc_20.localCOMx + (_loc_24.x + _loc_25.x) * _loc_26;
                                                                _loc_20.localCOMy = _loc_20.localCOMy + (_loc_24.y + _loc_25.y) * _loc_26;
                                                                _loc_23 = _loc_24;
                                                                _loc_24 = _loc_25;
                                                                _loc_22 = _loc_22.next;
                                                            }
                                                            _loc_22 = _loc_20.lverts.next;
                                                            _loc_25 = _loc_22;
                                                            _loc_21 = _loc_21 + _loc_24.x * (_loc_25.y - _loc_23.y);
                                                            _loc_26 = _loc_25.y * _loc_24.x - _loc_25.x * _loc_24.y;
                                                            _loc_20.localCOMx = _loc_20.localCOMx + (_loc_24.x + _loc_25.x) * _loc_26;
                                                            _loc_20.localCOMy = _loc_20.localCOMy + (_loc_24.y + _loc_25.y) * _loc_26;
                                                            _loc_23 = _loc_24;
                                                            _loc_24 = _loc_25;
                                                            _loc_22 = _loc_22.next;
                                                            _loc_27 = _loc_22;
                                                            _loc_21 = _loc_21 + _loc_24.x * (_loc_27.y - _loc_23.y);
                                                            _loc_26 = _loc_27.y * _loc_24.x - _loc_27.x * _loc_24.y;
                                                            _loc_20.localCOMx = _loc_20.localCOMx + (_loc_24.x + _loc_27.x) * _loc_26;
                                                            _loc_20.localCOMy = _loc_20.localCOMy + (_loc_24.y + _loc_27.y) * _loc_26;
                                                            _loc_21 = 1 / (3 * _loc_21);
                                                            _loc_26 = _loc_21;
                                                            _loc_20.localCOMx = _loc_20.localCOMx * _loc_26;
                                                            _loc_20.localCOMy = _loc_20.localCOMy * _loc_26;
                                                        }
                                                    }
                                                    if (_loc_19.wrap_localCOM != null)
                                                    {
                                                        _loc_19.wrap_localCOM.zpp_inner.x = _loc_19.localCOMx;
                                                        _loc_19.wrap_localCOM.zpp_inner.y = _loc_19.localCOMy;
                                                    }
                                                }
                                                _loc_28 = _loc_19.body;
                                                if (_loc_28.zip_axis)
                                                {
                                                    _loc_28.zip_axis = false;
                                                    _loc_28.axisx = Math.sin(_loc_28.rot);
                                                    _loc_28.axisy = Math.cos(_loc_28.rot);
                                                }
                                                _loc_19.worldCOMx = _loc_19.body.posx + (_loc_19.body.axisy * _loc_19.localCOMx - _loc_19.body.axisx * _loc_19.localCOMy);
                                                _loc_19.worldCOMy = _loc_19.body.posy + (_loc_19.localCOMx * _loc_19.body.axisx + _loc_19.localCOMy * _loc_19.body.axisy);
                                            }
                                        }
                                        _loc_21 = _loc_19.radius;
                                        _loc_26 = _loc_19.radius;
                                        _loc_19.aabb.minx = _loc_19.worldCOMx - _loc_21;
                                        _loc_19.aabb.miny = _loc_19.worldCOMy - _loc_26;
                                        _loc_19.aabb.maxx = _loc_19.worldCOMx + _loc_21;
                                        _loc_19.aabb.maxy = _loc_19.worldCOMy + _loc_26;
                                    }
                                    else
                                    {
                                        _loc_20 = _loc_2.polygon;
                                        if (_loc_20.zip_gverts)
                                        {
                                            if (_loc_20.body != null)
                                            {
                                                _loc_20.zip_gverts = false;
                                                _loc_20.validate_lverts();
                                                _loc_28 = _loc_20.body;
                                                if (_loc_28.zip_axis)
                                                {
                                                    _loc_28.zip_axis = false;
                                                    _loc_28.axisx = Math.sin(_loc_28.rot);
                                                    _loc_28.axisy = Math.cos(_loc_28.rot);
                                                }
                                                _loc_22 = _loc_20.lverts.next;
                                                _loc_23 = _loc_20.gverts.next;
                                                while (_loc_23 != null)
                                                {
                                                    
                                                    _loc_24 = _loc_23;
                                                    _loc_25 = _loc_22;
                                                    _loc_22 = _loc_22.next;
                                                    _loc_24.x = _loc_20.body.posx + (_loc_20.body.axisy * _loc_25.x - _loc_20.body.axisx * _loc_25.y);
                                                    _loc_24.y = _loc_20.body.posy + (_loc_25.x * _loc_20.body.axisx + _loc_25.y * _loc_20.body.axisy);
                                                    _loc_23 = _loc_23.next;
                                                }
                                            }
                                        }
                                        if (_loc_20.lverts.next == null)
                                        {
                                            throw "Error: An empty polygon has no meaningful bounds";
                                        }
                                        _loc_22 = _loc_20.gverts.next;
                                        _loc_20.aabb.minx = _loc_22.x;
                                        _loc_20.aabb.miny = _loc_22.y;
                                        _loc_20.aabb.maxx = _loc_22.x;
                                        _loc_20.aabb.maxy = _loc_22.y;
                                        _loc_23 = _loc_20.gverts.next.next;
                                        while (_loc_23 != null)
                                        {
                                            
                                            _loc_24 = _loc_23;
                                            if (_loc_24.x < _loc_20.aabb.minx)
                                            {
                                                _loc_20.aabb.minx = _loc_24.x;
                                            }
                                            if (_loc_24.x > _loc_20.aabb.maxx)
                                            {
                                                _loc_20.aabb.maxx = _loc_24.x;
                                            }
                                            if (_loc_24.y < _loc_20.aabb.miny)
                                            {
                                                _loc_20.aabb.miny = _loc_24.y;
                                            }
                                            if (_loc_24.y > _loc_20.aabb.maxy)
                                            {
                                                _loc_20.aabb.maxy = _loc_24.y;
                                            }
                                            _loc_23 = _loc_23.next;
                                        }
                                    }
                                }
                            }
                        }
                        _loc_15 = _loc_2.aabb;
                        _loc_8.minx = _loc_15.minx - 3;
                        _loc_8.miny = _loc_15.miny - 3;
                        _loc_8.maxx = _loc_15.maxx + 3;
                        _loc_8.maxy = _loc_15.maxy + 3;
                        if (_loc_2.body.type == ZPP_Flags.id_BodyType_STATIC ? (_loc_29 = false, _loc_1.dyn = _loc_29, _loc_29) : (_loc_29 = !_loc_2.body.component.sleeping, _loc_1.dyn = _loc_29, _loc_29))
                        {
                            _loc_3 = dtree;
                        }
                        else
                        {
                            _loc_3 = stree;
                        }
                        if (_loc_3.root == null)
                        {
                            _loc_3.root = _loc_1;
                            _loc_3.root.parent = null;
                        }
                        else
                        {
                            _loc_15 = _loc_1.aabb;
                            _loc_4 = _loc_3.root;
                            while (_loc_4.child1 != null)
                            {
                                
                                _loc_5 = _loc_4.child1;
                                _loc_6 = _loc_4.child2;
                                _loc_16 = _loc_4.aabb;
                                _loc_21 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                _loc_16 = ZPP_AABBTree.tmpaabb;
                                _loc_30 = _loc_4.aabb;
                                if (_loc_30.minx < _loc_15.minx)
                                {
                                    _loc_16.minx = _loc_30.minx;
                                }
                                else
                                {
                                    _loc_16.minx = _loc_15.minx;
                                }
                                if (_loc_30.miny < _loc_15.miny)
                                {
                                    _loc_16.miny = _loc_30.miny;
                                }
                                else
                                {
                                    _loc_16.miny = _loc_15.miny;
                                }
                                if (_loc_30.maxx > _loc_15.maxx)
                                {
                                    _loc_16.maxx = _loc_30.maxx;
                                }
                                else
                                {
                                    _loc_16.maxx = _loc_15.maxx;
                                }
                                if (_loc_30.maxy > _loc_15.maxy)
                                {
                                    _loc_16.maxy = _loc_30.maxy;
                                }
                                else
                                {
                                    _loc_16.maxy = _loc_15.maxy;
                                }
                                _loc_16 = ZPP_AABBTree.tmpaabb;
                                _loc_26 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                _loc_31 = 2 * _loc_26;
                                _loc_32 = 2 * (_loc_26 - _loc_21);
                                _loc_16 = ZPP_AABBTree.tmpaabb;
                                _loc_30 = _loc_5.aabb;
                                if (_loc_15.minx < _loc_30.minx)
                                {
                                    _loc_16.minx = _loc_15.minx;
                                }
                                else
                                {
                                    _loc_16.minx = _loc_30.minx;
                                }
                                if (_loc_15.miny < _loc_30.miny)
                                {
                                    _loc_16.miny = _loc_15.miny;
                                }
                                else
                                {
                                    _loc_16.miny = _loc_30.miny;
                                }
                                if (_loc_15.maxx > _loc_30.maxx)
                                {
                                    _loc_16.maxx = _loc_15.maxx;
                                }
                                else
                                {
                                    _loc_16.maxx = _loc_30.maxx;
                                }
                                if (_loc_15.maxy > _loc_30.maxy)
                                {
                                    _loc_16.maxy = _loc_15.maxy;
                                }
                                else
                                {
                                    _loc_16.maxy = _loc_30.maxy;
                                }
                                if (_loc_5.child1 == null)
                                {
                                    _loc_16 = ZPP_AABBTree.tmpaabb;
                                    _loc_33 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2 + _loc_32;
                                }
                                else
                                {
                                    _loc_16 = _loc_5.aabb;
                                    _loc_34 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                    _loc_16 = ZPP_AABBTree.tmpaabb;
                                    _loc_35 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                    _loc_33 = _loc_35 - _loc_34 + _loc_32;
                                }
                                _loc_16 = ZPP_AABBTree.tmpaabb;
                                _loc_30 = _loc_6.aabb;
                                if (_loc_15.minx < _loc_30.minx)
                                {
                                    _loc_16.minx = _loc_15.minx;
                                }
                                else
                                {
                                    _loc_16.minx = _loc_30.minx;
                                }
                                if (_loc_15.miny < _loc_30.miny)
                                {
                                    _loc_16.miny = _loc_15.miny;
                                }
                                else
                                {
                                    _loc_16.miny = _loc_30.miny;
                                }
                                if (_loc_15.maxx > _loc_30.maxx)
                                {
                                    _loc_16.maxx = _loc_15.maxx;
                                }
                                else
                                {
                                    _loc_16.maxx = _loc_30.maxx;
                                }
                                if (_loc_15.maxy > _loc_30.maxy)
                                {
                                    _loc_16.maxy = _loc_15.maxy;
                                }
                                else
                                {
                                    _loc_16.maxy = _loc_30.maxy;
                                }
                                if (_loc_6.child1 == null)
                                {
                                    _loc_16 = ZPP_AABBTree.tmpaabb;
                                    _loc_34 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2 + _loc_32;
                                }
                                else
                                {
                                    _loc_16 = _loc_6.aabb;
                                    _loc_35 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                    _loc_16 = ZPP_AABBTree.tmpaabb;
                                    _loc_36 = (_loc_16.maxx - _loc_16.minx + (_loc_16.maxy - _loc_16.miny)) * 2;
                                    _loc_34 = _loc_36 - _loc_35 + _loc_32;
                                }
                                if (_loc_31 < _loc_33)
                                {
                                }
                                if (_loc_31 < _loc_34)
                                {
                                    break;
                                    continue;
                                }
                                if (_loc_33 < _loc_34)
                                {
                                    _loc_4 = _loc_5;
                                    continue;
                                }
                                _loc_4 = _loc_6;
                            }
                            _loc_5 = _loc_4;
                            _loc_6 = _loc_5.parent;
                            if (ZPP_AABBNode.zpp_pool == null)
                            {
                                _loc_7 = new ZPP_AABBNode();
                            }
                            else
                            {
                                _loc_7 = ZPP_AABBNode.zpp_pool;
                                ZPP_AABBNode.zpp_pool = _loc_7.next;
                                _loc_7.next = null;
                            }
                            if (ZPP_AABB.zpp_pool == null)
                            {
                                _loc_7.aabb = new ZPP_AABB();
                            }
                            else
                            {
                                _loc_7.aabb = ZPP_AABB.zpp_pool;
                                ZPP_AABB.zpp_pool = _loc_7.aabb.next;
                                _loc_7.aabb.next = null;
                            }
                            _loc_7.moved = false;
                            _loc_7.synced = false;
                            _loc_7.first_sync = false;
                            _loc_7.parent = _loc_6;
                            _loc_16 = _loc_7.aabb;
                            _loc_30 = _loc_5.aabb;
                            if (_loc_15.minx < _loc_30.minx)
                            {
                                _loc_16.minx = _loc_15.minx;
                            }
                            else
                            {
                                _loc_16.minx = _loc_30.minx;
                            }
                            if (_loc_15.miny < _loc_30.miny)
                            {
                                _loc_16.miny = _loc_15.miny;
                            }
                            else
                            {
                                _loc_16.miny = _loc_30.miny;
                            }
                            if (_loc_15.maxx > _loc_30.maxx)
                            {
                                _loc_16.maxx = _loc_15.maxx;
                            }
                            else
                            {
                                _loc_16.maxx = _loc_30.maxx;
                            }
                            if (_loc_15.maxy > _loc_30.maxy)
                            {
                                _loc_16.maxy = _loc_15.maxy;
                            }
                            else
                            {
                                _loc_16.maxy = _loc_30.maxy;
                            }
                            _loc_7.height = _loc_5.height + 1;
                            if (_loc_6 != null)
                            {
                                if (_loc_6.child1 == _loc_5)
                                {
                                    _loc_6.child1 = _loc_7;
                                }
                                else
                                {
                                    _loc_6.child2 = _loc_7;
                                }
                                _loc_7.child1 = _loc_5;
                                _loc_7.child2 = _loc_1;
                                _loc_5.parent = _loc_7;
                                _loc_1.parent = _loc_7;
                            }
                            else
                            {
                                _loc_7.child1 = _loc_5;
                                _loc_7.child2 = _loc_1;
                                _loc_5.parent = _loc_7;
                                _loc_1.parent = _loc_7;
                                _loc_3.root = _loc_7;
                            }
                            _loc_4 = _loc_1.parent;
                            while (_loc_4 != null)
                            {
                                
                                if (_loc_4.child1 != null)
                                {
                                }
                                if (_loc_4.height < 2)
                                {
                                    _loc_4 = _loc_4;
                                }
                                else
                                {
                                    _loc_10 = _loc_4.child1;
                                    _loc_11 = _loc_4.child2;
                                    _loc_12 = _loc_11.height - _loc_10.height;
                                    if (_loc_12 > 1)
                                    {
                                        _loc_13 = _loc_11.child1;
                                        _loc_14 = _loc_11.child2;
                                        _loc_11.child1 = _loc_4;
                                        _loc_11.parent = _loc_4.parent;
                                        _loc_4.parent = _loc_11;
                                        if (_loc_11.parent != null)
                                        {
                                            if (_loc_11.parent.child1 == _loc_4)
                                            {
                                                _loc_11.parent.child1 = _loc_11;
                                            }
                                            else
                                            {
                                                _loc_11.parent.child2 = _loc_11;
                                            }
                                        }
                                        else
                                        {
                                            _loc_3.root = _loc_11;
                                        }
                                        if (_loc_13.height > _loc_14.height)
                                        {
                                            _loc_11.child2 = _loc_13;
                                            _loc_4.child2 = _loc_14;
                                            _loc_14.parent = _loc_4;
                                            _loc_16 = _loc_4.aabb;
                                            _loc_30 = _loc_10.aabb;
                                            _loc_37 = _loc_14.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_16 = _loc_11.aabb;
                                            _loc_30 = _loc_4.aabb;
                                            _loc_37 = _loc_13.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_17 = _loc_10.height;
                                            _loc_18 = _loc_14.height;
                                            _loc_4.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                            _loc_17 = _loc_4.height;
                                            _loc_18 = _loc_13.height;
                                            _loc_11.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                        }
                                        else
                                        {
                                            _loc_11.child2 = _loc_14;
                                            _loc_4.child2 = _loc_13;
                                            _loc_13.parent = _loc_4;
                                            _loc_16 = _loc_4.aabb;
                                            _loc_30 = _loc_10.aabb;
                                            _loc_37 = _loc_13.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_16 = _loc_11.aabb;
                                            _loc_30 = _loc_4.aabb;
                                            _loc_37 = _loc_14.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_17 = _loc_10.height;
                                            _loc_18 = _loc_13.height;
                                            _loc_4.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                            _loc_17 = _loc_4.height;
                                            _loc_18 = _loc_14.height;
                                            _loc_11.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                        }
                                        _loc_4 = _loc_11;
                                    }
                                    else if (_loc_12 < -1)
                                    {
                                        _loc_13 = _loc_10.child1;
                                        _loc_14 = _loc_10.child2;
                                        _loc_10.child1 = _loc_4;
                                        _loc_10.parent = _loc_4.parent;
                                        _loc_4.parent = _loc_10;
                                        if (_loc_10.parent != null)
                                        {
                                            if (_loc_10.parent.child1 == _loc_4)
                                            {
                                                _loc_10.parent.child1 = _loc_10;
                                            }
                                            else
                                            {
                                                _loc_10.parent.child2 = _loc_10;
                                            }
                                        }
                                        else
                                        {
                                            _loc_3.root = _loc_10;
                                        }
                                        if (_loc_13.height > _loc_14.height)
                                        {
                                            _loc_10.child2 = _loc_13;
                                            _loc_4.child1 = _loc_14;
                                            _loc_14.parent = _loc_4;
                                            _loc_16 = _loc_4.aabb;
                                            _loc_30 = _loc_11.aabb;
                                            _loc_37 = _loc_14.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_16 = _loc_10.aabb;
                                            _loc_30 = _loc_4.aabb;
                                            _loc_37 = _loc_13.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_17 = _loc_11.height;
                                            _loc_18 = _loc_14.height;
                                            _loc_4.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                            _loc_17 = _loc_4.height;
                                            _loc_18 = _loc_13.height;
                                            _loc_10.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                        }
                                        else
                                        {
                                            _loc_10.child2 = _loc_14;
                                            _loc_4.child1 = _loc_13;
                                            _loc_13.parent = _loc_4;
                                            _loc_16 = _loc_4.aabb;
                                            _loc_30 = _loc_11.aabb;
                                            _loc_37 = _loc_13.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_16 = _loc_10.aabb;
                                            _loc_30 = _loc_4.aabb;
                                            _loc_37 = _loc_14.aabb;
                                            if (_loc_30.minx < _loc_37.minx)
                                            {
                                                _loc_16.minx = _loc_30.minx;
                                            }
                                            else
                                            {
                                                _loc_16.minx = _loc_37.minx;
                                            }
                                            if (_loc_30.miny < _loc_37.miny)
                                            {
                                                _loc_16.miny = _loc_30.miny;
                                            }
                                            else
                                            {
                                                _loc_16.miny = _loc_37.miny;
                                            }
                                            if (_loc_30.maxx > _loc_37.maxx)
                                            {
                                                _loc_16.maxx = _loc_30.maxx;
                                            }
                                            else
                                            {
                                                _loc_16.maxx = _loc_37.maxx;
                                            }
                                            if (_loc_30.maxy > _loc_37.maxy)
                                            {
                                                _loc_16.maxy = _loc_30.maxy;
                                            }
                                            else
                                            {
                                                _loc_16.maxy = _loc_37.maxy;
                                            }
                                            _loc_17 = _loc_11.height;
                                            _loc_18 = _loc_13.height;
                                            _loc_4.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                            _loc_17 = _loc_4.height;
                                            _loc_18 = _loc_14.height;
                                            _loc_10.height = 1 + (_loc_17 > _loc_18 ? (_loc_17) : (_loc_18));
                                        }
                                        _loc_4 = _loc_10;
                                    }
                                    else
                                    {
                                        _loc_4 = _loc_4;
                                    }
                                }
                                _loc_10 = _loc_4.child1;
                                _loc_11 = _loc_4.child2;
                                _loc_12 = _loc_10.height;
                                _loc_17 = _loc_11.height;
                                _loc_4.height = 1 + (_loc_12 > _loc_17 ? (_loc_12) : (_loc_17));
                                _loc_16 = _loc_4.aabb;
                                _loc_30 = _loc_10.aabb;
                                _loc_37 = _loc_11.aabb;
                                if (_loc_30.minx < _loc_37.minx)
                                {
                                    _loc_16.minx = _loc_30.minx;
                                }
                                else
                                {
                                    _loc_16.minx = _loc_37.minx;
                                }
                                if (_loc_30.miny < _loc_37.miny)
                                {
                                    _loc_16.miny = _loc_30.miny;
                                }
                                else
                                {
                                    _loc_16.miny = _loc_37.miny;
                                }
                                if (_loc_30.maxx > _loc_37.maxx)
                                {
                                    _loc_16.maxx = _loc_30.maxx;
                                }
                                else
                                {
                                    _loc_16.maxx = _loc_37.maxx;
                                }
                                if (_loc_30.maxy > _loc_37.maxy)
                                {
                                    _loc_16.maxy = _loc_30.maxy;
                                }
                                else
                                {
                                    _loc_16.maxy = _loc_37.maxy;
                                }
                                _loc_4 = _loc_4.parent;
                            }
                        }
                        _loc_1.synced = false;
                        if (!_loc_1.moved)
                        {
                            _loc_1.moved = true;
                            _loc_1.mnext = moves;
                            moves = _loc_1;
                        }
                    }
                }
            }
            return;
        }// end function

        override public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
        {
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ShapeList;
            var _loc_9:* = null as ZPP_AABBNode;
            var _loc_10:* = null as ZPP_AABB;
            var _loc_11:* = null as ZPP_InteractionFilter;
            sync_broadphase();
            var _loc_6:* = false;
            if (ZPP_Vec2.zpp_pool == null)
            {
                _loc_7 = new ZPP_Vec2();
            }
            else
            {
                _loc_7 = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7.next;
                _loc_7.next = null;
            }
            _loc_7.weak = false;
            _loc_7._immutable = _loc_6;
            _loc_7.x = param1;
            _loc_7.y = param2;
            var _loc_5:* = _loc_7;
            if (param4 == null)
            {
                _loc_8 = new ShapeList();
            }
            else
            {
                _loc_8 = param4;
            }
            if (stree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(stree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_9 = treeStack.pop_unsafe();
                    _loc_10 = _loc_9.aabb;
                    if (_loc_5.x >= _loc_10.minx)
                    {
                    }
                    if (_loc_5.x <= _loc_10.maxx)
                    {
                    }
                    if (_loc_5.y >= _loc_10.miny)
                    {
                    }
                    if (_loc_5.y <= _loc_10.maxy)
                    {
                        if (_loc_9.child1 == null)
                        {
                            if (param3 != null)
                            {
                                _loc_11 = _loc_9.shape.filter;
                                if ((_loc_11.collisionMask & param3.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param3.collisionMask & _loc_11.collisionGroup) != 0)
                            {
                                if (_loc_9.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                {
                                    if (ZPP_Collide.circleContains(_loc_9.shape.circle, _loc_5))
                                    {
                                        _loc_8.push(_loc_9.shape.outer);
                                    }
                                }
                                else if (ZPP_Collide.polyContains(_loc_9.shape.polygon, _loc_5))
                                {
                                    _loc_8.push(_loc_9.shape.outer);
                                }
                            }
                            continue;
                        }
                        if (_loc_9.child1 != null)
                        {
                            treeStack.add(_loc_9.child1);
                        }
                        if (_loc_9.child2 != null)
                        {
                            treeStack.add(_loc_9.child2);
                        }
                    }
                }
            }
            if (dtree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(dtree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_9 = treeStack.pop_unsafe();
                    _loc_10 = _loc_9.aabb;
                    if (_loc_5.x >= _loc_10.minx)
                    {
                    }
                    if (_loc_5.x <= _loc_10.maxx)
                    {
                    }
                    if (_loc_5.y >= _loc_10.miny)
                    {
                    }
                    if (_loc_5.y <= _loc_10.maxy)
                    {
                        if (_loc_9.child1 == null)
                        {
                            if (param3 != null)
                            {
                                _loc_11 = _loc_9.shape.filter;
                                if ((_loc_11.collisionMask & param3.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param3.collisionMask & _loc_11.collisionGroup) != 0)
                            {
                                if (_loc_9.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                {
                                    if (ZPP_Collide.circleContains(_loc_9.shape.circle, _loc_5))
                                    {
                                        _loc_8.push(_loc_9.shape.outer);
                                    }
                                }
                                else if (ZPP_Collide.polyContains(_loc_9.shape.polygon, _loc_5))
                                {
                                    _loc_8.push(_loc_9.shape.outer);
                                }
                            }
                            continue;
                        }
                        if (_loc_9.child1 != null)
                        {
                            treeStack.add(_loc_9.child1);
                        }
                        if (_loc_9.child2 != null)
                        {
                            treeStack.add(_loc_9.child2);
                        }
                    }
                }
            }
            _loc_7 = _loc_5;
            if (_loc_7.outer != null)
            {
                _loc_7.outer.zpp_inner = null;
                _loc_7.outer = null;
            }
            _loc_7._isimmutable = null;
            _loc_7._validate = null;
            _loc_7._invalidate = null;
            _loc_7.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_7;
            return _loc_8;
        }// end function

        override public function shapesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
        {
            var _loc_6:* = null as ShapeList;
            var _loc_7:* = null as ZPP_AABBNode;
            var _loc_8:* = null as ZPP_AABB;
            var _loc_9:* = null as ZPP_InteractionFilter;
            sync_broadphase();
            validateShape(param1);
            var _loc_5:* = param1.aabb;
            if (param4 == null)
            {
                _loc_6 = new ShapeList();
            }
            else
            {
                _loc_6 = param4;
            }
            if (stree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(stree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_7 = treeStack.pop_unsafe();
                    _loc_8 = _loc_7.aabb;
                    if (_loc_5.miny <= _loc_8.maxy)
                    {
                    }
                    if (_loc_8.miny <= _loc_5.maxy)
                    {
                    }
                    if (_loc_5.minx <= _loc_8.maxx)
                    {
                    }
                    if (_loc_8.minx <= _loc_5.maxx)
                    {
                        if (_loc_7.child1 == null)
                        {
                            if (param3 != null)
                            {
                                _loc_9 = _loc_7.shape.filter;
                                if ((_loc_9.collisionMask & param3.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param3.collisionMask & _loc_9.collisionGroup) != 0)
                            {
                                if (param2)
                                {
                                    if (ZPP_Collide.containTest(param1, _loc_7.shape))
                                    {
                                        _loc_6.push(_loc_7.shape.outer);
                                    }
                                }
                                else if (ZPP_Collide.testCollide_safe(_loc_7.shape, param1))
                                {
                                    _loc_6.push(_loc_7.shape.outer);
                                }
                            }
                            continue;
                        }
                        if (_loc_7.child1 != null)
                        {
                            treeStack.add(_loc_7.child1);
                        }
                        if (_loc_7.child2 != null)
                        {
                            treeStack.add(_loc_7.child2);
                        }
                    }
                }
            }
            if (dtree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(dtree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_7 = treeStack.pop_unsafe();
                    _loc_8 = _loc_7.aabb;
                    if (_loc_5.miny <= _loc_8.maxy)
                    {
                    }
                    if (_loc_8.miny <= _loc_5.maxy)
                    {
                    }
                    if (_loc_5.minx <= _loc_8.maxx)
                    {
                    }
                    if (_loc_8.minx <= _loc_5.maxx)
                    {
                        if (_loc_7.child1 == null)
                        {
                            if (param3 != null)
                            {
                                _loc_9 = _loc_7.shape.filter;
                                if ((_loc_9.collisionMask & param3.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param3.collisionMask & _loc_9.collisionGroup) != 0)
                            {
                                if (param2)
                                {
                                    if (ZPP_Collide.containTest(param1, _loc_7.shape))
                                    {
                                        _loc_6.push(_loc_7.shape.outer);
                                    }
                                }
                                else if (ZPP_Collide.testCollide_safe(_loc_7.shape, param1))
                                {
                                    _loc_6.push(_loc_7.shape.outer);
                                }
                            }
                            continue;
                        }
                        if (_loc_7.child1 != null)
                        {
                            treeStack.add(_loc_7.child1);
                        }
                        if (_loc_7.child2 != null)
                        {
                            treeStack.add(_loc_7.child2);
                        }
                    }
                }
            }
            return _loc_6;
        }// end function

        override public function shapesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:ShapeList) : ShapeList
        {
            var _loc_8:* = null as ShapeList;
            var _loc_9:* = null as ZPP_AABBNode;
            var _loc_10:* = null as ZPP_AABB;
            var _loc_11:* = null as ZPP_InteractionFilter;
            sync_broadphase();
            updateCircShape(param1, param2, param3);
            var _loc_7:* = circShape.zpp_inner.aabb;
            if (param6 == null)
            {
                _loc_8 = new ShapeList();
            }
            else
            {
                _loc_8 = param6;
            }
            if (stree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(stree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_9 = treeStack.pop_unsafe();
                    _loc_10 = _loc_9.aabb;
                    if (_loc_7.miny <= _loc_10.maxy)
                    {
                    }
                    if (_loc_10.miny <= _loc_7.maxy)
                    {
                    }
                    if (_loc_7.minx <= _loc_10.maxx)
                    {
                    }
                    if (_loc_10.minx <= _loc_7.maxx)
                    {
                        if (_loc_9.child1 == null)
                        {
                            if (param5 != null)
                            {
                                _loc_11 = _loc_9.shape.filter;
                                if ((_loc_11.collisionMask & param5.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param5.collisionMask & _loc_11.collisionGroup) != 0)
                            {
                                if (param4)
                                {
                                    if (ZPP_Collide.containTest(circShape.zpp_inner, _loc_9.shape))
                                    {
                                        _loc_8.push(_loc_9.shape.outer);
                                    }
                                }
                                else if (ZPP_Collide.testCollide_safe(_loc_9.shape, circShape.zpp_inner))
                                {
                                    _loc_8.push(_loc_9.shape.outer);
                                }
                            }
                            continue;
                        }
                        if (_loc_9.child1 != null)
                        {
                            treeStack.add(_loc_9.child1);
                        }
                        if (_loc_9.child2 != null)
                        {
                            treeStack.add(_loc_9.child2);
                        }
                    }
                }
            }
            if (dtree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(dtree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_9 = treeStack.pop_unsafe();
                    _loc_10 = _loc_9.aabb;
                    if (_loc_7.miny <= _loc_10.maxy)
                    {
                    }
                    if (_loc_10.miny <= _loc_7.maxy)
                    {
                    }
                    if (_loc_7.minx <= _loc_10.maxx)
                    {
                    }
                    if (_loc_10.minx <= _loc_7.maxx)
                    {
                        if (_loc_9.child1 == null)
                        {
                            if (param5 != null)
                            {
                                _loc_11 = _loc_9.shape.filter;
                                if ((_loc_11.collisionMask & param5.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param5.collisionMask & _loc_11.collisionGroup) != 0)
                            {
                                if (param4)
                                {
                                    if (ZPP_Collide.containTest(circShape.zpp_inner, _loc_9.shape))
                                    {
                                        _loc_8.push(_loc_9.shape.outer);
                                    }
                                }
                                else if (ZPP_Collide.testCollide_safe(_loc_9.shape, circShape.zpp_inner))
                                {
                                    _loc_8.push(_loc_9.shape.outer);
                                }
                            }
                            continue;
                        }
                        if (_loc_9.child1 != null)
                        {
                            treeStack.add(_loc_9.child1);
                        }
                        if (_loc_9.child2 != null)
                        {
                            treeStack.add(_loc_9.child2);
                        }
                    }
                }
            }
            return _loc_8;
        }// end function

        override public function shapesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:ShapeList) : ShapeList
        {
            var _loc_7:* = null as ShapeList;
            var _loc_8:* = null as ZPP_AABBNode;
            var _loc_9:* = null as ZPP_AABB;
            var _loc_10:* = null as ZPP_InteractionFilter;
            var _loc_11:* = null as ZPP_AABBNode;
            sync_broadphase();
            updateAABBShape(param1);
            var _loc_6:* = aabbShape.zpp_inner.aabb;
            if (param5 == null)
            {
                _loc_7 = new ShapeList();
            }
            else
            {
                _loc_7 = param5;
            }
            if (stree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(stree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_8 = treeStack.pop_unsafe();
                    _loc_9 = _loc_8.aabb;
                    if (_loc_9.minx >= _loc_6.minx)
                    {
                    }
                    if (_loc_9.miny >= _loc_6.miny)
                    {
                    }
                    if (_loc_9.maxx <= _loc_6.maxx)
                    {
                    }
                    if (_loc_9.maxy <= _loc_6.maxy)
                    {
                        if (_loc_8.child1 == null)
                        {
                            if (param4 != null)
                            {
                                _loc_10 = _loc_8.shape.filter;
                                if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                            {
                                _loc_7.push(_loc_8.shape.outer);
                            }
                        }
                        else
                        {
                            if (treeStack2 == null)
                            {
                                treeStack2 = new ZNPList_ZPP_AABBNode();
                            }
                            treeStack2.add(_loc_8);
                            while (treeStack2.head != null)
                            {
                                
                                _loc_11 = treeStack2.pop_unsafe();
                                if (_loc_11.child1 == null)
                                {
                                    if (param4 != null)
                                    {
                                        _loc_10 = _loc_11.shape.filter;
                                        if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                        {
                                        }
                                    }
                                    if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                                    {
                                        _loc_7.push(_loc_11.shape.outer);
                                    }
                                    continue;
                                }
                                if (_loc_11.child1 != null)
                                {
                                    treeStack2.add(_loc_11.child1);
                                }
                                if (_loc_11.child2 != null)
                                {
                                    treeStack2.add(_loc_11.child2);
                                }
                            }
                        }
                        continue;
                    }
                    _loc_9 = _loc_8.aabb;
                    if (_loc_6.miny <= _loc_9.maxy)
                    {
                    }
                    if (_loc_9.miny <= _loc_6.maxy)
                    {
                    }
                    if (_loc_6.minx <= _loc_9.maxx)
                    {
                    }
                    if (_loc_9.minx <= _loc_6.maxx)
                    {
                        if (_loc_8.child1 == null)
                        {
                            if (param4 != null)
                            {
                                _loc_10 = _loc_8.shape.filter;
                                if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                            {
                                if (param2)
                                {
                                    if (param3)
                                    {
                                        if (ZPP_Collide.containTest(aabbShape.zpp_inner, _loc_8.shape))
                                        {
                                            _loc_7.push(_loc_8.shape.outer);
                                        }
                                    }
                                    else
                                    {
                                        _loc_9 = _loc_8.shape.aabb;
                                        if (_loc_9.minx >= _loc_6.minx)
                                        {
                                        }
                                        if (_loc_9.miny >= _loc_6.miny)
                                        {
                                        }
                                        if (_loc_9.maxx <= _loc_6.maxx)
                                        {
                                        }
                                        if (_loc_9.maxy <= _loc_6.maxy)
                                        {
                                            _loc_7.push(_loc_8.shape.outer);
                                        }
                                        else if (ZPP_Collide.testCollide_safe(_loc_8.shape, aabbShape.zpp_inner))
                                        {
                                            _loc_7.push(_loc_8.shape.outer);
                                        }
                                    }
                                }
                                else
                                {
                                    if (param3)
                                    {
                                        _loc_9 = _loc_8.shape.aabb;
                                        if (_loc_9.minx >= _loc_6.minx)
                                        {
                                        }
                                        if (_loc_9.miny >= _loc_6.miny)
                                        {
                                        }
                                        if (_loc_9.maxx <= _loc_6.maxx)
                                        {
                                        }
                                    }
                                    if (_loc_9.maxy <= _loc_6.maxy)
                                    {
                                        _loc_7.push(_loc_8.shape.outer);
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_8.child1 != null)
                        {
                            treeStack.add(_loc_8.child1);
                        }
                        if (_loc_8.child2 != null)
                        {
                            treeStack.add(_loc_8.child2);
                        }
                    }
                }
            }
            if (dtree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(dtree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_8 = treeStack.pop_unsafe();
                    _loc_9 = _loc_8.aabb;
                    if (_loc_9.minx >= _loc_6.minx)
                    {
                    }
                    if (_loc_9.miny >= _loc_6.miny)
                    {
                    }
                    if (_loc_9.maxx <= _loc_6.maxx)
                    {
                    }
                    if (_loc_9.maxy <= _loc_6.maxy)
                    {
                        if (_loc_8.child1 == null)
                        {
                            if (param4 != null)
                            {
                                _loc_10 = _loc_8.shape.filter;
                                if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                            {
                                _loc_7.push(_loc_8.shape.outer);
                            }
                        }
                        else
                        {
                            if (treeStack2 == null)
                            {
                                treeStack2 = new ZNPList_ZPP_AABBNode();
                            }
                            treeStack2.add(_loc_8);
                            while (treeStack2.head != null)
                            {
                                
                                _loc_11 = treeStack2.pop_unsafe();
                                if (_loc_11.child1 == null)
                                {
                                    if (param4 != null)
                                    {
                                        _loc_10 = _loc_11.shape.filter;
                                        if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                        {
                                        }
                                    }
                                    if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                                    {
                                        _loc_7.push(_loc_11.shape.outer);
                                    }
                                    continue;
                                }
                                if (_loc_11.child1 != null)
                                {
                                    treeStack2.add(_loc_11.child1);
                                }
                                if (_loc_11.child2 != null)
                                {
                                    treeStack2.add(_loc_11.child2);
                                }
                            }
                        }
                        continue;
                    }
                    _loc_9 = _loc_8.aabb;
                    if (_loc_6.miny <= _loc_9.maxy)
                    {
                    }
                    if (_loc_9.miny <= _loc_6.maxy)
                    {
                    }
                    if (_loc_6.minx <= _loc_9.maxx)
                    {
                    }
                    if (_loc_9.minx <= _loc_6.maxx)
                    {
                        if (_loc_8.child1 == null)
                        {
                            if (param4 != null)
                            {
                                _loc_10 = _loc_8.shape.filter;
                                if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                            {
                                if (param2)
                                {
                                    if (param3)
                                    {
                                        if (ZPP_Collide.containTest(aabbShape.zpp_inner, _loc_8.shape))
                                        {
                                            _loc_7.push(_loc_8.shape.outer);
                                        }
                                    }
                                    else
                                    {
                                        _loc_9 = _loc_8.shape.aabb;
                                        if (_loc_9.minx >= _loc_6.minx)
                                        {
                                        }
                                        if (_loc_9.miny >= _loc_6.miny)
                                        {
                                        }
                                        if (_loc_9.maxx <= _loc_6.maxx)
                                        {
                                        }
                                        if (_loc_9.maxy <= _loc_6.maxy)
                                        {
                                            _loc_7.push(_loc_8.shape.outer);
                                        }
                                        else if (ZPP_Collide.testCollide_safe(_loc_8.shape, aabbShape.zpp_inner))
                                        {
                                            _loc_7.push(_loc_8.shape.outer);
                                        }
                                    }
                                }
                                else
                                {
                                    if (param3)
                                    {
                                        _loc_9 = _loc_8.shape.aabb;
                                        if (_loc_9.minx >= _loc_6.minx)
                                        {
                                        }
                                        if (_loc_9.miny >= _loc_6.miny)
                                        {
                                        }
                                        if (_loc_9.maxx <= _loc_6.maxx)
                                        {
                                        }
                                    }
                                    if (_loc_9.maxy <= _loc_6.maxy)
                                    {
                                        _loc_7.push(_loc_8.shape.outer);
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_8.child1 != null)
                        {
                            treeStack.add(_loc_8.child1);
                        }
                        if (_loc_8.child2 != null)
                        {
                            treeStack.add(_loc_8.child2);
                        }
                    }
                }
            }
            return _loc_7;
        }// end function

        override public function rayMultiCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter, param4:RayResultList) : RayResultList
        {
            var _loc_6:* = null as RayResultList;
            var _loc_7:* = NaN;
            var _loc_8:* = null as ZPP_AABBNode;
            var _loc_9:* = null as ZPP_Shape;
            var _loc_10:* = null as ZPP_InteractionFilter;
            if (openlist == null)
            {
                openlist = new ZNPList_ZPP_AABBNode();
            }
            sync_broadphase();
            param1.validate_dir();
            var _loc_5:* = param1.maxdist >= 17899999999999994000000000000;
            if (param4 == null)
            {
                _loc_6 = new RayResultList();
            }
            else
            {
                _loc_6 = param4;
            }
            if (dtree.root != null)
            {
                if (param1.aabbtest(dtree.root.aabb))
                {
                    if (_loc_5)
                    {
                        openlist.add(dtree.root);
                    }
                    else
                    {
                        _loc_7 = param1.aabbsect(dtree.root.aabb);
                        if (_loc_7 >= 0)
                        {
                        }
                        if (_loc_7 < param1.maxdist)
                        {
                            openlist.add(dtree.root);
                        }
                    }
                }
            }
            if (stree.root != null)
            {
                if (param1.aabbtest(stree.root.aabb))
                {
                    if (_loc_5)
                    {
                        openlist.add(stree.root);
                    }
                    else
                    {
                        _loc_7 = param1.aabbsect(stree.root.aabb);
                        if (_loc_7 >= 0)
                        {
                        }
                        if (_loc_7 < param1.maxdist)
                        {
                            openlist.add(stree.root);
                        }
                    }
                }
            }
            while (openlist.head != null)
            {
                
                _loc_8 = openlist.pop_unsafe();
                if (_loc_8.child1 == null)
                {
                    _loc_9 = _loc_8.shape;
                    if (param3 != null)
                    {
                        _loc_10 = _loc_9.filter;
                        if ((_loc_10.collisionMask & param3.collisionGroup) != 0)
                        {
                        }
                    }
                    if ((param3.collisionMask & _loc_10.collisionGroup) != 0)
                    {
                        if (_loc_9.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            param1.circlesect2(_loc_9.circle, param2, _loc_6);
                        }
                        else if (param1.aabbtest(_loc_9.aabb))
                        {
                            param1.polysect2(_loc_9.polygon, param2, _loc_6);
                        }
                    }
                    continue;
                }
                if (_loc_8.child1 != null)
                {
                    if (param1.aabbtest(_loc_8.child1.aabb))
                    {
                        if (_loc_5)
                        {
                            openlist.add(_loc_8.child1);
                        }
                        else
                        {
                            _loc_7 = param1.aabbsect(_loc_8.child1.aabb);
                            if (_loc_7 >= 0)
                            {
                            }
                            if (_loc_7 < param1.maxdist)
                            {
                                openlist.add(_loc_8.child1);
                            }
                        }
                    }
                }
                if (_loc_8.child2 != null)
                {
                    if (param1.aabbtest(_loc_8.child2.aabb))
                    {
                        if (_loc_5)
                        {
                            openlist.add(_loc_8.child2);
                            continue;
                        }
                        _loc_7 = param1.aabbsect(_loc_8.child2.aabb);
                        if (_loc_7 >= 0)
                        {
                        }
                        if (_loc_7 < param1.maxdist)
                        {
                            openlist.add(_loc_8.child2);
                        }
                    }
                }
            }
            openlist.clear();
            return _loc_6;
        }// end function

        override public function rayCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter) : RayResult
        {
            var _loc_5:* = NaN;
            var _loc_6:* = null as ZNPNode_ZPP_AABBNode;
            var _loc_7:* = null as ZNPNode_ZPP_AABBNode;
            var _loc_8:* = null as ZPP_AABBNode;
            var _loc_9:* = null as ZNPList_ZPP_AABBNode;
            var _loc_10:* = null as ZNPNode_ZPP_AABBNode;
            var _loc_11:* = false;
            var _loc_13:* = null as ZPP_Shape;
            var _loc_14:* = null as ZPP_InteractionFilter;
            var _loc_15:* = null as RayResult;
            var _loc_16:* = null as ZPP_AABBNode;
            if (openlist == null)
            {
                openlist = new ZNPList_ZPP_AABBNode();
            }
            sync_broadphase();
            param1.validate_dir();
            var _loc_4:* = param1.maxdist;
            if (dtree.root != null)
            {
                if (param1.aabbtest(dtree.root.aabb))
                {
                    _loc_5 = param1.aabbsect(dtree.root.aabb);
                    if (_loc_5 >= 0)
                    {
                    }
                    if (_loc_5 < _loc_4)
                    {
                        dtree.root.rayt = _loc_5;
                        _loc_6 = null;
                        _loc_7 = openlist.head;
                        while (_loc_7 != null)
                        {
                            
                            _loc_8 = _loc_7.elt;
                            if (dtree.root.rayt < _loc_8.rayt)
                            {
                                break;
                            }
                            _loc_6 = _loc_7;
                            _loc_7 = _loc_7.next;
                        }
                        _loc_9 = openlist;
                        if (ZNPNode_ZPP_AABBNode.zpp_pool == null)
                        {
                            _loc_10 = new ZNPNode_ZPP_AABBNode();
                        }
                        else
                        {
                            _loc_10 = ZNPNode_ZPP_AABBNode.zpp_pool;
                            ZNPNode_ZPP_AABBNode.zpp_pool = _loc_10.next;
                            _loc_10.next = null;
                        }
                        _loc_10.elt = dtree.root;
                        _loc_7 = _loc_10;
                        if (_loc_6 == null)
                        {
                            _loc_7.next = _loc_9.head;
                            _loc_9.head = _loc_7;
                        }
                        else
                        {
                            _loc_7.next = _loc_6.next;
                            _loc_6.next = _loc_7;
                        }
                        _loc_11 = true;
                        _loc_9.modified = _loc_11;
                        _loc_9.pushmod = _loc_11;
                        (_loc_9.length + 1);
                    }
                }
            }
            if (stree.root != null)
            {
                if (param1.aabbtest(stree.root.aabb))
                {
                    _loc_5 = param1.aabbsect(stree.root.aabb);
                    if (_loc_5 >= 0)
                    {
                    }
                    if (_loc_5 < _loc_4)
                    {
                        stree.root.rayt = _loc_5;
                        _loc_6 = null;
                        _loc_7 = openlist.head;
                        while (_loc_7 != null)
                        {
                            
                            _loc_8 = _loc_7.elt;
                            if (stree.root.rayt < _loc_8.rayt)
                            {
                                break;
                            }
                            _loc_6 = _loc_7;
                            _loc_7 = _loc_7.next;
                        }
                        _loc_9 = openlist;
                        if (ZNPNode_ZPP_AABBNode.zpp_pool == null)
                        {
                            _loc_10 = new ZNPNode_ZPP_AABBNode();
                        }
                        else
                        {
                            _loc_10 = ZNPNode_ZPP_AABBNode.zpp_pool;
                            ZNPNode_ZPP_AABBNode.zpp_pool = _loc_10.next;
                            _loc_10.next = null;
                        }
                        _loc_10.elt = stree.root;
                        _loc_7 = _loc_10;
                        if (_loc_6 == null)
                        {
                            _loc_7.next = _loc_9.head;
                            _loc_9.head = _loc_7;
                        }
                        else
                        {
                            _loc_7.next = _loc_6.next;
                            _loc_6.next = _loc_7;
                        }
                        _loc_11 = true;
                        _loc_9.modified = _loc_11;
                        _loc_9.pushmod = _loc_11;
                        (_loc_9.length + 1);
                    }
                }
            }
            var _loc_12:* = null;
            while (openlist.head != null)
            {
                
                _loc_8 = openlist.pop_unsafe();
                if (_loc_8.rayt >= _loc_4)
                {
                    break;
                }
                if (_loc_8.child1 == null)
                {
                    _loc_13 = _loc_8.shape;
                    if (param3 != null)
                    {
                        _loc_14 = _loc_13.filter;
                        if ((_loc_14.collisionMask & param3.collisionGroup) != 0)
                        {
                        }
                    }
                    if ((param3.collisionMask & _loc_14.collisionGroup) != 0)
                    {
                        if (_loc_13.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_15 = param1.circlesect(_loc_13.circle, param2, _loc_4);
                        }
                        else if (param1.aabbtest(_loc_13.aabb))
                        {
                            _loc_15 = param1.polysect(_loc_13.polygon, param2, _loc_4);
                        }
                        else
                        {
                            _loc_15 = null;
                        }
                        if (_loc_15 != null)
                        {
                            if (_loc_15.zpp_inner.next != null)
                            {
                                throw "Error: This object has been disposed of and cannot be used";
                            }
                            _loc_4 = _loc_15.zpp_inner.toiDistance;
                            if (_loc_12 != null)
                            {
                                if (_loc_12.zpp_inner.next != null)
                                {
                                    throw "Error: This object has been disposed of and cannot be used";
                                }
                                _loc_12.zpp_inner.free();
                            }
                            _loc_12 = _loc_15;
                        }
                    }
                    continue;
                }
                if (_loc_8.child1 != null)
                {
                    if (param1.aabbtest(_loc_8.child1.aabb))
                    {
                        _loc_5 = param1.aabbsect(_loc_8.child1.aabb);
                        if (_loc_5 >= 0)
                        {
                        }
                        if (_loc_5 < _loc_4)
                        {
                            _loc_8.child1.rayt = _loc_5;
                            _loc_6 = null;
                            _loc_7 = openlist.head;
                            while (_loc_7 != null)
                            {
                                
                                _loc_16 = _loc_7.elt;
                                if (_loc_8.child1.rayt < _loc_16.rayt)
                                {
                                    break;
                                }
                                _loc_6 = _loc_7;
                                _loc_7 = _loc_7.next;
                            }
                            _loc_9 = openlist;
                            if (ZNPNode_ZPP_AABBNode.zpp_pool == null)
                            {
                                _loc_10 = new ZNPNode_ZPP_AABBNode();
                            }
                            else
                            {
                                _loc_10 = ZNPNode_ZPP_AABBNode.zpp_pool;
                                ZNPNode_ZPP_AABBNode.zpp_pool = _loc_10.next;
                                _loc_10.next = null;
                            }
                            _loc_10.elt = _loc_8.child1;
                            _loc_7 = _loc_10;
                            if (_loc_6 == null)
                            {
                                _loc_7.next = _loc_9.head;
                                _loc_9.head = _loc_7;
                            }
                            else
                            {
                                _loc_7.next = _loc_6.next;
                                _loc_6.next = _loc_7;
                            }
                            _loc_11 = true;
                            _loc_9.modified = _loc_11;
                            _loc_9.pushmod = _loc_11;
                            (_loc_9.length + 1);
                        }
                    }
                }
                if (_loc_8.child2 != null)
                {
                    if (param1.aabbtest(_loc_8.child2.aabb))
                    {
                        _loc_5 = param1.aabbsect(_loc_8.child2.aabb);
                        if (_loc_5 >= 0)
                        {
                        }
                        if (_loc_5 < _loc_4)
                        {
                            _loc_8.child2.rayt = _loc_5;
                            _loc_6 = null;
                            _loc_7 = openlist.head;
                            while (_loc_7 != null)
                            {
                                
                                _loc_16 = _loc_7.elt;
                                if (_loc_8.child2.rayt < _loc_16.rayt)
                                {
                                    break;
                                }
                                _loc_6 = _loc_7;
                                _loc_7 = _loc_7.next;
                            }
                            _loc_9 = openlist;
                            if (ZNPNode_ZPP_AABBNode.zpp_pool == null)
                            {
                                _loc_10 = new ZNPNode_ZPP_AABBNode();
                            }
                            else
                            {
                                _loc_10 = ZNPNode_ZPP_AABBNode.zpp_pool;
                                ZNPNode_ZPP_AABBNode.zpp_pool = _loc_10.next;
                                _loc_10.next = null;
                            }
                            _loc_10.elt = _loc_8.child2;
                            _loc_7 = _loc_10;
                            if (_loc_6 == null)
                            {
                                _loc_7.next = _loc_9.head;
                                _loc_9.head = _loc_7;
                            }
                            else
                            {
                                _loc_7.next = _loc_6.next;
                                _loc_6.next = _loc_7;
                            }
                            _loc_11 = true;
                            _loc_9.modified = _loc_11;
                            _loc_9.pushmod = _loc_11;
                            (_loc_9.length + 1);
                        }
                    }
                }
            }
            openlist.clear();
            return _loc_12;
        }// end function

        public function dyn(param1:ZPP_Shape) : Boolean
        {
            if (param1.body.type == ZPP_Flags.id_BodyType_STATIC)
            {
                return false;
            }
            else
            {
                return !param1.body.component.sleeping;
            }
        }// end function

        override public function clear() : void
        {
            var _loc_1:* = null as ZPP_AABBNode;
            var _loc_2:* = null as ZPP_AABBPair;
            var _loc_3:* = null as ZNPList_ZPP_AABBPair;
            var _loc_4:* = null as ZPP_AABBPair;
            var _loc_5:* = null as ZNPNode_ZPP_AABBPair;
            var _loc_6:* = null as ZNPNode_ZPP_AABBPair;
            var _loc_7:* = false;
            var _loc_8:* = null as ZNPNode_ZPP_AABBPair;
            var _loc_9:* = null as ZNPNode_ZPP_AABBPair;
            var _loc_10:* = null as ZNPNode_ZPP_AABBPair;
            while (syncs != null)
            {
                
                _loc_1 = syncs.snext;
                syncs.snext = null;
                if (syncs.first_sync)
                {
                    syncs.shape.node = null;
                    syncs.shape.removedFromSpace();
                    syncs.shape = null;
                }
                syncs = _loc_1;
            }
            while (moves != null)
            {
                
                _loc_1 = moves.mnext;
                moves.mnext = null;
                if (moves.first_sync)
                {
                    moves.shape.node = null;
                    moves.shape.removedFromSpace();
                    moves.shape = null;
                }
                moves = _loc_1;
            }
            while (pairs != null)
            {
                
                _loc_2 = pairs.next;
                if (pairs.arb != null)
                {
                    pairs.arb.pair = null;
                }
                pairs.arb = null;
                _loc_3 = pairs.n1.shape.pairs;
                _loc_4 = pairs;
                _loc_5 = null;
                _loc_6 = _loc_3.head;
                _loc_7 = false;
                while (_loc_6 != null)
                {
                    
                    if (_loc_6.elt == _loc_4)
                    {
                        if (_loc_5 == null)
                        {
                            _loc_8 = _loc_3.head;
                            _loc_9 = _loc_8.next;
                            _loc_3.head = _loc_9;
                            if (_loc_3.head == null)
                            {
                                _loc_3.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_8 = _loc_5.next;
                            _loc_9 = _loc_8.next;
                            _loc_5.next = _loc_9;
                            if (_loc_9 == null)
                            {
                                _loc_3.pushmod = true;
                            }
                        }
                        _loc_10 = _loc_8;
                        _loc_10.elt = null;
                        _loc_10.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                        ZNPNode_ZPP_AABBPair.zpp_pool = _loc_10;
                        _loc_3.modified = true;
                        (_loc_3.length - 1);
                        _loc_3.pushmod = true;
                        _loc_7 = true;
                        break;
                    }
                    _loc_5 = _loc_6;
                    _loc_6 = _loc_6.next;
                }
                _loc_3 = pairs.n2.shape.pairs;
                _loc_4 = pairs;
                _loc_5 = null;
                _loc_6 = _loc_3.head;
                _loc_7 = false;
                while (_loc_6 != null)
                {
                    
                    if (_loc_6.elt == _loc_4)
                    {
                        if (_loc_5 == null)
                        {
                            _loc_8 = _loc_3.head;
                            _loc_9 = _loc_8.next;
                            _loc_3.head = _loc_9;
                            if (_loc_3.head == null)
                            {
                                _loc_3.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_8 = _loc_5.next;
                            _loc_9 = _loc_8.next;
                            _loc_5.next = _loc_9;
                            if (_loc_9 == null)
                            {
                                _loc_3.pushmod = true;
                            }
                        }
                        _loc_10 = _loc_8;
                        _loc_10.elt = null;
                        _loc_10.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                        ZNPNode_ZPP_AABBPair.zpp_pool = _loc_10;
                        _loc_3.modified = true;
                        (_loc_3.length - 1);
                        _loc_3.pushmod = true;
                        _loc_7 = true;
                        break;
                    }
                    _loc_5 = _loc_6;
                    _loc_6 = _loc_6.next;
                }
                _loc_4 = pairs;
                _loc_1 = null;
                _loc_4.n2 = _loc_1;
                _loc_4.n1 = _loc_1;
                _loc_4.sleeping = false;
                _loc_4.next = ZPP_AABBPair.zpp_pool;
                ZPP_AABBPair.zpp_pool = _loc_4;
                pairs = _loc_2;
            }
            dtree.clear();
            stree.clear();
            return;
        }// end function

        override public function broadphase(param1:ZPP_Space, param2:Boolean) : void
        {
            var _loc_4:* = null as ZPP_Shape;
            var _loc_5:* = null as ZPP_AABBTree;
            var _loc_6:* = null as ZPP_AABBNode;
            var _loc_7:* = null as ZPP_AABBNode;
            var _loc_8:* = null as ZPP_AABBNode;
            var _loc_9:* = null as ZPP_AABBNode;
            var _loc_10:* = null as ZPP_AABB;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = null as ZPP_AABBNode;
            var _loc_13:* = null as ZPP_AABBNode;
            var _loc_14:* = 0;
            var _loc_15:* = null as ZPP_AABBNode;
            var _loc_16:* = null as ZPP_AABBNode;
            var _loc_17:* = null as ZPP_AABB;
            var _loc_18:* = null as ZPP_AABB;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = null as ZPP_Circle;
            var _loc_22:* = null as ZPP_Polygon;
            var _loc_23:* = NaN;
            var _loc_24:* = null as ZPP_Vec2;
            var _loc_25:* = null as ZPP_Vec2;
            var _loc_26:* = null as ZPP_Vec2;
            var _loc_27:* = null as ZPP_Vec2;
            var _loc_28:* = NaN;
            var _loc_29:* = null as ZPP_Vec2;
            var _loc_30:* = null as ZPP_Body;
            var _loc_31:* = false;
            var _loc_32:* = null as ZPP_AABB;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = null as ZPP_AABB;
            var _loc_40:* = null as ZPP_Shape;
            var _loc_41:* = null as ZPP_Shape;
            var _loc_42:* = null as ZPP_AABBPair;
            var _loc_43:* = null as ZNPNode_ZPP_AABBPair;
            var _loc_44:* = null as ZPP_AABBPair;
            var _loc_45:* = null as ZNPList_ZPP_AABBPair;
            var _loc_46:* = null as ZNPNode_ZPP_AABBPair;
            var _loc_47:* = null as ZNPNode_ZPP_AABBPair;
            var _loc_48:* = null as ZNPNode_ZPP_AABBPair;
            var _loc_49:* = null as ZNPNode_ZPP_AABBPair;
            var _loc_50:* = null as ZPP_AABBPair;
            var _loc_51:* = null as ZPP_AABBPair;
            var _loc_52:* = null as ZPP_Body;
            var _loc_53:* = null as ZPP_Arbiter;
            var _loc_3:* = syncs;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.shape;
                if (!_loc_3.first_sync)
                {
                    if (_loc_3.dyn)
                    {
                        _loc_5 = dtree;
                    }
                    else
                    {
                        _loc_5 = stree;
                    }
                    if (_loc_3 == _loc_5.root)
                    {
                        _loc_5.root = null;
                    }
                    else
                    {
                        _loc_6 = _loc_3.parent;
                        _loc_7 = _loc_6.parent;
                        if (_loc_6.child1 == _loc_3)
                        {
                            _loc_8 = _loc_6.child2;
                        }
                        else
                        {
                            _loc_8 = _loc_6.child1;
                        }
                        if (_loc_7 != null)
                        {
                            if (_loc_7.child1 == _loc_6)
                            {
                                _loc_7.child1 = _loc_8;
                            }
                            else
                            {
                                _loc_7.child2 = _loc_8;
                            }
                            _loc_8.parent = _loc_7;
                            _loc_9 = _loc_6;
                            _loc_9.height = -1;
                            _loc_10 = _loc_9.aabb;
                            if (_loc_10.outer != null)
                            {
                                _loc_10.outer.zpp_inner = null;
                                _loc_10.outer = null;
                            }
                            _loc_11 = null;
                            _loc_10.wrap_max = _loc_11;
                            _loc_10.wrap_min = _loc_11;
                            _loc_10._invalidate = null;
                            _loc_10._validate = null;
                            _loc_10.next = ZPP_AABB.zpp_pool;
                            ZPP_AABB.zpp_pool = _loc_10;
                            _loc_12 = null;
                            _loc_9.parent = _loc_12;
                            _loc_12 = _loc_12;
                            _loc_9.child2 = _loc_12;
                            _loc_9.child1 = _loc_12;
                            _loc_9.next = null;
                            _loc_9.snext = null;
                            _loc_9.mnext = null;
                            _loc_9.next = ZPP_AABBNode.zpp_pool;
                            ZPP_AABBNode.zpp_pool = _loc_9;
                            _loc_9 = _loc_7;
                            while (_loc_9 != null)
                            {
                                
                                if (_loc_9.child1 != null)
                                {
                                }
                                if (_loc_9.height < 2)
                                {
                                    _loc_9 = _loc_9;
                                }
                                else
                                {
                                    _loc_12 = _loc_9.child1;
                                    _loc_13 = _loc_9.child2;
                                    _loc_14 = _loc_13.height - _loc_12.height;
                                    if (_loc_14 > 1)
                                    {
                                        _loc_15 = _loc_13.child1;
                                        _loc_16 = _loc_13.child2;
                                        _loc_13.child1 = _loc_9;
                                        _loc_13.parent = _loc_9.parent;
                                        _loc_9.parent = _loc_13;
                                        if (_loc_13.parent != null)
                                        {
                                            if (_loc_13.parent.child1 == _loc_9)
                                            {
                                                _loc_13.parent.child1 = _loc_13;
                                            }
                                            else
                                            {
                                                _loc_13.parent.child2 = _loc_13;
                                            }
                                        }
                                        else
                                        {
                                            _loc_5.root = _loc_13;
                                        }
                                        if (_loc_15.height > _loc_16.height)
                                        {
                                            _loc_13.child2 = _loc_15;
                                            _loc_9.child2 = _loc_16;
                                            _loc_16.parent = _loc_9;
                                            _loc_10 = _loc_9.aabb;
                                            _loc_17 = _loc_12.aabb;
                                            _loc_18 = _loc_16.aabb;
                                            if (_loc_17.minx < _loc_18.minx)
                                            {
                                                _loc_10.minx = _loc_17.minx;
                                            }
                                            else
                                            {
                                                _loc_10.minx = _loc_18.minx;
                                            }
                                            if (_loc_17.miny < _loc_18.miny)
                                            {
                                                _loc_10.miny = _loc_17.miny;
                                            }
                                            else
                                            {
                                                _loc_10.miny = _loc_18.miny;
                                            }
                                            if (_loc_17.maxx > _loc_18.maxx)
                                            {
                                                _loc_10.maxx = _loc_17.maxx;
                                            }
                                            else
                                            {
                                                _loc_10.maxx = _loc_18.maxx;
                                            }
                                            if (_loc_17.maxy > _loc_18.maxy)
                                            {
                                                _loc_10.maxy = _loc_17.maxy;
                                            }
                                            else
                                            {
                                                _loc_10.maxy = _loc_18.maxy;
                                            }
                                            _loc_10 = _loc_13.aabb;
                                            _loc_17 = _loc_9.aabb;
                                            _loc_18 = _loc_15.aabb;
                                            if (_loc_17.minx < _loc_18.minx)
                                            {
                                                _loc_10.minx = _loc_17.minx;
                                            }
                                            else
                                            {
                                                _loc_10.minx = _loc_18.minx;
                                            }
                                            if (_loc_17.miny < _loc_18.miny)
                                            {
                                                _loc_10.miny = _loc_17.miny;
                                            }
                                            else
                                            {
                                                _loc_10.miny = _loc_18.miny;
                                            }
                                            if (_loc_17.maxx > _loc_18.maxx)
                                            {
                                                _loc_10.maxx = _loc_17.maxx;
                                            }
                                            else
                                            {
                                                _loc_10.maxx = _loc_18.maxx;
                                            }
                                            if (_loc_17.maxy > _loc_18.maxy)
                                            {
                                                _loc_10.maxy = _loc_17.maxy;
                                            }
                                            else
                                            {
                                                _loc_10.maxy = _loc_18.maxy;
                                            }
                                            _loc_19 = _loc_12.height;
                                            _loc_20 = _loc_16.height;
                                            _loc_9.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                            _loc_19 = _loc_9.height;
                                            _loc_20 = _loc_15.height;
                                            _loc_13.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                        }
                                        else
                                        {
                                            _loc_13.child2 = _loc_16;
                                            _loc_9.child2 = _loc_15;
                                            _loc_15.parent = _loc_9;
                                            _loc_10 = _loc_9.aabb;
                                            _loc_17 = _loc_12.aabb;
                                            _loc_18 = _loc_15.aabb;
                                            if (_loc_17.minx < _loc_18.minx)
                                            {
                                                _loc_10.minx = _loc_17.minx;
                                            }
                                            else
                                            {
                                                _loc_10.minx = _loc_18.minx;
                                            }
                                            if (_loc_17.miny < _loc_18.miny)
                                            {
                                                _loc_10.miny = _loc_17.miny;
                                            }
                                            else
                                            {
                                                _loc_10.miny = _loc_18.miny;
                                            }
                                            if (_loc_17.maxx > _loc_18.maxx)
                                            {
                                                _loc_10.maxx = _loc_17.maxx;
                                            }
                                            else
                                            {
                                                _loc_10.maxx = _loc_18.maxx;
                                            }
                                            if (_loc_17.maxy > _loc_18.maxy)
                                            {
                                                _loc_10.maxy = _loc_17.maxy;
                                            }
                                            else
                                            {
                                                _loc_10.maxy = _loc_18.maxy;
                                            }
                                            _loc_10 = _loc_13.aabb;
                                            _loc_17 = _loc_9.aabb;
                                            _loc_18 = _loc_16.aabb;
                                            if (_loc_17.minx < _loc_18.minx)
                                            {
                                                _loc_10.minx = _loc_17.minx;
                                            }
                                            else
                                            {
                                                _loc_10.minx = _loc_18.minx;
                                            }
                                            if (_loc_17.miny < _loc_18.miny)
                                            {
                                                _loc_10.miny = _loc_17.miny;
                                            }
                                            else
                                            {
                                                _loc_10.miny = _loc_18.miny;
                                            }
                                            if (_loc_17.maxx > _loc_18.maxx)
                                            {
                                                _loc_10.maxx = _loc_17.maxx;
                                            }
                                            else
                                            {
                                                _loc_10.maxx = _loc_18.maxx;
                                            }
                                            if (_loc_17.maxy > _loc_18.maxy)
                                            {
                                                _loc_10.maxy = _loc_17.maxy;
                                            }
                                            else
                                            {
                                                _loc_10.maxy = _loc_18.maxy;
                                            }
                                            _loc_19 = _loc_12.height;
                                            _loc_20 = _loc_15.height;
                                            _loc_9.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                            _loc_19 = _loc_9.height;
                                            _loc_20 = _loc_16.height;
                                            _loc_13.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                        }
                                        _loc_9 = _loc_13;
                                    }
                                    else if (_loc_14 < -1)
                                    {
                                        _loc_15 = _loc_12.child1;
                                        _loc_16 = _loc_12.child2;
                                        _loc_12.child1 = _loc_9;
                                        _loc_12.parent = _loc_9.parent;
                                        _loc_9.parent = _loc_12;
                                        if (_loc_12.parent != null)
                                        {
                                            if (_loc_12.parent.child1 == _loc_9)
                                            {
                                                _loc_12.parent.child1 = _loc_12;
                                            }
                                            else
                                            {
                                                _loc_12.parent.child2 = _loc_12;
                                            }
                                        }
                                        else
                                        {
                                            _loc_5.root = _loc_12;
                                        }
                                        if (_loc_15.height > _loc_16.height)
                                        {
                                            _loc_12.child2 = _loc_15;
                                            _loc_9.child1 = _loc_16;
                                            _loc_16.parent = _loc_9;
                                            _loc_10 = _loc_9.aabb;
                                            _loc_17 = _loc_13.aabb;
                                            _loc_18 = _loc_16.aabb;
                                            if (_loc_17.minx < _loc_18.minx)
                                            {
                                                _loc_10.minx = _loc_17.minx;
                                            }
                                            else
                                            {
                                                _loc_10.minx = _loc_18.minx;
                                            }
                                            if (_loc_17.miny < _loc_18.miny)
                                            {
                                                _loc_10.miny = _loc_17.miny;
                                            }
                                            else
                                            {
                                                _loc_10.miny = _loc_18.miny;
                                            }
                                            if (_loc_17.maxx > _loc_18.maxx)
                                            {
                                                _loc_10.maxx = _loc_17.maxx;
                                            }
                                            else
                                            {
                                                _loc_10.maxx = _loc_18.maxx;
                                            }
                                            if (_loc_17.maxy > _loc_18.maxy)
                                            {
                                                _loc_10.maxy = _loc_17.maxy;
                                            }
                                            else
                                            {
                                                _loc_10.maxy = _loc_18.maxy;
                                            }
                                            _loc_10 = _loc_12.aabb;
                                            _loc_17 = _loc_9.aabb;
                                            _loc_18 = _loc_15.aabb;
                                            if (_loc_17.minx < _loc_18.minx)
                                            {
                                                _loc_10.minx = _loc_17.minx;
                                            }
                                            else
                                            {
                                                _loc_10.minx = _loc_18.minx;
                                            }
                                            if (_loc_17.miny < _loc_18.miny)
                                            {
                                                _loc_10.miny = _loc_17.miny;
                                            }
                                            else
                                            {
                                                _loc_10.miny = _loc_18.miny;
                                            }
                                            if (_loc_17.maxx > _loc_18.maxx)
                                            {
                                                _loc_10.maxx = _loc_17.maxx;
                                            }
                                            else
                                            {
                                                _loc_10.maxx = _loc_18.maxx;
                                            }
                                            if (_loc_17.maxy > _loc_18.maxy)
                                            {
                                                _loc_10.maxy = _loc_17.maxy;
                                            }
                                            else
                                            {
                                                _loc_10.maxy = _loc_18.maxy;
                                            }
                                            _loc_19 = _loc_13.height;
                                            _loc_20 = _loc_16.height;
                                            _loc_9.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                            _loc_19 = _loc_9.height;
                                            _loc_20 = _loc_15.height;
                                            _loc_12.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                        }
                                        else
                                        {
                                            _loc_12.child2 = _loc_16;
                                            _loc_9.child1 = _loc_15;
                                            _loc_15.parent = _loc_9;
                                            _loc_10 = _loc_9.aabb;
                                            _loc_17 = _loc_13.aabb;
                                            _loc_18 = _loc_15.aabb;
                                            if (_loc_17.minx < _loc_18.minx)
                                            {
                                                _loc_10.minx = _loc_17.minx;
                                            }
                                            else
                                            {
                                                _loc_10.minx = _loc_18.minx;
                                            }
                                            if (_loc_17.miny < _loc_18.miny)
                                            {
                                                _loc_10.miny = _loc_17.miny;
                                            }
                                            else
                                            {
                                                _loc_10.miny = _loc_18.miny;
                                            }
                                            if (_loc_17.maxx > _loc_18.maxx)
                                            {
                                                _loc_10.maxx = _loc_17.maxx;
                                            }
                                            else
                                            {
                                                _loc_10.maxx = _loc_18.maxx;
                                            }
                                            if (_loc_17.maxy > _loc_18.maxy)
                                            {
                                                _loc_10.maxy = _loc_17.maxy;
                                            }
                                            else
                                            {
                                                _loc_10.maxy = _loc_18.maxy;
                                            }
                                            _loc_10 = _loc_12.aabb;
                                            _loc_17 = _loc_9.aabb;
                                            _loc_18 = _loc_16.aabb;
                                            if (_loc_17.minx < _loc_18.minx)
                                            {
                                                _loc_10.minx = _loc_17.minx;
                                            }
                                            else
                                            {
                                                _loc_10.minx = _loc_18.minx;
                                            }
                                            if (_loc_17.miny < _loc_18.miny)
                                            {
                                                _loc_10.miny = _loc_17.miny;
                                            }
                                            else
                                            {
                                                _loc_10.miny = _loc_18.miny;
                                            }
                                            if (_loc_17.maxx > _loc_18.maxx)
                                            {
                                                _loc_10.maxx = _loc_17.maxx;
                                            }
                                            else
                                            {
                                                _loc_10.maxx = _loc_18.maxx;
                                            }
                                            if (_loc_17.maxy > _loc_18.maxy)
                                            {
                                                _loc_10.maxy = _loc_17.maxy;
                                            }
                                            else
                                            {
                                                _loc_10.maxy = _loc_18.maxy;
                                            }
                                            _loc_19 = _loc_13.height;
                                            _loc_20 = _loc_15.height;
                                            _loc_9.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                            _loc_19 = _loc_9.height;
                                            _loc_20 = _loc_16.height;
                                            _loc_12.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                        }
                                        _loc_9 = _loc_12;
                                    }
                                    else
                                    {
                                        _loc_9 = _loc_9;
                                    }
                                }
                                _loc_12 = _loc_9.child1;
                                _loc_13 = _loc_9.child2;
                                _loc_10 = _loc_9.aabb;
                                _loc_17 = _loc_12.aabb;
                                _loc_18 = _loc_13.aabb;
                                if (_loc_17.minx < _loc_18.minx)
                                {
                                    _loc_10.minx = _loc_17.minx;
                                }
                                else
                                {
                                    _loc_10.minx = _loc_18.minx;
                                }
                                if (_loc_17.miny < _loc_18.miny)
                                {
                                    _loc_10.miny = _loc_17.miny;
                                }
                                else
                                {
                                    _loc_10.miny = _loc_18.miny;
                                }
                                if (_loc_17.maxx > _loc_18.maxx)
                                {
                                    _loc_10.maxx = _loc_17.maxx;
                                }
                                else
                                {
                                    _loc_10.maxx = _loc_18.maxx;
                                }
                                if (_loc_17.maxy > _loc_18.maxy)
                                {
                                    _loc_10.maxy = _loc_17.maxy;
                                }
                                else
                                {
                                    _loc_10.maxy = _loc_18.maxy;
                                }
                                _loc_14 = _loc_12.height;
                                _loc_19 = _loc_13.height;
                                _loc_9.height = 1 + (_loc_14 > _loc_19 ? (_loc_14) : (_loc_19));
                                _loc_9 = _loc_9.parent;
                            }
                        }
                        else
                        {
                            _loc_5.root = _loc_8;
                            _loc_8.parent = null;
                            _loc_9 = _loc_6;
                            _loc_9.height = -1;
                            _loc_10 = _loc_9.aabb;
                            if (_loc_10.outer != null)
                            {
                                _loc_10.outer.zpp_inner = null;
                                _loc_10.outer = null;
                            }
                            _loc_11 = null;
                            _loc_10.wrap_max = _loc_11;
                            _loc_10.wrap_min = _loc_11;
                            _loc_10._invalidate = null;
                            _loc_10._validate = null;
                            _loc_10.next = ZPP_AABB.zpp_pool;
                            ZPP_AABB.zpp_pool = _loc_10;
                            _loc_12 = null;
                            _loc_9.parent = _loc_12;
                            _loc_12 = _loc_12;
                            _loc_9.child2 = _loc_12;
                            _loc_9.child1 = _loc_12;
                            _loc_9.next = null;
                            _loc_9.snext = null;
                            _loc_9.mnext = null;
                            _loc_9.next = ZPP_AABBNode.zpp_pool;
                            ZPP_AABBNode.zpp_pool = _loc_9;
                        }
                    }
                }
                else
                {
                    _loc_3.first_sync = false;
                }
                _loc_10 = _loc_3.aabb;
                if (!param1.continuous)
                {
                    if (_loc_4.zip_aabb)
                    {
                        if (_loc_4.body != null)
                        {
                            _loc_4.zip_aabb = false;
                            if (_loc_4.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_21 = _loc_4.circle;
                                if (_loc_21.zip_worldCOM)
                                {
                                    if (_loc_21.body != null)
                                    {
                                        _loc_21.zip_worldCOM = false;
                                        if (_loc_21.zip_localCOM)
                                        {
                                            _loc_21.zip_localCOM = false;
                                            if (_loc_21.type == ZPP_Flags.id_ShapeType_POLYGON)
                                            {
                                                _loc_22 = _loc_21.polygon;
                                                if (_loc_22.lverts.next == null)
                                                {
                                                    throw "Error: An empty polygon has no meaningful localCOM";
                                                }
                                                if (_loc_22.lverts.next.next == null)
                                                {
                                                    _loc_22.localCOMx = _loc_22.lverts.next.x;
                                                    _loc_22.localCOMy = _loc_22.lverts.next.y;
                                                }
                                                else if (_loc_22.lverts.next.next.next == null)
                                                {
                                                    _loc_22.localCOMx = _loc_22.lverts.next.x;
                                                    _loc_22.localCOMy = _loc_22.lverts.next.y;
                                                    _loc_23 = 1;
                                                    _loc_22.localCOMx = _loc_22.localCOMx + _loc_22.lverts.next.next.x * _loc_23;
                                                    _loc_22.localCOMy = _loc_22.localCOMy + _loc_22.lverts.next.next.y * _loc_23;
                                                    _loc_23 = 0.5;
                                                    _loc_22.localCOMx = _loc_22.localCOMx * _loc_23;
                                                    _loc_22.localCOMy = _loc_22.localCOMy * _loc_23;
                                                }
                                                else
                                                {
                                                    _loc_22.localCOMx = 0;
                                                    _loc_22.localCOMy = 0;
                                                    _loc_23 = 0;
                                                    _loc_24 = _loc_22.lverts.next;
                                                    _loc_25 = _loc_24;
                                                    _loc_24 = _loc_24.next;
                                                    _loc_26 = _loc_24;
                                                    _loc_24 = _loc_24.next;
                                                    while (_loc_24 != null)
                                                    {
                                                        
                                                        _loc_27 = _loc_24;
                                                        _loc_23 = _loc_23 + _loc_26.x * (_loc_27.y - _loc_25.y);
                                                        _loc_28 = _loc_27.y * _loc_26.x - _loc_27.x * _loc_26.y;
                                                        _loc_22.localCOMx = _loc_22.localCOMx + (_loc_26.x + _loc_27.x) * _loc_28;
                                                        _loc_22.localCOMy = _loc_22.localCOMy + (_loc_26.y + _loc_27.y) * _loc_28;
                                                        _loc_25 = _loc_26;
                                                        _loc_26 = _loc_27;
                                                        _loc_24 = _loc_24.next;
                                                    }
                                                    _loc_24 = _loc_22.lverts.next;
                                                    _loc_27 = _loc_24;
                                                    _loc_23 = _loc_23 + _loc_26.x * (_loc_27.y - _loc_25.y);
                                                    _loc_28 = _loc_27.y * _loc_26.x - _loc_27.x * _loc_26.y;
                                                    _loc_22.localCOMx = _loc_22.localCOMx + (_loc_26.x + _loc_27.x) * _loc_28;
                                                    _loc_22.localCOMy = _loc_22.localCOMy + (_loc_26.y + _loc_27.y) * _loc_28;
                                                    _loc_25 = _loc_26;
                                                    _loc_26 = _loc_27;
                                                    _loc_24 = _loc_24.next;
                                                    _loc_29 = _loc_24;
                                                    _loc_23 = _loc_23 + _loc_26.x * (_loc_29.y - _loc_25.y);
                                                    _loc_28 = _loc_29.y * _loc_26.x - _loc_29.x * _loc_26.y;
                                                    _loc_22.localCOMx = _loc_22.localCOMx + (_loc_26.x + _loc_29.x) * _loc_28;
                                                    _loc_22.localCOMy = _loc_22.localCOMy + (_loc_26.y + _loc_29.y) * _loc_28;
                                                    _loc_23 = 1 / (3 * _loc_23);
                                                    _loc_28 = _loc_23;
                                                    _loc_22.localCOMx = _loc_22.localCOMx * _loc_28;
                                                    _loc_22.localCOMy = _loc_22.localCOMy * _loc_28;
                                                }
                                            }
                                            if (_loc_21.wrap_localCOM != null)
                                            {
                                                _loc_21.wrap_localCOM.zpp_inner.x = _loc_21.localCOMx;
                                                _loc_21.wrap_localCOM.zpp_inner.y = _loc_21.localCOMy;
                                            }
                                        }
                                        _loc_30 = _loc_21.body;
                                        if (_loc_30.zip_axis)
                                        {
                                            _loc_30.zip_axis = false;
                                            _loc_30.axisx = Math.sin(_loc_30.rot);
                                            _loc_30.axisy = Math.cos(_loc_30.rot);
                                        }
                                        _loc_21.worldCOMx = _loc_21.body.posx + (_loc_21.body.axisy * _loc_21.localCOMx - _loc_21.body.axisx * _loc_21.localCOMy);
                                        _loc_21.worldCOMy = _loc_21.body.posy + (_loc_21.localCOMx * _loc_21.body.axisx + _loc_21.localCOMy * _loc_21.body.axisy);
                                    }
                                }
                                _loc_23 = _loc_21.radius;
                                _loc_28 = _loc_21.radius;
                                _loc_21.aabb.minx = _loc_21.worldCOMx - _loc_23;
                                _loc_21.aabb.miny = _loc_21.worldCOMy - _loc_28;
                                _loc_21.aabb.maxx = _loc_21.worldCOMx + _loc_23;
                                _loc_21.aabb.maxy = _loc_21.worldCOMy + _loc_28;
                            }
                            else
                            {
                                _loc_22 = _loc_4.polygon;
                                if (_loc_22.zip_gverts)
                                {
                                    if (_loc_22.body != null)
                                    {
                                        _loc_22.zip_gverts = false;
                                        _loc_22.validate_lverts();
                                        _loc_30 = _loc_22.body;
                                        if (_loc_30.zip_axis)
                                        {
                                            _loc_30.zip_axis = false;
                                            _loc_30.axisx = Math.sin(_loc_30.rot);
                                            _loc_30.axisy = Math.cos(_loc_30.rot);
                                        }
                                        _loc_24 = _loc_22.lverts.next;
                                        _loc_25 = _loc_22.gverts.next;
                                        while (_loc_25 != null)
                                        {
                                            
                                            _loc_26 = _loc_25;
                                            _loc_27 = _loc_24;
                                            _loc_24 = _loc_24.next;
                                            _loc_26.x = _loc_22.body.posx + (_loc_22.body.axisy * _loc_27.x - _loc_22.body.axisx * _loc_27.y);
                                            _loc_26.y = _loc_22.body.posy + (_loc_27.x * _loc_22.body.axisx + _loc_27.y * _loc_22.body.axisy);
                                            _loc_25 = _loc_25.next;
                                        }
                                    }
                                }
                                if (_loc_22.lverts.next == null)
                                {
                                    throw "Error: An empty polygon has no meaningful bounds";
                                }
                                _loc_24 = _loc_22.gverts.next;
                                _loc_22.aabb.minx = _loc_24.x;
                                _loc_22.aabb.miny = _loc_24.y;
                                _loc_22.aabb.maxx = _loc_24.x;
                                _loc_22.aabb.maxy = _loc_24.y;
                                _loc_25 = _loc_22.gverts.next.next;
                                while (_loc_25 != null)
                                {
                                    
                                    _loc_26 = _loc_25;
                                    if (_loc_26.x < _loc_22.aabb.minx)
                                    {
                                        _loc_22.aabb.minx = _loc_26.x;
                                    }
                                    if (_loc_26.x > _loc_22.aabb.maxx)
                                    {
                                        _loc_22.aabb.maxx = _loc_26.x;
                                    }
                                    if (_loc_26.y < _loc_22.aabb.miny)
                                    {
                                        _loc_22.aabb.miny = _loc_26.y;
                                    }
                                    if (_loc_26.y > _loc_22.aabb.maxy)
                                    {
                                        _loc_22.aabb.maxy = _loc_26.y;
                                    }
                                    _loc_25 = _loc_25.next;
                                }
                            }
                        }
                    }
                }
                _loc_17 = _loc_4.aabb;
                _loc_10.minx = _loc_17.minx - 3;
                _loc_10.miny = _loc_17.miny - 3;
                _loc_10.maxx = _loc_17.maxx + 3;
                _loc_10.maxy = _loc_17.maxy + 3;
                if (_loc_4.body.type == ZPP_Flags.id_BodyType_STATIC ? (_loc_31 = false, _loc_3.dyn = _loc_31, _loc_31) : (_loc_31 = !_loc_4.body.component.sleeping, _loc_3.dyn = _loc_31, _loc_31))
                {
                    _loc_5 = dtree;
                }
                else
                {
                    _loc_5 = stree;
                }
                if (_loc_5.root == null)
                {
                    _loc_5.root = _loc_3;
                    _loc_5.root.parent = null;
                }
                else
                {
                    _loc_17 = _loc_3.aabb;
                    _loc_6 = _loc_5.root;
                    while (_loc_6.child1 != null)
                    {
                        
                        _loc_7 = _loc_6.child1;
                        _loc_8 = _loc_6.child2;
                        _loc_18 = _loc_6.aabb;
                        _loc_23 = (_loc_18.maxx - _loc_18.minx + (_loc_18.maxy - _loc_18.miny)) * 2;
                        _loc_18 = ZPP_AABBTree.tmpaabb;
                        _loc_32 = _loc_6.aabb;
                        if (_loc_32.minx < _loc_17.minx)
                        {
                            _loc_18.minx = _loc_32.minx;
                        }
                        else
                        {
                            _loc_18.minx = _loc_17.minx;
                        }
                        if (_loc_32.miny < _loc_17.miny)
                        {
                            _loc_18.miny = _loc_32.miny;
                        }
                        else
                        {
                            _loc_18.miny = _loc_17.miny;
                        }
                        if (_loc_32.maxx > _loc_17.maxx)
                        {
                            _loc_18.maxx = _loc_32.maxx;
                        }
                        else
                        {
                            _loc_18.maxx = _loc_17.maxx;
                        }
                        if (_loc_32.maxy > _loc_17.maxy)
                        {
                            _loc_18.maxy = _loc_32.maxy;
                        }
                        else
                        {
                            _loc_18.maxy = _loc_17.maxy;
                        }
                        _loc_18 = ZPP_AABBTree.tmpaabb;
                        _loc_28 = (_loc_18.maxx - _loc_18.minx + (_loc_18.maxy - _loc_18.miny)) * 2;
                        _loc_33 = 2 * _loc_28;
                        _loc_34 = 2 * (_loc_28 - _loc_23);
                        _loc_18 = ZPP_AABBTree.tmpaabb;
                        _loc_32 = _loc_7.aabb;
                        if (_loc_17.minx < _loc_32.minx)
                        {
                            _loc_18.minx = _loc_17.minx;
                        }
                        else
                        {
                            _loc_18.minx = _loc_32.minx;
                        }
                        if (_loc_17.miny < _loc_32.miny)
                        {
                            _loc_18.miny = _loc_17.miny;
                        }
                        else
                        {
                            _loc_18.miny = _loc_32.miny;
                        }
                        if (_loc_17.maxx > _loc_32.maxx)
                        {
                            _loc_18.maxx = _loc_17.maxx;
                        }
                        else
                        {
                            _loc_18.maxx = _loc_32.maxx;
                        }
                        if (_loc_17.maxy > _loc_32.maxy)
                        {
                            _loc_18.maxy = _loc_17.maxy;
                        }
                        else
                        {
                            _loc_18.maxy = _loc_32.maxy;
                        }
                        if (_loc_7.child1 == null)
                        {
                            _loc_18 = ZPP_AABBTree.tmpaabb;
                            _loc_35 = (_loc_18.maxx - _loc_18.minx + (_loc_18.maxy - _loc_18.miny)) * 2 + _loc_34;
                        }
                        else
                        {
                            _loc_18 = _loc_7.aabb;
                            _loc_36 = (_loc_18.maxx - _loc_18.minx + (_loc_18.maxy - _loc_18.miny)) * 2;
                            _loc_18 = ZPP_AABBTree.tmpaabb;
                            _loc_37 = (_loc_18.maxx - _loc_18.minx + (_loc_18.maxy - _loc_18.miny)) * 2;
                            _loc_35 = _loc_37 - _loc_36 + _loc_34;
                        }
                        _loc_18 = ZPP_AABBTree.tmpaabb;
                        _loc_32 = _loc_8.aabb;
                        if (_loc_17.minx < _loc_32.minx)
                        {
                            _loc_18.minx = _loc_17.minx;
                        }
                        else
                        {
                            _loc_18.minx = _loc_32.minx;
                        }
                        if (_loc_17.miny < _loc_32.miny)
                        {
                            _loc_18.miny = _loc_17.miny;
                        }
                        else
                        {
                            _loc_18.miny = _loc_32.miny;
                        }
                        if (_loc_17.maxx > _loc_32.maxx)
                        {
                            _loc_18.maxx = _loc_17.maxx;
                        }
                        else
                        {
                            _loc_18.maxx = _loc_32.maxx;
                        }
                        if (_loc_17.maxy > _loc_32.maxy)
                        {
                            _loc_18.maxy = _loc_17.maxy;
                        }
                        else
                        {
                            _loc_18.maxy = _loc_32.maxy;
                        }
                        if (_loc_8.child1 == null)
                        {
                            _loc_18 = ZPP_AABBTree.tmpaabb;
                            _loc_36 = (_loc_18.maxx - _loc_18.minx + (_loc_18.maxy - _loc_18.miny)) * 2 + _loc_34;
                        }
                        else
                        {
                            _loc_18 = _loc_8.aabb;
                            _loc_37 = (_loc_18.maxx - _loc_18.minx + (_loc_18.maxy - _loc_18.miny)) * 2;
                            _loc_18 = ZPP_AABBTree.tmpaabb;
                            _loc_38 = (_loc_18.maxx - _loc_18.minx + (_loc_18.maxy - _loc_18.miny)) * 2;
                            _loc_36 = _loc_38 - _loc_37 + _loc_34;
                        }
                        if (_loc_33 < _loc_35)
                        {
                        }
                        if (_loc_33 < _loc_36)
                        {
                            break;
                            continue;
                        }
                        if (_loc_35 < _loc_36)
                        {
                            _loc_6 = _loc_7;
                            continue;
                        }
                        _loc_6 = _loc_8;
                    }
                    _loc_7 = _loc_6;
                    _loc_8 = _loc_7.parent;
                    if (ZPP_AABBNode.zpp_pool == null)
                    {
                        _loc_9 = new ZPP_AABBNode();
                    }
                    else
                    {
                        _loc_9 = ZPP_AABBNode.zpp_pool;
                        ZPP_AABBNode.zpp_pool = _loc_9.next;
                        _loc_9.next = null;
                    }
                    if (ZPP_AABB.zpp_pool == null)
                    {
                        _loc_9.aabb = new ZPP_AABB();
                    }
                    else
                    {
                        _loc_9.aabb = ZPP_AABB.zpp_pool;
                        ZPP_AABB.zpp_pool = _loc_9.aabb.next;
                        _loc_9.aabb.next = null;
                    }
                    _loc_9.moved = false;
                    _loc_9.synced = false;
                    _loc_9.first_sync = false;
                    _loc_9.parent = _loc_8;
                    _loc_18 = _loc_9.aabb;
                    _loc_32 = _loc_7.aabb;
                    if (_loc_17.minx < _loc_32.minx)
                    {
                        _loc_18.minx = _loc_17.minx;
                    }
                    else
                    {
                        _loc_18.minx = _loc_32.minx;
                    }
                    if (_loc_17.miny < _loc_32.miny)
                    {
                        _loc_18.miny = _loc_17.miny;
                    }
                    else
                    {
                        _loc_18.miny = _loc_32.miny;
                    }
                    if (_loc_17.maxx > _loc_32.maxx)
                    {
                        _loc_18.maxx = _loc_17.maxx;
                    }
                    else
                    {
                        _loc_18.maxx = _loc_32.maxx;
                    }
                    if (_loc_17.maxy > _loc_32.maxy)
                    {
                        _loc_18.maxy = _loc_17.maxy;
                    }
                    else
                    {
                        _loc_18.maxy = _loc_32.maxy;
                    }
                    _loc_9.height = _loc_7.height + 1;
                    if (_loc_8 != null)
                    {
                        if (_loc_8.child1 == _loc_7)
                        {
                            _loc_8.child1 = _loc_9;
                        }
                        else
                        {
                            _loc_8.child2 = _loc_9;
                        }
                        _loc_9.child1 = _loc_7;
                        _loc_9.child2 = _loc_3;
                        _loc_7.parent = _loc_9;
                        _loc_3.parent = _loc_9;
                    }
                    else
                    {
                        _loc_9.child1 = _loc_7;
                        _loc_9.child2 = _loc_3;
                        _loc_7.parent = _loc_9;
                        _loc_3.parent = _loc_9;
                        _loc_5.root = _loc_9;
                    }
                    _loc_6 = _loc_3.parent;
                    while (_loc_6 != null)
                    {
                        
                        if (_loc_6.child1 != null)
                        {
                        }
                        if (_loc_6.height < 2)
                        {
                            _loc_6 = _loc_6;
                        }
                        else
                        {
                            _loc_12 = _loc_6.child1;
                            _loc_13 = _loc_6.child2;
                            _loc_14 = _loc_13.height - _loc_12.height;
                            if (_loc_14 > 1)
                            {
                                _loc_15 = _loc_13.child1;
                                _loc_16 = _loc_13.child2;
                                _loc_13.child1 = _loc_6;
                                _loc_13.parent = _loc_6.parent;
                                _loc_6.parent = _loc_13;
                                if (_loc_13.parent != null)
                                {
                                    if (_loc_13.parent.child1 == _loc_6)
                                    {
                                        _loc_13.parent.child1 = _loc_13;
                                    }
                                    else
                                    {
                                        _loc_13.parent.child2 = _loc_13;
                                    }
                                }
                                else
                                {
                                    _loc_5.root = _loc_13;
                                }
                                if (_loc_15.height > _loc_16.height)
                                {
                                    _loc_13.child2 = _loc_15;
                                    _loc_6.child2 = _loc_16;
                                    _loc_16.parent = _loc_6;
                                    _loc_18 = _loc_6.aabb;
                                    _loc_32 = _loc_12.aabb;
                                    _loc_39 = _loc_16.aabb;
                                    if (_loc_32.minx < _loc_39.minx)
                                    {
                                        _loc_18.minx = _loc_32.minx;
                                    }
                                    else
                                    {
                                        _loc_18.minx = _loc_39.minx;
                                    }
                                    if (_loc_32.miny < _loc_39.miny)
                                    {
                                        _loc_18.miny = _loc_32.miny;
                                    }
                                    else
                                    {
                                        _loc_18.miny = _loc_39.miny;
                                    }
                                    if (_loc_32.maxx > _loc_39.maxx)
                                    {
                                        _loc_18.maxx = _loc_32.maxx;
                                    }
                                    else
                                    {
                                        _loc_18.maxx = _loc_39.maxx;
                                    }
                                    if (_loc_32.maxy > _loc_39.maxy)
                                    {
                                        _loc_18.maxy = _loc_32.maxy;
                                    }
                                    else
                                    {
                                        _loc_18.maxy = _loc_39.maxy;
                                    }
                                    _loc_18 = _loc_13.aabb;
                                    _loc_32 = _loc_6.aabb;
                                    _loc_39 = _loc_15.aabb;
                                    if (_loc_32.minx < _loc_39.minx)
                                    {
                                        _loc_18.minx = _loc_32.minx;
                                    }
                                    else
                                    {
                                        _loc_18.minx = _loc_39.minx;
                                    }
                                    if (_loc_32.miny < _loc_39.miny)
                                    {
                                        _loc_18.miny = _loc_32.miny;
                                    }
                                    else
                                    {
                                        _loc_18.miny = _loc_39.miny;
                                    }
                                    if (_loc_32.maxx > _loc_39.maxx)
                                    {
                                        _loc_18.maxx = _loc_32.maxx;
                                    }
                                    else
                                    {
                                        _loc_18.maxx = _loc_39.maxx;
                                    }
                                    if (_loc_32.maxy > _loc_39.maxy)
                                    {
                                        _loc_18.maxy = _loc_32.maxy;
                                    }
                                    else
                                    {
                                        _loc_18.maxy = _loc_39.maxy;
                                    }
                                    _loc_19 = _loc_12.height;
                                    _loc_20 = _loc_16.height;
                                    _loc_6.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                    _loc_19 = _loc_6.height;
                                    _loc_20 = _loc_15.height;
                                    _loc_13.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                }
                                else
                                {
                                    _loc_13.child2 = _loc_16;
                                    _loc_6.child2 = _loc_15;
                                    _loc_15.parent = _loc_6;
                                    _loc_18 = _loc_6.aabb;
                                    _loc_32 = _loc_12.aabb;
                                    _loc_39 = _loc_15.aabb;
                                    if (_loc_32.minx < _loc_39.minx)
                                    {
                                        _loc_18.minx = _loc_32.minx;
                                    }
                                    else
                                    {
                                        _loc_18.minx = _loc_39.minx;
                                    }
                                    if (_loc_32.miny < _loc_39.miny)
                                    {
                                        _loc_18.miny = _loc_32.miny;
                                    }
                                    else
                                    {
                                        _loc_18.miny = _loc_39.miny;
                                    }
                                    if (_loc_32.maxx > _loc_39.maxx)
                                    {
                                        _loc_18.maxx = _loc_32.maxx;
                                    }
                                    else
                                    {
                                        _loc_18.maxx = _loc_39.maxx;
                                    }
                                    if (_loc_32.maxy > _loc_39.maxy)
                                    {
                                        _loc_18.maxy = _loc_32.maxy;
                                    }
                                    else
                                    {
                                        _loc_18.maxy = _loc_39.maxy;
                                    }
                                    _loc_18 = _loc_13.aabb;
                                    _loc_32 = _loc_6.aabb;
                                    _loc_39 = _loc_16.aabb;
                                    if (_loc_32.minx < _loc_39.minx)
                                    {
                                        _loc_18.minx = _loc_32.minx;
                                    }
                                    else
                                    {
                                        _loc_18.minx = _loc_39.minx;
                                    }
                                    if (_loc_32.miny < _loc_39.miny)
                                    {
                                        _loc_18.miny = _loc_32.miny;
                                    }
                                    else
                                    {
                                        _loc_18.miny = _loc_39.miny;
                                    }
                                    if (_loc_32.maxx > _loc_39.maxx)
                                    {
                                        _loc_18.maxx = _loc_32.maxx;
                                    }
                                    else
                                    {
                                        _loc_18.maxx = _loc_39.maxx;
                                    }
                                    if (_loc_32.maxy > _loc_39.maxy)
                                    {
                                        _loc_18.maxy = _loc_32.maxy;
                                    }
                                    else
                                    {
                                        _loc_18.maxy = _loc_39.maxy;
                                    }
                                    _loc_19 = _loc_12.height;
                                    _loc_20 = _loc_15.height;
                                    _loc_6.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                    _loc_19 = _loc_6.height;
                                    _loc_20 = _loc_16.height;
                                    _loc_13.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                }
                                _loc_6 = _loc_13;
                            }
                            else if (_loc_14 < -1)
                            {
                                _loc_15 = _loc_12.child1;
                                _loc_16 = _loc_12.child2;
                                _loc_12.child1 = _loc_6;
                                _loc_12.parent = _loc_6.parent;
                                _loc_6.parent = _loc_12;
                                if (_loc_12.parent != null)
                                {
                                    if (_loc_12.parent.child1 == _loc_6)
                                    {
                                        _loc_12.parent.child1 = _loc_12;
                                    }
                                    else
                                    {
                                        _loc_12.parent.child2 = _loc_12;
                                    }
                                }
                                else
                                {
                                    _loc_5.root = _loc_12;
                                }
                                if (_loc_15.height > _loc_16.height)
                                {
                                    _loc_12.child2 = _loc_15;
                                    _loc_6.child1 = _loc_16;
                                    _loc_16.parent = _loc_6;
                                    _loc_18 = _loc_6.aabb;
                                    _loc_32 = _loc_13.aabb;
                                    _loc_39 = _loc_16.aabb;
                                    if (_loc_32.minx < _loc_39.minx)
                                    {
                                        _loc_18.minx = _loc_32.minx;
                                    }
                                    else
                                    {
                                        _loc_18.minx = _loc_39.minx;
                                    }
                                    if (_loc_32.miny < _loc_39.miny)
                                    {
                                        _loc_18.miny = _loc_32.miny;
                                    }
                                    else
                                    {
                                        _loc_18.miny = _loc_39.miny;
                                    }
                                    if (_loc_32.maxx > _loc_39.maxx)
                                    {
                                        _loc_18.maxx = _loc_32.maxx;
                                    }
                                    else
                                    {
                                        _loc_18.maxx = _loc_39.maxx;
                                    }
                                    if (_loc_32.maxy > _loc_39.maxy)
                                    {
                                        _loc_18.maxy = _loc_32.maxy;
                                    }
                                    else
                                    {
                                        _loc_18.maxy = _loc_39.maxy;
                                    }
                                    _loc_18 = _loc_12.aabb;
                                    _loc_32 = _loc_6.aabb;
                                    _loc_39 = _loc_15.aabb;
                                    if (_loc_32.minx < _loc_39.minx)
                                    {
                                        _loc_18.minx = _loc_32.minx;
                                    }
                                    else
                                    {
                                        _loc_18.minx = _loc_39.minx;
                                    }
                                    if (_loc_32.miny < _loc_39.miny)
                                    {
                                        _loc_18.miny = _loc_32.miny;
                                    }
                                    else
                                    {
                                        _loc_18.miny = _loc_39.miny;
                                    }
                                    if (_loc_32.maxx > _loc_39.maxx)
                                    {
                                        _loc_18.maxx = _loc_32.maxx;
                                    }
                                    else
                                    {
                                        _loc_18.maxx = _loc_39.maxx;
                                    }
                                    if (_loc_32.maxy > _loc_39.maxy)
                                    {
                                        _loc_18.maxy = _loc_32.maxy;
                                    }
                                    else
                                    {
                                        _loc_18.maxy = _loc_39.maxy;
                                    }
                                    _loc_19 = _loc_13.height;
                                    _loc_20 = _loc_16.height;
                                    _loc_6.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                    _loc_19 = _loc_6.height;
                                    _loc_20 = _loc_15.height;
                                    _loc_12.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                }
                                else
                                {
                                    _loc_12.child2 = _loc_16;
                                    _loc_6.child1 = _loc_15;
                                    _loc_15.parent = _loc_6;
                                    _loc_18 = _loc_6.aabb;
                                    _loc_32 = _loc_13.aabb;
                                    _loc_39 = _loc_15.aabb;
                                    if (_loc_32.minx < _loc_39.minx)
                                    {
                                        _loc_18.minx = _loc_32.minx;
                                    }
                                    else
                                    {
                                        _loc_18.minx = _loc_39.minx;
                                    }
                                    if (_loc_32.miny < _loc_39.miny)
                                    {
                                        _loc_18.miny = _loc_32.miny;
                                    }
                                    else
                                    {
                                        _loc_18.miny = _loc_39.miny;
                                    }
                                    if (_loc_32.maxx > _loc_39.maxx)
                                    {
                                        _loc_18.maxx = _loc_32.maxx;
                                    }
                                    else
                                    {
                                        _loc_18.maxx = _loc_39.maxx;
                                    }
                                    if (_loc_32.maxy > _loc_39.maxy)
                                    {
                                        _loc_18.maxy = _loc_32.maxy;
                                    }
                                    else
                                    {
                                        _loc_18.maxy = _loc_39.maxy;
                                    }
                                    _loc_18 = _loc_12.aabb;
                                    _loc_32 = _loc_6.aabb;
                                    _loc_39 = _loc_16.aabb;
                                    if (_loc_32.minx < _loc_39.minx)
                                    {
                                        _loc_18.minx = _loc_32.minx;
                                    }
                                    else
                                    {
                                        _loc_18.minx = _loc_39.minx;
                                    }
                                    if (_loc_32.miny < _loc_39.miny)
                                    {
                                        _loc_18.miny = _loc_32.miny;
                                    }
                                    else
                                    {
                                        _loc_18.miny = _loc_39.miny;
                                    }
                                    if (_loc_32.maxx > _loc_39.maxx)
                                    {
                                        _loc_18.maxx = _loc_32.maxx;
                                    }
                                    else
                                    {
                                        _loc_18.maxx = _loc_39.maxx;
                                    }
                                    if (_loc_32.maxy > _loc_39.maxy)
                                    {
                                        _loc_18.maxy = _loc_32.maxy;
                                    }
                                    else
                                    {
                                        _loc_18.maxy = _loc_39.maxy;
                                    }
                                    _loc_19 = _loc_13.height;
                                    _loc_20 = _loc_15.height;
                                    _loc_6.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                    _loc_19 = _loc_6.height;
                                    _loc_20 = _loc_16.height;
                                    _loc_12.height = 1 + (_loc_19 > _loc_20 ? (_loc_19) : (_loc_20));
                                }
                                _loc_6 = _loc_12;
                            }
                            else
                            {
                                _loc_6 = _loc_6;
                            }
                        }
                        _loc_12 = _loc_6.child1;
                        _loc_13 = _loc_6.child2;
                        _loc_14 = _loc_12.height;
                        _loc_19 = _loc_13.height;
                        _loc_6.height = 1 + (_loc_14 > _loc_19 ? (_loc_14) : (_loc_19));
                        _loc_18 = _loc_6.aabb;
                        _loc_32 = _loc_12.aabb;
                        _loc_39 = _loc_13.aabb;
                        if (_loc_32.minx < _loc_39.minx)
                        {
                            _loc_18.minx = _loc_32.minx;
                        }
                        else
                        {
                            _loc_18.minx = _loc_39.minx;
                        }
                        if (_loc_32.miny < _loc_39.miny)
                        {
                            _loc_18.miny = _loc_32.miny;
                        }
                        else
                        {
                            _loc_18.miny = _loc_39.miny;
                        }
                        if (_loc_32.maxx > _loc_39.maxx)
                        {
                            _loc_18.maxx = _loc_32.maxx;
                        }
                        else
                        {
                            _loc_18.maxx = _loc_39.maxx;
                        }
                        if (_loc_32.maxy > _loc_39.maxy)
                        {
                            _loc_18.maxy = _loc_32.maxy;
                        }
                        else
                        {
                            _loc_18.maxy = _loc_39.maxy;
                        }
                        _loc_6 = _loc_6.parent;
                    }
                }
                _loc_3.synced = false;
                _loc_3 = _loc_3.snext;
            }
            while (syncs != null)
            {
                
                _loc_7 = syncs;
                syncs = _loc_7.snext;
                _loc_7.snext = null;
                _loc_6 = _loc_7;
                if (_loc_6.moved)
                {
                    continue;
                }
                _loc_6.moved = false;
                _loc_4 = _loc_6.shape;
                _loc_30 = _loc_4.body;
                if (_loc_30.component.sleeping)
                {
                    continue;
                }
                _loc_10 = _loc_6.aabb;
                _loc_7 = null;
                if (dtree.root != null)
                {
                    dtree.root.next = _loc_7;
                    _loc_7 = dtree.root;
                }
                while (_loc_7 != null)
                {
                    
                    _loc_9 = _loc_7;
                    _loc_7 = _loc_9.next;
                    _loc_9.next = null;
                    _loc_8 = _loc_9;
                    if (_loc_8 == _loc_6)
                    {
                        continue;
                    }
                    if (_loc_8.child1 == null)
                    {
                        _loc_40 = _loc_8.shape;
                        if (_loc_40.body != _loc_4.body)
                        {
                            if (_loc_40.body.type == ZPP_Flags.id_BodyType_STATIC)
                            {
                            }
                        }
                        if (_loc_4.body.type != ZPP_Flags.id_BodyType_STATIC)
                        {
                            _loc_17 = _loc_8.aabb;
                            if (_loc_17.miny <= _loc_10.maxy)
                            {
                            }
                            if (_loc_10.miny <= _loc_17.maxy)
                            {
                            }
                            if (_loc_17.minx <= _loc_10.maxx)
                            {
                            }
                            if (_loc_10.minx <= _loc_17.maxx)
                            {
                                if (_loc_4.id < _loc_40.id)
                                {
                                    _loc_14 = _loc_4.id;
                                    _loc_19 = _loc_40.id;
                                }
                                else
                                {
                                    _loc_14 = _loc_40.id;
                                    _loc_19 = _loc_4.id;
                                }
                                if (_loc_4.pairs.length < _loc_40.pairs.length)
                                {
                                    _loc_41 = _loc_4;
                                }
                                else
                                {
                                    _loc_41 = _loc_40;
                                }
                                _loc_42 = null;
                                _loc_43 = _loc_41.pairs.head;
                                while (_loc_43 != null)
                                {
                                    
                                    _loc_44 = _loc_43.elt;
                                    if (_loc_44.id == _loc_14)
                                    {
                                    }
                                    if (_loc_44.di == _loc_19)
                                    {
                                        _loc_42 = _loc_44;
                                        break;
                                    }
                                    _loc_43 = _loc_43.next;
                                }
                                if (_loc_42 != null)
                                {
                                    if (_loc_42.sleeping)
                                    {
                                        _loc_42.sleeping = false;
                                        _loc_42.next = pairs;
                                        pairs = _loc_42;
                                        _loc_42.first = true;
                                    }
                                    continue;
                                }
                                if (ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_42 = new ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_42 = ZPP_AABBPair.zpp_pool;
                                    ZPP_AABBPair.zpp_pool = _loc_42.next;
                                    _loc_42.next = null;
                                }
                                _loc_42.n1 = _loc_6;
                                _loc_42.n2 = _loc_8;
                                _loc_42.id = _loc_14;
                                _loc_42.di = _loc_19;
                                _loc_42.next = pairs;
                                pairs = _loc_42;
                                _loc_42.first = true;
                                _loc_45 = _loc_4.pairs;
                                if (ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_46 = new ZNPNode_ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_46 = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc_46.next;
                                    _loc_46.next = null;
                                }
                                _loc_46.elt = _loc_42;
                                _loc_43 = _loc_46;
                                _loc_43.next = _loc_45.head;
                                _loc_45.head = _loc_43;
                                _loc_45.modified = true;
                                (_loc_45.length + 1);
                                _loc_45 = _loc_40.pairs;
                                if (ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_46 = new ZNPNode_ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_46 = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc_46.next;
                                    _loc_46.next = null;
                                }
                                _loc_46.elt = _loc_42;
                                _loc_43 = _loc_46;
                                _loc_43.next = _loc_45.head;
                                _loc_45.head = _loc_43;
                                _loc_45.modified = true;
                                (_loc_45.length + 1);
                            }
                        }
                        continue;
                    }
                    _loc_17 = _loc_8.aabb;
                    if (_loc_17.miny <= _loc_10.maxy)
                    {
                    }
                    if (_loc_10.miny <= _loc_17.maxy)
                    {
                    }
                    if (_loc_17.minx <= _loc_10.maxx)
                    {
                    }
                    if (_loc_10.minx <= _loc_17.maxx)
                    {
                        if (_loc_8.child1 != null)
                        {
                            _loc_8.child1.next = _loc_7;
                            _loc_7 = _loc_8.child1;
                        }
                        if (_loc_8.child2 != null)
                        {
                            _loc_8.child2.next = _loc_7;
                            _loc_7 = _loc_8.child2;
                        }
                    }
                }
                if (stree.root != null)
                {
                    stree.root.next = _loc_7;
                    _loc_7 = stree.root;
                }
                while (_loc_7 != null)
                {
                    
                    _loc_9 = _loc_7;
                    _loc_7 = _loc_9.next;
                    _loc_9.next = null;
                    _loc_8 = _loc_9;
                    if (_loc_8 == _loc_6)
                    {
                        continue;
                    }
                    if (_loc_8.child1 == null)
                    {
                        _loc_40 = _loc_8.shape;
                        if (_loc_40.body != _loc_4.body)
                        {
                            if (_loc_40.body.type == ZPP_Flags.id_BodyType_STATIC)
                            {
                            }
                        }
                        if (_loc_4.body.type != ZPP_Flags.id_BodyType_STATIC)
                        {
                            _loc_17 = _loc_8.aabb;
                            if (_loc_17.miny <= _loc_10.maxy)
                            {
                            }
                            if (_loc_10.miny <= _loc_17.maxy)
                            {
                            }
                            if (_loc_17.minx <= _loc_10.maxx)
                            {
                            }
                            if (_loc_10.minx <= _loc_17.maxx)
                            {
                                if (_loc_4.id < _loc_40.id)
                                {
                                    _loc_14 = _loc_4.id;
                                    _loc_19 = _loc_40.id;
                                }
                                else
                                {
                                    _loc_14 = _loc_40.id;
                                    _loc_19 = _loc_4.id;
                                }
                                if (_loc_4.pairs.length < _loc_40.pairs.length)
                                {
                                    _loc_41 = _loc_4;
                                }
                                else
                                {
                                    _loc_41 = _loc_40;
                                }
                                _loc_42 = null;
                                _loc_43 = _loc_41.pairs.head;
                                while (_loc_43 != null)
                                {
                                    
                                    _loc_44 = _loc_43.elt;
                                    if (_loc_44.id == _loc_14)
                                    {
                                    }
                                    if (_loc_44.di == _loc_19)
                                    {
                                        _loc_42 = _loc_44;
                                        break;
                                    }
                                    _loc_43 = _loc_43.next;
                                }
                                if (_loc_42 != null)
                                {
                                    if (_loc_42.sleeping)
                                    {
                                        _loc_42.sleeping = false;
                                        _loc_42.next = pairs;
                                        pairs = _loc_42;
                                        _loc_42.first = true;
                                    }
                                    continue;
                                }
                                if (ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_42 = new ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_42 = ZPP_AABBPair.zpp_pool;
                                    ZPP_AABBPair.zpp_pool = _loc_42.next;
                                    _loc_42.next = null;
                                }
                                _loc_42.n1 = _loc_6;
                                _loc_42.n2 = _loc_8;
                                _loc_42.id = _loc_14;
                                _loc_42.di = _loc_19;
                                _loc_42.next = pairs;
                                pairs = _loc_42;
                                _loc_42.first = true;
                                _loc_45 = _loc_4.pairs;
                                if (ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_46 = new ZNPNode_ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_46 = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc_46.next;
                                    _loc_46.next = null;
                                }
                                _loc_46.elt = _loc_42;
                                _loc_43 = _loc_46;
                                _loc_43.next = _loc_45.head;
                                _loc_45.head = _loc_43;
                                _loc_45.modified = true;
                                (_loc_45.length + 1);
                                _loc_45 = _loc_40.pairs;
                                if (ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_46 = new ZNPNode_ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_46 = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc_46.next;
                                    _loc_46.next = null;
                                }
                                _loc_46.elt = _loc_42;
                                _loc_43 = _loc_46;
                                _loc_43.next = _loc_45.head;
                                _loc_45.head = _loc_43;
                                _loc_45.modified = true;
                                (_loc_45.length + 1);
                            }
                        }
                        continue;
                    }
                    _loc_17 = _loc_8.aabb;
                    if (_loc_17.miny <= _loc_10.maxy)
                    {
                    }
                    if (_loc_10.miny <= _loc_17.maxy)
                    {
                    }
                    if (_loc_17.minx <= _loc_10.maxx)
                    {
                    }
                    if (_loc_10.minx <= _loc_17.maxx)
                    {
                        if (_loc_8.child1 != null)
                        {
                            _loc_8.child1.next = _loc_7;
                            _loc_7 = _loc_8.child1;
                        }
                        if (_loc_8.child2 != null)
                        {
                            _loc_8.child2.next = _loc_7;
                            _loc_7 = _loc_8.child2;
                        }
                    }
                }
            }
            while (moves != null)
            {
                
                _loc_7 = moves;
                moves = _loc_7.mnext;
                _loc_7.mnext = null;
                _loc_6 = _loc_7;
                _loc_6.moved = false;
                _loc_4 = _loc_6.shape;
                _loc_30 = _loc_4.body;
                if (_loc_30.component.sleeping)
                {
                    continue;
                }
                _loc_10 = _loc_6.aabb;
                _loc_7 = null;
                if (dtree.root != null)
                {
                    dtree.root.next = _loc_7;
                    _loc_7 = dtree.root;
                }
                while (_loc_7 != null)
                {
                    
                    _loc_9 = _loc_7;
                    _loc_7 = _loc_9.next;
                    _loc_9.next = null;
                    _loc_8 = _loc_9;
                    if (_loc_8 == _loc_6)
                    {
                        continue;
                    }
                    if (_loc_8.child1 == null)
                    {
                        _loc_40 = _loc_8.shape;
                        if (_loc_40.body != _loc_4.body)
                        {
                            if (_loc_40.body.type == ZPP_Flags.id_BodyType_STATIC)
                            {
                            }
                        }
                        if (_loc_4.body.type != ZPP_Flags.id_BodyType_STATIC)
                        {
                            _loc_17 = _loc_8.aabb;
                            if (_loc_17.miny <= _loc_10.maxy)
                            {
                            }
                            if (_loc_10.miny <= _loc_17.maxy)
                            {
                            }
                            if (_loc_17.minx <= _loc_10.maxx)
                            {
                            }
                            if (_loc_10.minx <= _loc_17.maxx)
                            {
                                if (_loc_4.id < _loc_40.id)
                                {
                                    _loc_14 = _loc_4.id;
                                    _loc_19 = _loc_40.id;
                                }
                                else
                                {
                                    _loc_14 = _loc_40.id;
                                    _loc_19 = _loc_4.id;
                                }
                                if (_loc_4.pairs.length < _loc_40.pairs.length)
                                {
                                    _loc_41 = _loc_4;
                                }
                                else
                                {
                                    _loc_41 = _loc_40;
                                }
                                _loc_42 = null;
                                _loc_43 = _loc_41.pairs.head;
                                while (_loc_43 != null)
                                {
                                    
                                    _loc_44 = _loc_43.elt;
                                    if (_loc_44.id == _loc_14)
                                    {
                                    }
                                    if (_loc_44.di == _loc_19)
                                    {
                                        _loc_42 = _loc_44;
                                        break;
                                    }
                                    _loc_43 = _loc_43.next;
                                }
                                if (_loc_42 != null)
                                {
                                    if (_loc_42.sleeping)
                                    {
                                        _loc_42.sleeping = false;
                                        _loc_42.next = pairs;
                                        pairs = _loc_42;
                                        _loc_42.first = true;
                                    }
                                    continue;
                                }
                                if (ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_42 = new ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_42 = ZPP_AABBPair.zpp_pool;
                                    ZPP_AABBPair.zpp_pool = _loc_42.next;
                                    _loc_42.next = null;
                                }
                                _loc_42.n1 = _loc_6;
                                _loc_42.n2 = _loc_8;
                                _loc_42.id = _loc_14;
                                _loc_42.di = _loc_19;
                                _loc_42.next = pairs;
                                pairs = _loc_42;
                                _loc_42.first = true;
                                _loc_45 = _loc_4.pairs;
                                if (ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_46 = new ZNPNode_ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_46 = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc_46.next;
                                    _loc_46.next = null;
                                }
                                _loc_46.elt = _loc_42;
                                _loc_43 = _loc_46;
                                _loc_43.next = _loc_45.head;
                                _loc_45.head = _loc_43;
                                _loc_45.modified = true;
                                (_loc_45.length + 1);
                                _loc_45 = _loc_40.pairs;
                                if (ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_46 = new ZNPNode_ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_46 = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc_46.next;
                                    _loc_46.next = null;
                                }
                                _loc_46.elt = _loc_42;
                                _loc_43 = _loc_46;
                                _loc_43.next = _loc_45.head;
                                _loc_45.head = _loc_43;
                                _loc_45.modified = true;
                                (_loc_45.length + 1);
                            }
                        }
                        continue;
                    }
                    _loc_17 = _loc_8.aabb;
                    if (_loc_17.miny <= _loc_10.maxy)
                    {
                    }
                    if (_loc_10.miny <= _loc_17.maxy)
                    {
                    }
                    if (_loc_17.minx <= _loc_10.maxx)
                    {
                    }
                    if (_loc_10.minx <= _loc_17.maxx)
                    {
                        if (_loc_8.child1 != null)
                        {
                            _loc_8.child1.next = _loc_7;
                            _loc_7 = _loc_8.child1;
                        }
                        if (_loc_8.child2 != null)
                        {
                            _loc_8.child2.next = _loc_7;
                            _loc_7 = _loc_8.child2;
                        }
                    }
                }
                if (stree.root != null)
                {
                    stree.root.next = _loc_7;
                    _loc_7 = stree.root;
                }
                while (_loc_7 != null)
                {
                    
                    _loc_9 = _loc_7;
                    _loc_7 = _loc_9.next;
                    _loc_9.next = null;
                    _loc_8 = _loc_9;
                    if (_loc_8 == _loc_6)
                    {
                        continue;
                    }
                    if (_loc_8.child1 == null)
                    {
                        _loc_40 = _loc_8.shape;
                        if (_loc_40.body != _loc_4.body)
                        {
                            if (_loc_40.body.type == ZPP_Flags.id_BodyType_STATIC)
                            {
                            }
                        }
                        if (_loc_4.body.type != ZPP_Flags.id_BodyType_STATIC)
                        {
                            _loc_17 = _loc_8.aabb;
                            if (_loc_17.miny <= _loc_10.maxy)
                            {
                            }
                            if (_loc_10.miny <= _loc_17.maxy)
                            {
                            }
                            if (_loc_17.minx <= _loc_10.maxx)
                            {
                            }
                            if (_loc_10.minx <= _loc_17.maxx)
                            {
                                if (_loc_4.id < _loc_40.id)
                                {
                                    _loc_14 = _loc_4.id;
                                    _loc_19 = _loc_40.id;
                                }
                                else
                                {
                                    _loc_14 = _loc_40.id;
                                    _loc_19 = _loc_4.id;
                                }
                                if (_loc_4.pairs.length < _loc_40.pairs.length)
                                {
                                    _loc_41 = _loc_4;
                                }
                                else
                                {
                                    _loc_41 = _loc_40;
                                }
                                _loc_42 = null;
                                _loc_43 = _loc_41.pairs.head;
                                while (_loc_43 != null)
                                {
                                    
                                    _loc_44 = _loc_43.elt;
                                    if (_loc_44.id == _loc_14)
                                    {
                                    }
                                    if (_loc_44.di == _loc_19)
                                    {
                                        _loc_42 = _loc_44;
                                        break;
                                    }
                                    _loc_43 = _loc_43.next;
                                }
                                if (_loc_42 != null)
                                {
                                    if (_loc_42.sleeping)
                                    {
                                        _loc_42.sleeping = false;
                                        _loc_42.next = pairs;
                                        pairs = _loc_42;
                                        _loc_42.first = true;
                                    }
                                    continue;
                                }
                                if (ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_42 = new ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_42 = ZPP_AABBPair.zpp_pool;
                                    ZPP_AABBPair.zpp_pool = _loc_42.next;
                                    _loc_42.next = null;
                                }
                                _loc_42.n1 = _loc_6;
                                _loc_42.n2 = _loc_8;
                                _loc_42.id = _loc_14;
                                _loc_42.di = _loc_19;
                                _loc_42.next = pairs;
                                pairs = _loc_42;
                                _loc_42.first = true;
                                _loc_45 = _loc_4.pairs;
                                if (ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_46 = new ZNPNode_ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_46 = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc_46.next;
                                    _loc_46.next = null;
                                }
                                _loc_46.elt = _loc_42;
                                _loc_43 = _loc_46;
                                _loc_43.next = _loc_45.head;
                                _loc_45.head = _loc_43;
                                _loc_45.modified = true;
                                (_loc_45.length + 1);
                                _loc_45 = _loc_40.pairs;
                                if (ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                {
                                    _loc_46 = new ZNPNode_ZPP_AABBPair();
                                }
                                else
                                {
                                    _loc_46 = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc_46.next;
                                    _loc_46.next = null;
                                }
                                _loc_46.elt = _loc_42;
                                _loc_43 = _loc_46;
                                _loc_43.next = _loc_45.head;
                                _loc_45.head = _loc_43;
                                _loc_45.modified = true;
                                (_loc_45.length + 1);
                            }
                        }
                        continue;
                    }
                    _loc_17 = _loc_8.aabb;
                    if (_loc_17.miny <= _loc_10.maxy)
                    {
                    }
                    if (_loc_10.miny <= _loc_17.maxy)
                    {
                    }
                    if (_loc_17.minx <= _loc_10.maxx)
                    {
                    }
                    if (_loc_10.minx <= _loc_17.maxx)
                    {
                        if (_loc_8.child1 != null)
                        {
                            _loc_8.child1.next = _loc_7;
                            _loc_7 = _loc_8.child1;
                        }
                        if (_loc_8.child2 != null)
                        {
                            _loc_8.child2.next = _loc_7;
                            _loc_7 = _loc_8.child2;
                        }
                    }
                }
            }
            _loc_42 = null;
            _loc_44 = pairs;
            while (_loc_44 != null)
            {
                
                if (!_loc_44.first)
                {
                    _loc_10 = _loc_44.n1.aabb;
                    _loc_17 = _loc_44.n2.aabb;
                    if (_loc_17.miny <= _loc_10.maxy)
                    {
                    }
                    if (_loc_10.miny <= _loc_17.maxy)
                    {
                    }
                    if (_loc_17.minx <= _loc_10.maxx)
                    {
                    }
                }
                if (_loc_10.minx > _loc_17.maxx)
                {
                    if (_loc_42 == null)
                    {
                        pairs = _loc_44.next;
                    }
                    else
                    {
                        _loc_42.next = _loc_44.next;
                    }
                    _loc_45 = _loc_44.n1.shape.pairs;
                    _loc_43 = null;
                    _loc_46 = _loc_45.head;
                    _loc_31 = false;
                    while (_loc_46 != null)
                    {
                        
                        if (_loc_46.elt == _loc_44)
                        {
                            if (_loc_43 == null)
                            {
                                _loc_47 = _loc_45.head;
                                _loc_48 = _loc_47.next;
                                _loc_45.head = _loc_48;
                                if (_loc_45.head == null)
                                {
                                    _loc_45.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_47 = _loc_43.next;
                                _loc_48 = _loc_47.next;
                                _loc_43.next = _loc_48;
                                if (_loc_48 == null)
                                {
                                    _loc_45.pushmod = true;
                                }
                            }
                            _loc_49 = _loc_47;
                            _loc_49.elt = null;
                            _loc_49.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                            ZNPNode_ZPP_AABBPair.zpp_pool = _loc_49;
                            _loc_45.modified = true;
                            (_loc_45.length - 1);
                            _loc_45.pushmod = true;
                            _loc_31 = true;
                            break;
                        }
                        _loc_43 = _loc_46;
                        _loc_46 = _loc_46.next;
                    }
                    _loc_45 = _loc_44.n2.shape.pairs;
                    _loc_43 = null;
                    _loc_46 = _loc_45.head;
                    _loc_31 = false;
                    while (_loc_46 != null)
                    {
                        
                        if (_loc_46.elt == _loc_44)
                        {
                            if (_loc_43 == null)
                            {
                                _loc_47 = _loc_45.head;
                                _loc_48 = _loc_47.next;
                                _loc_45.head = _loc_48;
                                if (_loc_45.head == null)
                                {
                                    _loc_45.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_47 = _loc_43.next;
                                _loc_48 = _loc_47.next;
                                _loc_43.next = _loc_48;
                                if (_loc_48 == null)
                                {
                                    _loc_45.pushmod = true;
                                }
                            }
                            _loc_49 = _loc_47;
                            _loc_49.elt = null;
                            _loc_49.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                            ZNPNode_ZPP_AABBPair.zpp_pool = _loc_49;
                            _loc_45.modified = true;
                            (_loc_45.length - 1);
                            _loc_45.pushmod = true;
                            _loc_31 = true;
                            break;
                        }
                        _loc_43 = _loc_46;
                        _loc_46 = _loc_46.next;
                    }
                    _loc_50 = _loc_44.next;
                    if (_loc_44.arb != null)
                    {
                        _loc_44.arb.pair = null;
                    }
                    _loc_44.arb = null;
                    _loc_51 = _loc_44;
                    _loc_6 = null;
                    _loc_51.n2 = _loc_6;
                    _loc_51.n1 = _loc_6;
                    _loc_51.sleeping = false;
                    _loc_51.next = ZPP_AABBPair.zpp_pool;
                    ZPP_AABBPair.zpp_pool = _loc_51;
                    _loc_44 = _loc_50;
                    continue;
                }
                _loc_4 = _loc_44.n1.shape;
                _loc_30 = _loc_4.body;
                _loc_40 = _loc_44.n2.shape;
                _loc_52 = _loc_40.body;
                if (!_loc_44.first)
                {
                    if (!_loc_30.component.sleeping)
                    {
                    }
                    if (_loc_30.type == ZPP_Flags.id_BodyType_STATIC)
                    {
                        if (!_loc_52.component.sleeping)
                        {
                        }
                    }
                    if (_loc_52.type == ZPP_Flags.id_BodyType_STATIC)
                    {
                        _loc_44.sleeping = true;
                        if (_loc_42 == null)
                        {
                            pairs = _loc_44.next;
                        }
                        else
                        {
                            _loc_42.next = _loc_44.next;
                        }
                        _loc_44 = _loc_44.next;
                        continue;
                    }
                }
                _loc_44.first = false;
                _loc_10 = _loc_4.aabb;
                _loc_17 = _loc_40.aabb;
                if (_loc_17.miny <= _loc_10.maxy)
                {
                }
                if (_loc_10.miny <= _loc_17.maxy)
                {
                }
                if (_loc_17.minx <= _loc_10.maxx)
                {
                }
                if (_loc_10.minx <= _loc_17.maxx)
                {
                    _loc_53 = _loc_44.arb;
                    if (param2)
                    {
                        if (_loc_30.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                        }
                        _loc_44.arb = param1.narrowPhase(_loc_4, _loc_40, _loc_52.type != ZPP_Flags.id_BodyType_DYNAMIC, _loc_44.arb, false);
                    }
                    else
                    {
                        if (_loc_30.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                        }
                        _loc_44.arb = param1.continuousEvent(_loc_4, _loc_40, _loc_52.type != ZPP_Flags.id_BodyType_DYNAMIC, _loc_44.arb, false);
                    }
                    if (_loc_44.arb == null)
                    {
                        if (_loc_53 != null)
                        {
                            _loc_53.pair = null;
                        }
                    }
                    else
                    {
                        _loc_44.arb.pair = _loc_44;
                    }
                }
                _loc_42 = _loc_44;
                _loc_44 = _loc_44.next;
            }
            return;
        }// end function

        override public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
        {
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as BodyList;
            var _loc_9:* = null as ZPP_AABBNode;
            var _loc_10:* = null as ZPP_AABB;
            var _loc_11:* = null as Body;
            var _loc_12:* = null as ZPP_InteractionFilter;
            sync_broadphase();
            var _loc_6:* = false;
            if (ZPP_Vec2.zpp_pool == null)
            {
                _loc_7 = new ZPP_Vec2();
            }
            else
            {
                _loc_7 = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7.next;
                _loc_7.next = null;
            }
            _loc_7.weak = false;
            _loc_7._immutable = _loc_6;
            _loc_7.x = param1;
            _loc_7.y = param2;
            var _loc_5:* = _loc_7;
            if (param4 == null)
            {
                _loc_8 = new BodyList();
            }
            else
            {
                _loc_8 = param4;
            }
            if (stree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(stree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_9 = treeStack.pop_unsafe();
                    _loc_10 = _loc_9.aabb;
                    if (_loc_5.x >= _loc_10.minx)
                    {
                    }
                    if (_loc_5.x <= _loc_10.maxx)
                    {
                    }
                    if (_loc_5.y >= _loc_10.miny)
                    {
                    }
                    if (_loc_5.y <= _loc_10.maxy)
                    {
                        if (_loc_9.child1 == null)
                        {
                            _loc_11 = _loc_9.shape.body.outer;
                            if (!_loc_8.has(_loc_11))
                            {
                                if (param3 != null)
                                {
                                    _loc_12 = _loc_9.shape.filter;
                                    if ((_loc_12.collisionMask & param3.collisionGroup) != 0)
                                    {
                                    }
                                }
                                if ((param3.collisionMask & _loc_12.collisionGroup) != 0)
                                {
                                    if (_loc_9.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                    {
                                        if (ZPP_Collide.circleContains(_loc_9.shape.circle, _loc_5))
                                        {
                                            _loc_8.push(_loc_11);
                                        }
                                    }
                                    else if (ZPP_Collide.polyContains(_loc_9.shape.polygon, _loc_5))
                                    {
                                        _loc_8.push(_loc_11);
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_9.child1 != null)
                        {
                            treeStack.add(_loc_9.child1);
                        }
                        if (_loc_9.child2 != null)
                        {
                            treeStack.add(_loc_9.child2);
                        }
                    }
                }
            }
            if (dtree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(dtree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_9 = treeStack.pop_unsafe();
                    _loc_10 = _loc_9.aabb;
                    if (_loc_5.x >= _loc_10.minx)
                    {
                    }
                    if (_loc_5.x <= _loc_10.maxx)
                    {
                    }
                    if (_loc_5.y >= _loc_10.miny)
                    {
                    }
                    if (_loc_5.y <= _loc_10.maxy)
                    {
                        if (_loc_9.child1 == null)
                        {
                            _loc_11 = _loc_9.shape.body.outer;
                            if (!_loc_8.has(_loc_11))
                            {
                                if (param3 != null)
                                {
                                    _loc_12 = _loc_9.shape.filter;
                                    if ((_loc_12.collisionMask & param3.collisionGroup) != 0)
                                    {
                                    }
                                }
                                if ((param3.collisionMask & _loc_12.collisionGroup) != 0)
                                {
                                    if (_loc_9.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                    {
                                        if (ZPP_Collide.circleContains(_loc_9.shape.circle, _loc_5))
                                        {
                                            _loc_8.push(_loc_11);
                                        }
                                    }
                                    else if (ZPP_Collide.polyContains(_loc_9.shape.polygon, _loc_5))
                                    {
                                        _loc_8.push(_loc_11);
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_9.child1 != null)
                        {
                            treeStack.add(_loc_9.child1);
                        }
                        if (_loc_9.child2 != null)
                        {
                            treeStack.add(_loc_9.child2);
                        }
                    }
                }
            }
            _loc_7 = _loc_5;
            if (_loc_7.outer != null)
            {
                _loc_7.outer.zpp_inner = null;
                _loc_7.outer = null;
            }
            _loc_7._isimmutable = null;
            _loc_7._validate = null;
            _loc_7._invalidate = null;
            _loc_7.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_7;
            return _loc_8;
        }// end function

        override public function bodiesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
        {
            var _loc_6:* = null as BodyList;
            var _loc_7:* = null as ZPP_AABBNode;
            var _loc_8:* = null as ZPP_AABB;
            var _loc_9:* = null as Body;
            var _loc_10:* = null as ZPP_InteractionFilter;
            var _loc_11:* = false;
            sync_broadphase();
            validateShape(param1);
            var _loc_5:* = param1.aabb;
            if (param4 == null)
            {
                _loc_6 = new BodyList();
            }
            else
            {
                _loc_6 = param4;
            }
            if (failed == null)
            {
                failed = new BodyList();
            }
            if (stree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(stree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_7 = treeStack.pop_unsafe();
                    _loc_8 = _loc_7.aabb;
                    if (_loc_5.miny <= _loc_8.maxy)
                    {
                    }
                    if (_loc_8.miny <= _loc_5.maxy)
                    {
                    }
                    if (_loc_5.minx <= _loc_8.maxx)
                    {
                    }
                    if (_loc_8.minx <= _loc_5.maxx)
                    {
                        if (_loc_7.child1 == null)
                        {
                            _loc_9 = _loc_7.shape.body.outer;
                            if (param3 != null)
                            {
                                _loc_10 = _loc_7.shape.filter;
                                if ((_loc_10.collisionMask & param3.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param3.collisionMask & _loc_10.collisionGroup) != 0)
                            {
                                if (param2)
                                {
                                    if (!failed.has(_loc_9))
                                    {
                                        _loc_11 = ZPP_Collide.containTest(param1, _loc_7.shape);
                                        if (!_loc_6.has(_loc_9))
                                        {
                                        }
                                        if (_loc_11)
                                        {
                                            _loc_6.push(_loc_9);
                                        }
                                        else if (!_loc_11)
                                        {
                                            _loc_6.remove(_loc_9);
                                            failed.push(_loc_9);
                                        }
                                    }
                                }
                                else
                                {
                                    if (!_loc_6.has(_loc_9))
                                    {
                                    }
                                    if (ZPP_Collide.testCollide_safe(_loc_7.shape, param1))
                                    {
                                        _loc_6.push(_loc_9);
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_7.child1 != null)
                        {
                            treeStack.add(_loc_7.child1);
                        }
                        if (_loc_7.child2 != null)
                        {
                            treeStack.add(_loc_7.child2);
                        }
                    }
                }
            }
            if (dtree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(dtree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_7 = treeStack.pop_unsafe();
                    _loc_8 = _loc_7.aabb;
                    if (_loc_5.miny <= _loc_8.maxy)
                    {
                    }
                    if (_loc_8.miny <= _loc_5.maxy)
                    {
                    }
                    if (_loc_5.minx <= _loc_8.maxx)
                    {
                    }
                    if (_loc_8.minx <= _loc_5.maxx)
                    {
                        if (_loc_7.child1 == null)
                        {
                            _loc_9 = _loc_7.shape.body.outer;
                            if (param3 != null)
                            {
                                _loc_10 = _loc_7.shape.filter;
                                if ((_loc_10.collisionMask & param3.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param3.collisionMask & _loc_10.collisionGroup) != 0)
                            {
                                if (param2)
                                {
                                    if (!failed.has(_loc_9))
                                    {
                                        _loc_11 = ZPP_Collide.containTest(param1, _loc_7.shape);
                                        if (!_loc_6.has(_loc_9))
                                        {
                                        }
                                        if (_loc_11)
                                        {
                                            _loc_6.push(_loc_9);
                                        }
                                        else if (!_loc_11)
                                        {
                                            _loc_6.remove(_loc_9);
                                            failed.push(_loc_9);
                                        }
                                    }
                                }
                                else
                                {
                                    if (!_loc_6.has(_loc_9))
                                    {
                                    }
                                    if (ZPP_Collide.testCollide_safe(_loc_7.shape, param1))
                                    {
                                        _loc_6.push(_loc_9);
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_7.child1 != null)
                        {
                            treeStack.add(_loc_7.child1);
                        }
                        if (_loc_7.child2 != null)
                        {
                            treeStack.add(_loc_7.child2);
                        }
                    }
                }
            }
            failed.clear();
            return _loc_6;
        }// end function

        override public function bodiesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:BodyList) : BodyList
        {
            var _loc_8:* = null as BodyList;
            var _loc_9:* = null as ZPP_AABBNode;
            var _loc_10:* = null as ZPP_AABB;
            var _loc_11:* = null as Body;
            var _loc_12:* = null as ZPP_InteractionFilter;
            var _loc_13:* = false;
            sync_broadphase();
            updateCircShape(param1, param2, param3);
            var _loc_7:* = circShape.zpp_inner.aabb;
            if (param6 == null)
            {
                _loc_8 = new BodyList();
            }
            else
            {
                _loc_8 = param6;
            }
            if (failed == null)
            {
                failed = new BodyList();
            }
            if (stree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(stree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_9 = treeStack.pop_unsafe();
                    _loc_10 = _loc_9.aabb;
                    if (_loc_7.miny <= _loc_10.maxy)
                    {
                    }
                    if (_loc_10.miny <= _loc_7.maxy)
                    {
                    }
                    if (_loc_7.minx <= _loc_10.maxx)
                    {
                    }
                    if (_loc_10.minx <= _loc_7.maxx)
                    {
                        if (_loc_9.child1 == null)
                        {
                            _loc_11 = _loc_9.shape.body.outer;
                            if (param5 != null)
                            {
                                _loc_12 = _loc_9.shape.filter;
                                if ((_loc_12.collisionMask & param5.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param5.collisionMask & _loc_12.collisionGroup) != 0)
                            {
                                if (param4)
                                {
                                    if (!failed.has(_loc_11))
                                    {
                                        _loc_13 = ZPP_Collide.containTest(circShape.zpp_inner, _loc_9.shape);
                                        if (!_loc_8.has(_loc_11))
                                        {
                                        }
                                        if (_loc_13)
                                        {
                                            _loc_8.push(_loc_11);
                                        }
                                        else if (!_loc_13)
                                        {
                                            _loc_8.remove(_loc_11);
                                            failed.push(_loc_11);
                                        }
                                    }
                                }
                                else
                                {
                                    if (!_loc_8.has(_loc_11))
                                    {
                                    }
                                    if (ZPP_Collide.testCollide_safe(_loc_9.shape, circShape.zpp_inner))
                                    {
                                        _loc_8.push(_loc_11);
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_9.child1 != null)
                        {
                            treeStack.add(_loc_9.child1);
                        }
                        if (_loc_9.child2 != null)
                        {
                            treeStack.add(_loc_9.child2);
                        }
                    }
                }
            }
            if (dtree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(dtree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_9 = treeStack.pop_unsafe();
                    _loc_10 = _loc_9.aabb;
                    if (_loc_7.miny <= _loc_10.maxy)
                    {
                    }
                    if (_loc_10.miny <= _loc_7.maxy)
                    {
                    }
                    if (_loc_7.minx <= _loc_10.maxx)
                    {
                    }
                    if (_loc_10.minx <= _loc_7.maxx)
                    {
                        if (_loc_9.child1 == null)
                        {
                            _loc_11 = _loc_9.shape.body.outer;
                            if (param5 != null)
                            {
                                _loc_12 = _loc_9.shape.filter;
                                if ((_loc_12.collisionMask & param5.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param5.collisionMask & _loc_12.collisionGroup) != 0)
                            {
                                if (param4)
                                {
                                    if (!failed.has(_loc_11))
                                    {
                                        _loc_13 = ZPP_Collide.containTest(circShape.zpp_inner, _loc_9.shape);
                                        if (!_loc_8.has(_loc_11))
                                        {
                                        }
                                        if (_loc_13)
                                        {
                                            _loc_8.push(_loc_11);
                                        }
                                        else if (!_loc_13)
                                        {
                                            _loc_8.remove(_loc_11);
                                            failed.push(_loc_11);
                                        }
                                    }
                                }
                                else
                                {
                                    if (!_loc_8.has(_loc_11))
                                    {
                                    }
                                    if (ZPP_Collide.testCollide_safe(_loc_9.shape, circShape.zpp_inner))
                                    {
                                        _loc_8.push(_loc_11);
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_9.child1 != null)
                        {
                            treeStack.add(_loc_9.child1);
                        }
                        if (_loc_9.child2 != null)
                        {
                            treeStack.add(_loc_9.child2);
                        }
                    }
                }
            }
            failed.clear();
            return _loc_8;
        }// end function

        override public function bodiesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:BodyList) : BodyList
        {
            var _loc_7:* = null as BodyList;
            var _loc_8:* = null as ZPP_AABBNode;
            var _loc_9:* = null as ZPP_AABB;
            var _loc_10:* = null as ZPP_InteractionFilter;
            var _loc_11:* = null as Body;
            var _loc_12:* = null as ZPP_AABBNode;
            var _loc_13:* = false;
            sync_broadphase();
            updateAABBShape(param1);
            var _loc_6:* = aabbShape.zpp_inner.aabb;
            if (param5 == null)
            {
                _loc_7 = new BodyList();
            }
            else
            {
                _loc_7 = param5;
            }
            if (failed == null)
            {
                failed = new BodyList();
            }
            if (stree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(stree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_8 = treeStack.pop_unsafe();
                    _loc_9 = _loc_8.aabb;
                    if (_loc_9.minx >= _loc_6.minx)
                    {
                    }
                    if (_loc_9.miny >= _loc_6.miny)
                    {
                    }
                    if (_loc_9.maxx <= _loc_6.maxx)
                    {
                    }
                    if (_loc_9.maxy <= _loc_6.maxy)
                    {
                        if (_loc_8.child1 == null)
                        {
                            if (param4 != null)
                            {
                                _loc_10 = _loc_8.shape.filter;
                                if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                            {
                                _loc_11 = _loc_8.shape.body.outer;
                                if (!_loc_7.has(_loc_11))
                                {
                                    _loc_7.push(_loc_11);
                                }
                            }
                        }
                        else
                        {
                            if (treeStack2 == null)
                            {
                                treeStack2 = new ZNPList_ZPP_AABBNode();
                            }
                            treeStack2.add(_loc_8);
                            while (treeStack2.head != null)
                            {
                                
                                _loc_12 = treeStack2.pop_unsafe();
                                if (_loc_12.child1 == null)
                                {
                                    if (param4 != null)
                                    {
                                        _loc_10 = _loc_12.shape.filter;
                                        if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                        {
                                        }
                                    }
                                    if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                                    {
                                        _loc_11 = _loc_12.shape.body.outer;
                                        if (!_loc_7.has(_loc_11))
                                        {
                                            _loc_7.push(_loc_11);
                                        }
                                    }
                                    continue;
                                }
                                if (_loc_12.child1 != null)
                                {
                                    treeStack2.add(_loc_12.child1);
                                }
                                if (_loc_12.child2 != null)
                                {
                                    treeStack2.add(_loc_12.child2);
                                }
                            }
                        }
                        continue;
                    }
                    _loc_9 = _loc_8.aabb;
                    if (_loc_6.miny <= _loc_9.maxy)
                    {
                    }
                    if (_loc_9.miny <= _loc_6.maxy)
                    {
                    }
                    if (_loc_6.minx <= _loc_9.maxx)
                    {
                    }
                    if (_loc_9.minx <= _loc_6.maxx)
                    {
                        if (_loc_8.child1 == null)
                        {
                            _loc_11 = _loc_8.shape.body.outer;
                            if (param4 != null)
                            {
                                _loc_10 = _loc_8.shape.filter;
                                if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                            {
                                if (param2)
                                {
                                    if (param3)
                                    {
                                        if (!failed.has(_loc_11))
                                        {
                                            _loc_13 = ZPP_Collide.containTest(aabbShape.zpp_inner, _loc_8.shape);
                                            if (!_loc_7.has(_loc_11))
                                            {
                                            }
                                            if (_loc_13)
                                            {
                                                _loc_7.push(_loc_11);
                                            }
                                            else if (!_loc_13)
                                            {
                                                _loc_7.remove(_loc_11);
                                                failed.push(_loc_11);
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (!_loc_7.has(_loc_11))
                                        {
                                        }
                                        if (ZPP_Collide.testCollide_safe(_loc_8.shape, aabbShape.zpp_inner))
                                        {
                                            _loc_7.push(_loc_11);
                                        }
                                    }
                                }
                                else if (param3)
                                {
                                    if (!failed.has(_loc_11))
                                    {
                                        _loc_9 = _loc_8.shape.aabb;
                                        if (_loc_9.minx >= _loc_6.minx)
                                        {
                                        }
                                        if (_loc_9.miny >= _loc_6.miny)
                                        {
                                        }
                                        if (_loc_9.maxx <= _loc_6.maxx)
                                        {
                                        }
                                        _loc_13 = _loc_9.maxy <= _loc_6.maxy;
                                        if (!_loc_7.has(_loc_11))
                                        {
                                        }
                                        if (_loc_13)
                                        {
                                            _loc_7.push(_loc_11);
                                        }
                                        else if (!_loc_13)
                                        {
                                            _loc_7.remove(_loc_11);
                                            failed.push(_loc_11);
                                        }
                                    }
                                }
                                else
                                {
                                    if (!_loc_7.has(_loc_11))
                                    {
                                        _loc_9 = _loc_8.shape.aabb;
                                        if (_loc_9.minx >= _loc_6.minx)
                                        {
                                        }
                                        if (_loc_9.miny >= _loc_6.miny)
                                        {
                                        }
                                        if (_loc_9.maxx <= _loc_6.maxx)
                                        {
                                        }
                                    }
                                    if (_loc_9.maxy <= _loc_6.maxy)
                                    {
                                        _loc_7.push(_loc_11);
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_8.child1 != null)
                        {
                            treeStack.add(_loc_8.child1);
                        }
                        if (_loc_8.child2 != null)
                        {
                            treeStack.add(_loc_8.child2);
                        }
                    }
                }
            }
            if (dtree.root != null)
            {
                if (treeStack == null)
                {
                    treeStack = new ZNPList_ZPP_AABBNode();
                }
                treeStack.add(dtree.root);
                while (treeStack.head != null)
                {
                    
                    _loc_8 = treeStack.pop_unsafe();
                    _loc_9 = _loc_8.aabb;
                    if (_loc_9.minx >= _loc_6.minx)
                    {
                    }
                    if (_loc_9.miny >= _loc_6.miny)
                    {
                    }
                    if (_loc_9.maxx <= _loc_6.maxx)
                    {
                    }
                    if (_loc_9.maxy <= _loc_6.maxy)
                    {
                        if (_loc_8.child1 == null)
                        {
                            if (param4 != null)
                            {
                                _loc_10 = _loc_8.shape.filter;
                                if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                            {
                                _loc_11 = _loc_8.shape.body.outer;
                                if (!_loc_7.has(_loc_11))
                                {
                                    _loc_7.push(_loc_11);
                                }
                            }
                        }
                        else
                        {
                            if (treeStack2 == null)
                            {
                                treeStack2 = new ZNPList_ZPP_AABBNode();
                            }
                            treeStack2.add(_loc_8);
                            while (treeStack2.head != null)
                            {
                                
                                _loc_12 = treeStack2.pop_unsafe();
                                if (_loc_12.child1 == null)
                                {
                                    if (param4 != null)
                                    {
                                        _loc_10 = _loc_12.shape.filter;
                                        if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                        {
                                        }
                                    }
                                    if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                                    {
                                        _loc_11 = _loc_12.shape.body.outer;
                                        if (!_loc_7.has(_loc_11))
                                        {
                                            _loc_7.push(_loc_11);
                                        }
                                    }
                                    continue;
                                }
                                if (_loc_12.child1 != null)
                                {
                                    treeStack2.add(_loc_12.child1);
                                }
                                if (_loc_12.child2 != null)
                                {
                                    treeStack2.add(_loc_12.child2);
                                }
                            }
                        }
                        continue;
                    }
                    _loc_9 = _loc_8.aabb;
                    if (_loc_6.miny <= _loc_9.maxy)
                    {
                    }
                    if (_loc_9.miny <= _loc_6.maxy)
                    {
                    }
                    if (_loc_6.minx <= _loc_9.maxx)
                    {
                    }
                    if (_loc_9.minx <= _loc_6.maxx)
                    {
                        if (_loc_8.child1 == null)
                        {
                            _loc_11 = _loc_8.shape.body.outer;
                            if (param4 != null)
                            {
                                _loc_10 = _loc_8.shape.filter;
                                if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                                {
                                }
                            }
                            if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                            {
                                if (param2)
                                {
                                    if (param3)
                                    {
                                        if (!failed.has(_loc_11))
                                        {
                                            _loc_13 = ZPP_Collide.containTest(aabbShape.zpp_inner, _loc_8.shape);
                                            if (!_loc_7.has(_loc_11))
                                            {
                                            }
                                            if (_loc_13)
                                            {
                                                _loc_7.push(_loc_11);
                                            }
                                            else if (!_loc_13)
                                            {
                                                _loc_7.remove(_loc_11);
                                                failed.push(_loc_11);
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (!_loc_7.has(_loc_11))
                                        {
                                        }
                                        if (ZPP_Collide.testCollide_safe(_loc_8.shape, aabbShape.zpp_inner))
                                        {
                                            _loc_7.push(_loc_11);
                                        }
                                    }
                                }
                                else if (param3)
                                {
                                    if (!failed.has(_loc_11))
                                    {
                                        _loc_9 = _loc_8.shape.aabb;
                                        if (_loc_9.minx >= _loc_6.minx)
                                        {
                                        }
                                        if (_loc_9.miny >= _loc_6.miny)
                                        {
                                        }
                                        if (_loc_9.maxx <= _loc_6.maxx)
                                        {
                                        }
                                        _loc_13 = _loc_9.maxy <= _loc_6.maxy;
                                        if (!_loc_7.has(_loc_11))
                                        {
                                        }
                                        if (_loc_13)
                                        {
                                            _loc_7.push(_loc_11);
                                        }
                                        else if (!_loc_13)
                                        {
                                            _loc_7.remove(_loc_11);
                                            failed.push(_loc_11);
                                        }
                                    }
                                }
                                else
                                {
                                    if (!_loc_7.has(_loc_11))
                                    {
                                        _loc_9 = _loc_8.shape.aabb;
                                        if (_loc_9.minx >= _loc_6.minx)
                                        {
                                        }
                                        if (_loc_9.miny >= _loc_6.miny)
                                        {
                                        }
                                        if (_loc_9.maxx <= _loc_6.maxx)
                                        {
                                        }
                                    }
                                    if (_loc_9.maxy <= _loc_6.maxy)
                                    {
                                        _loc_7.push(_loc_11);
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_8.child1 != null)
                        {
                            treeStack.add(_loc_8.child1);
                        }
                        if (_loc_8.child2 != null)
                        {
                            treeStack.add(_loc_8.child2);
                        }
                    }
                }
            }
            failed.clear();
            return _loc_7;
        }// end function

        public function __sync(param1:ZPP_Shape) : void
        {
            var _loc_3:* = null as ZPP_Circle;
            var _loc_4:* = null as ZPP_Polygon;
            var _loc_5:* = NaN;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Body;
            var _loc_13:* = false;
            var _loc_14:* = null as ZPP_AABB;
            var _loc_15:* = null as ZPP_AABB;
            var _loc_2:* = param1.node;
            if (!_loc_2.synced)
            {
                if (!space.continuous)
                {
                    if (param1.zip_aabb)
                    {
                        if (param1.body != null)
                        {
                            param1.zip_aabb = false;
                            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_3 = param1.circle;
                                if (_loc_3.zip_worldCOM)
                                {
                                    if (_loc_3.body != null)
                                    {
                                        _loc_3.zip_worldCOM = false;
                                        if (_loc_3.zip_localCOM)
                                        {
                                            _loc_3.zip_localCOM = false;
                                            if (_loc_3.type == ZPP_Flags.id_ShapeType_POLYGON)
                                            {
                                                _loc_4 = _loc_3.polygon;
                                                if (_loc_4.lverts.next == null)
                                                {
                                                    throw "Error: An empty polygon has no meaningful localCOM";
                                                }
                                                if (_loc_4.lverts.next.next == null)
                                                {
                                                    _loc_4.localCOMx = _loc_4.lverts.next.x;
                                                    _loc_4.localCOMy = _loc_4.lverts.next.y;
                                                }
                                                else if (_loc_4.lverts.next.next.next == null)
                                                {
                                                    _loc_4.localCOMx = _loc_4.lverts.next.x;
                                                    _loc_4.localCOMy = _loc_4.lverts.next.y;
                                                    _loc_5 = 1;
                                                    _loc_4.localCOMx = _loc_4.localCOMx + _loc_4.lverts.next.next.x * _loc_5;
                                                    _loc_4.localCOMy = _loc_4.localCOMy + _loc_4.lverts.next.next.y * _loc_5;
                                                    _loc_5 = 0.5;
                                                    _loc_4.localCOMx = _loc_4.localCOMx * _loc_5;
                                                    _loc_4.localCOMy = _loc_4.localCOMy * _loc_5;
                                                }
                                                else
                                                {
                                                    _loc_4.localCOMx = 0;
                                                    _loc_4.localCOMy = 0;
                                                    _loc_5 = 0;
                                                    _loc_6 = _loc_4.lverts.next;
                                                    _loc_7 = _loc_6;
                                                    _loc_6 = _loc_6.next;
                                                    _loc_8 = _loc_6;
                                                    _loc_6 = _loc_6.next;
                                                    while (_loc_6 != null)
                                                    {
                                                        
                                                        _loc_9 = _loc_6;
                                                        _loc_5 = _loc_5 + _loc_8.x * (_loc_9.y - _loc_7.y);
                                                        _loc_10 = _loc_9.y * _loc_8.x - _loc_9.x * _loc_8.y;
                                                        _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_9.x) * _loc_10;
                                                        _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_9.y) * _loc_10;
                                                        _loc_7 = _loc_8;
                                                        _loc_8 = _loc_9;
                                                        _loc_6 = _loc_6.next;
                                                    }
                                                    _loc_6 = _loc_4.lverts.next;
                                                    _loc_9 = _loc_6;
                                                    _loc_5 = _loc_5 + _loc_8.x * (_loc_9.y - _loc_7.y);
                                                    _loc_10 = _loc_9.y * _loc_8.x - _loc_9.x * _loc_8.y;
                                                    _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_9.x) * _loc_10;
                                                    _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_9.y) * _loc_10;
                                                    _loc_7 = _loc_8;
                                                    _loc_8 = _loc_9;
                                                    _loc_6 = _loc_6.next;
                                                    _loc_11 = _loc_6;
                                                    _loc_5 = _loc_5 + _loc_8.x * (_loc_11.y - _loc_7.y);
                                                    _loc_10 = _loc_11.y * _loc_8.x - _loc_11.x * _loc_8.y;
                                                    _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_11.x) * _loc_10;
                                                    _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_11.y) * _loc_10;
                                                    _loc_5 = 1 / (3 * _loc_5);
                                                    _loc_10 = _loc_5;
                                                    _loc_4.localCOMx = _loc_4.localCOMx * _loc_10;
                                                    _loc_4.localCOMy = _loc_4.localCOMy * _loc_10;
                                                }
                                            }
                                            if (_loc_3.wrap_localCOM != null)
                                            {
                                                _loc_3.wrap_localCOM.zpp_inner.x = _loc_3.localCOMx;
                                                _loc_3.wrap_localCOM.zpp_inner.y = _loc_3.localCOMy;
                                            }
                                        }
                                        _loc_12 = _loc_3.body;
                                        if (_loc_12.zip_axis)
                                        {
                                            _loc_12.zip_axis = false;
                                            _loc_12.axisx = Math.sin(_loc_12.rot);
                                            _loc_12.axisy = Math.cos(_loc_12.rot);
                                        }
                                        _loc_3.worldCOMx = _loc_3.body.posx + (_loc_3.body.axisy * _loc_3.localCOMx - _loc_3.body.axisx * _loc_3.localCOMy);
                                        _loc_3.worldCOMy = _loc_3.body.posy + (_loc_3.localCOMx * _loc_3.body.axisx + _loc_3.localCOMy * _loc_3.body.axisy);
                                    }
                                }
                                _loc_5 = _loc_3.radius;
                                _loc_10 = _loc_3.radius;
                                _loc_3.aabb.minx = _loc_3.worldCOMx - _loc_5;
                                _loc_3.aabb.miny = _loc_3.worldCOMy - _loc_10;
                                _loc_3.aabb.maxx = _loc_3.worldCOMx + _loc_5;
                                _loc_3.aabb.maxy = _loc_3.worldCOMy + _loc_10;
                            }
                            else
                            {
                                _loc_4 = param1.polygon;
                                if (_loc_4.zip_gverts)
                                {
                                    if (_loc_4.body != null)
                                    {
                                        _loc_4.zip_gverts = false;
                                        _loc_4.validate_lverts();
                                        _loc_12 = _loc_4.body;
                                        if (_loc_12.zip_axis)
                                        {
                                            _loc_12.zip_axis = false;
                                            _loc_12.axisx = Math.sin(_loc_12.rot);
                                            _loc_12.axisy = Math.cos(_loc_12.rot);
                                        }
                                        _loc_6 = _loc_4.lverts.next;
                                        _loc_7 = _loc_4.gverts.next;
                                        while (_loc_7 != null)
                                        {
                                            
                                            _loc_8 = _loc_7;
                                            _loc_9 = _loc_6;
                                            _loc_6 = _loc_6.next;
                                            _loc_8.x = _loc_4.body.posx + (_loc_4.body.axisy * _loc_9.x - _loc_4.body.axisx * _loc_9.y);
                                            _loc_8.y = _loc_4.body.posy + (_loc_9.x * _loc_4.body.axisx + _loc_9.y * _loc_4.body.axisy);
                                            _loc_7 = _loc_7.next;
                                        }
                                    }
                                }
                                if (_loc_4.lverts.next == null)
                                {
                                    throw "Error: An empty polygon has no meaningful bounds";
                                }
                                _loc_6 = _loc_4.gverts.next;
                                _loc_4.aabb.minx = _loc_6.x;
                                _loc_4.aabb.miny = _loc_6.y;
                                _loc_4.aabb.maxx = _loc_6.x;
                                _loc_4.aabb.maxy = _loc_6.y;
                                _loc_7 = _loc_4.gverts.next.next;
                                while (_loc_7 != null)
                                {
                                    
                                    _loc_8 = _loc_7;
                                    if (_loc_8.x < _loc_4.aabb.minx)
                                    {
                                        _loc_4.aabb.minx = _loc_8.x;
                                    }
                                    if (_loc_8.x > _loc_4.aabb.maxx)
                                    {
                                        _loc_4.aabb.maxx = _loc_8.x;
                                    }
                                    if (_loc_8.y < _loc_4.aabb.miny)
                                    {
                                        _loc_4.aabb.miny = _loc_8.y;
                                    }
                                    if (_loc_8.y > _loc_4.aabb.maxy)
                                    {
                                        _loc_4.aabb.maxy = _loc_8.y;
                                    }
                                    _loc_7 = _loc_7.next;
                                }
                            }
                        }
                    }
                }
                if (_loc_2.dyn == (param1.body.type == ZPP_Flags.id_BodyType_STATIC ? (false) : (!param1.body.component.sleeping)))
                {
                    _loc_14 = _loc_2.aabb;
                    _loc_15 = param1.aabb;
                    if (_loc_15.minx >= _loc_14.minx)
                    {
                    }
                    if (_loc_15.miny >= _loc_14.miny)
                    {
                    }
                    if (_loc_15.maxx <= _loc_14.maxx)
                    {
                    }
                }
                _loc_13 = _loc_15.maxy > _loc_14.maxy;
                if (_loc_13)
                {
                    _loc_2.synced = true;
                    _loc_2.snext = syncs;
                    syncs = _loc_2;
                }
            }
            return;
        }// end function

        public function __remove(param1:ZPP_Shape) : void
        {
            var _loc_3:* = null as ZPP_AABBNode;
            var _loc_4:* = null as ZPP_AABBNode;
            var _loc_7:* = null as ZPP_AABBPair;
            var _loc_8:* = null as ZPP_AABBPair;
            var _loc_2:* = param1.node;
            if (!_loc_2.first_sync)
            {
                if (_loc_2.dyn)
                {
                    dtree.removeLeaf(_loc_2);
                }
                else
                {
                    stree.removeLeaf(_loc_2);
                }
            }
            param1.node = null;
            if (_loc_2.synced)
            {
                _loc_3 = null;
                _loc_4 = syncs;
                while (_loc_4 != null)
                {
                    
                    if (_loc_4 == _loc_2)
                    {
                        break;
                    }
                    _loc_3 = _loc_4;
                    _loc_4 = _loc_4.snext;
                }
                if (_loc_3 == null)
                {
                    syncs = _loc_4.snext;
                }
                else
                {
                    _loc_3.snext = _loc_4.snext;
                }
                _loc_4.snext = null;
                _loc_2.synced = false;
            }
            if (_loc_2.moved)
            {
                _loc_3 = null;
                _loc_4 = moves;
                while (_loc_4 != null)
                {
                    
                    if (_loc_4 == _loc_2)
                    {
                        break;
                    }
                    _loc_3 = _loc_4;
                    _loc_4 = _loc_4.mnext;
                }
                if (_loc_3 == null)
                {
                    moves = _loc_4.mnext;
                }
                else
                {
                    _loc_3.mnext = _loc_4.mnext;
                }
                _loc_4.mnext = null;
                _loc_2.moved = false;
            }
            var _loc_5:* = null;
            var _loc_6:* = pairs;
            while (_loc_6 != null)
            {
                
                _loc_7 = _loc_6.next;
                if (_loc_6.n1 != _loc_2)
                {
                }
                if (_loc_6.n2 == _loc_2)
                {
                    if (_loc_5 == null)
                    {
                        pairs = _loc_7;
                    }
                    else
                    {
                        _loc_5.next = _loc_7;
                    }
                    if (_loc_6.arb != null)
                    {
                        _loc_6.arb.pair = null;
                    }
                    _loc_6.arb = null;
                    _loc_6.n1.shape.pairs.remove(_loc_6);
                    _loc_6.n2.shape.pairs.remove(_loc_6);
                    _loc_8 = _loc_6;
                    _loc_3 = null;
                    _loc_8.n2 = _loc_3;
                    _loc_8.n1 = _loc_3;
                    _loc_8.sleeping = false;
                    _loc_8.next = ZPP_AABBPair.zpp_pool;
                    ZPP_AABBPair.zpp_pool = _loc_8;
                    _loc_6 = _loc_7;
                    continue;
                }
                _loc_5 = _loc_6;
                _loc_6 = _loc_7;
            }
            while (param1.pairs.head != null)
            {
                
                _loc_7 = param1.pairs.pop_unsafe();
                if (_loc_7.n1 == _loc_2)
                {
                    _loc_7.n2.shape.pairs.remove(_loc_7);
                }
                else
                {
                    _loc_7.n1.shape.pairs.remove(_loc_7);
                }
                if (_loc_7.arb != null)
                {
                    _loc_7.arb.pair = null;
                }
                _loc_7.arb = null;
                _loc_8 = _loc_7;
                _loc_3 = null;
                _loc_8.n2 = _loc_3;
                _loc_8.n1 = _loc_3;
                _loc_8.sleeping = false;
                _loc_8.next = ZPP_AABBPair.zpp_pool;
                ZPP_AABBPair.zpp_pool = _loc_8;
            }
            _loc_3 = _loc_2;
            _loc_3.height = -1;
            var _loc_9:* = _loc_3.aabb;
            if (_loc_9.outer != null)
            {
                _loc_9.outer.zpp_inner = null;
                _loc_9.outer = null;
            }
            var _loc_10:* = null;
            _loc_9.wrap_max = null;
            _loc_9.wrap_min = _loc_10;
            _loc_9._invalidate = null;
            _loc_9._validate = null;
            _loc_9.next = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc_9;
            _loc_4 = null;
            _loc_3.parent = _loc_4;
            _loc_4 = _loc_4;
            _loc_3.child2 = _loc_4;
            _loc_3.child1 = _loc_4;
            _loc_3.next = null;
            _loc_3.snext = null;
            _loc_3.mnext = null;
            _loc_3.next = ZPP_AABBNode.zpp_pool;
            ZPP_AABBNode.zpp_pool = _loc_3;
            return;
        }// end function

        public function __insert(param1:ZPP_Shape) : void
        {
            var _loc_2:* = null as ZPP_AABBNode;
            if (ZPP_AABBNode.zpp_pool == null)
            {
                _loc_2 = new ZPP_AABBNode();
            }
            else
            {
                _loc_2 = ZPP_AABBNode.zpp_pool;
                ZPP_AABBNode.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_2.aabb = new ZPP_AABB();
            }
            else
            {
                _loc_2.aabb = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_2.aabb.next;
                _loc_2.aabb.next = null;
            }
            _loc_2.moved = false;
            _loc_2.synced = false;
            _loc_2.first_sync = false;
            _loc_2.shape = param1;
            param1.node = _loc_2;
            _loc_2.synced = true;
            _loc_2.first_sync = true;
            _loc_2.snext = syncs;
            syncs = _loc_2;
            return;
        }// end function

    }
}
