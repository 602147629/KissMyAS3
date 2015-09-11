package zpp_nape.callbacks
{
    import flash.*;
    import nape.callbacks.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_InteractionListener extends ZPP_Listener
    {
        public var pure:Boolean;
        public var outer_znp:PreListener;
        public var outer_zni:InteractionListener;
        public var options2:ZPP_OptionType;
        public var options1:ZPP_OptionType;
        public var itype:int;
        public var handlerp:Object;
        public var handleri:Object;
        public var allowSleepingCallbacks:Boolean;
        public static var init__:Boolean;
        public static var UCbSet:ZNPList_ZPP_CbSet;
        public static var VCbSet:ZNPList_ZPP_CbSet;
        public static var WCbSet:ZNPList_ZPP_CbSet;
        public static var UCbType:ZNPList_ZPP_CbType;
        public static var VCbType:ZNPList_ZPP_CbType;
        public static var WCbType:ZNPList_ZPP_CbType;

        public function ZPP_InteractionListener(param1:OptionType = undefined, param2:OptionType = undefined, param3:int = 0, param4:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            handlerp = null;
            pure = false;
            allowSleepingCallbacks = false;
            handleri = null;
            options2 = null;
            options1 = null;
            itype = 0;
            outer_znp = null;
            outer_zni = null;
            type = param4;
            interaction = this;
            event = param3;
            options1 = param1.zpp_inner;
            options2 = param2.zpp_inner;
            allowSleepingCallbacks = false;
            return;
        }// end function

        public function with_uniquesets(param1:Boolean) : void
        {
            var _loc_3:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_10:* = null as ZPP_CbType;
            var _loc_11:* = null as ZPP_CbType;
            var _loc_12:* = null as ZNPNode_ZPP_CbType;
            var _loc_13:* = null as ZNPNode_ZPP_CbType;
            var _loc_14:* = null as ZNPList_ZPP_CbSet;
            var _loc_15:* = null as ZNPList_ZPP_CbSet;
            var _loc_16:* = null as ZNPList_ZPP_CbSet;
            var _loc_17:* = null as ZNPList_ZPP_CbSet;
            var _loc_18:* = null as ZNPNode_ZPP_CbSet;
            var _loc_19:* = null as ZNPNode_ZPP_CbSet;
            var _loc_20:* = null as ZPP_CbSet;
            var _loc_21:* = null as ZPP_CbSet;
            var _loc_22:* = null as ZNPNode_ZPP_CbSet;
            var _loc_23:* = null as ZNPNode_ZPP_CbSet;
            var _loc_24:* = null as ZPP_CbSetPair;
            var _loc_25:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_26:* = null as ZPP_CbSetPair;
            var _loc_27:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_28:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_2:* = this;
            if (ZPP_Set_ZPP_CbSetPair.zpp_pool == null)
            {
                _loc_3 = new ZPP_Set_ZPP_CbSetPair();
            }
            else
            {
                _loc_3 = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.lt = ZPP_CbSetPair.setlt;
            var _loc_4:* = options2.includes;
            var _loc_5:* = ZPP_InteractionListener.UCbType;
            var _loc_6:* = ZPP_InteractionListener.VCbType;
            var _loc_7:* = ZPP_InteractionListener.WCbType;
            var _loc_8:* = options1.includes.head;
            var _loc_9:* = _loc_4.head;
            do
            {
                
                _loc_10 = _loc_8.elt;
                _loc_11 = _loc_9.elt;
                if (_loc_10 == _loc_11)
                {
                    if (ZNPNode_ZPP_CbType.zpp_pool == null)
                    {
                        _loc_13 = new ZNPNode_ZPP_CbType();
                    }
                    else
                    {
                        _loc_13 = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc_13.next;
                        _loc_13.next = null;
                    }
                    _loc_13.elt = _loc_10;
                    _loc_12 = _loc_13;
                    _loc_12.next = _loc_7.head;
                    _loc_7.head = _loc_12;
                    _loc_7.modified = true;
                    (_loc_7.length + 1);
                    _loc_8 = _loc_8.next;
                    _loc_9 = _loc_9.next;
                }
                else if (_loc_10.id < _loc_11.id)
                {
                    if (ZNPNode_ZPP_CbType.zpp_pool == null)
                    {
                        _loc_13 = new ZNPNode_ZPP_CbType();
                    }
                    else
                    {
                        _loc_13 = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc_13.next;
                        _loc_13.next = null;
                    }
                    _loc_13.elt = _loc_10;
                    _loc_12 = _loc_13;
                    _loc_12.next = _loc_5.head;
                    _loc_5.head = _loc_12;
                    _loc_5.modified = true;
                    (_loc_5.length + 1);
                    _loc_8 = _loc_8.next;
                }
                else
                {
                    if (ZNPNode_ZPP_CbType.zpp_pool == null)
                    {
                        _loc_13 = new ZNPNode_ZPP_CbType();
                    }
                    else
                    {
                        _loc_13 = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc_13.next;
                        _loc_13.next = null;
                    }
                    _loc_13.elt = _loc_11;
                    _loc_12 = _loc_13;
                    _loc_12.next = _loc_6.head;
                    _loc_6.head = _loc_12;
                    _loc_6.modified = true;
                    (_loc_6.length + 1);
                    _loc_9 = _loc_9.next;
                }
                if (_loc_8 != null)
                {
                }
            }while (_loc_9 != null)
            while (_loc_8 != null)
            {
                
                _loc_10 = _loc_8.elt;
                if (ZNPNode_ZPP_CbType.zpp_pool == null)
                {
                    _loc_13 = new ZNPNode_ZPP_CbType();
                }
                else
                {
                    _loc_13 = ZNPNode_ZPP_CbType.zpp_pool;
                    ZNPNode_ZPP_CbType.zpp_pool = _loc_13.next;
                    _loc_13.next = null;
                }
                _loc_13.elt = _loc_10;
                _loc_12 = _loc_13;
                _loc_12.next = _loc_5.head;
                _loc_5.head = _loc_12;
                _loc_5.modified = true;
                (_loc_5.length + 1);
                _loc_8 = _loc_8.next;
            }
            while (_loc_9 != null)
            {
                
                _loc_10 = _loc_9.elt;
                if (ZNPNode_ZPP_CbType.zpp_pool == null)
                {
                    _loc_13 = new ZNPNode_ZPP_CbType();
                }
                else
                {
                    _loc_13 = ZNPNode_ZPP_CbType.zpp_pool;
                    ZNPNode_ZPP_CbType.zpp_pool = _loc_13.next;
                    _loc_13.next = null;
                }
                _loc_13.elt = _loc_10;
                _loc_12 = _loc_13;
                _loc_12.next = _loc_6.head;
                _loc_6.head = _loc_12;
                _loc_6.modified = true;
                (_loc_6.length + 1);
                _loc_9 = _loc_9.next;
            }
            while (_loc_5.head != null)
            {
                
                _loc_10 = _loc_5.pop_unsafe();
                _loc_12 = _loc_4.head;
                while (_loc_12 != null)
                {
                    
                    _loc_11 = _loc_12.elt;
                    _loc_14 = _loc_11.cbsets;
                    _loc_15 = ZPP_InteractionListener.UCbSet;
                    _loc_16 = ZPP_InteractionListener.VCbSet;
                    _loc_17 = ZPP_InteractionListener.WCbSet;
                    _loc_18 = _loc_10.cbsets.head;
                    _loc_19 = _loc_14.head;
                    do
                    {
                        
                        _loc_20 = _loc_18.elt;
                        _loc_21 = _loc_19.elt;
                        if (_loc_20 == _loc_21)
                        {
                            if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                            {
                                _loc_23 = new ZNPNode_ZPP_CbSet();
                            }
                            else
                            {
                                _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                                ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                                _loc_23.next = null;
                            }
                            _loc_23.elt = _loc_20;
                            _loc_22 = _loc_23;
                            _loc_22.next = _loc_17.head;
                            _loc_17.head = _loc_22;
                            _loc_17.modified = true;
                            (_loc_17.length + 1);
                            _loc_18 = _loc_18.next;
                            _loc_19 = _loc_19.next;
                        }
                        else if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                        {
                            if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                            {
                                _loc_23 = new ZNPNode_ZPP_CbSet();
                            }
                            else
                            {
                                _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                                ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                                _loc_23.next = null;
                            }
                            _loc_23.elt = _loc_20;
                            _loc_22 = _loc_23;
                            _loc_22.next = _loc_15.head;
                            _loc_15.head = _loc_22;
                            _loc_15.modified = true;
                            (_loc_15.length + 1);
                            _loc_18 = _loc_18.next;
                        }
                        else
                        {
                            if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                            {
                                _loc_23 = new ZNPNode_ZPP_CbSet();
                            }
                            else
                            {
                                _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                                ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                                _loc_23.next = null;
                            }
                            _loc_23.elt = _loc_21;
                            _loc_22 = _loc_23;
                            _loc_22.next = _loc_16.head;
                            _loc_16.head = _loc_22;
                            _loc_16.modified = true;
                            (_loc_16.length + 1);
                            _loc_19 = _loc_19.next;
                        }
                        if (_loc_18 != null)
                        {
                        }
                    }while (_loc_19 != null)
                    while (_loc_18 != null)
                    {
                        
                        _loc_20 = _loc_18.elt;
                        if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                        {
                            _loc_23 = new ZNPNode_ZPP_CbSet();
                        }
                        else
                        {
                            _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                            ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                            _loc_23.next = null;
                        }
                        _loc_23.elt = _loc_20;
                        _loc_22 = _loc_23;
                        _loc_22.next = _loc_15.head;
                        _loc_15.head = _loc_22;
                        _loc_15.modified = true;
                        (_loc_15.length + 1);
                        _loc_18 = _loc_18.next;
                    }
                    while (_loc_19 != null)
                    {
                        
                        _loc_20 = _loc_19.elt;
                        if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                        {
                            _loc_23 = new ZNPNode_ZPP_CbSet();
                        }
                        else
                        {
                            _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                            ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                            _loc_23.next = null;
                        }
                        _loc_23.elt = _loc_20;
                        _loc_22 = _loc_23;
                        _loc_22.next = _loc_16.head;
                        _loc_16.head = _loc_22;
                        _loc_16.modified = true;
                        (_loc_16.length + 1);
                        _loc_19 = _loc_19.next;
                    }
                    while (_loc_15.head != null)
                    {
                        
                        _loc_20 = _loc_15.pop_unsafe();
                        _loc_22 = _loc_14.head;
                        while (_loc_22 != null)
                        {
                            
                            _loc_21 = _loc_22.elt;
                            _loc_20.validate();
                            _loc_21.validate();
                            if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                            {
                                if (ZPP_CbSetPair.zpp_pool == null)
                                {
                                    _loc_24 = new ZPP_CbSetPair();
                                }
                                else
                                {
                                    _loc_24 = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                    _loc_24.next = null;
                                }
                                _loc_24.zip_listeners = true;
                                if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                                {
                                    _loc_24.a = _loc_20;
                                    _loc_24.b = _loc_21;
                                }
                                else
                                {
                                    _loc_24.a = _loc_21;
                                    _loc_24.b = _loc_20;
                                }
                                _loc_3.try_insert(_loc_24);
                            }
                            _loc_22 = _loc_22.next;
                        }
                    }
                    while (_loc_16.head != null)
                    {
                        
                        _loc_20 = _loc_16.pop_unsafe();
                        _loc_22 = _loc_17.head;
                        while (_loc_22 != null)
                        {
                            
                            _loc_21 = _loc_22.elt;
                            _loc_20.validate();
                            _loc_21.validate();
                            if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                            {
                                if (ZPP_CbSetPair.zpp_pool == null)
                                {
                                    _loc_24 = new ZPP_CbSetPair();
                                }
                                else
                                {
                                    _loc_24 = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                    _loc_24.next = null;
                                }
                                _loc_24.zip_listeners = true;
                                if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                                {
                                    _loc_24.a = _loc_20;
                                    _loc_24.b = _loc_21;
                                }
                                else
                                {
                                    _loc_24.a = _loc_21;
                                    _loc_24.b = _loc_20;
                                }
                                _loc_3.try_insert(_loc_24);
                            }
                            _loc_22 = _loc_22.next;
                        }
                    }
                    while (_loc_17.head != null)
                    {
                        
                        _loc_20 = _loc_17.pop_unsafe();
                        _loc_20.validate();
                        _loc_20.validate();
                        if (ZPP_CbSet.single_intersection(_loc_20, _loc_20, _loc_2))
                        {
                            if (ZPP_CbSetPair.zpp_pool == null)
                            {
                                _loc_24 = new ZPP_CbSetPair();
                            }
                            else
                            {
                                _loc_24 = ZPP_CbSetPair.zpp_pool;
                                ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                _loc_24.next = null;
                            }
                            _loc_24.zip_listeners = true;
                            if (ZPP_CbSet.setlt(_loc_20, _loc_20))
                            {
                                _loc_24.a = _loc_20;
                                _loc_24.b = _loc_20;
                            }
                            else
                            {
                                _loc_24.a = _loc_20;
                                _loc_24.b = _loc_20;
                            }
                            _loc_3.try_insert(_loc_24);
                        }
                        _loc_22 = _loc_17.head;
                        while (_loc_22 != null)
                        {
                            
                            _loc_21 = _loc_22.elt;
                            _loc_20.validate();
                            _loc_21.validate();
                            if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                            {
                                if (ZPP_CbSetPair.zpp_pool == null)
                                {
                                    _loc_24 = new ZPP_CbSetPair();
                                }
                                else
                                {
                                    _loc_24 = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                    _loc_24.next = null;
                                }
                                _loc_24.zip_listeners = true;
                                if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                                {
                                    _loc_24.a = _loc_20;
                                    _loc_24.b = _loc_21;
                                }
                                else
                                {
                                    _loc_24.a = _loc_21;
                                    _loc_24.b = _loc_20;
                                }
                                _loc_3.try_insert(_loc_24);
                            }
                            _loc_22 = _loc_22.next;
                        }
                    }
                    _loc_12 = _loc_12.next;
                }
            }
            while (_loc_6.head != null)
            {
                
                _loc_10 = _loc_6.pop_unsafe();
                _loc_12 = _loc_7.head;
                while (_loc_12 != null)
                {
                    
                    _loc_11 = _loc_12.elt;
                    _loc_14 = _loc_11.cbsets;
                    _loc_15 = ZPP_InteractionListener.UCbSet;
                    _loc_16 = ZPP_InteractionListener.VCbSet;
                    _loc_17 = ZPP_InteractionListener.WCbSet;
                    _loc_18 = _loc_10.cbsets.head;
                    _loc_19 = _loc_14.head;
                    do
                    {
                        
                        _loc_20 = _loc_18.elt;
                        _loc_21 = _loc_19.elt;
                        if (_loc_20 == _loc_21)
                        {
                            if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                            {
                                _loc_23 = new ZNPNode_ZPP_CbSet();
                            }
                            else
                            {
                                _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                                ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                                _loc_23.next = null;
                            }
                            _loc_23.elt = _loc_20;
                            _loc_22 = _loc_23;
                            _loc_22.next = _loc_17.head;
                            _loc_17.head = _loc_22;
                            _loc_17.modified = true;
                            (_loc_17.length + 1);
                            _loc_18 = _loc_18.next;
                            _loc_19 = _loc_19.next;
                        }
                        else if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                        {
                            if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                            {
                                _loc_23 = new ZNPNode_ZPP_CbSet();
                            }
                            else
                            {
                                _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                                ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                                _loc_23.next = null;
                            }
                            _loc_23.elt = _loc_20;
                            _loc_22 = _loc_23;
                            _loc_22.next = _loc_15.head;
                            _loc_15.head = _loc_22;
                            _loc_15.modified = true;
                            (_loc_15.length + 1);
                            _loc_18 = _loc_18.next;
                        }
                        else
                        {
                            if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                            {
                                _loc_23 = new ZNPNode_ZPP_CbSet();
                            }
                            else
                            {
                                _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                                ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                                _loc_23.next = null;
                            }
                            _loc_23.elt = _loc_21;
                            _loc_22 = _loc_23;
                            _loc_22.next = _loc_16.head;
                            _loc_16.head = _loc_22;
                            _loc_16.modified = true;
                            (_loc_16.length + 1);
                            _loc_19 = _loc_19.next;
                        }
                        if (_loc_18 != null)
                        {
                        }
                    }while (_loc_19 != null)
                    while (_loc_18 != null)
                    {
                        
                        _loc_20 = _loc_18.elt;
                        if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                        {
                            _loc_23 = new ZNPNode_ZPP_CbSet();
                        }
                        else
                        {
                            _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                            ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                            _loc_23.next = null;
                        }
                        _loc_23.elt = _loc_20;
                        _loc_22 = _loc_23;
                        _loc_22.next = _loc_15.head;
                        _loc_15.head = _loc_22;
                        _loc_15.modified = true;
                        (_loc_15.length + 1);
                        _loc_18 = _loc_18.next;
                    }
                    while (_loc_19 != null)
                    {
                        
                        _loc_20 = _loc_19.elt;
                        if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                        {
                            _loc_23 = new ZNPNode_ZPP_CbSet();
                        }
                        else
                        {
                            _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                            ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                            _loc_23.next = null;
                        }
                        _loc_23.elt = _loc_20;
                        _loc_22 = _loc_23;
                        _loc_22.next = _loc_16.head;
                        _loc_16.head = _loc_22;
                        _loc_16.modified = true;
                        (_loc_16.length + 1);
                        _loc_19 = _loc_19.next;
                    }
                    while (_loc_15.head != null)
                    {
                        
                        _loc_20 = _loc_15.pop_unsafe();
                        _loc_22 = _loc_14.head;
                        while (_loc_22 != null)
                        {
                            
                            _loc_21 = _loc_22.elt;
                            _loc_20.validate();
                            _loc_21.validate();
                            if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                            {
                                if (ZPP_CbSetPair.zpp_pool == null)
                                {
                                    _loc_24 = new ZPP_CbSetPair();
                                }
                                else
                                {
                                    _loc_24 = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                    _loc_24.next = null;
                                }
                                _loc_24.zip_listeners = true;
                                if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                                {
                                    _loc_24.a = _loc_20;
                                    _loc_24.b = _loc_21;
                                }
                                else
                                {
                                    _loc_24.a = _loc_21;
                                    _loc_24.b = _loc_20;
                                }
                                _loc_3.try_insert(_loc_24);
                            }
                            _loc_22 = _loc_22.next;
                        }
                    }
                    while (_loc_16.head != null)
                    {
                        
                        _loc_20 = _loc_16.pop_unsafe();
                        _loc_22 = _loc_17.head;
                        while (_loc_22 != null)
                        {
                            
                            _loc_21 = _loc_22.elt;
                            _loc_20.validate();
                            _loc_21.validate();
                            if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                            {
                                if (ZPP_CbSetPair.zpp_pool == null)
                                {
                                    _loc_24 = new ZPP_CbSetPair();
                                }
                                else
                                {
                                    _loc_24 = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                    _loc_24.next = null;
                                }
                                _loc_24.zip_listeners = true;
                                if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                                {
                                    _loc_24.a = _loc_20;
                                    _loc_24.b = _loc_21;
                                }
                                else
                                {
                                    _loc_24.a = _loc_21;
                                    _loc_24.b = _loc_20;
                                }
                                _loc_3.try_insert(_loc_24);
                            }
                            _loc_22 = _loc_22.next;
                        }
                    }
                    while (_loc_17.head != null)
                    {
                        
                        _loc_20 = _loc_17.pop_unsafe();
                        _loc_20.validate();
                        _loc_20.validate();
                        if (ZPP_CbSet.single_intersection(_loc_20, _loc_20, _loc_2))
                        {
                            if (ZPP_CbSetPair.zpp_pool == null)
                            {
                                _loc_24 = new ZPP_CbSetPair();
                            }
                            else
                            {
                                _loc_24 = ZPP_CbSetPair.zpp_pool;
                                ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                _loc_24.next = null;
                            }
                            _loc_24.zip_listeners = true;
                            if (ZPP_CbSet.setlt(_loc_20, _loc_20))
                            {
                                _loc_24.a = _loc_20;
                                _loc_24.b = _loc_20;
                            }
                            else
                            {
                                _loc_24.a = _loc_20;
                                _loc_24.b = _loc_20;
                            }
                            _loc_3.try_insert(_loc_24);
                        }
                        _loc_22 = _loc_17.head;
                        while (_loc_22 != null)
                        {
                            
                            _loc_21 = _loc_22.elt;
                            _loc_20.validate();
                            _loc_21.validate();
                            if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                            {
                                if (ZPP_CbSetPair.zpp_pool == null)
                                {
                                    _loc_24 = new ZPP_CbSetPair();
                                }
                                else
                                {
                                    _loc_24 = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                    _loc_24.next = null;
                                }
                                _loc_24.zip_listeners = true;
                                if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                                {
                                    _loc_24.a = _loc_20;
                                    _loc_24.b = _loc_21;
                                }
                                else
                                {
                                    _loc_24.a = _loc_21;
                                    _loc_24.b = _loc_20;
                                }
                                _loc_3.try_insert(_loc_24);
                            }
                            _loc_22 = _loc_22.next;
                        }
                    }
                    _loc_12 = _loc_12.next;
                }
            }
            while (_loc_7.head != null)
            {
                
                _loc_10 = _loc_7.pop_unsafe();
                _loc_14 = _loc_10.cbsets;
                _loc_15 = ZPP_InteractionListener.UCbSet;
                _loc_16 = ZPP_InteractionListener.VCbSet;
                _loc_17 = ZPP_InteractionListener.WCbSet;
                _loc_18 = _loc_10.cbsets.head;
                _loc_19 = _loc_14.head;
                do
                {
                    
                    _loc_20 = _loc_18.elt;
                    _loc_21 = _loc_19.elt;
                    if (_loc_20 == _loc_21)
                    {
                        if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                        {
                            _loc_23 = new ZNPNode_ZPP_CbSet();
                        }
                        else
                        {
                            _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                            ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                            _loc_23.next = null;
                        }
                        _loc_23.elt = _loc_20;
                        _loc_22 = _loc_23;
                        _loc_22.next = _loc_17.head;
                        _loc_17.head = _loc_22;
                        _loc_17.modified = true;
                        (_loc_17.length + 1);
                        _loc_18 = _loc_18.next;
                        _loc_19 = _loc_19.next;
                    }
                    else if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                    {
                        if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                        {
                            _loc_23 = new ZNPNode_ZPP_CbSet();
                        }
                        else
                        {
                            _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                            ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                            _loc_23.next = null;
                        }
                        _loc_23.elt = _loc_20;
                        _loc_22 = _loc_23;
                        _loc_22.next = _loc_15.head;
                        _loc_15.head = _loc_22;
                        _loc_15.modified = true;
                        (_loc_15.length + 1);
                        _loc_18 = _loc_18.next;
                    }
                    else
                    {
                        if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                        {
                            _loc_23 = new ZNPNode_ZPP_CbSet();
                        }
                        else
                        {
                            _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                            ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                            _loc_23.next = null;
                        }
                        _loc_23.elt = _loc_21;
                        _loc_22 = _loc_23;
                        _loc_22.next = _loc_16.head;
                        _loc_16.head = _loc_22;
                        _loc_16.modified = true;
                        (_loc_16.length + 1);
                        _loc_19 = _loc_19.next;
                    }
                    if (_loc_18 != null)
                    {
                    }
                }while (_loc_19 != null)
                while (_loc_18 != null)
                {
                    
                    _loc_20 = _loc_18.elt;
                    if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                    {
                        _loc_23 = new ZNPNode_ZPP_CbSet();
                    }
                    else
                    {
                        _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                        _loc_23.next = null;
                    }
                    _loc_23.elt = _loc_20;
                    _loc_22 = _loc_23;
                    _loc_22.next = _loc_15.head;
                    _loc_15.head = _loc_22;
                    _loc_15.modified = true;
                    (_loc_15.length + 1);
                    _loc_18 = _loc_18.next;
                }
                while (_loc_19 != null)
                {
                    
                    _loc_20 = _loc_19.elt;
                    if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                    {
                        _loc_23 = new ZNPNode_ZPP_CbSet();
                    }
                    else
                    {
                        _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                        _loc_23.next = null;
                    }
                    _loc_23.elt = _loc_20;
                    _loc_22 = _loc_23;
                    _loc_22.next = _loc_16.head;
                    _loc_16.head = _loc_22;
                    _loc_16.modified = true;
                    (_loc_16.length + 1);
                    _loc_19 = _loc_19.next;
                }
                while (_loc_15.head != null)
                {
                    
                    _loc_20 = _loc_15.pop_unsafe();
                    _loc_22 = _loc_14.head;
                    while (_loc_22 != null)
                    {
                        
                        _loc_21 = _loc_22.elt;
                        _loc_20.validate();
                        _loc_21.validate();
                        if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                        {
                            if (ZPP_CbSetPair.zpp_pool == null)
                            {
                                _loc_24 = new ZPP_CbSetPair();
                            }
                            else
                            {
                                _loc_24 = ZPP_CbSetPair.zpp_pool;
                                ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                _loc_24.next = null;
                            }
                            _loc_24.zip_listeners = true;
                            if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                            {
                                _loc_24.a = _loc_20;
                                _loc_24.b = _loc_21;
                            }
                            else
                            {
                                _loc_24.a = _loc_21;
                                _loc_24.b = _loc_20;
                            }
                            _loc_3.try_insert(_loc_24);
                        }
                        _loc_22 = _loc_22.next;
                    }
                }
                while (_loc_16.head != null)
                {
                    
                    _loc_20 = _loc_16.pop_unsafe();
                    _loc_22 = _loc_17.head;
                    while (_loc_22 != null)
                    {
                        
                        _loc_21 = _loc_22.elt;
                        _loc_20.validate();
                        _loc_21.validate();
                        if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                        {
                            if (ZPP_CbSetPair.zpp_pool == null)
                            {
                                _loc_24 = new ZPP_CbSetPair();
                            }
                            else
                            {
                                _loc_24 = ZPP_CbSetPair.zpp_pool;
                                ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                _loc_24.next = null;
                            }
                            _loc_24.zip_listeners = true;
                            if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                            {
                                _loc_24.a = _loc_20;
                                _loc_24.b = _loc_21;
                            }
                            else
                            {
                                _loc_24.a = _loc_21;
                                _loc_24.b = _loc_20;
                            }
                            _loc_3.try_insert(_loc_24);
                        }
                        _loc_22 = _loc_22.next;
                    }
                }
                while (_loc_17.head != null)
                {
                    
                    _loc_20 = _loc_17.pop_unsafe();
                    _loc_20.validate();
                    _loc_20.validate();
                    if (ZPP_CbSet.single_intersection(_loc_20, _loc_20, _loc_2))
                    {
                        if (ZPP_CbSetPair.zpp_pool == null)
                        {
                            _loc_24 = new ZPP_CbSetPair();
                        }
                        else
                        {
                            _loc_24 = ZPP_CbSetPair.zpp_pool;
                            ZPP_CbSetPair.zpp_pool = _loc_24.next;
                            _loc_24.next = null;
                        }
                        _loc_24.zip_listeners = true;
                        if (ZPP_CbSet.setlt(_loc_20, _loc_20))
                        {
                            _loc_24.a = _loc_20;
                            _loc_24.b = _loc_20;
                        }
                        else
                        {
                            _loc_24.a = _loc_20;
                            _loc_24.b = _loc_20;
                        }
                        _loc_3.try_insert(_loc_24);
                    }
                    _loc_22 = _loc_17.head;
                    while (_loc_22 != null)
                    {
                        
                        _loc_21 = _loc_22.elt;
                        _loc_20.validate();
                        _loc_21.validate();
                        if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                        {
                            if (ZPP_CbSetPair.zpp_pool == null)
                            {
                                _loc_24 = new ZPP_CbSetPair();
                            }
                            else
                            {
                                _loc_24 = ZPP_CbSetPair.zpp_pool;
                                ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                _loc_24.next = null;
                            }
                            _loc_24.zip_listeners = true;
                            if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                            {
                                _loc_24.a = _loc_20;
                                _loc_24.b = _loc_21;
                            }
                            else
                            {
                                _loc_24.a = _loc_21;
                                _loc_24.b = _loc_20;
                            }
                            _loc_3.try_insert(_loc_24);
                        }
                        _loc_22 = _loc_22.next;
                    }
                }
                _loc_12 = _loc_7.head;
                while (_loc_12 != null)
                {
                    
                    _loc_11 = _loc_12.elt;
                    _loc_14 = _loc_11.cbsets;
                    _loc_15 = ZPP_InteractionListener.UCbSet;
                    _loc_16 = ZPP_InteractionListener.VCbSet;
                    _loc_17 = ZPP_InteractionListener.WCbSet;
                    _loc_18 = _loc_10.cbsets.head;
                    _loc_19 = _loc_14.head;
                    do
                    {
                        
                        _loc_20 = _loc_18.elt;
                        _loc_21 = _loc_19.elt;
                        if (_loc_20 == _loc_21)
                        {
                            if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                            {
                                _loc_23 = new ZNPNode_ZPP_CbSet();
                            }
                            else
                            {
                                _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                                ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                                _loc_23.next = null;
                            }
                            _loc_23.elt = _loc_20;
                            _loc_22 = _loc_23;
                            _loc_22.next = _loc_17.head;
                            _loc_17.head = _loc_22;
                            _loc_17.modified = true;
                            (_loc_17.length + 1);
                            _loc_18 = _loc_18.next;
                            _loc_19 = _loc_19.next;
                        }
                        else if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                        {
                            if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                            {
                                _loc_23 = new ZNPNode_ZPP_CbSet();
                            }
                            else
                            {
                                _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                                ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                                _loc_23.next = null;
                            }
                            _loc_23.elt = _loc_20;
                            _loc_22 = _loc_23;
                            _loc_22.next = _loc_15.head;
                            _loc_15.head = _loc_22;
                            _loc_15.modified = true;
                            (_loc_15.length + 1);
                            _loc_18 = _loc_18.next;
                        }
                        else
                        {
                            if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                            {
                                _loc_23 = new ZNPNode_ZPP_CbSet();
                            }
                            else
                            {
                                _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                                ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                                _loc_23.next = null;
                            }
                            _loc_23.elt = _loc_21;
                            _loc_22 = _loc_23;
                            _loc_22.next = _loc_16.head;
                            _loc_16.head = _loc_22;
                            _loc_16.modified = true;
                            (_loc_16.length + 1);
                            _loc_19 = _loc_19.next;
                        }
                        if (_loc_18 != null)
                        {
                        }
                    }while (_loc_19 != null)
                    while (_loc_18 != null)
                    {
                        
                        _loc_20 = _loc_18.elt;
                        if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                        {
                            _loc_23 = new ZNPNode_ZPP_CbSet();
                        }
                        else
                        {
                            _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                            ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                            _loc_23.next = null;
                        }
                        _loc_23.elt = _loc_20;
                        _loc_22 = _loc_23;
                        _loc_22.next = _loc_15.head;
                        _loc_15.head = _loc_22;
                        _loc_15.modified = true;
                        (_loc_15.length + 1);
                        _loc_18 = _loc_18.next;
                    }
                    while (_loc_19 != null)
                    {
                        
                        _loc_20 = _loc_19.elt;
                        if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                        {
                            _loc_23 = new ZNPNode_ZPP_CbSet();
                        }
                        else
                        {
                            _loc_23 = ZNPNode_ZPP_CbSet.zpp_pool;
                            ZNPNode_ZPP_CbSet.zpp_pool = _loc_23.next;
                            _loc_23.next = null;
                        }
                        _loc_23.elt = _loc_20;
                        _loc_22 = _loc_23;
                        _loc_22.next = _loc_16.head;
                        _loc_16.head = _loc_22;
                        _loc_16.modified = true;
                        (_loc_16.length + 1);
                        _loc_19 = _loc_19.next;
                    }
                    while (_loc_15.head != null)
                    {
                        
                        _loc_20 = _loc_15.pop_unsafe();
                        _loc_22 = _loc_14.head;
                        while (_loc_22 != null)
                        {
                            
                            _loc_21 = _loc_22.elt;
                            _loc_20.validate();
                            _loc_21.validate();
                            if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                            {
                                if (ZPP_CbSetPair.zpp_pool == null)
                                {
                                    _loc_24 = new ZPP_CbSetPair();
                                }
                                else
                                {
                                    _loc_24 = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                    _loc_24.next = null;
                                }
                                _loc_24.zip_listeners = true;
                                if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                                {
                                    _loc_24.a = _loc_20;
                                    _loc_24.b = _loc_21;
                                }
                                else
                                {
                                    _loc_24.a = _loc_21;
                                    _loc_24.b = _loc_20;
                                }
                                _loc_3.try_insert(_loc_24);
                            }
                            _loc_22 = _loc_22.next;
                        }
                    }
                    while (_loc_16.head != null)
                    {
                        
                        _loc_20 = _loc_16.pop_unsafe();
                        _loc_22 = _loc_17.head;
                        while (_loc_22 != null)
                        {
                            
                            _loc_21 = _loc_22.elt;
                            _loc_20.validate();
                            _loc_21.validate();
                            if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                            {
                                if (ZPP_CbSetPair.zpp_pool == null)
                                {
                                    _loc_24 = new ZPP_CbSetPair();
                                }
                                else
                                {
                                    _loc_24 = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                    _loc_24.next = null;
                                }
                                _loc_24.zip_listeners = true;
                                if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                                {
                                    _loc_24.a = _loc_20;
                                    _loc_24.b = _loc_21;
                                }
                                else
                                {
                                    _loc_24.a = _loc_21;
                                    _loc_24.b = _loc_20;
                                }
                                _loc_3.try_insert(_loc_24);
                            }
                            _loc_22 = _loc_22.next;
                        }
                    }
                    while (_loc_17.head != null)
                    {
                        
                        _loc_20 = _loc_17.pop_unsafe();
                        _loc_20.validate();
                        _loc_20.validate();
                        if (ZPP_CbSet.single_intersection(_loc_20, _loc_20, _loc_2))
                        {
                            if (ZPP_CbSetPair.zpp_pool == null)
                            {
                                _loc_24 = new ZPP_CbSetPair();
                            }
                            else
                            {
                                _loc_24 = ZPP_CbSetPair.zpp_pool;
                                ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                _loc_24.next = null;
                            }
                            _loc_24.zip_listeners = true;
                            if (ZPP_CbSet.setlt(_loc_20, _loc_20))
                            {
                                _loc_24.a = _loc_20;
                                _loc_24.b = _loc_20;
                            }
                            else
                            {
                                _loc_24.a = _loc_20;
                                _loc_24.b = _loc_20;
                            }
                            _loc_3.try_insert(_loc_24);
                        }
                        _loc_22 = _loc_17.head;
                        while (_loc_22 != null)
                        {
                            
                            _loc_21 = _loc_22.elt;
                            _loc_20.validate();
                            _loc_21.validate();
                            if (ZPP_CbSet.single_intersection(_loc_20, _loc_21, _loc_2))
                            {
                                if (ZPP_CbSetPair.zpp_pool == null)
                                {
                                    _loc_24 = new ZPP_CbSetPair();
                                }
                                else
                                {
                                    _loc_24 = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc_24.next;
                                    _loc_24.next = null;
                                }
                                _loc_24.zip_listeners = true;
                                if (ZPP_CbSet.setlt(_loc_20, _loc_21))
                                {
                                    _loc_24.a = _loc_20;
                                    _loc_24.b = _loc_21;
                                }
                                else
                                {
                                    _loc_24.a = _loc_21;
                                    _loc_24.b = _loc_20;
                                }
                                _loc_3.try_insert(_loc_24);
                            }
                            _loc_22 = _loc_22.next;
                        }
                    }
                    _loc_12 = _loc_12.next;
                }
            }
            if (_loc_3.parent == null)
            {
            }
            else
            {
                _loc_25 = _loc_3.parent;
                while (_loc_25 != null)
                {
                    
                    if (_loc_25.prev != null)
                    {
                        _loc_25 = _loc_25.prev;
                        continue;
                    }
                    if (_loc_25.next != null)
                    {
                        _loc_25 = _loc_25.next;
                        continue;
                    }
                    _loc_24 = _loc_25.data;
                    if (param1)
                    {
                        _loc_2.space.freshListenerType(_loc_24.a, _loc_24.b);
                    }
                    else
                    {
                        _loc_2.space.nullListenerType(_loc_24.a, _loc_24.b);
                    }
                    _loc_26 = _loc_24;
                    _loc_20 = null;
                    _loc_26.b = _loc_20;
                    _loc_26.a = _loc_20;
                    _loc_26.listeners.clear();
                    _loc_26.next = ZPP_CbSetPair.zpp_pool;
                    ZPP_CbSetPair.zpp_pool = _loc_26;
                    _loc_27 = _loc_25.parent;
                    if (_loc_27 != null)
                    {
                        if (_loc_25 == _loc_27.prev)
                        {
                            _loc_27.prev = null;
                        }
                        else
                        {
                            _loc_27.next = null;
                        }
                        _loc_25.parent = null;
                    }
                    _loc_28 = _loc_25;
                    _loc_28.data = null;
                    _loc_28.lt = null;
                    _loc_28.swapped = null;
                    _loc_28.next = ZPP_Set_ZPP_CbSetPair.zpp_pool;
                    ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_28;
                    _loc_25 = _loc_27;
                }
                _loc_3.parent = null;
            }
            _loc_25 = _loc_3;
            _loc_25.data = null;
            _loc_25.lt = null;
            _loc_25.swapped = null;
            _loc_25.next = ZPP_Set_ZPP_CbSetPair.zpp_pool;
            ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_25;
            return;
        }// end function

        public function with_union(param1:Function) : void
        {
            var _loc_4:* = null as ZPP_CbType;
            var _loc_5:* = null as ZPP_CbType;
            var _loc_2:* = options1.includes.head;
            var _loc_3:* = options2.includes.head;
            do
            {
                
                _loc_4 = _loc_2.elt;
                _loc_5 = _loc_3.elt;
                if (_loc_4 == _loc_5)
                {
                    this.param1(_loc_4);
                    _loc_2 = _loc_2.next;
                    _loc_3 = _loc_3.next;
                }
                else if (_loc_4.id < _loc_5.id)
                {
                    this.param1(_loc_4);
                    _loc_2 = _loc_2.next;
                }
                else
                {
                    this.param1(_loc_5);
                    _loc_3 = _loc_3.next;
                }
                if (_loc_2 != null)
                {
                }
            }while (_loc_3 != null)
            while (_loc_2 != null)
            {
                
                this.param1(_loc_2.elt);
                _loc_2 = _loc_2.next;
            }
            while (_loc_3 != null)
            {
                
                this.param1(_loc_3.elt);
                _loc_3 = _loc_3.next;
            }
            return;
        }// end function

        public function wake() : void
        {
            var _loc_3:* = null as ZPP_CbType;
            var _loc_4:* = null as ZPP_CbType;
            var _loc_5:* = null as ZNPNode_ZPP_Interactor;
            var _loc_6:* = null as ZPP_Interactor;
            var _loc_1:* = options1.includes.head;
            var _loc_2:* = options2.includes.head;
            do
            {
                
                _loc_3 = _loc_1.elt;
                _loc_4 = _loc_2.elt;
                if (_loc_3 == _loc_4)
                {
                    _loc_5 = _loc_3.interactors.head;
                    while (_loc_5 != null)
                    {
                        
                        _loc_6 = _loc_5.elt;
                        _loc_6.wake();
                        _loc_5 = _loc_5.next;
                    }
                    _loc_1 = _loc_1.next;
                    _loc_2 = _loc_2.next;
                }
                else if (_loc_3.id < _loc_4.id)
                {
                    _loc_5 = _loc_3.interactors.head;
                    while (_loc_5 != null)
                    {
                        
                        _loc_6 = _loc_5.elt;
                        _loc_6.wake();
                        _loc_5 = _loc_5.next;
                    }
                    _loc_1 = _loc_1.next;
                }
                else
                {
                    _loc_5 = _loc_4.interactors.head;
                    while (_loc_5 != null)
                    {
                        
                        _loc_6 = _loc_5.elt;
                        _loc_6.wake();
                        _loc_5 = _loc_5.next;
                    }
                    _loc_2 = _loc_2.next;
                }
                if (_loc_1 != null)
                {
                }
            }while (_loc_2 != null)
            while (_loc_1 != null)
            {
                
                _loc_5 = _loc_1.elt.interactors.head;
                while (_loc_5 != null)
                {
                    
                    _loc_6 = _loc_5.elt;
                    _loc_6.wake();
                    _loc_5 = _loc_5.next;
                }
                _loc_1 = _loc_1.next;
            }
            while (_loc_2 != null)
            {
                
                _loc_5 = _loc_2.elt.interactors.head;
                while (_loc_5 != null)
                {
                    
                    _loc_6 = _loc_5.elt;
                    _loc_6.wake();
                    _loc_5 = _loc_5.next;
                }
                _loc_2 = _loc_2.next;
            }
            return;
        }// end function

        override public function swapEvent(param1:int) : void
        {
            if (type == ZPP_Flags.id_ListenerType_PRE)
            {
                throw "Error: PreListener event can only be PRE";
            }
            else
            {
                if (param1 != ZPP_Flags.id_CbEvent_BEGIN)
                {
                }
                if (param1 != ZPP_Flags.id_CbEvent_END)
                {
                }
                if (param1 != ZPP_Flags.id_CbEvent_ONGOING)
                {
                    throw "Error: InteractionListener event must be either BEGIN, END, ONGOING";
                }
            }
            removedFromSpace();
            event = param1;
            addedToSpace();
            return;
        }// end function

        public function setInteractionType(param1:int) : void
        {
            itype = param1;
            return;
        }// end function

        override public function removedFromSpace() : void
        {
            var _loc_5:* = null as ZPP_CbType;
            var _loc_6:* = null as ZPP_CbType;
            var _loc_7:* = null as ZNPNode_ZPP_CbSet;
            var _loc_8:* = null as ZPP_CbSet;
            var _loc_9:* = null as ZNPNode_ZPP_Interactor;
            var _loc_10:* = null as ZPP_Interactor;
            var _loc_1:* = this;
            with_uniquesets(false);
            var _loc_2:* = type == ZPP_Flags.id_ListenerType_PRE;
            var _loc_3:* = options1.includes.head;
            var _loc_4:* = options2.includes.head;
            do
            {
                
                _loc_5 = _loc_3.elt;
                _loc_6 = _loc_4.elt;
                if (_loc_5 == _loc_6)
                {
                    _loc_5.listeners.remove(_loc_1);
                    _loc_7 = _loc_5.cbsets.head;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.elt;
                        _loc_8.zip_listeners = true;
                        _loc_8.invalidate_pairs();
                        _loc_7 = _loc_7.next;
                    }
                    if (_loc_2)
                    {
                        _loc_9 = _loc_5.interactors.head;
                        while (_loc_9 != null)
                        {
                            
                            _loc_10 = _loc_9.elt;
                            _loc_10.wake();
                            _loc_9 = _loc_9.next;
                        }
                    }
                    _loc_3 = _loc_3.next;
                    _loc_4 = _loc_4.next;
                }
                else if (_loc_5.id < _loc_6.id)
                {
                    _loc_5.listeners.remove(_loc_1);
                    _loc_7 = _loc_5.cbsets.head;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.elt;
                        _loc_8.zip_listeners = true;
                        _loc_8.invalidate_pairs();
                        _loc_7 = _loc_7.next;
                    }
                    if (_loc_2)
                    {
                        _loc_9 = _loc_5.interactors.head;
                        while (_loc_9 != null)
                        {
                            
                            _loc_10 = _loc_9.elt;
                            _loc_10.wake();
                            _loc_9 = _loc_9.next;
                        }
                    }
                    _loc_3 = _loc_3.next;
                }
                else
                {
                    _loc_6.listeners.remove(_loc_1);
                    _loc_7 = _loc_6.cbsets.head;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.elt;
                        _loc_8.zip_listeners = true;
                        _loc_8.invalidate_pairs();
                        _loc_7 = _loc_7.next;
                    }
                    if (_loc_2)
                    {
                        _loc_9 = _loc_6.interactors.head;
                        while (_loc_9 != null)
                        {
                            
                            _loc_10 = _loc_9.elt;
                            _loc_10.wake();
                            _loc_9 = _loc_9.next;
                        }
                    }
                    _loc_4 = _loc_4.next;
                }
                if (_loc_3 != null)
                {
                }
            }while (_loc_4 != null)
            while (_loc_3 != null)
            {
                
                _loc_5 = _loc_3.elt;
                _loc_5.listeners.remove(_loc_1);
                _loc_7 = _loc_5.cbsets.head;
                while (_loc_7 != null)
                {
                    
                    _loc_8 = _loc_7.elt;
                    _loc_8.zip_listeners = true;
                    _loc_8.invalidate_pairs();
                    _loc_7 = _loc_7.next;
                }
                if (_loc_2)
                {
                    _loc_9 = _loc_5.interactors.head;
                    while (_loc_9 != null)
                    {
                        
                        _loc_10 = _loc_9.elt;
                        _loc_10.wake();
                        _loc_9 = _loc_9.next;
                    }
                }
                _loc_3 = _loc_3.next;
            }
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                _loc_5.listeners.remove(_loc_1);
                _loc_7 = _loc_5.cbsets.head;
                while (_loc_7 != null)
                {
                    
                    _loc_8 = _loc_7.elt;
                    _loc_8.zip_listeners = true;
                    _loc_8.invalidate_pairs();
                    _loc_7 = _loc_7.next;
                }
                if (_loc_2)
                {
                    _loc_9 = _loc_5.interactors.head;
                    while (_loc_9 != null)
                    {
                        
                        _loc_10 = _loc_9.elt;
                        _loc_10.wake();
                        _loc_9 = _loc_9.next;
                    }
                }
                _loc_4 = _loc_4.next;
            }
            options1.handler = null;
            options2.handler = null;
            return;
        }// end function

        override public function invalidate_precedence() : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null as ZNPNode_ZPP_CbType;
            var _loc_4:* = null as ZNPNode_ZPP_CbType;
            var _loc_5:* = null as ZPP_CbType;
            var _loc_6:* = null as ZPP_CbType;
            var _loc_7:* = null as ZNPNode_ZPP_CbSet;
            var _loc_8:* = null as ZPP_CbSet;
            var _loc_9:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_10:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_11:* = null as ZPP_InteractionListener;
            var _loc_12:* = null as ZNPList_ZPP_InteractionListener;
            var _loc_13:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_14:* = false;
            var _loc_15:* = null as ZNPNode_ZPP_Interactor;
            var _loc_16:* = null as ZPP_Interactor;
            var _loc_1:* = this;
            if (space != null)
            {
                _loc_2 = type == ZPP_Flags.id_ListenerType_PRE;
                _loc_3 = options1.includes.head;
                _loc_4 = options2.includes.head;
                do
                {
                    
                    _loc_5 = _loc_3.elt;
                    _loc_6 = _loc_4.elt;
                    if (_loc_5 == _loc_6)
                    {
                        _loc_5.listeners.remove(_loc_1);
                        _loc_7 = _loc_5.cbsets.head;
                        while (_loc_7 != null)
                        {
                            
                            _loc_8 = _loc_7.elt;
                            _loc_8.zip_listeners = true;
                            _loc_8.invalidate_pairs();
                            _loc_7 = _loc_7.next;
                        }
                        _loc_9 = null;
                        _loc_10 = _loc_5.listeners.head;
                        while (_loc_10 != null)
                        {
                            
                            _loc_11 = _loc_10.elt;
                            if (_loc_1.precedence <= _loc_11.precedence)
                            {
                                if (_loc_1.precedence == _loc_11.precedence)
                                {
                                }
                            }
                            if (_loc_1.id > _loc_11.id)
                            {
                                break;
                            }
                            _loc_9 = _loc_10;
                            _loc_10 = _loc_10.next;
                        }
                        _loc_12 = _loc_5.listeners;
                        if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                        {
                            _loc_13 = new ZNPNode_ZPP_InteractionListener();
                        }
                        else
                        {
                            _loc_13 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                            ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_13.next;
                            _loc_13.next = null;
                        }
                        _loc_13.elt = _loc_1;
                        _loc_10 = _loc_13;
                        if (_loc_9 == null)
                        {
                            _loc_10.next = _loc_12.head;
                            _loc_12.head = _loc_10;
                        }
                        else
                        {
                            _loc_10.next = _loc_9.next;
                            _loc_9.next = _loc_10;
                        }
                        _loc_14 = true;
                        _loc_12.modified = _loc_14;
                        _loc_12.pushmod = _loc_14;
                        (_loc_12.length + 1);
                        _loc_7 = _loc_5.cbsets.head;
                        while (_loc_7 != null)
                        {
                            
                            _loc_8 = _loc_7.elt;
                            _loc_8.zip_listeners = true;
                            _loc_8.invalidate_pairs();
                            _loc_7 = _loc_7.next;
                        }
                        if (_loc_2)
                        {
                            _loc_15 = _loc_5.interactors.head;
                            while (_loc_15 != null)
                            {
                                
                                _loc_16 = _loc_15.elt;
                                _loc_16.wake();
                                _loc_15 = _loc_15.next;
                            }
                        }
                        _loc_3 = _loc_3.next;
                        _loc_4 = _loc_4.next;
                    }
                    else if (_loc_5.id < _loc_6.id)
                    {
                        _loc_5.listeners.remove(_loc_1);
                        _loc_7 = _loc_5.cbsets.head;
                        while (_loc_7 != null)
                        {
                            
                            _loc_8 = _loc_7.elt;
                            _loc_8.zip_listeners = true;
                            _loc_8.invalidate_pairs();
                            _loc_7 = _loc_7.next;
                        }
                        _loc_9 = null;
                        _loc_10 = _loc_5.listeners.head;
                        while (_loc_10 != null)
                        {
                            
                            _loc_11 = _loc_10.elt;
                            if (_loc_1.precedence <= _loc_11.precedence)
                            {
                                if (_loc_1.precedence == _loc_11.precedence)
                                {
                                }
                            }
                            if (_loc_1.id > _loc_11.id)
                            {
                                break;
                            }
                            _loc_9 = _loc_10;
                            _loc_10 = _loc_10.next;
                        }
                        _loc_12 = _loc_5.listeners;
                        if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                        {
                            _loc_13 = new ZNPNode_ZPP_InteractionListener();
                        }
                        else
                        {
                            _loc_13 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                            ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_13.next;
                            _loc_13.next = null;
                        }
                        _loc_13.elt = _loc_1;
                        _loc_10 = _loc_13;
                        if (_loc_9 == null)
                        {
                            _loc_10.next = _loc_12.head;
                            _loc_12.head = _loc_10;
                        }
                        else
                        {
                            _loc_10.next = _loc_9.next;
                            _loc_9.next = _loc_10;
                        }
                        _loc_14 = true;
                        _loc_12.modified = _loc_14;
                        _loc_12.pushmod = _loc_14;
                        (_loc_12.length + 1);
                        _loc_7 = _loc_5.cbsets.head;
                        while (_loc_7 != null)
                        {
                            
                            _loc_8 = _loc_7.elt;
                            _loc_8.zip_listeners = true;
                            _loc_8.invalidate_pairs();
                            _loc_7 = _loc_7.next;
                        }
                        if (_loc_2)
                        {
                            _loc_15 = _loc_5.interactors.head;
                            while (_loc_15 != null)
                            {
                                
                                _loc_16 = _loc_15.elt;
                                _loc_16.wake();
                                _loc_15 = _loc_15.next;
                            }
                        }
                        _loc_3 = _loc_3.next;
                    }
                    else
                    {
                        _loc_6.listeners.remove(_loc_1);
                        _loc_7 = _loc_6.cbsets.head;
                        while (_loc_7 != null)
                        {
                            
                            _loc_8 = _loc_7.elt;
                            _loc_8.zip_listeners = true;
                            _loc_8.invalidate_pairs();
                            _loc_7 = _loc_7.next;
                        }
                        _loc_9 = null;
                        _loc_10 = _loc_6.listeners.head;
                        while (_loc_10 != null)
                        {
                            
                            _loc_11 = _loc_10.elt;
                            if (_loc_1.precedence <= _loc_11.precedence)
                            {
                                if (_loc_1.precedence == _loc_11.precedence)
                                {
                                }
                            }
                            if (_loc_1.id > _loc_11.id)
                            {
                                break;
                            }
                            _loc_9 = _loc_10;
                            _loc_10 = _loc_10.next;
                        }
                        _loc_12 = _loc_6.listeners;
                        if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                        {
                            _loc_13 = new ZNPNode_ZPP_InteractionListener();
                        }
                        else
                        {
                            _loc_13 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                            ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_13.next;
                            _loc_13.next = null;
                        }
                        _loc_13.elt = _loc_1;
                        _loc_10 = _loc_13;
                        if (_loc_9 == null)
                        {
                            _loc_10.next = _loc_12.head;
                            _loc_12.head = _loc_10;
                        }
                        else
                        {
                            _loc_10.next = _loc_9.next;
                            _loc_9.next = _loc_10;
                        }
                        _loc_14 = true;
                        _loc_12.modified = _loc_14;
                        _loc_12.pushmod = _loc_14;
                        (_loc_12.length + 1);
                        _loc_7 = _loc_6.cbsets.head;
                        while (_loc_7 != null)
                        {
                            
                            _loc_8 = _loc_7.elt;
                            _loc_8.zip_listeners = true;
                            _loc_8.invalidate_pairs();
                            _loc_7 = _loc_7.next;
                        }
                        if (_loc_2)
                        {
                            _loc_15 = _loc_6.interactors.head;
                            while (_loc_15 != null)
                            {
                                
                                _loc_16 = _loc_15.elt;
                                _loc_16.wake();
                                _loc_15 = _loc_15.next;
                            }
                        }
                        _loc_4 = _loc_4.next;
                    }
                    if (_loc_3 != null)
                    {
                    }
                }while (_loc_4 != null)
                while (_loc_3 != null)
                {
                    
                    _loc_5 = _loc_3.elt;
                    _loc_5.listeners.remove(_loc_1);
                    _loc_7 = _loc_5.cbsets.head;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.elt;
                        _loc_8.zip_listeners = true;
                        _loc_8.invalidate_pairs();
                        _loc_7 = _loc_7.next;
                    }
                    _loc_9 = null;
                    _loc_10 = _loc_5.listeners.head;
                    while (_loc_10 != null)
                    {
                        
                        _loc_11 = _loc_10.elt;
                        if (_loc_1.precedence <= _loc_11.precedence)
                        {
                            if (_loc_1.precedence == _loc_11.precedence)
                            {
                            }
                        }
                        if (_loc_1.id > _loc_11.id)
                        {
                            break;
                        }
                        _loc_9 = _loc_10;
                        _loc_10 = _loc_10.next;
                    }
                    _loc_12 = _loc_5.listeners;
                    if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                    {
                        _loc_13 = new ZNPNode_ZPP_InteractionListener();
                    }
                    else
                    {
                        _loc_13 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                        ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_13.next;
                        _loc_13.next = null;
                    }
                    _loc_13.elt = _loc_1;
                    _loc_10 = _loc_13;
                    if (_loc_9 == null)
                    {
                        _loc_10.next = _loc_12.head;
                        _loc_12.head = _loc_10;
                    }
                    else
                    {
                        _loc_10.next = _loc_9.next;
                        _loc_9.next = _loc_10;
                    }
                    _loc_14 = true;
                    _loc_12.modified = _loc_14;
                    _loc_12.pushmod = _loc_14;
                    (_loc_12.length + 1);
                    _loc_7 = _loc_5.cbsets.head;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.elt;
                        _loc_8.zip_listeners = true;
                        _loc_8.invalidate_pairs();
                        _loc_7 = _loc_7.next;
                    }
                    if (_loc_2)
                    {
                        _loc_15 = _loc_5.interactors.head;
                        while (_loc_15 != null)
                        {
                            
                            _loc_16 = _loc_15.elt;
                            _loc_16.wake();
                            _loc_15 = _loc_15.next;
                        }
                    }
                    _loc_3 = _loc_3.next;
                }
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.elt;
                    _loc_5.listeners.remove(_loc_1);
                    _loc_7 = _loc_5.cbsets.head;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.elt;
                        _loc_8.zip_listeners = true;
                        _loc_8.invalidate_pairs();
                        _loc_7 = _loc_7.next;
                    }
                    _loc_9 = null;
                    _loc_10 = _loc_5.listeners.head;
                    while (_loc_10 != null)
                    {
                        
                        _loc_11 = _loc_10.elt;
                        if (_loc_1.precedence <= _loc_11.precedence)
                        {
                            if (_loc_1.precedence == _loc_11.precedence)
                            {
                            }
                        }
                        if (_loc_1.id > _loc_11.id)
                        {
                            break;
                        }
                        _loc_9 = _loc_10;
                        _loc_10 = _loc_10.next;
                    }
                    _loc_12 = _loc_5.listeners;
                    if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                    {
                        _loc_13 = new ZNPNode_ZPP_InteractionListener();
                    }
                    else
                    {
                        _loc_13 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                        ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_13.next;
                        _loc_13.next = null;
                    }
                    _loc_13.elt = _loc_1;
                    _loc_10 = _loc_13;
                    if (_loc_9 == null)
                    {
                        _loc_10.next = _loc_12.head;
                        _loc_12.head = _loc_10;
                    }
                    else
                    {
                        _loc_10.next = _loc_9.next;
                        _loc_9.next = _loc_10;
                    }
                    _loc_14 = true;
                    _loc_12.modified = _loc_14;
                    _loc_12.pushmod = _loc_14;
                    (_loc_12.length + 1);
                    _loc_7 = _loc_5.cbsets.head;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.elt;
                        _loc_8.zip_listeners = true;
                        _loc_8.invalidate_pairs();
                        _loc_7 = _loc_7.next;
                    }
                    if (_loc_2)
                    {
                        _loc_15 = _loc_5.interactors.head;
                        while (_loc_15 != null)
                        {
                            
                            _loc_16 = _loc_15.elt;
                            _loc_16.wake();
                            _loc_15 = _loc_15.next;
                        }
                    }
                    _loc_4 = _loc_4.next;
                }
            }
            return;
        }// end function

        public function cbtype_change2(param1:ZPP_CbType, param2:Boolean, param3:Boolean) : void
        {
            cbtype_change(options2, param1, param2, param3);
            return;
        }// end function

        public function cbtype_change1(param1:ZPP_CbType, param2:Boolean, param3:Boolean) : void
        {
            cbtype_change(options1, param1, param2, param3);
            return;
        }// end function

        public function cbtype_change(param1:ZPP_OptionType, param2:ZPP_CbType, param3:Boolean, param4:Boolean) : void
        {
            var _loc_5:* = null as ZNPNode_ZPP_CbType;
            var _loc_6:* = null as ZNPNode_ZPP_CbType;
            var _loc_7:* = null as ZPP_CbType;
            var _loc_8:* = null as ZNPList_ZPP_CbType;
            var _loc_9:* = null as ZNPNode_ZPP_CbType;
            var _loc_10:* = false;
            removedFromSpace();
            if (param3)
            {
                if (param4)
                {
                    _loc_5 = null;
                    _loc_6 = param1.includes.head;
                    while (_loc_6 != null)
                    {
                        
                        _loc_7 = _loc_6.elt;
                        if (param2.id < _loc_7.id)
                        {
                            break;
                        }
                        _loc_5 = _loc_6;
                        _loc_6 = _loc_6.next;
                    }
                    _loc_8 = param1.includes;
                    if (ZNPNode_ZPP_CbType.zpp_pool == null)
                    {
                        _loc_9 = new ZNPNode_ZPP_CbType();
                    }
                    else
                    {
                        _loc_9 = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc_9.next;
                        _loc_9.next = null;
                    }
                    _loc_9.elt = param2;
                    _loc_6 = _loc_9;
                    if (_loc_5 == null)
                    {
                        _loc_6.next = _loc_8.head;
                        _loc_8.head = _loc_6;
                    }
                    else
                    {
                        _loc_6.next = _loc_5.next;
                        _loc_5.next = _loc_6;
                    }
                    _loc_10 = true;
                    _loc_8.modified = _loc_10;
                    _loc_8.pushmod = _loc_10;
                    (_loc_8.length + 1);
                }
                else
                {
                    param1.includes.remove(param2);
                }
            }
            else if (param4)
            {
                _loc_5 = null;
                _loc_6 = param1.excludes.head;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6.elt;
                    if (param2.id < _loc_7.id)
                    {
                        break;
                    }
                    _loc_5 = _loc_6;
                    _loc_6 = _loc_6.next;
                }
                _loc_8 = param1.excludes;
                if (ZNPNode_ZPP_CbType.zpp_pool == null)
                {
                    _loc_9 = new ZNPNode_ZPP_CbType();
                }
                else
                {
                    _loc_9 = ZNPNode_ZPP_CbType.zpp_pool;
                    ZNPNode_ZPP_CbType.zpp_pool = _loc_9.next;
                    _loc_9.next = null;
                }
                _loc_9.elt = param2;
                _loc_6 = _loc_9;
                if (_loc_5 == null)
                {
                    _loc_6.next = _loc_8.head;
                    _loc_8.head = _loc_6;
                }
                else
                {
                    _loc_6.next = _loc_5.next;
                    _loc_5.next = _loc_6;
                }
                _loc_10 = true;
                _loc_8.modified = _loc_10;
                _loc_8.pushmod = _loc_10;
                (_loc_8.length + 1);
            }
            else
            {
                param1.excludes.remove(param2);
            }
            addedToSpace();
            return;
        }// end function

        override public function addedToSpace() : void
        {
            var _loc_5:* = null as ZPP_CbType;
            var _loc_6:* = null as ZPP_CbType;
            var _loc_7:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_8:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_9:* = null as ZPP_InteractionListener;
            var _loc_10:* = null as ZNPList_ZPP_InteractionListener;
            var _loc_11:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_12:* = false;
            var _loc_13:* = null as ZNPNode_ZPP_CbSet;
            var _loc_14:* = null as ZPP_CbSet;
            var _loc_15:* = null as ZNPNode_ZPP_Interactor;
            var _loc_16:* = null as ZPP_Interactor;
            var _loc_1:* = this;
            var _loc_2:* = type == ZPP_Flags.id_ListenerType_PRE;
            var _loc_3:* = options1.includes.head;
            var _loc_4:* = options2.includes.head;
            do
            {
                
                _loc_5 = _loc_3.elt;
                _loc_6 = _loc_4.elt;
                if (_loc_5 == _loc_6)
                {
                    _loc_7 = null;
                    _loc_8 = _loc_5.listeners.head;
                    while (_loc_8 != null)
                    {
                        
                        _loc_9 = _loc_8.elt;
                        if (_loc_1.precedence <= _loc_9.precedence)
                        {
                            if (_loc_1.precedence == _loc_9.precedence)
                            {
                            }
                        }
                        if (_loc_1.id > _loc_9.id)
                        {
                            break;
                        }
                        _loc_7 = _loc_8;
                        _loc_8 = _loc_8.next;
                    }
                    _loc_10 = _loc_5.listeners;
                    if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                    {
                        _loc_11 = new ZNPNode_ZPP_InteractionListener();
                    }
                    else
                    {
                        _loc_11 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                        ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.elt = _loc_1;
                    _loc_8 = _loc_11;
                    if (_loc_7 == null)
                    {
                        _loc_8.next = _loc_10.head;
                        _loc_10.head = _loc_8;
                    }
                    else
                    {
                        _loc_8.next = _loc_7.next;
                        _loc_7.next = _loc_8;
                    }
                    _loc_12 = true;
                    _loc_10.modified = _loc_12;
                    _loc_10.pushmod = _loc_12;
                    (_loc_10.length + 1);
                    _loc_13 = _loc_5.cbsets.head;
                    while (_loc_13 != null)
                    {
                        
                        _loc_14 = _loc_13.elt;
                        _loc_14.zip_listeners = true;
                        _loc_14.invalidate_pairs();
                        _loc_13 = _loc_13.next;
                    }
                    if (_loc_2)
                    {
                        _loc_15 = _loc_5.interactors.head;
                        while (_loc_15 != null)
                        {
                            
                            _loc_16 = _loc_15.elt;
                            _loc_16.wake();
                            _loc_15 = _loc_15.next;
                        }
                    }
                    _loc_3 = _loc_3.next;
                    _loc_4 = _loc_4.next;
                }
                else if (_loc_5.id < _loc_6.id)
                {
                    _loc_7 = null;
                    _loc_8 = _loc_5.listeners.head;
                    while (_loc_8 != null)
                    {
                        
                        _loc_9 = _loc_8.elt;
                        if (_loc_1.precedence <= _loc_9.precedence)
                        {
                            if (_loc_1.precedence == _loc_9.precedence)
                            {
                            }
                        }
                        if (_loc_1.id > _loc_9.id)
                        {
                            break;
                        }
                        _loc_7 = _loc_8;
                        _loc_8 = _loc_8.next;
                    }
                    _loc_10 = _loc_5.listeners;
                    if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                    {
                        _loc_11 = new ZNPNode_ZPP_InteractionListener();
                    }
                    else
                    {
                        _loc_11 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                        ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.elt = _loc_1;
                    _loc_8 = _loc_11;
                    if (_loc_7 == null)
                    {
                        _loc_8.next = _loc_10.head;
                        _loc_10.head = _loc_8;
                    }
                    else
                    {
                        _loc_8.next = _loc_7.next;
                        _loc_7.next = _loc_8;
                    }
                    _loc_12 = true;
                    _loc_10.modified = _loc_12;
                    _loc_10.pushmod = _loc_12;
                    (_loc_10.length + 1);
                    _loc_13 = _loc_5.cbsets.head;
                    while (_loc_13 != null)
                    {
                        
                        _loc_14 = _loc_13.elt;
                        _loc_14.zip_listeners = true;
                        _loc_14.invalidate_pairs();
                        _loc_13 = _loc_13.next;
                    }
                    if (_loc_2)
                    {
                        _loc_15 = _loc_5.interactors.head;
                        while (_loc_15 != null)
                        {
                            
                            _loc_16 = _loc_15.elt;
                            _loc_16.wake();
                            _loc_15 = _loc_15.next;
                        }
                    }
                    _loc_3 = _loc_3.next;
                }
                else
                {
                    _loc_7 = null;
                    _loc_8 = _loc_6.listeners.head;
                    while (_loc_8 != null)
                    {
                        
                        _loc_9 = _loc_8.elt;
                        if (_loc_1.precedence <= _loc_9.precedence)
                        {
                            if (_loc_1.precedence == _loc_9.precedence)
                            {
                            }
                        }
                        if (_loc_1.id > _loc_9.id)
                        {
                            break;
                        }
                        _loc_7 = _loc_8;
                        _loc_8 = _loc_8.next;
                    }
                    _loc_10 = _loc_6.listeners;
                    if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                    {
                        _loc_11 = new ZNPNode_ZPP_InteractionListener();
                    }
                    else
                    {
                        _loc_11 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                        ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.elt = _loc_1;
                    _loc_8 = _loc_11;
                    if (_loc_7 == null)
                    {
                        _loc_8.next = _loc_10.head;
                        _loc_10.head = _loc_8;
                    }
                    else
                    {
                        _loc_8.next = _loc_7.next;
                        _loc_7.next = _loc_8;
                    }
                    _loc_12 = true;
                    _loc_10.modified = _loc_12;
                    _loc_10.pushmod = _loc_12;
                    (_loc_10.length + 1);
                    _loc_13 = _loc_6.cbsets.head;
                    while (_loc_13 != null)
                    {
                        
                        _loc_14 = _loc_13.elt;
                        _loc_14.zip_listeners = true;
                        _loc_14.invalidate_pairs();
                        _loc_13 = _loc_13.next;
                    }
                    if (_loc_2)
                    {
                        _loc_15 = _loc_6.interactors.head;
                        while (_loc_15 != null)
                        {
                            
                            _loc_16 = _loc_15.elt;
                            _loc_16.wake();
                            _loc_15 = _loc_15.next;
                        }
                    }
                    _loc_4 = _loc_4.next;
                }
                if (_loc_3 != null)
                {
                }
            }while (_loc_4 != null)
            while (_loc_3 != null)
            {
                
                _loc_5 = _loc_3.elt;
                _loc_7 = null;
                _loc_8 = _loc_5.listeners.head;
                while (_loc_8 != null)
                {
                    
                    _loc_9 = _loc_8.elt;
                    if (_loc_1.precedence <= _loc_9.precedence)
                    {
                        if (_loc_1.precedence == _loc_9.precedence)
                        {
                        }
                    }
                    if (_loc_1.id > _loc_9.id)
                    {
                        break;
                    }
                    _loc_7 = _loc_8;
                    _loc_8 = _loc_8.next;
                }
                _loc_10 = _loc_5.listeners;
                if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                {
                    _loc_11 = new ZNPNode_ZPP_InteractionListener();
                }
                else
                {
                    _loc_11 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                    ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_11.next;
                    _loc_11.next = null;
                }
                _loc_11.elt = _loc_1;
                _loc_8 = _loc_11;
                if (_loc_7 == null)
                {
                    _loc_8.next = _loc_10.head;
                    _loc_10.head = _loc_8;
                }
                else
                {
                    _loc_8.next = _loc_7.next;
                    _loc_7.next = _loc_8;
                }
                _loc_12 = true;
                _loc_10.modified = _loc_12;
                _loc_10.pushmod = _loc_12;
                (_loc_10.length + 1);
                _loc_13 = _loc_5.cbsets.head;
                while (_loc_13 != null)
                {
                    
                    _loc_14 = _loc_13.elt;
                    _loc_14.zip_listeners = true;
                    _loc_14.invalidate_pairs();
                    _loc_13 = _loc_13.next;
                }
                if (_loc_2)
                {
                    _loc_15 = _loc_5.interactors.head;
                    while (_loc_15 != null)
                    {
                        
                        _loc_16 = _loc_15.elt;
                        _loc_16.wake();
                        _loc_15 = _loc_15.next;
                    }
                }
                _loc_3 = _loc_3.next;
            }
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                _loc_7 = null;
                _loc_8 = _loc_5.listeners.head;
                while (_loc_8 != null)
                {
                    
                    _loc_9 = _loc_8.elt;
                    if (_loc_1.precedence <= _loc_9.precedence)
                    {
                        if (_loc_1.precedence == _loc_9.precedence)
                        {
                        }
                    }
                    if (_loc_1.id > _loc_9.id)
                    {
                        break;
                    }
                    _loc_7 = _loc_8;
                    _loc_8 = _loc_8.next;
                }
                _loc_10 = _loc_5.listeners;
                if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                {
                    _loc_11 = new ZNPNode_ZPP_InteractionListener();
                }
                else
                {
                    _loc_11 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                    ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_11.next;
                    _loc_11.next = null;
                }
                _loc_11.elt = _loc_1;
                _loc_8 = _loc_11;
                if (_loc_7 == null)
                {
                    _loc_8.next = _loc_10.head;
                    _loc_10.head = _loc_8;
                }
                else
                {
                    _loc_8.next = _loc_7.next;
                    _loc_7.next = _loc_8;
                }
                _loc_12 = true;
                _loc_10.modified = _loc_12;
                _loc_10.pushmod = _loc_12;
                (_loc_10.length + 1);
                _loc_13 = _loc_5.cbsets.head;
                while (_loc_13 != null)
                {
                    
                    _loc_14 = _loc_13.elt;
                    _loc_14.zip_listeners = true;
                    _loc_14.invalidate_pairs();
                    _loc_13 = _loc_13.next;
                }
                if (_loc_2)
                {
                    _loc_15 = _loc_5.interactors.head;
                    while (_loc_15 != null)
                    {
                        
                        _loc_16 = _loc_15.elt;
                        _loc_16.wake();
                        _loc_15 = _loc_15.next;
                    }
                }
                _loc_4 = _loc_4.next;
            }
            options1.handler = cbtype_change1;
            options2.handler = cbtype_change2;
            with_uniquesets(true);
            return;
        }// end function

        public function CbTypeset(param1:ZNPList_ZPP_CbType, param2:ZNPList_ZPP_CbType, param3:Function) : void
        {
            var _loc_9:* = null as ZPP_CbType;
            var _loc_10:* = null as ZPP_CbType;
            var _loc_11:* = null as ZNPNode_ZPP_CbType;
            var _loc_12:* = null as ZNPNode_ZPP_CbType;
            var _loc_4:* = ZPP_InteractionListener.UCbType;
            var _loc_5:* = ZPP_InteractionListener.VCbType;
            var _loc_6:* = ZPP_InteractionListener.WCbType;
            var _loc_7:* = param1.head;
            var _loc_8:* = param2.head;
            do
            {
                
                _loc_9 = _loc_7.elt;
                _loc_10 = _loc_8.elt;
                if (_loc_9 == _loc_10)
                {
                    if (ZNPNode_ZPP_CbType.zpp_pool == null)
                    {
                        _loc_12 = new ZNPNode_ZPP_CbType();
                    }
                    else
                    {
                        _loc_12 = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc_12.next;
                        _loc_12.next = null;
                    }
                    _loc_12.elt = _loc_9;
                    _loc_11 = _loc_12;
                    _loc_11.next = _loc_6.head;
                    _loc_6.head = _loc_11;
                    _loc_6.modified = true;
                    (_loc_6.length + 1);
                    _loc_7 = _loc_7.next;
                    _loc_8 = _loc_8.next;
                }
                else if (_loc_9.id < _loc_10.id)
                {
                    if (ZNPNode_ZPP_CbType.zpp_pool == null)
                    {
                        _loc_12 = new ZNPNode_ZPP_CbType();
                    }
                    else
                    {
                        _loc_12 = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc_12.next;
                        _loc_12.next = null;
                    }
                    _loc_12.elt = _loc_9;
                    _loc_11 = _loc_12;
                    _loc_11.next = _loc_4.head;
                    _loc_4.head = _loc_11;
                    _loc_4.modified = true;
                    (_loc_4.length + 1);
                    _loc_7 = _loc_7.next;
                }
                else
                {
                    if (ZNPNode_ZPP_CbType.zpp_pool == null)
                    {
                        _loc_12 = new ZNPNode_ZPP_CbType();
                    }
                    else
                    {
                        _loc_12 = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc_12.next;
                        _loc_12.next = null;
                    }
                    _loc_12.elt = _loc_10;
                    _loc_11 = _loc_12;
                    _loc_11.next = _loc_5.head;
                    _loc_5.head = _loc_11;
                    _loc_5.modified = true;
                    (_loc_5.length + 1);
                    _loc_8 = _loc_8.next;
                }
                if (_loc_7 != null)
                {
                }
            }while (_loc_8 != null)
            while (_loc_7 != null)
            {
                
                _loc_9 = _loc_7.elt;
                if (ZNPNode_ZPP_CbType.zpp_pool == null)
                {
                    _loc_12 = new ZNPNode_ZPP_CbType();
                }
                else
                {
                    _loc_12 = ZNPNode_ZPP_CbType.zpp_pool;
                    ZNPNode_ZPP_CbType.zpp_pool = _loc_12.next;
                    _loc_12.next = null;
                }
                _loc_12.elt = _loc_9;
                _loc_11 = _loc_12;
                _loc_11.next = _loc_4.head;
                _loc_4.head = _loc_11;
                _loc_4.modified = true;
                (_loc_4.length + 1);
                _loc_7 = _loc_7.next;
            }
            while (_loc_8 != null)
            {
                
                _loc_9 = _loc_8.elt;
                if (ZNPNode_ZPP_CbType.zpp_pool == null)
                {
                    _loc_12 = new ZNPNode_ZPP_CbType();
                }
                else
                {
                    _loc_12 = ZNPNode_ZPP_CbType.zpp_pool;
                    ZNPNode_ZPP_CbType.zpp_pool = _loc_12.next;
                    _loc_12.next = null;
                }
                _loc_12.elt = _loc_9;
                _loc_11 = _loc_12;
                _loc_11.next = _loc_5.head;
                _loc_5.head = _loc_11;
                _loc_5.modified = true;
                (_loc_5.length + 1);
                _loc_8 = _loc_8.next;
            }
            while (_loc_4.head != null)
            {
                
                _loc_9 = _loc_4.pop_unsafe();
                _loc_11 = param2.head;
                while (_loc_11 != null)
                {
                    
                    _loc_10 = _loc_11.elt;
                    null.param3(_loc_9, _loc_10);
                    _loc_11 = _loc_11.next;
                }
            }
            while (_loc_5.head != null)
            {
                
                _loc_9 = _loc_5.pop_unsafe();
                _loc_11 = _loc_6.head;
                while (_loc_11 != null)
                {
                    
                    _loc_10 = _loc_11.elt;
                    null.param3(_loc_9, _loc_10);
                    _loc_11 = _loc_11.next;
                }
            }
            while (_loc_6.head != null)
            {
                
                _loc_9 = _loc_6.pop_unsafe();
                null.param3(_loc_9, _loc_9);
                _loc_11 = _loc_6.head;
                while (_loc_11 != null)
                {
                    
                    _loc_10 = _loc_11.elt;
                    null.param3(_loc_9, _loc_10);
                    _loc_11 = _loc_11.next;
                }
            }
            return;
        }// end function

        public function CbSetset(param1:ZNPList_ZPP_CbSet, param2:ZNPList_ZPP_CbSet, param3:Function) : void
        {
            var _loc_9:* = null as ZPP_CbSet;
            var _loc_10:* = null as ZPP_CbSet;
            var _loc_11:* = null as ZNPNode_ZPP_CbSet;
            var _loc_12:* = null as ZNPNode_ZPP_CbSet;
            var _loc_4:* = ZPP_InteractionListener.UCbSet;
            var _loc_5:* = ZPP_InteractionListener.VCbSet;
            var _loc_6:* = ZPP_InteractionListener.WCbSet;
            var _loc_7:* = param1.head;
            var _loc_8:* = param2.head;
            do
            {
                
                _loc_9 = _loc_7.elt;
                _loc_10 = _loc_8.elt;
                if (_loc_9 == _loc_10)
                {
                    if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                    {
                        _loc_12 = new ZNPNode_ZPP_CbSet();
                    }
                    else
                    {
                        _loc_12 = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc_12.next;
                        _loc_12.next = null;
                    }
                    _loc_12.elt = _loc_9;
                    _loc_11 = _loc_12;
                    _loc_11.next = _loc_6.head;
                    _loc_6.head = _loc_11;
                    _loc_6.modified = true;
                    (_loc_6.length + 1);
                    _loc_7 = _loc_7.next;
                    _loc_8 = _loc_8.next;
                }
                else if (ZPP_CbSet.setlt(_loc_9, _loc_10))
                {
                    if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                    {
                        _loc_12 = new ZNPNode_ZPP_CbSet();
                    }
                    else
                    {
                        _loc_12 = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc_12.next;
                        _loc_12.next = null;
                    }
                    _loc_12.elt = _loc_9;
                    _loc_11 = _loc_12;
                    _loc_11.next = _loc_4.head;
                    _loc_4.head = _loc_11;
                    _loc_4.modified = true;
                    (_loc_4.length + 1);
                    _loc_7 = _loc_7.next;
                }
                else
                {
                    if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                    {
                        _loc_12 = new ZNPNode_ZPP_CbSet();
                    }
                    else
                    {
                        _loc_12 = ZNPNode_ZPP_CbSet.zpp_pool;
                        ZNPNode_ZPP_CbSet.zpp_pool = _loc_12.next;
                        _loc_12.next = null;
                    }
                    _loc_12.elt = _loc_10;
                    _loc_11 = _loc_12;
                    _loc_11.next = _loc_5.head;
                    _loc_5.head = _loc_11;
                    _loc_5.modified = true;
                    (_loc_5.length + 1);
                    _loc_8 = _loc_8.next;
                }
                if (_loc_7 != null)
                {
                }
            }while (_loc_8 != null)
            while (_loc_7 != null)
            {
                
                _loc_9 = _loc_7.elt;
                if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                {
                    _loc_12 = new ZNPNode_ZPP_CbSet();
                }
                else
                {
                    _loc_12 = ZNPNode_ZPP_CbSet.zpp_pool;
                    ZNPNode_ZPP_CbSet.zpp_pool = _loc_12.next;
                    _loc_12.next = null;
                }
                _loc_12.elt = _loc_9;
                _loc_11 = _loc_12;
                _loc_11.next = _loc_4.head;
                _loc_4.head = _loc_11;
                _loc_4.modified = true;
                (_loc_4.length + 1);
                _loc_7 = _loc_7.next;
            }
            while (_loc_8 != null)
            {
                
                _loc_9 = _loc_8.elt;
                if (ZNPNode_ZPP_CbSet.zpp_pool == null)
                {
                    _loc_12 = new ZNPNode_ZPP_CbSet();
                }
                else
                {
                    _loc_12 = ZNPNode_ZPP_CbSet.zpp_pool;
                    ZNPNode_ZPP_CbSet.zpp_pool = _loc_12.next;
                    _loc_12.next = null;
                }
                _loc_12.elt = _loc_9;
                _loc_11 = _loc_12;
                _loc_11.next = _loc_5.head;
                _loc_5.head = _loc_11;
                _loc_5.modified = true;
                (_loc_5.length + 1);
                _loc_8 = _loc_8.next;
            }
            while (_loc_4.head != null)
            {
                
                _loc_9 = _loc_4.pop_unsafe();
                _loc_11 = param2.head;
                while (_loc_11 != null)
                {
                    
                    _loc_10 = _loc_11.elt;
                    null.param3(_loc_9, _loc_10);
                    _loc_11 = _loc_11.next;
                }
            }
            while (_loc_5.head != null)
            {
                
                _loc_9 = _loc_5.pop_unsafe();
                _loc_11 = _loc_6.head;
                while (_loc_11 != null)
                {
                    
                    _loc_10 = _loc_11.elt;
                    null.param3(_loc_9, _loc_10);
                    _loc_11 = _loc_11.next;
                }
            }
            while (_loc_6.head != null)
            {
                
                _loc_9 = _loc_6.pop_unsafe();
                null.param3(_loc_9, _loc_9);
                _loc_11 = _loc_6.head;
                while (_loc_11 != null)
                {
                    
                    _loc_10 = _loc_11.elt;
                    null.param3(_loc_9, _loc_10);
                    _loc_11 = _loc_11.next;
                }
            }
            return;
        }// end function

    }
}
