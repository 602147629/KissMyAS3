package zpp_nape.callbacks
{
    import __AS3__.vec.*;
    import flash.*;
    import nape.callbacks.*;
    import zpp_nape.*;
    import zpp_nape.util.*;

    public class ZPP_OptionType extends Object
    {
        public var wrap_includes:CbTypeList;
        public var wrap_excludes:CbTypeList;
        public var outer:OptionType;
        public var includes:ZNPList_ZPP_CbType;
        public var handler:Object;
        public var excludes:ZNPList_ZPP_CbType;

        public function ZPP_OptionType() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            wrap_excludes = null;
            wrap_includes = null;
            excludes = null;
            includes = null;
            handler = null;
            outer = null;
            includes = new ZNPList_ZPP_CbType();
            excludes = new ZNPList_ZPP_CbType();
            return;
        }// end function

        public function setup_includes() : void
        {
            wrap_includes = ZPP_CbTypeList.get(includes, true);
            return;
        }// end function

        public function setup_excludes() : void
        {
            wrap_excludes = ZPP_CbTypeList.get(excludes, true);
            return;
        }// end function

        public function set(param1:ZPP_OptionType) : ZPP_OptionType
        {
            var _loc_2:* = null as ZNPNode_ZPP_CbType;
            var _loc_3:* = null as ZPP_CbType;
            if (param1 != this)
            {
                while (includes.head != null)
                {
                    
                    append_type(excludes, includes.head.elt);
                }
                while (excludes.head != null)
                {
                    
                    append_type(includes, excludes.head.elt);
                }
                _loc_2 = param1.excludes.head;
                while (_loc_2 != null)
                {
                    
                    _loc_3 = _loc_2.elt;
                    append_type(excludes, _loc_3);
                    _loc_2 = _loc_2.next;
                }
                _loc_2 = param1.includes.head;
                while (_loc_2 != null)
                {
                    
                    _loc_3 = _loc_2.elt;
                    append_type(includes, _loc_3);
                    _loc_2 = _loc_2.next;
                }
            }
            return this;
        }// end function

        public function nonemptyintersection(param1:ZNPList_ZPP_CbType, param2:ZNPList_ZPP_CbType) : Boolean
        {
            var _loc_6:* = null as ZPP_CbType;
            var _loc_7:* = null as ZPP_CbType;
            var _loc_3:* = false;
            var _loc_4:* = param1.head;
            var _loc_5:* = param2.head;
            do
            {
                
                _loc_6 = _loc_5.elt;
                _loc_7 = _loc_4.elt;
                if (_loc_6 == _loc_7)
                {
                    _loc_3 = true;
                    break;
                }
                else if (_loc_6.id < _loc_7.id)
                {
                    _loc_5 = _loc_5.next;
                }
                else
                {
                    _loc_4 = _loc_4.next;
                }
                if (_loc_5 != null)
                {
                }
            }while (_loc_4 != null)
            return _loc_3;
        }// end function

        public function included(param1:ZNPList_ZPP_CbType) : Boolean
        {
            return nonemptyintersection(param1, includes);
        }// end function

        public function excluded(param1:ZNPList_ZPP_CbType) : Boolean
        {
            return nonemptyintersection(param1, excludes);
        }// end function

        public function effect_change(param1:ZPP_CbType, param2:Boolean, param3:Boolean) : void
        {
            var _loc_4:* = null as ZNPNode_ZPP_CbType;
            var _loc_5:* = null as ZNPNode_ZPP_CbType;
            var _loc_6:* = null as ZPP_CbType;
            var _loc_7:* = null as ZNPList_ZPP_CbType;
            var _loc_8:* = null as ZNPNode_ZPP_CbType;
            var _loc_9:* = false;
            if (param2)
            {
                if (param3)
                {
                    _loc_4 = null;
                    _loc_5 = includes.head;
                    while (_loc_5 != null)
                    {
                        
                        _loc_6 = _loc_5.elt;
                        if (param1.id < _loc_6.id)
                        {
                            break;
                        }
                        _loc_4 = _loc_5;
                        _loc_5 = _loc_5.next;
                    }
                    _loc_7 = includes;
                    if (ZNPNode_ZPP_CbType.zpp_pool == null)
                    {
                        _loc_8 = new ZNPNode_ZPP_CbType();
                    }
                    else
                    {
                        _loc_8 = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc_8.next;
                        _loc_8.next = null;
                    }
                    _loc_8.elt = param1;
                    _loc_5 = _loc_8;
                    if (_loc_4 == null)
                    {
                        _loc_5.next = _loc_7.head;
                        _loc_7.head = _loc_5;
                    }
                    else
                    {
                        _loc_5.next = _loc_4.next;
                        _loc_4.next = _loc_5;
                    }
                    _loc_9 = true;
                    _loc_7.modified = _loc_9;
                    _loc_7.pushmod = _loc_9;
                    (_loc_7.length + 1);
                }
                else
                {
                    includes.remove(param1);
                }
            }
            else if (param3)
            {
                _loc_4 = null;
                _loc_5 = excludes.head;
                while (_loc_5 != null)
                {
                    
                    _loc_6 = _loc_5.elt;
                    if (param1.id < _loc_6.id)
                    {
                        break;
                    }
                    _loc_4 = _loc_5;
                    _loc_5 = _loc_5.next;
                }
                _loc_7 = excludes;
                if (ZNPNode_ZPP_CbType.zpp_pool == null)
                {
                    _loc_8 = new ZNPNode_ZPP_CbType();
                }
                else
                {
                    _loc_8 = ZNPNode_ZPP_CbType.zpp_pool;
                    ZNPNode_ZPP_CbType.zpp_pool = _loc_8.next;
                    _loc_8.next = null;
                }
                _loc_8.elt = param1;
                _loc_5 = _loc_8;
                if (_loc_4 == null)
                {
                    _loc_5.next = _loc_7.head;
                    _loc_7.head = _loc_5;
                }
                else
                {
                    _loc_5.next = _loc_4.next;
                    _loc_4.next = _loc_5;
                }
                _loc_9 = true;
                _loc_7.modified = _loc_9;
                _loc_7.pushmod = _loc_9;
                (_loc_7.length + 1);
            }
            else
            {
                excludes.remove(param1);
            }
            return;
        }// end function

        public function compatible(param1:ZNPList_ZPP_CbType) : Boolean
        {
            if (nonemptyintersection(param1, includes))
            {
            }
            return !nonemptyintersection(param1, excludes);
        }// end function

        public function append_type(param1:ZNPList_ZPP_CbType, param2:ZPP_CbType) : void
        {
            var _loc_3:* = null as ZNPNode_ZPP_CbType;
            var _loc_4:* = null as ZNPNode_ZPP_CbType;
            var _loc_5:* = null as ZPP_CbType;
            var _loc_6:* = null as ZNPList_ZPP_CbType;
            var _loc_7:* = null as ZNPNode_ZPP_CbType;
            var _loc_8:* = false;
            if (param1 == includes)
            {
                if (!includes.has(param2))
                {
                    if (!excludes.has(param2))
                    {
                        if (handler != null)
                        {
                            handler(param2, true, true);
                        }
                        else
                        {
                            _loc_3 = null;
                            _loc_4 = includes.head;
                            while (_loc_4 != null)
                            {
                                
                                _loc_5 = _loc_4.elt;
                                if (param2.id < _loc_5.id)
                                {
                                    break;
                                }
                                _loc_3 = _loc_4;
                                _loc_4 = _loc_4.next;
                            }
                            _loc_6 = includes;
                            if (ZNPNode_ZPP_CbType.zpp_pool == null)
                            {
                                _loc_7 = new ZNPNode_ZPP_CbType();
                            }
                            else
                            {
                                _loc_7 = ZNPNode_ZPP_CbType.zpp_pool;
                                ZNPNode_ZPP_CbType.zpp_pool = _loc_7.next;
                                _loc_7.next = null;
                            }
                            _loc_7.elt = param2;
                            _loc_4 = _loc_7;
                            if (_loc_3 == null)
                            {
                                _loc_4.next = _loc_6.head;
                                _loc_6.head = _loc_4;
                            }
                            else
                            {
                                _loc_4.next = _loc_3.next;
                                _loc_3.next = _loc_4;
                            }
                            _loc_8 = true;
                            _loc_6.modified = _loc_8;
                            _loc_6.pushmod = _loc_8;
                            (_loc_6.length + 1);
                        }
                    }
                    else if (handler != null)
                    {
                        handler(param2, false, false);
                    }
                    else
                    {
                        excludes.remove(param2);
                    }
                }
            }
            else if (!excludes.has(param2))
            {
                if (!includes.has(param2))
                {
                    if (handler != null)
                    {
                        handler(param2, false, true);
                    }
                    else
                    {
                        _loc_3 = null;
                        _loc_4 = excludes.head;
                        while (_loc_4 != null)
                        {
                            
                            _loc_5 = _loc_4.elt;
                            if (param2.id < _loc_5.id)
                            {
                                break;
                            }
                            _loc_3 = _loc_4;
                            _loc_4 = _loc_4.next;
                        }
                        _loc_6 = excludes;
                        if (ZNPNode_ZPP_CbType.zpp_pool == null)
                        {
                            _loc_7 = new ZNPNode_ZPP_CbType();
                        }
                        else
                        {
                            _loc_7 = ZNPNode_ZPP_CbType.zpp_pool;
                            ZNPNode_ZPP_CbType.zpp_pool = _loc_7.next;
                            _loc_7.next = null;
                        }
                        _loc_7.elt = param2;
                        _loc_4 = _loc_7;
                        if (_loc_3 == null)
                        {
                            _loc_4.next = _loc_6.head;
                            _loc_6.head = _loc_4;
                        }
                        else
                        {
                            _loc_4.next = _loc_3.next;
                            _loc_3.next = _loc_4;
                        }
                        _loc_8 = true;
                        _loc_6.modified = _loc_8;
                        _loc_6.pushmod = _loc_8;
                        (_loc_6.length + 1);
                    }
                }
                else if (handler != null)
                {
                    handler(param2, true, false);
                }
                else
                {
                    includes.remove(param2);
                }
            }
            return;
        }// end function

        public function append(param1:ZNPList_ZPP_CbType, param2) : void
        {
            var _loc_3:* = null as CbType;
            var _loc_4:* = null as CbTypeList;
            var _loc_5:* = null as CbTypeIterator;
            var _loc_6:* = 0;
            var _loc_7:* = null as CbTypeList;
            var _loc_8:* = null as Vector.<CbType>;
            var _loc_9:* = null as Array;
            var _loc_10:* = null;
            if (param2 == null)
            {
                throw "Error: Cannot append null, only CbType and CbType list values";
            }
            if (param2 is CbType)
            {
                _loc_3 = param2;
                append_type(param1, _loc_3.zpp_inner);
            }
            else if (param2 is CbTypeList)
            {
                _loc_4 = param2;
                _loc_4.zpp_inner.valmod();
                _loc_5 = CbTypeIterator.get(_loc_4);
                do
                {
                    
                    _loc_5.zpp_critical = false;
                    _loc_6 = _loc_5.zpp_i;
                    (_loc_5.zpp_i + 1);
                    _loc_3 = _loc_5.zpp_inner.at(_loc_6);
                    append_type(param1, _loc_3.zpp_inner);
                    _loc_5.zpp_inner.zpp_inner.valmod();
                    _loc_7 = _loc_5.zpp_inner;
                    _loc_7.zpp_inner.valmod();
                    if (_loc_7.zpp_inner.zip_length)
                    {
                        _loc_7.zpp_inner.zip_length = false;
                        _loc_7.zpp_inner.user_length = _loc_7.zpp_inner.inner.length;
                    }
                    _loc_6 = _loc_7.zpp_inner.user_length;
                    _loc_5.zpp_critical = true;
                }while (_loc_5.zpp_i < _loc_6 ? (true) : (_loc_5.zpp_next = CbTypeIterator.zpp_pool, CbTypeIterator.zpp_pool = _loc_5, _loc_5.zpp_inner = null, false))
            }
            else if (param2 is ZPP_Const.cbtypevector)
            {
                _loc_8 = param2;
                _loc_6 = 0;
                while (_loc_6 < _loc_8.length)
                {
                    
                    _loc_3 = _loc_8[_loc_6];
                    _loc_6++;
                    append_type(param1, _loc_3.zpp_inner);
                }
            }
            else if (param2 is Array)
            {
                _loc_9 = param2;
                _loc_6 = 0;
                while (_loc_6 < _loc_9.length)
                {
                    
                    _loc_10 = _loc_9[_loc_6];
                    _loc_6++;
                    if (!(_loc_10 is CbType))
                    {
                        throw "Error: Cannot append non-CbType or CbType list value";
                    }
                    _loc_3 = _loc_10;
                    append_type(param1, _loc_3.zpp_inner);
                }
            }
            else
            {
                throw "Error: Cannot append non-CbType or CbType list value";
            }
            return;
        }// end function

        public static function argument(param1) : OptionType
        {
            if (param1 == null)
            {
                return new OptionType();
            }
            else if (param1 is OptionType)
            {
                return param1;
            }
            else
            {
                return new OptionType().including(param1);
            }
        }// end function

    }
}
