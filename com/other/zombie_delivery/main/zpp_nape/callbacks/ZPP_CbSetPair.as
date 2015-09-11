package zpp_nape.callbacks
{
    import flash.*;
    import zpp_nape.util.*;

    public class ZPP_CbSetPair extends Object
    {
        public var zip_listeners:Boolean;
        public var next:ZPP_CbSetPair;
        public var listeners:ZNPList_ZPP_InteractionListener;
        public var b:ZPP_CbSet;
        public var a:ZPP_CbSet;
        public static var zpp_pool:ZPP_CbSetPair;

        public function ZPP_CbSetPair() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            listeners = null;
            zip_listeners = false;
            next = null;
            b = null;
            a = null;
            listeners = new ZNPList_ZPP_InteractionListener();
            return;
        }// end function

        public function validate() : void
        {
            if (zip_listeners)
            {
                zip_listeners = false;
                __validate();
            }
            return;
        }// end function

        public function single_intersection(param1:ZPP_InteractionListener) : Boolean
        {
            var _loc_2:* = listeners.head;
            if (_loc_2 != null)
            {
            }
            if (_loc_2.elt == param1)
            {
            }
            return _loc_2.next == null;
        }// end function

        public function invalidate() : void
        {
            zip_listeners = true;
            return;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null;
            b = null;
            a = _loc_1;
            listeners.clear();
            return;
        }// end function

        public function forall(param1:int, param2:Function) : void
        {
            var _loc_4:* = null as ZPP_InteractionListener;
            var _loc_3:* = listeners.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                if (_loc_4.event == param1)
                {
                    this.param2(_loc_4);
                }
                _loc_3 = _loc_3.next;
            }
            return;
        }// end function

        public function empty_intersection() : Boolean
        {
            return listeners.head == null;
        }// end function

        public function compatible(param1:ZPP_InteractionListener) : Boolean
        {
            var _loc_2:* = null as ZPP_OptionType;
            var _loc_3:* = null as ZNPList_ZPP_CbType;
            _loc_2 = param1.options1;
            _loc_3 = a.cbTypes;
            if (_loc_2.nonemptyintersection(_loc_3, _loc_2.includes))
            {
            }
            if (!_loc_2.nonemptyintersection(_loc_3, _loc_2.excludes))
            {
                _loc_2 = param1.options2;
                _loc_3 = b.cbTypes;
                if (_loc_2.nonemptyintersection(_loc_3, _loc_2.includes))
                {
                }
            }
            if (_loc_2.nonemptyintersection(_loc_3, _loc_2.excludes))
            {
                _loc_2 = param1.options2;
                _loc_3 = a.cbTypes;
                if (_loc_2.nonemptyintersection(_loc_3, _loc_2.includes))
                {
                }
                if (!_loc_2.nonemptyintersection(_loc_3, _loc_2.excludes))
                {
                    _loc_2 = param1.options1;
                    _loc_3 = b.cbTypes;
                    if (_loc_2.nonemptyintersection(_loc_3, _loc_2.includes))
                    {
                    }
                }
            }
            return !_loc_2.nonemptyintersection(_loc_3, _loc_2.excludes);
        }// end function

        public function alloc() : void
        {
            zip_listeners = true;
            return;
        }// end function

        public function __validate() : void
        {
            var _loc_3:* = null as ZPP_InteractionListener;
            var _loc_4:* = null as ZPP_InteractionListener;
            var _loc_5:* = null as ZPP_OptionType;
            var _loc_6:* = null as ZNPList_ZPP_CbType;
            listeners.clear();
            var _loc_1:* = a.listeners.head;
            var _loc_2:* = b.listeners.head;
            do
            {
                
                _loc_3 = _loc_1.elt;
                _loc_4 = _loc_2.elt;
                if (_loc_3 == _loc_4)
                {
                    _loc_5 = _loc_3.options1;
                    _loc_6 = a.cbTypes;
                    if (_loc_5.nonemptyintersection(_loc_6, _loc_5.includes))
                    {
                    }
                    if (!_loc_5.nonemptyintersection(_loc_6, _loc_5.excludes))
                    {
                        _loc_5 = _loc_3.options2;
                        _loc_6 = b.cbTypes;
                        if (_loc_5.nonemptyintersection(_loc_6, _loc_5.includes))
                        {
                        }
                    }
                    if (_loc_5.nonemptyintersection(_loc_6, _loc_5.excludes))
                    {
                        _loc_5 = _loc_3.options2;
                        _loc_6 = a.cbTypes;
                        if (_loc_5.nonemptyintersection(_loc_6, _loc_5.includes))
                        {
                        }
                        if (!_loc_5.nonemptyintersection(_loc_6, _loc_5.excludes))
                        {
                            _loc_5 = _loc_3.options1;
                            _loc_6 = b.cbTypes;
                            if (_loc_5.nonemptyintersection(_loc_6, _loc_5.includes))
                            {
                            }
                        }
                    }
                    if (!_loc_5.nonemptyintersection(_loc_6, _loc_5.excludes))
                    {
                        listeners.add(_loc_3);
                    }
                    _loc_1 = _loc_1.next;
                    _loc_2 = _loc_2.next;
                }
                else
                {
                    if (_loc_3.precedence <= _loc_4.precedence)
                    {
                        if (_loc_3.precedence == _loc_4.precedence)
                        {
                        }
                    }
                    if (_loc_3.id > _loc_4.id)
                    {
                        _loc_1 = _loc_1.next;
                    }
                    else
                    {
                        _loc_2 = _loc_2.next;
                    }
                }
                if (_loc_1 != null)
                {
                }
            }while (_loc_2 != null)
            return;
        }// end function

        public static function get(param1:ZPP_CbSet, param2:ZPP_CbSet) : ZPP_CbSetPair
        {
            var _loc_3:* = null as ZPP_CbSetPair;
            if (ZPP_CbSetPair.zpp_pool == null)
            {
                _loc_3 = new ZPP_CbSetPair();
            }
            else
            {
                _loc_3 = ZPP_CbSetPair.zpp_pool;
                ZPP_CbSetPair.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.zip_listeners = true;
            if (ZPP_CbSet.setlt(param1, param2))
            {
                _loc_3.a = param1;
                _loc_3.b = param2;
            }
            else
            {
                _loc_3.a = param2;
                _loc_3.b = param1;
            }
            return _loc_3;
        }// end function

        public static function setlt(param1:ZPP_CbSetPair, param2:ZPP_CbSetPair) : Boolean
        {
            if (!ZPP_CbSet.setlt(param1.a, param2.a))
            {
                if (param1.a == param2.a)
                {
                }
            }
            return ZPP_CbSet.setlt(param1.b, param2.b);
        }// end function

    }
}
