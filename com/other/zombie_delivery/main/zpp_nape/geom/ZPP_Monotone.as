package zpp_nape.geom
{
    import nape.geom.*;
    import zpp_nape.util.*;

    public class ZPP_Monotone extends Object
    {
        public static var sharedPPoly:ZPP_PartitionedPoly;
        public static var queue:ZNPList_ZPP_PartitionVertex;
        public static var edges:ZPP_Set_ZPP_PartitionVertex;

        public function ZPP_Monotone() : void
        {
            return;
        }// end function

        public static function bisector(param1:ZPP_PartitionVertex) : ZPP_Vec2
        {
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_2:* = param1.prev;
            var _loc_3:* = param1.next;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_4 = param1.x - _loc_2.x;
            _loc_5 = param1.y - _loc_2.y;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_6 = _loc_3.x - param1.x;
            _loc_7 = _loc_3.y - param1.y;
            var _loc_9:* = false;
            if (ZPP_Vec2.zpp_pool == null)
            {
                _loc_10 = new ZPP_Vec2();
            }
            else
            {
                _loc_10 = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_10.next;
                _loc_10.next = null;
            }
            _loc_10.weak = false;
            _loc_10._immutable = _loc_9;
            _loc_10.x = -_loc_5 - _loc_7;
            _loc_10.y = _loc_4 + _loc_6;
            var _loc_8:* = _loc_10;
            var _loc_11:* = _loc_8.x * _loc_8.x + _loc_8.y * _loc_8.y;
            var _loc_13:* = 1597463007 - (0 >> 1);
            var _loc_14:* = 0;
            var _loc_12:* = _loc_14 * (1.5 - 0.5 * _loc_11 * _loc_14 * _loc_14);
            _loc_14 = _loc_12;
            _loc_8.x = _loc_8.x * _loc_14;
            _loc_8.y = _loc_8.y * _loc_14;
            if (_loc_7 * _loc_4 - _loc_6 * _loc_5 < 0)
            {
                _loc_8.x = -_loc_8.x;
                _loc_8.y = -_loc_8.y;
            }
            return _loc_8;
        }// end function

        public static function below(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = NaN;
            var _loc_6:* = false;
            var _loc_7:* = null as ZPP_Vec2;
            if (param1.y < param2.y)
            {
                return true;
            }
            else if (param1.y > param2.y)
            {
                return false;
            }
            else if (param1.x < param2.x)
            {
                return true;
            }
            else if (param1.x > param2.x)
            {
                return false;
            }
            else
            {
                _loc_3 = ZPP_Monotone.bisector(param1);
                _loc_4 = ZPP_Monotone.bisector(param2);
                _loc_5 = 1;
                _loc_3.x = _loc_3.x + param1.x * _loc_5;
                _loc_3.y = _loc_3.y + param1.y * _loc_5;
                _loc_5 = 1;
                _loc_4.x = _loc_4.x + param2.x * _loc_5;
                _loc_4.y = _loc_4.y + param2.y * _loc_5;
                if (_loc_3.x >= _loc_4.x)
                {
                    if (_loc_3.x == _loc_4.x)
                    {
                    }
                }
                _loc_6 = _loc_3.y < _loc_4.y;
                _loc_7 = _loc_3;
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
                _loc_7 = _loc_4;
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
                return _loc_6;
            }
        }// end function

        public static function above(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
        {
            return ZPP_Monotone.below(param2, param1);
        }// end function

        public static function left_vertex(param1:ZPP_PartitionVertex) : Boolean
        {
            var _loc_2:* = param1.prev;
            if (_loc_2.y <= param1.y)
            {
                if (_loc_2.y == param1.y)
                {
                }
            }
            return param1.next.y < param1.y;
        }// end function

        public static function isMonotone(param1:ZPP_GeomVert) : Boolean
        {
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = null as ZPP_GeomVert;
            var _loc_9:* = null as ZPP_GeomVert;
            var _loc_2:* = param1;
            var _loc_3:* = param1;
            var _loc_4:* = param1.next;
            _loc_5 = param1;
            if (_loc_4 != null)
            {
                _loc_6 = _loc_4;
                do
                {
                    
                    _loc_7 = _loc_6;
                    if (_loc_7.y < _loc_2.y)
                    {
                        _loc_2 = _loc_7;
                    }
                    if (_loc_7.y > _loc_3.y)
                    {
                        _loc_3 = _loc_7;
                    }
                    _loc_6 = _loc_6.next;
                }while (_loc_6 != _loc_5)
            }
            var _loc_8:* = true;
            _loc_4 = _loc_2;
            if (_loc_3 != _loc_2.next)
            {
                _loc_5 = _loc_2.next;
                _loc_6 = _loc_3;
                if (_loc_5 != null)
                {
                    _loc_7 = _loc_5;
                    do
                    {
                        
                        _loc_9 = _loc_7;
                        if (_loc_9.y < _loc_4.y)
                        {
                            _loc_8 = false;
                            break;
                        }
                        _loc_4 = _loc_9;
                        _loc_7 = _loc_7.next;
                    }while (_loc_7 != _loc_6)
                }
            }
            if (!_loc_8)
            {
                return false;
            }
            _loc_4 = _loc_2;
            if (_loc_3 != _loc_2.prev)
            {
                _loc_5 = _loc_2.prev;
                _loc_6 = _loc_3;
                if (_loc_5 != null)
                {
                    _loc_7 = _loc_5;
                    do
                    {
                        
                        _loc_9 = _loc_7;
                        if (_loc_9.y < _loc_4.y)
                        {
                            _loc_8 = false;
                            break;
                        }
                        _loc_4 = _loc_9;
                        _loc_7 = _loc_7.prev;
                    }while (_loc_7 != _loc_6)
                }
            }
            return _loc_8;
        }// end function

        public static function getShared() : ZPP_PartitionedPoly
        {
            if (ZPP_Monotone.sharedPPoly == null)
            {
                ZPP_Monotone.sharedPPoly = new ZPP_PartitionedPoly();
            }
            return ZPP_Monotone.sharedPPoly;
        }// end function

        public static function decompose(param1:ZPP_GeomVert, param2:ZPP_PartitionedPoly = undefined) : ZPP_PartitionedPoly
        {
            var _loc_3:* = null as ZPP_PartitionVertex;
            var _loc_4:* = null as ZPP_PartitionVertex;
            var _loc_5:* = null as ZPP_PartitionVertex;
            var _loc_6:* = null as ZPP_PartitionVertex;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = false;
            var _loc_13:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_14:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_15:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_16:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_17:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = null as ZPP_Set_ZPP_PartitionVertex;
            var _loc_23:* = null as ZPP_PartitionVertex;
            if (param2 == null)
            {
                param2 = new ZPP_PartitionedPoly(param1);
            }
            else
            {
                param2.init(param1);
            }
            if (param2.vertices == null)
            {
                return param2;
            }
            if (ZPP_Monotone.queue == null)
            {
                ZPP_Monotone.queue = new ZNPList_ZPP_PartitionVertex();
            }
            _loc_3 = param2.vertices;
            _loc_4 = param2.vertices;
            if (_loc_3 != null)
            {
                _loc_5 = _loc_3;
                do
                {
                    
                    _loc_6 = _loc_5;
                    ZPP_Monotone.queue.add(_loc_6);
                    _loc_7 = 0;
                    _loc_8 = 0;
                    _loc_7 = _loc_6.next.x - _loc_6.x;
                    _loc_8 = _loc_6.next.y - _loc_6.y;
                    _loc_9 = 0;
                    _loc_10 = 0;
                    _loc_9 = _loc_6.prev.x - _loc_6.x;
                    _loc_10 = _loc_6.prev.y - _loc_6.y;
                    _loc_11 = _loc_10 * _loc_7 - _loc_9 * _loc_8 > 0;
                    if (ZPP_Monotone.below(_loc_6.prev, _loc_6))
                    {
                        if (ZPP_Monotone.below(_loc_6.next, _loc_6))
                        {
                            if (_loc_11)
                            {
                                _loc_6.type = 0;
                            }
                            else
                            {
                                _loc_6.type = 3;
                            }
                        }
                        else
                        {
                            _loc_6.type = 4;
                        }
                    }
                    else if (ZPP_Monotone.below(_loc_6, _loc_6.next))
                    {
                        if (_loc_11)
                        {
                            _loc_6.type = 1;
                        }
                        else
                        {
                            _loc_6.type = 2;
                        }
                    }
                    else
                    {
                        _loc_6.type = 4;
                    }
                    _loc_5 = _loc_5.next;
                }while (_loc_5 != _loc_4)
            }
            var _loc_12:* = ZPP_Monotone.queue;
            if (_loc_12.head != null)
            {
            }
            if (_loc_12.head.next != null)
            {
                _loc_13 = _loc_12.head;
                _loc_14 = null;
                _loc_15 = null;
                _loc_16 = null;
                _loc_17 = null;
                _loc_18 = 1;
                do
                {
                    
                    _loc_19 = 0;
                    _loc_15 = _loc_13;
                    _loc_13 = null;
                    _loc_14 = _loc_13;
                    while (_loc_15 != null)
                    {
                        
                        _loc_19++;
                        _loc_16 = _loc_15;
                        _loc_20 = 0;
                        _loc_21 = _loc_18;
                        do
                        {
                            
                            _loc_20++;
                            _loc_16 = _loc_16.next;
                            if (_loc_16 != null)
                            {
                            }
                        }while (_loc_20 < _loc_18)
                        do
                        {
                            
                            if (_loc_20 == 0)
                            {
                                _loc_17 = _loc_16;
                                _loc_16 = _loc_16.next;
                                _loc_21--;
                            }
                            else
                            {
                                if (_loc_21 != 0)
                                {
                                }
                                if (_loc_16 == null)
                                {
                                    _loc_17 = _loc_15;
                                    _loc_15 = _loc_15.next;
                                    _loc_20--;
                                }
                                else if (ZPP_Monotone.above(_loc_15.elt, _loc_16.elt))
                                {
                                    _loc_17 = _loc_15;
                                    _loc_15 = _loc_15.next;
                                    _loc_20--;
                                }
                                else
                                {
                                    _loc_17 = _loc_16;
                                    _loc_16 = _loc_16.next;
                                    _loc_21--;
                                }
                            }
                            if (_loc_14 != null)
                            {
                                _loc_14.next = _loc_17;
                            }
                            else
                            {
                                _loc_13 = _loc_17;
                            }
                            _loc_14 = _loc_17;
                            if (_loc_20 <= 0)
                            {
                                if (_loc_21 > 0)
                                {
                                }
                            }
                        }while (_loc_16 != null)
                        _loc_15 = _loc_16;
                    }
                    _loc_14.next = null;
                    _loc_18 = _loc_18 << 1;
                }while (_loc_19 > 1)
                _loc_12.head = _loc_13;
                _loc_12.modified = true;
                _loc_12.pushmod = true;
            }
            if (ZPP_Monotone.edges == null)
            {
                if (ZPP_Set_ZPP_PartitionVertex.zpp_pool == null)
                {
                    ZPP_Monotone.edges = new ZPP_Set_ZPP_PartitionVertex();
                }
                else
                {
                    ZPP_Monotone.edges = ZPP_Set_ZPP_PartitionVertex.zpp_pool;
                    ZPP_Set_ZPP_PartitionVertex.zpp_pool = ZPP_Monotone.edges.next;
                    ZPP_Monotone.edges.next = null;
                }
                ZPP_Monotone.edges.lt = ZPP_PartitionVertex.edge_lt;
                ZPP_Monotone.edges.swapped = ZPP_PartitionVertex.edge_swap;
            }
            while (ZPP_Monotone.queue.head != null)
            {
                
                _loc_3 = ZPP_Monotone.queue.pop_unsafe();
                _loc_18 = _loc_3.type;
                switch(_loc_18) branch count is:<4>[24, 51, 435, 130, 806] default offset is:<20>;
                continue;
                _loc_3.helper = _loc_3;
                _loc_3.node = ZPP_Monotone.edges.insert(_loc_3);
                continue;
                _loc_4 = _loc_3.prev;
                if (_loc_4.helper == null)
                {
                    throw "Fatal error (1): Polygon is not weakly-simple and clockwise";
                }
                if (_loc_4.helper.type == 2)
                {
                    param2.add_diagonal(_loc_3, _loc_4.helper);
                }
                ZPP_Monotone.edges.remove_node(_loc_4.node);
                _loc_4.helper = null;
                continue;
                _loc_5 = null;
                if (!ZPP_Monotone.edges.empty())
                {
                    _loc_22 = ZPP_Monotone.edges.parent;
                    while (_loc_22.prev != null)
                    {
                        
                        _loc_22 = _loc_22.prev;
                    }
                    while (_loc_22 != null)
                    {
                        
                        _loc_6 = _loc_22.data;
                        if (!ZPP_PartitionVertex.vert_lt(_loc_6, _loc_3))
                        {
                            _loc_5 = _loc_6;
                            break;
                        }
                        if (_loc_22.next != null)
                        {
                            _loc_22 = _loc_22.next;
                            while (_loc_22.prev != null)
                            {
                                
                                _loc_22 = _loc_22.prev;
                            }
                            continue;
                        }
                        do
                        {
                            
                            _loc_22 = _loc_22.parent;
                            if (_loc_22.parent != null)
                            {
                            }
                        }while (_loc_22 == _loc_22.parent.next)
                        _loc_22 = _loc_22.parent;
                    }
                }
                _loc_4 = _loc_5;
                if (_loc_4 != null)
                {
                    if (_loc_4.helper == null)
                    {
                        throw "Fatal error (2): Polygon is not weakly-simple and clockwise";
                    }
                    param2.add_diagonal(_loc_3, _loc_4.helper);
                    _loc_4.helper = _loc_3;
                }
                _loc_3.node = ZPP_Monotone.edges.insert(_loc_3);
                _loc_3.helper = _loc_3;
                continue;
                _loc_4 = _loc_3.prev;
                if (_loc_4.helper == null)
                {
                    throw "Fatal error (3): Polygon is not weakly-simple and clockwise";
                }
                if (_loc_4.helper.type == 2)
                {
                    param2.add_diagonal(_loc_3, _loc_4.helper);
                }
                ZPP_Monotone.edges.remove_node(_loc_4.node);
                _loc_4.helper = null;
                _loc_6 = null;
                if (!ZPP_Monotone.edges.empty())
                {
                    _loc_22 = ZPP_Monotone.edges.parent;
                    while (_loc_22.prev != null)
                    {
                        
                        _loc_22 = _loc_22.prev;
                    }
                    while (_loc_22 != null)
                    {
                        
                        _loc_23 = _loc_22.data;
                        if (!ZPP_PartitionVertex.vert_lt(_loc_23, _loc_3))
                        {
                            _loc_6 = _loc_23;
                            break;
                        }
                        if (_loc_22.next != null)
                        {
                            _loc_22 = _loc_22.next;
                            while (_loc_22.prev != null)
                            {
                                
                                _loc_22 = _loc_22.prev;
                            }
                            continue;
                        }
                        do
                        {
                            
                            _loc_22 = _loc_22.parent;
                            if (_loc_22.parent != null)
                            {
                            }
                        }while (_loc_22 == _loc_22.parent.next)
                        _loc_22 = _loc_22.parent;
                    }
                }
                _loc_5 = _loc_6;
                if (_loc_5 != null)
                {
                    if (_loc_5.helper == null)
                    {
                        throw "Fatal error (4): Polygon is not weakly-simple and clockwise";
                    }
                    if (_loc_5.helper.type == 2)
                    {
                        param2.add_diagonal(_loc_3, _loc_5.helper);
                    }
                    _loc_5.helper = _loc_3;
                }
                continue;
                _loc_4 = _loc_3.prev;
                if (ZPP_Monotone.left_vertex(_loc_3))
                {
                    if (_loc_4.helper == null)
                    {
                        throw "Fatal error (5): Polygon is not weakly-simple and clockwise";
                    }
                    if (_loc_4.helper.type == 2)
                    {
                        param2.add_diagonal(_loc_3, _loc_4.helper);
                    }
                    ZPP_Monotone.edges.remove_node(_loc_4.node);
                    _loc_4.helper = null;
                    _loc_3.node = ZPP_Monotone.edges.insert(_loc_3);
                    _loc_3.helper = _loc_3;
                    continue;
                }
                _loc_6 = null;
                if (!ZPP_Monotone.edges.empty())
                {
                    _loc_22 = ZPP_Monotone.edges.parent;
                    while (_loc_22.prev != null)
                    {
                        
                        _loc_22 = _loc_22.prev;
                    }
                    while (_loc_22 != null)
                    {
                        
                        _loc_23 = _loc_22.data;
                        if (!ZPP_PartitionVertex.vert_lt(_loc_23, _loc_3))
                        {
                            _loc_6 = _loc_23;
                            break;
                        }
                        if (_loc_22.next != null)
                        {
                            _loc_22 = _loc_22.next;
                            while (_loc_22.prev != null)
                            {
                                
                                _loc_22 = _loc_22.prev;
                            }
                            continue;
                        }
                        do
                        {
                            
                            _loc_22 = _loc_22.parent;
                            if (_loc_22.parent != null)
                            {
                            }
                        }while (_loc_22 == _loc_22.parent.next)
                        _loc_22 = _loc_22.parent;
                    }
                }
                _loc_5 = _loc_6;
                if (_loc_5 != null)
                {
                }
                if (_loc_5.helper == null)
                {
                    throw "Fatal error (6): Polygon is not weakly-simple and clockwise";
                }
                if (_loc_5.helper.type == 2)
                {
                    param2.add_diagonal(_loc_3, _loc_5.helper);
                }
                _loc_5.helper = _loc_3;
            }
            return param2;
        }// end function

    }
}
