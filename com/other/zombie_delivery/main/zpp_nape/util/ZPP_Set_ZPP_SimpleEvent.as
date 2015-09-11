package zpp_nape.util
{
    import flash.*;
    import zpp_nape.geom.*;

    public class ZPP_Set_ZPP_SimpleEvent extends Object
    {
        public var swapped:Function;
        public var prev:ZPP_Set_ZPP_SimpleEvent;
        public var parent:ZPP_Set_ZPP_SimpleEvent;
        public var next:ZPP_Set_ZPP_SimpleEvent;
        public var lt:Function;
        public var data:ZPP_SimpleEvent;
        public var colour:int;
        public static var zpp_pool:ZPP_Set_ZPP_SimpleEvent;

        public function ZPP_Set_ZPP_SimpleEvent() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            colour = 0;
            parent = null;
            next = null;
            prev = null;
            data = null;
            swapped = null;
            lt = null;
            return;
        }// end function

        public function verify() : Boolean
        {
            var _loc_1:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_2:* = null as ZPP_SimpleEvent;
            var _loc_3:* = false;
            var _loc_4:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_5:* = null as ZPP_SimpleEvent;
            if (!empty())
            {
                _loc_1 = parent;
                while (_loc_1.prev != null)
                {
                    
                    _loc_1 = _loc_1.prev;
                }
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1.data;
                    _loc_3 = true;
                    if (!empty())
                    {
                        _loc_4 = parent;
                        while (_loc_4.prev != null)
                        {
                            
                            _loc_4 = _loc_4.prev;
                        }
                        while (_loc_4 != null)
                        {
                            
                            _loc_5 = _loc_4.data;
                            if (!_loc_3)
                            {
                                if (!lt(_loc_2, _loc_5))
                                {
                                }
                                if (lt(_loc_5, _loc_2))
                                {
                                    return false;
                                }
                            }
                            else if (_loc_2 == _loc_5)
                            {
                                _loc_3 = false;
                            }
                            else
                            {
                                if (!lt(_loc_5, _loc_2))
                                {
                                }
                                if (lt(_loc_2, _loc_5))
                                {
                                    return false;
                                }
                            }
                            if (_loc_4.next != null)
                            {
                                _loc_4 = _loc_4.next;
                                while (_loc_4.prev != null)
                                {
                                    
                                    _loc_4 = _loc_4.prev;
                                }
                                continue;
                            }
                            do
                            {
                                
                                _loc_4 = _loc_4.parent;
                                if (_loc_4.parent != null)
                                {
                                }
                            }while (_loc_4 == _loc_4.parent.next)
                            _loc_4 = _loc_4.parent;
                        }
                    }
                    if (_loc_1.next != null)
                    {
                        _loc_1 = _loc_1.next;
                        while (_loc_1.prev != null)
                        {
                            
                            _loc_1 = _loc_1.prev;
                        }
                        continue;
                    }
                    do
                    {
                        
                        _loc_1 = _loc_1.parent;
                        if (_loc_1.parent != null)
                        {
                        }
                    }while (_loc_1 == _loc_1.parent.next)
                    _loc_1 = _loc_1.parent;
                }
            }
            return true;
        }// end function

        public function try_insert_bool(event:ZPP_SimpleEvent) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (parent == null)
            {
                if (ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
                {
                    _loc_2 = new ZPP_Set_ZPP_SimpleEvent();
                }
                else
                {
                    _loc_2 = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                    ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_2.next;
                    _loc_2.next = null;
                }
                _loc_2.data = event;
                parent = _loc_2;
            }
            else
            {
                _loc_3 = parent;
                while (true)
                {
                    
                    if (lt(event, _loc_3.data))
                    {
                        if (_loc_3.prev == null)
                        {
                            if (ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
                            {
                                _loc_2 = new ZPP_Set_ZPP_SimpleEvent();
                            }
                            else
                            {
                                _loc_2 = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                                ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_2.next;
                                _loc_2.next = null;
                            }
                            _loc_2.data = event;
                            _loc_3.prev = _loc_2;
                            _loc_2.parent = _loc_3;
                            break;
                        }
                        else
                        {
                            _loc_3 = _loc_3.prev;
                        }
                        continue;
                    }
                    if (lt(_loc_3.data, event))
                    {
                        if (_loc_3.next == null)
                        {
                            if (ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
                            {
                                _loc_2 = new ZPP_Set_ZPP_SimpleEvent();
                            }
                            else
                            {
                                _loc_2 = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                                ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_2.next;
                                _loc_2.next = null;
                            }
                            _loc_2.data = event;
                            _loc_3.next = _loc_2;
                            _loc_2.parent = _loc_3;
                            break;
                        }
                        else
                        {
                            _loc_3 = _loc_3.next;
                        }
                        continue;
                    }
                    break;
                }
            }
            if (_loc_2 == null)
            {
                return false;
            }
            else
            {
                if (_loc_2.parent == null)
                {
                    _loc_2.colour = 1;
                }
                else
                {
                    _loc_2.colour = 0;
                    if (_loc_2.parent.colour == 0)
                    {
                        __fix_dbl_red(_loc_2);
                    }
                }
                return true;
            }
        }// end function

        public function try_insert(event:ZPP_SimpleEvent) : ZPP_Set_ZPP_SimpleEvent
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (parent == null)
            {
                if (ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
                {
                    _loc_2 = new ZPP_Set_ZPP_SimpleEvent();
                }
                else
                {
                    _loc_2 = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                    ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_2.next;
                    _loc_2.next = null;
                }
                _loc_2.data = event;
                parent = _loc_2;
            }
            else
            {
                _loc_3 = parent;
                while (true)
                {
                    
                    if (lt(event, _loc_3.data))
                    {
                        if (_loc_3.prev == null)
                        {
                            if (ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
                            {
                                _loc_2 = new ZPP_Set_ZPP_SimpleEvent();
                            }
                            else
                            {
                                _loc_2 = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                                ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_2.next;
                                _loc_2.next = null;
                            }
                            _loc_2.data = event;
                            _loc_3.prev = _loc_2;
                            _loc_2.parent = _loc_3;
                            break;
                        }
                        else
                        {
                            _loc_3 = _loc_3.prev;
                        }
                        continue;
                    }
                    if (lt(_loc_3.data, event))
                    {
                        if (_loc_3.next == null)
                        {
                            if (ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
                            {
                                _loc_2 = new ZPP_Set_ZPP_SimpleEvent();
                            }
                            else
                            {
                                _loc_2 = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                                ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_2.next;
                                _loc_2.next = null;
                            }
                            _loc_2.data = event;
                            _loc_3.next = _loc_2;
                            _loc_2.parent = _loc_3;
                            break;
                        }
                        else
                        {
                            _loc_3 = _loc_3.next;
                        }
                        continue;
                    }
                    break;
                }
            }
            if (_loc_2 == null)
            {
                return _loc_3;
            }
            else
            {
                if (_loc_2.parent == null)
                {
                    _loc_2.colour = 1;
                }
                else
                {
                    _loc_2.colour = 0;
                    if (_loc_2.parent.colour == 0)
                    {
                        __fix_dbl_red(_loc_2);
                    }
                }
                return _loc_2;
            }
        }// end function

        public function successor_node(event:ZPP_Set_ZPP_SimpleEvent) : ZPP_Set_ZPP_SimpleEvent
        {
            var _loc_2:* = null as ZPP_Set_ZPP_SimpleEvent;
            if (event.next != null)
            {
                event = event.next;
                while (event.prev != null)
                {
                    
                    event = event.prev;
                }
            }
            else
            {
                _loc_2 = event;
                event = event.parent;
                do
                {
                    
                    _loc_2 = event;
                    event = event.parent;
                    if (event != null)
                    {
                    }
                }while (event.prev != _loc_2)
            }
            return event;
        }// end function

        public function successor(event:ZPP_SimpleEvent) : ZPP_SimpleEvent
        {
            var _loc_2:* = successor_node(find(event));
            if (_loc_2 == null)
            {
                return null;
            }
            else
            {
                return _loc_2.data;
            }
        }// end function

        public function size() : int
        {
            var _loc_2:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_3:* = null as ZPP_SimpleEvent;
            var _loc_1:* = 0;
            if (!empty())
            {
                _loc_2 = parent;
                while (_loc_2.prev != null)
                {
                    
                    _loc_2 = _loc_2.prev;
                }
                while (_loc_2 != null)
                {
                    
                    _loc_3 = _loc_2.data;
                    _loc_1++;
                    if (_loc_2.next != null)
                    {
                        _loc_2 = _loc_2.next;
                        while (_loc_2.prev != null)
                        {
                            
                            _loc_2 = _loc_2.prev;
                        }
                        continue;
                    }
                    do
                    {
                        
                        _loc_2 = _loc_2.parent;
                        if (_loc_2.parent != null)
                        {
                        }
                    }while (_loc_2 == _loc_2.parent.next)
                    _loc_2 = _loc_2.parent;
                }
            }
            return _loc_1;
        }// end function

        public function singular() : Boolean
        {
            if (parent != null)
            {
            }
            if (parent.prev == null)
            {
            }
            return parent.next == null;
        }// end function

        public function remove_node(event:ZPP_Set_ZPP_SimpleEvent) : void
        {
            var _loc_2:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_3:* = null as ZPP_SimpleEvent;
            var _loc_4:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_5:* = null as ZPP_Set_ZPP_SimpleEvent;
            if (event.next != null)
            {
            }
            if (event.prev != null)
            {
                _loc_2 = event.next;
                while (_loc_2.prev != null)
                {
                    
                    _loc_2 = _loc_2.prev;
                }
                _loc_3 = event.data;
                event.data = _loc_2.data;
                _loc_2.data = _loc_3;
                if (swapped != null)
                {
                    swapped(event.data, _loc_2.data);
                }
                event = _loc_2;
            }
            if (event.prev == null)
            {
                _loc_2 = event.next;
            }
            else
            {
                _loc_2 = event.prev;
            }
            if (event.colour == 1)
            {
                if (event.prev == null)
                {
                }
                if (event.next != null)
                {
                    _loc_2.colour = 1;
                }
                else if (event.parent != null)
                {
                    _loc_4 = event.parent;
                    while (true)
                    {
                        
                        (_loc_4.colour + 1);
                        (_loc_4.prev.colour - 1);
                        (_loc_4.next.colour - 1);
                        _loc_5 = _loc_4.prev;
                        if (_loc_5.colour == -1)
                        {
                            __fix_neg_red(_loc_5);
                            break;
                        }
                        else if (_loc_5.colour == 0)
                        {
                            if (_loc_5.prev != null)
                            {
                            }
                            if (_loc_5.prev.colour == 0)
                            {
                                __fix_dbl_red(_loc_5.prev);
                                break;
                            }
                            if (_loc_5.next != null)
                            {
                            }
                            if (_loc_5.next.colour == 0)
                            {
                                __fix_dbl_red(_loc_5.next);
                                break;
                            }
                        }
                        _loc_5 = _loc_4.next;
                        if (_loc_5.colour == -1)
                        {
                            __fix_neg_red(_loc_5);
                            break;
                        }
                        else if (_loc_5.colour == 0)
                        {
                            if (_loc_5.prev != null)
                            {
                            }
                            if (_loc_5.prev.colour == 0)
                            {
                                __fix_dbl_red(_loc_5.prev);
                                break;
                            }
                            if (_loc_5.next != null)
                            {
                            }
                            if (_loc_5.next.colour == 0)
                            {
                                __fix_dbl_red(_loc_5.next);
                                break;
                            }
                        }
                        if (_loc_4.colour == 2)
                        {
                            if (_loc_4.parent == null)
                            {
                                _loc_4.colour = 1;
                            }
                            else
                            {
                                _loc_4 = _loc_4.parent;
                                continue;
                            }
                        }
                        break;
                    }
                }
            }
            _loc_4 = event.parent;
            if (_loc_4 == null)
            {
                parent = _loc_2;
            }
            else if (_loc_4.prev == event)
            {
                _loc_4.prev = _loc_2;
            }
            else
            {
                _loc_4.next = _loc_2;
            }
            if (_loc_2 != null)
            {
                _loc_2.parent = _loc_4;
            }
            _loc_4 = null;
            event.next = _loc_4;
            _loc_4 = _loc_4;
            event.prev = _loc_4;
            event.parent = _loc_4;
            _loc_4 = event;
            _loc_4.data = null;
            _loc_4.lt = null;
            _loc_4.swapped = null;
            _loc_4.next = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
            ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_4;
            return;
        }// end function

        public function remove(event:ZPP_SimpleEvent) : void
        {
            var _loc_2:* = find(event);
            remove_node(_loc_2);
            return;
        }// end function

        public function predecessor_node(event:ZPP_Set_ZPP_SimpleEvent) : ZPP_Set_ZPP_SimpleEvent
        {
            var _loc_2:* = null as ZPP_Set_ZPP_SimpleEvent;
            if (event.prev != null)
            {
                event = event.prev;
                while (event.next != null)
                {
                    
                    event = event.next;
                }
            }
            else
            {
                _loc_2 = event;
                event = event.parent;
                do
                {
                    
                    _loc_2 = event;
                    event = event.parent;
                    if (event != null)
                    {
                    }
                }while (event.next != _loc_2)
            }
            return event;
        }// end function

        public function predecessor(event:ZPP_SimpleEvent) : ZPP_SimpleEvent
        {
            var _loc_2:* = predecessor_node(find(event));
            if (_loc_2 == null)
            {
                return null;
            }
            else
            {
                return _loc_2.data;
            }
        }// end function

        public function pop_front() : ZPP_SimpleEvent
        {
            var _loc_1:* = parent;
            while (_loc_1.prev != null)
            {
                
                _loc_1 = _loc_1.prev;
            }
            var _loc_2:* = _loc_1.data;
            remove_node(_loc_1);
            return _loc_2;
        }// end function

        public function lower_bound(event:ZPP_SimpleEvent) : ZPP_SimpleEvent
        {
            var _loc_3:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_4:* = null as ZPP_SimpleEvent;
            var _loc_2:* = null;
            if (!empty())
            {
                _loc_3 = parent;
                while (_loc_3.prev != null)
                {
                    
                    _loc_3 = _loc_3.prev;
                }
                while (_loc_3 != null)
                {
                    
                    _loc_4 = _loc_3.data;
                    if (!lt(_loc_4, event))
                    {
                        _loc_2 = _loc_4;
                        break;
                    }
                    if (_loc_3.next != null)
                    {
                        _loc_3 = _loc_3.next;
                        while (_loc_3.prev != null)
                        {
                            
                            _loc_3 = _loc_3.prev;
                        }
                        continue;
                    }
                    do
                    {
                        
                        _loc_3 = _loc_3.parent;
                        if (_loc_3.parent != null)
                        {
                        }
                    }while (_loc_3 == _loc_3.parent.next)
                    _loc_3 = _loc_3.parent;
                }
            }
            return _loc_2;
        }// end function

        public function insert(event:ZPP_SimpleEvent) : ZPP_Set_ZPP_SimpleEvent
        {
            var _loc_2:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_3:* = null as ZPP_Set_ZPP_SimpleEvent;
            if (ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
            {
                _loc_2 = new ZPP_Set_ZPP_SimpleEvent();
            }
            else
            {
                _loc_2 = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            _loc_2.data = event;
            if (parent == null)
            {
                parent = _loc_2;
            }
            else
            {
                _loc_3 = parent;
                while (true)
                {
                    
                    if (lt(_loc_2.data, _loc_3.data))
                    {
                        if (_loc_3.prev == null)
                        {
                            _loc_3.prev = _loc_2;
                            _loc_2.parent = _loc_3;
                            break;
                        }
                        else
                        {
                            _loc_3 = _loc_3.prev;
                        }
                        continue;
                    }
                    if (_loc_3.next == null)
                    {
                        _loc_3.next = _loc_2;
                        _loc_2.parent = _loc_3;
                        break;
                        continue;
                    }
                    _loc_3 = _loc_3.next;
                }
            }
            if (_loc_2.parent == null)
            {
                _loc_2.colour = 1;
            }
            else
            {
                _loc_2.colour = 0;
                if (_loc_2.parent.colour == 0)
                {
                    __fix_dbl_red(_loc_2);
                }
            }
            return _loc_2;
        }// end function

        public function has_weak(event:ZPP_SimpleEvent) : Boolean
        {
            return find_weak(event) != null;
        }// end function

        public function has(event:ZPP_SimpleEvent) : Boolean
        {
            return find(event) != null;
        }// end function

        public function free() : void
        {
            data = null;
            lt = null;
            swapped = null;
            return;
        }// end function

        public function first() : ZPP_SimpleEvent
        {
            var _loc_1:* = parent;
            while (_loc_1.prev != null)
            {
                
                _loc_1 = _loc_1.prev;
            }
            return _loc_1.data;
        }// end function

        public function find_weak(event:ZPP_SimpleEvent) : ZPP_Set_ZPP_SimpleEvent
        {
            var _loc_2:* = parent;
            while (_loc_2 != null)
            {
                
                if (lt(event, _loc_2.data))
                {
                    _loc_2 = _loc_2.prev;
                    continue;
                }
                if (lt(_loc_2.data, event))
                {
                    _loc_2 = _loc_2.next;
                    continue;
                }
                break;
            }
            return _loc_2;
        }// end function

        public function find(event:ZPP_SimpleEvent) : ZPP_Set_ZPP_SimpleEvent
        {
            var _loc_2:* = parent;
            do
            {
                
                if (lt(event, _loc_2.data))
                {
                    _loc_2 = _loc_2.prev;
                }
                else
                {
                    _loc_2 = _loc_2.next;
                }
                if (_loc_2 != null)
                {
                }
            }while (_loc_2.data != event)
            return _loc_2;
        }// end function

        public function empty() : Boolean
        {
            return parent == null;
        }// end function

        public function clear_with(param1:Function) : void
        {
            var _loc_2:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_3:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_4:* = null as ZPP_Set_ZPP_SimpleEvent;
            if (parent == null)
            {
                return;
            }
            else
            {
                _loc_2 = parent;
                while (_loc_2 != null)
                {
                    
                    if (_loc_2.prev != null)
                    {
                        _loc_2 = _loc_2.prev;
                        continue;
                    }
                    if (_loc_2.next != null)
                    {
                        _loc_2 = _loc_2.next;
                        continue;
                    }
                    this.param1(_loc_2.data);
                    _loc_3 = _loc_2.parent;
                    if (_loc_3 != null)
                    {
                        if (_loc_2 == _loc_3.prev)
                        {
                            _loc_3.prev = null;
                        }
                        else
                        {
                            _loc_3.next = null;
                        }
                        _loc_2.parent = null;
                    }
                    _loc_4 = _loc_2;
                    _loc_4.data = null;
                    _loc_4.lt = null;
                    _loc_4.swapped = null;
                    _loc_4.next = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                    ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_4;
                    _loc_2 = _loc_3;
                }
                parent = null;
            }
            return;
        }// end function

        public function clear_node(event:ZPP_Set_ZPP_SimpleEvent, param2:Function) : ZPP_Set_ZPP_SimpleEvent
        {
            null.param2(event.data);
            var _loc_3:* = event.parent;
            if (_loc_3 != null)
            {
                if (event == _loc_3.prev)
                {
                    _loc_3.prev = null;
                }
                else
                {
                    _loc_3.next = null;
                }
                event.parent = null;
            }
            var _loc_4:* = event;
            _loc_4.data = null;
            _loc_4.lt = null;
            _loc_4.swapped = null;
            _loc_4.next = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
            ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_4;
            return _loc_3;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_2:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_3:* = null as ZPP_Set_ZPP_SimpleEvent;
            if (parent == null)
            {
            }
            else
            {
                _loc_1 = parent;
                while (_loc_1 != null)
                {
                    
                    if (_loc_1.prev != null)
                    {
                        _loc_1 = _loc_1.prev;
                        continue;
                    }
                    if (_loc_1.next != null)
                    {
                        _loc_1 = _loc_1.next;
                        continue;
                    }
                    _loc_2 = _loc_1.parent;
                    if (_loc_2 != null)
                    {
                        if (_loc_1 == _loc_2.prev)
                        {
                            _loc_2.prev = null;
                        }
                        else
                        {
                            _loc_2.next = null;
                        }
                        _loc_1.parent = null;
                    }
                    _loc_3 = _loc_1;
                    _loc_3.data = null;
                    _loc_3.lt = null;
                    _loc_3.swapped = null;
                    _loc_3.next = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
                    ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_3;
                    _loc_1 = _loc_2;
                }
                parent = null;
            }
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public function __fix_neg_red(event:ZPP_Set_ZPP_SimpleEvent) : void
        {
            var _loc_3:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_4:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_5:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_6:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_7:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_8:* = 0;
            var _loc_9:* = null as ZPP_SimpleEvent;
            var _loc_2:* = event.parent;
            if (_loc_2.prev == event)
            {
                _loc_4 = event.prev;
                _loc_5 = event.next;
                _loc_6 = _loc_5.prev;
                _loc_7 = _loc_5.next;
                _loc_4.colour = 0;
                _loc_8 = 1;
                _loc_2.colour = _loc_8;
                event.colour = _loc_8;
                event.next = _loc_6;
                if (_loc_6 != null)
                {
                    _loc_6.parent = event;
                }
                _loc_9 = _loc_2.data;
                _loc_2.data = _loc_5.data;
                _loc_5.data = _loc_9;
                if (swapped != null)
                {
                    swapped(_loc_2.data, _loc_5.data);
                }
                _loc_5.prev = _loc_7;
                if (_loc_7 != null)
                {
                    _loc_7.parent = _loc_5;
                }
                _loc_5.next = _loc_2.next;
                if (_loc_2.next != null)
                {
                    _loc_2.next.parent = _loc_5;
                }
                _loc_2.next = _loc_5;
                if (_loc_5 != null)
                {
                    _loc_5.parent = _loc_2;
                }
                _loc_3 = _loc_4;
            }
            else
            {
                _loc_4 = event.next;
                _loc_5 = event.prev;
                _loc_6 = _loc_5.next;
                _loc_7 = _loc_5.prev;
                _loc_4.colour = 0;
                _loc_8 = 1;
                _loc_2.colour = _loc_8;
                event.colour = _loc_8;
                event.prev = _loc_6;
                if (_loc_6 != null)
                {
                    _loc_6.parent = event;
                }
                _loc_9 = _loc_2.data;
                _loc_2.data = _loc_5.data;
                _loc_5.data = _loc_9;
                if (swapped != null)
                {
                    swapped(_loc_2.data, _loc_5.data);
                }
                _loc_5.next = _loc_7;
                if (_loc_7 != null)
                {
                    _loc_7.parent = _loc_5;
                }
                _loc_5.prev = _loc_2.prev;
                if (_loc_2.prev != null)
                {
                    _loc_2.prev.parent = _loc_5;
                }
                _loc_2.prev = _loc_5;
                if (_loc_5 != null)
                {
                    _loc_5.parent = _loc_2;
                }
                _loc_3 = _loc_4;
            }
            if (_loc_3.prev != null)
            {
            }
            if (_loc_3.prev.colour == 0)
            {
                __fix_dbl_red(_loc_3.prev);
            }
            else
            {
                if (_loc_3.next != null)
                {
                }
                if (_loc_3.next.colour == 0)
                {
                    __fix_dbl_red(_loc_3.next);
                }
            }
            return;
        }// end function

        public function __fix_dbl_red(event:ZPP_Set_ZPP_SimpleEvent) : void
        {
            var _loc_2:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_3:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_4:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_5:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_6:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_7:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_8:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_9:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_10:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_11:* = null as ZPP_Set_ZPP_SimpleEvent;
            while (true)
            {
                
                _loc_2 = event.parent;
                _loc_3 = _loc_2.parent;
                if (_loc_3 == null)
                {
                    _loc_2.colour = 1;
                    break;
                }
                if (_loc_2 == _loc_3.prev)
                {
                    _loc_6 = _loc_3;
                    _loc_10 = _loc_3.next;
                    if (event == _loc_2.prev)
                    {
                        _loc_4 = event;
                        _loc_5 = _loc_2;
                        _loc_7 = event.prev;
                        _loc_8 = event.next;
                        _loc_9 = _loc_2.next;
                    }
                    else
                    {
                        _loc_4 = _loc_2;
                        _loc_5 = event;
                        _loc_7 = _loc_2.prev;
                        _loc_8 = event.prev;
                        _loc_9 = event.next;
                    }
                }
                else
                {
                    _loc_4 = _loc_3;
                    _loc_7 = _loc_3.prev;
                    if (event == _loc_2.prev)
                    {
                        _loc_5 = event;
                        _loc_6 = _loc_2;
                        _loc_8 = event.prev;
                        _loc_9 = event.next;
                        _loc_10 = _loc_2.next;
                    }
                    else
                    {
                        _loc_5 = _loc_2;
                        _loc_6 = event;
                        _loc_8 = _loc_2.prev;
                        _loc_9 = event.prev;
                        _loc_10 = event.next;
                    }
                }
                _loc_11 = _loc_3.parent;
                if (_loc_11 == null)
                {
                    parent = _loc_5;
                }
                else if (_loc_11.prev == _loc_3)
                {
                    _loc_11.prev = _loc_5;
                }
                else
                {
                    _loc_11.next = _loc_5;
                }
                if (_loc_5 != null)
                {
                    _loc_5.parent = _loc_11;
                }
                _loc_4.prev = _loc_7;
                if (_loc_7 != null)
                {
                    _loc_7.parent = _loc_4;
                }
                _loc_4.next = _loc_8;
                if (_loc_8 != null)
                {
                    _loc_8.parent = _loc_4;
                }
                _loc_5.prev = _loc_4;
                if (_loc_4 != null)
                {
                    _loc_4.parent = _loc_5;
                }
                _loc_5.next = _loc_6;
                if (_loc_6 != null)
                {
                    _loc_6.parent = _loc_5;
                }
                _loc_6.prev = _loc_9;
                if (_loc_9 != null)
                {
                    _loc_9.parent = _loc_6;
                }
                _loc_6.next = _loc_10;
                if (_loc_10 != null)
                {
                    _loc_10.parent = _loc_6;
                }
                _loc_5.colour = _loc_3.colour - 1;
                _loc_4.colour = 1;
                _loc_6.colour = 1;
                if (_loc_5 == parent)
                {
                    parent.colour = 1;
                }
                else
                {
                    if (_loc_5.colour == 0)
                    {
                    }
                    if (_loc_5.parent.colour == 0)
                    {
                        event = _loc_5;
                        continue;
                    }
                }
                break;
            }
            return;
        }// end function

    }
}
