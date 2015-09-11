package zpp_nape.callbacks
{
    import flash.*;
    import nape.constraint.*;
    import nape.phys.*;
    import zpp_nape.*;
    import zpp_nape.constraint.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_CbSet extends Object
    {
        public var zip_listeners:Boolean;
        public var zip_conlisteners:Boolean;
        public var zip_bodylisteners:Boolean;
        public var wrap_interactors:InteractorList;
        public var wrap_constraints:ConstraintList;
        public var next:ZPP_CbSet;
        public var manager:ZPP_CbSetManager;
        public var listeners:ZNPList_ZPP_InteractionListener;
        public var interactors:ZNPList_ZPP_Interactor;
        public var id:int;
        public var count:int;
        public var constraints:ZNPList_ZPP_Constraint;
        public var conlisteners:ZNPList_ZPP_ConstraintListener;
        public var cbpairs:ZNPList_ZPP_CbSetPair;
        public var cbTypes:ZNPList_ZPP_CbType;
        public var bodylisteners:ZNPList_ZPP_BodyListener;
        public static var zpp_pool:ZPP_CbSet;

        public function ZPP_CbSet() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            wrap_constraints = null;
            constraints = null;
            wrap_interactors = null;
            interactors = null;
            zip_conlisteners = false;
            conlisteners = null;
            zip_bodylisteners = false;
            bodylisteners = null;
            zip_listeners = false;
            listeners = null;
            cbpairs = null;
            manager = null;
            id = 0;
            next = null;
            count = 0;
            cbTypes = null;
            cbTypes = new ZNPList_ZPP_CbType();
            listeners = new ZNPList_ZPP_InteractionListener();
            zip_listeners = true;
            bodylisteners = new ZNPList_ZPP_BodyListener();
            zip_bodylisteners = true;
            conlisteners = new ZNPList_ZPP_ConstraintListener();
            zip_conlisteners = true;
            constraints = new ZNPList_ZPP_Constraint();
            interactors = new ZNPList_ZPP_Interactor();
            id = ZPP_ID.CbSet();
            cbpairs = new ZNPList_ZPP_CbSetPair();
            return;
        }// end function

        public function validate_listeners() : void
        {
            if (zip_listeners)
            {
                zip_listeners = false;
                realvalidate_listeners();
            }
            return;
        }// end function

        public function validate_conlisteners() : void
        {
            if (zip_conlisteners)
            {
                zip_conlisteners = false;
                realvalidate_conlisteners();
            }
            return;
        }// end function

        public function validate_bodylisteners() : void
        {
            if (zip_bodylisteners)
            {
                zip_bodylisteners = false;
                realvalidate_bodylisteners();
            }
            return;
        }// end function

        public function validate() : void
        {
            if (zip_listeners)
            {
                zip_listeners = false;
                realvalidate_listeners();
            }
            if (zip_bodylisteners)
            {
                zip_bodylisteners = false;
                realvalidate_bodylisteners();
            }
            if (zip_conlisteners)
            {
                zip_conlisteners = false;
                realvalidate_conlisteners();
            }
            return;
        }// end function

        public function remInteractor(param1:ZPP_Interactor) : void
        {
            interactors.remove(param1);
            return;
        }// end function

        public function remConstraint(param1:ZPP_Constraint) : void
        {
            constraints.remove(param1);
            return;
        }// end function

        public function realvalidate_listeners() : void
        {
            var _loc_2:* = null as ZPP_CbType;
            var _loc_3:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_4:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_5:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_6:* = null as ZPP_InteractionListener;
            var _loc_7:* = null as ZPP_Listener;
            var _loc_8:* = null as ZNPList_ZPP_InteractionListener;
            var _loc_9:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_10:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_11:* = false;
            listeners.clear();
            var _loc_1:* = cbTypes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_3 = null;
                _loc_4 = listeners.head;
                _loc_5 = _loc_2.listeners.head;
                while (_loc_5 != null)
                {
                    
                    _loc_6 = _loc_5.elt;
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.elt == _loc_6)
                    {
                        _loc_5 = _loc_5.next;
                        _loc_3 = _loc_4;
                        _loc_4 = _loc_4.next;
                        continue;
                    }
                    if (_loc_4 != null)
                    {
                        _loc_7 = _loc_4.elt;
                        if (_loc_6.precedence <= _loc_7.precedence)
                        {
                            if (_loc_6.precedence == _loc_7.precedence)
                            {
                            }
                        }
                    }
                    if (_loc_6.id > _loc_7.id)
                    {
                        if (_loc_6.space == manager.space)
                        {
                            _loc_8 = listeners;
                            if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                            {
                                _loc_10 = new ZNPNode_ZPP_InteractionListener();
                            }
                            else
                            {
                                _loc_10 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_10.next;
                                _loc_10.next = null;
                            }
                            _loc_10.elt = _loc_6;
                            _loc_9 = _loc_10;
                            if (_loc_3 == null)
                            {
                                _loc_9.next = _loc_8.head;
                                _loc_8.head = _loc_9;
                            }
                            else
                            {
                                _loc_9.next = _loc_3.next;
                                _loc_3.next = _loc_9;
                            }
                            _loc_11 = true;
                            _loc_8.modified = _loc_11;
                            _loc_8.pushmod = _loc_11;
                            (_loc_8.length + 1);
                            _loc_3 = _loc_9;
                        }
                        _loc_5 = _loc_5.next;
                        continue;
                    }
                    _loc_3 = _loc_4;
                    _loc_4 = _loc_4.next;
                }
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function realvalidate_conlisteners() : void
        {
            var _loc_2:* = null as ZPP_CbType;
            var _loc_3:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_4:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_5:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_6:* = null as ZPP_ConstraintListener;
            var _loc_7:* = null as ZPP_Listener;
            var _loc_8:* = null as ZPP_OptionType;
            var _loc_9:* = null as ZNPList_ZPP_ConstraintListener;
            var _loc_10:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_11:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_12:* = false;
            conlisteners.clear();
            var _loc_1:* = cbTypes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_3 = null;
                _loc_4 = conlisteners.head;
                _loc_5 = _loc_2.conlisteners.head;
                while (_loc_5 != null)
                {
                    
                    _loc_6 = _loc_5.elt;
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.elt == _loc_6)
                    {
                        _loc_5 = _loc_5.next;
                        _loc_3 = _loc_4;
                        _loc_4 = _loc_4.next;
                        continue;
                    }
                    if (_loc_4 != null)
                    {
                        _loc_7 = _loc_4.elt;
                        if (_loc_6.precedence <= _loc_7.precedence)
                        {
                            if (_loc_6.precedence == _loc_7.precedence)
                            {
                            }
                        }
                    }
                    if (_loc_6.id > _loc_7.id)
                    {
                        _loc_8 = _loc_6.options;
                        if (!_loc_8.nonemptyintersection(cbTypes, _loc_8.excludes))
                        {
                        }
                        if (_loc_6.space == manager.space)
                        {
                            _loc_9 = conlisteners;
                            if (ZNPNode_ZPP_ConstraintListener.zpp_pool == null)
                            {
                                _loc_11 = new ZNPNode_ZPP_ConstraintListener();
                            }
                            else
                            {
                                _loc_11 = ZNPNode_ZPP_ConstraintListener.zpp_pool;
                                ZNPNode_ZPP_ConstraintListener.zpp_pool = _loc_11.next;
                                _loc_11.next = null;
                            }
                            _loc_11.elt = _loc_6;
                            _loc_10 = _loc_11;
                            if (_loc_3 == null)
                            {
                                _loc_10.next = _loc_9.head;
                                _loc_9.head = _loc_10;
                            }
                            else
                            {
                                _loc_10.next = _loc_3.next;
                                _loc_3.next = _loc_10;
                            }
                            _loc_12 = true;
                            _loc_9.modified = _loc_12;
                            _loc_9.pushmod = _loc_12;
                            (_loc_9.length + 1);
                            _loc_3 = _loc_10;
                        }
                        _loc_5 = _loc_5.next;
                        continue;
                    }
                    _loc_3 = _loc_4;
                    _loc_4 = _loc_4.next;
                }
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function realvalidate_bodylisteners() : void
        {
            var _loc_2:* = null as ZPP_CbType;
            var _loc_3:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_4:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_5:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_6:* = null as ZPP_BodyListener;
            var _loc_7:* = null as ZPP_Listener;
            var _loc_8:* = null as ZPP_OptionType;
            var _loc_9:* = null as ZNPList_ZPP_BodyListener;
            var _loc_10:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_11:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_12:* = false;
            bodylisteners.clear();
            var _loc_1:* = cbTypes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_3 = null;
                _loc_4 = bodylisteners.head;
                _loc_5 = _loc_2.bodylisteners.head;
                while (_loc_5 != null)
                {
                    
                    _loc_6 = _loc_5.elt;
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.elt == _loc_6)
                    {
                        _loc_5 = _loc_5.next;
                        _loc_3 = _loc_4;
                        _loc_4 = _loc_4.next;
                        continue;
                    }
                    if (_loc_4 != null)
                    {
                        _loc_7 = _loc_4.elt;
                        if (_loc_6.precedence <= _loc_7.precedence)
                        {
                            if (_loc_6.precedence == _loc_7.precedence)
                            {
                            }
                        }
                    }
                    if (_loc_6.id > _loc_7.id)
                    {
                        _loc_8 = _loc_6.options;
                        if (!_loc_8.nonemptyintersection(cbTypes, _loc_8.excludes))
                        {
                        }
                        if (_loc_6.space == manager.space)
                        {
                            _loc_9 = bodylisteners;
                            if (ZNPNode_ZPP_BodyListener.zpp_pool == null)
                            {
                                _loc_11 = new ZNPNode_ZPP_BodyListener();
                            }
                            else
                            {
                                _loc_11 = ZNPNode_ZPP_BodyListener.zpp_pool;
                                ZNPNode_ZPP_BodyListener.zpp_pool = _loc_11.next;
                                _loc_11.next = null;
                            }
                            _loc_11.elt = _loc_6;
                            _loc_10 = _loc_11;
                            if (_loc_3 == null)
                            {
                                _loc_10.next = _loc_9.head;
                                _loc_9.head = _loc_10;
                            }
                            else
                            {
                                _loc_10.next = _loc_3.next;
                                _loc_3.next = _loc_10;
                            }
                            _loc_12 = true;
                            _loc_9.modified = _loc_12;
                            _loc_9.pushmod = _loc_12;
                            (_loc_9.length + 1);
                            _loc_3 = _loc_10;
                        }
                        _loc_5 = _loc_5.next;
                        continue;
                    }
                    _loc_3 = _loc_4;
                    _loc_4 = _loc_4.next;
                }
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function invalidate_pairs() : void
        {
            var _loc_2:* = null as ZPP_CbSetPair;
            var _loc_1:* = cbpairs.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.zip_listeners = true;
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function invalidate_listeners() : void
        {
            zip_listeners = true;
            invalidate_pairs();
            return;
        }// end function

        public function invalidate_conlisteners() : void
        {
            zip_conlisteners = true;
            return;
        }// end function

        public function invalidate_bodylisteners() : void
        {
            zip_bodylisteners = true;
            return;
        }// end function

        public function increment() : void
        {
            (count + 1);
            return;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null as ZPP_CbType;
            listeners.clear();
            zip_listeners = true;
            bodylisteners.clear();
            zip_bodylisteners = true;
            conlisteners.clear();
            zip_conlisteners = true;
            while (cbTypes.head != null)
            {
                
                _loc_1 = cbTypes.pop_unsafe();
                _loc_1.cbsets.remove(this);
            }
            return;
        }// end function

        public function decrement() : Boolean
        {
            --count;
            return --count == 0;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public function addInteractor(param1:ZPP_Interactor) : void
        {
            interactors.add(param1);
            return;
        }// end function

        public function addConstraint(param1:ZPP_Constraint) : void
        {
            constraints.add(param1);
            return;
        }// end function

        public static function setlt(param1:ZPP_CbSet, param2:ZPP_CbSet) : Boolean
        {
            var _loc_5:* = null as ZPP_CbType;
            var _loc_6:* = null as ZPP_CbType;
            var _loc_3:* = param1.cbTypes.head;
            var _loc_4:* = param2.cbTypes.head;
            do
            {
                
                _loc_5 = _loc_3.elt;
                _loc_6 = _loc_4.elt;
                if (_loc_5.id < _loc_6.id)
                {
                    return true;
                }
                if (_loc_6.id < _loc_5.id)
                {
                    return false;
                }
                else
                {
                    _loc_3 = _loc_3.next;
                    _loc_4 = _loc_4.next;
                }
                if (_loc_3 != null)
                {
                }
            }while (_loc_4 != null)
            if (_loc_4 != null)
            {
            }
            return _loc_3 == null;
        }// end function

        public static function get(param1:ZNPList_ZPP_CbType) : ZPP_CbSet
        {
            var _loc_2:* = null as ZPP_CbSet;
            var _loc_5:* = null as ZPP_CbType;
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
            var _loc_3:* = null;
            var _loc_4:* = param1.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                _loc_3 = _loc_2.cbTypes.insert(_loc_3, _loc_5);
                _loc_5.cbsets.add(_loc_2);
                _loc_4 = _loc_4.next;
            }
            return _loc_2;
        }// end function

        public static function compatible(param1:ZPP_InteractionListener, param2:ZPP_CbSet, param3:ZPP_CbSet) : Boolean
        {
            var _loc_4:* = null as ZPP_OptionType;
            var _loc_5:* = null as ZNPList_ZPP_CbType;
            _loc_4 = param1.options1;
            _loc_5 = param2.cbTypes;
            if (_loc_4.nonemptyintersection(_loc_5, _loc_4.includes))
            {
            }
            if (!_loc_4.nonemptyintersection(_loc_5, _loc_4.excludes))
            {
                _loc_4 = param1.options2;
                _loc_5 = param3.cbTypes;
                if (_loc_4.nonemptyintersection(_loc_5, _loc_4.includes))
                {
                }
            }
            if (_loc_4.nonemptyintersection(_loc_5, _loc_4.excludes))
            {
                _loc_4 = param1.options2;
                _loc_5 = param2.cbTypes;
                if (_loc_4.nonemptyintersection(_loc_5, _loc_4.includes))
                {
                }
                if (!_loc_4.nonemptyintersection(_loc_5, _loc_4.excludes))
                {
                    _loc_4 = param1.options1;
                    _loc_5 = param3.cbTypes;
                    if (_loc_4.nonemptyintersection(_loc_5, _loc_4.includes))
                    {
                    }
                }
            }
            return !_loc_4.nonemptyintersection(_loc_5, _loc_4.excludes);
        }// end function

        public static function empty_intersection(param1:ZPP_CbSet, param2:ZPP_CbSet) : Boolean
        {
            var _loc_5:* = null as ZNPList_ZPP_CbSetPair;
            var _loc_7:* = null as ZPP_CbSetPair;
            var _loc_4:* = null;
            if (param1.cbpairs.length < param2.cbpairs.length)
            {
                _loc_5 = param1.cbpairs;
            }
            else
            {
                _loc_5 = param2.cbpairs;
            }
            var _loc_6:* = _loc_5.head;
            while (_loc_6 != null)
            {
                
                _loc_7 = _loc_6.elt;
                if (_loc_7.a == param1)
                {
                }
                if (_loc_7.b != param2)
                {
                    if (_loc_7.a == param2)
                    {
                    }
                }
                if (_loc_7.b == param1)
                {
                    _loc_4 = _loc_7;
                    break;
                }
                _loc_6 = _loc_6.next;
            }
            if (_loc_4 == null)
            {
                if (ZPP_CbSetPair.zpp_pool == null)
                {
                    _loc_7 = new ZPP_CbSetPair();
                }
                else
                {
                    _loc_7 = ZPP_CbSetPair.zpp_pool;
                    ZPP_CbSetPair.zpp_pool = _loc_7.next;
                    _loc_7.next = null;
                }
                _loc_7.zip_listeners = true;
                if (ZPP_CbSet.setlt(param1, param2))
                {
                    _loc_7.a = param1;
                    _loc_7.b = param2;
                }
                else
                {
                    _loc_7.a = param2;
                    _loc_7.b = param1;
                }
                _loc_4 = _loc_7;
                param1.cbpairs.add(_loc_4);
                if (param2 != param1)
                {
                    param2.cbpairs.add(_loc_4);
                }
            }
            if (_loc_4.zip_listeners)
            {
                _loc_4.zip_listeners = false;
                _loc_4.__validate();
            }
            var _loc_3:* = _loc_4;
            return _loc_3.listeners.head == null;
        }// end function

        public static function single_intersection(param1:ZPP_CbSet, param2:ZPP_CbSet, param3:ZPP_InteractionListener) : Boolean
        {
            var _loc_6:* = null as ZNPList_ZPP_CbSetPair;
            var _loc_8:* = null as ZPP_CbSetPair;
            var _loc_5:* = null;
            if (param1.cbpairs.length < param2.cbpairs.length)
            {
                _loc_6 = param1.cbpairs;
            }
            else
            {
                _loc_6 = param2.cbpairs;
            }
            var _loc_7:* = _loc_6.head;
            while (_loc_7 != null)
            {
                
                _loc_8 = _loc_7.elt;
                if (_loc_8.a == param1)
                {
                }
                if (_loc_8.b != param2)
                {
                    if (_loc_8.a == param2)
                    {
                    }
                }
                if (_loc_8.b == param1)
                {
                    _loc_5 = _loc_8;
                    break;
                }
                _loc_7 = _loc_7.next;
            }
            if (_loc_5 == null)
            {
                if (ZPP_CbSetPair.zpp_pool == null)
                {
                    _loc_8 = new ZPP_CbSetPair();
                }
                else
                {
                    _loc_8 = ZPP_CbSetPair.zpp_pool;
                    ZPP_CbSetPair.zpp_pool = _loc_8.next;
                    _loc_8.next = null;
                }
                _loc_8.zip_listeners = true;
                if (ZPP_CbSet.setlt(param1, param2))
                {
                    _loc_8.a = param1;
                    _loc_8.b = param2;
                }
                else
                {
                    _loc_8.a = param2;
                    _loc_8.b = param1;
                }
                _loc_5 = _loc_8;
                param1.cbpairs.add(_loc_5);
                if (param2 != param1)
                {
                    param2.cbpairs.add(_loc_5);
                }
            }
            if (_loc_5.zip_listeners)
            {
                _loc_5.zip_listeners = false;
                _loc_5.__validate();
            }
            var _loc_4:* = _loc_5;
            var _loc_9:* = _loc_4.listeners.head;
            if (_loc_9 != null)
            {
            }
            if (_loc_9.elt == param3)
            {
            }
            return _loc_9.next == null;
        }// end function

        public static function find_all(param1:ZPP_CbSet, param2:ZPP_CbSet, param3:int, param4:Function) : void
        {
            var _loc_7:* = null as ZNPList_ZPP_CbSetPair;
            var _loc_9:* = null as ZPP_CbSetPair;
            var _loc_11:* = null as ZPP_InteractionListener;
            var _loc_6:* = null;
            if (param1.cbpairs.length < param2.cbpairs.length)
            {
                _loc_7 = param1.cbpairs;
            }
            else
            {
                _loc_7 = param2.cbpairs;
            }
            var _loc_8:* = _loc_7.head;
            while (_loc_8 != null)
            {
                
                _loc_9 = _loc_8.elt;
                if (_loc_9.a == param1)
                {
                }
                if (_loc_9.b != param2)
                {
                    if (_loc_9.a == param2)
                    {
                    }
                }
                if (_loc_9.b == param1)
                {
                    _loc_6 = _loc_9;
                    break;
                }
                _loc_8 = _loc_8.next;
            }
            if (_loc_6 == null)
            {
                if (ZPP_CbSetPair.zpp_pool == null)
                {
                    _loc_9 = new ZPP_CbSetPair();
                }
                else
                {
                    _loc_9 = ZPP_CbSetPair.zpp_pool;
                    ZPP_CbSetPair.zpp_pool = _loc_9.next;
                    _loc_9.next = null;
                }
                _loc_9.zip_listeners = true;
                if (ZPP_CbSet.setlt(param1, param2))
                {
                    _loc_9.a = param1;
                    _loc_9.b = param2;
                }
                else
                {
                    _loc_9.a = param2;
                    _loc_9.b = param1;
                }
                _loc_6 = _loc_9;
                param1.cbpairs.add(_loc_6);
                if (param2 != param1)
                {
                    param2.cbpairs.add(_loc_6);
                }
            }
            if (_loc_6.zip_listeners)
            {
                _loc_6.zip_listeners = false;
                _loc_6.__validate();
            }
            var _loc_5:* = _loc_6;
            var _loc_10:* = _loc_5.listeners.head;
            while (_loc_10 != null)
            {
                
                _loc_11 = _loc_10.elt;
                if (_loc_11.event == param3)
                {
                    null.param4(_loc_11);
                }
                _loc_10 = _loc_10.next;
            }
            return;
        }// end function

    }
}
