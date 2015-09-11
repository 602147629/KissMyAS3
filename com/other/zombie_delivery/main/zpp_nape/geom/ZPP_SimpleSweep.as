package zpp_nape.geom
{
    import flash.*;
    import zpp_nape.util.*;

    public class ZPP_SimpleSweep extends Object
    {
        public var tree:ZPP_Set_ZPP_SimpleSeg;
        public var sweepx:Number;

        public function ZPP_SimpleSweep() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            tree = null;
            sweepx = 0;
            if (ZPP_Set_ZPP_SimpleSeg.zpp_pool == null)
            {
                tree = new ZPP_Set_ZPP_SimpleSeg();
            }
            else
            {
                tree = ZPP_Set_ZPP_SimpleSeg.zpp_pool;
                ZPP_Set_ZPP_SimpleSeg.zpp_pool = tree.next;
                tree.next = null;
            }
            tree.lt = edge_lt;
            tree.swapped = swap_nodes;
            return;
        }// end function

        public function swap_nodes(param1:ZPP_SimpleSeg, param2:ZPP_SimpleSeg) : void
        {
            var _loc_3:* = param1.node;
            param1.node = param2.node;
            param2.node = _loc_3;
            return;
        }// end function

        public function remove(param1:ZPP_SimpleSeg) : void
        {
            var _loc_2:* = tree.successor_node(param1.node);
            var _loc_3:* = tree.predecessor_node(param1.node);
            if (_loc_2 != null)
            {
                _loc_2.data.prev = param1.prev;
            }
            if (_loc_3 != null)
            {
                _loc_3.data.next = param1.next;
            }
            tree.remove_node(param1.node);
            param1.node = null;
            return;
        }// end function

        public function intersection(param1:ZPP_SimpleSeg, param2:ZPP_SimpleSeg) : ZPP_SimpleEvent
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = null as ZPP_SimpleVert;
            var _loc_13:* = false;
            var _loc_14:* = null as ZPP_SimpleVert;
            var _loc_15:* = null as ZPP_SimpleEvent;
            var _loc_16:* = null as ZPP_SimpleEvent;
            if (param1 != null)
            {
            }
            if (param2 == null)
            {
                return null;
            }
            else
            {
                if (param1.left != param2.left)
                {
                }
                if (param1.left != param2.right)
                {
                }
                if (param1.right != param2.left)
                {
                }
                if (param1.right == param2.right)
                {
                    return null;
                }
                else
                {
                    _loc_3 = 0;
                    _loc_4 = 0;
                    _loc_3 = param1.right.x - param1.left.x;
                    _loc_4 = param1.right.y - param1.left.y;
                    _loc_5 = 0;
                    _loc_6 = 0;
                    _loc_5 = param2.right.x - param2.left.x;
                    _loc_6 = param2.right.y - param2.left.y;
                    _loc_7 = _loc_6 * _loc_3 - _loc_5 * _loc_4;
                    if (_loc_7 == 0)
                    {
                        return null;
                    }
                    _loc_7 = 1 / _loc_7;
                    _loc_8 = 0;
                    _loc_9 = 0;
                    _loc_8 = param2.left.x - param1.left.x;
                    _loc_9 = param2.left.y - param1.left.y;
                    _loc_10 = (_loc_6 * _loc_8 - _loc_5 * _loc_9) * _loc_7;
                    if (_loc_10 >= 0)
                    {
                    }
                    if (_loc_10 > 1)
                    {
                        return null;
                    }
                    _loc_11 = (_loc_4 * _loc_8 - _loc_3 * _loc_9) * _loc_7;
                    if (_loc_11 >= 0)
                    {
                    }
                    if (_loc_11 > 1)
                    {
                        return null;
                    }
                    if (_loc_11 != 0)
                    {
                    }
                    if (_loc_11 != 1)
                    {
                    }
                    if (_loc_10 != 0)
                    {
                    }
                    if (_loc_10 == 1)
                    {
                        _loc_13 = _loc_11 == 0;
                        if (_loc_11 == 1)
                        {
                        }
                        if (_loc_13)
                        {
                            throw "corner case 1a";
                        }
                        else if (_loc_11 == 1)
                        {
                            _loc_13 = true;
                        }
                        if (_loc_10 == 0)
                        {
                        }
                        if (_loc_13)
                        {
                            throw "corner case 1b";
                        }
                        else if (_loc_10 == 0)
                        {
                            _loc_13 = true;
                        }
                        if (_loc_10 == 1)
                        {
                        }
                        if (_loc_13)
                        {
                            throw "corner case 1c";
                        }
                        if (_loc_11 == 0)
                        {
                            _loc_12 = param2.left;
                        }
                        else if (_loc_11 == 1)
                        {
                            _loc_12 = param2.right;
                        }
                        else if (_loc_10 == 0)
                        {
                            _loc_12 = param1.left;
                        }
                        else
                        {
                            _loc_12 = param1.right;
                        }
                    }
                    else
                    {
                        if (ZPP_SimpleVert.zpp_pool == null)
                        {
                            _loc_14 = new ZPP_SimpleVert();
                        }
                        else
                        {
                            _loc_14 = ZPP_SimpleVert.zpp_pool;
                            ZPP_SimpleVert.zpp_pool = _loc_14.next;
                            _loc_14.next = null;
                        }
                        _loc_14.x = 0.5 * (param1.left.x + _loc_3 * _loc_10 + param2.left.x + _loc_5 * _loc_11);
                        _loc_14.y = 0.5 * (param1.left.y + _loc_4 * _loc_10 + param2.left.y + _loc_6 * _loc_11);
                        _loc_12 = _loc_14;
                    }
                    if (ZPP_SimpleEvent.zpp_pool == null)
                    {
                        _loc_16 = new ZPP_SimpleEvent();
                    }
                    else
                    {
                        _loc_16 = ZPP_SimpleEvent.zpp_pool;
                        ZPP_SimpleEvent.zpp_pool = _loc_16.next;
                        _loc_16.next = null;
                    }
                    _loc_16.vertex = _loc_12;
                    _loc_15 = _loc_16;
                    _loc_15.type = 0;
                    _loc_15.segment = param1;
                    _loc_15.segment2 = param2;
                    return _loc_15;
                }
            }
        }// end function

        public function intersect(param1:ZPP_SimpleSeg, param2:ZPP_SimpleSeg) : Boolean
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            if (param1 != null)
            {
            }
            if (param2 == null)
            {
                return false;
            }
            else
            {
                if (param1.left != param2.left)
                {
                }
                if (param1.left != param2.right)
                {
                }
                if (param1.right != param2.left)
                {
                }
                if (param1.right == param2.right)
                {
                    return false;
                }
                else
                {
                    _loc_3 = (param2.left.x - param1.left.x) * (param1.right.y - param1.left.y) - (param1.right.x - param1.left.x) * (param2.left.y - param1.left.y);
                    _loc_4 = (param2.right.x - param1.left.x) * (param1.right.y - param1.left.y) - (param1.right.x - param1.left.x) * (param2.right.y - param1.left.y);
                    if (_loc_3 * _loc_4 > 0)
                    {
                        return false;
                    }
                    else
                    {
                        _loc_5 = (param1.left.x - param2.left.x) * (param2.right.y - param2.left.y) - (param2.right.x - param2.left.x) * (param1.left.y - param2.left.y);
                        _loc_6 = (param1.right.x - param2.left.x) * (param2.right.y - param2.left.y) - (param2.right.x - param2.left.x) * (param1.right.y - param2.left.y);
                        if (_loc_5 * _loc_6 > 0)
                        {
                            return false;
                        }
                        else
                        {
                            if (_loc_3 * _loc_4 >= 0)
                            {
                            }
                            if (_loc_5 * _loc_6 >= 0)
                            {
                                return true;
                            }
                            else
                            {
                                return true;
                            }
                        }
                    }
                }
            }
        }// end function

        public function edge_lt(param1:ZPP_SimpleSeg, param2:ZPP_SimpleSeg) : Boolean
        {
            var _loc_7:* = false;
            var _loc_8:* = null as ZPP_SimpleVert;
            var _loc_9:* = null as ZPP_SimpleVert;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = false;
            var _loc_13:* = false;
            var _loc_14:* = false;
            var _loc_15:* = false;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (param1.left == param2.left)
            {
            }
            if (param1.right == param2.right)
            {
                return false;
            }
            else if (param1.left == param2.right)
            {
                if (param1.left.x == param1.right.x)
                {
                    if (param1.left.y < param1.right.y)
                    {
                        return param1.left.y > param2.left.y;
                    }
                    else
                    {
                        return param1.right.y > param2.left.y;
                    }
                }
                else
                {
                    _loc_7 = param1.right.x < param1.left.x;
                    _loc_3 = param1.right.x - param1.left.x;
                    _loc_4 = param1.right.y - param1.left.y;
                    _loc_5 = param2.left.x - param1.left.x;
                    _loc_6 = param2.left.y - param1.left.y;
                    return (_loc_7 ? (_loc_4 * _loc_5 - _loc_3 * _loc_6) : (_loc_6 * _loc_3 - _loc_5 * _loc_4)) < 0;
                }
            }
            else if (param1.right == param2.left)
            {
                return !(param2.left.x == param2.right.x ? (param2.left.y < param2.right.y ? (param2.left.y > param1.left.y) : (param2.right.y > param1.left.y)) : (_loc_7 = param2.right.x < param2.left.x, _loc_3 = param2.right.x - param2.left.x, _loc_4 = param2.right.y - param2.left.y, _loc_5 = param1.left.x - param2.left.x, _loc_6 = param1.left.y - param2.left.y, (_loc_7 ? (_loc_4 * _loc_5 - _loc_3 * _loc_6) : (_loc_6 * _loc_3 - _loc_5 * _loc_4)) < 0));
            }
            else if (param1.left == param2.left)
            {
                if (param1.left.x == param1.right.x)
                {
                    if (param1.left.y < param1.right.y)
                    {
                        return param1.left.y > param2.right.y;
                    }
                    else
                    {
                        return param1.right.y > param2.right.y;
                    }
                }
                else
                {
                    _loc_7 = param1.right.x < param1.left.x;
                    _loc_3 = param1.right.x - param1.left.x;
                    _loc_4 = param1.right.y - param1.left.y;
                    _loc_5 = param2.right.x - param1.left.x;
                    _loc_6 = param2.right.y - param1.left.y;
                    return (_loc_7 ? (_loc_4 * _loc_5 - _loc_3 * _loc_6) : (_loc_6 * _loc_3 - _loc_5 * _loc_4)) < 0;
                }
            }
            else if (param1.right == param2.right)
            {
                if (param1.left.x == param1.right.x)
                {
                    if (param1.left.y < param1.right.y)
                    {
                        return param1.left.y > param2.left.y;
                    }
                    else
                    {
                        return param1.right.y > param2.left.y;
                    }
                }
                else
                {
                    _loc_7 = param1.right.x < param1.left.x;
                    _loc_3 = param1.right.x - param1.left.x;
                    _loc_4 = param1.right.y - param1.left.y;
                    _loc_5 = param2.left.x - param1.left.x;
                    _loc_6 = param2.left.y - param1.left.y;
                    return (_loc_7 ? (_loc_4 * _loc_5 - _loc_3 * _loc_6) : (_loc_6 * _loc_3 - _loc_5 * _loc_4)) < 0;
                }
            }
            if (param1.left.x == param1.right.x)
            {
                if (param2.left.x == param2.right.x)
                {
                    if (param1.left.y < param1.right.y)
                    {
                        _loc_8 = param1.right;
                    }
                    else
                    {
                        _loc_8 = param1.left;
                    }
                    if (param2.left.y < param2.right.y)
                    {
                        _loc_9 = param2.right;
                    }
                    else
                    {
                        _loc_9 = param2.left;
                    }
                    return _loc_8.y > _loc_9.y;
                }
                else
                {
                    _loc_7 = param2.right.x < param2.left.x;
                    _loc_3 = param2.right.x - param2.left.x;
                    _loc_4 = param2.right.y - param2.left.y;
                    _loc_5 = param1.left.x - param2.left.x;
                    _loc_6 = param1.left.y - param2.left.y;
                    if (_loc_7)
                    {
                        _loc_10 = _loc_4 * _loc_5 - _loc_3 * _loc_6;
                    }
                    else
                    {
                        _loc_10 = _loc_6 * _loc_3 - _loc_5 * _loc_4;
                    }
                    _loc_7 = param2.right.x < param2.left.x;
                    _loc_3 = param2.right.x - param2.left.x;
                    _loc_4 = param2.right.y - param2.left.y;
                    _loc_5 = param1.right.x - param2.left.x;
                    _loc_6 = param1.right.y - param2.left.y;
                    if (_loc_7)
                    {
                        _loc_11 = _loc_4 * _loc_5 - _loc_3 * _loc_6;
                    }
                    else
                    {
                        _loc_11 = _loc_6 * _loc_3 - _loc_5 * _loc_4;
                    }
                    if (_loc_10 * _loc_11 >= 0)
                    {
                        return _loc_10 >= 0;
                    }
                    else
                    {
                        return sweepx >= param1.left.x;
                    }
                }
            }
            else if (param2.left.x == param2.right.x)
            {
                _loc_7 = param1.right.x < param1.left.x;
                _loc_3 = param1.right.x - param1.left.x;
                _loc_4 = param1.right.y - param1.left.y;
                _loc_5 = param2.left.x - param1.left.x;
                _loc_6 = param2.left.y - param1.left.y;
                if (_loc_7)
                {
                    _loc_10 = _loc_4 * _loc_5 - _loc_3 * _loc_6;
                }
                else
                {
                    _loc_10 = _loc_6 * _loc_3 - _loc_5 * _loc_4;
                }
                _loc_7 = param1.right.x < param1.left.x;
                _loc_3 = param1.right.x - param1.left.x;
                _loc_4 = param1.right.y - param1.left.y;
                _loc_5 = param2.right.x - param1.left.x;
                _loc_6 = param2.right.y - param1.left.y;
                if (_loc_7)
                {
                    _loc_11 = _loc_4 * _loc_5 - _loc_3 * _loc_6;
                }
                else
                {
                    _loc_11 = _loc_6 * _loc_3 - _loc_5 * _loc_4;
                }
                if (_loc_10 * _loc_11 >= 0)
                {
                    return _loc_10 < 0;
                }
                else
                {
                    return sweepx < param2.left.x;
                }
            }
            else
            {
                _loc_7 = param1.right.x < param1.left.x;
                _loc_3 = param1.right.x - param1.left.x;
                _loc_4 = param1.right.y - param1.left.y;
                _loc_5 = param2.left.x - param1.left.x;
                _loc_6 = param2.left.y - param1.left.y;
                _loc_12 = (_loc_7 ? (_loc_4 * _loc_5 - _loc_3 * _loc_6) : (_loc_6 * _loc_3 - _loc_5 * _loc_4)) < 0;
                _loc_7 = param1.right.x < param1.left.x;
                _loc_3 = param1.right.x - param1.left.x;
                _loc_4 = param1.right.y - param1.left.y;
                _loc_5 = param2.right.x - param1.left.x;
                _loc_6 = param2.right.y - param1.left.y;
                _loc_13 = (_loc_7 ? (_loc_4 * _loc_5 - _loc_3 * _loc_6) : (_loc_6 * _loc_3 - _loc_5 * _loc_4)) < 0;
                if (_loc_12 == _loc_13)
                {
                    return _loc_12;
                }
                else
                {
                    _loc_7 = param2.right.x < param2.left.x;
                    _loc_3 = param2.right.x - param2.left.x;
                    _loc_4 = param2.right.y - param2.left.y;
                    _loc_5 = param1.left.x - param2.left.x;
                    _loc_6 = param1.left.y - param2.left.y;
                    _loc_14 = (_loc_7 ? (_loc_4 * _loc_5 - _loc_3 * _loc_6) : (_loc_6 * _loc_3 - _loc_5 * _loc_4)) >= 0;
                    _loc_7 = param2.right.x < param2.left.x;
                    _loc_3 = param2.right.x - param2.left.x;
                    _loc_4 = param2.right.y - param2.left.y;
                    _loc_5 = param1.right.x - param2.left.x;
                    _loc_6 = param1.right.y - param2.left.y;
                    _loc_15 = (_loc_7 ? (_loc_4 * _loc_5 - _loc_3 * _loc_6) : (_loc_6 * _loc_3 - _loc_5 * _loc_4)) >= 0;
                    if (_loc_14 == _loc_15)
                    {
                        return _loc_14;
                    }
                    _loc_10 = (sweepx - param1.left.x) / (param1.right.x - param1.left.x) * (param1.right.y - param1.left.y) + param1.left.y;
                    _loc_11 = (sweepx - param2.left.x) / (param2.right.x - param2.left.x) * (param2.right.y - param2.left.y) + param2.left.y;
                    return _loc_10 > _loc_11;
                }
            }
        }// end function

        public function clear() : void
        {
            tree.clear();
            return;
        }// end function

        public function add(param1:ZPP_SimpleSeg) : ZPP_SimpleSeg
        {
            param1.node = tree.insert(param1);
            var _loc_2:* = tree.successor_node(param1.node);
            var _loc_3:* = tree.predecessor_node(param1.node);
            if (_loc_2 != null)
            {
                param1.next = _loc_2.data;
                _loc_2.data.prev = param1;
            }
            if (_loc_3 != null)
            {
                param1.prev = _loc_3.data;
                _loc_3.data.next = param1;
            }
            return param1;
        }// end function

    }
}
