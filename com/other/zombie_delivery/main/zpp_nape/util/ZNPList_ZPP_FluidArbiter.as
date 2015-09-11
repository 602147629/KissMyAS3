package zpp_nape.util
{
    import flash.*;
    import zpp_nape.dynamics.*;

    public class ZNPList_ZPP_FluidArbiter extends Object
    {
        public var pushmod:Boolean;
        public var modified:Boolean;
        public var length:int;
        public var head:ZNPNode_ZPP_FluidArbiter;

        public function ZNPList_ZPP_FluidArbiter() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            length = 0;
            pushmod = false;
            modified = false;
            head = null;
            return;
        }// end function

        public function try_remove(param1:ZPP_FluidArbiter) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = head;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3.elt == param1)
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

        public function splice(param1:ZNPNode_ZPP_FluidArbiter, param2:int) : ZNPNode_ZPP_FluidArbiter
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

        public function setbegin(param1:ZNPNode_ZPP_FluidArbiter) : void
        {
            head = param1;
            modified = true;
            pushmod = true;
            return;
        }// end function

        public function reverse() : void
        {
            var _loc_3:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_1:* = head;
            var _loc_2:* = null;
            while (_loc_1 != null)
            {
                
                _loc_3 = _loc_1.next;
                _loc_1.next = _loc_2;
                head = _loc_1;
                _loc_2 = _loc_1;
                _loc_1 = _loc_3;
            }
            modified = true;
            pushmod = true;
            return;
        }// end function

        public function remove(param1:ZPP_FluidArbiter) : void
        {
            var _loc_5:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_6:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_7:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_2:* = null;
            var _loc_3:* = head;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3.elt == param1)
                {
                    if (_loc_2 == null)
                    {
                        _loc_5 = head;
                        _loc_6 = _loc_5.next;
                        head = _loc_6;
                        if (head == null)
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
                    _loc_7 = _loc_5;
                    _loc_7.elt = null;
                    _loc_7.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                    ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_7;
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

        public function pop_unsafe() : ZPP_FluidArbiter
        {
            var _loc_1:* = head.elt;
            pop();
            return _loc_1;
        }// end function

        public function pop() : void
        {
            var _loc_1:* = head;
            head = _loc_1.next;
            var _loc_2:* = _loc_1;
            _loc_2.elt = null;
            _loc_2.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
            ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_2;
            if (head == null)
            {
                pushmod = true;
            }
            modified = true;
            (length - 1);
            return;
        }// end function

        public function iterator_at(param1:int) : ZNPNode_ZPP_FluidArbiter
        {
            var _loc_2:* = head;
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

        public function insert(param1:ZNPNode_ZPP_FluidArbiter, param2:ZPP_FluidArbiter) : ZNPNode_ZPP_FluidArbiter
        {
            var _loc_4:* = null as ZNPNode_ZPP_FluidArbiter;
            if (ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
            {
                _loc_4 = new ZNPNode_ZPP_FluidArbiter();
            }
            else
            {
                _loc_4 = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_4.next;
                _loc_4.next = null;
            }
            _loc_4.elt = param2;
            var _loc_3:* = _loc_4;
            if (param1 == null)
            {
                _loc_3.next = head;
                head = _loc_3;
            }
            else
            {
                _loc_3.next = param1.next;
                param1.next = _loc_3;
            }
            var _loc_5:* = true;
            modified = true;
            pushmod = _loc_5;
            (length + 1);
            return _loc_3;
        }// end function

        public function inlined_try_remove(param1:ZPP_FluidArbiter) : Boolean
        {
            var _loc_5:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_6:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_7:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_2:* = null;
            var _loc_3:* = head;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3.elt == param1)
                {
                    if (_loc_2 == null)
                    {
                        _loc_5 = head;
                        _loc_6 = _loc_5.next;
                        head = _loc_6;
                        if (head == null)
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
                    _loc_7 = _loc_5;
                    _loc_7.elt = null;
                    _loc_7.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                    ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_7;
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

        public function inlined_remove(param1:ZPP_FluidArbiter) : void
        {
            var _loc_5:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_6:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_7:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_2:* = null;
            var _loc_3:* = head;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3.elt == param1)
                {
                    if (_loc_2 == null)
                    {
                        _loc_5 = head;
                        _loc_6 = _loc_5.next;
                        head = _loc_6;
                        if (head == null)
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
                    _loc_7 = _loc_5;
                    _loc_7.elt = null;
                    _loc_7.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                    ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_7;
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

        public function inlined_pop_unsafe() : ZPP_FluidArbiter
        {
            var _loc_1:* = head.elt;
            pop();
            return _loc_1;
        }// end function

        public function inlined_pop() : void
        {
            var _loc_1:* = head;
            head = _loc_1.next;
            var _loc_2:* = _loc_1;
            _loc_2.elt = null;
            _loc_2.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
            ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_2;
            if (head == null)
            {
                pushmod = true;
            }
            modified = true;
            (length - 1);
            return;
        }// end function

        public function inlined_insert(param1:ZNPNode_ZPP_FluidArbiter, param2:ZPP_FluidArbiter) : ZNPNode_ZPP_FluidArbiter
        {
            var _loc_4:* = null as ZNPNode_ZPP_FluidArbiter;
            if (ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
            {
                _loc_4 = new ZNPNode_ZPP_FluidArbiter();
            }
            else
            {
                _loc_4 = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_4.next;
                _loc_4.next = null;
            }
            _loc_4.elt = param2;
            var _loc_3:* = _loc_4;
            if (param1 == null)
            {
                _loc_3.next = head;
                head = _loc_3;
            }
            else
            {
                _loc_3.next = param1.next;
                param1.next = _loc_3;
            }
            var _loc_5:* = true;
            modified = true;
            pushmod = _loc_5;
            (length + 1);
            return _loc_3;
        }// end function

        public function inlined_has(param1:ZPP_FluidArbiter) : Boolean
        {
            var _loc_4:* = null as ZPP_FluidArbiter;
            var _loc_2:* = false;
            var _loc_3:* = head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                if (_loc_4 == param1)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3.next;
            }
            return _loc_2;
        }// end function

        public function inlined_erase(param1:ZNPNode_ZPP_FluidArbiter) : ZNPNode_ZPP_FluidArbiter
        {
            var _loc_2:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_3:* = null as ZNPNode_ZPP_FluidArbiter;
            if (param1 == null)
            {
                _loc_2 = head;
                _loc_3 = _loc_2.next;
                head = _loc_3;
                if (head == null)
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
            var _loc_4:* = _loc_2;
            _loc_4.elt = null;
            _loc_4.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
            ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_4;
            modified = true;
            (length - 1);
            pushmod = true;
            return _loc_3;
        }// end function

        public function inlined_clear() : void
        {
            var _loc_1:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_2:* = null as ZNPNode_ZPP_FluidArbiter;
            while (head != null)
            {
                
                _loc_1 = head;
                head = _loc_1.next;
                _loc_2 = _loc_1;
                _loc_2.elt = null;
                _loc_2.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_2;
                if (head == null)
                {
                    pushmod = true;
                }
                modified = true;
                (length - 1);
            }
            pushmod = true;
            return;
        }// end function

        public function inlined_add(param1:ZPP_FluidArbiter) : ZPP_FluidArbiter
        {
            var _loc_3:* = null as ZNPNode_ZPP_FluidArbiter;
            if (ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
            {
                _loc_3 = new ZNPNode_ZPP_FluidArbiter();
            }
            else
            {
                _loc_3 = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.elt = param1;
            var _loc_2:* = _loc_3;
            _loc_2.next = head;
            head = _loc_2;
            modified = true;
            (length + 1);
            return param1;
        }// end function

        public function has(param1:ZPP_FluidArbiter) : Boolean
        {
            var _loc_4:* = null as ZPP_FluidArbiter;
            var _loc_2:* = false;
            var _loc_3:* = head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                if (_loc_4 == param1)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3.next;
            }
            return _loc_2;
        }// end function

        public function front() : ZPP_FluidArbiter
        {
            return head.elt;
        }// end function

        public function erase(param1:ZNPNode_ZPP_FluidArbiter) : ZNPNode_ZPP_FluidArbiter
        {
            var _loc_2:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_3:* = null as ZNPNode_ZPP_FluidArbiter;
            if (param1 == null)
            {
                _loc_2 = head;
                _loc_3 = _loc_2.next;
                head = _loc_3;
                if (head == null)
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
            var _loc_4:* = _loc_2;
            _loc_4.elt = null;
            _loc_4.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
            ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_4;
            modified = true;
            (length - 1);
            pushmod = true;
            return _loc_3;
        }// end function

        public function empty() : Boolean
        {
            return head == null;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_2:* = null as ZNPNode_ZPP_FluidArbiter;
            while (head != null)
            {
                
                _loc_1 = head;
                head = _loc_1.next;
                _loc_2 = _loc_1;
                _loc_2.elt = null;
                _loc_2.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_2;
                if (head == null)
                {
                    pushmod = true;
                }
                modified = true;
                (length - 1);
            }
            pushmod = true;
            return;
        }// end function

        public function begin() : ZNPNode_ZPP_FluidArbiter
        {
            return head;
        }// end function

        public function back() : ZPP_FluidArbiter
        {
            var _loc_1:* = head;
            var _loc_2:* = _loc_1;
            while (_loc_2 != null)
            {
                
                _loc_1 = _loc_2;
                _loc_2 = _loc_2.next;
            }
            return _loc_1.elt;
        }// end function

        public function at(param1:int) : ZPP_FluidArbiter
        {
            var _loc_2:* = iterator_at(param1);
            if (_loc_2 != null)
            {
                return _loc_2.elt;
            }
            else
            {
                return null;
            }
        }// end function

        public function addAll(param1:ZNPList_ZPP_FluidArbiter) : void
        {
            var _loc_3:* = null as ZPP_FluidArbiter;
            var _loc_2:* = param1.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                add(_loc_3);
                _loc_2 = _loc_2.next;
            }
            return;
        }// end function

        public function add(param1:ZPP_FluidArbiter) : ZPP_FluidArbiter
        {
            var _loc_3:* = null as ZNPNode_ZPP_FluidArbiter;
            if (ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
            {
                _loc_3 = new ZNPNode_ZPP_FluidArbiter();
            }
            else
            {
                _loc_3 = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.elt = param1;
            var _loc_2:* = _loc_3;
            _loc_2.next = head;
            head = _loc_2;
            modified = true;
            (length + 1);
            return param1;
        }// end function

    }
}
