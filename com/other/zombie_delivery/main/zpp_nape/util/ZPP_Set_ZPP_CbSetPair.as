package zpp_nape.util
{
    import flash.*;
    import zpp_nape.callbacks.*;

    public class ZPP_Set_ZPP_CbSetPair extends Object
    {
        public var swapped:Function;
        public var prev:ZPP_Set_ZPP_CbSetPair;
        public var parent:ZPP_Set_ZPP_CbSetPair;
        public var next:ZPP_Set_ZPP_CbSetPair;
        public var lt:Function;
        public var data:ZPP_CbSetPair;
        public var colour:int;
        public static var zpp_pool:ZPP_Set_ZPP_CbSetPair;

        public function ZPP_Set_ZPP_CbSetPair() : void
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
            var _loc_1:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_2:* = null as ZPP_CbSetPair;
            var _loc_3:* = false;
            var _loc_4:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_5:* = null as ZPP_CbSetPair;
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

        public function try_insert_bool(param1:ZPP_CbSetPair) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (parent == null)
            {
                if (ZPP_Set_ZPP_CbSetPair.zpp_pool == null)
                {
                    _loc_2 = new ZPP_Set_ZPP_CbSetPair();
                }
                else
                {
                    _loc_2 = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                    ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_2.next;
                    _loc_2.next = null;
                }
                _loc_2.data = param1;
                parent = _loc_2;
            }
            else
            {
                _loc_3 = parent;
                while (true)
                {
                    
                    if (lt(param1, _loc_3.data))
                    {
                        if (_loc_3.prev == null)
                        {
                            if (ZPP_Set_ZPP_CbSetPair.zpp_pool == null)
                            {
                                _loc_2 = new ZPP_Set_ZPP_CbSetPair();
                            }
                            else
                            {
                                _loc_2 = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                                ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_2.next;
                                _loc_2.next = null;
                            }
                            _loc_2.data = param1;
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
                    if (lt(_loc_3.data, param1))
                    {
                        if (_loc_3.next == null)
                        {
                            if (ZPP_Set_ZPP_CbSetPair.zpp_pool == null)
                            {
                                _loc_2 = new ZPP_Set_ZPP_CbSetPair();
                            }
                            else
                            {
                                _loc_2 = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                                ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_2.next;
                                _loc_2.next = null;
                            }
                            _loc_2.data = param1;
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

        public function try_insert(param1:ZPP_CbSetPair) : ZPP_Set_ZPP_CbSetPair
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (parent == null)
            {
                if (ZPP_Set_ZPP_CbSetPair.zpp_pool == null)
                {
                    _loc_2 = new ZPP_Set_ZPP_CbSetPair();
                }
                else
                {
                    _loc_2 = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                    ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_2.next;
                    _loc_2.next = null;
                }
                _loc_2.data = param1;
                parent = _loc_2;
            }
            else
            {
                _loc_3 = parent;
                while (true)
                {
                    
                    if (lt(param1, _loc_3.data))
                    {
                        if (_loc_3.prev == null)
                        {
                            if (ZPP_Set_ZPP_CbSetPair.zpp_pool == null)
                            {
                                _loc_2 = new ZPP_Set_ZPP_CbSetPair();
                            }
                            else
                            {
                                _loc_2 = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                                ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_2.next;
                                _loc_2.next = null;
                            }
                            _loc_2.data = param1;
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
                    if (lt(_loc_3.data, param1))
                    {
                        if (_loc_3.next == null)
                        {
                            if (ZPP_Set_ZPP_CbSetPair.zpp_pool == null)
                            {
                                _loc_2 = new ZPP_Set_ZPP_CbSetPair();
                            }
                            else
                            {
                                _loc_2 = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                                ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_2.next;
                                _loc_2.next = null;
                            }
                            _loc_2.data = param1;
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

        public function successor_node(param1:ZPP_Set_ZPP_CbSetPair) : ZPP_Set_ZPP_CbSetPair
        {
            var _loc_2:* = null as ZPP_Set_ZPP_CbSetPair;
            if (param1.next != null)
            {
                param1 = param1.next;
                while (param1.prev != null)
                {
                    
                    param1 = param1.prev;
                }
            }
            else
            {
                _loc_2 = param1;
                param1 = param1.parent;
                do
                {
                    
                    _loc_2 = param1;
                    param1 = param1.parent;
                    if (param1 != null)
                    {
                    }
                }while (param1.prev != _loc_2)
            }
            return param1;
        }// end function

        public function successor(param1:ZPP_CbSetPair) : ZPP_CbSetPair
        {
            var _loc_2:* = successor_node(find(param1));
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
            var _loc_2:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_3:* = null as ZPP_CbSetPair;
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

        public function remove_node(param1:ZPP_Set_ZPP_CbSetPair) : void
        {
            var _loc_2:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_3:* = null as ZPP_CbSetPair;
            var _loc_4:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_5:* = null as ZPP_Set_ZPP_CbSetPair;
            if (param1.next != null)
            {
            }
            if (param1.prev != null)
            {
                _loc_2 = param1.next;
                while (_loc_2.prev != null)
                {
                    
                    _loc_2 = _loc_2.prev;
                }
                _loc_3 = param1.data;
                param1.data = _loc_2.data;
                _loc_2.data = _loc_3;
                if (swapped != null)
                {
                    swapped(param1.data, _loc_2.data);
                }
                param1 = _loc_2;
            }
            if (param1.prev == null)
            {
                _loc_2 = param1.next;
            }
            else
            {
                _loc_2 = param1.prev;
            }
            if (param1.colour == 1)
            {
                if (param1.prev == null)
                {
                }
                if (param1.next != null)
                {
                    _loc_2.colour = 1;
                }
                else if (param1.parent != null)
                {
                    _loc_4 = param1.parent;
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
            _loc_4 = param1.parent;
            if (_loc_4 == null)
            {
                parent = _loc_2;
            }
            else if (_loc_4.prev == param1)
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
            param1.next = _loc_4;
            _loc_4 = _loc_4;
            param1.prev = _loc_4;
            param1.parent = _loc_4;
            _loc_4 = param1;
            _loc_4.data = null;
            _loc_4.lt = null;
            _loc_4.swapped = null;
            _loc_4.next = ZPP_Set_ZPP_CbSetPair.zpp_pool;
            ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_4;
            return;
        }// end function

        public function remove(param1:ZPP_CbSetPair) : void
        {
            var _loc_2:* = find(param1);
            remove_node(_loc_2);
            return;
        }// end function

        public function predecessor_node(param1:ZPP_Set_ZPP_CbSetPair) : ZPP_Set_ZPP_CbSetPair
        {
            var _loc_2:* = null as ZPP_Set_ZPP_CbSetPair;
            if (param1.prev != null)
            {
                param1 = param1.prev;
                while (param1.next != null)
                {
                    
                    param1 = param1.next;
                }
            }
            else
            {
                _loc_2 = param1;
                param1 = param1.parent;
                do
                {
                    
                    _loc_2 = param1;
                    param1 = param1.parent;
                    if (param1 != null)
                    {
                    }
                }while (param1.next != _loc_2)
            }
            return param1;
        }// end function

        public function predecessor(param1:ZPP_CbSetPair) : ZPP_CbSetPair
        {
            var _loc_2:* = predecessor_node(find(param1));
            if (_loc_2 == null)
            {
                return null;
            }
            else
            {
                return _loc_2.data;
            }
        }// end function

        public function pop_front() : ZPP_CbSetPair
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

        public function lower_bound(param1:ZPP_CbSetPair) : ZPP_CbSetPair
        {
            var _loc_3:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_4:* = null as ZPP_CbSetPair;
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
                    if (!lt(_loc_4, param1))
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

        public function insert(param1:ZPP_CbSetPair) : ZPP_Set_ZPP_CbSetPair
        {
            var _loc_2:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_3:* = null as ZPP_Set_ZPP_CbSetPair;
            if (ZPP_Set_ZPP_CbSetPair.zpp_pool == null)
            {
                _loc_2 = new ZPP_Set_ZPP_CbSetPair();
            }
            else
            {
                _loc_2 = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            _loc_2.data = param1;
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

        public function has_weak(param1:ZPP_CbSetPair) : Boolean
        {
            return find_weak(param1) != null;
        }// end function

        public function has(param1:ZPP_CbSetPair) : Boolean
        {
            return find(param1) != null;
        }// end function

        public function free() : void
        {
            data = null;
            lt = null;
            swapped = null;
            return;
        }// end function

        public function first() : ZPP_CbSetPair
        {
            var _loc_1:* = parent;
            while (_loc_1.prev != null)
            {
                
                _loc_1 = _loc_1.prev;
            }
            return _loc_1.data;
        }// end function

        public function find_weak(param1:ZPP_CbSetPair) : ZPP_Set_ZPP_CbSetPair
        {
            var _loc_2:* = parent;
            while (_loc_2 != null)
            {
                
                if (lt(param1, _loc_2.data))
                {
                    _loc_2 = _loc_2.prev;
                    continue;
                }
                if (lt(_loc_2.data, param1))
                {
                    _loc_2 = _loc_2.next;
                    continue;
                }
                break;
            }
            return _loc_2;
        }// end function

        public function find(param1:ZPP_CbSetPair) : ZPP_Set_ZPP_CbSetPair
        {
            var _loc_2:* = parent;
            do
            {
                
                if (lt(param1, _loc_2.data))
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
            }while (_loc_2.data != param1)
            return _loc_2;
        }// end function

        public function empty() : Boolean
        {
            return parent == null;
        }// end function

        public function clear_with(param1:Function) : void
        {
            var _loc_2:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_3:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_4:* = null as ZPP_Set_ZPP_CbSetPair;
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
                    _loc_4.next = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                    ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_4;
                    _loc_2 = _loc_3;
                }
                parent = null;
            }
            return;
        }// end function

        public function clear_node(param1:ZPP_Set_ZPP_CbSetPair, param2:Function) : ZPP_Set_ZPP_CbSetPair
        {
            null.param2(param1.data);
            var _loc_3:* = param1.parent;
            if (_loc_3 != null)
            {
                if (param1 == _loc_3.prev)
                {
                    _loc_3.prev = null;
                }
                else
                {
                    _loc_3.next = null;
                }
                param1.parent = null;
            }
            var _loc_4:* = param1;
            _loc_4.data = null;
            _loc_4.lt = null;
            _loc_4.swapped = null;
            _loc_4.next = ZPP_Set_ZPP_CbSetPair.zpp_pool;
            ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_4;
            return _loc_3;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_2:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_3:* = null as ZPP_Set_ZPP_CbSetPair;
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
                    _loc_3.next = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                    ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_3;
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

        public function __fix_neg_red(param1:ZPP_Set_ZPP_CbSetPair) : void
        {
            var _loc_3:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_4:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_5:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_6:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_7:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_8:* = 0;
            var _loc_9:* = null as ZPP_CbSetPair;
            var _loc_2:* = param1.parent;
            if (_loc_2.prev == param1)
            {
                _loc_4 = param1.prev;
                _loc_5 = param1.next;
                _loc_6 = _loc_5.prev;
                _loc_7 = _loc_5.next;
                _loc_4.colour = 0;
                _loc_8 = 1;
                _loc_2.colour = _loc_8;
                param1.colour = _loc_8;
                param1.next = _loc_6;
                if (_loc_6 != null)
                {
                    _loc_6.parent = param1;
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
                _loc_4 = param1.next;
                _loc_5 = param1.prev;
                _loc_6 = _loc_5.next;
                _loc_7 = _loc_5.prev;
                _loc_4.colour = 0;
                _loc_8 = 1;
                _loc_2.colour = _loc_8;
                param1.colour = _loc_8;
                param1.prev = _loc_6;
                if (_loc_6 != null)
                {
                    _loc_6.parent = param1;
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

        public function __fix_dbl_red(param1:ZPP_Set_ZPP_CbSetPair) : void
        {
            var _loc_2:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_3:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_4:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_5:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_6:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_7:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_8:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_9:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_10:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_11:* = null as ZPP_Set_ZPP_CbSetPair;
            while (true)
            {
                
                _loc_2 = param1.parent;
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
                    if (param1 == _loc_2.prev)
                    {
                        _loc_4 = param1;
                        _loc_5 = _loc_2;
                        _loc_7 = param1.prev;
                        _loc_8 = param1.next;
                        _loc_9 = _loc_2.next;
                    }
                    else
                    {
                        _loc_4 = _loc_2;
                        _loc_5 = param1;
                        _loc_7 = _loc_2.prev;
                        _loc_8 = param1.prev;
                        _loc_9 = param1.next;
                    }
                }
                else
                {
                    _loc_4 = _loc_3;
                    _loc_7 = _loc_3.prev;
                    if (param1 == _loc_2.prev)
                    {
                        _loc_5 = param1;
                        _loc_6 = _loc_2;
                        _loc_8 = param1.prev;
                        _loc_9 = param1.next;
                        _loc_10 = _loc_2.next;
                    }
                    else
                    {
                        _loc_5 = _loc_2;
                        _loc_6 = param1;
                        _loc_8 = _loc_2.prev;
                        _loc_9 = param1.prev;
                        _loc_10 = param1.next;
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
                        param1 = _loc_5;
                        continue;
                    }
                }
                break;
            }
            return;
        }// end function

    }
}
