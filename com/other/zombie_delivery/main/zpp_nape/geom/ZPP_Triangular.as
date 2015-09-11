package zpp_nape.geom
{
    import zpp_nape.util.*;

    public class ZPP_Triangular extends Object
    {
        public static var queue:ZNPList_ZPP_PartitionVertex;
        public static var stack:ZNPList_ZPP_PartitionVertex;
        public static var edgeSet:ZPP_Set_ZPP_PartitionPair;

        public function ZPP_Triangular() : void
        {
            return;
        }// end function

        public static function lt(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
        {
            if (param1.y >= param2.y)
            {
                if (param1.y == param2.y)
                {
                }
            }
            return param1.x < param2.x;
        }// end function

        public static function right_turn(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex, param3:ZPP_PartitionVertex) : Number
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_4 = param3.x - param2.x;
            _loc_5 = param3.y - param2.y;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_6 = param2.x - param1.x;
            _loc_7 = param2.y - param1.y;
            return _loc_7 * _loc_4 - _loc_6 * _loc_5;
        }// end function

        public static function delaunay(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex, param3:ZPP_PartitionVertex, param4:ZPP_PartitionVertex) : Boolean
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            _loc_5 = param3.x - param2.x;
            _loc_6 = param3.y - param2.y;
            _loc_7 = param2.x - param1.x;
            _loc_8 = param2.y - param1.y;
            if (_loc_8 * _loc_5 - _loc_7 * _loc_6 < 0)
            {
                _loc_5 = param4.x - param3.x;
                _loc_6 = param4.y - param3.y;
                _loc_7 = param3.x - param2.x;
                _loc_8 = param3.y - param2.y;
            }
            if (_loc_8 * _loc_5 - _loc_7 * _loc_6 < 0)
            {
                _loc_5 = param1.x - param4.x;
                _loc_6 = param1.y - param4.y;
                _loc_7 = param4.x - param3.x;
                _loc_8 = param4.y - param3.y;
            }
            if (_loc_8 * _loc_5 - _loc_7 * _loc_6 < 0)
            {
                _loc_5 = param2.x - param1.x;
                _loc_6 = param2.y - param1.y;
                _loc_7 = param1.x - param4.x;
                _loc_8 = param1.y - param4.y;
            }
            if (_loc_8 * _loc_5 - _loc_7 * _loc_6 >= 0)
            {
                return true;
            }
            return param2.x * (param3.y * param4.mag - param3.mag * param4.y) - param3.x * (param2.y * param4.mag - param2.mag * param4.y) + param4.x * (param2.y * param3.mag - param2.mag * param3.y) - (param1.x * (param3.y * param4.mag - param3.mag * param4.y) - param3.x * (param1.y * param4.mag - param1.mag * param4.y) + param4.x * (param1.y * param3.mag - param1.mag * param3.y)) + (param1.x * (param2.y * param4.mag - param2.mag * param4.y) - param2.x * (param1.y * param4.mag - param1.mag * param4.y) + param4.x * (param1.y * param2.mag - param1.mag * param2.y)) - (param1.x * (param2.y * param3.mag - param2.mag * param3.y) - param2.x * (param1.y * param3.mag - param1.mag * param3.y) + param3.x * (param1.y * param2.mag - param1.mag * param2.y)) > 0;
            return param2.x * (param3.y * param4.mag - param3.mag * param4.y) + param2.y * (param3.mag * param4.x - param3.x * param4.mag) + param2.mag * (param3.x * param4.y - param3.y * param4.x) + param1.x * (param3.mag * param4.y - param3.y * param4.mag + param2.mag * (param3.y - param4.y) + param2.y * (param4.mag - param3.mag)) + param1.y * (param3.x * param4.mag - param3.mag * param4.x + param2.mag * (param4.x - param3.x) + param2.x * (param3.mag - param4.mag)) + param1.mag * (param3.y * param4.x - param3.x * param4.y + param2.x * (param4.y - param3.y) + param2.y * (param3.x - param4.x)) > 0;
        }// end function

        public static function optimise(param1:ZPP_PartitionedPoly) : void
        {
            var _loc_2:* = null as ZPP_PartitionVertex;
            var _loc_3:* = null as ZPP_PartitionVertex;
            var _loc_4:* = null as ZPP_PartitionVertex;
            var _loc_5:* = null as ZPP_PartitionVertex;
            var _loc_6:* = null as ZPP_PartitionPair;
            var _loc_7:* = null as ZPP_PartitionVertex;
            var _loc_8:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_9:* = null as ZPP_PartitionVertex;
            var _loc_10:* = null as ZPP_PartitionVertex;
            var _loc_11:* = null as ZPP_PartitionPair;
            var _loc_12:* = null as ZPP_PartitionPair;
            _loc_2 = param1.vertices;
            _loc_3 = param1.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    _loc_5.sort();
                    _loc_5.mag = _loc_5.x * _loc_5.x + _loc_5.y * _loc_5.y;
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            if (ZPP_Triangular.edgeSet == null)
            {
                if (ZPP_Set_ZPP_PartitionPair.zpp_pool == null)
                {
                    ZPP_Triangular.edgeSet = new ZPP_Set_ZPP_PartitionPair();
                }
                else
                {
                    ZPP_Triangular.edgeSet = ZPP_Set_ZPP_PartitionPair.zpp_pool;
                    ZPP_Set_ZPP_PartitionPair.zpp_pool = ZPP_Triangular.edgeSet.next;
                    ZPP_Triangular.edgeSet.next = null;
                }
                ZPP_Triangular.edgeSet.lt = ZPP_PartitionPair.edge_lt;
                ZPP_Triangular.edgeSet.swapped = ZPP_PartitionPair.edge_swap;
            }
            if (ZPP_PartitionPair.zpp_pool == null)
            {
                _loc_6 = new ZPP_PartitionPair();
            }
            else
            {
                _loc_6 = ZPP_PartitionPair.zpp_pool;
                ZPP_PartitionPair.zpp_pool = _loc_6.next;
                _loc_6.next = null;
            }
            _loc_2 = param1.vertices;
            _loc_3 = param1.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    _loc_7 = _loc_5.next;
                    _loc_5.diagonals.reverse();
                    _loc_8 = _loc_5.diagonals.head;
                    while (_loc_8 != null)
                    {
                        
                        _loc_9 = _loc_8.elt;
                        if (_loc_9.id < _loc_5.id)
                        {
                            _loc_7 = _loc_9;
                            _loc_8 = _loc_8.next;
                            continue;
                        }
                        if (_loc_8.next == null)
                        {
                            _loc_10 = _loc_5.prev;
                        }
                        else
                        {
                            _loc_10 = _loc_8.next.elt;
                        }
                        if (!ZPP_Triangular.delaunay(_loc_5, _loc_7, _loc_9, _loc_10))
                        {
                            if (ZPP_PartitionPair.zpp_pool == null)
                            {
                                _loc_12 = new ZPP_PartitionPair();
                            }
                            else
                            {
                                _loc_12 = ZPP_PartitionPair.zpp_pool;
                                ZPP_PartitionPair.zpp_pool = _loc_12.next;
                                _loc_12.next = null;
                            }
                            _loc_12.a = _loc_5;
                            _loc_12.b = _loc_9;
                            if (_loc_5.id < _loc_9.id)
                            {
                                _loc_12.id = _loc_5.id;
                                _loc_12.di = _loc_9.id;
                            }
                            else
                            {
                                _loc_12.id = _loc_9.id;
                                _loc_12.di = _loc_5.id;
                            }
                            _loc_11 = _loc_12;
                            _loc_6.add(_loc_11);
                            _loc_11.node = ZPP_Triangular.edgeSet.insert(_loc_11);
                        }
                        _loc_7 = _loc_9;
                        _loc_8 = _loc_8.next;
                    }
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            while (_loc_6.next != null)
            {
                
                _loc_11 = _loc_6.pop_unsafe();
                _loc_2 = _loc_11.a;
                _loc_3 = _loc_11.b;
                _loc_4 = _loc_2.next;
                _loc_5 = null;
                _loc_8 = _loc_2.diagonals.head;
                while (_loc_8 != null)
                {
                    
                    _loc_7 = _loc_8.elt;
                    if (_loc_7 == _loc_3)
                    {
                        _loc_8 = _loc_8.next;
                        if (_loc_8 == null)
                        {
                            _loc_5 = _loc_2.prev;
                        }
                        else
                        {
                            _loc_5 = _loc_8.elt;
                        }
                        break;
                    }
                    _loc_4 = _loc_7;
                    _loc_8 = _loc_8.next;
                }
                _loc_2.diagonals.remove(_loc_3);
                _loc_3.diagonals.remove(_loc_2);
                if (_loc_3 == _loc_4.next)
                {
                    _loc_4.diagonals.add(_loc_5);
                }
                else
                {
                    _loc_8 = _loc_4.diagonals.head;
                    while (_loc_8 != null)
                    {
                        
                        _loc_7 = _loc_8.elt;
                        if (_loc_7 == _loc_3)
                        {
                            _loc_4.diagonals.insert(_loc_8, _loc_5);
                            break;
                        }
                        _loc_8 = _loc_8.next;
                    }
                }
                if (_loc_2 == _loc_5.next)
                {
                    _loc_5.diagonals.add(_loc_4);
                }
                else
                {
                    _loc_8 = _loc_5.diagonals.head;
                    while (_loc_8 != null)
                    {
                        
                        _loc_7 = _loc_8.elt;
                        if (_loc_7 == _loc_2)
                        {
                            _loc_5.diagonals.insert(_loc_8, _loc_4);
                            break;
                        }
                        _loc_8 = _loc_8.next;
                    }
                }
                ZPP_Triangular.edgeSet.remove_node(_loc_11.node);
                _loc_12 = _loc_11;
                _loc_7 = null;
                _loc_12.b = _loc_7;
                _loc_12.a = _loc_7;
                _loc_12.node = null;
                _loc_12.next = ZPP_PartitionPair.zpp_pool;
                ZPP_PartitionPair.zpp_pool = _loc_12;
            }
            _loc_11 = _loc_6;
            _loc_2 = null;
            _loc_11.b = _loc_2;
            _loc_11.a = _loc_2;
            _loc_11.node = null;
            _loc_11.next = ZPP_PartitionPair.zpp_pool;
            ZPP_PartitionPair.zpp_pool = _loc_11;
            return;
        }// end function

        public static function triangulate(param1:ZPP_PartitionedPoly) : ZPP_PartitionedPoly
        {
            var _loc_6:* = null as ZPP_PartitionVertex;
            var _loc_7:* = null as ZPP_PartitionVertex;
            var _loc_8:* = null as ZPP_PartitionVertex;
            var _loc_9:* = null as ZPP_PartitionVertex;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_2:* = param1.vertices;
            var _loc_3:* = param1.vertices;
            var _loc_4:* = param1.vertices.next;
            var _loc_5:* = param1.vertices;
            if (_loc_4 != null)
            {
                _loc_6 = _loc_4;
                do
                {
                    
                    _loc_7 = _loc_6;
                    if (_loc_7.y >= _loc_2.y)
                    {
                        if (_loc_7.y == _loc_2.y)
                        {
                        }
                    }
                    if (_loc_7.x < _loc_2.x)
                    {
                        _loc_2 = _loc_7;
                    }
                    if (_loc_3.y >= _loc_7.y)
                    {
                        if (_loc_3.y == _loc_7.y)
                        {
                        }
                    }
                    if (_loc_3.x < _loc_7.x)
                    {
                        _loc_3 = _loc_7;
                    }
                    _loc_6 = _loc_6.next;
                }while (_loc_6 != _loc_5)
            }
            if (ZPP_Triangular.queue == null)
            {
                ZPP_Triangular.queue = new ZNPList_ZPP_PartitionVertex();
            }
            _loc_4 = _loc_3.prev;
            _loc_5 = _loc_3.next;
            ZPP_Triangular.queue.add(_loc_3);
            do
            {
                
                if (_loc_4 != _loc_2)
                {
                    if (_loc_5 != _loc_2)
                    {
                        if (_loc_4.y >= _loc_5.y)
                        {
                            if (_loc_4.y == _loc_5.y)
                            {
                            }
                        }
                    }
                }
                if (_loc_4.x < _loc_5.x)
                {
                    ZPP_Triangular.queue.add(_loc_5);
                    _loc_5.rightchain = false;
                    _loc_5 = _loc_5.next;
                }
                else
                {
                    ZPP_Triangular.queue.add(_loc_4);
                    _loc_4.rightchain = true;
                    _loc_4 = _loc_4.prev;
                }
                if (_loc_4 == _loc_2)
                {
                }
            }while (_loc_5 != _loc_2)
            ZPP_Triangular.queue.add(_loc_2);
            if (ZPP_Triangular.stack == null)
            {
                ZPP_Triangular.stack = new ZNPList_ZPP_PartitionVertex();
            }
            ZPP_Triangular.stack.add(ZPP_Triangular.queue.pop_unsafe());
            _loc_6 = ZPP_Triangular.queue.pop_unsafe();
            ZPP_Triangular.stack.add(_loc_6);
            while (true)
            {
                
                _loc_7 = ZPP_Triangular.queue.pop_unsafe();
                if (ZPP_Triangular.queue.head == null)
                {
                    break;
                }
                if (_loc_7.rightchain != ZPP_Triangular.stack.head.elt.rightchain)
                {
                    while (true)
                    {
                        
                        _loc_8 = ZPP_Triangular.stack.pop_unsafe();
                        if (ZPP_Triangular.stack.head == null)
                        {
                            break;
                        }
                        param1.add_diagonal(_loc_8, _loc_7);
                    }
                    ZPP_Triangular.stack.add(_loc_6);
                }
                else
                {
                    _loc_8 = ZPP_Triangular.stack.pop_unsafe();
                    while (ZPP_Triangular.stack.head != null)
                    {
                        
                        _loc_9 = ZPP_Triangular.stack.head.elt;
                        _loc_11 = 0;
                        _loc_12 = 0;
                        _loc_11 = _loc_7.x - _loc_8.x;
                        _loc_12 = _loc_7.y - _loc_8.y;
                        _loc_13 = 0;
                        _loc_14 = 0;
                        _loc_13 = _loc_8.x - _loc_9.x;
                        _loc_14 = _loc_8.y - _loc_9.y;
                        _loc_10 = _loc_14 * _loc_11 - _loc_13 * _loc_12;
                        if (_loc_7.rightchain)
                        {
                        }
                        if (_loc_10 < 0)
                        {
                            if (!_loc_7.rightchain)
                            {
                            }
                        }
                        if (_loc_10 <= 0)
                        {
                            break;
                        }
                        param1.add_diagonal(_loc_9, _loc_7);
                        _loc_8 = _loc_9;
                        ZPP_Triangular.stack.pop();
                    }
                    ZPP_Triangular.stack.add(_loc_8);
                }
                ZPP_Triangular.stack.add(_loc_7);
                _loc_6 = _loc_7;
            }
            if (ZPP_Triangular.stack.head != null)
            {
                ZPP_Triangular.stack.pop();
                while (ZPP_Triangular.stack.head != null)
                {
                    
                    _loc_7 = ZPP_Triangular.stack.pop_unsafe();
                    if (ZPP_Triangular.stack.head == null)
                    {
                        break;
                    }
                    param1.add_diagonal(_loc_3, _loc_7);
                }
            }
            return param1;
        }// end function

    }
}
