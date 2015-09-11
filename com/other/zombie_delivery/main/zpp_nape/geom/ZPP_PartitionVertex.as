package zpp_nape.geom
{
    import flash.*;
    import zpp_nape.util.*;

    public class ZPP_PartitionVertex extends Object
    {
        public var y:Number;
        public var x:Number;
        public var type:int;
        public var rightchain:Boolean;
        public var prev:ZPP_PartitionVertex;
        public var node:ZPP_Set_ZPP_PartitionVertex;
        public var next:ZPP_PartitionVertex;
        public var mag:Number;
        public var id:int;
        public var helper:ZPP_PartitionVertex;
        public var forced:Boolean;
        public var diagonals:ZNPList_ZPP_PartitionVertex;
        public static var nextId:int;
        public static var zpp_pool:ZPP_PartitionVertex;

        public function ZPP_PartitionVertex() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            node = null;
            prev = null;
            next = null;
            rightchain = false;
            helper = null;
            type = 0;
            diagonals = null;
            forced = false;
            y = 0;
            x = 0;
            mag = 0;
            id = 0;
            var _loc_1:* = ZPP_PartitionVertex.nextId;
            (ZPP_PartitionVertex.nextId + 1);
            id = _loc_1;
            diagonals = new ZNPList_ZPP_PartitionVertex();
            return;
        }// end function

        public function sort() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_8:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_9:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_10:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_11:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_12:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = NaN;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_1 = prev.x - x;
            _loc_2 = prev.y - y;
            _loc_3 = next.x - x;
            _loc_4 = next.y - y;
            _loc_6 = _loc_4 * _loc_1 - _loc_3 * _loc_2;
            if (_loc_6 > 0)
            {
                _loc_5 = -1;
            }
            else if (_loc_6 == 0)
            {
                _loc_5 = 0;
            }
            else
            {
                _loc_5 = 1;
            }
            var _loc_7:* = diagonals;
            if (_loc_7.head != null)
            {
            }
            if (_loc_7.head.next != null)
            {
                _loc_8 = _loc_7.head;
                _loc_9 = null;
                _loc_10 = null;
                _loc_11 = null;
                _loc_12 = null;
                _loc_13 = 1;
                do
                {
                    
                    _loc_14 = 0;
                    _loc_10 = _loc_8;
                    _loc_8 = null;
                    _loc_9 = _loc_8;
                    while (_loc_10 != null)
                    {
                        
                        _loc_14++;
                        _loc_11 = _loc_10;
                        _loc_15 = 0;
                        _loc_16 = _loc_13;
                        do
                        {
                            
                            _loc_15++;
                            _loc_11 = _loc_11.next;
                            if (_loc_11 != null)
                            {
                            }
                        }while (_loc_15 < _loc_13)
                        do
                        {
                            
                            if (_loc_15 == 0)
                            {
                                _loc_12 = _loc_11;
                                _loc_11 = _loc_11.next;
                                _loc_16--;
                            }
                            else
                            {
                                if (_loc_16 != 0)
                                {
                                }
                                if (_loc_11 == null)
                                {
                                    _loc_12 = _loc_10;
                                    _loc_10 = _loc_10.next;
                                    _loc_15--;
                                }
                                else
                                {
                                    if (_loc_6 > 0)
                                    {
                                    }
                                    else if (_loc_6 == 0)
                                    {
                                    }
                                    else
                                    {
                                    }
                                    if (_loc_6 > 0)
                                    {
                                    }
                                    else if (_loc_6 == 0)
                                    {
                                    }
                                    else
                                    {
                                    }
                                    if (_loc_17 * _loc_18 != 1)
                                    {
                                        if (_loc_17 * _loc_18 == 0)
                                        {
                                            if (_loc_17 != 1)
                                            {
                                            }
                                        }
                                    }
                                    if (_loc_17 != -1)
                                    {
                                    }
                                    if (_loc_17 == 0)
                                    {
                                    }
                                    if (_loc_6 < 0)
                                    {
                                    }
                                    if (_loc_19 < 0)
                                    {
                                    }
                                    if (_loc_6 == 0 ? (_loc_1 = _loc_10.elt.x - x, _loc_2 = _loc_10.elt.y - y, _loc_3 = _loc_11.elt.x - x, _loc_4 = _loc_11.elt.y - y, _loc_6 = _loc_4 * _loc_1 - _loc_3 * _loc_2, (_loc_6 > 0 ? (-1) : (_loc_6 == 0 ? (0) : (1))) == 1) : (_loc_1 = prev.x - x, _loc_2 = prev.y - y, _loc_3 = _loc_10.elt.x - x, _loc_4 = _loc_10.elt.y - y, _loc_6 = _loc_4 * _loc_1 - _loc_3 * _loc_2, if (!(_loc_6 > 0)) goto 696, _loc_17 = -1, // Jump to 718, if (!(_loc_6 == 0)) goto 713, _loc_17 = 0, // Jump to 718, _loc_17 = 1, _loc_1 = prev.x - x, _loc_2 = prev.y - y, _loc_3 = _loc_11.elt.x - x, _loc_4 = _loc_11.elt.y - y, _loc_6 = _loc_4 * _loc_1 - _loc_3 * _loc_2, if (!(_loc_6 > 0)) goto 817, _loc_18 = -1, // Jump to 839, if (!(_loc_6 == 0)) goto 834, _loc_18 = 0, // Jump to 839, _loc_18 = 1, if (_loc_17 * _loc_18 == 1) goto 883, if (!(_loc_17 * _loc_18 == 0)) goto 882, if (_loc_17 == 1) goto 881, _loc_18 == 1 ? (_loc_1 = _loc_10.elt.x - x, _loc_2 = _loc_10.elt.y - y, _loc_3 = _loc_11.elt.x - x, _loc_4 = _loc_11.elt.y - y, _loc_6 = _loc_4 * _loc_1 - _loc_3 * _loc_2, (_loc_6 > 0 ? (-1) : (_loc_6 == 0 ? (0) : (1))) == 1) : (if (_loc_17 == -1) goto 1020, _loc_18 == -1 ? (_loc_18 == -1) : (if (!(_loc_17 == 0)) goto 1049, _loc_18 == 0 ? (_loc_1 = x - prev.x, _loc_2 = y - prev.y, _loc_3 = _loc_10.elt.x - x, _loc_4 = _loc_10.elt.y - y, _loc_6 = _loc_1 * _loc_3 + _loc_2 * _loc_4, _loc_3 = _loc_11.elt.x - x, _loc_4 = _loc_11.elt.y - y, _loc_19 = _loc_1 * _loc_3 + _loc_2 * _loc_4, if (!(_loc_6 < 0)) goto 1199, _loc_19 > 0 ? (true) : (if (!(_loc_19 < 0)) goto 1224, _loc_6 > 0 ? (false) : (true))) : (true)))))
                                    {
                                        _loc_12 = _loc_10;
                                        _loc_10 = _loc_10.next;
                                        _loc_15--;
                                    }
                                    else
                                    {
                                        _loc_12 = _loc_11;
                                        _loc_11 = _loc_11.next;
                                        _loc_16--;
                                    }
                                }
                            }
                            if (_loc_9 != null)
                            {
                                _loc_9.next = _loc_12;
                            }
                            else
                            {
                                _loc_8 = _loc_12;
                            }
                            _loc_9 = _loc_12;
                            if (_loc_15 <= 0)
                            {
                                if (_loc_16 > 0)
                                {
                                }
                            }
                        }while (_loc_11 != null)
                        _loc_10 = _loc_11;
                    }
                    _loc_9.next = null;
                    _loc_13 = _loc_13 << 1;
                }while (_loc_14 > 1)
                _loc_7.head = _loc_8;
                _loc_7.modified = true;
                _loc_7.pushmod = true;
            }
            return;
        }// end function

        public function free() : void
        {
            helper = null;
            return;
        }// end function

        public function copy() : ZPP_PartitionVertex
        {
            var _loc_1:* = null as ZPP_PartitionVertex;
            if (ZPP_PartitionVertex.zpp_pool == null)
            {
                _loc_1 = new ZPP_PartitionVertex();
            }
            else
            {
                _loc_1 = ZPP_PartitionVertex.zpp_pool;
                ZPP_PartitionVertex.zpp_pool = _loc_1.next;
                _loc_1.next = null;
            }
            _loc_1.x = x;
            _loc_1.y = y;
            _loc_1.forced = forced;
            return _loc_1;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function get(param1:ZPP_GeomVert) : ZPP_PartitionVertex
        {
            var _loc_2:* = null as ZPP_PartitionVertex;
            if (ZPP_PartitionVertex.zpp_pool == null)
            {
                _loc_2 = new ZPP_PartitionVertex();
            }
            else
            {
                _loc_2 = ZPP_PartitionVertex.zpp_pool;
                ZPP_PartitionVertex.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            _loc_2.x = param1.x;
            _loc_2.y = param1.y;
            return _loc_2;
        }// end function

        public static function rightdistance(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Number
        {
            var _loc_3:* = param1.next.y > param1.y;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_4 = param1.next.x - param1.x;
            _loc_5 = param1.next.y - param1.y;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_6 = param2.x - param1.x;
            _loc_7 = param2.y - param1.y;
            return (_loc_3 ? (-1) : (1)) * (_loc_7 * _loc_4 - _loc_6 * _loc_5);
        }// end function

        public static function vert_lt(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            if (param2 != param1)
            {
            }
            if (param2 == param1.next)
            {
                return true;
            }
            else if (param1.y == param1.next.y)
            {
                _loc_3 = param1.x;
                _loc_4 = param1.next.x;
                return (_loc_3 < _loc_4 ? (_loc_3) : (_loc_4)) <= param2.x;
            }
            else
            {
                return ZPP_PartitionVertex.rightdistance(param1, param2) <= 0;
            }
        }// end function

        public static function edge_swap(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : void
        {
            var _loc_3:* = param1.node;
            param1.node = param2.node;
            param2.node = _loc_3;
            return;
        }// end function

        public static function edge_lt(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            if (param1 == param2)
            {
            }
            if (param1.next == param2.next)
            {
                return false;
            }
            if (param1 == param2.next)
            {
                return !ZPP_PartitionVertex.vert_lt(param1, param2);
            }
            else if (param2 == param1.next)
            {
                return ZPP_PartitionVertex.vert_lt(param2, param1);
            }
            else if (param1.y == param1.next.y)
            {
                if (param2.y == param2.next.y)
                {
                    _loc_3 = param1.x;
                    _loc_4 = param1.next.x;
                    _loc_3 = param2.x;
                    _loc_4 = param2.next.x;
                    return (_loc_3 > _loc_4 ? (_loc_3) : (_loc_4)) > (_loc_3 > _loc_4 ? (_loc_3) : (_loc_4));
                }
                else
                {
                    if (ZPP_PartitionVertex.rightdistance(param2, param1) <= 0)
                    {
                    }
                    return ZPP_PartitionVertex.rightdistance(param2, param1.next) > 0;
                }
            }
            else
            {
                _loc_3 = ZPP_PartitionVertex.rightdistance(param1, param2);
                _loc_4 = ZPP_PartitionVertex.rightdistance(param1, param2.next);
                if (_loc_3 == 0)
                {
                }
                if (_loc_4 == 0)
                {
                    _loc_5 = param1.x;
                    _loc_6 = param1.next.x;
                    _loc_5 = param2.x;
                    _loc_6 = param2.next.x;
                    return (_loc_5 > _loc_6 ? (_loc_5) : (_loc_6)) > (_loc_5 > _loc_6 ? (_loc_5) : (_loc_6));
                }
                if (_loc_3 * _loc_4 >= 0)
                {
                    if (_loc_3 >= 0)
                    {
                    }
                    return _loc_4 < 0;
                }
                _loc_5 = ZPP_PartitionVertex.rightdistance(param2, param1);
                _loc_6 = ZPP_PartitionVertex.rightdistance(param2, param1.next);
                if (_loc_5 * _loc_6 >= 0)
                {
                    if (_loc_5 <= 0)
                    {
                    }
                    return _loc_6 > 0;
                }
                return false;
            }
        }// end function

    }
}
