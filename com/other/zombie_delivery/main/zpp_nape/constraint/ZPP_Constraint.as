package zpp_nape.constraint
{
    import flash.*;
    import nape.callbacks.*;
    import nape.constraint.*;
    import nape.util.*;
    import zpp_nape.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_Constraint extends Object
    {
        public var wrap_cbTypes:CbTypeList;
        public var userData:Object;
        public var stiff:Boolean;
        public var space:ZPP_Space;
        public var removeOnBreak:Boolean;
        public var pre_dt:Number;
        public var outer:Constraint;
        public var maxForce:Number;
        public var maxError:Number;
        public var ignore:Boolean;
        public var id:int;
        public var frequency:Number;
        public var damping:Number;
        public var compound:ZPP_Compound;
        public var component:ZPP_Component;
        public var cbTypes:ZNPList_ZPP_CbType;
        public var cbSet:ZPP_CbSet;
        public var breakUnderForce:Boolean;
        public var breakUnderError:Boolean;
        public var active:Boolean;
        public var __velocity:Boolean;

        public function ZPP_Constraint() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            pre_dt = 0;
            wrap_cbTypes = null;
            cbSet = null;
            cbTypes = null;
            __velocity = false;
            ignore = false;
            component = null;
            removeOnBreak = false;
            breakUnderError = false;
            breakUnderForce = false;
            maxError = 0;
            maxForce = 0;
            damping = 0;
            frequency = 0;
            stiff = false;
            active = false;
            space = null;
            compound = null;
            userData = null;
            id = 0;
            outer = null;
            __velocity = false;
            id = ZPP_ID.Constraint();
            stiff = true;
            active = true;
            ignore = false;
            frequency = 10;
            damping = 1;
            maxForce = 17899999999999994000000000000;
            maxError = 17899999999999994000000000000;
            breakUnderForce = false;
            removeOnBreak = true;
            pre_dt = -1;
            cbTypes = new ZNPList_ZPP_CbType();
            return;
        }// end function

        public function wrap_cbTypes_subber(param1:CbType) : void
        {
            var _loc_2:* = param1.zpp_inner;
            if (cbTypes.has(_loc_2))
            {
                if (space != null)
                {
                    dealloc_cbSet();
                    _loc_2.constraints.remove(this);
                }
                cbTypes.remove(_loc_2);
                if (space != null)
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

        public function warmStart() : void
        {
            return;
        }// end function

        public function wake_connected() : void
        {
            return;
        }// end function

        public function wake() : void
        {
            if (space != null)
            {
                space.wake_constraint(this);
            }
            return;
        }// end function

        public function validate() : void
        {
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

        public function removedFromSpace() : void
        {
            var _loc_2:* = null as ZPP_CbType;
            if (active)
            {
                inactiveOrOutSpace();
            }
            inactiveBodies();
            var _loc_1:* = cbTypes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.constraints.remove(this);
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function preStep(param1:Number) : Boolean
        {
            return false;
        }// end function

        public function pair_exists(param1:int, param2:int) : Boolean
        {
            return false;
        }// end function

        public function insert_cbtype(param1:ZPP_CbType) : void
        {
            var _loc_2:* = null as ZNPNode_ZPP_CbType;
            var _loc_3:* = null as ZNPNode_ZPP_CbType;
            var _loc_4:* = null as ZPP_CbType;
            var _loc_5:* = null as ZNPList_ZPP_CbType;
            var _loc_6:* = null as ZNPNode_ZPP_CbType;
            var _loc_7:* = false;
            if (!cbTypes.has(param1))
            {
                if (space != null)
                {
                    dealloc_cbSet();
                    param1.constraints.add(this);
                }
                _loc_2 = null;
                _loc_3 = cbTypes.head;
                while (_loc_3 != null)
                {
                    
                    _loc_4 = _loc_3.elt;
                    if (param1.id < _loc_4.id)
                    {
                        break;
                    }
                    _loc_2 = _loc_3;
                    _loc_3 = _loc_3.next;
                }
                _loc_5 = cbTypes;
                if (ZNPNode_ZPP_CbType.zpp_pool == null)
                {
                    _loc_6 = new ZNPNode_ZPP_CbType();
                }
                else
                {
                    _loc_6 = ZNPNode_ZPP_CbType.zpp_pool;
                    ZNPNode_ZPP_CbType.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.elt = param1;
                _loc_3 = _loc_6;
                if (_loc_2 == null)
                {
                    _loc_3.next = _loc_5.head;
                    _loc_5.head = _loc_3;
                }
                else
                {
                    _loc_3.next = _loc_2.next;
                    _loc_2.next = _loc_3;
                }
                _loc_7 = true;
                _loc_5.modified = _loc_7;
                _loc_5.pushmod = _loc_7;
                (_loc_5.length + 1);
                if (space != null)
                {
                    alloc_cbSet();
                    wake();
                }
            }
            return;
        }// end function

        public function inactiveOrOutSpace() : void
        {
            dealloc_cbSet();
            var _loc_1:* = component;
            _loc_1.body = null;
            _loc_1.constraint = null;
            _loc_1.next = ZPP_Component.zpp_pool;
            ZPP_Component.zpp_pool = _loc_1;
            component = null;
            return;
        }// end function

        public function inactiveBodies() : void
        {
            return;
        }// end function

        public function immutable_midstep(param1:String) : void
        {
            if (space != null)
            {
            }
            if (space.midstep)
            {
                throw "Error: Constraint::" + param1 + " cannot be set during space step()";
            }
            return;
        }// end function

        public function immutable_cbTypes() : void
        {
            immutable_midstep("Constraint::cbTypes");
            return;
        }// end function

        public function forest() : void
        {
            return;
        }// end function

        public function draw(param1:Debug) : void
        {
            return;
        }// end function

        public function dealloc_cbSet() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null as ZPP_CbSet;
            var _loc_3:* = null as ZPP_CbType;
            if (cbSet != null)
            {
                cbSet.constraints.remove(this);
                --cbSet.count;
                if (--cbSet.count == 0)
                {
                    space.cbsets.remove(cbSet);
                    _loc_2 = cbSet;
                    _loc_2.listeners.clear();
                    _loc_2.zip_listeners = true;
                    _loc_2.bodylisteners.clear();
                    _loc_2.zip_bodylisteners = true;
                    _loc_2.conlisteners.clear();
                    _loc_2.zip_conlisteners = true;
                    while (_loc_2.cbTypes.head != null)
                    {
                        
                        _loc_3 = _loc_2.cbTypes.pop_unsafe();
                        _loc_3.cbsets.remove(_loc_2);
                    }
                    _loc_2.next = ZPP_CbSet.zpp_pool;
                    ZPP_CbSet.zpp_pool = _loc_2;
                }
                cbSet = null;
            }
            return;
        }// end function

        public function deactivate() : void
        {
            if (space != null)
            {
                inactiveOrOutSpace();
            }
            return;
        }// end function

        public function copyto(param1:Constraint) : void
        {
            var _loc_4:* = null as CbTypeList;
            var _loc_5:* = null as CbType;
            var _loc_6:* = 0;
            var _loc_2:* = outer;
            if (_loc_2.zpp_inner.wrap_cbTypes == null)
            {
                _loc_2.zpp_inner.setupcbTypes();
            }
            _loc_4 = _loc_2.zpp_inner.wrap_cbTypes;
            _loc_4.zpp_inner.valmod();
            var _loc_3:* = CbTypeIterator.get(_loc_4);
            do
            {
                
                _loc_3.zpp_critical = false;
                _loc_6 = _loc_3.zpp_i;
                (_loc_3.zpp_i + 1);
                _loc_5 = _loc_3.zpp_inner.at(_loc_6);
                if (param1.zpp_inner.wrap_cbTypes == null)
                {
                    param1.zpp_inner.setupcbTypes();
                }
                _loc_4 = param1.zpp_inner.wrap_cbTypes;
                if (_loc_4.zpp_inner.reverse_flag)
                {
                    _loc_4.push(_loc_5);
                }
                else
                {
                    _loc_4.unshift(_loc_5);
                }
                _loc_3.zpp_inner.zpp_inner.valmod();
                _loc_4 = _loc_3.zpp_inner;
                _loc_4.zpp_inner.valmod();
                if (_loc_4.zpp_inner.zip_length)
                {
                    _loc_4.zpp_inner.zip_length = false;
                    _loc_4.zpp_inner.user_length = _loc_4.zpp_inner.inner.length;
                }
                _loc_6 = _loc_4.zpp_inner.user_length;
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_6 ? (true) : (_loc_3.zpp_next = CbTypeIterator.zpp_pool, CbTypeIterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            param1.zpp_inner.removeOnBreak = _loc_2.zpp_inner.removeOnBreak;
            var _loc_7:* = _loc_2.zpp_inner.breakUnderError;
            if (param1.zpp_inner.breakUnderError != _loc_7)
            {
                param1.zpp_inner.breakUnderError = _loc_7;
                param1.zpp_inner.wake();
            }
            _loc_7 = _loc_2.zpp_inner.breakUnderForce;
            if (param1.zpp_inner.breakUnderForce != _loc_7)
            {
                param1.zpp_inner.breakUnderForce = _loc_7;
                param1.zpp_inner.wake();
            }
            var _loc_8:* = _loc_2.zpp_inner.maxError;
            if (_loc_8 != _loc_8)
            {
                throw "Error: Constraint::maxError cannot be NaN";
            }
            if (_loc_8 < 0)
            {
                throw "Error: Constraint::maxError must be >=0";
            }
            if (param1.zpp_inner.maxError != _loc_8)
            {
                param1.zpp_inner.maxError = _loc_8;
                param1.zpp_inner.wake();
            }
            _loc_8 = _loc_2.zpp_inner.maxForce;
            if (_loc_8 != _loc_8)
            {
                throw "Error: Constraint::maxForce cannot be NaN";
            }
            if (_loc_8 < 0)
            {
                throw "Error: Constraint::maxForce must be >=0";
            }
            if (param1.zpp_inner.maxForce != _loc_8)
            {
                param1.zpp_inner.maxForce = _loc_8;
                param1.zpp_inner.wake();
            }
            _loc_8 = _loc_2.zpp_inner.damping;
            if (_loc_8 != _loc_8)
            {
                throw "Error: Constraint::Damping cannot be Nan";
            }
            if (_loc_8 < 0)
            {
                throw "Error: Constraint::Damping must be >=0";
            }
            if (param1.zpp_inner.damping != _loc_8)
            {
                param1.zpp_inner.damping = _loc_8;
                if (!param1.zpp_inner.stiff)
                {
                    param1.zpp_inner.wake();
                }
            }
            _loc_8 = _loc_2.zpp_inner.frequency;
            if (_loc_8 != _loc_8)
            {
                throw "Error: Constraint::Frequency cannot be NaN";
            }
            if (_loc_8 <= 0)
            {
                throw "Error: Constraint::Frequency must be >0";
            }
            if (param1.zpp_inner.frequency != _loc_8)
            {
                param1.zpp_inner.frequency = _loc_8;
                if (!param1.zpp_inner.stiff)
                {
                    param1.zpp_inner.wake();
                }
            }
            _loc_7 = _loc_2.zpp_inner.stiff;
            if (param1.zpp_inner.stiff != _loc_7)
            {
                param1.zpp_inner.stiff = _loc_7;
                param1.zpp_inner.wake();
            }
            _loc_7 = _loc_2.zpp_inner.ignore;
            if (param1.zpp_inner.ignore != _loc_7)
            {
                param1.zpp_inner.ignore = _loc_7;
                param1.zpp_inner.wake();
            }
            _loc_7 = _loc_2.zpp_inner.active;
            if (param1.zpp_inner.active != _loc_7)
            {
                if (param1.zpp_inner.component != null)
                {
                    param1.zpp_inner.component.woken = false;
                }
                param1.zpp_inner.clearcache();
                if (_loc_7)
                {
                    param1.zpp_inner.active = _loc_7;
                    param1.zpp_inner.activate();
                    if (param1.zpp_inner.space != null)
                    {
                        if (param1.zpp_inner.component != null)
                        {
                            param1.zpp_inner.component.sleeping = true;
                        }
                        param1.zpp_inner.space.wake_constraint(param1.zpp_inner, true);
                    }
                }
                else
                {
                    if (param1.zpp_inner.space != null)
                    {
                        param1.zpp_inner.wake();
                        param1.zpp_inner.space.live_constraints.remove(param1.zpp_inner);
                    }
                    param1.zpp_inner.active = _loc_7;
                    param1.zpp_inner.deactivate();
                }
            }
            return;
        }// end function

        public function copy(param1:Array = undefined, param2:Array = undefined) : Constraint
        {
            return null;
        }// end function

        public function clearcache() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function broken() : void
        {
            return;
        }// end function

        public function applyImpulseVel() : Boolean
        {
            return false;
        }// end function

        public function applyImpulsePos() : Boolean
        {
            return false;
        }// end function

        public function alloc_cbSet() : void
        {
            var _loc_1:* = space.cbsets.get(cbTypes);
            cbSet = space.cbsets.get(cbTypes);
            if (_loc_1 != null)
            {
                (cbSet.count + 1);
                cbSet.constraints.add(this);
            }
            return;
        }// end function

        public function addedToSpace() : void
        {
            var _loc_2:* = null as ZPP_CbType;
            if (active)
            {
                activeInSpace();
            }
            activeBodies();
            var _loc_1:* = cbTypes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.constraints.add(this);
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function activeInSpace() : void
        {
            alloc_cbSet();
            if (ZPP_Component.zpp_pool == null)
            {
                component = new ZPP_Component();
            }
            else
            {
                component = ZPP_Component.zpp_pool;
                ZPP_Component.zpp_pool = component.next;
                component.next = null;
            }
            component.isBody = false;
            component.constraint = this;
            return;
        }// end function

        public function activeBodies() : void
        {
            return;
        }// end function

        public function activate() : void
        {
            if (space != null)
            {
                activeInSpace();
            }
            return;
        }// end function

    }
}
