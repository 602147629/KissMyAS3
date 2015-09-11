package zpp_nape.phys
{
    import flash.*;
    import nape.callbacks.*;
    import nape.phys.*;
    import zpp_nape.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_Interactor extends Object
    {
        public var wrap_cbTypes:CbTypeList;
        public var userData:Object;
        public var outer_i:Interactor;
        public var ishape:ZPP_Shape;
        public var id:int;
        public var icompound:ZPP_Compound;
        public var ibody:ZPP_Body;
        public var group:ZPP_InteractionGroup;
        public var cbsets:ZNPList_ZPP_CallbackSet;
        public var cbTypes:ZNPList_ZPP_CbType;
        public var cbSet:ZPP_CbSet;

        public function ZPP_Interactor() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            wrap_cbTypes = null;
            cbSet = null;
            cbTypes = null;
            group = null;
            cbsets = null;
            icompound = null;
            ibody = null;
            ishape = null;
            userData = null;
            id = 0;
            outer_i = null;
            id = ZPP_ID.Interactor();
            cbsets = new ZNPList_ZPP_CallbackSet();
            cbTypes = new ZNPList_ZPP_CbType();
            return;
        }// end function

        public function wrap_cbTypes_subber(param1:CbType) : void
        {
            var _loc_3:* = null as ZPP_Space;
            var _loc_2:* = param1.zpp_inner;
            if (cbTypes.has(_loc_2))
            {
                if (ishape != null)
                {
                    if (ishape.body == null)
                    {
                        _loc_3 = null;
                    }
                    else
                    {
                        _loc_3 = ishape.body.space;
                    }
                }
                else if (ibody != null)
                {
                    _loc_3 = ibody.space;
                }
                else
                {
                    _loc_3 = icompound.space;
                }
                if (_loc_3 != null)
                {
                    dealloc_cbSet();
                    _loc_2.interactors.remove(this);
                }
                cbTypes.remove(_loc_2);
                if (_loc_3 != null)
                {
                    alloc_cbSet();
                    wake();
                }
            }
            return;
        }// end function

        public function wrap_cbTypes_adder(param1:CbType) : Boolean
        {
            insert_cbtype(param1.zpp_inner);
            return false;
        }// end function

        public function wake() : void
        {
            var _loc_1:* = null as ZPP_Body;
            if (ishape != null)
            {
                _loc_1 = ishape.body;
                if (_loc_1 != null)
                {
                }
                if (_loc_1.space != null)
                {
                    _loc_1.space.non_inlined_wake(_loc_1);
                }
            }
            else if (ibody != null)
            {
                if (ibody.space != null)
                {
                    ibody.space.non_inlined_wake(ibody);
                }
                else
                {
                }
            }
            else
            {
                if (icompound.space != null)
                {
                    icompound.space.wakeCompound(icompound);
                }
            }
            return;
        }// end function

        public function setupcbTypes() : void
        {
            wrap_cbTypes = ZPP_CbTypeList.get(cbTypes);
            wrap_cbTypes.zpp_inner.adder = wrap_cbTypes_adder;
            wrap_cbTypes.zpp_inner.subber = wrap_cbTypes_subber;
            wrap_cbTypes.zpp_inner.dontremove = true;
            wrap_cbTypes.zpp_inner._modifiable = immutable_cbTypes;
            return;
        }// end function

        public function setGroup(param1:ZPP_InteractionGroup) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = 0;
            if (group != param1)
            {
                _loc_2 = (ishape != null ? (ishape.body == null ? (null) : (ishape.body.space)) : (ibody != null ? (ibody.space) : (icompound.space))) != null;
                if (_loc_2)
                {
                }
                if (group != null)
                {
                    _loc_3 = -1;
                    group.interactors.remove(this);
                }
                group = param1;
                if (_loc_2)
                {
                }
                if (param1 != null)
                {
                    param1.interactors.add(this);
                }
                if (_loc_2)
                {
                    if (ishape != null)
                    {
                        ishape.body.wake();
                    }
                    else if (ibody != null)
                    {
                        ibody.wake();
                    }
                    else
                    {
                        icompound.wake();
                    }
                }
            }
            return;
        }// end function

        public function lookup_group() : ZPP_InteractionGroup
        {
            var _loc_1:* = this;
            do
            {
                
                if (_loc_1.ishape != null)
                {
                    _loc_1 = _loc_1.ishape.body;
                }
                else if (_loc_1.icompound != null)
                {
                    _loc_1 = _loc_1.icompound.compound;
                }
                else
                {
                    _loc_1 = _loc_1.ibody.compound;
                }
                if (_loc_1 != null)
                {
                }
            }while (_loc_1.group == null)
            if (_loc_1 == null)
            {
                return null;
            }
            else
            {
                return _loc_1.group;
            }
        }// end function

        public function isShape() : Boolean
        {
            return ishape != null;
        }// end function

        public function isCompound() : Boolean
        {
            return icompound != null;
        }// end function

        public function isBody() : Boolean
        {
            return ibody != null;
        }// end function

        public function insert_cbtype(param1:ZPP_CbType) : void
        {
            var _loc_2:* = null as ZPP_Space;
            var _loc_3:* = null as ZNPNode_ZPP_CbType;
            var _loc_4:* = null as ZNPNode_ZPP_CbType;
            var _loc_5:* = null as ZPP_CbType;
            var _loc_6:* = null as ZNPList_ZPP_CbType;
            var _loc_7:* = null as ZNPNode_ZPP_CbType;
            var _loc_8:* = false;
            if (!cbTypes.has(param1))
            {
                if (ishape != null)
                {
                    if (ishape.body == null)
                    {
                        _loc_2 = null;
                    }
                    else
                    {
                        _loc_2 = ishape.body.space;
                    }
                }
                else if (ibody != null)
                {
                    _loc_2 = ibody.space;
                }
                else
                {
                    _loc_2 = icompound.space;
                }
                if (_loc_2 != null)
                {
                    dealloc_cbSet();
                    param1.interactors.add(this);
                }
                _loc_3 = null;
                _loc_4 = cbTypes.head;
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.elt;
                    if (param1.id < _loc_5.id)
                    {
                        break;
                    }
                    _loc_3 = _loc_4;
                    _loc_4 = _loc_4.next;
                }
                _loc_6 = cbTypes;
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
                _loc_7.elt = param1;
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
                if (_loc_2 != null)
                {
                    alloc_cbSet();
                    wake();
                }
            }
            return;
        }// end function

        public function immutable_midstep(param1:String) : void
        {
            var _loc_2:* = null as ZPP_Body;
            if (ibody != null)
            {
                _loc_2 = ibody;
                if (_loc_2.space != null)
                {
                }
                if (_loc_2.space.midstep)
                {
                    throw "Error: " + param1 + " cannot be set during a space step()";
                }
            }
            else if (ishape != null)
            {
                ishape.__immutable_midstep(param1);
            }
            else
            {
                icompound.__imutable_midstep(param1);
            }
            return;
        }// end function

        public function immutable_cbTypes() : void
        {
            immutable_midstep("Interactor::cbTypes");
            return;
        }// end function

        public function getSpace() : ZPP_Space
        {
            if (ishape != null)
            {
                if (ishape.body == null)
                {
                    return null;
                }
                else
                {
                    return ishape.body.space;
                }
            }
            else if (ibody != null)
            {
                return ibody.space;
            }
            else
            {
                return icompound.space;
            }
        }// end function

        public function dealloc_cbSet() : void
        {
            var _loc_1:* = null as ZPP_Space;
            var _loc_2:* = 0;
            var _loc_3:* = null as ZPP_CbSet;
            var _loc_4:* = null as ZPP_CbType;
            if (ishape != null)
            {
                if (ishape.body == null)
                {
                    _loc_1 = null;
                }
                else
                {
                    _loc_1 = ishape.body.space;
                }
            }
            else if (ibody != null)
            {
                _loc_1 = ibody.space;
            }
            else
            {
                _loc_1 = icompound.space;
            }
            if (cbSet != null)
            {
                cbSet.interactors.remove(this);
                _loc_1.nullInteractorType(this);
                --cbSet.count;
                if (--cbSet.count == 0)
                {
                    _loc_1.cbsets.remove(cbSet);
                    _loc_3 = cbSet;
                    _loc_3.listeners.clear();
                    _loc_3.zip_listeners = true;
                    _loc_3.bodylisteners.clear();
                    _loc_3.zip_bodylisteners = true;
                    _loc_3.conlisteners.clear();
                    _loc_3.zip_conlisteners = true;
                    while (_loc_3.cbTypes.head != null)
                    {
                        
                        _loc_4 = _loc_3.cbTypes.pop_unsafe();
                        _loc_4.cbsets.remove(_loc_3);
                    }
                    _loc_3.next = ZPP_CbSet.zpp_pool;
                    ZPP_CbSet.zpp_pool = _loc_3;
                }
                cbSet = null;
            }
            return;
        }// end function

        public function copyto(param1:Interactor) : void
        {
            var _loc_3:* = null as CbTypeList;
            var _loc_5:* = null as CbType;
            var _loc_6:* = 0;
            param1.zpp_inner_i.group = group;
            var _loc_4:* = outer_i;
            if (_loc_4.zpp_inner_i.wrap_cbTypes == null)
            {
                _loc_4.zpp_inner_i.setupcbTypes();
            }
            _loc_3 = _loc_4.zpp_inner_i.wrap_cbTypes;
            _loc_3.zpp_inner.valmod();
            var _loc_2:* = CbTypeIterator.get(_loc_3);
            do
            {
                
                _loc_2.zpp_critical = false;
                _loc_6 = _loc_2.zpp_i;
                (_loc_2.zpp_i + 1);
                _loc_5 = _loc_2.zpp_inner.at(_loc_6);
                if (param1.zpp_inner_i.wrap_cbTypes == null)
                {
                    param1.zpp_inner_i.setupcbTypes();
                }
                _loc_3 = param1.zpp_inner_i.wrap_cbTypes;
                if (_loc_3.zpp_inner.reverse_flag)
                {
                    _loc_3.push(_loc_5);
                }
                else
                {
                    _loc_3.unshift(_loc_5);
                }
                _loc_2.zpp_inner.zpp_inner.valmod();
                _loc_3 = _loc_2.zpp_inner;
                _loc_3.zpp_inner.valmod();
                if (_loc_3.zpp_inner.zip_length)
                {
                    _loc_3.zpp_inner.zip_length = false;
                    _loc_3.zpp_inner.user_length = _loc_3.zpp_inner.inner.length;
                }
                _loc_6 = _loc_3.zpp_inner.user_length;
                _loc_2.zpp_critical = true;
            }while (_loc_2.zpp_i < _loc_6 ? (true) : (_loc_2.zpp_next = CbTypeIterator.zpp_pool, CbTypeIterator.zpp_pool = _loc_2, _loc_2.zpp_inner = null, false))
            if (userData != null)
            {
                param1.zpp_inner_i.userData = Reflect.copy(userData);
            }
            return;
        }// end function

        public function alloc_cbSet() : void
        {
            var _loc_1:* = null as ZPP_Space;
            if (ishape != null)
            {
                if (ishape.body == null)
                {
                    _loc_1 = null;
                }
                else
                {
                    _loc_1 = ishape.body.space;
                }
            }
            else if (ibody != null)
            {
                _loc_1 = ibody.space;
            }
            else
            {
                _loc_1 = icompound.space;
            }
            var _loc_2:* = _loc_1.cbsets.get(cbTypes);
            cbSet = _loc_1.cbsets.get(cbTypes);
            if (_loc_2 != null)
            {
                (cbSet.count + 1);
                cbSet.interactors.add(this);
                cbSet.validate();
                _loc_1.freshInteractorType(this);
            }
            return;
        }// end function

        public function __iremovedFromSpace() : void
        {
            var _loc_1:* = 0;
            var _loc_3:* = null as ZPP_CbType;
            if (group != null)
            {
                _loc_1 = -1;
                group.interactors.remove(this);
            }
            var _loc_2:* = cbTypes.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_3.interactors.remove(this);
                _loc_2 = _loc_2.next;
            }
            dealloc_cbSet();
            return;
        }// end function

        public function __iaddedToSpace() : void
        {
            var _loc_2:* = null as ZPP_CbType;
            if (group != null)
            {
                group.interactors.add(this);
            }
            var _loc_1:* = cbTypes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.interactors.add(this);
                _loc_1 = _loc_1.next;
            }
            alloc_cbSet();
            return;
        }// end function

        public static function get(param1:ZPP_Interactor, param2:ZPP_Interactor) : ZPP_CallbackSet
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null as ZNPList_ZPP_CallbackSet;
            var _loc_8:* = null as ZPP_CallbackSet;
            if (param1.id < param2.id)
            {
                _loc_3 = param1.id;
            }
            else
            {
                _loc_3 = param2.id;
            }
            if (param1.id < param2.id)
            {
                _loc_4 = param2.id;
            }
            else
            {
                _loc_4 = param1.id;
            }
            if (param1.cbsets.length < param2.cbsets.length)
            {
                _loc_5 = param1.cbsets;
            }
            else
            {
                _loc_5 = param2.cbsets;
            }
            var _loc_6:* = null;
            var _loc_7:* = _loc_5.head;
            while (_loc_7 != null)
            {
                
                _loc_8 = _loc_7.elt;
                if (_loc_8.id == _loc_3)
                {
                }
                if (_loc_8.di == _loc_4)
                {
                    _loc_6 = _loc_8;
                    break;
                }
                _loc_7 = _loc_7.next;
            }
            return _loc_6;
        }// end function

        public static function int_callback(param1:ZPP_CallbackSet, param2:ZPP_InteractionListener, param3:ZPP_Callback) : void
        {
            var _loc_6:* = null as ZPP_OptionType;
            var _loc_7:* = null as ZNPList_ZPP_CbType;
            var _loc_4:* = param1.int1;
            var _loc_5:* = param1.int2;
            _loc_6 = param2.options1;
            _loc_7 = _loc_4.cbTypes;
            if (_loc_6.nonemptyintersection(_loc_7, _loc_6.includes))
            {
            }
            if (!_loc_6.nonemptyintersection(_loc_7, _loc_6.excludes))
            {
                _loc_6 = param2.options2;
                _loc_7 = _loc_5.cbTypes;
                if (_loc_6.nonemptyintersection(_loc_7, _loc_6.includes))
                {
                }
            }
            if (!_loc_6.nonemptyintersection(_loc_7, _loc_6.excludes))
            {
                param3.int1 = _loc_4;
                param3.int2 = _loc_5;
            }
            else
            {
                param3.int1 = _loc_5;
                param3.int2 = _loc_4;
            }
            return;
        }// end function

    }
}
