package zpp_nape.space
{
    import flash.*;
    import nape.geom.*;
    import zpp_nape.geom.*;
    import zpp_nape.shape.*;

    public class ZPP_AABBTree extends Object
    {
        public var root:ZPP_AABBNode;
        public static var init__:Boolean;
        public static var tmpaabb:ZPP_AABB;

        public function ZPP_AABBTree() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            root = null;
            return;
        }// end function

        public function removeLeaf(param1:ZPP_AABBNode) : void
        {
            var _loc_2:* = null as ZPP_AABBNode;
            var _loc_3:* = null as ZPP_AABBNode;
            var _loc_4:* = null as ZPP_AABBNode;
            var _loc_5:* = null as ZPP_AABBNode;
            var _loc_6:* = null as ZPP_AABB;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_AABBNode;
            var _loc_9:* = null as ZPP_AABBNode;
            var _loc_10:* = 0;
            var _loc_11:* = null as ZPP_AABBNode;
            var _loc_12:* = null as ZPP_AABBNode;
            var _loc_13:* = null as ZPP_AABB;
            var _loc_14:* = null as ZPP_AABB;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            if (param1 == root)
            {
                root = null;
            }
            else
            {
                _loc_2 = param1.parent;
                _loc_3 = _loc_2.parent;
                if (_loc_2.child1 == param1)
                {
                    _loc_4 = _loc_2.child2;
                }
                else
                {
                    _loc_4 = _loc_2.child1;
                }
                if (_loc_3 != null)
                {
                    if (_loc_3.child1 == _loc_2)
                    {
                        _loc_3.child1 = _loc_4;
                    }
                    else
                    {
                        _loc_3.child2 = _loc_4;
                    }
                    _loc_4.parent = _loc_3;
                    _loc_5 = _loc_2;
                    _loc_5.height = -1;
                    _loc_6 = _loc_5.aabb;
                    if (_loc_6.outer != null)
                    {
                        _loc_6.outer.zpp_inner = null;
                        _loc_6.outer = null;
                    }
                    _loc_7 = null;
                    _loc_6.wrap_max = _loc_7;
                    _loc_6.wrap_min = _loc_7;
                    _loc_6._invalidate = null;
                    _loc_6._validate = null;
                    _loc_6.next = ZPP_AABB.zpp_pool;
                    ZPP_AABB.zpp_pool = _loc_6;
                    _loc_8 = null;
                    _loc_5.parent = _loc_8;
                    _loc_8 = _loc_8;
                    _loc_5.child2 = _loc_8;
                    _loc_5.child1 = _loc_8;
                    _loc_5.next = null;
                    _loc_5.snext = null;
                    _loc_5.mnext = null;
                    _loc_5.next = ZPP_AABBNode.zpp_pool;
                    ZPP_AABBNode.zpp_pool = _loc_5;
                    _loc_5 = _loc_3;
                    while (_loc_5 != null)
                    {
                        
                        if (_loc_5.child1 != null)
                        {
                        }
                        if (_loc_5.height < 2)
                        {
                            _loc_5 = _loc_5;
                        }
                        else
                        {
                            _loc_8 = _loc_5.child1;
                            _loc_9 = _loc_5.child2;
                            _loc_10 = _loc_9.height - _loc_8.height;
                            if (_loc_10 > 1)
                            {
                                _loc_11 = _loc_9.child1;
                                _loc_12 = _loc_9.child2;
                                _loc_9.child1 = _loc_5;
                                _loc_9.parent = _loc_5.parent;
                                _loc_5.parent = _loc_9;
                                if (_loc_9.parent != null)
                                {
                                    if (_loc_9.parent.child1 == _loc_5)
                                    {
                                        _loc_9.parent.child1 = _loc_9;
                                    }
                                    else
                                    {
                                        _loc_9.parent.child2 = _loc_9;
                                    }
                                }
                                else
                                {
                                    root = _loc_9;
                                }
                                if (_loc_11.height > _loc_12.height)
                                {
                                    _loc_9.child2 = _loc_11;
                                    _loc_5.child2 = _loc_12;
                                    _loc_12.parent = _loc_5;
                                    _loc_6 = _loc_5.aabb;
                                    _loc_13 = _loc_8.aabb;
                                    _loc_14 = _loc_12.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_6 = _loc_9.aabb;
                                    _loc_13 = _loc_5.aabb;
                                    _loc_14 = _loc_11.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_15 = _loc_8.height;
                                    _loc_16 = _loc_12.height;
                                    _loc_5.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                    _loc_15 = _loc_5.height;
                                    _loc_16 = _loc_11.height;
                                    _loc_9.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                }
                                else
                                {
                                    _loc_9.child2 = _loc_12;
                                    _loc_5.child2 = _loc_11;
                                    _loc_11.parent = _loc_5;
                                    _loc_6 = _loc_5.aabb;
                                    _loc_13 = _loc_8.aabb;
                                    _loc_14 = _loc_11.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_6 = _loc_9.aabb;
                                    _loc_13 = _loc_5.aabb;
                                    _loc_14 = _loc_12.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_15 = _loc_8.height;
                                    _loc_16 = _loc_11.height;
                                    _loc_5.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                    _loc_15 = _loc_5.height;
                                    _loc_16 = _loc_12.height;
                                    _loc_9.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                }
                                _loc_5 = _loc_9;
                            }
                            else if (_loc_10 < -1)
                            {
                                _loc_11 = _loc_8.child1;
                                _loc_12 = _loc_8.child2;
                                _loc_8.child1 = _loc_5;
                                _loc_8.parent = _loc_5.parent;
                                _loc_5.parent = _loc_8;
                                if (_loc_8.parent != null)
                                {
                                    if (_loc_8.parent.child1 == _loc_5)
                                    {
                                        _loc_8.parent.child1 = _loc_8;
                                    }
                                    else
                                    {
                                        _loc_8.parent.child2 = _loc_8;
                                    }
                                }
                                else
                                {
                                    root = _loc_8;
                                }
                                if (_loc_11.height > _loc_12.height)
                                {
                                    _loc_8.child2 = _loc_11;
                                    _loc_5.child1 = _loc_12;
                                    _loc_12.parent = _loc_5;
                                    _loc_6 = _loc_5.aabb;
                                    _loc_13 = _loc_9.aabb;
                                    _loc_14 = _loc_12.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_6 = _loc_8.aabb;
                                    _loc_13 = _loc_5.aabb;
                                    _loc_14 = _loc_11.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_15 = _loc_9.height;
                                    _loc_16 = _loc_12.height;
                                    _loc_5.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                    _loc_15 = _loc_5.height;
                                    _loc_16 = _loc_11.height;
                                    _loc_8.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                }
                                else
                                {
                                    _loc_8.child2 = _loc_12;
                                    _loc_5.child1 = _loc_11;
                                    _loc_11.parent = _loc_5;
                                    _loc_6 = _loc_5.aabb;
                                    _loc_13 = _loc_9.aabb;
                                    _loc_14 = _loc_11.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_6 = _loc_8.aabb;
                                    _loc_13 = _loc_5.aabb;
                                    _loc_14 = _loc_12.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_15 = _loc_9.height;
                                    _loc_16 = _loc_11.height;
                                    _loc_5.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                    _loc_15 = _loc_5.height;
                                    _loc_16 = _loc_12.height;
                                    _loc_8.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                }
                                _loc_5 = _loc_8;
                            }
                            else
                            {
                                _loc_5 = _loc_5;
                            }
                        }
                        _loc_8 = _loc_5.child1;
                        _loc_9 = _loc_5.child2;
                        _loc_6 = _loc_5.aabb;
                        _loc_13 = _loc_8.aabb;
                        _loc_14 = _loc_9.aabb;
                        if (_loc_13.minx < _loc_14.minx)
                        {
                            _loc_6.minx = _loc_13.minx;
                        }
                        else
                        {
                            _loc_6.minx = _loc_14.minx;
                        }
                        if (_loc_13.miny < _loc_14.miny)
                        {
                            _loc_6.miny = _loc_13.miny;
                        }
                        else
                        {
                            _loc_6.miny = _loc_14.miny;
                        }
                        if (_loc_13.maxx > _loc_14.maxx)
                        {
                            _loc_6.maxx = _loc_13.maxx;
                        }
                        else
                        {
                            _loc_6.maxx = _loc_14.maxx;
                        }
                        if (_loc_13.maxy > _loc_14.maxy)
                        {
                            _loc_6.maxy = _loc_13.maxy;
                        }
                        else
                        {
                            _loc_6.maxy = _loc_14.maxy;
                        }
                        _loc_10 = _loc_8.height;
                        _loc_15 = _loc_9.height;
                        _loc_5.height = 1 + (_loc_10 > _loc_15 ? (_loc_10) : (_loc_15));
                        _loc_5 = _loc_5.parent;
                    }
                }
                else
                {
                    root = _loc_4;
                    _loc_4.parent = null;
                    _loc_5 = _loc_2;
                    _loc_5.height = -1;
                    _loc_6 = _loc_5.aabb;
                    if (_loc_6.outer != null)
                    {
                        _loc_6.outer.zpp_inner = null;
                        _loc_6.outer = null;
                    }
                    _loc_7 = null;
                    _loc_6.wrap_max = _loc_7;
                    _loc_6.wrap_min = _loc_7;
                    _loc_6._invalidate = null;
                    _loc_6._validate = null;
                    _loc_6.next = ZPP_AABB.zpp_pool;
                    ZPP_AABB.zpp_pool = _loc_6;
                    _loc_8 = null;
                    _loc_5.parent = _loc_8;
                    _loc_8 = _loc_8;
                    _loc_5.child2 = _loc_8;
                    _loc_5.child1 = _loc_8;
                    _loc_5.next = null;
                    _loc_5.snext = null;
                    _loc_5.mnext = null;
                    _loc_5.next = ZPP_AABBNode.zpp_pool;
                    ZPP_AABBNode.zpp_pool = _loc_5;
                }
            }
            return;
        }// end function

        public function insertLeaf(param1:ZPP_AABBNode) : void
        {
            var _loc_2:* = null as ZPP_AABB;
            var _loc_3:* = null as ZPP_AABBNode;
            var _loc_4:* = null as ZPP_AABBNode;
            var _loc_5:* = null as ZPP_AABBNode;
            var _loc_6:* = NaN;
            var _loc_7:* = null as ZPP_AABB;
            var _loc_8:* = null as ZPP_AABB;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = null as ZPP_AABBNode;
            var _loc_17:* = null as ZPP_AABBNode;
            var _loc_18:* = null as ZPP_AABBNode;
            var _loc_19:* = 0;
            var _loc_20:* = null as ZPP_AABBNode;
            var _loc_21:* = null as ZPP_AABBNode;
            var _loc_22:* = null as ZPP_AABB;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            if (root == null)
            {
                root = param1;
                root.parent = null;
            }
            else
            {
                _loc_2 = param1.aabb;
                _loc_3 = root;
                while (_loc_3.child1 != null)
                {
                    
                    _loc_4 = _loc_3.child1;
                    _loc_5 = _loc_3.child2;
                    _loc_7 = _loc_3.aabb;
                    _loc_6 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                    _loc_7 = ZPP_AABBTree.tmpaabb;
                    _loc_8 = _loc_3.aabb;
                    if (_loc_8.minx < _loc_2.minx)
                    {
                        _loc_7.minx = _loc_8.minx;
                    }
                    else
                    {
                        _loc_7.minx = _loc_2.minx;
                    }
                    if (_loc_8.miny < _loc_2.miny)
                    {
                        _loc_7.miny = _loc_8.miny;
                    }
                    else
                    {
                        _loc_7.miny = _loc_2.miny;
                    }
                    if (_loc_8.maxx > _loc_2.maxx)
                    {
                        _loc_7.maxx = _loc_8.maxx;
                    }
                    else
                    {
                        _loc_7.maxx = _loc_2.maxx;
                    }
                    if (_loc_8.maxy > _loc_2.maxy)
                    {
                        _loc_7.maxy = _loc_8.maxy;
                    }
                    else
                    {
                        _loc_7.maxy = _loc_2.maxy;
                    }
                    _loc_7 = ZPP_AABBTree.tmpaabb;
                    _loc_9 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                    _loc_10 = 2 * _loc_9;
                    _loc_11 = 2 * (_loc_9 - _loc_6);
                    _loc_7 = ZPP_AABBTree.tmpaabb;
                    _loc_8 = _loc_4.aabb;
                    if (_loc_2.minx < _loc_8.minx)
                    {
                        _loc_7.minx = _loc_2.minx;
                    }
                    else
                    {
                        _loc_7.minx = _loc_8.minx;
                    }
                    if (_loc_2.miny < _loc_8.miny)
                    {
                        _loc_7.miny = _loc_2.miny;
                    }
                    else
                    {
                        _loc_7.miny = _loc_8.miny;
                    }
                    if (_loc_2.maxx > _loc_8.maxx)
                    {
                        _loc_7.maxx = _loc_2.maxx;
                    }
                    else
                    {
                        _loc_7.maxx = _loc_8.maxx;
                    }
                    if (_loc_2.maxy > _loc_8.maxy)
                    {
                        _loc_7.maxy = _loc_2.maxy;
                    }
                    else
                    {
                        _loc_7.maxy = _loc_8.maxy;
                    }
                    if (_loc_4.child1 == null)
                    {
                        _loc_7 = ZPP_AABBTree.tmpaabb;
                        _loc_12 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2 + _loc_11;
                    }
                    else
                    {
                        _loc_7 = _loc_4.aabb;
                        _loc_13 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                        _loc_7 = ZPP_AABBTree.tmpaabb;
                        _loc_14 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                        _loc_12 = _loc_14 - _loc_13 + _loc_11;
                    }
                    _loc_7 = ZPP_AABBTree.tmpaabb;
                    _loc_8 = _loc_5.aabb;
                    if (_loc_2.minx < _loc_8.minx)
                    {
                        _loc_7.minx = _loc_2.minx;
                    }
                    else
                    {
                        _loc_7.minx = _loc_8.minx;
                    }
                    if (_loc_2.miny < _loc_8.miny)
                    {
                        _loc_7.miny = _loc_2.miny;
                    }
                    else
                    {
                        _loc_7.miny = _loc_8.miny;
                    }
                    if (_loc_2.maxx > _loc_8.maxx)
                    {
                        _loc_7.maxx = _loc_2.maxx;
                    }
                    else
                    {
                        _loc_7.maxx = _loc_8.maxx;
                    }
                    if (_loc_2.maxy > _loc_8.maxy)
                    {
                        _loc_7.maxy = _loc_2.maxy;
                    }
                    else
                    {
                        _loc_7.maxy = _loc_8.maxy;
                    }
                    if (_loc_5.child1 == null)
                    {
                        _loc_7 = ZPP_AABBTree.tmpaabb;
                        _loc_13 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2 + _loc_11;
                    }
                    else
                    {
                        _loc_7 = _loc_5.aabb;
                        _loc_14 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                        _loc_7 = ZPP_AABBTree.tmpaabb;
                        _loc_15 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                        _loc_13 = _loc_15 - _loc_14 + _loc_11;
                    }
                    if (_loc_10 < _loc_12)
                    {
                    }
                    if (_loc_10 < _loc_13)
                    {
                        break;
                        continue;
                    }
                    if (_loc_12 < _loc_13)
                    {
                        _loc_3 = _loc_4;
                        continue;
                    }
                    _loc_3 = _loc_5;
                }
                _loc_4 = _loc_3;
                _loc_5 = _loc_4.parent;
                if (ZPP_AABBNode.zpp_pool == null)
                {
                    _loc_16 = new ZPP_AABBNode();
                }
                else
                {
                    _loc_16 = ZPP_AABBNode.zpp_pool;
                    ZPP_AABBNode.zpp_pool = _loc_16.next;
                    _loc_16.next = null;
                }
                if (ZPP_AABB.zpp_pool == null)
                {
                    _loc_16.aabb = new ZPP_AABB();
                }
                else
                {
                    _loc_16.aabb = ZPP_AABB.zpp_pool;
                    ZPP_AABB.zpp_pool = _loc_16.aabb.next;
                    _loc_16.aabb.next = null;
                }
                _loc_16.moved = false;
                _loc_16.synced = false;
                _loc_16.first_sync = false;
                _loc_16.parent = _loc_5;
                _loc_7 = _loc_16.aabb;
                _loc_8 = _loc_4.aabb;
                if (_loc_2.minx < _loc_8.minx)
                {
                    _loc_7.minx = _loc_2.minx;
                }
                else
                {
                    _loc_7.minx = _loc_8.minx;
                }
                if (_loc_2.miny < _loc_8.miny)
                {
                    _loc_7.miny = _loc_2.miny;
                }
                else
                {
                    _loc_7.miny = _loc_8.miny;
                }
                if (_loc_2.maxx > _loc_8.maxx)
                {
                    _loc_7.maxx = _loc_2.maxx;
                }
                else
                {
                    _loc_7.maxx = _loc_8.maxx;
                }
                if (_loc_2.maxy > _loc_8.maxy)
                {
                    _loc_7.maxy = _loc_2.maxy;
                }
                else
                {
                    _loc_7.maxy = _loc_8.maxy;
                }
                _loc_16.height = _loc_4.height + 1;
                if (_loc_5 != null)
                {
                    if (_loc_5.child1 == _loc_4)
                    {
                        _loc_5.child1 = _loc_16;
                    }
                    else
                    {
                        _loc_5.child2 = _loc_16;
                    }
                    _loc_16.child1 = _loc_4;
                    _loc_16.child2 = param1;
                    _loc_4.parent = _loc_16;
                    param1.parent = _loc_16;
                }
                else
                {
                    _loc_16.child1 = _loc_4;
                    _loc_16.child2 = param1;
                    _loc_4.parent = _loc_16;
                    param1.parent = _loc_16;
                    root = _loc_16;
                }
                _loc_3 = param1.parent;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3.child1 != null)
                    {
                    }
                    if (_loc_3.height < 2)
                    {
                        _loc_3 = _loc_3;
                    }
                    else
                    {
                        _loc_17 = _loc_3.child1;
                        _loc_18 = _loc_3.child2;
                        _loc_19 = _loc_18.height - _loc_17.height;
                        if (_loc_19 > 1)
                        {
                            _loc_20 = _loc_18.child1;
                            _loc_21 = _loc_18.child2;
                            _loc_18.child1 = _loc_3;
                            _loc_18.parent = _loc_3.parent;
                            _loc_3.parent = _loc_18;
                            if (_loc_18.parent != null)
                            {
                                if (_loc_18.parent.child1 == _loc_3)
                                {
                                    _loc_18.parent.child1 = _loc_18;
                                }
                                else
                                {
                                    _loc_18.parent.child2 = _loc_18;
                                }
                            }
                            else
                            {
                                root = _loc_18;
                            }
                            if (_loc_20.height > _loc_21.height)
                            {
                                _loc_18.child2 = _loc_20;
                                _loc_3.child2 = _loc_21;
                                _loc_21.parent = _loc_3;
                                _loc_7 = _loc_3.aabb;
                                _loc_8 = _loc_17.aabb;
                                _loc_22 = _loc_21.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_7 = _loc_18.aabb;
                                _loc_8 = _loc_3.aabb;
                                _loc_22 = _loc_20.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_23 = _loc_17.height;
                                _loc_24 = _loc_21.height;
                                _loc_3.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                                _loc_23 = _loc_3.height;
                                _loc_24 = _loc_20.height;
                                _loc_18.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                            }
                            else
                            {
                                _loc_18.child2 = _loc_21;
                                _loc_3.child2 = _loc_20;
                                _loc_20.parent = _loc_3;
                                _loc_7 = _loc_3.aabb;
                                _loc_8 = _loc_17.aabb;
                                _loc_22 = _loc_20.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_7 = _loc_18.aabb;
                                _loc_8 = _loc_3.aabb;
                                _loc_22 = _loc_21.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_23 = _loc_17.height;
                                _loc_24 = _loc_20.height;
                                _loc_3.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                                _loc_23 = _loc_3.height;
                                _loc_24 = _loc_21.height;
                                _loc_18.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                            }
                            _loc_3 = _loc_18;
                        }
                        else if (_loc_19 < -1)
                        {
                            _loc_20 = _loc_17.child1;
                            _loc_21 = _loc_17.child2;
                            _loc_17.child1 = _loc_3;
                            _loc_17.parent = _loc_3.parent;
                            _loc_3.parent = _loc_17;
                            if (_loc_17.parent != null)
                            {
                                if (_loc_17.parent.child1 == _loc_3)
                                {
                                    _loc_17.parent.child1 = _loc_17;
                                }
                                else
                                {
                                    _loc_17.parent.child2 = _loc_17;
                                }
                            }
                            else
                            {
                                root = _loc_17;
                            }
                            if (_loc_20.height > _loc_21.height)
                            {
                                _loc_17.child2 = _loc_20;
                                _loc_3.child1 = _loc_21;
                                _loc_21.parent = _loc_3;
                                _loc_7 = _loc_3.aabb;
                                _loc_8 = _loc_18.aabb;
                                _loc_22 = _loc_21.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_7 = _loc_17.aabb;
                                _loc_8 = _loc_3.aabb;
                                _loc_22 = _loc_20.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_23 = _loc_18.height;
                                _loc_24 = _loc_21.height;
                                _loc_3.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                                _loc_23 = _loc_3.height;
                                _loc_24 = _loc_20.height;
                                _loc_17.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                            }
                            else
                            {
                                _loc_17.child2 = _loc_21;
                                _loc_3.child1 = _loc_20;
                                _loc_20.parent = _loc_3;
                                _loc_7 = _loc_3.aabb;
                                _loc_8 = _loc_18.aabb;
                                _loc_22 = _loc_20.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_7 = _loc_17.aabb;
                                _loc_8 = _loc_3.aabb;
                                _loc_22 = _loc_21.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_23 = _loc_18.height;
                                _loc_24 = _loc_20.height;
                                _loc_3.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                                _loc_23 = _loc_3.height;
                                _loc_24 = _loc_21.height;
                                _loc_17.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                            }
                            _loc_3 = _loc_17;
                        }
                        else
                        {
                            _loc_3 = _loc_3;
                        }
                    }
                    _loc_17 = _loc_3.child1;
                    _loc_18 = _loc_3.child2;
                    _loc_19 = _loc_17.height;
                    _loc_23 = _loc_18.height;
                    _loc_3.height = 1 + (_loc_19 > _loc_23 ? (_loc_19) : (_loc_23));
                    _loc_7 = _loc_3.aabb;
                    _loc_8 = _loc_17.aabb;
                    _loc_22 = _loc_18.aabb;
                    if (_loc_8.minx < _loc_22.minx)
                    {
                        _loc_7.minx = _loc_8.minx;
                    }
                    else
                    {
                        _loc_7.minx = _loc_22.minx;
                    }
                    if (_loc_8.miny < _loc_22.miny)
                    {
                        _loc_7.miny = _loc_8.miny;
                    }
                    else
                    {
                        _loc_7.miny = _loc_22.miny;
                    }
                    if (_loc_8.maxx > _loc_22.maxx)
                    {
                        _loc_7.maxx = _loc_8.maxx;
                    }
                    else
                    {
                        _loc_7.maxx = _loc_22.maxx;
                    }
                    if (_loc_8.maxy > _loc_22.maxy)
                    {
                        _loc_7.maxy = _loc_8.maxy;
                    }
                    else
                    {
                        _loc_7.maxy = _loc_22.maxy;
                    }
                    _loc_3 = _loc_3.parent;
                }
            }
            return;
        }// end function

        public function inlined_removeLeaf(param1:ZPP_AABBNode) : void
        {
            var _loc_2:* = null as ZPP_AABBNode;
            var _loc_3:* = null as ZPP_AABBNode;
            var _loc_4:* = null as ZPP_AABBNode;
            var _loc_5:* = null as ZPP_AABBNode;
            var _loc_6:* = null as ZPP_AABB;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_AABBNode;
            var _loc_9:* = null as ZPP_AABBNode;
            var _loc_10:* = 0;
            var _loc_11:* = null as ZPP_AABBNode;
            var _loc_12:* = null as ZPP_AABBNode;
            var _loc_13:* = null as ZPP_AABB;
            var _loc_14:* = null as ZPP_AABB;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            if (param1 == root)
            {
                root = null;
                return;
            }
            else
            {
                _loc_2 = param1.parent;
                _loc_3 = _loc_2.parent;
                if (_loc_2.child1 == param1)
                {
                    _loc_4 = _loc_2.child2;
                }
                else
                {
                    _loc_4 = _loc_2.child1;
                }
                if (_loc_3 != null)
                {
                    if (_loc_3.child1 == _loc_2)
                    {
                        _loc_3.child1 = _loc_4;
                    }
                    else
                    {
                        _loc_3.child2 = _loc_4;
                    }
                    _loc_4.parent = _loc_3;
                    _loc_5 = _loc_2;
                    _loc_5.height = -1;
                    _loc_6 = _loc_5.aabb;
                    if (_loc_6.outer != null)
                    {
                        _loc_6.outer.zpp_inner = null;
                        _loc_6.outer = null;
                    }
                    _loc_7 = null;
                    _loc_6.wrap_max = _loc_7;
                    _loc_6.wrap_min = _loc_7;
                    _loc_6._invalidate = null;
                    _loc_6._validate = null;
                    _loc_6.next = ZPP_AABB.zpp_pool;
                    ZPP_AABB.zpp_pool = _loc_6;
                    _loc_8 = null;
                    _loc_5.parent = _loc_8;
                    _loc_8 = _loc_8;
                    _loc_5.child2 = _loc_8;
                    _loc_5.child1 = _loc_8;
                    _loc_5.next = null;
                    _loc_5.snext = null;
                    _loc_5.mnext = null;
                    _loc_5.next = ZPP_AABBNode.zpp_pool;
                    ZPP_AABBNode.zpp_pool = _loc_5;
                    _loc_5 = _loc_3;
                    while (_loc_5 != null)
                    {
                        
                        if (_loc_5.child1 != null)
                        {
                        }
                        if (_loc_5.height < 2)
                        {
                            _loc_5 = _loc_5;
                        }
                        else
                        {
                            _loc_8 = _loc_5.child1;
                            _loc_9 = _loc_5.child2;
                            _loc_10 = _loc_9.height - _loc_8.height;
                            if (_loc_10 > 1)
                            {
                                _loc_11 = _loc_9.child1;
                                _loc_12 = _loc_9.child2;
                                _loc_9.child1 = _loc_5;
                                _loc_9.parent = _loc_5.parent;
                                _loc_5.parent = _loc_9;
                                if (_loc_9.parent != null)
                                {
                                    if (_loc_9.parent.child1 == _loc_5)
                                    {
                                        _loc_9.parent.child1 = _loc_9;
                                    }
                                    else
                                    {
                                        _loc_9.parent.child2 = _loc_9;
                                    }
                                }
                                else
                                {
                                    root = _loc_9;
                                }
                                if (_loc_11.height > _loc_12.height)
                                {
                                    _loc_9.child2 = _loc_11;
                                    _loc_5.child2 = _loc_12;
                                    _loc_12.parent = _loc_5;
                                    _loc_6 = _loc_5.aabb;
                                    _loc_13 = _loc_8.aabb;
                                    _loc_14 = _loc_12.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_6 = _loc_9.aabb;
                                    _loc_13 = _loc_5.aabb;
                                    _loc_14 = _loc_11.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_15 = _loc_8.height;
                                    _loc_16 = _loc_12.height;
                                    _loc_5.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                    _loc_15 = _loc_5.height;
                                    _loc_16 = _loc_11.height;
                                    _loc_9.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                }
                                else
                                {
                                    _loc_9.child2 = _loc_12;
                                    _loc_5.child2 = _loc_11;
                                    _loc_11.parent = _loc_5;
                                    _loc_6 = _loc_5.aabb;
                                    _loc_13 = _loc_8.aabb;
                                    _loc_14 = _loc_11.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_6 = _loc_9.aabb;
                                    _loc_13 = _loc_5.aabb;
                                    _loc_14 = _loc_12.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_15 = _loc_8.height;
                                    _loc_16 = _loc_11.height;
                                    _loc_5.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                    _loc_15 = _loc_5.height;
                                    _loc_16 = _loc_12.height;
                                    _loc_9.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                }
                                _loc_5 = _loc_9;
                            }
                            else if (_loc_10 < -1)
                            {
                                _loc_11 = _loc_8.child1;
                                _loc_12 = _loc_8.child2;
                                _loc_8.child1 = _loc_5;
                                _loc_8.parent = _loc_5.parent;
                                _loc_5.parent = _loc_8;
                                if (_loc_8.parent != null)
                                {
                                    if (_loc_8.parent.child1 == _loc_5)
                                    {
                                        _loc_8.parent.child1 = _loc_8;
                                    }
                                    else
                                    {
                                        _loc_8.parent.child2 = _loc_8;
                                    }
                                }
                                else
                                {
                                    root = _loc_8;
                                }
                                if (_loc_11.height > _loc_12.height)
                                {
                                    _loc_8.child2 = _loc_11;
                                    _loc_5.child1 = _loc_12;
                                    _loc_12.parent = _loc_5;
                                    _loc_6 = _loc_5.aabb;
                                    _loc_13 = _loc_9.aabb;
                                    _loc_14 = _loc_12.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_6 = _loc_8.aabb;
                                    _loc_13 = _loc_5.aabb;
                                    _loc_14 = _loc_11.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_15 = _loc_9.height;
                                    _loc_16 = _loc_12.height;
                                    _loc_5.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                    _loc_15 = _loc_5.height;
                                    _loc_16 = _loc_11.height;
                                    _loc_8.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                }
                                else
                                {
                                    _loc_8.child2 = _loc_12;
                                    _loc_5.child1 = _loc_11;
                                    _loc_11.parent = _loc_5;
                                    _loc_6 = _loc_5.aabb;
                                    _loc_13 = _loc_9.aabb;
                                    _loc_14 = _loc_11.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_6 = _loc_8.aabb;
                                    _loc_13 = _loc_5.aabb;
                                    _loc_14 = _loc_12.aabb;
                                    if (_loc_13.minx < _loc_14.minx)
                                    {
                                        _loc_6.minx = _loc_13.minx;
                                    }
                                    else
                                    {
                                        _loc_6.minx = _loc_14.minx;
                                    }
                                    if (_loc_13.miny < _loc_14.miny)
                                    {
                                        _loc_6.miny = _loc_13.miny;
                                    }
                                    else
                                    {
                                        _loc_6.miny = _loc_14.miny;
                                    }
                                    if (_loc_13.maxx > _loc_14.maxx)
                                    {
                                        _loc_6.maxx = _loc_13.maxx;
                                    }
                                    else
                                    {
                                        _loc_6.maxx = _loc_14.maxx;
                                    }
                                    if (_loc_13.maxy > _loc_14.maxy)
                                    {
                                        _loc_6.maxy = _loc_13.maxy;
                                    }
                                    else
                                    {
                                        _loc_6.maxy = _loc_14.maxy;
                                    }
                                    _loc_15 = _loc_9.height;
                                    _loc_16 = _loc_11.height;
                                    _loc_5.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                    _loc_15 = _loc_5.height;
                                    _loc_16 = _loc_12.height;
                                    _loc_8.height = 1 + (_loc_15 > _loc_16 ? (_loc_15) : (_loc_16));
                                }
                                _loc_5 = _loc_8;
                            }
                            else
                            {
                                _loc_5 = _loc_5;
                            }
                        }
                        _loc_8 = _loc_5.child1;
                        _loc_9 = _loc_5.child2;
                        _loc_6 = _loc_5.aabb;
                        _loc_13 = _loc_8.aabb;
                        _loc_14 = _loc_9.aabb;
                        if (_loc_13.minx < _loc_14.minx)
                        {
                            _loc_6.minx = _loc_13.minx;
                        }
                        else
                        {
                            _loc_6.minx = _loc_14.minx;
                        }
                        if (_loc_13.miny < _loc_14.miny)
                        {
                            _loc_6.miny = _loc_13.miny;
                        }
                        else
                        {
                            _loc_6.miny = _loc_14.miny;
                        }
                        if (_loc_13.maxx > _loc_14.maxx)
                        {
                            _loc_6.maxx = _loc_13.maxx;
                        }
                        else
                        {
                            _loc_6.maxx = _loc_14.maxx;
                        }
                        if (_loc_13.maxy > _loc_14.maxy)
                        {
                            _loc_6.maxy = _loc_13.maxy;
                        }
                        else
                        {
                            _loc_6.maxy = _loc_14.maxy;
                        }
                        _loc_10 = _loc_8.height;
                        _loc_15 = _loc_9.height;
                        _loc_5.height = 1 + (_loc_10 > _loc_15 ? (_loc_10) : (_loc_15));
                        _loc_5 = _loc_5.parent;
                    }
                }
                else
                {
                    root = _loc_4;
                    _loc_4.parent = null;
                    _loc_5 = _loc_2;
                    _loc_5.height = -1;
                    _loc_6 = _loc_5.aabb;
                    if (_loc_6.outer != null)
                    {
                        _loc_6.outer.zpp_inner = null;
                        _loc_6.outer = null;
                    }
                    _loc_7 = null;
                    _loc_6.wrap_max = _loc_7;
                    _loc_6.wrap_min = _loc_7;
                    _loc_6._invalidate = null;
                    _loc_6._validate = null;
                    _loc_6.next = ZPP_AABB.zpp_pool;
                    ZPP_AABB.zpp_pool = _loc_6;
                    _loc_8 = null;
                    _loc_5.parent = _loc_8;
                    _loc_8 = _loc_8;
                    _loc_5.child2 = _loc_8;
                    _loc_5.child1 = _loc_8;
                    _loc_5.next = null;
                    _loc_5.snext = null;
                    _loc_5.mnext = null;
                    _loc_5.next = ZPP_AABBNode.zpp_pool;
                    ZPP_AABBNode.zpp_pool = _loc_5;
                }
            }
            return;
        }// end function

        public function inlined_insertLeaf(param1:ZPP_AABBNode) : void
        {
            var _loc_2:* = null as ZPP_AABB;
            var _loc_3:* = null as ZPP_AABBNode;
            var _loc_4:* = null as ZPP_AABBNode;
            var _loc_5:* = null as ZPP_AABBNode;
            var _loc_6:* = NaN;
            var _loc_7:* = null as ZPP_AABB;
            var _loc_8:* = null as ZPP_AABB;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = null as ZPP_AABBNode;
            var _loc_17:* = null as ZPP_AABBNode;
            var _loc_18:* = null as ZPP_AABBNode;
            var _loc_19:* = 0;
            var _loc_20:* = null as ZPP_AABBNode;
            var _loc_21:* = null as ZPP_AABBNode;
            var _loc_22:* = null as ZPP_AABB;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            if (root == null)
            {
                root = param1;
                root.parent = null;
            }
            else
            {
                _loc_2 = param1.aabb;
                _loc_3 = root;
                while (_loc_3.child1 != null)
                {
                    
                    _loc_4 = _loc_3.child1;
                    _loc_5 = _loc_3.child2;
                    _loc_7 = _loc_3.aabb;
                    _loc_6 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                    _loc_7 = ZPP_AABBTree.tmpaabb;
                    _loc_8 = _loc_3.aabb;
                    if (_loc_8.minx < _loc_2.minx)
                    {
                        _loc_7.minx = _loc_8.minx;
                    }
                    else
                    {
                        _loc_7.minx = _loc_2.minx;
                    }
                    if (_loc_8.miny < _loc_2.miny)
                    {
                        _loc_7.miny = _loc_8.miny;
                    }
                    else
                    {
                        _loc_7.miny = _loc_2.miny;
                    }
                    if (_loc_8.maxx > _loc_2.maxx)
                    {
                        _loc_7.maxx = _loc_8.maxx;
                    }
                    else
                    {
                        _loc_7.maxx = _loc_2.maxx;
                    }
                    if (_loc_8.maxy > _loc_2.maxy)
                    {
                        _loc_7.maxy = _loc_8.maxy;
                    }
                    else
                    {
                        _loc_7.maxy = _loc_2.maxy;
                    }
                    _loc_7 = ZPP_AABBTree.tmpaabb;
                    _loc_9 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                    _loc_10 = 2 * _loc_9;
                    _loc_11 = 2 * (_loc_9 - _loc_6);
                    _loc_7 = ZPP_AABBTree.tmpaabb;
                    _loc_8 = _loc_4.aabb;
                    if (_loc_2.minx < _loc_8.minx)
                    {
                        _loc_7.minx = _loc_2.minx;
                    }
                    else
                    {
                        _loc_7.minx = _loc_8.minx;
                    }
                    if (_loc_2.miny < _loc_8.miny)
                    {
                        _loc_7.miny = _loc_2.miny;
                    }
                    else
                    {
                        _loc_7.miny = _loc_8.miny;
                    }
                    if (_loc_2.maxx > _loc_8.maxx)
                    {
                        _loc_7.maxx = _loc_2.maxx;
                    }
                    else
                    {
                        _loc_7.maxx = _loc_8.maxx;
                    }
                    if (_loc_2.maxy > _loc_8.maxy)
                    {
                        _loc_7.maxy = _loc_2.maxy;
                    }
                    else
                    {
                        _loc_7.maxy = _loc_8.maxy;
                    }
                    if (_loc_4.child1 == null)
                    {
                        _loc_7 = ZPP_AABBTree.tmpaabb;
                        _loc_12 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2 + _loc_11;
                    }
                    else
                    {
                        _loc_7 = _loc_4.aabb;
                        _loc_13 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                        _loc_7 = ZPP_AABBTree.tmpaabb;
                        _loc_14 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                        _loc_12 = _loc_14 - _loc_13 + _loc_11;
                    }
                    _loc_7 = ZPP_AABBTree.tmpaabb;
                    _loc_8 = _loc_5.aabb;
                    if (_loc_2.minx < _loc_8.minx)
                    {
                        _loc_7.minx = _loc_2.minx;
                    }
                    else
                    {
                        _loc_7.minx = _loc_8.minx;
                    }
                    if (_loc_2.miny < _loc_8.miny)
                    {
                        _loc_7.miny = _loc_2.miny;
                    }
                    else
                    {
                        _loc_7.miny = _loc_8.miny;
                    }
                    if (_loc_2.maxx > _loc_8.maxx)
                    {
                        _loc_7.maxx = _loc_2.maxx;
                    }
                    else
                    {
                        _loc_7.maxx = _loc_8.maxx;
                    }
                    if (_loc_2.maxy > _loc_8.maxy)
                    {
                        _loc_7.maxy = _loc_2.maxy;
                    }
                    else
                    {
                        _loc_7.maxy = _loc_8.maxy;
                    }
                    if (_loc_5.child1 == null)
                    {
                        _loc_7 = ZPP_AABBTree.tmpaabb;
                        _loc_13 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2 + _loc_11;
                    }
                    else
                    {
                        _loc_7 = _loc_5.aabb;
                        _loc_14 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                        _loc_7 = ZPP_AABBTree.tmpaabb;
                        _loc_15 = (_loc_7.maxx - _loc_7.minx + (_loc_7.maxy - _loc_7.miny)) * 2;
                        _loc_13 = _loc_15 - _loc_14 + _loc_11;
                    }
                    if (_loc_10 < _loc_12)
                    {
                    }
                    if (_loc_10 < _loc_13)
                    {
                        break;
                        continue;
                    }
                    if (_loc_12 < _loc_13)
                    {
                        _loc_3 = _loc_4;
                        continue;
                    }
                    _loc_3 = _loc_5;
                }
                _loc_4 = _loc_3;
                _loc_5 = _loc_4.parent;
                if (ZPP_AABBNode.zpp_pool == null)
                {
                    _loc_16 = new ZPP_AABBNode();
                }
                else
                {
                    _loc_16 = ZPP_AABBNode.zpp_pool;
                    ZPP_AABBNode.zpp_pool = _loc_16.next;
                    _loc_16.next = null;
                }
                if (ZPP_AABB.zpp_pool == null)
                {
                    _loc_16.aabb = new ZPP_AABB();
                }
                else
                {
                    _loc_16.aabb = ZPP_AABB.zpp_pool;
                    ZPP_AABB.zpp_pool = _loc_16.aabb.next;
                    _loc_16.aabb.next = null;
                }
                _loc_16.moved = false;
                _loc_16.synced = false;
                _loc_16.first_sync = false;
                _loc_16.parent = _loc_5;
                _loc_7 = _loc_16.aabb;
                _loc_8 = _loc_4.aabb;
                if (_loc_2.minx < _loc_8.minx)
                {
                    _loc_7.minx = _loc_2.minx;
                }
                else
                {
                    _loc_7.minx = _loc_8.minx;
                }
                if (_loc_2.miny < _loc_8.miny)
                {
                    _loc_7.miny = _loc_2.miny;
                }
                else
                {
                    _loc_7.miny = _loc_8.miny;
                }
                if (_loc_2.maxx > _loc_8.maxx)
                {
                    _loc_7.maxx = _loc_2.maxx;
                }
                else
                {
                    _loc_7.maxx = _loc_8.maxx;
                }
                if (_loc_2.maxy > _loc_8.maxy)
                {
                    _loc_7.maxy = _loc_2.maxy;
                }
                else
                {
                    _loc_7.maxy = _loc_8.maxy;
                }
                _loc_16.height = _loc_4.height + 1;
                if (_loc_5 != null)
                {
                    if (_loc_5.child1 == _loc_4)
                    {
                        _loc_5.child1 = _loc_16;
                    }
                    else
                    {
                        _loc_5.child2 = _loc_16;
                    }
                    _loc_16.child1 = _loc_4;
                    _loc_16.child2 = param1;
                    _loc_4.parent = _loc_16;
                    param1.parent = _loc_16;
                }
                else
                {
                    _loc_16.child1 = _loc_4;
                    _loc_16.child2 = param1;
                    _loc_4.parent = _loc_16;
                    param1.parent = _loc_16;
                    root = _loc_16;
                }
                _loc_3 = param1.parent;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3.child1 != null)
                    {
                    }
                    if (_loc_3.height < 2)
                    {
                        _loc_3 = _loc_3;
                    }
                    else
                    {
                        _loc_17 = _loc_3.child1;
                        _loc_18 = _loc_3.child2;
                        _loc_19 = _loc_18.height - _loc_17.height;
                        if (_loc_19 > 1)
                        {
                            _loc_20 = _loc_18.child1;
                            _loc_21 = _loc_18.child2;
                            _loc_18.child1 = _loc_3;
                            _loc_18.parent = _loc_3.parent;
                            _loc_3.parent = _loc_18;
                            if (_loc_18.parent != null)
                            {
                                if (_loc_18.parent.child1 == _loc_3)
                                {
                                    _loc_18.parent.child1 = _loc_18;
                                }
                                else
                                {
                                    _loc_18.parent.child2 = _loc_18;
                                }
                            }
                            else
                            {
                                root = _loc_18;
                            }
                            if (_loc_20.height > _loc_21.height)
                            {
                                _loc_18.child2 = _loc_20;
                                _loc_3.child2 = _loc_21;
                                _loc_21.parent = _loc_3;
                                _loc_7 = _loc_3.aabb;
                                _loc_8 = _loc_17.aabb;
                                _loc_22 = _loc_21.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_7 = _loc_18.aabb;
                                _loc_8 = _loc_3.aabb;
                                _loc_22 = _loc_20.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_23 = _loc_17.height;
                                _loc_24 = _loc_21.height;
                                _loc_3.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                                _loc_23 = _loc_3.height;
                                _loc_24 = _loc_20.height;
                                _loc_18.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                            }
                            else
                            {
                                _loc_18.child2 = _loc_21;
                                _loc_3.child2 = _loc_20;
                                _loc_20.parent = _loc_3;
                                _loc_7 = _loc_3.aabb;
                                _loc_8 = _loc_17.aabb;
                                _loc_22 = _loc_20.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_7 = _loc_18.aabb;
                                _loc_8 = _loc_3.aabb;
                                _loc_22 = _loc_21.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_23 = _loc_17.height;
                                _loc_24 = _loc_20.height;
                                _loc_3.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                                _loc_23 = _loc_3.height;
                                _loc_24 = _loc_21.height;
                                _loc_18.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                            }
                            _loc_3 = _loc_18;
                        }
                        else if (_loc_19 < -1)
                        {
                            _loc_20 = _loc_17.child1;
                            _loc_21 = _loc_17.child2;
                            _loc_17.child1 = _loc_3;
                            _loc_17.parent = _loc_3.parent;
                            _loc_3.parent = _loc_17;
                            if (_loc_17.parent != null)
                            {
                                if (_loc_17.parent.child1 == _loc_3)
                                {
                                    _loc_17.parent.child1 = _loc_17;
                                }
                                else
                                {
                                    _loc_17.parent.child2 = _loc_17;
                                }
                            }
                            else
                            {
                                root = _loc_17;
                            }
                            if (_loc_20.height > _loc_21.height)
                            {
                                _loc_17.child2 = _loc_20;
                                _loc_3.child1 = _loc_21;
                                _loc_21.parent = _loc_3;
                                _loc_7 = _loc_3.aabb;
                                _loc_8 = _loc_18.aabb;
                                _loc_22 = _loc_21.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_7 = _loc_17.aabb;
                                _loc_8 = _loc_3.aabb;
                                _loc_22 = _loc_20.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_23 = _loc_18.height;
                                _loc_24 = _loc_21.height;
                                _loc_3.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                                _loc_23 = _loc_3.height;
                                _loc_24 = _loc_20.height;
                                _loc_17.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                            }
                            else
                            {
                                _loc_17.child2 = _loc_21;
                                _loc_3.child1 = _loc_20;
                                _loc_20.parent = _loc_3;
                                _loc_7 = _loc_3.aabb;
                                _loc_8 = _loc_18.aabb;
                                _loc_22 = _loc_20.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_7 = _loc_17.aabb;
                                _loc_8 = _loc_3.aabb;
                                _loc_22 = _loc_21.aabb;
                                if (_loc_8.minx < _loc_22.minx)
                                {
                                    _loc_7.minx = _loc_8.minx;
                                }
                                else
                                {
                                    _loc_7.minx = _loc_22.minx;
                                }
                                if (_loc_8.miny < _loc_22.miny)
                                {
                                    _loc_7.miny = _loc_8.miny;
                                }
                                else
                                {
                                    _loc_7.miny = _loc_22.miny;
                                }
                                if (_loc_8.maxx > _loc_22.maxx)
                                {
                                    _loc_7.maxx = _loc_8.maxx;
                                }
                                else
                                {
                                    _loc_7.maxx = _loc_22.maxx;
                                }
                                if (_loc_8.maxy > _loc_22.maxy)
                                {
                                    _loc_7.maxy = _loc_8.maxy;
                                }
                                else
                                {
                                    _loc_7.maxy = _loc_22.maxy;
                                }
                                _loc_23 = _loc_18.height;
                                _loc_24 = _loc_20.height;
                                _loc_3.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                                _loc_23 = _loc_3.height;
                                _loc_24 = _loc_21.height;
                                _loc_17.height = 1 + (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24));
                            }
                            _loc_3 = _loc_17;
                        }
                        else
                        {
                            _loc_3 = _loc_3;
                        }
                    }
                    _loc_17 = _loc_3.child1;
                    _loc_18 = _loc_3.child2;
                    _loc_19 = _loc_17.height;
                    _loc_23 = _loc_18.height;
                    _loc_3.height = 1 + (_loc_19 > _loc_23 ? (_loc_19) : (_loc_23));
                    _loc_7 = _loc_3.aabb;
                    _loc_8 = _loc_17.aabb;
                    _loc_22 = _loc_18.aabb;
                    if (_loc_8.minx < _loc_22.minx)
                    {
                        _loc_7.minx = _loc_8.minx;
                    }
                    else
                    {
                        _loc_7.minx = _loc_22.minx;
                    }
                    if (_loc_8.miny < _loc_22.miny)
                    {
                        _loc_7.miny = _loc_8.miny;
                    }
                    else
                    {
                        _loc_7.miny = _loc_22.miny;
                    }
                    if (_loc_8.maxx > _loc_22.maxx)
                    {
                        _loc_7.maxx = _loc_8.maxx;
                    }
                    else
                    {
                        _loc_7.maxx = _loc_22.maxx;
                    }
                    if (_loc_8.maxy > _loc_22.maxy)
                    {
                        _loc_7.maxy = _loc_8.maxy;
                    }
                    else
                    {
                        _loc_7.maxy = _loc_22.maxy;
                    }
                    _loc_3 = _loc_3.parent;
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            var _loc_2:* = null as ZPP_AABBNode;
            var _loc_3:* = null as ZPP_AABBNode;
            var _loc_4:* = null as ZPP_AABB;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as ZPP_AABBNode;
            if (root == null)
            {
                return;
            }
            var _loc_1:* = null;
            root.next = _loc_1;
            _loc_1 = root;
            while (_loc_1 != null)
            {
                
                _loc_3 = _loc_1;
                _loc_1 = _loc_3.next;
                _loc_3.next = null;
                _loc_2 = _loc_3;
                if (_loc_2.child1 == null)
                {
                    _loc_2.shape.node = null;
                    _loc_2.shape.removedFromSpace();
                    _loc_2.shape = null;
                }
                else
                {
                    if (_loc_2.child1 != null)
                    {
                        _loc_2.child1.next = _loc_1;
                        _loc_1 = _loc_2.child1;
                    }
                    if (_loc_2.child2 != null)
                    {
                        _loc_2.child2.next = _loc_1;
                        _loc_1 = _loc_2.child2;
                    }
                }
                _loc_3 = _loc_2;
                _loc_3.height = -1;
                _loc_4 = _loc_3.aabb;
                if (_loc_4.outer != null)
                {
                    _loc_4.outer.zpp_inner = null;
                    _loc_4.outer = null;
                }
                _loc_5 = null;
                _loc_4.wrap_max = _loc_5;
                _loc_4.wrap_min = _loc_5;
                _loc_4._invalidate = null;
                _loc_4._validate = null;
                _loc_4.next = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_4;
                _loc_6 = null;
                _loc_3.parent = _loc_6;
                _loc_6 = _loc_6;
                _loc_3.child2 = _loc_6;
                _loc_3.child1 = _loc_6;
                _loc_3.next = null;
                _loc_3.snext = null;
                _loc_3.mnext = null;
                _loc_3.next = ZPP_AABBNode.zpp_pool;
                ZPP_AABBNode.zpp_pool = _loc_3;
            }
            root = null;
            return;
        }// end function

        public function balance(param1:ZPP_AABBNode) : ZPP_AABBNode
        {
            var _loc_2:* = null as ZPP_AABBNode;
            var _loc_3:* = null as ZPP_AABBNode;
            var _loc_4:* = 0;
            var _loc_5:* = null as ZPP_AABBNode;
            var _loc_6:* = null as ZPP_AABBNode;
            var _loc_7:* = null as ZPP_AABB;
            var _loc_8:* = null as ZPP_AABB;
            var _loc_9:* = null as ZPP_AABB;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            if (param1.child1 != null)
            {
            }
            if (param1.height < 2)
            {
                return param1;
            }
            else
            {
                _loc_2 = param1.child1;
                _loc_3 = param1.child2;
                _loc_4 = _loc_3.height - _loc_2.height;
                if (_loc_4 > 1)
                {
                    _loc_5 = _loc_3.child1;
                    _loc_6 = _loc_3.child2;
                    _loc_3.child1 = param1;
                    _loc_3.parent = param1.parent;
                    param1.parent = _loc_3;
                    if (_loc_3.parent != null)
                    {
                        if (_loc_3.parent.child1 == param1)
                        {
                            _loc_3.parent.child1 = _loc_3;
                        }
                        else
                        {
                            _loc_3.parent.child2 = _loc_3;
                        }
                    }
                    else
                    {
                        root = _loc_3;
                    }
                    if (_loc_5.height > _loc_6.height)
                    {
                        _loc_3.child2 = _loc_5;
                        param1.child2 = _loc_6;
                        _loc_6.parent = param1;
                        _loc_7 = param1.aabb;
                        _loc_8 = _loc_2.aabb;
                        _loc_9 = _loc_6.aabb;
                        if (_loc_8.minx < _loc_9.minx)
                        {
                            _loc_7.minx = _loc_8.minx;
                        }
                        else
                        {
                            _loc_7.minx = _loc_9.minx;
                        }
                        if (_loc_8.miny < _loc_9.miny)
                        {
                            _loc_7.miny = _loc_8.miny;
                        }
                        else
                        {
                            _loc_7.miny = _loc_9.miny;
                        }
                        if (_loc_8.maxx > _loc_9.maxx)
                        {
                            _loc_7.maxx = _loc_8.maxx;
                        }
                        else
                        {
                            _loc_7.maxx = _loc_9.maxx;
                        }
                        if (_loc_8.maxy > _loc_9.maxy)
                        {
                            _loc_7.maxy = _loc_8.maxy;
                        }
                        else
                        {
                            _loc_7.maxy = _loc_9.maxy;
                        }
                        _loc_7 = _loc_3.aabb;
                        _loc_8 = param1.aabb;
                        _loc_9 = _loc_5.aabb;
                        if (_loc_8.minx < _loc_9.minx)
                        {
                            _loc_7.minx = _loc_8.minx;
                        }
                        else
                        {
                            _loc_7.minx = _loc_9.minx;
                        }
                        if (_loc_8.miny < _loc_9.miny)
                        {
                            _loc_7.miny = _loc_8.miny;
                        }
                        else
                        {
                            _loc_7.miny = _loc_9.miny;
                        }
                        if (_loc_8.maxx > _loc_9.maxx)
                        {
                            _loc_7.maxx = _loc_8.maxx;
                        }
                        else
                        {
                            _loc_7.maxx = _loc_9.maxx;
                        }
                        if (_loc_8.maxy > _loc_9.maxy)
                        {
                            _loc_7.maxy = _loc_8.maxy;
                        }
                        else
                        {
                            _loc_7.maxy = _loc_9.maxy;
                        }
                        _loc_10 = _loc_2.height;
                        _loc_11 = _loc_6.height;
                        param1.height = 1 + (_loc_10 > _loc_11 ? (_loc_10) : (_loc_11));
                        _loc_10 = param1.height;
                        _loc_11 = _loc_5.height;
                        _loc_3.height = 1 + (_loc_10 > _loc_11 ? (_loc_10) : (_loc_11));
                    }
                    else
                    {
                        _loc_3.child2 = _loc_6;
                        param1.child2 = _loc_5;
                        _loc_5.parent = param1;
                        _loc_7 = param1.aabb;
                        _loc_8 = _loc_2.aabb;
                        _loc_9 = _loc_5.aabb;
                        if (_loc_8.minx < _loc_9.minx)
                        {
                            _loc_7.minx = _loc_8.minx;
                        }
                        else
                        {
                            _loc_7.minx = _loc_9.minx;
                        }
                        if (_loc_8.miny < _loc_9.miny)
                        {
                            _loc_7.miny = _loc_8.miny;
                        }
                        else
                        {
                            _loc_7.miny = _loc_9.miny;
                        }
                        if (_loc_8.maxx > _loc_9.maxx)
                        {
                            _loc_7.maxx = _loc_8.maxx;
                        }
                        else
                        {
                            _loc_7.maxx = _loc_9.maxx;
                        }
                        if (_loc_8.maxy > _loc_9.maxy)
                        {
                            _loc_7.maxy = _loc_8.maxy;
                        }
                        else
                        {
                            _loc_7.maxy = _loc_9.maxy;
                        }
                        _loc_7 = _loc_3.aabb;
                        _loc_8 = param1.aabb;
                        _loc_9 = _loc_6.aabb;
                        if (_loc_8.minx < _loc_9.minx)
                        {
                            _loc_7.minx = _loc_8.minx;
                        }
                        else
                        {
                            _loc_7.minx = _loc_9.minx;
                        }
                        if (_loc_8.miny < _loc_9.miny)
                        {
                            _loc_7.miny = _loc_8.miny;
                        }
                        else
                        {
                            _loc_7.miny = _loc_9.miny;
                        }
                        if (_loc_8.maxx > _loc_9.maxx)
                        {
                            _loc_7.maxx = _loc_8.maxx;
                        }
                        else
                        {
                            _loc_7.maxx = _loc_9.maxx;
                        }
                        if (_loc_8.maxy > _loc_9.maxy)
                        {
                            _loc_7.maxy = _loc_8.maxy;
                        }
                        else
                        {
                            _loc_7.maxy = _loc_9.maxy;
                        }
                        _loc_10 = _loc_2.height;
                        _loc_11 = _loc_5.height;
                        param1.height = 1 + (_loc_10 > _loc_11 ? (_loc_10) : (_loc_11));
                        _loc_10 = param1.height;
                        _loc_11 = _loc_6.height;
                        _loc_3.height = 1 + (_loc_10 > _loc_11 ? (_loc_10) : (_loc_11));
                    }
                    return _loc_3;
                }
                else if (_loc_4 < -1)
                {
                    _loc_5 = _loc_2.child1;
                    _loc_6 = _loc_2.child2;
                    _loc_2.child1 = param1;
                    _loc_2.parent = param1.parent;
                    param1.parent = _loc_2;
                    if (_loc_2.parent != null)
                    {
                        if (_loc_2.parent.child1 == param1)
                        {
                            _loc_2.parent.child1 = _loc_2;
                        }
                        else
                        {
                            _loc_2.parent.child2 = _loc_2;
                        }
                    }
                    else
                    {
                        root = _loc_2;
                    }
                    if (_loc_5.height > _loc_6.height)
                    {
                        _loc_2.child2 = _loc_5;
                        param1.child1 = _loc_6;
                        _loc_6.parent = param1;
                        _loc_7 = param1.aabb;
                        _loc_8 = _loc_3.aabb;
                        _loc_9 = _loc_6.aabb;
                        if (_loc_8.minx < _loc_9.minx)
                        {
                            _loc_7.minx = _loc_8.minx;
                        }
                        else
                        {
                            _loc_7.minx = _loc_9.minx;
                        }
                        if (_loc_8.miny < _loc_9.miny)
                        {
                            _loc_7.miny = _loc_8.miny;
                        }
                        else
                        {
                            _loc_7.miny = _loc_9.miny;
                        }
                        if (_loc_8.maxx > _loc_9.maxx)
                        {
                            _loc_7.maxx = _loc_8.maxx;
                        }
                        else
                        {
                            _loc_7.maxx = _loc_9.maxx;
                        }
                        if (_loc_8.maxy > _loc_9.maxy)
                        {
                            _loc_7.maxy = _loc_8.maxy;
                        }
                        else
                        {
                            _loc_7.maxy = _loc_9.maxy;
                        }
                        _loc_7 = _loc_2.aabb;
                        _loc_8 = param1.aabb;
                        _loc_9 = _loc_5.aabb;
                        if (_loc_8.minx < _loc_9.minx)
                        {
                            _loc_7.minx = _loc_8.minx;
                        }
                        else
                        {
                            _loc_7.minx = _loc_9.minx;
                        }
                        if (_loc_8.miny < _loc_9.miny)
                        {
                            _loc_7.miny = _loc_8.miny;
                        }
                        else
                        {
                            _loc_7.miny = _loc_9.miny;
                        }
                        if (_loc_8.maxx > _loc_9.maxx)
                        {
                            _loc_7.maxx = _loc_8.maxx;
                        }
                        else
                        {
                            _loc_7.maxx = _loc_9.maxx;
                        }
                        if (_loc_8.maxy > _loc_9.maxy)
                        {
                            _loc_7.maxy = _loc_8.maxy;
                        }
                        else
                        {
                            _loc_7.maxy = _loc_9.maxy;
                        }
                        _loc_10 = _loc_3.height;
                        _loc_11 = _loc_6.height;
                        param1.height = 1 + (_loc_10 > _loc_11 ? (_loc_10) : (_loc_11));
                        _loc_10 = param1.height;
                        _loc_11 = _loc_5.height;
                        _loc_2.height = 1 + (_loc_10 > _loc_11 ? (_loc_10) : (_loc_11));
                    }
                    else
                    {
                        _loc_2.child2 = _loc_6;
                        param1.child1 = _loc_5;
                        _loc_5.parent = param1;
                        _loc_7 = param1.aabb;
                        _loc_8 = _loc_3.aabb;
                        _loc_9 = _loc_5.aabb;
                        if (_loc_8.minx < _loc_9.minx)
                        {
                            _loc_7.minx = _loc_8.minx;
                        }
                        else
                        {
                            _loc_7.minx = _loc_9.minx;
                        }
                        if (_loc_8.miny < _loc_9.miny)
                        {
                            _loc_7.miny = _loc_8.miny;
                        }
                        else
                        {
                            _loc_7.miny = _loc_9.miny;
                        }
                        if (_loc_8.maxx > _loc_9.maxx)
                        {
                            _loc_7.maxx = _loc_8.maxx;
                        }
                        else
                        {
                            _loc_7.maxx = _loc_9.maxx;
                        }
                        if (_loc_8.maxy > _loc_9.maxy)
                        {
                            _loc_7.maxy = _loc_8.maxy;
                        }
                        else
                        {
                            _loc_7.maxy = _loc_9.maxy;
                        }
                        _loc_7 = _loc_2.aabb;
                        _loc_8 = param1.aabb;
                        _loc_9 = _loc_6.aabb;
                        if (_loc_8.minx < _loc_9.minx)
                        {
                            _loc_7.minx = _loc_8.minx;
                        }
                        else
                        {
                            _loc_7.minx = _loc_9.minx;
                        }
                        if (_loc_8.miny < _loc_9.miny)
                        {
                            _loc_7.miny = _loc_8.miny;
                        }
                        else
                        {
                            _loc_7.miny = _loc_9.miny;
                        }
                        if (_loc_8.maxx > _loc_9.maxx)
                        {
                            _loc_7.maxx = _loc_8.maxx;
                        }
                        else
                        {
                            _loc_7.maxx = _loc_9.maxx;
                        }
                        if (_loc_8.maxy > _loc_9.maxy)
                        {
                            _loc_7.maxy = _loc_8.maxy;
                        }
                        else
                        {
                            _loc_7.maxy = _loc_9.maxy;
                        }
                        _loc_10 = _loc_3.height;
                        _loc_11 = _loc_5.height;
                        param1.height = 1 + (_loc_10 > _loc_11 ? (_loc_10) : (_loc_11));
                        _loc_10 = param1.height;
                        _loc_11 = _loc_6.height;
                        _loc_2.height = 1 + (_loc_10 > _loc_11 ? (_loc_10) : (_loc_11));
                    }
                    return _loc_2;
                }
                else
                {
                    return param1;
                }
            }
        }// end function

    }
}
