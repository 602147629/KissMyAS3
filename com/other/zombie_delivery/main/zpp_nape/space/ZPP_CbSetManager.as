package zpp_nape.space
{
    import flash.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.util.*;

    public class ZPP_CbSetManager extends Object
    {
        public var space:ZPP_Space;
        public var cbsets:ZPP_Set_ZPP_CbSet;

        public function ZPP_CbSetManager(param1:ZPP_Space = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            space = null;
            cbsets = null;
            if (ZPP_Set_ZPP_CbSet.zpp_pool == null)
            {
                cbsets = new ZPP_Set_ZPP_CbSet();
            }
            else
            {
                cbsets = ZPP_Set_ZPP_CbSet.zpp_pool;
                ZPP_Set_ZPP_CbSet.zpp_pool = cbsets.next;
                cbsets.next = null;
            }
            cbsets.lt = ZPP_CbSet.setlt;
            space = param1;
            return;
        }// end function

        public function validate() : void
        {
            var _loc_1:* = null as ZPP_Set_ZPP_CbSet;
            var _loc_2:* = null as ZPP_CbSet;
            if (!cbsets.empty())
            {
                _loc_1 = cbsets.parent;
                while (_loc_1.prev != null)
                {
                    
                    _loc_1 = _loc_1.prev;
                }
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1.data;
                    _loc_2.validate();
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
            return;
        }// end function

        public function valid_listener(param1:ZPP_Listener) : Boolean
        {
            return param1.space == space;
        }// end function

        public function remove(param1:ZPP_CbSet) : void
        {
            var _loc_2:* = null as ZPP_CbSetPair;
            var _loc_3:* = null as ZPP_CbSetPair;
            var _loc_4:* = null as ZPP_CbSet;
            cbsets.remove(param1);
            while (param1.cbpairs.head != null)
            {
                
                _loc_2 = param1.cbpairs.pop_unsafe();
                if (_loc_2.a != _loc_2.b)
                {
                    if (param1 == _loc_2.a)
                    {
                        _loc_2.b.cbpairs.remove(_loc_2);
                    }
                    else
                    {
                        _loc_2.a.cbpairs.remove(_loc_2);
                    }
                }
                _loc_3 = _loc_2;
                _loc_4 = null;
                _loc_3.b = _loc_4;
                _loc_3.a = _loc_4;
                _loc_3.listeners.clear();
                _loc_3.next = ZPP_CbSetPair.zpp_pool;
                ZPP_CbSetPair.zpp_pool = _loc_3;
            }
            param1.manager = null;
            return;
        }// end function

        public function pair(param1:ZPP_CbSet, param2:ZPP_CbSet) : ZPP_CbSetPair
        {
            var _loc_4:* = null as ZNPList_ZPP_CbSetPair;
            var _loc_6:* = null as ZPP_CbSetPair;
            var _loc_3:* = null;
            if (param1.cbpairs.length < param2.cbpairs.length)
            {
                _loc_4 = param1.cbpairs;
            }
            else
            {
                _loc_4 = param2.cbpairs;
            }
            var _loc_5:* = _loc_4.head;
            while (_loc_5 != null)
            {
                
                _loc_6 = _loc_5.elt;
                if (_loc_6.a == param1)
                {
                }
                if (_loc_6.b != param2)
                {
                    if (_loc_6.a == param2)
                    {
                    }
                }
                if (_loc_6.b == param1)
                {
                    _loc_3 = _loc_6;
                    break;
                }
                _loc_5 = _loc_5.next;
            }
            if (_loc_3 == null)
            {
                if (ZPP_CbSetPair.zpp_pool == null)
                {
                    _loc_6 = new ZPP_CbSetPair();
                }
                else
                {
                    _loc_6 = ZPP_CbSetPair.zpp_pool;
                    ZPP_CbSetPair.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.zip_listeners = true;
                if (ZPP_CbSet.setlt(param1, param2))
                {
                    _loc_6.a = param1;
                    _loc_6.b = param2;
                }
                else
                {
                    _loc_6.a = param2;
                    _loc_6.b = param1;
                }
                _loc_3 = _loc_6;
                param1.cbpairs.add(_loc_3);
                if (param2 != param1)
                {
                    param2.cbpairs.add(_loc_3);
                }
            }
            if (_loc_3.zip_listeners)
            {
                _loc_3.zip_listeners = false;
                _loc_3.__validate();
            }
            return _loc_3;
        }// end function

        public function get(param1:ZNPList_ZPP_CbType) : ZPP_CbSet
        {
            var _loc_2:* = null as ZPP_CbSet;
            var _loc_5:* = null as ZPP_CbSet;
            var _loc_6:* = null as ZPP_CbSet;
            var _loc_7:* = null as ZPP_CbType;
            if (param1.head == null)
            {
                return null;
            }
            if (ZPP_CbSet.zpp_pool == null)
            {
                _loc_2 = new ZPP_CbSet();
            }
            else
            {
                _loc_2 = ZPP_CbSet.zpp_pool;
                ZPP_CbSet.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            var _loc_3:* = _loc_2.cbTypes;
            _loc_2.cbTypes = param1;
            var _loc_4:* = cbsets.find_weak(_loc_2);
            if (_loc_4 != null)
            {
                _loc_5 = _loc_4.data;
            }
            else
            {
                _loc_6 = ZPP_CbSet.get(param1);
                cbsets.insert(_loc_6);
                _loc_6.manager = this;
                _loc_5 = _loc_6;
            }
            _loc_2.cbTypes = _loc_3;
            _loc_6 = _loc_2;
            _loc_6.listeners.clear();
            _loc_6.zip_listeners = true;
            _loc_6.bodylisteners.clear();
            _loc_6.zip_bodylisteners = true;
            _loc_6.conlisteners.clear();
            _loc_6.zip_conlisteners = true;
            while (_loc_6.cbTypes.head != null)
            {
                
                _loc_7 = _loc_6.cbTypes.pop_unsafe();
                _loc_7.cbsets.remove(_loc_6);
            }
            _loc_6.next = ZPP_CbSet.zpp_pool;
            ZPP_CbSet.zpp_pool = _loc_6;
            return _loc_5;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

    }
}
