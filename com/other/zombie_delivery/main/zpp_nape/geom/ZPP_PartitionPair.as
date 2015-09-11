package zpp_nape.geom
{
    import flash.*;
    import zpp_nape.util.*;

    public class ZPP_PartitionPair extends Object
    {
        public var pushmod:Boolean;
        public var node:ZPP_Set_ZPP_PartitionPair;
        public var next:ZPP_PartitionPair;
        public var modified:Boolean;
        public var length:int;
        public var id:int;
        public var di:int;
        public var b:ZPP_PartitionVertex;
        public var a:ZPP_PartitionVertex;
        public var _inuse:Boolean;
        public static var zpp_pool:ZPP_PartitionPair;

        public function ZPP_PartitionPair() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            node = null;
            di = 0;
            id = 0;
            b = null;
            a = null;
            length = 0;
            pushmod = false;
            modified = false;
            _inuse = false;
            next = null;
            return;
        }// end function

        public function try_remove(param1:ZPP_PartitionPair) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = next;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3 == param1)
                {
                    erase(_loc_2);
                    _loc_4 = true;
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            return _loc_4;
        }// end function

        public function splice(param1:ZPP_PartitionPair, param2:int) : ZPP_PartitionPair
        {
            do
            {
                
                erase(param1);
                param2--;
                if (param2 > 0)
                {
                }
            }while (param1.next != null)
            return param1.next;
        }// end function

        public function size() : int
        {
            return length;
        }// end function

        public function setbegin(param1:ZPP_PartitionPair) : void
        {
            next = param1;
            modified = true;
            pushmod = true;
            return;
        }// end function

        public function reverse() : void
        {
            var _loc_3:* = null as ZPP_PartitionPair;
            var _loc_1:* = next;
            var _loc_2:* = null;
            while (_loc_1 != null)
            {
                
                _loc_3 = _loc_1.next;
                _loc_1.next = _loc_2;
                next = _loc_1;
                _loc_2 = _loc_1;
                _loc_1 = _loc_3;
            }
            modified = true;
            pushmod = true;
            return;
        }// end function

        public function remove(param1:ZPP_PartitionPair) : void
        {
            var _loc_5:* = null as ZPP_PartitionPair;
            var _loc_6:* = null as ZPP_PartitionPair;
            var _loc_2:* = null;
            var _loc_3:* = next;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3 == param1)
                {
                    if (_loc_2 == null)
                    {
                        _loc_5 = next;
                        _loc_6 = _loc_5.next;
                        next = _loc_6;
                        if (next == null)
                        {
                            pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_5 = _loc_2.next;
                        _loc_6 = _loc_5.next;
                        _loc_2.next = _loc_6;
                        if (_loc_6 == null)
                        {
                            pushmod = true;
                        }
                    }
                    _loc_5._inuse = false;
                    modified = true;
                    (length - 1);
                    pushmod = true;
                    _loc_4 = true;
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            return;
        }// end function

        public function pop_unsafe() : ZPP_PartitionPair
        {
            var _loc_1:* = next;
            pop();
            return _loc_1;
        }// end function

        public function pop() : void
        {
            var _loc_1:* = next;
            next = _loc_1.next;
            _loc_1._inuse = false;
            if (next == null)
            {
                pushmod = true;
            }
            modified = true;
            (length - 1);
            return;
        }// end function

        public function iterator_at(param1:int) : ZPP_PartitionPair
        {
            var _loc_2:* = next;
            do
            {
                
                _loc_2 = _loc_2.next;
                param1--;
                if (param1 > 0)
                {
                }
            }while (_loc_2 != null)
            return _loc_2;
        }// end function

        public function insert(param1:ZPP_PartitionPair, param2:ZPP_PartitionPair) : ZPP_PartitionPair
        {
            param2._inuse = true;
            var _loc_3:* = param2;
            if (param1 == null)
            {
                _loc_3.next = next;
                next = _loc_3;
            }
            else
            {
                _loc_3.next = param1.next;
                param1.next = _loc_3;
            }
            var _loc_4:* = true;
            modified = true;
            pushmod = _loc_4;
            (length + 1);
            return _loc_3;
        }// end function

        public function inlined_try_remove(param1:ZPP_PartitionPair) : Boolean
        {
            var _loc_5:* = null as ZPP_PartitionPair;
            var _loc_6:* = null as ZPP_PartitionPair;
            var _loc_2:* = null;
            var _loc_3:* = next;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3 == param1)
                {
                    if (_loc_2 == null)
                    {
                        _loc_5 = next;
                        _loc_6 = _loc_5.next;
                        next = _loc_6;
                        if (next == null)
                        {
                            pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_5 = _loc_2.next;
                        _loc_6 = _loc_5.next;
                        _loc_2.next = _loc_6;
                        if (_loc_6 == null)
                        {
                            pushmod = true;
                        }
                    }
                    _loc_5._inuse = false;
                    modified = true;
                    (length - 1);
                    pushmod = true;
                    _loc_4 = true;
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            return _loc_4;
        }// end function

        public function inlined_remove(param1:ZPP_PartitionPair) : void
        {
            var _loc_5:* = null as ZPP_PartitionPair;
            var _loc_6:* = null as ZPP_PartitionPair;
            var _loc_2:* = null;
            var _loc_3:* = next;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3 == param1)
                {
                    if (_loc_2 == null)
                    {
                        _loc_5 = next;
                        _loc_6 = _loc_5.next;
                        next = _loc_6;
                        if (next == null)
                        {
                            pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_5 = _loc_2.next;
                        _loc_6 = _loc_5.next;
                        _loc_2.next = _loc_6;
                        if (_loc_6 == null)
                        {
                            pushmod = true;
                        }
                    }
                    _loc_5._inuse = false;
                    modified = true;
                    (length - 1);
                    pushmod = true;
                    _loc_4 = true;
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            return;
        }// end function

        public function inlined_pop_unsafe() : ZPP_PartitionPair
        {
            var _loc_1:* = next;
            pop();
            return _loc_1;
        }// end function

        public function inlined_pop() : void
        {
            var _loc_1:* = next;
            next = _loc_1.next;
            _loc_1._inuse = false;
            if (next == null)
            {
                pushmod = true;
            }
            modified = true;
            (length - 1);
            return;
        }// end function

        public function inlined_insert(param1:ZPP_PartitionPair, param2:ZPP_PartitionPair) : ZPP_PartitionPair
        {
            param2._inuse = true;
            var _loc_3:* = param2;
            if (param1 == null)
            {
                _loc_3.next = next;
                next = _loc_3;
            }
            else
            {
                _loc_3.next = param1.next;
                param1.next = _loc_3;
            }
            var _loc_4:* = true;
            modified = true;
            pushmod = _loc_4;
            (length + 1);
            return _loc_3;
        }// end function

        public function inlined_has(param1:ZPP_PartitionPair) : Boolean
        {
            var _loc_4:* = null as ZPP_PartitionPair;
            var _loc_2:* = false;
            var _loc_3:* = next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
                if (_loc_4 == param1)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3.next;
            }
            return _loc_2;
        }// end function

        public function inlined_erase(param1:ZPP_PartitionPair) : ZPP_PartitionPair
        {
            var _loc_2:* = null as ZPP_PartitionPair;
            var _loc_3:* = null as ZPP_PartitionPair;
            if (param1 == null)
            {
                _loc_2 = next;
                _loc_3 = _loc_2.next;
                next = _loc_3;
                if (next == null)
                {
                    pushmod = true;
                }
            }
            else
            {
                _loc_2 = param1.next;
                _loc_3 = _loc_2.next;
                param1.next = _loc_3;
                if (_loc_3 == null)
                {
                    pushmod = true;
                }
            }
            _loc_2._inuse = false;
            modified = true;
            (length - 1);
            pushmod = true;
            return _loc_3;
        }// end function

        public function inlined_clear() : void
        {
            return;
        }// end function

        public function inlined_add(param1:ZPP_PartitionPair) : ZPP_PartitionPair
        {
            param1._inuse = true;
            var _loc_2:* = param1;
            _loc_2.next = next;
            next = _loc_2;
            modified = true;
            (length + 1);
            return param1;
        }// end function

        public function has(param1:ZPP_PartitionPair) : Boolean
        {
            var _loc_4:* = null as ZPP_PartitionPair;
            var _loc_2:* = false;
            var _loc_3:* = next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
                if (_loc_4 == param1)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3.next;
            }
            return _loc_2;
        }// end function

        public function front() : ZPP_PartitionPair
        {
            return next;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null;
            b = null;
            a = _loc_1;
            node = null;
            return;
        }// end function

        public function erase(param1:ZPP_PartitionPair) : ZPP_PartitionPair
        {
            var _loc_2:* = null as ZPP_PartitionPair;
            var _loc_3:* = null as ZPP_PartitionPair;
            if (param1 == null)
            {
                _loc_2 = next;
                _loc_3 = _loc_2.next;
                next = _loc_3;
                if (next == null)
                {
                    pushmod = true;
                }
            }
            else
            {
                _loc_2 = param1.next;
                _loc_3 = _loc_2.next;
                param1.next = _loc_3;
                if (_loc_3 == null)
                {
                    pushmod = true;
                }
            }
            _loc_2._inuse = false;
            modified = true;
            (length - 1);
            pushmod = true;
            return _loc_3;
        }// end function

        public function empty() : Boolean
        {
            return next == null;
        }// end function

        public function elem() : ZPP_PartitionPair
        {
            return this;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function begin() : ZPP_PartitionPair
        {
            return next;
        }// end function

        public function back() : ZPP_PartitionPair
        {
            var _loc_1:* = next;
            var _loc_2:* = _loc_1;
            while (_loc_2 != null)
            {
                
                _loc_1 = _loc_2;
                _loc_2 = _loc_2.next;
            }
            return _loc_1;
        }// end function

        public function at(param1:int) : ZPP_PartitionPair
        {
            var _loc_2:* = iterator_at(param1);
            if (_loc_2 != null)
            {
                return _loc_2;
            }
            else
            {
                return null;
            }
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public function addAll(param1:ZPP_PartitionPair) : void
        {
            var _loc_3:* = null as ZPP_PartitionPair;
            var _loc_2:* = param1.next;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2;
                add(_loc_3);
                _loc_2 = _loc_2.next;
            }
            return;
        }// end function

        public function add(param1:ZPP_PartitionPair) : ZPP_PartitionPair
        {
            param1._inuse = true;
            var _loc_2:* = param1;
            _loc_2.next = next;
            next = _loc_2;
            modified = true;
            (length + 1);
            return param1;
        }// end function

        public static function get(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : ZPP_PartitionPair
        {
            var _loc_3:* = null as ZPP_PartitionPair;
            if (ZPP_PartitionPair.zpp_pool == null)
            {
                _loc_3 = new ZPP_PartitionPair();
            }
            else
            {
                _loc_3 = ZPP_PartitionPair.zpp_pool;
                ZPP_PartitionPair.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.a = param1;
            _loc_3.b = param2;
            if (param1.id < param2.id)
            {
                _loc_3.id = param1.id;
                _loc_3.di = param2.id;
            }
            else
            {
                _loc_3.id = param2.id;
                _loc_3.di = param1.id;
            }
            return _loc_3;
        }// end function

        public static function edge_swap(param1:ZPP_PartitionPair, param2:ZPP_PartitionPair) : void
        {
            var _loc_3:* = param1.node;
            param1.node = param2.node;
            param2.node = _loc_3;
            return;
        }// end function

        public static function edge_lt(param1:ZPP_PartitionPair, param2:ZPP_PartitionPair) : Boolean
        {
            if (param1.id >= param2.id)
            {
                if (param1.id == param2.id)
                {
                }
            }
            return param1.di < param2.di;
        }// end function

    }
}
