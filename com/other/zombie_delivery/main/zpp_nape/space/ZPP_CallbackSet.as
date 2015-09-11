package zpp_nape.space
{
    import flash.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.phys.*;
    import zpp_nape.util.*;

    public class ZPP_CallbackSet extends Object
    {
        public var pushmod:Boolean;
        public var next:ZPP_CallbackSet;
        public var modified:Boolean;
        public var length:int;
        public var lazydel:Boolean;
        public var int2:ZPP_Interactor;
        public var int1:ZPP_Interactor;
        public var id:int;
        public var freed:Boolean;
        public var di:int;
        public var arbiters:ZNPList_ZPP_Arbiter;
        public var _inuse:Boolean;
        public var SENSORstate:int;
        public var SENSORstamp:int;
        public var FLUIDstate:int;
        public var FLUIDstamp:int;
        public var COLLISIONstate:int;
        public var COLLISIONstamp:int;
        public static var zpp_pool:ZPP_CallbackSet;

        public function ZPP_CallbackSet() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            lazydel = false;
            freed = false;
            length = 0;
            pushmod = false;
            modified = false;
            _inuse = false;
            next = null;
            int2 = null;
            int1 = null;
            di = 0;
            id = 0;
            arbiters = new ZNPList_ZPP_Arbiter();
            return;
        }// end function

        public function try_remove_arb(param1:ZPP_Arbiter) : Boolean
        {
            var _loc_6:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_8:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_2:* = arbiters;
            var _loc_3:* = null;
            var _loc_4:* = _loc_2.head;
            var _loc_5:* = false;
            while (_loc_4 != null)
            {
                
                if (_loc_4.elt == param1)
                {
                    if (_loc_3 == null)
                    {
                        _loc_6 = _loc_2.head;
                        _loc_7 = _loc_6.next;
                        _loc_2.head = _loc_7;
                        if (_loc_2.head == null)
                        {
                            _loc_2.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_6 = _loc_3.next;
                        _loc_7 = _loc_6.next;
                        _loc_3.next = _loc_7;
                        if (_loc_7 == null)
                        {
                            _loc_2.pushmod = true;
                        }
                    }
                    _loc_8 = _loc_6;
                    _loc_8.elt = null;
                    _loc_8.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc_8;
                    _loc_2.modified = true;
                    (_loc_2.length - 1);
                    _loc_2.pushmod = true;
                    _loc_5 = true;
                    break;
                }
                _loc_3 = _loc_4;
                _loc_4 = _loc_4.next;
            }
            return _loc_5;
        }// end function

        public function try_remove(param1:ZPP_CallbackSet) : Boolean
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

        public function splice(param1:ZPP_CallbackSet, param2:int) : ZPP_CallbackSet
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

        public function sleeping() : Boolean
        {
            var _loc_3:* = null as ZPP_Arbiter;
            var _loc_1:* = true;
            var _loc_2:* = arbiters.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                if (_loc_3.sleeping)
                {
                    _loc_2 = _loc_2.next;
                    continue;
                }
                else
                {
                    _loc_1 = false;
                    break;
                }
                _loc_2 = _loc_2.next;
            }
            return _loc_1;
        }// end function

        public function size() : int
        {
            return length;
        }// end function

        public function setbegin(param1:ZPP_CallbackSet) : void
        {
            next = param1;
            modified = true;
            pushmod = true;
            return;
        }// end function

        public function reverse() : void
        {
            var _loc_3:* = null as ZPP_CallbackSet;
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

        public function remove_arb(param1:ZPP_Arbiter) : void
        {
            var _loc_6:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_8:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_2:* = arbiters;
            var _loc_3:* = null;
            var _loc_4:* = _loc_2.head;
            var _loc_5:* = false;
            while (_loc_4 != null)
            {
                
                if (_loc_4.elt == param1)
                {
                    if (_loc_3 == null)
                    {
                        _loc_6 = _loc_2.head;
                        _loc_7 = _loc_6.next;
                        _loc_2.head = _loc_7;
                        if (_loc_2.head == null)
                        {
                            _loc_2.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_6 = _loc_3.next;
                        _loc_7 = _loc_6.next;
                        _loc_3.next = _loc_7;
                        if (_loc_7 == null)
                        {
                            _loc_2.pushmod = true;
                        }
                    }
                    _loc_8 = _loc_6;
                    _loc_8.elt = null;
                    _loc_8.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc_8;
                    _loc_2.modified = true;
                    (_loc_2.length - 1);
                    _loc_2.pushmod = true;
                    _loc_5 = true;
                    break;
                }
                _loc_3 = _loc_4;
                _loc_4 = _loc_4.next;
            }
            return;
        }// end function

        public function remove(param1:ZPP_CallbackSet) : void
        {
            var _loc_5:* = null as ZPP_CallbackSet;
            var _loc_6:* = null as ZPP_CallbackSet;
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

        public function really_empty() : Boolean
        {
            return arbiters.head == null;
        }// end function

        public function pop_unsafe() : ZPP_CallbackSet
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

        public function iterator_at(param1:int) : ZPP_CallbackSet
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

        public function insert(param1:ZPP_CallbackSet, param2:ZPP_CallbackSet) : ZPP_CallbackSet
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

        public function inlined_try_remove(param1:ZPP_CallbackSet) : Boolean
        {
            var _loc_5:* = null as ZPP_CallbackSet;
            var _loc_6:* = null as ZPP_CallbackSet;
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

        public function inlined_remove(param1:ZPP_CallbackSet) : void
        {
            var _loc_5:* = null as ZPP_CallbackSet;
            var _loc_6:* = null as ZPP_CallbackSet;
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

        public function inlined_pop_unsafe() : ZPP_CallbackSet
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

        public function inlined_insert(param1:ZPP_CallbackSet, param2:ZPP_CallbackSet) : ZPP_CallbackSet
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

        public function inlined_has(param1:ZPP_CallbackSet) : Boolean
        {
            var _loc_4:* = null as ZPP_CallbackSet;
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

        public function inlined_erase(param1:ZPP_CallbackSet) : ZPP_CallbackSet
        {
            var _loc_2:* = null as ZPP_CallbackSet;
            var _loc_3:* = null as ZPP_CallbackSet;
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

        public function inlined_add(param1:ZPP_CallbackSet) : ZPP_CallbackSet
        {
            param1._inuse = true;
            var _loc_2:* = param1;
            _loc_2.next = next;
            next = _loc_2;
            modified = true;
            (length + 1);
            return param1;
        }// end function

        public function has(param1:ZPP_CallbackSet) : Boolean
        {
            var _loc_4:* = null as ZPP_CallbackSet;
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

        public function front() : ZPP_CallbackSet
        {
            return next;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null;
            int2 = null;
            int1 = _loc_1;
            var _loc_2:* = -1;
            di = -1;
            id = _loc_2;
            freed = true;
            return;
        }// end function

        public function erase(param1:ZPP_CallbackSet) : ZPP_CallbackSet
        {
            var _loc_2:* = null as ZPP_CallbackSet;
            var _loc_3:* = null as ZPP_CallbackSet;
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

        public function empty_arb(param1:int) : Boolean
        {
            var _loc_4:* = null as ZPP_Arbiter;
            var _loc_2:* = true;
            var _loc_3:* = arbiters.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                if ((_loc_4.type & param1) == 0)
                {
                    _loc_3 = _loc_3.next;
                    continue;
                }
                else
                {
                    _loc_2 = false;
                    break;
                }
                _loc_3 = _loc_3.next;
            }
            return _loc_2;
        }// end function

        public function empty() : Boolean
        {
            return next == null;
        }// end function

        public function elem() : ZPP_CallbackSet
        {
            return this;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function begin() : ZPP_CallbackSet
        {
            return next;
        }// end function

        public function back() : ZPP_CallbackSet
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

        public function at(param1:int) : ZPP_CallbackSet
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
            freed = false;
            lazydel = false;
            COLLISIONstate = ZPP_Flags.id_PreFlag_ACCEPT;
            COLLISIONstamp = 0;
            SENSORstate = ZPP_Flags.id_PreFlag_ACCEPT;
            SENSORstamp = 0;
            FLUIDstate = ZPP_Flags.id_PreFlag_ACCEPT;
            FLUIDstamp = 0;
            return;
        }// end function

        public function add_arb(param1:ZPP_Arbiter) : Boolean
        {
            var _loc_3:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_4:* = null as ZPP_Arbiter;
            var _loc_5:* = null as ZNPList_ZPP_Arbiter;
            var _loc_6:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_2:* = false;
            _loc_3 = arbiters.head;
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
            if (!_loc_2)
            {
                _loc_5 = arbiters;
                if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
                {
                    _loc_6 = new ZNPNode_ZPP_Arbiter();
                }
                else
                {
                    _loc_6 = ZNPNode_ZPP_Arbiter.zpp_pool;
                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.elt = param1;
                _loc_3 = _loc_6;
                _loc_3.next = _loc_5.head;
                _loc_5.head = _loc_3;
                _loc_5.modified = true;
                (_loc_5.length + 1);
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function addAll(param1:ZPP_CallbackSet) : void
        {
            var _loc_3:* = null as ZPP_CallbackSet;
            var _loc_2:* = param1.next;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2;
                add(_loc_3);
                _loc_2 = _loc_2.next;
            }
            return;
        }// end function

        public function add(param1:ZPP_CallbackSet) : ZPP_CallbackSet
        {
            param1._inuse = true;
            var _loc_2:* = param1;
            _loc_2.next = next;
            next = _loc_2;
            modified = true;
            (length + 1);
            return param1;
        }// end function

        public static function get(param1:ZPP_Interactor, param2:ZPP_Interactor) : ZPP_CallbackSet
        {
            var _loc_3:* = null as ZPP_CallbackSet;
            if (ZPP_CallbackSet.zpp_pool == null)
            {
                _loc_3 = new ZPP_CallbackSet();
            }
            else
            {
                _loc_3 = ZPP_CallbackSet.zpp_pool;
                ZPP_CallbackSet.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.freed = false;
            _loc_3.lazydel = false;
            _loc_3.COLLISIONstate = ZPP_Flags.id_PreFlag_ACCEPT;
            _loc_3.COLLISIONstamp = 0;
            _loc_3.SENSORstate = ZPP_Flags.id_PreFlag_ACCEPT;
            _loc_3.SENSORstamp = 0;
            _loc_3.FLUIDstate = ZPP_Flags.id_PreFlag_ACCEPT;
            _loc_3.FLUIDstamp = 0;
            if (param1.id < param2.id)
            {
                _loc_3.int1 = param1;
                _loc_3.int2 = param2;
            }
            else
            {
                _loc_3.int1 = param2;
                _loc_3.int2 = param1;
            }
            _loc_3.id = _loc_3.int1.id;
            _loc_3.di = _loc_3.int2.id;
            return _loc_3;
        }// end function

    }
}
