package zpp_nape.space
{
    import flash.*;
    import nape.*;
    import nape.callbacks.*;
    import nape.constraint.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import nape.space.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.constraint.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_Space extends Object
    {
        public var wrap_livecon:ConstraintList;
        public var wrap_live:BodyList;
        public var wrap_listeners:ListenerList;
        public var wrap_gravity:Vec2;
        public var wrap_constraints:ConstraintList;
        public var wrap_compounds:CompoundList;
        public var wrap_bodies:BodyList;
        public var wrap_arbiters:ArbiterList;
        public var userData:Object;
        public var toiEvents:ZNPList_ZPP_ToiEvent;
        public var time:Number;
        public var staticsleep:ZNPList_ZPP_Body;
        public var stamp:int;
        public var sortcontacts:Boolean;
        public var s_arbiters:ZNPList_ZPP_SensorArbiter;
        public var prelisteners:ZNPList_ZPP_InteractionListener;
        public var precb:PreCallback;
        public var pre_dt:Number;
        public var outer:Space;
        public var mrca2:ZNPList_ZPP_Interactor;
        public var mrca1:ZNPList_ZPP_Interactor;
        public var midstep:Boolean;
        public var live_constraints:ZNPList_ZPP_Constraint;
        public var live:ZNPList_ZPP_Body;
        public var listeners:ZNPList_ZPP_Listener;
        public var kinematics:ZNPList_ZPP_Body;
        public var islands:ZPP_Island;
        public var gravityy:Number;
        public var gravityx:Number;
        public var global_lin_drag:Number;
        public var global_ang_drag:Number;
        public var f_arbiters:ZNPList_ZPP_FluidArbiter;
        public var convexShapeList:ShapeList;
        public var continuous:Boolean;
        public var constraints:ZNPList_ZPP_Constraint;
        public var compounds:ZNPList_ZPP_Compound;
        public var cbsets:ZPP_CbSetManager;
        public var callbackset_list:ZPP_CallbackSet;
        public var callbacks:ZPP_Callback;
        public var c_arbiters_true:ZNPList_ZPP_ColArbiter;
        public var c_arbiters_false:ZNPList_ZPP_ColArbiter;
        public var bphase:ZPP_Broadphase;
        public var bodies:ZNPList_ZPP_Body;
        public var __static:Body;

        public function ZPP_Space(param1:ZPP_Vec2 = undefined, param2:Broadphase = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            prelisteners = null;
            precb = null;
            continuous = false;
            toiEvents = null;
            pre_dt = 0;
            convexShapeList = null;
            cbsets = null;
            callbackset_list = null;
            callbacks = null;
            wrap_listeners = null;
            listeners = null;
            islands = null;
            staticsleep = null;
            wrap_livecon = null;
            live_constraints = null;
            wrap_live = null;
            live = null;
            wrap_arbiters = null;
            s_arbiters = null;
            f_arbiters = null;
            c_arbiters_false = null;
            c_arbiters_true = null;
            sortcontacts = false;
            time = 0;
            midstep = false;
            stamp = 0;
            global_ang_drag = 0;
            global_lin_drag = 0;
            __static = null;
            bphase = null;
            kinematics = null;
            wrap_constraints = null;
            constraints = null;
            wrap_compounds = null;
            compounds = null;
            wrap_bodies = null;
            bodies = null;
            wrap_gravity = null;
            gravityy = 0;
            gravityx = 0;
            userData = null;
            outer = null;
            toiEvents = new ZNPList_ZPP_ToiEvent();
            global_lin_drag = 0.015;
            global_ang_drag = 0.015;
            ZPP_Callback.internal = true;
            precb = new PreCallback();
            precb.zpp_inner = new ZPP_Callback();
            ZPP_Callback.internal = false;
            sortcontacts = true;
            pre_dt = 0;
            if (param2 != null)
            {
                if (ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE = new Broadphase();
                    ZPP_Flags.internal = false;
                }
            }
            if (param2 == ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE)
            {
                bphase = new ZPP_DynAABBPhase(this);
            }
            else
            {
                if (ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.Broadphase_SWEEP_AND_PRUNE = new Broadphase();
                    ZPP_Flags.internal = false;
                }
                if (param2 == ZPP_Flags.Broadphase_SWEEP_AND_PRUNE)
                {
                    bphase = new ZPP_SweepPhase(this);
                }
            }
            time = 0;
            var _loc_3:* = this;
            if (param1 != null)
            {
                gravityx = param1.x;
                gravityy = param1.y;
            }
            else
            {
                gravityx = 0;
                gravityy = 0;
            }
            bodies = new ZNPList_ZPP_Body();
            wrap_bodies = ZPP_BodyList.get(bodies);
            wrap_bodies.zpp_inner.adder = bodies_adder;
            wrap_bodies.zpp_inner.subber = bodies_subber;
            wrap_bodies.zpp_inner._modifiable = bodies_modifiable;
            compounds = new ZNPList_ZPP_Compound();
            wrap_compounds = ZPP_CompoundList.get(compounds);
            wrap_compounds.zpp_inner.adder = compounds_adder;
            wrap_compounds.zpp_inner.subber = compounds_subber;
            wrap_compounds.zpp_inner._modifiable = compounds_modifiable;
            kinematics = new ZNPList_ZPP_Body();
            c_arbiters_true = new ZNPList_ZPP_ColArbiter();
            c_arbiters_false = new ZNPList_ZPP_ColArbiter();
            f_arbiters = new ZNPList_ZPP_FluidArbiter();
            s_arbiters = new ZNPList_ZPP_SensorArbiter();
            islands = new ZPP_Island();
            live = new ZNPList_ZPP_Body();
            wrap_live = ZPP_BodyList.get(live, true);
            staticsleep = new ZNPList_ZPP_Body();
            constraints = new ZNPList_ZPP_Constraint();
            wrap_constraints = ZPP_ConstraintList.get(constraints);
            wrap_constraints.zpp_inner.adder = constraints_adder;
            wrap_constraints.zpp_inner.subber = constraints_subber;
            wrap_constraints.zpp_inner._modifiable = constraints_modifiable;
            live_constraints = new ZNPList_ZPP_Constraint();
            wrap_livecon = ZPP_ConstraintList.get(live_constraints, true);
            __static = ZPP_Body.__static();
            __static.zpp_inner.space = this;
            callbacks = new ZPP_Callback();
            midstep = false;
            listeners = new ZNPList_ZPP_Listener();
            wrap_listeners = ZPP_ListenerList.get(listeners);
            wrap_listeners.zpp_inner.adder = listeners_adder;
            wrap_listeners.zpp_inner.subber = listeners_subber;
            wrap_listeners.zpp_inner._modifiable = listeners_modifiable;
            callbackset_list = new ZPP_CallbackSet();
            mrca1 = new ZNPList_ZPP_Interactor();
            mrca2 = new ZNPList_ZPP_Interactor();
            prelisteners = new ZNPList_ZPP_InteractionListener();
            cbsets = new ZPP_CbSetManager(this);
            return;
        }// end function

        public function warmStart() : void
        {
            var _loc_2:* = null as ZPP_FluidArbiter;
            var _loc_3:* = NaN;
            var _loc_6:* = null as ZPP_ColArbiter;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_10:* = null as ZPP_Constraint;
            var _loc_1:* = f_arbiters.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                if (_loc_2.active)
                {
                }
                if ((_loc_2.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                {
                    _loc_3 = _loc_2.b1.imass;
                    _loc_2.b1.velx = _loc_2.b1.velx - _loc_2.dampx * _loc_3;
                    _loc_2.b1.vely = _loc_2.b1.vely - _loc_2.dampy * _loc_3;
                    _loc_3 = _loc_2.b2.imass;
                    _loc_2.b2.velx = _loc_2.b2.velx + _loc_2.dampx * _loc_3;
                    _loc_2.b2.vely = _loc_2.b2.vely + _loc_2.dampy * _loc_3;
                    _loc_2.b1.angvel = _loc_2.b1.angvel - _loc_2.b1.iinertia * (_loc_2.dampy * _loc_2.r1x - _loc_2.dampx * _loc_2.r1y);
                    _loc_2.b2.angvel = _loc_2.b2.angvel + _loc_2.b2.iinertia * (_loc_2.dampy * _loc_2.r2x - _loc_2.dampx * _loc_2.r2y);
                    _loc_2.b1.angvel = _loc_2.b1.angvel - _loc_2.adamp * _loc_2.b1.iinertia;
                    _loc_2.b2.angvel = _loc_2.b2.angvel + _loc_2.adamp * _loc_2.b2.iinertia;
                }
                _loc_1 = _loc_1.next;
            }
            var _loc_4:* = c_arbiters_false.head;
            var _loc_5:* = true;
            if (_loc_4 == null)
            {
                _loc_4 = c_arbiters_true.head;
                _loc_5 = false;
            }
            while (_loc_4 != null)
            {
                
                _loc_6 = _loc_4.elt;
                if (_loc_6.active)
                {
                }
                if ((_loc_6.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                {
                    _loc_3 = _loc_6.nx * _loc_6.c1.jnAcc - _loc_6.ny * _loc_6.c1.jtAcc;
                    _loc_7 = _loc_6.ny * _loc_6.c1.jnAcc + _loc_6.nx * _loc_6.c1.jtAcc;
                    _loc_8 = _loc_6.b1.imass;
                    _loc_6.b1.velx = _loc_6.b1.velx - _loc_3 * _loc_8;
                    _loc_6.b1.vely = _loc_6.b1.vely - _loc_7 * _loc_8;
                    _loc_6.b1.angvel = _loc_6.b1.angvel - _loc_6.b1.iinertia * (_loc_7 * _loc_6.c1.r1x - _loc_3 * _loc_6.c1.r1y);
                    _loc_8 = _loc_6.b2.imass;
                    _loc_6.b2.velx = _loc_6.b2.velx + _loc_3 * _loc_8;
                    _loc_6.b2.vely = _loc_6.b2.vely + _loc_7 * _loc_8;
                    _loc_6.b2.angvel = _loc_6.b2.angvel + _loc_6.b2.iinertia * (_loc_7 * _loc_6.c1.r2x - _loc_3 * _loc_6.c1.r2y);
                    if (_loc_6.hc2)
                    {
                        _loc_3 = _loc_6.nx * _loc_6.c2.jnAcc - _loc_6.ny * _loc_6.c2.jtAcc;
                        _loc_7 = _loc_6.ny * _loc_6.c2.jnAcc + _loc_6.nx * _loc_6.c2.jtAcc;
                        _loc_8 = _loc_6.b1.imass;
                        _loc_6.b1.velx = _loc_6.b1.velx - _loc_3 * _loc_8;
                        _loc_6.b1.vely = _loc_6.b1.vely - _loc_7 * _loc_8;
                        _loc_6.b1.angvel = _loc_6.b1.angvel - _loc_6.b1.iinertia * (_loc_7 * _loc_6.c2.r1x - _loc_3 * _loc_6.c2.r1y);
                        _loc_8 = _loc_6.b2.imass;
                        _loc_6.b2.velx = _loc_6.b2.velx + _loc_3 * _loc_8;
                        _loc_6.b2.vely = _loc_6.b2.vely + _loc_7 * _loc_8;
                        _loc_6.b2.angvel = _loc_6.b2.angvel + _loc_6.b2.iinertia * (_loc_7 * _loc_6.c2.r2x - _loc_3 * _loc_6.c2.r2y);
                    }
                    _loc_6.b2.angvel = _loc_6.b2.angvel + _loc_6.jrAcc * _loc_6.b2.iinertia;
                    _loc_6.b1.angvel = _loc_6.b1.angvel - _loc_6.jrAcc * _loc_6.b1.iinertia;
                }
                _loc_4 = _loc_4.next;
                if (_loc_5)
                {
                }
                if (_loc_4 == null)
                {
                    _loc_4 = c_arbiters_true.head;
                    _loc_5 = false;
                }
            }
            var _loc_9:* = live_constraints.head;
            while (_loc_9 != null)
            {
                
                _loc_10 = _loc_9.elt;
                _loc_10.warmStart();
                _loc_9 = _loc_9.next;
            }
            return;
        }// end function

        public function wake_constraint(param1:ZPP_Constraint, param2:Boolean = false) : Boolean
        {
            var _loc_3:* = null as ZNPList_ZPP_Constraint;
            var _loc_4:* = null as ZNPNode_ZPP_Constraint;
            var _loc_5:* = null as ZNPNode_ZPP_Constraint;
            if (param1.active)
            {
                param1.component.waket = stamp + (midstep ? (0) : (1));
                if (param1.component.sleeping)
                {
                    if (param1.component.island == null)
                    {
                        param1.component.sleeping = false;
                        _loc_3 = live_constraints;
                        if (ZNPNode_ZPP_Constraint.zpp_pool == null)
                        {
                            _loc_5 = new ZNPNode_ZPP_Constraint();
                        }
                        else
                        {
                            _loc_5 = ZNPNode_ZPP_Constraint.zpp_pool;
                            ZNPNode_ZPP_Constraint.zpp_pool = _loc_5.next;
                            _loc_5.next = null;
                        }
                        _loc_5.elt = param1;
                        _loc_4 = _loc_5;
                        _loc_4.next = _loc_3.head;
                        _loc_3.head = _loc_4;
                        _loc_3.modified = true;
                        (_loc_3.length + 1);
                        param1.wake_connected();
                        if (!param2)
                        {
                            constraintCbWake(param1);
                        }
                    }
                    else
                    {
                        wakeIsland(param1.component.island);
                    }
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }// end function

        public function wakeIsland(param1:ZPP_Island) : void
        {
            var _loc_2:* = null as ZPP_Component;
            var _loc_3:* = null as ZPP_Body;
            var _loc_4:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_5:* = null as ZPP_Arbiter;
            var _loc_6:* = null as ZPP_ColArbiter;
            var _loc_7:* = null as ZNPList_ZPP_ColArbiter;
            var _loc_8:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_9:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_10:* = null as ZNPList_ZPP_FluidArbiter;
            var _loc_11:* = null as ZPP_FluidArbiter;
            var _loc_12:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_13:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_14:* = null as ZNPList_ZPP_SensorArbiter;
            var _loc_15:* = null as ZPP_SensorArbiter;
            var _loc_16:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_17:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_18:* = null as ZNPNode_ZPP_Shape;
            var _loc_19:* = null as ZPP_Shape;
            var _loc_20:* = null as ZPP_Constraint;
            var _loc_21:* = null as ZNPList_ZPP_Constraint;
            var _loc_22:* = null as ZNPNode_ZPP_Constraint;
            var _loc_23:* = null as ZNPNode_ZPP_Constraint;
            while (param1.comps.head != null)
            {
                
                _loc_2 = param1.comps.pop_unsafe();
                _loc_2.waket = stamp + (midstep ? (0) : (1));
                if (_loc_2.isBody)
                {
                    _loc_3 = _loc_2.body;
                    live.add(_loc_3);
                    _loc_4 = _loc_3.arbiters.head;
                    while (_loc_4 != null)
                    {
                        
                        _loc_5 = _loc_4.elt;
                        if (_loc_5.sleeping)
                        {
                            _loc_5.sleeping = false;
                            _loc_5.up_stamp = _loc_5.up_stamp + (stamp - _loc_5.sleep_stamp);
                            if (_loc_5.type == ZPP_Arbiter.COL)
                            {
                                _loc_6 = _loc_5.colarb;
                                if (_loc_6.stat)
                                {
                                    _loc_7 = c_arbiters_true;
                                    if (ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                                    {
                                        _loc_9 = new ZNPNode_ZPP_ColArbiter();
                                    }
                                    else
                                    {
                                        _loc_9 = ZNPNode_ZPP_ColArbiter.zpp_pool;
                                        ZNPNode_ZPP_ColArbiter.zpp_pool = _loc_9.next;
                                        _loc_9.next = null;
                                    }
                                    _loc_9.elt = _loc_6;
                                    _loc_8 = _loc_9;
                                    _loc_8.next = _loc_7.head;
                                    _loc_7.head = _loc_8;
                                    _loc_7.modified = true;
                                    (_loc_7.length + 1);
                                }
                                else
                                {
                                    _loc_7 = c_arbiters_false;
                                    if (ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                                    {
                                        _loc_9 = new ZNPNode_ZPP_ColArbiter();
                                    }
                                    else
                                    {
                                        _loc_9 = ZNPNode_ZPP_ColArbiter.zpp_pool;
                                        ZNPNode_ZPP_ColArbiter.zpp_pool = _loc_9.next;
                                        _loc_9.next = null;
                                    }
                                    _loc_9.elt = _loc_6;
                                    _loc_8 = _loc_9;
                                    _loc_8.next = _loc_7.head;
                                    _loc_7.head = _loc_8;
                                    _loc_7.modified = true;
                                    (_loc_7.length + 1);
                                }
                            }
                            else if (_loc_5.type == ZPP_Arbiter.FLUID)
                            {
                                _loc_10 = f_arbiters;
                                _loc_11 = _loc_5.fluidarb;
                                if (ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                                {
                                    _loc_13 = new ZNPNode_ZPP_FluidArbiter();
                                }
                                else
                                {
                                    _loc_13 = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                                    ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_13.next;
                                    _loc_13.next = null;
                                }
                                _loc_13.elt = _loc_11;
                                _loc_12 = _loc_13;
                                _loc_12.next = _loc_10.head;
                                _loc_10.head = _loc_12;
                                _loc_10.modified = true;
                                (_loc_10.length + 1);
                            }
                            else
                            {
                                _loc_14 = s_arbiters;
                                _loc_15 = _loc_5.sensorarb;
                                if (ZNPNode_ZPP_SensorArbiter.zpp_pool == null)
                                {
                                    _loc_17 = new ZNPNode_ZPP_SensorArbiter();
                                }
                                else
                                {
                                    _loc_17 = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                                    ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc_17.next;
                                    _loc_17.next = null;
                                }
                                _loc_17.elt = _loc_15;
                                _loc_16 = _loc_17;
                                _loc_16.next = _loc_14.head;
                                _loc_14.head = _loc_16;
                                _loc_14.modified = true;
                                (_loc_14.length + 1);
                            }
                        }
                        _loc_4 = _loc_4.next;
                    }
                    bodyCbWake(_loc_3);
                    _loc_2.sleeping = false;
                    _loc_2.island = null;
                    _loc_2.parent = _loc_2;
                    _loc_2.rank = 0;
                    if (_loc_3.type != ZPP_Flags.id_BodyType_STATIC)
                    {
                        _loc_18 = _loc_3.shapes.head;
                        while (_loc_18 != null)
                        {
                            
                            _loc_19 = _loc_18.elt;
                            if (_loc_19.node != null)
                            {
                                bphase.sync(_loc_19);
                            }
                            _loc_18 = _loc_18.next;
                        }
                    }
                    continue;
                }
                _loc_20 = _loc_2.constraint;
                _loc_21 = live_constraints;
                if (ZNPNode_ZPP_Constraint.zpp_pool == null)
                {
                    _loc_23 = new ZNPNode_ZPP_Constraint();
                }
                else
                {
                    _loc_23 = ZNPNode_ZPP_Constraint.zpp_pool;
                    ZNPNode_ZPP_Constraint.zpp_pool = _loc_23.next;
                    _loc_23.next = null;
                }
                _loc_23.elt = _loc_20;
                _loc_22 = _loc_23;
                _loc_22.next = _loc_21.head;
                _loc_21.head = _loc_22;
                _loc_21.modified = true;
                (_loc_21.length + 1);
                constraintCbWake(_loc_20);
                _loc_2.sleeping = false;
                _loc_2.island = null;
                _loc_2.parent = _loc_2;
                _loc_2.rank = 0;
            }
            var _loc_24:* = param1;
            _loc_24.next = ZPP_Island.zpp_pool;
            ZPP_Island.zpp_pool = _loc_24;
            return;
        }// end function

        public function wakeCompound(param1:ZPP_Compound) : void
        {
            var _loc_3:* = null as ZPP_Body;
            var _loc_4:* = null as ZPP_Body;
            var _loc_6:* = null as ZPP_Constraint;
            var _loc_8:* = null as ZPP_Compound;
            var _loc_2:* = param1.bodies.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_4 = _loc_3;
                if (!_loc_4.world)
                {
                    _loc_4.component.waket = stamp + (midstep ? (0) : (1));
                    if (_loc_4.type == ZPP_Flags.id_BodyType_KINEMATIC)
                    {
                        _loc_4.kinematicDelaySleep = true;
                    }
                    if (_loc_4.component.sleeping)
                    {
                        really_wake(_loc_4, false);
                    }
                }
                _loc_2 = _loc_2.next;
            }
            var _loc_5:* = param1.constraints.head;
            while (_loc_5 != null)
            {
                
                _loc_6 = _loc_5.elt;
                wake_constraint(_loc_6);
                _loc_5 = _loc_5.next;
            }
            var _loc_7:* = param1.compounds.head;
            while (_loc_7 != null)
            {
                
                _loc_8 = _loc_7.elt;
                wakeCompound(_loc_8);
                _loc_7 = _loc_7.next;
            }
            return;
        }// end function

        public function validation() : void
        {
            var _loc_2:* = null as ZPP_Set_ZPP_CbSet;
            var _loc_3:* = null as ZPP_CbSet;
            var _loc_5:* = null as ZPP_Body;
            var _loc_6:* = null as ZNPNode_ZPP_Shape;
            var _loc_7:* = null as ZPP_Shape;
            var _loc_8:* = null as ZPP_Polygon;
            var _loc_9:* = null as ValidationResult;
            var _loc_10:* = null as ZPP_Body;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_13:* = null as ZPP_Vec2;
            var _loc_14:* = null as ZPP_Vec2;
            var _loc_15:* = null as ZNPNode_ZPP_Edge;
            var _loc_16:* = null as ZPP_Edge;
            var _loc_17:* = null as ZPP_Circle;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = null as ZPP_Vec2;
            var _loc_21:* = null as ZPP_AABB;
            var _loc_22:* = null as ZPP_AABB;
            var _loc_23:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_24:* = null as ZPP_BodyListener;
            var _loc_25:* = null as ZPP_Callback;
            var _loc_27:* = null as ZPP_Constraint;
            var _loc_28:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_29:* = null as ZPP_ConstraintListener;
            var _loc_1:* = cbsets;
            if (!_loc_1.cbsets.empty())
            {
                _loc_2 = _loc_1.cbsets.parent;
                while (_loc_2.prev != null)
                {
                    
                    _loc_2 = _loc_2.prev;
                }
                while (_loc_2 != null)
                {
                    
                    _loc_3 = _loc_2.data;
                    _loc_3.validate();
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
            var _loc_4:* = live.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                _loc_5.sweepRadius = 0;
                _loc_6 = _loc_5.shapes.head;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6.elt;
                    if (_loc_7.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                        _loc_8 = _loc_7.polygon;
                        if (_loc_8.zip_sanitation)
                        {
                            _loc_8.zip_sanitation = false;
                            _loc_8.splice_collinear_real();
                        }
                        _loc_9 = _loc_7.polygon.valid();
                        if (ZPP_Flags.ValidationResult_VALID == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                            ZPP_Flags.internal = false;
                        }
                        if (_loc_9 != ZPP_Flags.ValidationResult_VALID)
                        {
                            throw "Error: Cannot simulate with an invalid Polygon : " + _loc_7.polygon.outer.toString() + " is invalid : " + _loc_9.toString();
                        }
                        _loc_8 = _loc_7.polygon;
                        if (_loc_8.zip_gaxi)
                        {
                            if (_loc_8.body != null)
                            {
                                _loc_8.zip_gaxi = false;
                                _loc_8.validate_laxi();
                                _loc_10 = _loc_8.body;
                                if (_loc_10.zip_axis)
                                {
                                    _loc_10.zip_axis = false;
                                    _loc_10.axisx = Math.sin(_loc_10.rot);
                                    _loc_10.axisy = Math.cos(_loc_10.rot);
                                }
                                if (_loc_8.zip_gverts)
                                {
                                    if (_loc_8.body != null)
                                    {
                                        _loc_8.zip_gverts = false;
                                        _loc_8.validate_lverts();
                                        _loc_10 = _loc_8.body;
                                        if (_loc_10.zip_axis)
                                        {
                                            _loc_10.zip_axis = false;
                                            _loc_10.axisx = Math.sin(_loc_10.rot);
                                            _loc_10.axisy = Math.cos(_loc_10.rot);
                                        }
                                        _loc_11 = _loc_8.lverts.next;
                                        _loc_12 = _loc_8.gverts.next;
                                        while (_loc_12 != null)
                                        {
                                            
                                            _loc_13 = _loc_12;
                                            _loc_14 = _loc_11;
                                            _loc_11 = _loc_11.next;
                                            _loc_13.x = _loc_8.body.posx + (_loc_8.body.axisy * _loc_14.x - _loc_8.body.axisx * _loc_14.y);
                                            _loc_13.y = _loc_8.body.posy + (_loc_14.x * _loc_8.body.axisx + _loc_14.y * _loc_8.body.axisy);
                                            _loc_12 = _loc_12.next;
                                        }
                                    }
                                }
                                _loc_15 = _loc_8.edges.head;
                                _loc_11 = _loc_8.gverts.next;
                                _loc_12 = _loc_11;
                                _loc_11 = _loc_11.next;
                                while (_loc_11 != null)
                                {
                                    
                                    _loc_13 = _loc_11;
                                    _loc_16 = _loc_15.elt;
                                    _loc_15 = _loc_15.next;
                                    _loc_16.gp0 = _loc_12;
                                    _loc_16.gp1 = _loc_13;
                                    _loc_16.gnormx = _loc_8.body.axisy * _loc_16.lnormx - _loc_8.body.axisx * _loc_16.lnormy;
                                    _loc_16.gnormy = _loc_16.lnormx * _loc_8.body.axisx + _loc_16.lnormy * _loc_8.body.axisy;
                                    _loc_16.gprojection = _loc_8.body.posx * _loc_16.gnormx + _loc_8.body.posy * _loc_16.gnormy + _loc_16.lprojection;
                                    if (_loc_16.wrap_gnorm != null)
                                    {
                                        _loc_16.wrap_gnorm.zpp_inner.x = _loc_16.gnormx;
                                        _loc_16.wrap_gnorm.zpp_inner.y = _loc_16.gnormy;
                                    }
                                    _loc_16.tp0 = _loc_16.gp0.y * _loc_16.gnormx - _loc_16.gp0.x * _loc_16.gnormy;
                                    _loc_16.tp1 = _loc_16.gp1.y * _loc_16.gnormx - _loc_16.gp1.x * _loc_16.gnormy;
                                    _loc_12 = _loc_13;
                                    _loc_11 = _loc_11.next;
                                }
                                _loc_13 = _loc_8.gverts.next;
                                _loc_16 = _loc_15.elt;
                                _loc_15 = _loc_15.next;
                                _loc_16.gp0 = _loc_12;
                                _loc_16.gp1 = _loc_13;
                                _loc_16.gnormx = _loc_8.body.axisy * _loc_16.lnormx - _loc_8.body.axisx * _loc_16.lnormy;
                                _loc_16.gnormy = _loc_16.lnormx * _loc_8.body.axisx + _loc_16.lnormy * _loc_8.body.axisy;
                                _loc_16.gprojection = _loc_8.body.posx * _loc_16.gnormx + _loc_8.body.posy * _loc_16.gnormy + _loc_16.lprojection;
                                if (_loc_16.wrap_gnorm != null)
                                {
                                    _loc_16.wrap_gnorm.zpp_inner.x = _loc_16.gnormx;
                                    _loc_16.wrap_gnorm.zpp_inner.y = _loc_16.gnormy;
                                }
                                _loc_16.tp0 = _loc_16.gp0.y * _loc_16.gnormx - _loc_16.gp0.x * _loc_16.gnormy;
                                _loc_16.tp1 = _loc_16.gp1.y * _loc_16.gnormx - _loc_16.gp1.x * _loc_16.gnormy;
                            }
                        }
                    }
                    _loc_7.validate_sweepRadius();
                    if (_loc_7.sweepRadius > _loc_5.sweepRadius)
                    {
                        _loc_5.sweepRadius = _loc_7.sweepRadius;
                    }
                    _loc_6 = _loc_6.next;
                }
                _loc_5.validate_mass();
                _loc_5.validate_inertia();
                if (_loc_5.shapes.head != null)
                {
                    if (_loc_5.shapes.head == null)
                    {
                        throw "Error: Body bounds only makes sense if it contains shapes";
                    }
                    if (_loc_5.zip_aabb)
                    {
                        _loc_5.zip_aabb = false;
                        _loc_5.aabb.minx = 17899999999999994000000000000;
                        _loc_5.aabb.miny = 17899999999999994000000000000;
                        _loc_5.aabb.maxx = -17899999999999994000000000000;
                        _loc_5.aabb.maxy = -17899999999999994000000000000;
                        _loc_6 = _loc_5.shapes.head;
                        while (_loc_6 != null)
                        {
                            
                            _loc_7 = _loc_6.elt;
                            if (_loc_7.zip_aabb)
                            {
                                if (_loc_7.body != null)
                                {
                                    _loc_7.zip_aabb = false;
                                    if (_loc_7.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                    {
                                        _loc_17 = _loc_7.circle;
                                        if (_loc_17.zip_worldCOM)
                                        {
                                            if (_loc_17.body != null)
                                            {
                                                _loc_17.zip_worldCOM = false;
                                                if (_loc_17.zip_localCOM)
                                                {
                                                    _loc_17.zip_localCOM = false;
                                                    if (_loc_17.type == ZPP_Flags.id_ShapeType_POLYGON)
                                                    {
                                                        _loc_8 = _loc_17.polygon;
                                                        if (_loc_8.lverts.next == null)
                                                        {
                                                            throw "Error: An empty polygon has no meaningful localCOM";
                                                        }
                                                        if (_loc_8.lverts.next.next == null)
                                                        {
                                                            _loc_8.localCOMx = _loc_8.lverts.next.x;
                                                            _loc_8.localCOMy = _loc_8.lverts.next.y;
                                                        }
                                                        else if (_loc_8.lverts.next.next.next == null)
                                                        {
                                                            _loc_8.localCOMx = _loc_8.lverts.next.x;
                                                            _loc_8.localCOMy = _loc_8.lverts.next.y;
                                                            _loc_18 = 1;
                                                            _loc_8.localCOMx = _loc_8.localCOMx + _loc_8.lverts.next.next.x * _loc_18;
                                                            _loc_8.localCOMy = _loc_8.localCOMy + _loc_8.lverts.next.next.y * _loc_18;
                                                            _loc_18 = 0.5;
                                                            _loc_8.localCOMx = _loc_8.localCOMx * _loc_18;
                                                            _loc_8.localCOMy = _loc_8.localCOMy * _loc_18;
                                                        }
                                                        else
                                                        {
                                                            _loc_8.localCOMx = 0;
                                                            _loc_8.localCOMy = 0;
                                                            _loc_18 = 0;
                                                            _loc_11 = _loc_8.lverts.next;
                                                            _loc_12 = _loc_11;
                                                            _loc_11 = _loc_11.next;
                                                            _loc_13 = _loc_11;
                                                            _loc_11 = _loc_11.next;
                                                            while (_loc_11 != null)
                                                            {
                                                                
                                                                _loc_14 = _loc_11;
                                                                _loc_18 = _loc_18 + _loc_13.x * (_loc_14.y - _loc_12.y);
                                                                _loc_19 = _loc_14.y * _loc_13.x - _loc_14.x * _loc_13.y;
                                                                _loc_8.localCOMx = _loc_8.localCOMx + (_loc_13.x + _loc_14.x) * _loc_19;
                                                                _loc_8.localCOMy = _loc_8.localCOMy + (_loc_13.y + _loc_14.y) * _loc_19;
                                                                _loc_12 = _loc_13;
                                                                _loc_13 = _loc_14;
                                                                _loc_11 = _loc_11.next;
                                                            }
                                                            _loc_11 = _loc_8.lverts.next;
                                                            _loc_14 = _loc_11;
                                                            _loc_18 = _loc_18 + _loc_13.x * (_loc_14.y - _loc_12.y);
                                                            _loc_19 = _loc_14.y * _loc_13.x - _loc_14.x * _loc_13.y;
                                                            _loc_8.localCOMx = _loc_8.localCOMx + (_loc_13.x + _loc_14.x) * _loc_19;
                                                            _loc_8.localCOMy = _loc_8.localCOMy + (_loc_13.y + _loc_14.y) * _loc_19;
                                                            _loc_12 = _loc_13;
                                                            _loc_13 = _loc_14;
                                                            _loc_11 = _loc_11.next;
                                                            _loc_20 = _loc_11;
                                                            _loc_18 = _loc_18 + _loc_13.x * (_loc_20.y - _loc_12.y);
                                                            _loc_19 = _loc_20.y * _loc_13.x - _loc_20.x * _loc_13.y;
                                                            _loc_8.localCOMx = _loc_8.localCOMx + (_loc_13.x + _loc_20.x) * _loc_19;
                                                            _loc_8.localCOMy = _loc_8.localCOMy + (_loc_13.y + _loc_20.y) * _loc_19;
                                                            _loc_18 = 1 / (3 * _loc_18);
                                                            _loc_19 = _loc_18;
                                                            _loc_8.localCOMx = _loc_8.localCOMx * _loc_19;
                                                            _loc_8.localCOMy = _loc_8.localCOMy * _loc_19;
                                                        }
                                                    }
                                                    if (_loc_17.wrap_localCOM != null)
                                                    {
                                                        _loc_17.wrap_localCOM.zpp_inner.x = _loc_17.localCOMx;
                                                        _loc_17.wrap_localCOM.zpp_inner.y = _loc_17.localCOMy;
                                                    }
                                                }
                                                _loc_10 = _loc_17.body;
                                                if (_loc_10.zip_axis)
                                                {
                                                    _loc_10.zip_axis = false;
                                                    _loc_10.axisx = Math.sin(_loc_10.rot);
                                                    _loc_10.axisy = Math.cos(_loc_10.rot);
                                                }
                                                _loc_17.worldCOMx = _loc_17.body.posx + (_loc_17.body.axisy * _loc_17.localCOMx - _loc_17.body.axisx * _loc_17.localCOMy);
                                                _loc_17.worldCOMy = _loc_17.body.posy + (_loc_17.localCOMx * _loc_17.body.axisx + _loc_17.localCOMy * _loc_17.body.axisy);
                                            }
                                        }
                                        _loc_18 = _loc_17.radius;
                                        _loc_19 = _loc_17.radius;
                                        _loc_17.aabb.minx = _loc_17.worldCOMx - _loc_18;
                                        _loc_17.aabb.miny = _loc_17.worldCOMy - _loc_19;
                                        _loc_17.aabb.maxx = _loc_17.worldCOMx + _loc_18;
                                        _loc_17.aabb.maxy = _loc_17.worldCOMy + _loc_19;
                                    }
                                    else
                                    {
                                        _loc_8 = _loc_7.polygon;
                                        if (_loc_8.zip_gverts)
                                        {
                                            if (_loc_8.body != null)
                                            {
                                                _loc_8.zip_gverts = false;
                                                _loc_8.validate_lverts();
                                                _loc_10 = _loc_8.body;
                                                if (_loc_10.zip_axis)
                                                {
                                                    _loc_10.zip_axis = false;
                                                    _loc_10.axisx = Math.sin(_loc_10.rot);
                                                    _loc_10.axisy = Math.cos(_loc_10.rot);
                                                }
                                                _loc_11 = _loc_8.lverts.next;
                                                _loc_12 = _loc_8.gverts.next;
                                                while (_loc_12 != null)
                                                {
                                                    
                                                    _loc_13 = _loc_12;
                                                    _loc_14 = _loc_11;
                                                    _loc_11 = _loc_11.next;
                                                    _loc_13.x = _loc_8.body.posx + (_loc_8.body.axisy * _loc_14.x - _loc_8.body.axisx * _loc_14.y);
                                                    _loc_13.y = _loc_8.body.posy + (_loc_14.x * _loc_8.body.axisx + _loc_14.y * _loc_8.body.axisy);
                                                    _loc_12 = _loc_12.next;
                                                }
                                            }
                                        }
                                        if (_loc_8.lverts.next == null)
                                        {
                                            throw "Error: An empty polygon has no meaningful bounds";
                                        }
                                        _loc_11 = _loc_8.gverts.next;
                                        _loc_8.aabb.minx = _loc_11.x;
                                        _loc_8.aabb.miny = _loc_11.y;
                                        _loc_8.aabb.maxx = _loc_11.x;
                                        _loc_8.aabb.maxy = _loc_11.y;
                                        _loc_12 = _loc_8.gverts.next.next;
                                        while (_loc_12 != null)
                                        {
                                            
                                            _loc_13 = _loc_12;
                                            if (_loc_13.x < _loc_8.aabb.minx)
                                            {
                                                _loc_8.aabb.minx = _loc_13.x;
                                            }
                                            if (_loc_13.x > _loc_8.aabb.maxx)
                                            {
                                                _loc_8.aabb.maxx = _loc_13.x;
                                            }
                                            if (_loc_13.y < _loc_8.aabb.miny)
                                            {
                                                _loc_8.aabb.miny = _loc_13.y;
                                            }
                                            if (_loc_13.y > _loc_8.aabb.maxy)
                                            {
                                                _loc_8.aabb.maxy = _loc_13.y;
                                            }
                                            _loc_12 = _loc_12.next;
                                        }
                                    }
                                }
                            }
                            _loc_21 = _loc_5.aabb;
                            _loc_22 = _loc_7.aabb;
                            if (_loc_22.minx < _loc_21.minx)
                            {
                                _loc_21.minx = _loc_22.minx;
                            }
                            if (_loc_22.maxx > _loc_21.maxx)
                            {
                                _loc_21.maxx = _loc_22.maxx;
                            }
                            if (_loc_22.miny < _loc_21.miny)
                            {
                                _loc_21.miny = _loc_22.miny;
                            }
                            if (_loc_22.maxy > _loc_21.maxy)
                            {
                                _loc_21.maxy = _loc_22.maxy;
                            }
                            _loc_6 = _loc_6.next;
                        }
                    }
                    _loc_5.validate_worldCOM();
                }
                _loc_5.validate_gravMass();
                if (_loc_5.zip_axis)
                {
                    _loc_5.zip_axis = false;
                    _loc_5.axisx = Math.sin(_loc_5.rot);
                    _loc_5.axisy = Math.cos(_loc_5.rot);
                }
                if (!_loc_5.nomove)
                {
                }
                if (_loc_5.type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                }
                if (_loc_5.mass == 0)
                {
                    throw "Error: Dynamic Body cannot be simulated with 0 mass unless allowMovement is false";
                }
                if (!_loc_5.norotate)
                {
                }
                if (_loc_5.type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                }
                if (_loc_5.inertia == 0)
                {
                    throw "Error: Dynamic Body cannot be simulated with 0 inertia unless allowRotation is false";
                }
                if (_loc_5.component.woken)
                {
                }
                if (_loc_5.cbSet != null)
                {
                    _loc_23 = _loc_5.cbSet.bodylisteners.head;
                    while (_loc_23 != null)
                    {
                        
                        _loc_24 = _loc_23.elt;
                        if (_loc_24.event != ZPP_Flags.id_CbEvent_WAKE)
                        {
                            _loc_23 = _loc_23.next;
                            continue;
                        }
                        _loc_25 = push_callback(_loc_24);
                        _loc_25.event = ZPP_Flags.id_CbEvent_WAKE;
                        _loc_25.body = _loc_5;
                        _loc_23 = _loc_23.next;
                    }
                }
                _loc_5.component.woken = false;
                _loc_6 = _loc_5.shapes.head;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6.elt;
                    bphase.sync(_loc_7);
                    _loc_6 = _loc_6.next;
                }
                _loc_4 = _loc_4.next;
            }
            _loc_4 = kinematics.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                _loc_5.sweepRadius = 0;
                _loc_6 = _loc_5.shapes.head;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6.elt;
                    if (_loc_7.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                        _loc_8 = _loc_7.polygon;
                        if (_loc_8.zip_sanitation)
                        {
                            _loc_8.zip_sanitation = false;
                            _loc_8.splice_collinear_real();
                        }
                        _loc_9 = _loc_7.polygon.valid();
                        if (ZPP_Flags.ValidationResult_VALID == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                            ZPP_Flags.internal = false;
                        }
                        if (_loc_9 != ZPP_Flags.ValidationResult_VALID)
                        {
                            throw "Error: Cannot simulate with an invalid Polygon : " + _loc_7.polygon.outer.toString() + " is invalid : " + _loc_9.toString();
                        }
                        _loc_8 = _loc_7.polygon;
                        if (_loc_8.zip_gaxi)
                        {
                            if (_loc_8.body != null)
                            {
                                _loc_8.zip_gaxi = false;
                                _loc_8.validate_laxi();
                                _loc_10 = _loc_8.body;
                                if (_loc_10.zip_axis)
                                {
                                    _loc_10.zip_axis = false;
                                    _loc_10.axisx = Math.sin(_loc_10.rot);
                                    _loc_10.axisy = Math.cos(_loc_10.rot);
                                }
                                if (_loc_8.zip_gverts)
                                {
                                    if (_loc_8.body != null)
                                    {
                                        _loc_8.zip_gverts = false;
                                        _loc_8.validate_lverts();
                                        _loc_10 = _loc_8.body;
                                        if (_loc_10.zip_axis)
                                        {
                                            _loc_10.zip_axis = false;
                                            _loc_10.axisx = Math.sin(_loc_10.rot);
                                            _loc_10.axisy = Math.cos(_loc_10.rot);
                                        }
                                        _loc_11 = _loc_8.lverts.next;
                                        _loc_12 = _loc_8.gverts.next;
                                        while (_loc_12 != null)
                                        {
                                            
                                            _loc_13 = _loc_12;
                                            _loc_14 = _loc_11;
                                            _loc_11 = _loc_11.next;
                                            _loc_13.x = _loc_8.body.posx + (_loc_8.body.axisy * _loc_14.x - _loc_8.body.axisx * _loc_14.y);
                                            _loc_13.y = _loc_8.body.posy + (_loc_14.x * _loc_8.body.axisx + _loc_14.y * _loc_8.body.axisy);
                                            _loc_12 = _loc_12.next;
                                        }
                                    }
                                }
                                _loc_15 = _loc_8.edges.head;
                                _loc_11 = _loc_8.gverts.next;
                                _loc_12 = _loc_11;
                                _loc_11 = _loc_11.next;
                                while (_loc_11 != null)
                                {
                                    
                                    _loc_13 = _loc_11;
                                    _loc_16 = _loc_15.elt;
                                    _loc_15 = _loc_15.next;
                                    _loc_16.gp0 = _loc_12;
                                    _loc_16.gp1 = _loc_13;
                                    _loc_16.gnormx = _loc_8.body.axisy * _loc_16.lnormx - _loc_8.body.axisx * _loc_16.lnormy;
                                    _loc_16.gnormy = _loc_16.lnormx * _loc_8.body.axisx + _loc_16.lnormy * _loc_8.body.axisy;
                                    _loc_16.gprojection = _loc_8.body.posx * _loc_16.gnormx + _loc_8.body.posy * _loc_16.gnormy + _loc_16.lprojection;
                                    if (_loc_16.wrap_gnorm != null)
                                    {
                                        _loc_16.wrap_gnorm.zpp_inner.x = _loc_16.gnormx;
                                        _loc_16.wrap_gnorm.zpp_inner.y = _loc_16.gnormy;
                                    }
                                    _loc_16.tp0 = _loc_16.gp0.y * _loc_16.gnormx - _loc_16.gp0.x * _loc_16.gnormy;
                                    _loc_16.tp1 = _loc_16.gp1.y * _loc_16.gnormx - _loc_16.gp1.x * _loc_16.gnormy;
                                    _loc_12 = _loc_13;
                                    _loc_11 = _loc_11.next;
                                }
                                _loc_13 = _loc_8.gverts.next;
                                _loc_16 = _loc_15.elt;
                                _loc_15 = _loc_15.next;
                                _loc_16.gp0 = _loc_12;
                                _loc_16.gp1 = _loc_13;
                                _loc_16.gnormx = _loc_8.body.axisy * _loc_16.lnormx - _loc_8.body.axisx * _loc_16.lnormy;
                                _loc_16.gnormy = _loc_16.lnormx * _loc_8.body.axisx + _loc_16.lnormy * _loc_8.body.axisy;
                                _loc_16.gprojection = _loc_8.body.posx * _loc_16.gnormx + _loc_8.body.posy * _loc_16.gnormy + _loc_16.lprojection;
                                if (_loc_16.wrap_gnorm != null)
                                {
                                    _loc_16.wrap_gnorm.zpp_inner.x = _loc_16.gnormx;
                                    _loc_16.wrap_gnorm.zpp_inner.y = _loc_16.gnormy;
                                }
                                _loc_16.tp0 = _loc_16.gp0.y * _loc_16.gnormx - _loc_16.gp0.x * _loc_16.gnormy;
                                _loc_16.tp1 = _loc_16.gp1.y * _loc_16.gnormx - _loc_16.gp1.x * _loc_16.gnormy;
                            }
                        }
                    }
                    _loc_7.validate_sweepRadius();
                    if (_loc_7.sweepRadius > _loc_5.sweepRadius)
                    {
                        _loc_5.sweepRadius = _loc_7.sweepRadius;
                    }
                    _loc_6 = _loc_6.next;
                }
                _loc_5.validate_mass();
                _loc_5.validate_inertia();
                if (_loc_5.shapes.head != null)
                {
                    if (_loc_5.shapes.head == null)
                    {
                        throw "Error: Body bounds only makes sense if it contains shapes";
                    }
                    if (_loc_5.zip_aabb)
                    {
                        _loc_5.zip_aabb = false;
                        _loc_5.aabb.minx = 17899999999999994000000000000;
                        _loc_5.aabb.miny = 17899999999999994000000000000;
                        _loc_5.aabb.maxx = -17899999999999994000000000000;
                        _loc_5.aabb.maxy = -17899999999999994000000000000;
                        _loc_6 = _loc_5.shapes.head;
                        while (_loc_6 != null)
                        {
                            
                            _loc_7 = _loc_6.elt;
                            if (_loc_7.zip_aabb)
                            {
                                if (_loc_7.body != null)
                                {
                                    _loc_7.zip_aabb = false;
                                    if (_loc_7.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                    {
                                        _loc_17 = _loc_7.circle;
                                        if (_loc_17.zip_worldCOM)
                                        {
                                            if (_loc_17.body != null)
                                            {
                                                _loc_17.zip_worldCOM = false;
                                                if (_loc_17.zip_localCOM)
                                                {
                                                    _loc_17.zip_localCOM = false;
                                                    if (_loc_17.type == ZPP_Flags.id_ShapeType_POLYGON)
                                                    {
                                                        _loc_8 = _loc_17.polygon;
                                                        if (_loc_8.lverts.next == null)
                                                        {
                                                            throw "Error: An empty polygon has no meaningful localCOM";
                                                        }
                                                        if (_loc_8.lverts.next.next == null)
                                                        {
                                                            _loc_8.localCOMx = _loc_8.lverts.next.x;
                                                            _loc_8.localCOMy = _loc_8.lverts.next.y;
                                                        }
                                                        else if (_loc_8.lverts.next.next.next == null)
                                                        {
                                                            _loc_8.localCOMx = _loc_8.lverts.next.x;
                                                            _loc_8.localCOMy = _loc_8.lverts.next.y;
                                                            _loc_18 = 1;
                                                            _loc_8.localCOMx = _loc_8.localCOMx + _loc_8.lverts.next.next.x * _loc_18;
                                                            _loc_8.localCOMy = _loc_8.localCOMy + _loc_8.lverts.next.next.y * _loc_18;
                                                            _loc_18 = 0.5;
                                                            _loc_8.localCOMx = _loc_8.localCOMx * _loc_18;
                                                            _loc_8.localCOMy = _loc_8.localCOMy * _loc_18;
                                                        }
                                                        else
                                                        {
                                                            _loc_8.localCOMx = 0;
                                                            _loc_8.localCOMy = 0;
                                                            _loc_18 = 0;
                                                            _loc_11 = _loc_8.lverts.next;
                                                            _loc_12 = _loc_11;
                                                            _loc_11 = _loc_11.next;
                                                            _loc_13 = _loc_11;
                                                            _loc_11 = _loc_11.next;
                                                            while (_loc_11 != null)
                                                            {
                                                                
                                                                _loc_14 = _loc_11;
                                                                _loc_18 = _loc_18 + _loc_13.x * (_loc_14.y - _loc_12.y);
                                                                _loc_19 = _loc_14.y * _loc_13.x - _loc_14.x * _loc_13.y;
                                                                _loc_8.localCOMx = _loc_8.localCOMx + (_loc_13.x + _loc_14.x) * _loc_19;
                                                                _loc_8.localCOMy = _loc_8.localCOMy + (_loc_13.y + _loc_14.y) * _loc_19;
                                                                _loc_12 = _loc_13;
                                                                _loc_13 = _loc_14;
                                                                _loc_11 = _loc_11.next;
                                                            }
                                                            _loc_11 = _loc_8.lverts.next;
                                                            _loc_14 = _loc_11;
                                                            _loc_18 = _loc_18 + _loc_13.x * (_loc_14.y - _loc_12.y);
                                                            _loc_19 = _loc_14.y * _loc_13.x - _loc_14.x * _loc_13.y;
                                                            _loc_8.localCOMx = _loc_8.localCOMx + (_loc_13.x + _loc_14.x) * _loc_19;
                                                            _loc_8.localCOMy = _loc_8.localCOMy + (_loc_13.y + _loc_14.y) * _loc_19;
                                                            _loc_12 = _loc_13;
                                                            _loc_13 = _loc_14;
                                                            _loc_11 = _loc_11.next;
                                                            _loc_20 = _loc_11;
                                                            _loc_18 = _loc_18 + _loc_13.x * (_loc_20.y - _loc_12.y);
                                                            _loc_19 = _loc_20.y * _loc_13.x - _loc_20.x * _loc_13.y;
                                                            _loc_8.localCOMx = _loc_8.localCOMx + (_loc_13.x + _loc_20.x) * _loc_19;
                                                            _loc_8.localCOMy = _loc_8.localCOMy + (_loc_13.y + _loc_20.y) * _loc_19;
                                                            _loc_18 = 1 / (3 * _loc_18);
                                                            _loc_19 = _loc_18;
                                                            _loc_8.localCOMx = _loc_8.localCOMx * _loc_19;
                                                            _loc_8.localCOMy = _loc_8.localCOMy * _loc_19;
                                                        }
                                                    }
                                                    if (_loc_17.wrap_localCOM != null)
                                                    {
                                                        _loc_17.wrap_localCOM.zpp_inner.x = _loc_17.localCOMx;
                                                        _loc_17.wrap_localCOM.zpp_inner.y = _loc_17.localCOMy;
                                                    }
                                                }
                                                _loc_10 = _loc_17.body;
                                                if (_loc_10.zip_axis)
                                                {
                                                    _loc_10.zip_axis = false;
                                                    _loc_10.axisx = Math.sin(_loc_10.rot);
                                                    _loc_10.axisy = Math.cos(_loc_10.rot);
                                                }
                                                _loc_17.worldCOMx = _loc_17.body.posx + (_loc_17.body.axisy * _loc_17.localCOMx - _loc_17.body.axisx * _loc_17.localCOMy);
                                                _loc_17.worldCOMy = _loc_17.body.posy + (_loc_17.localCOMx * _loc_17.body.axisx + _loc_17.localCOMy * _loc_17.body.axisy);
                                            }
                                        }
                                        _loc_18 = _loc_17.radius;
                                        _loc_19 = _loc_17.radius;
                                        _loc_17.aabb.minx = _loc_17.worldCOMx - _loc_18;
                                        _loc_17.aabb.miny = _loc_17.worldCOMy - _loc_19;
                                        _loc_17.aabb.maxx = _loc_17.worldCOMx + _loc_18;
                                        _loc_17.aabb.maxy = _loc_17.worldCOMy + _loc_19;
                                    }
                                    else
                                    {
                                        _loc_8 = _loc_7.polygon;
                                        if (_loc_8.zip_gverts)
                                        {
                                            if (_loc_8.body != null)
                                            {
                                                _loc_8.zip_gverts = false;
                                                _loc_8.validate_lverts();
                                                _loc_10 = _loc_8.body;
                                                if (_loc_10.zip_axis)
                                                {
                                                    _loc_10.zip_axis = false;
                                                    _loc_10.axisx = Math.sin(_loc_10.rot);
                                                    _loc_10.axisy = Math.cos(_loc_10.rot);
                                                }
                                                _loc_11 = _loc_8.lverts.next;
                                                _loc_12 = _loc_8.gverts.next;
                                                while (_loc_12 != null)
                                                {
                                                    
                                                    _loc_13 = _loc_12;
                                                    _loc_14 = _loc_11;
                                                    _loc_11 = _loc_11.next;
                                                    _loc_13.x = _loc_8.body.posx + (_loc_8.body.axisy * _loc_14.x - _loc_8.body.axisx * _loc_14.y);
                                                    _loc_13.y = _loc_8.body.posy + (_loc_14.x * _loc_8.body.axisx + _loc_14.y * _loc_8.body.axisy);
                                                    _loc_12 = _loc_12.next;
                                                }
                                            }
                                        }
                                        if (_loc_8.lverts.next == null)
                                        {
                                            throw "Error: An empty polygon has no meaningful bounds";
                                        }
                                        _loc_11 = _loc_8.gverts.next;
                                        _loc_8.aabb.minx = _loc_11.x;
                                        _loc_8.aabb.miny = _loc_11.y;
                                        _loc_8.aabb.maxx = _loc_11.x;
                                        _loc_8.aabb.maxy = _loc_11.y;
                                        _loc_12 = _loc_8.gverts.next.next;
                                        while (_loc_12 != null)
                                        {
                                            
                                            _loc_13 = _loc_12;
                                            if (_loc_13.x < _loc_8.aabb.minx)
                                            {
                                                _loc_8.aabb.minx = _loc_13.x;
                                            }
                                            if (_loc_13.x > _loc_8.aabb.maxx)
                                            {
                                                _loc_8.aabb.maxx = _loc_13.x;
                                            }
                                            if (_loc_13.y < _loc_8.aabb.miny)
                                            {
                                                _loc_8.aabb.miny = _loc_13.y;
                                            }
                                            if (_loc_13.y > _loc_8.aabb.maxy)
                                            {
                                                _loc_8.aabb.maxy = _loc_13.y;
                                            }
                                            _loc_12 = _loc_12.next;
                                        }
                                    }
                                }
                            }
                            _loc_21 = _loc_5.aabb;
                            _loc_22 = _loc_7.aabb;
                            if (_loc_22.minx < _loc_21.minx)
                            {
                                _loc_21.minx = _loc_22.minx;
                            }
                            if (_loc_22.maxx > _loc_21.maxx)
                            {
                                _loc_21.maxx = _loc_22.maxx;
                            }
                            if (_loc_22.miny < _loc_21.miny)
                            {
                                _loc_21.miny = _loc_22.miny;
                            }
                            if (_loc_22.maxy > _loc_21.maxy)
                            {
                                _loc_21.maxy = _loc_22.maxy;
                            }
                            _loc_6 = _loc_6.next;
                        }
                    }
                    _loc_5.validate_worldCOM();
                }
                _loc_5.validate_gravMass();
                if (_loc_5.zip_axis)
                {
                    _loc_5.zip_axis = false;
                    _loc_5.axisx = Math.sin(_loc_5.rot);
                    _loc_5.axisy = Math.cos(_loc_5.rot);
                }
                if (!_loc_5.nomove)
                {
                }
                if (_loc_5.type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                }
                if (_loc_5.mass == 0)
                {
                    throw "Error: Dynamic Body cannot be simulated with 0 mass unless allowMovement is false";
                }
                if (!_loc_5.norotate)
                {
                }
                if (_loc_5.type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                }
                if (_loc_5.inertia == 0)
                {
                    throw "Error: Dynamic Body cannot be simulated with 0 inertia unless allowRotation is false";
                }
                _loc_6 = _loc_5.shapes.head;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6.elt;
                    bphase.sync(_loc_7);
                    _loc_6 = _loc_6.next;
                }
                _loc_4 = _loc_4.next;
            }
            var _loc_26:* = live_constraints.head;
            while (_loc_26 != null)
            {
                
                _loc_27 = _loc_26.elt;
                if (_loc_27.active)
                {
                    _loc_27.validate();
                    if (_loc_27.component.woken)
                    {
                    }
                    if (_loc_27.cbSet != null)
                    {
                        _loc_28 = _loc_27.cbSet.conlisteners.head;
                        while (_loc_28 != null)
                        {
                            
                            _loc_29 = _loc_28.elt;
                            if (_loc_29.event != ZPP_Flags.id_CbEvent_WAKE)
                            {
                                _loc_28 = _loc_28.next;
                                continue;
                            }
                            _loc_25 = push_callback(_loc_29);
                            _loc_25.event = ZPP_Flags.id_CbEvent_WAKE;
                            _loc_25.constraint = _loc_27;
                            _loc_28 = _loc_28.next;
                        }
                    }
                    _loc_27.component.woken = false;
                }
                _loc_26 = _loc_26.next;
            }
            return;
        }// end function

        public function updateVel(param1:Number) : void
        {
            var _loc_6:* = null as ZPP_Body;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_2:* = null;
            var _loc_3:* = 1 - param1 * global_lin_drag;
            var _loc_4:* = 1 - param1 * global_ang_drag;
            var _loc_5:* = live.head;
            while (_loc_5 != null)
            {
                
                _loc_6 = _loc_5.elt;
                if (_loc_6.smass != 0)
                {
                    _loc_7 = param1 * _loc_6.imass;
                    _loc_6.velx = _loc_3 * _loc_6.velx + (_loc_6.forcex + gravityx * _loc_6.gravMass) * _loc_7;
                    _loc_6.vely = _loc_3 * _loc_6.vely + (_loc_6.forcey + gravityy * _loc_6.gravMass) * _loc_7;
                }
                if (_loc_6.sinertia != 0)
                {
                    _loc_7 = 0;
                    _loc_8 = 0;
                    _loc_7 = _loc_6.worldCOMx - _loc_6.posx;
                    _loc_8 = _loc_6.worldCOMy - _loc_6.posy;
                    _loc_9 = _loc_6.torque + (gravityy * _loc_7 - gravityx * _loc_8) * _loc_6.gravMass;
                    _loc_6.angvel = _loc_4 * _loc_6.angvel + _loc_9 * param1 * _loc_6.iinertia;
                }
                _loc_2 = _loc_5;
                _loc_5 = _loc_5.next;
            }
            return;
        }// end function

        public function updatePos(param1:Number) : void
        {
            var _loc_4:* = null as ZPP_Body;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZNPNode_ZPP_Shape;
            var _loc_12:* = null as ZPP_Shape;
            var _loc_13:* = null as ZPP_AABB;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = 0;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = null as ZPP_Circle;
            var _loc_25:* = null as ZPP_Polygon;
            var _loc_26:* = null as ZPP_Vec2;
            var _loc_27:* = null as ZPP_Vec2;
            var _loc_28:* = null as ZPP_Vec2;
            var _loc_29:* = null as ZPP_Vec2;
            var _loc_30:* = null as ZPP_Vec2;
            var _loc_31:* = null as ZPP_Vec2;
            var _loc_32:* = 0;
            var _loc_33:* = 0;
            var _loc_34:* = NaN;
            var _loc_2:* = 2 * Math.PI / param1;
            var _loc_3:* = live.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                _loc_4.pre_posx = _loc_4.posx;
                _loc_4.pre_posy = _loc_4.posy;
                _loc_4.pre_rot = _loc_4.rot;
                _loc_4.sweepTime = 0;
                _loc_4.sweep_angvel = _loc_4.angvel % _loc_2;
                _loc_5 = param1 - _loc_4.sweepTime;
                if (_loc_5 != 0)
                {
                    _loc_4.sweepTime = param1;
                    _loc_6 = _loc_5;
                    _loc_4.posx = _loc_4.posx + _loc_4.velx * _loc_6;
                    _loc_4.posy = _loc_4.posy + _loc_4.vely * _loc_6;
                    if (_loc_4.angvel != 0)
                    {
                        _loc_6 = _loc_4.sweep_angvel * _loc_5;
                        _loc_4.rot = _loc_4.rot + _loc_6;
                        if (_loc_6 * _loc_6 > 0.0001)
                        {
                            _loc_4.axisx = Math.sin(_loc_4.rot);
                            _loc_4.axisy = Math.cos(_loc_4.rot);
                        }
                        else
                        {
                            _loc_7 = _loc_6 * _loc_6;
                            _loc_8 = 1 - 0.5 * _loc_7;
                            _loc_9 = 1 - _loc_7 * _loc_7 / 8;
                            _loc_10 = (_loc_8 * _loc_4.axisx + _loc_6 * _loc_4.axisy) * _loc_9;
                            _loc_4.axisy = (_loc_8 * _loc_4.axisy - _loc_6 * _loc_4.axisx) * _loc_9;
                            _loc_4.axisx = _loc_10;
                        }
                    }
                }
                if (!_loc_4.disableCCD)
                {
                    _loc_5 = Config.staticCCDLinearThreshold * _loc_4.sweepRadius;
                    _loc_6 = Config.staticCCDAngularThreshold;
                    if ((_loc_4.velx * _loc_4.velx + _loc_4.vely * _loc_4.vely) * param1 * param1 <= _loc_5 * _loc_5)
                    {
                    }
                    if (_loc_4.angvel * _loc_4.angvel * param1 * param1 <= _loc_6 * _loc_6)
                    {
                    }
                    if (_loc_4.type == ZPP_Flags.id_BodyType_KINEMATIC)
                    {
                        _loc_7 = _loc_4.sweep_angvel;
                        if (_loc_7 < 0)
                        {
                            _loc_7 = -_loc_7;
                        }
                        _loc_8 = 1 / _loc_7;
                        _loc_11 = _loc_4.shapes.head;
                        while (_loc_11 != null)
                        {
                            
                            _loc_12 = _loc_11.elt;
                            _loc_13 = _loc_12.aabb;
                            _loc_9 = _loc_13.minx;
                            _loc_10 = _loc_13.miny;
                            _loc_14 = _loc_13.maxx;
                            _loc_15 = _loc_13.maxy;
                            _loc_16 = _loc_7 * param1 * _loc_12.sweepCoef * 0.00833333;
                            if (_loc_16 > 8)
                            {
                                _loc_16 = 8;
                            }
                            _loc_17 = _loc_7 * param1 / _loc_16;
                            _loc_18 = param1 - _loc_4.sweepTime;
                            if (_loc_18 != 0)
                            {
                                _loc_4.sweepTime = param1;
                                _loc_19 = _loc_18;
                                _loc_4.posx = _loc_4.posx + _loc_4.velx * _loc_19;
                                _loc_4.posy = _loc_4.posy + _loc_4.vely * _loc_19;
                                if (_loc_4.angvel != 0)
                                {
                                    _loc_19 = _loc_4.sweep_angvel * _loc_18;
                                    _loc_4.rot = _loc_4.rot + _loc_19;
                                    if (_loc_19 * _loc_19 > 0.0001)
                                    {
                                        _loc_4.axisx = Math.sin(_loc_4.rot);
                                        _loc_4.axisy = Math.cos(_loc_4.rot);
                                    }
                                    else
                                    {
                                        _loc_20 = _loc_19 * _loc_19;
                                        _loc_21 = 1 - 0.5 * _loc_20;
                                        _loc_22 = 1 - _loc_20 * _loc_20 / 8;
                                        _loc_23 = (_loc_21 * _loc_4.axisx + _loc_19 * _loc_4.axisy) * _loc_22;
                                        _loc_4.axisy = (_loc_21 * _loc_4.axisy - _loc_19 * _loc_4.axisx) * _loc_22;
                                        _loc_4.axisx = _loc_23;
                                    }
                                }
                            }
                            if (_loc_12.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_24 = _loc_12.circle;
                                _loc_24.worldCOMx = _loc_24.body.posx + (_loc_24.body.axisy * _loc_24.localCOMx - _loc_24.body.axisx * _loc_24.localCOMy);
                                _loc_24.worldCOMy = _loc_24.body.posy + (_loc_24.localCOMx * _loc_24.body.axisx + _loc_24.localCOMy * _loc_24.body.axisy);
                                _loc_24.aabb.minx = _loc_24.worldCOMx - _loc_24.radius;
                                _loc_24.aabb.miny = _loc_24.worldCOMy - _loc_24.radius;
                                _loc_24.aabb.maxx = _loc_24.worldCOMx + _loc_24.radius;
                                _loc_24.aabb.maxy = _loc_24.worldCOMy + _loc_24.radius;
                            }
                            else
                            {
                                _loc_25 = _loc_12.polygon;
                                _loc_26 = _loc_25.lverts.next;
                                _loc_27 = _loc_25.gverts.next;
                                _loc_28 = _loc_26;
                                _loc_26 = _loc_26.next;
                                _loc_27.x = _loc_25.body.posx + (_loc_25.body.axisy * _loc_28.x - _loc_25.body.axisx * _loc_28.y);
                                _loc_27.y = _loc_25.body.posy + (_loc_28.x * _loc_25.body.axisx + _loc_28.y * _loc_25.body.axisy);
                                _loc_25.aabb.minx = _loc_27.x;
                                _loc_25.aabb.miny = _loc_27.y;
                                _loc_25.aabb.maxx = _loc_27.x;
                                _loc_25.aabb.maxy = _loc_27.y;
                                _loc_29 = _loc_25.gverts.next.next;
                                while (_loc_29 != null)
                                {
                                    
                                    _loc_30 = _loc_29;
                                    _loc_31 = _loc_26;
                                    _loc_26 = _loc_26.next;
                                    _loc_30.x = _loc_25.body.posx + (_loc_25.body.axisy * _loc_31.x - _loc_25.body.axisx * _loc_31.y);
                                    _loc_30.y = _loc_25.body.posy + (_loc_31.x * _loc_25.body.axisx + _loc_31.y * _loc_25.body.axisy);
                                    if (_loc_30.x < _loc_25.aabb.minx)
                                    {
                                        _loc_25.aabb.minx = _loc_30.x;
                                    }
                                    if (_loc_30.x > _loc_25.aabb.maxx)
                                    {
                                        _loc_25.aabb.maxx = _loc_30.x;
                                    }
                                    if (_loc_30.y < _loc_25.aabb.miny)
                                    {
                                        _loc_25.aabb.miny = _loc_30.y;
                                    }
                                    if (_loc_30.y > _loc_25.aabb.maxy)
                                    {
                                        _loc_25.aabb.maxy = _loc_30.y;
                                    }
                                    _loc_29 = _loc_29.next;
                                }
                            }
                            if (_loc_9 < _loc_13.minx)
                            {
                                _loc_13.minx = _loc_9;
                            }
                            else
                            {
                                _loc_9 = _loc_13.minx;
                            }
                            if (_loc_10 < _loc_13.miny)
                            {
                                _loc_13.miny = _loc_10;
                            }
                            else
                            {
                                _loc_10 = _loc_13.miny;
                            }
                            if (_loc_14 > _loc_13.maxx)
                            {
                                _loc_13.maxx = _loc_14;
                            }
                            else
                            {
                                _loc_14 = _loc_13.maxx;
                            }
                            if (_loc_15 > _loc_13.maxy)
                            {
                                _loc_13.maxy = _loc_15;
                            }
                            else
                            {
                                _loc_15 = _loc_13.maxy;
                            }
                            _loc_32 = 1;
                            while (_loc_32 < _loc_16)
                            {
                                
                                _loc_32++;
                                _loc_33 = _loc_32;
                                _loc_18 = _loc_17 * _loc_33 * _loc_8;
                                _loc_19 = _loc_18 - _loc_4.sweepTime;
                                if (_loc_19 != 0)
                                {
                                    _loc_4.sweepTime = _loc_18;
                                    _loc_20 = _loc_19;
                                    _loc_4.posx = _loc_4.posx + _loc_4.velx * _loc_20;
                                    _loc_4.posy = _loc_4.posy + _loc_4.vely * _loc_20;
                                    if (_loc_4.angvel != 0)
                                    {
                                        _loc_20 = _loc_4.sweep_angvel * _loc_19;
                                        _loc_4.rot = _loc_4.rot + _loc_20;
                                        if (_loc_20 * _loc_20 > 0.0001)
                                        {
                                            _loc_4.axisx = Math.sin(_loc_4.rot);
                                            _loc_4.axisy = Math.cos(_loc_4.rot);
                                        }
                                        else
                                        {
                                            _loc_21 = _loc_20 * _loc_20;
                                            _loc_22 = 1 - 0.5 * _loc_21;
                                            _loc_23 = 1 - _loc_21 * _loc_21 / 8;
                                            _loc_34 = (_loc_22 * _loc_4.axisx + _loc_20 * _loc_4.axisy) * _loc_23;
                                            _loc_4.axisy = (_loc_22 * _loc_4.axisy - _loc_20 * _loc_4.axisx) * _loc_23;
                                            _loc_4.axisx = _loc_34;
                                        }
                                    }
                                }
                                if (_loc_12.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                {
                                    _loc_24 = _loc_12.circle;
                                    _loc_24.worldCOMx = _loc_24.body.posx + (_loc_24.body.axisy * _loc_24.localCOMx - _loc_24.body.axisx * _loc_24.localCOMy);
                                    _loc_24.worldCOMy = _loc_24.body.posy + (_loc_24.localCOMx * _loc_24.body.axisx + _loc_24.localCOMy * _loc_24.body.axisy);
                                    _loc_24.aabb.minx = _loc_24.worldCOMx - _loc_24.radius;
                                    _loc_24.aabb.miny = _loc_24.worldCOMy - _loc_24.radius;
                                    _loc_24.aabb.maxx = _loc_24.worldCOMx + _loc_24.radius;
                                    _loc_24.aabb.maxy = _loc_24.worldCOMy + _loc_24.radius;
                                }
                                else
                                {
                                    _loc_25 = _loc_12.polygon;
                                    _loc_26 = _loc_25.lverts.next;
                                    _loc_27 = _loc_25.gverts.next;
                                    _loc_28 = _loc_26;
                                    _loc_26 = _loc_26.next;
                                    _loc_27.x = _loc_25.body.posx + (_loc_25.body.axisy * _loc_28.x - _loc_25.body.axisx * _loc_28.y);
                                    _loc_27.y = _loc_25.body.posy + (_loc_28.x * _loc_25.body.axisx + _loc_28.y * _loc_25.body.axisy);
                                    _loc_25.aabb.minx = _loc_27.x;
                                    _loc_25.aabb.miny = _loc_27.y;
                                    _loc_25.aabb.maxx = _loc_27.x;
                                    _loc_25.aabb.maxy = _loc_27.y;
                                    _loc_29 = _loc_25.gverts.next.next;
                                    while (_loc_29 != null)
                                    {
                                        
                                        _loc_30 = _loc_29;
                                        _loc_31 = _loc_26;
                                        _loc_26 = _loc_26.next;
                                        _loc_30.x = _loc_25.body.posx + (_loc_25.body.axisy * _loc_31.x - _loc_25.body.axisx * _loc_31.y);
                                        _loc_30.y = _loc_25.body.posy + (_loc_31.x * _loc_25.body.axisx + _loc_31.y * _loc_25.body.axisy);
                                        if (_loc_30.x < _loc_25.aabb.minx)
                                        {
                                            _loc_25.aabb.minx = _loc_30.x;
                                        }
                                        if (_loc_30.x > _loc_25.aabb.maxx)
                                        {
                                            _loc_25.aabb.maxx = _loc_30.x;
                                        }
                                        if (_loc_30.y < _loc_25.aabb.miny)
                                        {
                                            _loc_25.aabb.miny = _loc_30.y;
                                        }
                                        if (_loc_30.y > _loc_25.aabb.maxy)
                                        {
                                            _loc_25.aabb.maxy = _loc_30.y;
                                        }
                                        _loc_29 = _loc_29.next;
                                    }
                                }
                                if (_loc_9 < _loc_13.minx)
                                {
                                    _loc_13.minx = _loc_9;
                                }
                                else
                                {
                                    _loc_9 = _loc_13.minx;
                                }
                                if (_loc_10 < _loc_13.miny)
                                {
                                    _loc_13.miny = _loc_10;
                                }
                                else
                                {
                                    _loc_10 = _loc_13.miny;
                                }
                                if (_loc_14 > _loc_13.maxx)
                                {
                                    _loc_13.maxx = _loc_14;
                                }
                                else
                                {
                                    _loc_14 = _loc_13.maxx;
                                }
                                if (_loc_15 > _loc_13.maxy)
                                {
                                    _loc_13.maxy = _loc_15;
                                    continue;
                                }
                                _loc_15 = _loc_13.maxy;
                            }
                            bphase.sync(_loc_12);
                            _loc_11 = _loc_11.next;
                        }
                        _loc_4.sweepFrozen = false;
                        if (_loc_4.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                        }
                        if (_loc_4.bulletEnabled)
                        {
                            _loc_9 = Config.bulletCCDLinearThreshold * _loc_4.sweepRadius;
                            _loc_10 = Config.bulletCCDAngularThreshold;
                            if ((_loc_4.velx * _loc_4.velx + _loc_4.vely * _loc_4.vely) * param1 * param1 <= _loc_9 * _loc_9)
                            {
                            }
                            if (_loc_4.angvel * _loc_4.angvel * param1 * param1 > _loc_10 * _loc_10)
                            {
                                _loc_4.bullet = true;
                            }
                        }
                    }
                    else
                    {
                        _loc_4.sweepFrozen = true;
                        _loc_4.bullet = false;
                    }
                }
                else
                {
                    _loc_4.sweepFrozen = true;
                    _loc_4.bullet = false;
                }
                _loc_3 = _loc_3.next;
            }
            _loc_3 = kinematics.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                _loc_4.pre_posx = _loc_4.posx;
                _loc_4.pre_posy = _loc_4.posy;
                _loc_4.pre_rot = _loc_4.rot;
                _loc_4.sweepTime = 0;
                _loc_4.sweep_angvel = _loc_4.angvel % _loc_2;
                _loc_5 = param1 - _loc_4.sweepTime;
                if (_loc_5 != 0)
                {
                    _loc_4.sweepTime = param1;
                    _loc_6 = _loc_5;
                    _loc_4.posx = _loc_4.posx + _loc_4.velx * _loc_6;
                    _loc_4.posy = _loc_4.posy + _loc_4.vely * _loc_6;
                    if (_loc_4.angvel != 0)
                    {
                        _loc_6 = _loc_4.sweep_angvel * _loc_5;
                        _loc_4.rot = _loc_4.rot + _loc_6;
                        if (_loc_6 * _loc_6 > 0.0001)
                        {
                            _loc_4.axisx = Math.sin(_loc_4.rot);
                            _loc_4.axisy = Math.cos(_loc_4.rot);
                        }
                        else
                        {
                            _loc_7 = _loc_6 * _loc_6;
                            _loc_8 = 1 - 0.5 * _loc_7;
                            _loc_9 = 1 - _loc_7 * _loc_7 / 8;
                            _loc_10 = (_loc_8 * _loc_4.axisx + _loc_6 * _loc_4.axisy) * _loc_9;
                            _loc_4.axisy = (_loc_8 * _loc_4.axisy - _loc_6 * _loc_4.axisx) * _loc_9;
                            _loc_4.axisx = _loc_10;
                        }
                    }
                }
                if (!_loc_4.disableCCD)
                {
                    _loc_5 = Config.staticCCDLinearThreshold * _loc_4.sweepRadius;
                    _loc_6 = Config.staticCCDAngularThreshold;
                    if ((_loc_4.velx * _loc_4.velx + _loc_4.vely * _loc_4.vely) * param1 * param1 <= _loc_5 * _loc_5)
                    {
                    }
                    if (_loc_4.angvel * _loc_4.angvel * param1 * param1 <= _loc_6 * _loc_6)
                    {
                    }
                    if (_loc_4.type == ZPP_Flags.id_BodyType_KINEMATIC)
                    {
                        _loc_7 = _loc_4.sweep_angvel;
                        if (_loc_7 < 0)
                        {
                            _loc_7 = -_loc_7;
                        }
                        _loc_8 = 1 / _loc_7;
                        _loc_11 = _loc_4.shapes.head;
                        while (_loc_11 != null)
                        {
                            
                            _loc_12 = _loc_11.elt;
                            _loc_13 = _loc_12.aabb;
                            _loc_9 = _loc_13.minx;
                            _loc_10 = _loc_13.miny;
                            _loc_14 = _loc_13.maxx;
                            _loc_15 = _loc_13.maxy;
                            _loc_16 = _loc_7 * param1 * _loc_12.sweepCoef * 0.00833333;
                            if (_loc_16 > 8)
                            {
                                _loc_16 = 8;
                            }
                            _loc_17 = _loc_7 * param1 / _loc_16;
                            _loc_18 = param1 - _loc_4.sweepTime;
                            if (_loc_18 != 0)
                            {
                                _loc_4.sweepTime = param1;
                                _loc_19 = _loc_18;
                                _loc_4.posx = _loc_4.posx + _loc_4.velx * _loc_19;
                                _loc_4.posy = _loc_4.posy + _loc_4.vely * _loc_19;
                                if (_loc_4.angvel != 0)
                                {
                                    _loc_19 = _loc_4.sweep_angvel * _loc_18;
                                    _loc_4.rot = _loc_4.rot + _loc_19;
                                    if (_loc_19 * _loc_19 > 0.0001)
                                    {
                                        _loc_4.axisx = Math.sin(_loc_4.rot);
                                        _loc_4.axisy = Math.cos(_loc_4.rot);
                                    }
                                    else
                                    {
                                        _loc_20 = _loc_19 * _loc_19;
                                        _loc_21 = 1 - 0.5 * _loc_20;
                                        _loc_22 = 1 - _loc_20 * _loc_20 / 8;
                                        _loc_23 = (_loc_21 * _loc_4.axisx + _loc_19 * _loc_4.axisy) * _loc_22;
                                        _loc_4.axisy = (_loc_21 * _loc_4.axisy - _loc_19 * _loc_4.axisx) * _loc_22;
                                        _loc_4.axisx = _loc_23;
                                    }
                                }
                            }
                            if (_loc_12.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_24 = _loc_12.circle;
                                _loc_24.worldCOMx = _loc_24.body.posx + (_loc_24.body.axisy * _loc_24.localCOMx - _loc_24.body.axisx * _loc_24.localCOMy);
                                _loc_24.worldCOMy = _loc_24.body.posy + (_loc_24.localCOMx * _loc_24.body.axisx + _loc_24.localCOMy * _loc_24.body.axisy);
                                _loc_24.aabb.minx = _loc_24.worldCOMx - _loc_24.radius;
                                _loc_24.aabb.miny = _loc_24.worldCOMy - _loc_24.radius;
                                _loc_24.aabb.maxx = _loc_24.worldCOMx + _loc_24.radius;
                                _loc_24.aabb.maxy = _loc_24.worldCOMy + _loc_24.radius;
                            }
                            else
                            {
                                _loc_25 = _loc_12.polygon;
                                _loc_26 = _loc_25.lverts.next;
                                _loc_27 = _loc_25.gverts.next;
                                _loc_28 = _loc_26;
                                _loc_26 = _loc_26.next;
                                _loc_27.x = _loc_25.body.posx + (_loc_25.body.axisy * _loc_28.x - _loc_25.body.axisx * _loc_28.y);
                                _loc_27.y = _loc_25.body.posy + (_loc_28.x * _loc_25.body.axisx + _loc_28.y * _loc_25.body.axisy);
                                _loc_25.aabb.minx = _loc_27.x;
                                _loc_25.aabb.miny = _loc_27.y;
                                _loc_25.aabb.maxx = _loc_27.x;
                                _loc_25.aabb.maxy = _loc_27.y;
                                _loc_29 = _loc_25.gverts.next.next;
                                while (_loc_29 != null)
                                {
                                    
                                    _loc_30 = _loc_29;
                                    _loc_31 = _loc_26;
                                    _loc_26 = _loc_26.next;
                                    _loc_30.x = _loc_25.body.posx + (_loc_25.body.axisy * _loc_31.x - _loc_25.body.axisx * _loc_31.y);
                                    _loc_30.y = _loc_25.body.posy + (_loc_31.x * _loc_25.body.axisx + _loc_31.y * _loc_25.body.axisy);
                                    if (_loc_30.x < _loc_25.aabb.minx)
                                    {
                                        _loc_25.aabb.minx = _loc_30.x;
                                    }
                                    if (_loc_30.x > _loc_25.aabb.maxx)
                                    {
                                        _loc_25.aabb.maxx = _loc_30.x;
                                    }
                                    if (_loc_30.y < _loc_25.aabb.miny)
                                    {
                                        _loc_25.aabb.miny = _loc_30.y;
                                    }
                                    if (_loc_30.y > _loc_25.aabb.maxy)
                                    {
                                        _loc_25.aabb.maxy = _loc_30.y;
                                    }
                                    _loc_29 = _loc_29.next;
                                }
                            }
                            if (_loc_9 < _loc_13.minx)
                            {
                                _loc_13.minx = _loc_9;
                            }
                            else
                            {
                                _loc_9 = _loc_13.minx;
                            }
                            if (_loc_10 < _loc_13.miny)
                            {
                                _loc_13.miny = _loc_10;
                            }
                            else
                            {
                                _loc_10 = _loc_13.miny;
                            }
                            if (_loc_14 > _loc_13.maxx)
                            {
                                _loc_13.maxx = _loc_14;
                            }
                            else
                            {
                                _loc_14 = _loc_13.maxx;
                            }
                            if (_loc_15 > _loc_13.maxy)
                            {
                                _loc_13.maxy = _loc_15;
                            }
                            else
                            {
                                _loc_15 = _loc_13.maxy;
                            }
                            _loc_32 = 1;
                            while (_loc_32 < _loc_16)
                            {
                                
                                _loc_32++;
                                _loc_33 = _loc_32;
                                _loc_18 = _loc_17 * _loc_33 * _loc_8;
                                _loc_19 = _loc_18 - _loc_4.sweepTime;
                                if (_loc_19 != 0)
                                {
                                    _loc_4.sweepTime = _loc_18;
                                    _loc_20 = _loc_19;
                                    _loc_4.posx = _loc_4.posx + _loc_4.velx * _loc_20;
                                    _loc_4.posy = _loc_4.posy + _loc_4.vely * _loc_20;
                                    if (_loc_4.angvel != 0)
                                    {
                                        _loc_20 = _loc_4.sweep_angvel * _loc_19;
                                        _loc_4.rot = _loc_4.rot + _loc_20;
                                        if (_loc_20 * _loc_20 > 0.0001)
                                        {
                                            _loc_4.axisx = Math.sin(_loc_4.rot);
                                            _loc_4.axisy = Math.cos(_loc_4.rot);
                                        }
                                        else
                                        {
                                            _loc_21 = _loc_20 * _loc_20;
                                            _loc_22 = 1 - 0.5 * _loc_21;
                                            _loc_23 = 1 - _loc_21 * _loc_21 / 8;
                                            _loc_34 = (_loc_22 * _loc_4.axisx + _loc_20 * _loc_4.axisy) * _loc_23;
                                            _loc_4.axisy = (_loc_22 * _loc_4.axisy - _loc_20 * _loc_4.axisx) * _loc_23;
                                            _loc_4.axisx = _loc_34;
                                        }
                                    }
                                }
                                if (_loc_12.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                {
                                    _loc_24 = _loc_12.circle;
                                    _loc_24.worldCOMx = _loc_24.body.posx + (_loc_24.body.axisy * _loc_24.localCOMx - _loc_24.body.axisx * _loc_24.localCOMy);
                                    _loc_24.worldCOMy = _loc_24.body.posy + (_loc_24.localCOMx * _loc_24.body.axisx + _loc_24.localCOMy * _loc_24.body.axisy);
                                    _loc_24.aabb.minx = _loc_24.worldCOMx - _loc_24.radius;
                                    _loc_24.aabb.miny = _loc_24.worldCOMy - _loc_24.radius;
                                    _loc_24.aabb.maxx = _loc_24.worldCOMx + _loc_24.radius;
                                    _loc_24.aabb.maxy = _loc_24.worldCOMy + _loc_24.radius;
                                }
                                else
                                {
                                    _loc_25 = _loc_12.polygon;
                                    _loc_26 = _loc_25.lverts.next;
                                    _loc_27 = _loc_25.gverts.next;
                                    _loc_28 = _loc_26;
                                    _loc_26 = _loc_26.next;
                                    _loc_27.x = _loc_25.body.posx + (_loc_25.body.axisy * _loc_28.x - _loc_25.body.axisx * _loc_28.y);
                                    _loc_27.y = _loc_25.body.posy + (_loc_28.x * _loc_25.body.axisx + _loc_28.y * _loc_25.body.axisy);
                                    _loc_25.aabb.minx = _loc_27.x;
                                    _loc_25.aabb.miny = _loc_27.y;
                                    _loc_25.aabb.maxx = _loc_27.x;
                                    _loc_25.aabb.maxy = _loc_27.y;
                                    _loc_29 = _loc_25.gverts.next.next;
                                    while (_loc_29 != null)
                                    {
                                        
                                        _loc_30 = _loc_29;
                                        _loc_31 = _loc_26;
                                        _loc_26 = _loc_26.next;
                                        _loc_30.x = _loc_25.body.posx + (_loc_25.body.axisy * _loc_31.x - _loc_25.body.axisx * _loc_31.y);
                                        _loc_30.y = _loc_25.body.posy + (_loc_31.x * _loc_25.body.axisx + _loc_31.y * _loc_25.body.axisy);
                                        if (_loc_30.x < _loc_25.aabb.minx)
                                        {
                                            _loc_25.aabb.minx = _loc_30.x;
                                        }
                                        if (_loc_30.x > _loc_25.aabb.maxx)
                                        {
                                            _loc_25.aabb.maxx = _loc_30.x;
                                        }
                                        if (_loc_30.y < _loc_25.aabb.miny)
                                        {
                                            _loc_25.aabb.miny = _loc_30.y;
                                        }
                                        if (_loc_30.y > _loc_25.aabb.maxy)
                                        {
                                            _loc_25.aabb.maxy = _loc_30.y;
                                        }
                                        _loc_29 = _loc_29.next;
                                    }
                                }
                                if (_loc_9 < _loc_13.minx)
                                {
                                    _loc_13.minx = _loc_9;
                                }
                                else
                                {
                                    _loc_9 = _loc_13.minx;
                                }
                                if (_loc_10 < _loc_13.miny)
                                {
                                    _loc_13.miny = _loc_10;
                                }
                                else
                                {
                                    _loc_10 = _loc_13.miny;
                                }
                                if (_loc_14 > _loc_13.maxx)
                                {
                                    _loc_13.maxx = _loc_14;
                                }
                                else
                                {
                                    _loc_14 = _loc_13.maxx;
                                }
                                if (_loc_15 > _loc_13.maxy)
                                {
                                    _loc_13.maxy = _loc_15;
                                    continue;
                                }
                                _loc_15 = _loc_13.maxy;
                            }
                            bphase.sync(_loc_12);
                            _loc_11 = _loc_11.next;
                        }
                        _loc_4.sweepFrozen = false;
                        if (_loc_4.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                        }
                        if (_loc_4.bulletEnabled)
                        {
                            _loc_9 = Config.bulletCCDLinearThreshold * _loc_4.sweepRadius;
                            _loc_10 = Config.bulletCCDAngularThreshold;
                            if ((_loc_4.velx * _loc_4.velx + _loc_4.vely * _loc_4.vely) * param1 * param1 <= _loc_9 * _loc_9)
                            {
                            }
                            if (_loc_4.angvel * _loc_4.angvel * param1 * param1 > _loc_10 * _loc_10)
                            {
                                _loc_4.bullet = true;
                            }
                        }
                    }
                    else
                    {
                        _loc_4.sweepFrozen = true;
                        _loc_4.bullet = false;
                    }
                }
                else
                {
                    _loc_4.sweepFrozen = true;
                    _loc_4.bullet = false;
                }
                _loc_3 = _loc_3.next;
            }
            return;
        }// end function

        public function unrevoke_listener(param1:ZPP_InteractionListener) : void
        {
            return;
        }// end function

        public function transmitType(param1:ZPP_Body, param2:int) : void
        {
            var _loc_3:* = param1;
            if (!_loc_3.world)
            {
                _loc_3.component.waket = stamp + (midstep ? (0) : (1));
                if (_loc_3.type == ZPP_Flags.id_BodyType_KINEMATIC)
                {
                    _loc_3.kinematicDelaySleep = true;
                }
                if (_loc_3.component.sleeping)
                {
                    really_wake(_loc_3, false);
                }
            }
            if (param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                live.remove(param1);
            }
            else if (param1.type == ZPP_Flags.id_BodyType_KINEMATIC)
            {
                kinematics.remove(param1);
                staticsleep.remove(param1);
            }
            else if (param1.type == ZPP_Flags.id_BodyType_STATIC)
            {
                staticsleep.remove(param1);
            }
            param1.type = param2;
            if (param1.type == ZPP_Flags.id_BodyType_KINEMATIC)
            {
                kinematics.add(param1);
            }
            if (param1.type == ZPP_Flags.id_BodyType_STATIC)
            {
                static_validation(param1);
            }
            param1.component.sleeping = true;
            _loc_3 = param1;
            if (!_loc_3.world)
            {
                _loc_3.component.waket = stamp + (midstep ? (0) : (1));
                if (_loc_3.type == ZPP_Flags.id_BodyType_KINEMATIC)
                {
                    _loc_3.kinematicDelaySleep = true;
                }
                if (_loc_3.component.sleeping)
                {
                    really_wake(_loc_3, true);
                }
            }
            return;
        }// end function

        public function step(param1:Number, param2:int, param3:int) : void
        {
            var _loc_5:* = null as ZNPList_ZPP_ColArbiter;
            var _loc_6:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_7:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_8:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_9:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_10:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_16:* = null as ZPP_Body;
            var _loc_17:* = false;
            var _loc_18:* = false;
            var _loc_19:* = null as ZNPNode_ZPP_Shape;
            var _loc_20:* = null as ZPP_Shape;
            var _loc_22:* = null as ZNPList_ZPP_Body;
            var _loc_23:* = null as ZNPNode_ZPP_Body;
            var _loc_24:* = null as ZNPNode_ZPP_Body;
            var _loc_25:* = null as ZNPNode_ZPP_Body;
            var _loc_28:* = null as ZPP_CallbackSet;
            var _loc_29:* = null as ZPP_CallbackSet;
            var _loc_30:* = null as ZPP_CallbackSet;
            var _loc_31:* = null as ZPP_CallbackSet;
            var _loc_32:* = null as String;
            var _loc_33:* = null as ZPP_Interactor;
            var _loc_34:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_35:* = null as ZPP_Arbiter;
            var _loc_36:* = null as ZPP_CbSet;
            var _loc_37:* = null as ZPP_CbSet;
            var _loc_38:* = null as ZPP_CbSetPair;
            var _loc_39:* = null as ZPP_CbSetPair;
            var _loc_40:* = null as ZNPList_ZPP_CbSetPair;
            var _loc_41:* = null as ZNPNode_ZPP_CbSetPair;
            var _loc_42:* = null as ZPP_CbSetPair;
            var _loc_43:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_44:* = null as ZPP_InteractionListener;
            var _loc_45:* = null as ZPP_Callback;
            var _loc_46:* = null as ZPP_Interactor;
            var _loc_47:* = null as ZPP_OptionType;
            var _loc_48:* = null as ZNPList_ZPP_CbType;
            var _loc_49:* = null as ZPP_BodyListener;
            var _loc_50:* = null as ZPP_ConstraintListener;
            var _loc_51:* = null as ZPP_Callback;
            var _loc_4:* = this;
            if (midstep)
            {
                throw "Error: ... REALLY?? you\'re going to call space.step() inside of space.step()? COME ON!!";
            }
            time = time + param1;
            pre_dt = param1;
            midstep = true;
            (stamp + 1);
            validation();
            bphase.broadphase(this, true);
            prestep(param1);
            if (sortcontacts)
            {
                _loc_5 = c_arbiters_false;
                if (_loc_5.head != null)
                {
                }
                if (_loc_5.head.next != null)
                {
                    _loc_6 = _loc_5.head;
                    _loc_7 = null;
                    _loc_8 = null;
                    _loc_9 = null;
                    _loc_10 = null;
                    _loc_11 = 1;
                    do
                    {
                        
                        _loc_12 = 0;
                        _loc_8 = _loc_6;
                        _loc_6 = null;
                        _loc_7 = _loc_6;
                        while (_loc_8 != null)
                        {
                            
                            _loc_12++;
                            _loc_9 = _loc_8;
                            _loc_13 = 0;
                            _loc_14 = _loc_11;
                            do
                            {
                                
                                _loc_13++;
                                _loc_9 = _loc_9.next;
                                if (_loc_9 != null)
                                {
                                }
                            }while (_loc_13 < _loc_11)
                            do
                            {
                                
                                if (_loc_13 == 0)
                                {
                                    _loc_10 = _loc_9;
                                    _loc_9 = _loc_9.next;
                                    _loc_14--;
                                }
                                else
                                {
                                    if (_loc_14 != 0)
                                    {
                                    }
                                    if (_loc_9 == null)
                                    {
                                        _loc_10 = _loc_8;
                                        _loc_8 = _loc_8.next;
                                        _loc_13--;
                                    }
                                    else
                                    {
                                        if (_loc_8.elt.active)
                                        {
                                        }
                                        if (_loc_9.elt.active ? (_loc_8.elt.oc1.dist < _loc_9.elt.oc1.dist) : (true))
                                        {
                                            _loc_10 = _loc_8;
                                            _loc_8 = _loc_8.next;
                                            _loc_13--;
                                        }
                                        else
                                        {
                                            _loc_10 = _loc_9;
                                            _loc_9 = _loc_9.next;
                                            _loc_14--;
                                        }
                                    }
                                }
                                if (_loc_7 != null)
                                {
                                    _loc_7.next = _loc_10;
                                }
                                else
                                {
                                    _loc_6 = _loc_10;
                                }
                                _loc_7 = _loc_10;
                                if (_loc_13 <= 0)
                                {
                                    if (_loc_14 > 0)
                                    {
                                    }
                                }
                            }while (_loc_9 != null)
                            _loc_8 = _loc_9;
                        }
                        _loc_7.next = null;
                        _loc_11 = _loc_11 << 1;
                    }while (_loc_12 > 1)
                    _loc_5.head = _loc_6;
                    _loc_5.modified = true;
                    _loc_5.pushmod = true;
                }
            }
            updateVel(param1);
            warmStart();
            iterateVel(param2);
            var _loc_15:* = kinematics.head;
            while (_loc_15 != null)
            {
                
                _loc_16 = _loc_15.elt;
                _loc_16.pre_posx = _loc_16.posx;
                _loc_16.pre_posy = _loc_16.posy;
                _loc_16.pre_rot = _loc_16.rot;
                _loc_15 = _loc_15.next;
            }
            _loc_15 = live.head;
            while (_loc_15 != null)
            {
                
                _loc_16 = _loc_15.elt;
                _loc_16.pre_posx = _loc_16.posx;
                _loc_16.pre_posy = _loc_16.posy;
                _loc_16.pre_rot = _loc_16.rot;
                _loc_15 = _loc_15.next;
            }
            updatePos(param1);
            continuous = true;
            continuousCollisions(param1);
            continuous = false;
            iteratePos(param3);
            _loc_15 = kinematics.head;
            while (_loc_15 != null)
            {
                
                _loc_16 = _loc_15.elt;
                if (_loc_16.posx == _loc_16.pre_posx)
                {
                }
                _loc_17 = _loc_16.posy != _loc_16.pre_posy;
                _loc_18 = _loc_16.pre_rot != _loc_16.rot;
                if (_loc_17)
                {
                    _loc_19 = _loc_16.shapes.head;
                    while (_loc_19 != null)
                    {
                        
                        _loc_20 = _loc_19.elt;
                        if (_loc_20.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_20.polygon.invalidate_gverts();
                            _loc_20.polygon.invalidate_gaxi();
                        }
                        _loc_20.invalidate_worldCOM();
                        _loc_19 = _loc_19.next;
                    }
                    _loc_16.zip_worldCOM = true;
                }
                if (_loc_18)
                {
                    _loc_16.zip_axis = true;
                    _loc_19 = _loc_16.shapes.head;
                    while (_loc_19 != null)
                    {
                        
                        _loc_20 = _loc_19.elt;
                        if (_loc_20.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_20.polygon.invalidate_gverts();
                            _loc_20.polygon.invalidate_gaxi();
                        }
                        _loc_20.invalidate_worldCOM();
                        _loc_19 = _loc_19.next;
                    }
                    _loc_16.zip_worldCOM = true;
                }
                _loc_15 = _loc_15.next;
            }
            _loc_15 = live.head;
            while (_loc_15 != null)
            {
                
                _loc_16 = _loc_15.elt;
                if (_loc_16.posx == _loc_16.pre_posx)
                {
                }
                _loc_17 = _loc_16.posy != _loc_16.pre_posy;
                _loc_18 = _loc_16.pre_rot != _loc_16.rot;
                if (_loc_17)
                {
                    _loc_19 = _loc_16.shapes.head;
                    while (_loc_19 != null)
                    {
                        
                        _loc_20 = _loc_19.elt;
                        if (_loc_20.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_20.polygon.invalidate_gverts();
                            _loc_20.polygon.invalidate_gaxi();
                        }
                        _loc_20.invalidate_worldCOM();
                        _loc_19 = _loc_19.next;
                    }
                    _loc_16.zip_worldCOM = true;
                }
                if (_loc_18)
                {
                    _loc_16.zip_axis = true;
                    _loc_19 = _loc_16.shapes.head;
                    while (_loc_19 != null)
                    {
                        
                        _loc_20 = _loc_19.elt;
                        if (_loc_20.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_20.polygon.invalidate_gverts();
                            _loc_20.polygon.invalidate_gaxi();
                        }
                        _loc_20.invalidate_worldCOM();
                        _loc_19 = _loc_19.next;
                    }
                    _loc_16.zip_worldCOM = true;
                }
                _loc_15 = _loc_15.next;
            }
            _loc_15 = null;
            var _loc_21:* = staticsleep.head;
            while (_loc_21 != null)
            {
                
                _loc_16 = _loc_21.elt;
                if (_loc_16.type == ZPP_Flags.id_BodyType_KINEMATIC)
                {
                    if (_loc_16.velx == 0)
                    {
                    }
                    if (_loc_16.vely == 0)
                    {
                    }
                }
                if (_loc_16.angvel == 0)
                {
                    if (_loc_16.kinematicDelaySleep)
                    {
                        _loc_16.kinematicDelaySleep = false;
                        _loc_21 = _loc_21.next;
                        continue;
                    }
                    _loc_16.component.sleeping = true;
                    _loc_22 = staticsleep;
                    if (_loc_15 == null)
                    {
                        _loc_23 = _loc_22.head;
                        _loc_24 = _loc_23.next;
                        _loc_22.head = _loc_24;
                        if (_loc_22.head == null)
                        {
                            _loc_22.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_23 = _loc_15.next;
                        _loc_24 = _loc_23.next;
                        _loc_15.next = _loc_24;
                        if (_loc_24 == null)
                        {
                            _loc_22.pushmod = true;
                        }
                    }
                    _loc_25 = _loc_23;
                    _loc_25.elt = null;
                    _loc_25.next = ZNPNode_ZPP_Body.zpp_pool;
                    ZNPNode_ZPP_Body.zpp_pool = _loc_25;
                    _loc_22.modified = true;
                    (_loc_22.length - 1);
                    _loc_22.pushmod = true;
                    _loc_21 = _loc_24;
                    continue;
                }
                _loc_15 = _loc_21;
                _loc_21 = _loc_21.next;
            }
            doForests(param1);
            sleepArbiters();
            midstep = false;
            var _loc_26:* = null;
            var _loc_27:* = callbackset_list.next;
            while (_loc_27 != null)
            {
                
                _loc_28 = _loc_27;
                if (_loc_28.arbiters.head == null)
                {
                    _loc_29 = callbackset_list;
                    if (_loc_26 == null)
                    {
                        _loc_30 = _loc_29.next;
                        _loc_31 = _loc_30.next;
                        _loc_29.next = _loc_31;
                        if (_loc_29.next == null)
                        {
                            _loc_29.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_30 = _loc_26.next;
                        _loc_31 = _loc_30.next;
                        _loc_26.next = _loc_31;
                        if (_loc_31 == null)
                        {
                            _loc_29.pushmod = true;
                        }
                    }
                    _loc_30._inuse = false;
                    _loc_29.modified = true;
                    (_loc_29.length - 1);
                    _loc_29.pushmod = true;
                    _loc_27 = _loc_31;
                    _loc_32 = _loc_28.int1.id + " " + _loc_28.int2.id;
                    _loc_29 = _loc_28;
                    _loc_33 = null;
                    _loc_29.int2 = _loc_33;
                    _loc_29.int1 = _loc_33;
                    _loc_11 = -1;
                    _loc_29.di = _loc_11;
                    _loc_29.id = _loc_11;
                    _loc_29.freed = true;
                    _loc_29.next = ZPP_CallbackSet.zpp_pool;
                    ZPP_CallbackSet.zpp_pool = _loc_29;
                    continue;
                }
                _loc_18 = true;
                _loc_34 = _loc_28.arbiters.head;
                while (_loc_34 != null)
                {
                    
                    _loc_35 = _loc_34.elt;
                    if (_loc_35.sleeping)
                    {
                        _loc_34 = _loc_34.next;
                        continue;
                    }
                    else
                    {
                        _loc_18 = false;
                        break;
                    }
                    _loc_34 = _loc_34.next;
                }
                _loc_17 = _loc_18;
                _loc_36 = _loc_28.int1.cbSet;
                _loc_37 = _loc_28.int2.cbSet;
                _loc_11 = ZPP_Flags.id_CbEvent_ONGOING;
                _loc_39 = null;
                if (_loc_36.cbpairs.length < _loc_37.cbpairs.length)
                {
                    _loc_40 = _loc_36.cbpairs;
                }
                else
                {
                    _loc_40 = _loc_37.cbpairs;
                }
                _loc_41 = _loc_40.head;
                while (_loc_41 != null)
                {
                    
                    _loc_42 = _loc_41.elt;
                    if (_loc_42.a == _loc_36)
                    {
                    }
                    if (_loc_42.b != _loc_37)
                    {
                        if (_loc_42.a == _loc_37)
                        {
                        }
                    }
                    if (_loc_42.b == _loc_36)
                    {
                        _loc_39 = _loc_42;
                        break;
                    }
                    _loc_41 = _loc_41.next;
                }
                if (_loc_39 == null)
                {
                    if (ZPP_CbSetPair.zpp_pool == null)
                    {
                        _loc_42 = new ZPP_CbSetPair();
                    }
                    else
                    {
                        _loc_42 = ZPP_CbSetPair.zpp_pool;
                        ZPP_CbSetPair.zpp_pool = _loc_42.next;
                        _loc_42.next = null;
                    }
                    _loc_42.zip_listeners = true;
                    if (ZPP_CbSet.setlt(_loc_36, _loc_37))
                    {
                        _loc_42.a = _loc_36;
                        _loc_42.b = _loc_37;
                    }
                    else
                    {
                        _loc_42.a = _loc_37;
                        _loc_42.b = _loc_36;
                    }
                    _loc_39 = _loc_42;
                    _loc_36.cbpairs.add(_loc_39);
                    if (_loc_37 != _loc_36)
                    {
                        _loc_37.cbpairs.add(_loc_39);
                    }
                }
                if (_loc_39.zip_listeners)
                {
                    _loc_39.zip_listeners = false;
                    _loc_39.__validate();
                }
                _loc_38 = _loc_39;
                _loc_43 = _loc_38.listeners.head;
                while (_loc_43 != null)
                {
                    
                    _loc_44 = _loc_43.elt;
                    if (_loc_44.event == _loc_11)
                    {
                        if (_loc_17)
                        {
                        }
                        if (_loc_44.allowSleepingCallbacks)
                        {
                        }
                        if (!_loc_28.empty_arb(_loc_44.itype))
                        {
                            _loc_45 = _loc_4.push_callback(_loc_44);
                            _loc_45.event = ZPP_Flags.id_CbEvent_ONGOING;
                            _loc_33 = _loc_28.int1;
                            _loc_46 = _loc_28.int2;
                            _loc_47 = _loc_44.options1;
                            _loc_48 = _loc_33.cbTypes;
                            if (_loc_47.nonemptyintersection(_loc_48, _loc_47.includes))
                            {
                            }
                            if (!_loc_47.nonemptyintersection(_loc_48, _loc_47.excludes))
                            {
                                _loc_47 = _loc_44.options2;
                                _loc_48 = _loc_46.cbTypes;
                                if (_loc_47.nonemptyintersection(_loc_48, _loc_47.includes))
                                {
                                }
                            }
                            if (!_loc_47.nonemptyintersection(_loc_48, _loc_47.excludes))
                            {
                                _loc_45.int1 = _loc_33;
                                _loc_45.int2 = _loc_46;
                            }
                            else
                            {
                                _loc_45.int1 = _loc_46;
                                _loc_45.int2 = _loc_33;
                            }
                            _loc_45.set = _loc_28;
                        }
                    }
                    _loc_43 = _loc_43.next;
                }
                _loc_26 = _loc_27;
                _loc_27 = _loc_27.next;
            }
            while (!callbacks.empty())
            {
                
                _loc_45 = callbacks.pop();
                if (_loc_45.listener.type == ZPP_Flags.id_ListenerType_BODY)
                {
                    _loc_49 = _loc_45.listener.body;
                    _loc_49.handler(_loc_45.wrapper_body());
                }
                else if (_loc_45.listener.type == ZPP_Flags.id_ListenerType_CONSTRAINT)
                {
                    _loc_50 = _loc_45.listener.constraint;
                    _loc_50.handler(_loc_45.wrapper_con());
                }
                else if (_loc_45.listener.type == ZPP_Flags.id_ListenerType_INTERACTION)
                {
                    _loc_44 = _loc_45.listener.interaction;
                    _loc_44.handleri(_loc_45.wrapper_int());
                }
                _loc_51 = _loc_45;
                _loc_33 = null;
                _loc_51.int2 = _loc_33;
                _loc_51.int1 = _loc_33;
                _loc_51.body = null;
                _loc_51.constraint = null;
                _loc_51.listener = null;
                if (_loc_51.wrap_arbiters != null)
                {
                    _loc_51.wrap_arbiters.zpp_inner.inner = null;
                }
                _loc_51.set = null;
                _loc_51.next = ZPP_Callback.zpp_pool;
                ZPP_Callback.zpp_pool = _loc_51;
            }
            return;
        }// end function

        public function static_validation(param1:ZPP_Body) : void
        {
            var _loc_2:* = null as ZNPNode_ZPP_Shape;
            var _loc_3:* = null as ZPP_Shape;
            var _loc_4:* = null as ZPP_Circle;
            var _loc_5:* = null as ZPP_Polygon;
            var _loc_6:* = NaN;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = NaN;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_13:* = null as ZPP_Body;
            var _loc_14:* = null as ZPP_AABB;
            var _loc_15:* = null as ZPP_AABB;
            var _loc_16:* = null as ValidationResult;
            var _loc_17:* = null as ZNPNode_ZPP_Edge;
            var _loc_18:* = null as ZPP_Edge;
            if (param1.shapes.head != null)
            {
                if (param1.shapes.head == null)
                {
                    throw "Error: Body bounds only makes sense if it contains shapes";
                }
                if (param1.zip_aabb)
                {
                    param1.zip_aabb = false;
                    param1.aabb.minx = 17899999999999994000000000000;
                    param1.aabb.miny = 17899999999999994000000000000;
                    param1.aabb.maxx = -17899999999999994000000000000;
                    param1.aabb.maxy = -17899999999999994000000000000;
                    _loc_2 = param1.shapes.head;
                    while (_loc_2 != null)
                    {
                        
                        _loc_3 = _loc_2.elt;
                        if (_loc_3.zip_aabb)
                        {
                            if (_loc_3.body != null)
                            {
                                _loc_3.zip_aabb = false;
                                if (_loc_3.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                {
                                    _loc_4 = _loc_3.circle;
                                    if (_loc_4.zip_worldCOM)
                                    {
                                        if (_loc_4.body != null)
                                        {
                                            _loc_4.zip_worldCOM = false;
                                            if (_loc_4.zip_localCOM)
                                            {
                                                _loc_4.zip_localCOM = false;
                                                if (_loc_4.type == ZPP_Flags.id_ShapeType_POLYGON)
                                                {
                                                    _loc_5 = _loc_4.polygon;
                                                    if (_loc_5.lverts.next == null)
                                                    {
                                                        throw "Error: An empty polygon has no meaningful localCOM";
                                                    }
                                                    if (_loc_5.lverts.next.next == null)
                                                    {
                                                        _loc_5.localCOMx = _loc_5.lverts.next.x;
                                                        _loc_5.localCOMy = _loc_5.lverts.next.y;
                                                    }
                                                    else if (_loc_5.lverts.next.next.next == null)
                                                    {
                                                        _loc_5.localCOMx = _loc_5.lverts.next.x;
                                                        _loc_5.localCOMy = _loc_5.lverts.next.y;
                                                        _loc_6 = 1;
                                                        _loc_5.localCOMx = _loc_5.localCOMx + _loc_5.lverts.next.next.x * _loc_6;
                                                        _loc_5.localCOMy = _loc_5.localCOMy + _loc_5.lverts.next.next.y * _loc_6;
                                                        _loc_6 = 0.5;
                                                        _loc_5.localCOMx = _loc_5.localCOMx * _loc_6;
                                                        _loc_5.localCOMy = _loc_5.localCOMy * _loc_6;
                                                    }
                                                    else
                                                    {
                                                        _loc_5.localCOMx = 0;
                                                        _loc_5.localCOMy = 0;
                                                        _loc_6 = 0;
                                                        _loc_7 = _loc_5.lverts.next;
                                                        _loc_8 = _loc_7;
                                                        _loc_7 = _loc_7.next;
                                                        _loc_9 = _loc_7;
                                                        _loc_7 = _loc_7.next;
                                                        while (_loc_7 != null)
                                                        {
                                                            
                                                            _loc_10 = _loc_7;
                                                            _loc_6 = _loc_6 + _loc_9.x * (_loc_10.y - _loc_8.y);
                                                            _loc_11 = _loc_10.y * _loc_9.x - _loc_10.x * _loc_9.y;
                                                            _loc_5.localCOMx = _loc_5.localCOMx + (_loc_9.x + _loc_10.x) * _loc_11;
                                                            _loc_5.localCOMy = _loc_5.localCOMy + (_loc_9.y + _loc_10.y) * _loc_11;
                                                            _loc_8 = _loc_9;
                                                            _loc_9 = _loc_10;
                                                            _loc_7 = _loc_7.next;
                                                        }
                                                        _loc_7 = _loc_5.lverts.next;
                                                        _loc_10 = _loc_7;
                                                        _loc_6 = _loc_6 + _loc_9.x * (_loc_10.y - _loc_8.y);
                                                        _loc_11 = _loc_10.y * _loc_9.x - _loc_10.x * _loc_9.y;
                                                        _loc_5.localCOMx = _loc_5.localCOMx + (_loc_9.x + _loc_10.x) * _loc_11;
                                                        _loc_5.localCOMy = _loc_5.localCOMy + (_loc_9.y + _loc_10.y) * _loc_11;
                                                        _loc_8 = _loc_9;
                                                        _loc_9 = _loc_10;
                                                        _loc_7 = _loc_7.next;
                                                        _loc_12 = _loc_7;
                                                        _loc_6 = _loc_6 + _loc_9.x * (_loc_12.y - _loc_8.y);
                                                        _loc_11 = _loc_12.y * _loc_9.x - _loc_12.x * _loc_9.y;
                                                        _loc_5.localCOMx = _loc_5.localCOMx + (_loc_9.x + _loc_12.x) * _loc_11;
                                                        _loc_5.localCOMy = _loc_5.localCOMy + (_loc_9.y + _loc_12.y) * _loc_11;
                                                        _loc_6 = 1 / (3 * _loc_6);
                                                        _loc_11 = _loc_6;
                                                        _loc_5.localCOMx = _loc_5.localCOMx * _loc_11;
                                                        _loc_5.localCOMy = _loc_5.localCOMy * _loc_11;
                                                    }
                                                }
                                                if (_loc_4.wrap_localCOM != null)
                                                {
                                                    _loc_4.wrap_localCOM.zpp_inner.x = _loc_4.localCOMx;
                                                    _loc_4.wrap_localCOM.zpp_inner.y = _loc_4.localCOMy;
                                                }
                                            }
                                            _loc_13 = _loc_4.body;
                                            if (_loc_13.zip_axis)
                                            {
                                                _loc_13.zip_axis = false;
                                                _loc_13.axisx = Math.sin(_loc_13.rot);
                                                _loc_13.axisy = Math.cos(_loc_13.rot);
                                            }
                                            _loc_4.worldCOMx = _loc_4.body.posx + (_loc_4.body.axisy * _loc_4.localCOMx - _loc_4.body.axisx * _loc_4.localCOMy);
                                            _loc_4.worldCOMy = _loc_4.body.posy + (_loc_4.localCOMx * _loc_4.body.axisx + _loc_4.localCOMy * _loc_4.body.axisy);
                                        }
                                    }
                                    _loc_6 = _loc_4.radius;
                                    _loc_11 = _loc_4.radius;
                                    _loc_4.aabb.minx = _loc_4.worldCOMx - _loc_6;
                                    _loc_4.aabb.miny = _loc_4.worldCOMy - _loc_11;
                                    _loc_4.aabb.maxx = _loc_4.worldCOMx + _loc_6;
                                    _loc_4.aabb.maxy = _loc_4.worldCOMy + _loc_11;
                                }
                                else
                                {
                                    _loc_5 = _loc_3.polygon;
                                    if (_loc_5.zip_gverts)
                                    {
                                        if (_loc_5.body != null)
                                        {
                                            _loc_5.zip_gverts = false;
                                            _loc_5.validate_lverts();
                                            _loc_13 = _loc_5.body;
                                            if (_loc_13.zip_axis)
                                            {
                                                _loc_13.zip_axis = false;
                                                _loc_13.axisx = Math.sin(_loc_13.rot);
                                                _loc_13.axisy = Math.cos(_loc_13.rot);
                                            }
                                            _loc_7 = _loc_5.lverts.next;
                                            _loc_8 = _loc_5.gverts.next;
                                            while (_loc_8 != null)
                                            {
                                                
                                                _loc_9 = _loc_8;
                                                _loc_10 = _loc_7;
                                                _loc_7 = _loc_7.next;
                                                _loc_9.x = _loc_5.body.posx + (_loc_5.body.axisy * _loc_10.x - _loc_5.body.axisx * _loc_10.y);
                                                _loc_9.y = _loc_5.body.posy + (_loc_10.x * _loc_5.body.axisx + _loc_10.y * _loc_5.body.axisy);
                                                _loc_8 = _loc_8.next;
                                            }
                                        }
                                    }
                                    if (_loc_5.lverts.next == null)
                                    {
                                        throw "Error: An empty polygon has no meaningful bounds";
                                    }
                                    _loc_7 = _loc_5.gverts.next;
                                    _loc_5.aabb.minx = _loc_7.x;
                                    _loc_5.aabb.miny = _loc_7.y;
                                    _loc_5.aabb.maxx = _loc_7.x;
                                    _loc_5.aabb.maxy = _loc_7.y;
                                    _loc_8 = _loc_5.gverts.next.next;
                                    while (_loc_8 != null)
                                    {
                                        
                                        _loc_9 = _loc_8;
                                        if (_loc_9.x < _loc_5.aabb.minx)
                                        {
                                            _loc_5.aabb.minx = _loc_9.x;
                                        }
                                        if (_loc_9.x > _loc_5.aabb.maxx)
                                        {
                                            _loc_5.aabb.maxx = _loc_9.x;
                                        }
                                        if (_loc_9.y < _loc_5.aabb.miny)
                                        {
                                            _loc_5.aabb.miny = _loc_9.y;
                                        }
                                        if (_loc_9.y > _loc_5.aabb.maxy)
                                        {
                                            _loc_5.aabb.maxy = _loc_9.y;
                                        }
                                        _loc_8 = _loc_8.next;
                                    }
                                }
                            }
                        }
                        _loc_14 = param1.aabb;
                        _loc_15 = _loc_3.aabb;
                        if (_loc_15.minx < _loc_14.minx)
                        {
                            _loc_14.minx = _loc_15.minx;
                        }
                        if (_loc_15.maxx > _loc_14.maxx)
                        {
                            _loc_14.maxx = _loc_15.maxx;
                        }
                        if (_loc_15.miny < _loc_14.miny)
                        {
                            _loc_14.miny = _loc_15.miny;
                        }
                        if (_loc_15.maxy > _loc_14.maxy)
                        {
                            _loc_14.maxy = _loc_15.maxy;
                        }
                        _loc_2 = _loc_2.next;
                    }
                }
            }
            param1.validate_mass();
            param1.validate_inertia();
            if (param1.velx == 0)
            {
            }
            if (param1.vely == 0)
            {
            }
            if (param1.angvel != 0)
            {
                throw "Error: Static body cannot have any real velocity, only kinematic or surface velocities";
            }
            _loc_2 = param1.shapes.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                if (_loc_3.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_5 = _loc_3.polygon;
                    if (_loc_5.zip_sanitation)
                    {
                        _loc_5.zip_sanitation = false;
                        _loc_5.splice_collinear_real();
                    }
                    _loc_16 = _loc_3.polygon.valid();
                    if (ZPP_Flags.ValidationResult_VALID == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                        ZPP_Flags.internal = false;
                    }
                    if (_loc_16 != ZPP_Flags.ValidationResult_VALID)
                    {
                        throw "Error: Cannot simulate with an invalid Polygon : " + _loc_3.polygon.outer.toString() + " is invalid : " + _loc_16.toString();
                    }
                    _loc_5 = _loc_3.polygon;
                    if (_loc_5.zip_gaxi)
                    {
                        if (_loc_5.body != null)
                        {
                            _loc_5.zip_gaxi = false;
                            _loc_5.validate_laxi();
                            _loc_13 = _loc_5.body;
                            if (_loc_13.zip_axis)
                            {
                                _loc_13.zip_axis = false;
                                _loc_13.axisx = Math.sin(_loc_13.rot);
                                _loc_13.axisy = Math.cos(_loc_13.rot);
                            }
                            if (_loc_5.zip_gverts)
                            {
                                if (_loc_5.body != null)
                                {
                                    _loc_5.zip_gverts = false;
                                    _loc_5.validate_lverts();
                                    _loc_13 = _loc_5.body;
                                    if (_loc_13.zip_axis)
                                    {
                                        _loc_13.zip_axis = false;
                                        _loc_13.axisx = Math.sin(_loc_13.rot);
                                        _loc_13.axisy = Math.cos(_loc_13.rot);
                                    }
                                    _loc_7 = _loc_5.lverts.next;
                                    _loc_8 = _loc_5.gverts.next;
                                    while (_loc_8 != null)
                                    {
                                        
                                        _loc_9 = _loc_8;
                                        _loc_10 = _loc_7;
                                        _loc_7 = _loc_7.next;
                                        _loc_9.x = _loc_5.body.posx + (_loc_5.body.axisy * _loc_10.x - _loc_5.body.axisx * _loc_10.y);
                                        _loc_9.y = _loc_5.body.posy + (_loc_10.x * _loc_5.body.axisx + _loc_10.y * _loc_5.body.axisy);
                                        _loc_8 = _loc_8.next;
                                    }
                                }
                            }
                            _loc_17 = _loc_5.edges.head;
                            _loc_7 = _loc_5.gverts.next;
                            _loc_8 = _loc_7;
                            _loc_7 = _loc_7.next;
                            while (_loc_7 != null)
                            {
                                
                                _loc_9 = _loc_7;
                                _loc_18 = _loc_17.elt;
                                _loc_17 = _loc_17.next;
                                _loc_18.gp0 = _loc_8;
                                _loc_18.gp1 = _loc_9;
                                _loc_18.gnormx = _loc_5.body.axisy * _loc_18.lnormx - _loc_5.body.axisx * _loc_18.lnormy;
                                _loc_18.gnormy = _loc_18.lnormx * _loc_5.body.axisx + _loc_18.lnormy * _loc_5.body.axisy;
                                _loc_18.gprojection = _loc_5.body.posx * _loc_18.gnormx + _loc_5.body.posy * _loc_18.gnormy + _loc_18.lprojection;
                                if (_loc_18.wrap_gnorm != null)
                                {
                                    _loc_18.wrap_gnorm.zpp_inner.x = _loc_18.gnormx;
                                    _loc_18.wrap_gnorm.zpp_inner.y = _loc_18.gnormy;
                                }
                                _loc_18.tp0 = _loc_18.gp0.y * _loc_18.gnormx - _loc_18.gp0.x * _loc_18.gnormy;
                                _loc_18.tp1 = _loc_18.gp1.y * _loc_18.gnormx - _loc_18.gp1.x * _loc_18.gnormy;
                                _loc_8 = _loc_9;
                                _loc_7 = _loc_7.next;
                            }
                            _loc_9 = _loc_5.gverts.next;
                            _loc_18 = _loc_17.elt;
                            _loc_17 = _loc_17.next;
                            _loc_18.gp0 = _loc_8;
                            _loc_18.gp1 = _loc_9;
                            _loc_18.gnormx = _loc_5.body.axisy * _loc_18.lnormx - _loc_5.body.axisx * _loc_18.lnormy;
                            _loc_18.gnormy = _loc_18.lnormx * _loc_5.body.axisx + _loc_18.lnormy * _loc_5.body.axisy;
                            _loc_18.gprojection = _loc_5.body.posx * _loc_18.gnormx + _loc_5.body.posy * _loc_18.gnormy + _loc_18.lprojection;
                            if (_loc_18.wrap_gnorm != null)
                            {
                                _loc_18.wrap_gnorm.zpp_inner.x = _loc_18.gnormx;
                                _loc_18.wrap_gnorm.zpp_inner.y = _loc_18.gnormy;
                            }
                            _loc_18.tp0 = _loc_18.gp0.y * _loc_18.gnormx - _loc_18.gp0.x * _loc_18.gnormy;
                            _loc_18.tp1 = _loc_18.gp1.y * _loc_18.gnormx - _loc_18.gp1.x * _loc_18.gnormy;
                        }
                    }
                }
                _loc_2 = _loc_2.next;
            }
            param1.sweepFrozen = true;
            return;
        }// end function

        public function sleepArbiters() : void
        {
            var _loc_5:* = null as ZPP_ColArbiter;
            var _loc_6:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_7:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_8:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_12:* = null as ZPP_FluidArbiter;
            var _loc_13:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_14:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_15:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_19:* = null as ZPP_SensorArbiter;
            var _loc_20:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_21:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_22:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_1:* = null;
            var _loc_2:* = c_arbiters_true;
            var _loc_3:* = _loc_2.head;
            var _loc_4:* = c_arbiters_false != null;
            if (_loc_4)
            {
            }
            if (_loc_3 == null)
            {
                _loc_4 = false;
                _loc_3 = c_arbiters_false.head;
                _loc_2 = c_arbiters_false;
                _loc_1 = null;
            }
            while (_loc_3 != null)
            {
                
                _loc_5 = _loc_3.elt;
                if (_loc_5.b1.component.sleeping)
                {
                }
                if (_loc_5.b2.component.sleeping)
                {
                    _loc_5.sleep_stamp = stamp;
                    _loc_5.sleeping = true;
                    if (_loc_1 == null)
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
                        _loc_6 = _loc_1.next;
                        _loc_7 = _loc_6.next;
                        _loc_1.next = _loc_7;
                        if (_loc_7 == null)
                        {
                            _loc_2.pushmod = true;
                        }
                    }
                    _loc_8 = _loc_6;
                    _loc_8.elt = null;
                    _loc_8.next = ZNPNode_ZPP_ColArbiter.zpp_pool;
                    ZNPNode_ZPP_ColArbiter.zpp_pool = _loc_8;
                    _loc_2.modified = true;
                    (_loc_2.length - 1);
                    _loc_2.pushmod = true;
                    _loc_3 = _loc_7;
                    if (_loc_4)
                    {
                    }
                    if (_loc_3 == null)
                    {
                        _loc_4 = false;
                        _loc_3 = c_arbiters_false.head;
                        _loc_2 = c_arbiters_false;
                        _loc_1 = null;
                    }
                    continue;
                }
                _loc_1 = _loc_3;
                _loc_3 = _loc_3.next;
                if (_loc_4)
                {
                }
                if (_loc_3 == null)
                {
                    _loc_4 = false;
                    _loc_3 = c_arbiters_false.head;
                    _loc_2 = c_arbiters_false;
                    _loc_1 = null;
                }
            }
            var _loc_9:* = null;
            var _loc_10:* = f_arbiters;
            var _loc_11:* = _loc_10.head;
            _loc_4 = false;
            if (_loc_4)
            {
            }
            if (_loc_11 == null)
            {
                _loc_4 = false;
                _loc_11 = null.begin();
                _loc_10 = null;
                _loc_9 = null;
            }
            while (_loc_11 != null)
            {
                
                _loc_12 = _loc_11.elt;
                if (_loc_12.b1.component.sleeping)
                {
                }
                if (_loc_12.b2.component.sleeping)
                {
                    _loc_12.sleep_stamp = stamp;
                    _loc_12.sleeping = true;
                    if (_loc_9 == null)
                    {
                        _loc_13 = _loc_10.head;
                        _loc_14 = _loc_13.next;
                        _loc_10.head = _loc_14;
                        if (_loc_10.head == null)
                        {
                            _loc_10.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_13 = _loc_9.next;
                        _loc_14 = _loc_13.next;
                        _loc_9.next = _loc_14;
                        if (_loc_14 == null)
                        {
                            _loc_10.pushmod = true;
                        }
                    }
                    _loc_15 = _loc_13;
                    _loc_15.elt = null;
                    _loc_15.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                    ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_15;
                    _loc_10.modified = true;
                    (_loc_10.length - 1);
                    _loc_10.pushmod = true;
                    _loc_11 = _loc_14;
                    if (_loc_4)
                    {
                    }
                    if (_loc_11 == null)
                    {
                        _loc_4 = false;
                        _loc_11 = null.begin();
                        _loc_10 = null;
                        _loc_9 = null;
                    }
                    continue;
                }
                _loc_9 = _loc_11;
                _loc_11 = _loc_11.next;
                if (_loc_4)
                {
                }
                if (_loc_11 == null)
                {
                    _loc_4 = false;
                    _loc_11 = null.begin();
                    _loc_10 = null;
                    _loc_9 = null;
                }
            }
            var _loc_16:* = null;
            var _loc_17:* = s_arbiters;
            var _loc_18:* = _loc_17.head;
            _loc_4 = false;
            if (_loc_4)
            {
            }
            if (_loc_18 == null)
            {
                _loc_4 = false;
                _loc_18 = null.begin();
                _loc_17 = null;
                _loc_16 = null;
            }
            while (_loc_18 != null)
            {
                
                _loc_19 = _loc_18.elt;
                if (_loc_19.b1.component.sleeping)
                {
                }
                if (_loc_19.b2.component.sleeping)
                {
                    _loc_19.sleep_stamp = stamp;
                    _loc_19.sleeping = true;
                    if (_loc_16 == null)
                    {
                        _loc_20 = _loc_17.head;
                        _loc_21 = _loc_20.next;
                        _loc_17.head = _loc_21;
                        if (_loc_17.head == null)
                        {
                            _loc_17.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_20 = _loc_16.next;
                        _loc_21 = _loc_20.next;
                        _loc_16.next = _loc_21;
                        if (_loc_21 == null)
                        {
                            _loc_17.pushmod = true;
                        }
                    }
                    _loc_22 = _loc_20;
                    _loc_22.elt = null;
                    _loc_22.next = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                    ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc_22;
                    _loc_17.modified = true;
                    (_loc_17.length - 1);
                    _loc_17.pushmod = true;
                    _loc_18 = _loc_21;
                    if (_loc_4)
                    {
                    }
                    if (_loc_18 == null)
                    {
                        _loc_4 = false;
                        _loc_18 = null.begin();
                        _loc_17 = null;
                        _loc_16 = null;
                    }
                    continue;
                }
                _loc_16 = _loc_18;
                _loc_18 = _loc_18.next;
                if (_loc_4)
                {
                }
                if (_loc_18 == null)
                {
                    _loc_4 = false;
                    _loc_18 = null.begin();
                    _loc_17 = null;
                    _loc_16 = null;
                }
            }
            return;
        }// end function

        public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
        {
            return bphase.shapesUnderPoint(param1, param2, param3, param4);
        }// end function

        public function shapesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
        {
            return bphase.shapesInShape(param1, param2, param3, param4);
        }// end function

        public function shapesInCircle(param1:Vec2, param2:Number, param3:Boolean, param4:ZPP_InteractionFilter, param5:ShapeList) : ShapeList
        {
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_6:* = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            return bphase.shapesInCircle(param1.zpp_inner.x, param1.zpp_inner.y, param2, param3, param4, param5);
        }// end function

        public function shapesInAABB(param1:AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:ShapeList) : ShapeList
        {
            return bphase.shapesInAABB(param1.zpp_inner, param2, param3, param4, param5);
        }// end function

        public function revoke_listener(param1:ZPP_InteractionListener) : void
        {
            return;
        }// end function

        public function removed_shape(param1:ZPP_Shape, param2:Boolean = false) : void
        {
            var _loc_7:* = null as ZPP_Arbiter;
            var _loc_8:* = false;
            var _loc_9:* = null as ZNPNode_ZPP_Interactor;
            var _loc_10:* = null as ZPP_Interactor;
            var _loc_11:* = null as ZNPNode_ZPP_Interactor;
            var _loc_12:* = null as ZPP_Interactor;
            var _loc_13:* = null as ZPP_CbSet;
            var _loc_14:* = null as ZPP_CbSet;
            var _loc_15:* = null as ZPP_CbSetPair;
            var _loc_16:* = null as ZPP_CbSetPair;
            var _loc_17:* = null as ZNPList_ZPP_CbSetPair;
            var _loc_18:* = null as ZNPNode_ZPP_CbSetPair;
            var _loc_19:* = null as ZPP_CbSetPair;
            var _loc_20:* = null as ZPP_CallbackSet;
            var _loc_21:* = 0;
            var _loc_22:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_23:* = null as ZPP_InteractionListener;
            var _loc_24:* = null as ZPP_Callback;
            var _loc_25:* = null as ZPP_Interactor;
            var _loc_26:* = null as ZPP_Interactor;
            var _loc_27:* = null as ZPP_OptionType;
            var _loc_28:* = null as ZNPList_ZPP_CbType;
            var _loc_29:* = null as ZPP_Body;
            var _loc_30:* = null as ZNPList_ZPP_Arbiter;
            var _loc_31:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_32:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_33:* = false;
            var _loc_34:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_35:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_36:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_3:* = this;
            var _loc_4:* = param1.body;
            if (!param2)
            {
                _loc_4.wake();
            }
            var _loc_5:* = null;
            var _loc_6:* = _loc_4.arbiters.head;
            while (_loc_6 != null)
            {
                
                _loc_7 = _loc_6.elt;
                if (_loc_7.ws1 != param1)
                {
                }
                _loc_8 = _loc_7.ws2 == param1;
                if (_loc_8)
                {
                    if (_loc_7.present != 0)
                    {
                        MRCA_chains(_loc_7.ws1, _loc_7.ws2);
                        _loc_9 = mrca1.head;
                        while (_loc_9 != null)
                        {
                            
                            _loc_10 = _loc_9.elt;
                            _loc_11 = mrca2.head;
                            while (_loc_11 != null)
                            {
                                
                                _loc_12 = _loc_11.elt;
                                _loc_13 = _loc_10.cbSet;
                                _loc_14 = _loc_12.cbSet;
                                _loc_13.validate();
                                _loc_14.validate();
                                _loc_16 = null;
                                if (_loc_13.cbpairs.length < _loc_14.cbpairs.length)
                                {
                                    _loc_17 = _loc_13.cbpairs;
                                }
                                else
                                {
                                    _loc_17 = _loc_14.cbpairs;
                                }
                                _loc_18 = _loc_17.head;
                                while (_loc_18 != null)
                                {
                                    
                                    _loc_19 = _loc_18.elt;
                                    if (_loc_19.a == _loc_13)
                                    {
                                    }
                                    if (_loc_19.b != _loc_14)
                                    {
                                        if (_loc_19.a == _loc_14)
                                        {
                                        }
                                    }
                                    if (_loc_19.b == _loc_13)
                                    {
                                        _loc_16 = _loc_19;
                                        break;
                                    }
                                    _loc_18 = _loc_18.next;
                                }
                                if (_loc_16 == null)
                                {
                                    if (ZPP_CbSetPair.zpp_pool == null)
                                    {
                                        _loc_19 = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                        _loc_19 = ZPP_CbSetPair.zpp_pool;
                                        ZPP_CbSetPair.zpp_pool = _loc_19.next;
                                        _loc_19.next = null;
                                    }
                                    _loc_19.zip_listeners = true;
                                    if (ZPP_CbSet.setlt(_loc_13, _loc_14))
                                    {
                                        _loc_19.a = _loc_13;
                                        _loc_19.b = _loc_14;
                                    }
                                    else
                                    {
                                        _loc_19.a = _loc_14;
                                        _loc_19.b = _loc_13;
                                    }
                                    _loc_16 = _loc_19;
                                    _loc_13.cbpairs.add(_loc_16);
                                    if (_loc_14 != _loc_13)
                                    {
                                        _loc_14.cbpairs.add(_loc_16);
                                    }
                                }
                                if (_loc_16.zip_listeners)
                                {
                                    _loc_16.zip_listeners = false;
                                    _loc_16.__validate();
                                }
                                _loc_15 = _loc_16;
                                if (_loc_15.listeners.head == null)
                                {
                                    _loc_11 = _loc_11.next;
                                    continue;
                                }
                                _loc_20 = ZPP_Interactor.get(_loc_10, _loc_12);
                                _loc_20.remove_arb(_loc_7);
                                (_loc_7.present - 1);
                                _loc_21 = ZPP_Flags.id_CbEvent_END;
                                _loc_16 = null;
                                if (_loc_13.cbpairs.length < _loc_14.cbpairs.length)
                                {
                                    _loc_17 = _loc_13.cbpairs;
                                }
                                else
                                {
                                    _loc_17 = _loc_14.cbpairs;
                                }
                                _loc_18 = _loc_17.head;
                                while (_loc_18 != null)
                                {
                                    
                                    _loc_19 = _loc_18.elt;
                                    if (_loc_19.a == _loc_13)
                                    {
                                    }
                                    if (_loc_19.b != _loc_14)
                                    {
                                        if (_loc_19.a == _loc_14)
                                        {
                                        }
                                    }
                                    if (_loc_19.b == _loc_13)
                                    {
                                        _loc_16 = _loc_19;
                                        break;
                                    }
                                    _loc_18 = _loc_18.next;
                                }
                                if (_loc_16 == null)
                                {
                                    if (ZPP_CbSetPair.zpp_pool == null)
                                    {
                                        _loc_19 = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                        _loc_19 = ZPP_CbSetPair.zpp_pool;
                                        ZPP_CbSetPair.zpp_pool = _loc_19.next;
                                        _loc_19.next = null;
                                    }
                                    _loc_19.zip_listeners = true;
                                    if (ZPP_CbSet.setlt(_loc_13, _loc_14))
                                    {
                                        _loc_19.a = _loc_13;
                                        _loc_19.b = _loc_14;
                                    }
                                    else
                                    {
                                        _loc_19.a = _loc_14;
                                        _loc_19.b = _loc_13;
                                    }
                                    _loc_16 = _loc_19;
                                    _loc_13.cbpairs.add(_loc_16);
                                    if (_loc_14 != _loc_13)
                                    {
                                        _loc_14.cbpairs.add(_loc_16);
                                    }
                                }
                                if (_loc_16.zip_listeners)
                                {
                                    _loc_16.zip_listeners = false;
                                    _loc_16.__validate();
                                }
                                _loc_15 = _loc_16;
                                _loc_22 = _loc_15.listeners.head;
                                while (_loc_22 != null)
                                {
                                    
                                    _loc_23 = _loc_22.elt;
                                    if (_loc_23.event == _loc_21)
                                    {
                                        if ((_loc_23.itype & _loc_7.type) != 0)
                                        {
                                        }
                                        if (_loc_20.empty_arb(_loc_23.itype))
                                        {
                                            _loc_24 = _loc_3.push_callback(_loc_23);
                                            _loc_24.event = ZPP_Flags.id_CbEvent_END;
                                            _loc_25 = _loc_20.int1;
                                            _loc_26 = _loc_20.int2;
                                            _loc_27 = _loc_23.options1;
                                            _loc_28 = _loc_25.cbTypes;
                                            if (_loc_27.nonemptyintersection(_loc_28, _loc_27.includes))
                                            {
                                            }
                                            if (!_loc_27.nonemptyintersection(_loc_28, _loc_27.excludes))
                                            {
                                                _loc_27 = _loc_23.options2;
                                                _loc_28 = _loc_26.cbTypes;
                                                if (_loc_27.nonemptyintersection(_loc_28, _loc_27.includes))
                                                {
                                                }
                                            }
                                            if (!_loc_27.nonemptyintersection(_loc_28, _loc_27.excludes))
                                            {
                                                _loc_24.int1 = _loc_25;
                                                _loc_24.int2 = _loc_26;
                                            }
                                            else
                                            {
                                                _loc_24.int1 = _loc_26;
                                                _loc_24.int2 = _loc_25;
                                            }
                                            _loc_24.set = _loc_20;
                                        }
                                    }
                                    _loc_22 = _loc_22.next;
                                }
                                if (_loc_20.arbiters.head == null)
                                {
                                    remove_callbackset(_loc_20);
                                }
                                _loc_11 = _loc_11.next;
                            }
                            _loc_9 = _loc_9.next;
                        }
                    }
                    if (_loc_7.b1 != _loc_4)
                    {
                    }
                    if (_loc_7.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                    {
                        _loc_29 = _loc_7.b1;
                        if (!_loc_29.world)
                        {
                            _loc_29.component.waket = stamp + (midstep ? (0) : (1));
                            if (_loc_29.type == ZPP_Flags.id_BodyType_KINEMATIC)
                            {
                                _loc_29.kinematicDelaySleep = true;
                            }
                            if (_loc_29.component.sleeping)
                            {
                                really_wake(_loc_29, false);
                            }
                        }
                    }
                    if (_loc_7.b2 != _loc_4)
                    {
                    }
                    if (_loc_7.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
                    {
                        _loc_29 = _loc_7.b2;
                        if (!_loc_29.world)
                        {
                            _loc_29.component.waket = stamp + (midstep ? (0) : (1));
                            if (_loc_29.type == ZPP_Flags.id_BodyType_KINEMATIC)
                            {
                                _loc_29.kinematicDelaySleep = true;
                            }
                            if (_loc_29.component.sleeping)
                            {
                                really_wake(_loc_29, false);
                            }
                        }
                    }
                    _loc_7.cleared = true;
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_7.b2 == _loc_4)
                    {
                        _loc_30 = _loc_7.b1.arbiters;
                        _loc_31 = null;
                        _loc_32 = _loc_30.head;
                        _loc_33 = false;
                        while (_loc_32 != null)
                        {
                            
                            if (_loc_32.elt == _loc_7)
                            {
                                if (_loc_31 == null)
                                {
                                    _loc_34 = _loc_30.head;
                                    _loc_35 = _loc_34.next;
                                    _loc_30.head = _loc_35;
                                    if (_loc_30.head == null)
                                    {
                                        _loc_30.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_34 = _loc_31.next;
                                    _loc_35 = _loc_34.next;
                                    _loc_31.next = _loc_35;
                                    if (_loc_35 == null)
                                    {
                                        _loc_30.pushmod = true;
                                    }
                                }
                                _loc_36 = _loc_34;
                                _loc_36.elt = null;
                                _loc_36.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_36;
                                _loc_30.modified = true;
                                (_loc_30.length - 1);
                                _loc_30.pushmod = true;
                                _loc_33 = true;
                                break;
                            }
                            _loc_31 = _loc_32;
                            _loc_32 = _loc_32.next;
                        }
                    }
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_7.b1 == _loc_4)
                    {
                        _loc_30 = _loc_7.b2.arbiters;
                        _loc_31 = null;
                        _loc_32 = _loc_30.head;
                        _loc_33 = false;
                        while (_loc_32 != null)
                        {
                            
                            if (_loc_32.elt == _loc_7)
                            {
                                if (_loc_31 == null)
                                {
                                    _loc_34 = _loc_30.head;
                                    _loc_35 = _loc_34.next;
                                    _loc_30.head = _loc_35;
                                    if (_loc_30.head == null)
                                    {
                                        _loc_30.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_34 = _loc_31.next;
                                    _loc_35 = _loc_34.next;
                                    _loc_31.next = _loc_35;
                                    if (_loc_35 == null)
                                    {
                                        _loc_30.pushmod = true;
                                    }
                                }
                                _loc_36 = _loc_34;
                                _loc_36.elt = null;
                                _loc_36.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_36;
                                _loc_30.modified = true;
                                (_loc_30.length - 1);
                                _loc_30.pushmod = true;
                                _loc_33 = true;
                                break;
                            }
                            _loc_31 = _loc_32;
                            _loc_32 = _loc_32.next;
                        }
                    }
                    if (_loc_7.pair != null)
                    {
                        _loc_7.pair.arb = null;
                        _loc_7.pair = null;
                    }
                    _loc_7.active = false;
                    f_arbiters.modified = true;
                    _loc_6 = _loc_4.arbiters.erase(_loc_5);
                    continue;
                }
                _loc_5 = _loc_6;
                _loc_6 = _loc_6.next;
            }
            bphase.remove(param1);
            param1.removedFromSpace();
            return;
        }// end function

        public function remove_callbackset(param1:ZPP_CallbackSet) : void
        {
            var _loc_6:* = null as ZNPNode_ZPP_CallbackSet;
            var _loc_7:* = null as ZNPNode_ZPP_CallbackSet;
            var _loc_8:* = null as ZNPNode_ZPP_CallbackSet;
            param1.lazydel = true;
            var _loc_2:* = param1.int1.cbsets;
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
                    _loc_8.next = ZNPNode_ZPP_CallbackSet.zpp_pool;
                    ZNPNode_ZPP_CallbackSet.zpp_pool = _loc_8;
                    _loc_2.modified = true;
                    (_loc_2.length - 1);
                    _loc_2.pushmod = true;
                    _loc_5 = true;
                    break;
                }
                _loc_3 = _loc_4;
                _loc_4 = _loc_4.next;
            }
            _loc_2 = param1.int2.cbsets;
            _loc_3 = null;
            _loc_4 = _loc_2.head;
            _loc_5 = false;
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
                    _loc_8.next = ZNPNode_ZPP_CallbackSet.zpp_pool;
                    ZNPNode_ZPP_CallbackSet.zpp_pool = _loc_8;
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

        public function remListener(param1:ZPP_Listener) : void
        {
            if (param1.interaction != null)
            {
            }
            param1.removedFromSpace();
            param1.space = null;
            return;
        }// end function

        public function remConstraint(param1:ZPP_Constraint) : void
        {
            if (param1.active)
            {
                wake_constraint(param1, true);
                live_constraints.remove(param1);
            }
            param1.removedFromSpace();
            param1.space = null;
            return;
        }// end function

        public function remCompound(param1:ZPP_Compound) : void
        {
            var _loc_3:* = null as ZPP_Body;
            var _loc_5:* = null as ZPP_Constraint;
            var _loc_7:* = null as ZPP_Compound;
            var _loc_2:* = param1.bodies.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                remBody(_loc_3);
                _loc_2 = _loc_2.next;
            }
            var _loc_4:* = param1.constraints.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                remConstraint(_loc_5);
                _loc_4 = _loc_4.next;
            }
            var _loc_6:* = param1.compounds.head;
            while (_loc_6 != null)
            {
                
                _loc_7 = _loc_6.elt;
                remCompound(_loc_7);
                _loc_6 = _loc_6.next;
            }
            param1.removedFromSpace();
            param1.space = null;
            return;
        }// end function

        public function remBody(param1:ZPP_Body, param2:int = -1) : void
        {
            var _loc_3:* = null as ZPP_Body;
            var _loc_5:* = null as ZPP_Shape;
            if (param1.type == ZPP_Flags.id_BodyType_STATIC)
            {
                _loc_3 = param1;
                if (!_loc_3.world)
                {
                    _loc_3.component.waket = stamp + (midstep ? (0) : (1));
                    if (_loc_3.type == ZPP_Flags.id_BodyType_KINEMATIC)
                    {
                        _loc_3.kinematicDelaySleep = true;
                    }
                    if (_loc_3.component.sleeping)
                    {
                        really_wake(_loc_3, true);
                    }
                }
                staticsleep.remove(param1);
            }
            else if (param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                _loc_3 = param1;
                if (!_loc_3.world)
                {
                    _loc_3.component.waket = stamp + (midstep ? (0) : (1));
                    if (_loc_3.type == ZPP_Flags.id_BodyType_KINEMATIC)
                    {
                        _loc_3.kinematicDelaySleep = true;
                    }
                    if (_loc_3.component.sleeping)
                    {
                        really_wake(_loc_3, true);
                    }
                }
                live.remove(param1);
            }
            else
            {
                if (param2 != ZPP_Flags.id_BodyType_KINEMATIC)
                {
                    kinematics.remove(param1);
                }
                _loc_3 = param1;
                if (!_loc_3.world)
                {
                    _loc_3.component.waket = stamp + (midstep ? (0) : (1));
                    if (_loc_3.type == ZPP_Flags.id_BodyType_KINEMATIC)
                    {
                        _loc_3.kinematicDelaySleep = true;
                    }
                    if (_loc_3.component.sleeping)
                    {
                        really_wake(_loc_3, true);
                    }
                }
                staticsleep.remove(param1);
            }
            var _loc_4:* = param1.shapes.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                removed_shape(_loc_5, true);
                _loc_4 = _loc_4.next;
            }
            param1.removedFromSpace();
            param1.space = null;
            return;
        }// end function

        public function really_wake(param1:ZPP_Body, param2:Boolean = false) : void
        {
            var _loc_3:* = null as ZNPList_ZPP_Body;
            var _loc_4:* = null as ZNPNode_ZPP_Body;
            var _loc_5:* = null as ZNPNode_ZPP_Body;
            var _loc_6:* = null as ZNPNode_ZPP_Constraint;
            var _loc_7:* = null as ZPP_Constraint;
            var _loc_8:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_9:* = null as ZPP_Arbiter;
            var _loc_10:* = null as ZPP_ColArbiter;
            var _loc_11:* = null as ZNPList_ZPP_ColArbiter;
            var _loc_12:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_13:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_14:* = null as ZNPList_ZPP_FluidArbiter;
            var _loc_15:* = null as ZPP_FluidArbiter;
            var _loc_16:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_17:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_18:* = null as ZNPList_ZPP_SensorArbiter;
            var _loc_19:* = null as ZPP_SensorArbiter;
            var _loc_20:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_21:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_22:* = null as ZPP_Body;
            var _loc_23:* = null as ZNPNode_ZPP_Shape;
            var _loc_24:* = null as ZPP_Shape;
            if (param1.component.island == null)
            {
                param1.component.sleeping = false;
                if (param1.type != ZPP_Flags.id_BodyType_KINEMATIC)
                {
                }
                if (param1.type == ZPP_Flags.id_BodyType_STATIC)
                {
                    _loc_3 = staticsleep;
                    if (ZNPNode_ZPP_Body.zpp_pool == null)
                    {
                        _loc_5 = new ZNPNode_ZPP_Body();
                    }
                    else
                    {
                        _loc_5 = ZNPNode_ZPP_Body.zpp_pool;
                        ZNPNode_ZPP_Body.zpp_pool = _loc_5.next;
                        _loc_5.next = null;
                    }
                    _loc_5.elt = param1;
                    _loc_4 = _loc_5;
                    _loc_4.next = _loc_3.head;
                    _loc_3.head = _loc_4;
                    _loc_3.modified = true;
                    (_loc_3.length + 1);
                }
                else
                {
                    _loc_3 = live;
                    if (ZNPNode_ZPP_Body.zpp_pool == null)
                    {
                        _loc_5 = new ZNPNode_ZPP_Body();
                    }
                    else
                    {
                        _loc_5 = ZNPNode_ZPP_Body.zpp_pool;
                        ZNPNode_ZPP_Body.zpp_pool = _loc_5.next;
                        _loc_5.next = null;
                    }
                    _loc_5.elt = param1;
                    _loc_4 = _loc_5;
                    _loc_4.next = _loc_3.head;
                    _loc_3.head = _loc_4;
                    _loc_3.modified = true;
                    (_loc_3.length + 1);
                }
                _loc_6 = param1.constraints.head;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6.elt;
                    if (_loc_7.space == this)
                    {
                        wake_constraint(_loc_7);
                    }
                    _loc_6 = _loc_6.next;
                }
                _loc_8 = param1.arbiters.head;
                while (_loc_8 != null)
                {
                    
                    _loc_9 = _loc_8.elt;
                    if (_loc_9.sleeping)
                    {
                        _loc_9.sleeping = false;
                        _loc_9.up_stamp = _loc_9.up_stamp + (stamp + (midstep ? (0) : (1)) - _loc_9.sleep_stamp);
                        if (_loc_9.type == ZPP_Arbiter.COL)
                        {
                            _loc_10 = _loc_9.colarb;
                            if (_loc_10.stat)
                            {
                                _loc_11 = c_arbiters_true;
                                if (ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                                {
                                    _loc_13 = new ZNPNode_ZPP_ColArbiter();
                                }
                                else
                                {
                                    _loc_13 = ZNPNode_ZPP_ColArbiter.zpp_pool;
                                    ZNPNode_ZPP_ColArbiter.zpp_pool = _loc_13.next;
                                    _loc_13.next = null;
                                }
                                _loc_13.elt = _loc_10;
                                _loc_12 = _loc_13;
                                _loc_12.next = _loc_11.head;
                                _loc_11.head = _loc_12;
                                _loc_11.modified = true;
                                (_loc_11.length + 1);
                            }
                            else
                            {
                                _loc_11 = c_arbiters_false;
                                if (ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                                {
                                    _loc_13 = new ZNPNode_ZPP_ColArbiter();
                                }
                                else
                                {
                                    _loc_13 = ZNPNode_ZPP_ColArbiter.zpp_pool;
                                    ZNPNode_ZPP_ColArbiter.zpp_pool = _loc_13.next;
                                    _loc_13.next = null;
                                }
                                _loc_13.elt = _loc_10;
                                _loc_12 = _loc_13;
                                _loc_12.next = _loc_11.head;
                                _loc_11.head = _loc_12;
                                _loc_11.modified = true;
                                (_loc_11.length + 1);
                            }
                        }
                        else if (_loc_9.type == ZPP_Arbiter.FLUID)
                        {
                            _loc_14 = f_arbiters;
                            _loc_15 = _loc_9.fluidarb;
                            if (ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                            {
                                _loc_17 = new ZNPNode_ZPP_FluidArbiter();
                            }
                            else
                            {
                                _loc_17 = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                                ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_17.next;
                                _loc_17.next = null;
                            }
                            _loc_17.elt = _loc_15;
                            _loc_16 = _loc_17;
                            _loc_16.next = _loc_14.head;
                            _loc_14.head = _loc_16;
                            _loc_14.modified = true;
                            (_loc_14.length + 1);
                        }
                        else
                        {
                            _loc_18 = s_arbiters;
                            _loc_19 = _loc_9.sensorarb;
                            if (ZNPNode_ZPP_SensorArbiter.zpp_pool == null)
                            {
                                _loc_21 = new ZNPNode_ZPP_SensorArbiter();
                            }
                            else
                            {
                                _loc_21 = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                                ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc_21.next;
                                _loc_21.next = null;
                            }
                            _loc_21.elt = _loc_19;
                            _loc_20 = _loc_21;
                            _loc_20.next = _loc_18.head;
                            _loc_18.head = _loc_20;
                            _loc_18.modified = true;
                            (_loc_18.length + 1);
                        }
                    }
                    if (_loc_9.type != ZPP_Arbiter.SENSOR)
                    {
                    }
                    if (!_loc_9.cleared)
                    {
                    }
                    if (_loc_9.up_stamp >= stamp)
                    {
                    }
                    if ((_loc_9.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                    {
                        if (_loc_9.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                        }
                        if (_loc_9.b1.component.sleeping)
                        {
                            _loc_22 = _loc_9.b1;
                            if (!_loc_22.world)
                            {
                                _loc_22.component.waket = stamp + (midstep ? (0) : (1));
                                if (_loc_22.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                {
                                    _loc_22.kinematicDelaySleep = true;
                                }
                                if (_loc_22.component.sleeping)
                                {
                                    really_wake(_loc_22, false);
                                }
                            }
                        }
                        if (_loc_9.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                        }
                        if (_loc_9.b2.component.sleeping)
                        {
                            _loc_22 = _loc_9.b2;
                            if (!_loc_22.world)
                            {
                                _loc_22.component.waket = stamp + (midstep ? (0) : (1));
                                if (_loc_22.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                {
                                    _loc_22.kinematicDelaySleep = true;
                                }
                                if (_loc_22.component.sleeping)
                                {
                                    really_wake(_loc_22, false);
                                }
                            }
                        }
                    }
                    _loc_8 = _loc_8.next;
                }
                if (!param2)
                {
                }
                if (param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                    bodyCbWake(param1);
                }
                if (!param2)
                {
                }
                if (!bphase.is_sweep)
                {
                }
                if (param1.type != ZPP_Flags.id_BodyType_STATIC)
                {
                    _loc_23 = param1.shapes.head;
                    while (_loc_23 != null)
                    {
                        
                        _loc_24 = _loc_23.elt;
                        if (_loc_24.node != null)
                        {
                            bphase.sync(_loc_24);
                        }
                        _loc_23 = _loc_23.next;
                    }
                }
            }
            else
            {
                wakeIsland(param1.component.island);
            }
            return;
        }// end function

        public function rayMultiCast(param1:Ray, param2:Boolean, param3:InteractionFilter, param4:RayResultList) : RayResultList
        {
            return bphase.rayMultiCast(param1.zpp_inner, param2, param3 == null ? (null) : (param3.zpp_inner), param4);
        }// end function

        public function rayCast(param1:Ray, param2:Boolean, param3:InteractionFilter) : RayResult
        {
            return bphase.rayCast(param1.zpp_inner, param2, param3 == null ? (null) : (param3.zpp_inner));
        }// end function

        public function push_callback(param1:ZPP_Listener) : ZPP_Callback
        {
            var _loc_2:* = null as ZPP_Callback;
            if (ZPP_Callback.zpp_pool == null)
            {
                _loc_2 = new ZPP_Callback();
            }
            else
            {
                _loc_2 = ZPP_Callback.zpp_pool;
                ZPP_Callback.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            callbacks.push(_loc_2);
            _loc_2.listener = param1;
            return _loc_2;
        }// end function

        public function presteparb(param1:ZPP_Arbiter, param2:Number, param3:Object = undefined) : Boolean
        {
            var _loc_5:* = false;
            var _loc_6:* = false;
            var _loc_7:* = null as ZPP_Shape;
            var _loc_8:* = null as ZPP_Shape;
            var _loc_9:* = null as ZNPList_ZPP_Interactor;
            var _loc_10:* = null as ZNPNode_ZPP_Interactor;
            var _loc_11:* = null as ZNPNode_ZPP_Interactor;
            var _loc_12:* = null as ZPP_Interactor;
            var _loc_13:* = null as ZPP_Compound;
            var _loc_14:* = null as ZPP_Compound;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = null as ZPP_Interactor;
            var _loc_18:* = null as ZPP_CbSet;
            var _loc_19:* = null as ZPP_CbSet;
            var _loc_20:* = null as ZPP_CbSetPair;
            var _loc_21:* = null as ZPP_CbSetPair;
            var _loc_22:* = null as ZNPList_ZPP_CbSetPair;
            var _loc_23:* = null as ZNPNode_ZPP_CbSetPair;
            var _loc_24:* = null as ZPP_CbSetPair;
            var _loc_25:* = null as ZPP_CallbackSet;
            var _loc_26:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_27:* = null as ZPP_InteractionListener;
            var _loc_28:* = null as ZPP_Callback;
            var _loc_29:* = null as ZPP_Interactor;
            var _loc_30:* = null as ZPP_Interactor;
            var _loc_31:* = null as ZPP_OptionType;
            var _loc_32:* = null as ZNPList_ZPP_CbType;
            var _loc_33:* = false;
            var _loc_34:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_35:* = null as ZPP_Arbiter;
            var _loc_36:* = null as ZNPList_ZPP_Arbiter;
            var _loc_37:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_38:* = null as ZPP_SensorArbiter;
            var _loc_39:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_40:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_41:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_42:* = null as ZPP_Body;
            var _loc_43:* = null as ZPP_SensorArbiter;
            var _loc_44:* = null as ZPP_FluidArbiter;
            var _loc_45:* = null as ZPP_FluidArbiter;
            var _loc_46:* = null as ZPP_ColArbiter;
            var _loc_47:* = null as ZPP_Contact;
            var _loc_48:* = null as ZPP_Contact;
            var _loc_49:* = null as ZPP_Contact;
            var _loc_50:* = null as ZPP_IContact;
            var _loc_51:* = null as ZPP_IContact;
            var _loc_52:* = null as ZPP_ColArbiter;
            var _loc_53:* = null as ZPP_Edge;
            var _loc_54:* = NaN;
            var _loc_55:* = NaN;
            var _loc_56:* = NaN;
            var _loc_57:* = null as ZPP_Contact;
            var _loc_58:* = null as ZPP_Contact;
            var _loc_59:* = null as ZPP_Contact;
            var _loc_60:* = null as ZPP_IContact;
            var _loc_61:* = null as ZPP_IContact;
            var _loc_62:* = null as ZPP_IContact;
            var _loc_63:* = false;
            var _loc_64:* = NaN;
            var _loc_65:* = NaN;
            var _loc_66:* = NaN;
            var _loc_67:* = NaN;
            var _loc_68:* = NaN;
            var _loc_69:* = NaN;
            var _loc_70:* = NaN;
            var _loc_71:* = NaN;
            var _loc_72:* = NaN;
            var _loc_73:* = NaN;
            var _loc_74:* = null as ZPP_Polygon;
            var _loc_75:* = NaN;
            var _loc_76:* = null as ZNPNode_ZPP_Edge;
            var _loc_77:* = NaN;
            var _loc_78:* = NaN;
            var _loc_79:* = NaN;
            var _loc_80:* = NaN;
            var _loc_81:* = NaN;
            if (param3 == null)
            {
                param3 = false;
            }
            var _loc_4:* = this;
            if (!param1.cleared)
            {
                if (param1.b1.component.sleeping)
                {
                }
            }
            if (param1.b2.component.sleeping)
            {
                param1.sleep_stamp = stamp;
                param1.sleeping = true;
                return true;
            }
            if (param1.cleared)
            {
            }
            if (param1.present == 0)
            {
            }
            if (param1.intchange)
            {
                if (!param3)
                {
                }
                if (param1.up_stamp == (stamp - 1))
                {
                }
                if (!param1.cleared)
                {
                }
                _loc_5 = !param1.intchange;
                if (param1.fresh)
                {
                }
                if (!param1.cleared)
                {
                }
                _loc_6 = !param1.intchange;
                if (_loc_5)
                {
                    param1.endGenerated = stamp;
                }
                if (!_loc_6)
                {
                }
                if (!_loc_5)
                {
                }
                if (!param1.cleared)
                {
                }
                if (param1.intchange)
                {
                    _loc_7 = param1.ws1;
                    _loc_8 = param1.ws2;
                    _loc_9 = mrca1;
                    while (_loc_9.head != null)
                    {
                        
                        _loc_10 = _loc_9.head;
                        _loc_9.head = _loc_10.next;
                        _loc_11 = _loc_10;
                        _loc_11.elt = null;
                        _loc_11.next = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_11;
                        if (_loc_9.head == null)
                        {
                            _loc_9.pushmod = true;
                        }
                        _loc_9.modified = true;
                        (_loc_9.length - 1);
                    }
                    _loc_9.pushmod = true;
                    _loc_9 = mrca2;
                    while (_loc_9.head != null)
                    {
                        
                        _loc_10 = _loc_9.head;
                        _loc_9.head = _loc_10.next;
                        _loc_11 = _loc_10;
                        _loc_11.elt = null;
                        _loc_11.next = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_11;
                        if (_loc_9.head == null)
                        {
                            _loc_9.pushmod = true;
                        }
                        _loc_9.modified = true;
                        (_loc_9.length - 1);
                    }
                    _loc_9.pushmod = true;
                    if (_loc_7.cbSet != null)
                    {
                        _loc_9 = mrca1;
                        if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                            _loc_11 = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                            _loc_11 = ZNPNode_ZPP_Interactor.zpp_pool;
                            ZNPNode_ZPP_Interactor.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.elt = _loc_7;
                        _loc_10 = _loc_11;
                        _loc_10.next = _loc_9.head;
                        _loc_9.head = _loc_10;
                        _loc_9.modified = true;
                        (_loc_9.length + 1);
                    }
                    if (_loc_7.body.cbSet != null)
                    {
                        _loc_9 = mrca1;
                        _loc_12 = _loc_7.body;
                        if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                            _loc_11 = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                            _loc_11 = ZNPNode_ZPP_Interactor.zpp_pool;
                            ZNPNode_ZPP_Interactor.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.elt = _loc_12;
                        _loc_10 = _loc_11;
                        _loc_10.next = _loc_9.head;
                        _loc_9.head = _loc_10;
                        _loc_9.modified = true;
                        (_loc_9.length + 1);
                    }
                    if (_loc_8.cbSet != null)
                    {
                        _loc_9 = mrca2;
                        if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                            _loc_11 = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                            _loc_11 = ZNPNode_ZPP_Interactor.zpp_pool;
                            ZNPNode_ZPP_Interactor.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.elt = _loc_8;
                        _loc_10 = _loc_11;
                        _loc_10.next = _loc_9.head;
                        _loc_9.head = _loc_10;
                        _loc_9.modified = true;
                        (_loc_9.length + 1);
                    }
                    if (_loc_8.body.cbSet != null)
                    {
                        _loc_9 = mrca2;
                        _loc_12 = _loc_8.body;
                        if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                            _loc_11 = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                            _loc_11 = ZNPNode_ZPP_Interactor.zpp_pool;
                            ZNPNode_ZPP_Interactor.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.elt = _loc_12;
                        _loc_10 = _loc_11;
                        _loc_10.next = _loc_9.head;
                        _loc_9.head = _loc_10;
                        _loc_9.modified = true;
                        (_loc_9.length + 1);
                    }
                    _loc_13 = _loc_7.body.compound;
                    _loc_14 = _loc_8.body.compound;
                    while (_loc_13 != _loc_14)
                    {
                        
                        if (_loc_13 == null)
                        {
                            _loc_15 = 0;
                        }
                        else
                        {
                            _loc_15 = _loc_13.depth;
                        }
                        if (_loc_14 == null)
                        {
                            _loc_16 = 0;
                        }
                        else
                        {
                            _loc_16 = _loc_14.depth;
                        }
                        if (_loc_15 < _loc_16)
                        {
                            if (_loc_14.cbSet != null)
                            {
                                _loc_9 = mrca2;
                                if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                {
                                    _loc_11 = new ZNPNode_ZPP_Interactor();
                                }
                                else
                                {
                                    _loc_11 = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_11.next;
                                    _loc_11.next = null;
                                }
                                _loc_11.elt = _loc_14;
                                _loc_10 = _loc_11;
                                _loc_10.next = _loc_9.head;
                                _loc_9.head = _loc_10;
                                _loc_9.modified = true;
                                (_loc_9.length + 1);
                            }
                            _loc_14 = _loc_14.compound;
                            continue;
                        }
                        if (_loc_13.cbSet != null)
                        {
                            _loc_9 = mrca1;
                            if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                            {
                                _loc_11 = new ZNPNode_ZPP_Interactor();
                            }
                            else
                            {
                                _loc_11 = ZNPNode_ZPP_Interactor.zpp_pool;
                                ZNPNode_ZPP_Interactor.zpp_pool = _loc_11.next;
                                _loc_11.next = null;
                            }
                            _loc_11.elt = _loc_13;
                            _loc_10 = _loc_11;
                            _loc_10.next = _loc_9.head;
                            _loc_9.head = _loc_10;
                            _loc_9.modified = true;
                            (_loc_9.length + 1);
                        }
                        _loc_13 = _loc_13.compound;
                    }
                    _loc_10 = mrca1.head;
                    while (_loc_10 != null)
                    {
                        
                        _loc_12 = _loc_10.elt;
                        _loc_11 = mrca2.head;
                        while (_loc_11 != null)
                        {
                            
                            _loc_17 = _loc_11.elt;
                            _loc_18 = _loc_12.cbSet;
                            _loc_19 = _loc_17.cbSet;
                            _loc_21 = null;
                            if (_loc_18.cbpairs.length < _loc_19.cbpairs.length)
                            {
                                _loc_22 = _loc_18.cbpairs;
                            }
                            else
                            {
                                _loc_22 = _loc_19.cbpairs;
                            }
                            _loc_23 = _loc_22.head;
                            while (_loc_23 != null)
                            {
                                
                                _loc_24 = _loc_23.elt;
                                if (_loc_24.a == _loc_18)
                                {
                                }
                                if (_loc_24.b != _loc_19)
                                {
                                    if (_loc_24.a == _loc_19)
                                    {
                                    }
                                }
                                if (_loc_24.b == _loc_18)
                                {
                                    _loc_21 = _loc_24;
                                    break;
                                }
                                _loc_23 = _loc_23.next;
                            }
                            if (_loc_21 == null)
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
                                if (ZPP_CbSet.setlt(_loc_18, _loc_19))
                                {
                                    _loc_24.a = _loc_18;
                                    _loc_24.b = _loc_19;
                                }
                                else
                                {
                                    _loc_24.a = _loc_19;
                                    _loc_24.b = _loc_18;
                                }
                                _loc_21 = _loc_24;
                                _loc_18.cbpairs.add(_loc_21);
                                if (_loc_19 != _loc_18)
                                {
                                    _loc_19.cbpairs.add(_loc_21);
                                }
                            }
                            if (_loc_21.zip_listeners)
                            {
                                _loc_21.zip_listeners = false;
                                _loc_21.__validate();
                            }
                            _loc_20 = _loc_21;
                            if (_loc_20.listeners.head == null)
                            {
                                _loc_11 = _loc_11.next;
                                continue;
                            }
                            _loc_25 = ZPP_Interactor.get(_loc_12, _loc_17);
                            if (!_loc_6)
                            {
                            }
                            if (param1.intchange)
                            {
                                if (_loc_25 == null)
                                {
                                    _loc_25 = ZPP_CallbackSet.get(_loc_12, _loc_17);
                                    add_callbackset(_loc_25);
                                }
                                _loc_15 = ZPP_Flags.id_CbEvent_BEGIN;
                                _loc_21 = null;
                                if (_loc_18.cbpairs.length < _loc_19.cbpairs.length)
                                {
                                    _loc_22 = _loc_18.cbpairs;
                                }
                                else
                                {
                                    _loc_22 = _loc_19.cbpairs;
                                }
                                _loc_23 = _loc_22.head;
                                while (_loc_23 != null)
                                {
                                    
                                    _loc_24 = _loc_23.elt;
                                    if (_loc_24.a == _loc_18)
                                    {
                                    }
                                    if (_loc_24.b != _loc_19)
                                    {
                                        if (_loc_24.a == _loc_19)
                                        {
                                        }
                                    }
                                    if (_loc_24.b == _loc_18)
                                    {
                                        _loc_21 = _loc_24;
                                        break;
                                    }
                                    _loc_23 = _loc_23.next;
                                }
                                if (_loc_21 == null)
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
                                    if (ZPP_CbSet.setlt(_loc_18, _loc_19))
                                    {
                                        _loc_24.a = _loc_18;
                                        _loc_24.b = _loc_19;
                                    }
                                    else
                                    {
                                        _loc_24.a = _loc_19;
                                        _loc_24.b = _loc_18;
                                    }
                                    _loc_21 = _loc_24;
                                    _loc_18.cbpairs.add(_loc_21);
                                    if (_loc_19 != _loc_18)
                                    {
                                        _loc_19.cbpairs.add(_loc_21);
                                    }
                                }
                                if (_loc_21.zip_listeners)
                                {
                                    _loc_21.zip_listeners = false;
                                    _loc_21.__validate();
                                }
                                _loc_20 = _loc_21;
                                _loc_26 = _loc_20.listeners.head;
                                while (_loc_26 != null)
                                {
                                    
                                    _loc_27 = _loc_26.elt;
                                    if (_loc_27.event == _loc_15)
                                    {
                                        if ((_loc_27.itype & param1.type) != 0)
                                        {
                                        }
                                        if (_loc_25.empty_arb(_loc_27.itype))
                                        {
                                            _loc_28 = _loc_4.push_callback(_loc_27);
                                            _loc_28.event = ZPP_Flags.id_CbEvent_BEGIN;
                                            _loc_29 = _loc_25.int1;
                                            _loc_30 = _loc_25.int2;
                                            _loc_31 = _loc_27.options1;
                                            _loc_32 = _loc_29.cbTypes;
                                            if (_loc_31.nonemptyintersection(_loc_32, _loc_31.includes))
                                            {
                                            }
                                            if (!_loc_31.nonemptyintersection(_loc_32, _loc_31.excludes))
                                            {
                                                _loc_31 = _loc_27.options2;
                                                _loc_32 = _loc_30.cbTypes;
                                                if (_loc_31.nonemptyintersection(_loc_32, _loc_31.includes))
                                                {
                                                }
                                            }
                                            if (!_loc_31.nonemptyintersection(_loc_32, _loc_31.excludes))
                                            {
                                                _loc_28.int1 = _loc_29;
                                                _loc_28.int2 = _loc_30;
                                            }
                                            else
                                            {
                                                _loc_28.int1 = _loc_30;
                                                _loc_28.int2 = _loc_29;
                                            }
                                            _loc_28.set = _loc_25;
                                        }
                                    }
                                    _loc_26 = _loc_26.next;
                                }
                                _loc_33 = false;
                                _loc_34 = _loc_25.arbiters.head;
                                while (_loc_34 != null)
                                {
                                    
                                    _loc_35 = _loc_34.elt;
                                    if (_loc_35 == param1)
                                    {
                                        _loc_33 = true;
                                        break;
                                    }
                                    _loc_34 = _loc_34.next;
                                }
                                if (!_loc_33)
                                {
                                    _loc_36 = _loc_25.arbiters;
                                    if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                    {
                                        _loc_37 = new ZNPNode_ZPP_Arbiter();
                                    }
                                    else
                                    {
                                        _loc_37 = ZNPNode_ZPP_Arbiter.zpp_pool;
                                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc_37.next;
                                        _loc_37.next = null;
                                    }
                                    _loc_37.elt = param1;
                                    _loc_34 = _loc_37;
                                    _loc_34.next = _loc_36.head;
                                    _loc_36.head = _loc_34;
                                    _loc_36.modified = true;
                                    (_loc_36.length + 1);
                                }
                                else
                                {
                                }
                                if (false)
                                {
                                    (param1.present + 1);
                                }
                            }
                            else
                            {
                                (param1.present - 1);
                                _loc_25.remove_arb(param1);
                                _loc_15 = ZPP_Flags.id_CbEvent_END;
                                _loc_21 = null;
                                if (_loc_18.cbpairs.length < _loc_19.cbpairs.length)
                                {
                                    _loc_22 = _loc_18.cbpairs;
                                }
                                else
                                {
                                    _loc_22 = _loc_19.cbpairs;
                                }
                                _loc_23 = _loc_22.head;
                                while (_loc_23 != null)
                                {
                                    
                                    _loc_24 = _loc_23.elt;
                                    if (_loc_24.a == _loc_18)
                                    {
                                    }
                                    if (_loc_24.b != _loc_19)
                                    {
                                        if (_loc_24.a == _loc_19)
                                        {
                                        }
                                    }
                                    if (_loc_24.b == _loc_18)
                                    {
                                        _loc_21 = _loc_24;
                                        break;
                                    }
                                    _loc_23 = _loc_23.next;
                                }
                                if (_loc_21 == null)
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
                                    if (ZPP_CbSet.setlt(_loc_18, _loc_19))
                                    {
                                        _loc_24.a = _loc_18;
                                        _loc_24.b = _loc_19;
                                    }
                                    else
                                    {
                                        _loc_24.a = _loc_19;
                                        _loc_24.b = _loc_18;
                                    }
                                    _loc_21 = _loc_24;
                                    _loc_18.cbpairs.add(_loc_21);
                                    if (_loc_19 != _loc_18)
                                    {
                                        _loc_19.cbpairs.add(_loc_21);
                                    }
                                }
                                if (_loc_21.zip_listeners)
                                {
                                    _loc_21.zip_listeners = false;
                                    _loc_21.__validate();
                                }
                                _loc_20 = _loc_21;
                                _loc_26 = _loc_20.listeners.head;
                                while (_loc_26 != null)
                                {
                                    
                                    _loc_27 = _loc_26.elt;
                                    if (_loc_27.event == _loc_15)
                                    {
                                        if ((_loc_27.itype & param1.type) != 0)
                                        {
                                        }
                                        if (_loc_25.empty_arb(_loc_27.itype))
                                        {
                                            _loc_28 = _loc_4.push_callback(_loc_27);
                                            _loc_28.event = ZPP_Flags.id_CbEvent_END;
                                            _loc_29 = _loc_25.int1;
                                            _loc_30 = _loc_25.int2;
                                            _loc_31 = _loc_27.options1;
                                            _loc_32 = _loc_29.cbTypes;
                                            if (_loc_31.nonemptyintersection(_loc_32, _loc_31.includes))
                                            {
                                            }
                                            if (!_loc_31.nonemptyintersection(_loc_32, _loc_31.excludes))
                                            {
                                                _loc_31 = _loc_27.options2;
                                                _loc_32 = _loc_30.cbTypes;
                                                if (_loc_31.nonemptyintersection(_loc_32, _loc_31.includes))
                                                {
                                                }
                                            }
                                            if (!_loc_31.nonemptyintersection(_loc_32, _loc_31.excludes))
                                            {
                                                _loc_28.int1 = _loc_29;
                                                _loc_28.int2 = _loc_30;
                                            }
                                            else
                                            {
                                                _loc_28.int1 = _loc_30;
                                                _loc_28.int2 = _loc_29;
                                            }
                                            _loc_28.set = _loc_25;
                                        }
                                    }
                                    _loc_26 = _loc_26.next;
                                }
                                if (_loc_25.arbiters.head == null)
                                {
                                    remove_callbackset(_loc_25);
                                }
                            }
                            _loc_11 = _loc_11.next;
                        }
                        _loc_10 = _loc_10.next;
                    }
                }
                param1.fresh = false;
                param1.intchange = false;
            }
            if (!param1.cleared)
            {
            }
            if (param1.up_stamp + (param1.type == ZPP_Arbiter.COL ? (Config.arbiterExpirationDelay) : (0)) < stamp)
            {
                if (param1.type == ZPP_Arbiter.SENSOR)
                {
                    _loc_38 = param1.sensorarb;
                    if (!_loc_38.cleared)
                    {
                        _loc_36 = _loc_38.b1.arbiters;
                        _loc_34 = null;
                        _loc_37 = _loc_36.head;
                        _loc_5 = false;
                        while (_loc_37 != null)
                        {
                            
                            if (_loc_37.elt == _loc_38)
                            {
                                if (_loc_34 == null)
                                {
                                    _loc_39 = _loc_36.head;
                                    _loc_40 = _loc_39.next;
                                    _loc_36.head = _loc_40;
                                    if (_loc_36.head == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_39 = _loc_34.next;
                                    _loc_40 = _loc_39.next;
                                    _loc_34.next = _loc_40;
                                    if (_loc_40 == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                _loc_41 = _loc_39;
                                _loc_41.elt = null;
                                _loc_41.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_41;
                                _loc_36.modified = true;
                                (_loc_36.length - 1);
                                _loc_36.pushmod = true;
                                _loc_5 = true;
                                break;
                            }
                            _loc_34 = _loc_37;
                            _loc_37 = _loc_37.next;
                        }
                        _loc_36 = _loc_38.b2.arbiters;
                        _loc_34 = null;
                        _loc_37 = _loc_36.head;
                        _loc_5 = false;
                        while (_loc_37 != null)
                        {
                            
                            if (_loc_37.elt == _loc_38)
                            {
                                if (_loc_34 == null)
                                {
                                    _loc_39 = _loc_36.head;
                                    _loc_40 = _loc_39.next;
                                    _loc_36.head = _loc_40;
                                    if (_loc_36.head == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_39 = _loc_34.next;
                                    _loc_40 = _loc_39.next;
                                    _loc_34.next = _loc_40;
                                    if (_loc_40 == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                _loc_41 = _loc_39;
                                _loc_41.elt = null;
                                _loc_41.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_41;
                                _loc_36.modified = true;
                                (_loc_36.length - 1);
                                _loc_36.pushmod = true;
                                _loc_5 = true;
                                break;
                            }
                            _loc_34 = _loc_37;
                            _loc_37 = _loc_37.next;
                        }
                        if (_loc_38.pair != null)
                        {
                            _loc_38.pair.arb = null;
                            _loc_38.pair = null;
                        }
                    }
                    _loc_42 = null;
                    _loc_38.b2 = _loc_42;
                    _loc_38.b1 = _loc_42;
                    _loc_38.active = false;
                    _loc_38.intchange = false;
                    _loc_43 = _loc_38;
                    _loc_43.next = ZPP_SensorArbiter.zpp_pool;
                    ZPP_SensorArbiter.zpp_pool = _loc_43;
                }
                else if (param1.type == ZPP_Arbiter.FLUID)
                {
                    _loc_44 = param1.fluidarb;
                    if (!_loc_44.cleared)
                    {
                        _loc_36 = _loc_44.b1.arbiters;
                        _loc_34 = null;
                        _loc_37 = _loc_36.head;
                        _loc_5 = false;
                        while (_loc_37 != null)
                        {
                            
                            if (_loc_37.elt == _loc_44)
                            {
                                if (_loc_34 == null)
                                {
                                    _loc_39 = _loc_36.head;
                                    _loc_40 = _loc_39.next;
                                    _loc_36.head = _loc_40;
                                    if (_loc_36.head == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_39 = _loc_34.next;
                                    _loc_40 = _loc_39.next;
                                    _loc_34.next = _loc_40;
                                    if (_loc_40 == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                _loc_41 = _loc_39;
                                _loc_41.elt = null;
                                _loc_41.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_41;
                                _loc_36.modified = true;
                                (_loc_36.length - 1);
                                _loc_36.pushmod = true;
                                _loc_5 = true;
                                break;
                            }
                            _loc_34 = _loc_37;
                            _loc_37 = _loc_37.next;
                        }
                        _loc_36 = _loc_44.b2.arbiters;
                        _loc_34 = null;
                        _loc_37 = _loc_36.head;
                        _loc_5 = false;
                        while (_loc_37 != null)
                        {
                            
                            if (_loc_37.elt == _loc_44)
                            {
                                if (_loc_34 == null)
                                {
                                    _loc_39 = _loc_36.head;
                                    _loc_40 = _loc_39.next;
                                    _loc_36.head = _loc_40;
                                    if (_loc_36.head == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_39 = _loc_34.next;
                                    _loc_40 = _loc_39.next;
                                    _loc_34.next = _loc_40;
                                    if (_loc_40 == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                _loc_41 = _loc_39;
                                _loc_41.elt = null;
                                _loc_41.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_41;
                                _loc_36.modified = true;
                                (_loc_36.length - 1);
                                _loc_36.pushmod = true;
                                _loc_5 = true;
                                break;
                            }
                            _loc_34 = _loc_37;
                            _loc_37 = _loc_37.next;
                        }
                        if (_loc_44.pair != null)
                        {
                            _loc_44.pair.arb = null;
                            _loc_44.pair = null;
                        }
                    }
                    _loc_42 = null;
                    _loc_44.b2 = _loc_42;
                    _loc_44.b1 = _loc_42;
                    _loc_44.active = false;
                    _loc_44.intchange = false;
                    _loc_45 = _loc_44;
                    _loc_45.next = ZPP_FluidArbiter.zpp_pool;
                    ZPP_FluidArbiter.zpp_pool = _loc_45;
                    _loc_44.pre_dt = -1;
                }
                else
                {
                    _loc_46 = param1.colarb;
                    if (!_loc_46.cleared)
                    {
                        _loc_36 = _loc_46.b1.arbiters;
                        _loc_34 = null;
                        _loc_37 = _loc_36.head;
                        _loc_5 = false;
                        while (_loc_37 != null)
                        {
                            
                            if (_loc_37.elt == _loc_46)
                            {
                                if (_loc_34 == null)
                                {
                                    _loc_39 = _loc_36.head;
                                    _loc_40 = _loc_39.next;
                                    _loc_36.head = _loc_40;
                                    if (_loc_36.head == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_39 = _loc_34.next;
                                    _loc_40 = _loc_39.next;
                                    _loc_34.next = _loc_40;
                                    if (_loc_40 == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                _loc_41 = _loc_39;
                                _loc_41.elt = null;
                                _loc_41.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_41;
                                _loc_36.modified = true;
                                (_loc_36.length - 1);
                                _loc_36.pushmod = true;
                                _loc_5 = true;
                                break;
                            }
                            _loc_34 = _loc_37;
                            _loc_37 = _loc_37.next;
                        }
                        _loc_36 = _loc_46.b2.arbiters;
                        _loc_34 = null;
                        _loc_37 = _loc_36.head;
                        _loc_5 = false;
                        while (_loc_37 != null)
                        {
                            
                            if (_loc_37.elt == _loc_46)
                            {
                                if (_loc_34 == null)
                                {
                                    _loc_39 = _loc_36.head;
                                    _loc_40 = _loc_39.next;
                                    _loc_36.head = _loc_40;
                                    if (_loc_36.head == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_39 = _loc_34.next;
                                    _loc_40 = _loc_39.next;
                                    _loc_34.next = _loc_40;
                                    if (_loc_40 == null)
                                    {
                                        _loc_36.pushmod = true;
                                    }
                                }
                                _loc_41 = _loc_39;
                                _loc_41.elt = null;
                                _loc_41.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_41;
                                _loc_36.modified = true;
                                (_loc_36.length - 1);
                                _loc_36.pushmod = true;
                                _loc_5 = true;
                                break;
                            }
                            _loc_34 = _loc_37;
                            _loc_37 = _loc_37.next;
                        }
                        if (_loc_46.pair != null)
                        {
                            _loc_46.pair.arb = null;
                            _loc_46.pair = null;
                        }
                    }
                    _loc_42 = null;
                    _loc_46.b2 = _loc_42;
                    _loc_46.b1 = _loc_42;
                    _loc_46.active = false;
                    _loc_46.intchange = false;
                    while (_loc_46.contacts.next != null)
                    {
                        
                        _loc_48 = _loc_46.contacts;
                        _loc_49 = _loc_48.next;
                        _loc_48.pop();
                        _loc_47 = _loc_49;
                        _loc_47.arbiter = null;
                        _loc_47.next = ZPP_Contact.zpp_pool;
                        ZPP_Contact.zpp_pool = _loc_47;
                        _loc_50 = _loc_46.innards;
                        _loc_51 = _loc_50.next;
                        _loc_50.next = _loc_51.next;
                        _loc_51._inuse = false;
                        if (_loc_50.next == null)
                        {
                            _loc_50.pushmod = true;
                        }
                        _loc_50.modified = true;
                        (_loc_50.length - 1);
                    }
                    _loc_52 = _loc_46;
                    _loc_52.userdef_dyn_fric = false;
                    _loc_52.userdef_stat_fric = false;
                    _loc_52.userdef_restitution = false;
                    _loc_52.userdef_rfric = false;
                    _loc_53 = null;
                    _loc_52.__ref_edge2 = _loc_53;
                    _loc_52.__ref_edge1 = _loc_53;
                    _loc_52.next = ZPP_ColArbiter.zpp_pool;
                    ZPP_ColArbiter.zpp_pool = _loc_52;
                    _loc_46.pre_dt = -1;
                }
                return true;
            }
            _loc_5 = param1.active;
            _loc_6 = param1.up_stamp == stamp;
            param1.presentable = _loc_6;
            param1.active = _loc_6;
            if ((param1.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
            {
                if (param1.active)
                {
                }
                if (param1.type != ZPP_Arbiter.SENSOR)
                {
                    if (param1.colarb != null)
                    {
                        _loc_46 = param1.colarb;
                        if (_loc_46.invalidated)
                        {
                            _loc_46.invalidated = false;
                            if (!_loc_46.userdef_restitution)
                            {
                                if (_loc_46.s1.material.elasticity > -17899999999999994000000000000)
                                {
                                }
                                if (_loc_46.s2.material.elasticity <= -17899999999999994000000000000)
                                {
                                    _loc_46.restitution = 0;
                                }
                                else
                                {
                                    if (_loc_46.s1.material.elasticity < 17899999999999994000000000000)
                                    {
                                    }
                                    if (_loc_46.s2.material.elasticity >= 17899999999999994000000000000)
                                    {
                                        _loc_46.restitution = 1;
                                    }
                                    else
                                    {
                                        _loc_46.restitution = (_loc_46.s1.material.elasticity + _loc_46.s2.material.elasticity) / 2;
                                    }
                                }
                                if (_loc_46.restitution < 0)
                                {
                                    _loc_46.restitution = 0;
                                }
                                if (_loc_46.restitution > 1)
                                {
                                    _loc_46.restitution = 1;
                                }
                            }
                            if (!_loc_46.userdef_dyn_fric)
                            {
                                _loc_54 = _loc_46.s1.material.dynamicFriction * _loc_46.s2.material.dynamicFriction;
                                if (_loc_54 == 0)
                                {
                                    _loc_46.dyn_fric = 0;
                                }
                                else
                                {
                                    _loc_15 = 1597463007 - (0 >> 1);
                                    _loc_55 = 0;
                                    _loc_15.dyn_fric = 0 / (_loc_55 * (1.5 - 0.5 * _loc_54 * _loc_55 * _loc_55));
                                }
                            }
                            if (!_loc_46.userdef_stat_fric)
                            {
                                _loc_54 = _loc_46.s1.material.staticFriction * _loc_46.s2.material.staticFriction;
                                if (_loc_54 == 0)
                                {
                                    _loc_46.stat_fric = 0;
                                }
                                else
                                {
                                    _loc_15 = 1597463007 - (0 >> 1);
                                    _loc_55 = 0;
                                    _loc_15.stat_fric = 0 / (_loc_55 * (1.5 - 0.5 * _loc_54 * _loc_55 * _loc_55));
                                }
                            }
                            if (!_loc_46.userdef_rfric)
                            {
                                _loc_54 = _loc_46.s1.material.rollingFriction * _loc_46.s2.material.rollingFriction;
                                if (_loc_54 == 0)
                                {
                                    _loc_46.rfric = 0;
                                }
                                else
                                {
                                    _loc_15 = 1597463007 - (0 >> 1);
                                    _loc_55 = 0;
                                    _loc_15.rfric = 0 / (_loc_55 * (1.5 - 0.5 * _loc_54 * _loc_55 * _loc_55));
                                }
                            }
                        }
                        if (_loc_46.pre_dt == -1)
                        {
                            _loc_46.pre_dt = param2;
                        }
                        _loc_54 = param2 / _loc_46.pre_dt;
                        _loc_46.pre_dt = param2;
                        _loc_55 = _loc_46.b1.smass + _loc_46.b2.smass;
                        _loc_46.hc2 = false;
                        _loc_6 = true;
                        if (_loc_46.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                        }
                        _loc_33 = _loc_46.b2.type != ZPP_Flags.id_BodyType_DYNAMIC;
                        if (_loc_33)
                        {
                            if (_loc_46.continuous)
                            {
                                _loc_56 = Config.contactContinuousStaticBiasCoef;
                            }
                            else
                            {
                                _loc_56 = Config.contactStaticBiasCoef;
                            }
                        }
                        else if (_loc_46.continuous)
                        {
                            _loc_56 = Config.contactContinuousBiasCoef;
                        }
                        else
                        {
                            _loc_56 = Config.contactBiasCoef;
                        }
                        _loc_46.biasCoef = _loc_56;
                        _loc_46.continuous = false;
                        _loc_47 = null;
                        _loc_50 = null;
                        _loc_51 = _loc_46.innards.next;
                        _loc_48 = _loc_46.contacts.next;
                        while (_loc_48 != null)
                        {
                            
                            _loc_49 = _loc_48;
                            if (_loc_49.stamp + Config.arbiterExpirationDelay < _loc_46.stamp)
                            {
                                _loc_57 = _loc_46.contacts;
                                if (_loc_47 == null)
                                {
                                    _loc_58 = _loc_57.next;
                                    _loc_59 = _loc_58.next;
                                    _loc_57.next = _loc_59;
                                    if (_loc_57.next == null)
                                    {
                                        _loc_57.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_58 = _loc_47.next;
                                    _loc_59 = _loc_58.next;
                                    _loc_47.next = _loc_59;
                                    if (_loc_59 == null)
                                    {
                                        _loc_57.pushmod = true;
                                    }
                                }
                                _loc_58._inuse = false;
                                _loc_57.modified = true;
                                (_loc_57.length - 1);
                                _loc_57.pushmod = true;
                                _loc_48 = _loc_59;
                                _loc_60 = _loc_46.innards;
                                if (_loc_50 == null)
                                {
                                    _loc_61 = _loc_60.next;
                                    _loc_62 = _loc_61.next;
                                    _loc_60.next = _loc_62;
                                    if (_loc_60.next == null)
                                    {
                                        _loc_60.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_61 = _loc_50.next;
                                    _loc_62 = _loc_61.next;
                                    _loc_50.next = _loc_62;
                                    if (_loc_62 == null)
                                    {
                                        _loc_60.pushmod = true;
                                    }
                                }
                                _loc_61._inuse = false;
                                _loc_60.modified = true;
                                (_loc_60.length - 1);
                                _loc_60.pushmod = true;
                                _loc_51 = _loc_62;
                                _loc_57 = _loc_49;
                                _loc_57.arbiter = null;
                                _loc_57.next = ZPP_Contact.zpp_pool;
                                ZPP_Contact.zpp_pool = _loc_57;
                                continue;
                            }
                            _loc_60 = _loc_49.inner;
                            _loc_63 = _loc_49.active;
                            _loc_49.active = _loc_49.stamp == _loc_46.stamp;
                            if (_loc_49.active)
                            {
                                if (_loc_6)
                                {
                                    _loc_6 = false;
                                    _loc_46.c1 = _loc_60;
                                    _loc_46.oc1 = _loc_49;
                                }
                                else
                                {
                                    _loc_46.hc2 = true;
                                    _loc_46.c2 = _loc_60;
                                    _loc_46.oc2 = _loc_49;
                                }
                                _loc_60.r2x = _loc_49.px - _loc_46.b2.posx;
                                _loc_60.r2y = _loc_49.py - _loc_46.b2.posy;
                                _loc_60.r1x = _loc_49.px - _loc_46.b1.posx;
                                _loc_60.r1y = _loc_49.py - _loc_46.b1.posy;
                                _loc_65 = _loc_60.r2x * _loc_46.nx + _loc_60.r2y * _loc_46.ny;
                                _loc_64 = _loc_55 + _loc_46.b2.sinertia * (_loc_65 * _loc_65);
                                _loc_65 = _loc_60.r1x * _loc_46.nx + _loc_60.r1y * _loc_46.ny;
                                _loc_64 = _loc_64 + _loc_46.b1.sinertia * (_loc_65 * _loc_65);
                                if (_loc_64 < Config.epsilon * Config.epsilon)
                                {
                                    _loc_60.tMass = 0;
                                }
                                else
                                {
                                    _loc_60.tMass = 1 / _loc_64;
                                }
                                _loc_66 = _loc_46.ny * _loc_60.r2x - _loc_46.nx * _loc_60.r2y;
                                _loc_65 = _loc_55 + _loc_46.b2.sinertia * (_loc_66 * _loc_66);
                                _loc_66 = _loc_46.ny * _loc_60.r1x - _loc_46.nx * _loc_60.r1y;
                                _loc_65 = _loc_65 + _loc_46.b1.sinertia * (_loc_66 * _loc_66);
                                if (_loc_65 < Config.epsilon * Config.epsilon)
                                {
                                    _loc_60.nMass = 0;
                                }
                                else
                                {
                                    _loc_60.nMass = 1 / _loc_65;
                                }
                                _loc_66 = 0;
                                _loc_67 = 0;
                                _loc_68 = _loc_46.b2.angvel + _loc_46.b2.kinangvel;
                                _loc_66 = _loc_46.b2.velx + _loc_46.b2.kinvelx - _loc_60.r2y * _loc_68;
                                _loc_67 = _loc_46.b2.vely + _loc_46.b2.kinvely + _loc_60.r2x * _loc_68;
                                _loc_68 = _loc_46.b1.angvel + _loc_46.b1.kinangvel;
                                _loc_66 = _loc_66 - (_loc_46.b1.velx + _loc_46.b1.kinvelx - _loc_60.r1y * _loc_68);
                                _loc_67 = _loc_67 - (_loc_46.b1.vely + _loc_46.b1.kinvely + _loc_60.r1x * _loc_68);
                                _loc_68 = _loc_46.nx * _loc_66 + _loc_46.ny * _loc_67;
                                _loc_49.elasticity = _loc_46.restitution;
                                _loc_60.bounce = _loc_68 * _loc_49.elasticity;
                                if (_loc_60.bounce > -Config.elasticThreshold)
                                {
                                    _loc_60.bounce = 0;
                                }
                                _loc_68 = _loc_67 * _loc_46.nx - _loc_66 * _loc_46.ny;
                                _loc_69 = Config.staticFrictionThreshold;
                                if (_loc_68 * _loc_68 > _loc_69 * _loc_69)
                                {
                                    _loc_60.friction = _loc_46.dyn_fric;
                                }
                                else
                                {
                                    _loc_60.friction = _loc_46.stat_fric;
                                }
                                _loc_60.jnAcc = _loc_60.jnAcc * _loc_54;
                                _loc_60.jtAcc = _loc_60.jtAcc * _loc_54;
                            }
                            if (_loc_63 != _loc_49.active)
                            {
                                _loc_46.contacts.modified = true;
                            }
                            _loc_47 = _loc_48;
                            _loc_50 = _loc_51;
                            _loc_51 = _loc_51.next;
                            _loc_48 = _loc_48.next;
                        }
                        if (_loc_46.hc2)
                        {
                            _loc_46.hpc2 = true;
                            if (_loc_46.oc1.posOnly)
                            {
                                _loc_60 = _loc_46.c1;
                                _loc_46.c1 = _loc_46.c2;
                                _loc_46.c2 = _loc_60;
                                _loc_48 = _loc_46.oc1;
                                _loc_46.oc1 = _loc_46.oc2;
                                _loc_46.oc2 = _loc_48;
                                _loc_46.hc2 = false;
                            }
                            else if (_loc_46.oc2.posOnly)
                            {
                                _loc_46.hc2 = false;
                            }
                            if (_loc_46.oc1.posOnly)
                            {
                                _loc_6 = true;
                            }
                        }
                        else
                        {
                            _loc_46.hpc2 = false;
                        }
                        _loc_46.jrAcc = _loc_46.jrAcc * _loc_54;
                        if (!_loc_6)
                        {
                            _loc_46.rn1a = _loc_46.ny * _loc_46.c1.r1x - _loc_46.nx * _loc_46.c1.r1y;
                            _loc_46.rt1a = _loc_46.c1.r1x * _loc_46.nx + _loc_46.c1.r1y * _loc_46.ny;
                            _loc_46.rn1b = _loc_46.ny * _loc_46.c1.r2x - _loc_46.nx * _loc_46.c1.r2y;
                            _loc_46.rt1b = _loc_46.c1.r2x * _loc_46.nx + _loc_46.c1.r2y * _loc_46.ny;
                            _loc_46.k1x = _loc_46.b2.kinvelx - _loc_46.c1.r2y * _loc_46.b2.kinangvel - (_loc_46.b1.kinvelx - _loc_46.c1.r1y * _loc_46.b1.kinangvel);
                            _loc_46.k1y = _loc_46.b2.kinvely + _loc_46.c1.r2x * _loc_46.b2.kinangvel - (_loc_46.b1.kinvely + _loc_46.c1.r1x * _loc_46.b1.kinangvel);
                        }
                        if (_loc_46.hc2)
                        {
                            _loc_46.rn2a = _loc_46.ny * _loc_46.c2.r1x - _loc_46.nx * _loc_46.c2.r1y;
                            _loc_46.rt2a = _loc_46.c2.r1x * _loc_46.nx + _loc_46.c2.r1y * _loc_46.ny;
                            _loc_46.rn2b = _loc_46.ny * _loc_46.c2.r2x - _loc_46.nx * _loc_46.c2.r2y;
                            _loc_46.rt2b = _loc_46.c2.r2x * _loc_46.nx + _loc_46.c2.r2y * _loc_46.ny;
                            _loc_46.k2x = _loc_46.b2.kinvelx - _loc_46.c2.r2y * _loc_46.b2.kinangvel - (_loc_46.b1.kinvelx - _loc_46.c2.r1y * _loc_46.b1.kinangvel);
                            _loc_46.k2y = _loc_46.b2.kinvely + _loc_46.c2.r2x * _loc_46.b2.kinangvel - (_loc_46.b1.kinvely + _loc_46.c2.r1x * _loc_46.b1.kinangvel);
                            _loc_46.kMassa = _loc_55 + _loc_46.b1.sinertia * _loc_46.rn1a * _loc_46.rn1a + _loc_46.b2.sinertia * _loc_46.rn1b * _loc_46.rn1b;
                            _loc_46.kMassb = _loc_55 + _loc_46.b1.sinertia * _loc_46.rn1a * _loc_46.rn2a + _loc_46.b2.sinertia * _loc_46.rn1b * _loc_46.rn2b;
                            _loc_46.kMassc = _loc_55 + _loc_46.b1.sinertia * _loc_46.rn2a * _loc_46.rn2a + _loc_46.b2.sinertia * _loc_46.rn2b * _loc_46.rn2b;
                            _loc_64 = _loc_46.kMassa * _loc_46.kMassa + 2 * _loc_46.kMassb * _loc_46.kMassb + _loc_46.kMassc * _loc_46.kMassc;
                            if (_loc_64 < Config.illConditionedThreshold * (_loc_46.kMassa * _loc_46.kMassc - _loc_46.kMassb * _loc_46.kMassb))
                            {
                                _loc_46.Ka = _loc_46.kMassa;
                                _loc_46.Kb = _loc_46.kMassb;
                                _loc_46.Kc = _loc_46.kMassc;
                                _loc_65 = _loc_46.kMassa * _loc_46.kMassc - _loc_46.kMassb * _loc_46.kMassb;
                                if (_loc_65 != _loc_65)
                                {
                                    _loc_66 = 0;
                                    _loc_46.kMassc = _loc_66;
                                    _loc_66 = _loc_66;
                                    _loc_46.kMassb = _loc_66;
                                    _loc_46.kMassa = _loc_66;
                                }
                                else if (_loc_65 == 0)
                                {
                                    _loc_15 = 0;
                                    if (_loc_46.kMassa != 0)
                                    {
                                        _loc_46.kMassa = 1 / _loc_46.kMassa;
                                    }
                                    else
                                    {
                                        _loc_46.kMassa = 0;
                                        _loc_15 = _loc_15 | 1;
                                    }
                                    if (_loc_46.kMassc != 0)
                                    {
                                        _loc_46.kMassc = 1 / _loc_46.kMassc;
                                    }
                                    else
                                    {
                                        _loc_46.kMassc = 0;
                                        _loc_15 = _loc_15 | 2;
                                    }
                                    _loc_46.kMassb = 0;
                                }
                                else
                                {
                                    _loc_65 = 1 / _loc_65;
                                    _loc_66 = _loc_46.kMassc * _loc_65;
                                    _loc_46.kMassc = _loc_46.kMassa * _loc_65;
                                    _loc_46.kMassa = _loc_66;
                                    _loc_46.kMassb = _loc_46.kMassb * (-_loc_65);
                                }
                            }
                            else
                            {
                                _loc_46.hc2 = false;
                                if (_loc_46.oc2.dist < _loc_46.oc1.dist)
                                {
                                    _loc_60 = _loc_46.c1;
                                    _loc_46.c1 = _loc_46.c2;
                                    _loc_46.c2 = _loc_60;
                                }
                                _loc_46.oc2.active = false;
                                _loc_46.contacts.modified = true;
                            }
                        }
                        _loc_46.surfacex = _loc_46.b2.svelx;
                        _loc_46.surfacey = _loc_46.b2.svely;
                        _loc_64 = 1;
                        _loc_46.surfacex = _loc_46.surfacex + _loc_46.b1.svelx * _loc_64;
                        _loc_46.surfacey = _loc_46.surfacey + _loc_46.b1.svely * _loc_64;
                        _loc_46.surfacex = -_loc_46.surfacex;
                        _loc_46.surfacey = -_loc_46.surfacey;
                        _loc_46.rMass = _loc_46.b1.sinertia + _loc_46.b2.sinertia;
                        if (_loc_46.rMass != 0)
                        {
                            _loc_46.rMass = 1 / _loc_46.rMass;
                        }
                        if (_loc_6)
                        {
                            param1.active = false;
                        }
                    }
                    else
                    {
                        _loc_44 = param1.fluidarb;
                        if (_loc_44.pre_dt == -1)
                        {
                            _loc_44.pre_dt = param2;
                        }
                        _loc_54 = param2 / _loc_44.pre_dt;
                        _loc_44.pre_dt = param2;
                        _loc_44.r1x = _loc_44.centroidx - _loc_44.b1.posx;
                        _loc_44.r1y = _loc_44.centroidy - _loc_44.b1.posy;
                        _loc_44.r2x = _loc_44.centroidx - _loc_44.b2.posx;
                        _loc_44.r2y = _loc_44.centroidy - _loc_44.b2.posy;
                        _loc_55 = 0;
                        _loc_56 = 0;
                        if (_loc_44.ws1.fluidEnabled)
                        {
                        }
                        if (_loc_44.ws1.fluidProperties.wrap_gravity != null)
                        {
                            _loc_55 = _loc_44.ws1.fluidProperties.gravityx;
                            _loc_56 = _loc_44.ws1.fluidProperties.gravityy;
                        }
                        else
                        {
                            _loc_55 = gravityx;
                            _loc_56 = gravityy;
                        }
                        _loc_64 = 0;
                        _loc_65 = 0;
                        if (_loc_44.ws2.fluidEnabled)
                        {
                        }
                        if (_loc_44.ws2.fluidProperties.wrap_gravity != null)
                        {
                            _loc_64 = _loc_44.ws2.fluidProperties.gravityx;
                            _loc_65 = _loc_44.ws2.fluidProperties.gravityy;
                        }
                        else
                        {
                            _loc_64 = gravityx;
                            _loc_65 = gravityy;
                        }
                        _loc_66 = 0;
                        _loc_67 = 0;
                        if (_loc_44.ws1.fluidEnabled)
                        {
                        }
                        if (_loc_44.ws2.fluidEnabled)
                        {
                            _loc_68 = _loc_44.overlap * _loc_44.ws1.fluidProperties.density;
                            _loc_69 = _loc_44.overlap * _loc_44.ws2.fluidProperties.density;
                            if (_loc_68 > _loc_69)
                            {
                                _loc_70 = _loc_68 + _loc_69;
                                _loc_66 = _loc_66 - _loc_55 * _loc_70;
                                _loc_67 = _loc_67 - _loc_56 * _loc_70;
                            }
                            else if (_loc_68 < _loc_69)
                            {
                                _loc_70 = _loc_68 + _loc_69;
                                _loc_66 = _loc_66 + _loc_64 * _loc_70;
                                _loc_67 = _loc_67 + _loc_65 * _loc_70;
                            }
                            else
                            {
                                _loc_70 = 0;
                                _loc_71 = 0;
                                _loc_70 = _loc_55 + _loc_64;
                                _loc_71 = _loc_56 + _loc_65;
                                _loc_72 = 0.5;
                                _loc_70 = _loc_70 * _loc_72;
                                _loc_71 = _loc_71 * _loc_72;
                                if (_loc_44.ws1.worldCOMx * _loc_70 + _loc_44.ws1.worldCOMy * _loc_71 > _loc_44.ws2.worldCOMx * _loc_70 + _loc_44.ws2.worldCOMy * _loc_71)
                                {
                                    _loc_72 = _loc_68 + _loc_69;
                                    _loc_66 = _loc_66 - _loc_70 * _loc_72;
                                    _loc_67 = _loc_67 - _loc_71 * _loc_72;
                                }
                                else
                                {
                                    _loc_72 = _loc_68 + _loc_69;
                                    _loc_66 = _loc_66 + _loc_70 * _loc_72;
                                    _loc_67 = _loc_67 + _loc_71 * _loc_72;
                                }
                            }
                        }
                        else if (_loc_44.ws1.fluidEnabled)
                        {
                            _loc_68 = _loc_44.overlap * _loc_44.ws1.fluidProperties.density;
                            _loc_69 = _loc_68;
                            _loc_66 = _loc_66 - _loc_55 * _loc_69;
                            _loc_67 = _loc_67 - _loc_56 * _loc_69;
                        }
                        else if (_loc_44.ws2.fluidEnabled)
                        {
                            _loc_68 = _loc_44.overlap * _loc_44.ws2.fluidProperties.density;
                            _loc_69 = _loc_68;
                            _loc_66 = _loc_66 + _loc_64 * _loc_69;
                            _loc_67 = _loc_67 + _loc_65 * _loc_69;
                        }
                        _loc_68 = param2;
                        _loc_66 = _loc_66 * _loc_68;
                        _loc_67 = _loc_67 * _loc_68;
                        _loc_44.buoyx = _loc_66;
                        _loc_44.buoyy = _loc_67;
                        if (_loc_44.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                            _loc_68 = _loc_44.b1.imass;
                            _loc_44.b1.velx = _loc_44.b1.velx - _loc_66 * _loc_68;
                            _loc_44.b1.vely = _loc_44.b1.vely - _loc_67 * _loc_68;
                            _loc_44.b1.angvel = _loc_44.b1.angvel - (_loc_67 * _loc_44.r1x - _loc_66 * _loc_44.r1y) * _loc_44.b1.iinertia;
                        }
                        if (_loc_44.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                            _loc_68 = _loc_44.b2.imass;
                            _loc_44.b2.velx = _loc_44.b2.velx + _loc_66 * _loc_68;
                            _loc_44.b2.vely = _loc_44.b2.vely + _loc_67 * _loc_68;
                            _loc_44.b2.angvel = _loc_44.b2.angvel + (_loc_67 * _loc_44.r2x - _loc_66 * _loc_44.r2y) * _loc_44.b2.iinertia;
                        }
                        if (_loc_44.ws1.fluidEnabled)
                        {
                        }
                        if (_loc_44.ws1.fluidProperties.viscosity == 0)
                        {
                            if (_loc_44.ws2.fluidEnabled)
                            {
                            }
                        }
                        if (_loc_44.ws2.fluidProperties.viscosity == 0)
                        {
                            _loc_44.nodrag = true;
                            _loc_44.dampx = 0;
                            _loc_44.dampy = 0;
                            _loc_44.adamp = 0;
                        }
                        else
                        {
                            _loc_44.nodrag = false;
                            _loc_68 = 0;
                            if (_loc_44.ws1.fluidEnabled)
                            {
                                _loc_44.ws2.validate_angDrag();
                                _loc_68 = _loc_68 + _loc_44.ws1.fluidProperties.viscosity * _loc_44.ws2.angDrag * _loc_44.overlap / _loc_44.ws2.area;
                            }
                            if (_loc_44.ws2.fluidEnabled)
                            {
                                _loc_44.ws1.validate_angDrag();
                                _loc_68 = _loc_68 + _loc_44.ws2.fluidProperties.viscosity * _loc_44.ws1.angDrag * _loc_44.overlap / _loc_44.ws1.area;
                            }
                            if (_loc_68 != 0)
                            {
                                _loc_69 = _loc_44.b1.sinertia + _loc_44.b2.sinertia;
                                if (_loc_69 != 0)
                                {
                                    _loc_44.wMass = 1 / _loc_69;
                                }
                                else
                                {
                                    _loc_44.wMass = 0;
                                }
                                _loc_68 = _loc_68 * 0.0004;
                                _loc_71 = 2 * Math.PI * _loc_68;
                                _loc_44.agamma = 1 / (param2 * _loc_71 * (2 + _loc_71 * param2));
                                _loc_72 = 1 / (1 + _loc_44.agamma);
                                _loc_70 = param2 * _loc_71 * _loc_71 * _loc_44.agamma;
                                _loc_44.agamma = _loc_44.agamma * _loc_72;
                                _loc_44.wMass = _loc_44.wMass * _loc_72;
                            }
                            else
                            {
                                _loc_44.wMass = 0;
                                _loc_44.agamma = 0;
                            }
                            _loc_69 = _loc_44.b2.velx + _loc_44.b2.kinvelx - _loc_44.r2y * (_loc_44.b2.angvel + _loc_44.b2.kinangvel) - (_loc_44.b1.velx + _loc_44.b1.kinvelx - _loc_44.r1y * (_loc_44.b2.angvel + _loc_44.b2.kinangvel));
                            _loc_70 = _loc_44.b2.vely + _loc_44.b2.kinvely + _loc_44.r2x * (_loc_44.b2.angvel + _loc_44.b2.kinangvel) - (_loc_44.b1.vely + _loc_44.b1.kinvely + _loc_44.r1x * (_loc_44.b1.angvel + _loc_44.b1.kinangvel));
                            if (_loc_69 * _loc_69 + _loc_70 * _loc_70 < Config.epsilon * Config.epsilon)
                            {
                            }
                            else
                            {
                                _loc_71 = _loc_69 * _loc_69 + _loc_70 * _loc_70;
                                _loc_15 = 1597463007 - (0 >> 1);
                                _loc_73 = 0;
                                _loc_72 = _loc_73 * (1.5 - 0.5 * _loc_71 * _loc_73 * _loc_73);
                                _loc_73 = _loc_72;
                                _loc_69 = _loc_69 * _loc_73;
                                _loc_70 = _loc_70 * _loc_73;
                                _loc_44.nx = _loc_69;
                                _loc_44.ny = _loc_70;
                            }
                            _loc_71 = 0;
                            if (_loc_44.ws1.fluidEnabled)
                            {
                                _loc_72 = (-_loc_44.ws1.fluidProperties.viscosity) * _loc_44.overlap / _loc_44.ws2.area;
                                if (_loc_44.ws2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                {
                                    _loc_71 = _loc_71 - _loc_72 * _loc_44.ws2.circle.radius * Config.fluidLinearDrag / (2 * _loc_44.ws2.circle.radius * Math.PI);
                                }
                                else
                                {
                                    _loc_74 = _loc_44.ws2.polygon;
                                    _loc_73 = 0;
                                    _loc_75 = 0;
                                    _loc_76 = _loc_74.edges.head;
                                    while (_loc_76 != null)
                                    {
                                        
                                        _loc_53 = _loc_76.elt;
                                        _loc_73 = _loc_73 + _loc_53.length;
                                        _loc_77 = _loc_72 * _loc_53.length * (_loc_53.gnormx * _loc_44.nx + _loc_53.gnormy * _loc_44.ny);
                                        if (_loc_77 > 0)
                                        {
                                            _loc_77 = _loc_77 * (-Config.fluidVacuumDrag);
                                            _loc_77 = _loc_77;
                                        }
                                        _loc_75 = _loc_75 - _loc_77 * 0.5 * Config.fluidLinearDrag;
                                        _loc_76 = _loc_76.next;
                                    }
                                    _loc_71 = _loc_71 + _loc_75 / _loc_73;
                                }
                            }
                            if (_loc_44.ws2.fluidEnabled)
                            {
                                _loc_72 = (-_loc_44.ws2.fluidProperties.viscosity) * _loc_44.overlap / _loc_44.ws1.area;
                                if (_loc_44.ws1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                {
                                    _loc_71 = _loc_71 - _loc_72 * _loc_44.ws1.circle.radius * Config.fluidLinearDrag / (2 * _loc_44.ws1.circle.radius * Math.PI);
                                }
                                else
                                {
                                    _loc_74 = _loc_44.ws1.polygon;
                                    _loc_73 = 0;
                                    _loc_75 = 0;
                                    _loc_76 = _loc_74.edges.head;
                                    while (_loc_76 != null)
                                    {
                                        
                                        _loc_53 = _loc_76.elt;
                                        _loc_73 = _loc_73 + _loc_53.length;
                                        _loc_77 = _loc_72 * _loc_53.length * (_loc_53.gnormx * _loc_44.nx + _loc_53.gnormy * _loc_44.ny);
                                        if (_loc_77 > 0)
                                        {
                                            _loc_77 = _loc_77 * (-Config.fluidVacuumDrag);
                                            _loc_77 = _loc_77;
                                        }
                                        _loc_75 = _loc_75 - _loc_77 * 0.5 * Config.fluidLinearDrag;
                                        _loc_76 = _loc_76.next;
                                    }
                                    _loc_71 = _loc_71 + _loc_75 / _loc_73;
                                }
                            }
                            if (_loc_71 != 0)
                            {
                                _loc_72 = _loc_44.b1.smass + _loc_44.b2.smass;
                                _loc_73 = 0;
                                _loc_75 = 0;
                                _loc_77 = 0;
                                _loc_73 = _loc_72;
                                _loc_75 = 0;
                                _loc_77 = _loc_72;
                                if (_loc_44.b1.sinertia != 0)
                                {
                                    _loc_78 = _loc_44.r1x * _loc_44.b1.sinertia;
                                    _loc_79 = _loc_44.r1y * _loc_44.b1.sinertia;
                                    _loc_73 = _loc_73 + _loc_79 * _loc_44.r1y;
                                    _loc_75 = _loc_75 + (-_loc_79) * _loc_44.r1x;
                                    _loc_77 = _loc_77 + _loc_78 * _loc_44.r1x;
                                }
                                if (_loc_44.b2.sinertia != 0)
                                {
                                    _loc_78 = _loc_44.r2x * _loc_44.b2.sinertia;
                                    _loc_79 = _loc_44.r2y * _loc_44.b2.sinertia;
                                    _loc_73 = _loc_73 + _loc_79 * _loc_44.r2y;
                                    _loc_75 = _loc_75 + (-_loc_79) * _loc_44.r2x;
                                    _loc_77 = _loc_77 + _loc_78 * _loc_44.r2x;
                                }
                                _loc_78 = _loc_73 * _loc_77 - _loc_75 * _loc_75;
                                if (_loc_78 != _loc_78)
                                {
                                    _loc_77 = 0;
                                    _loc_75 = _loc_77;
                                    _loc_73 = _loc_75;
                                }
                                else if (_loc_78 == 0)
                                {
                                    _loc_15 = 0;
                                    if (_loc_73 != 0)
                                    {
                                        _loc_73 = 1 / _loc_73;
                                    }
                                    else
                                    {
                                        _loc_73 = 0;
                                        _loc_15 = _loc_15 | 1;
                                    }
                                    if (_loc_77 != 0)
                                    {
                                        _loc_77 = 1 / _loc_77;
                                    }
                                    else
                                    {
                                        _loc_77 = 0;
                                        _loc_15 = _loc_15 | 2;
                                    }
                                    _loc_75 = 0;
                                }
                                else
                                {
                                    _loc_78 = 1 / _loc_78;
                                    _loc_79 = _loc_77 * _loc_78;
                                    _loc_77 = _loc_73 * _loc_78;
                                    _loc_73 = _loc_79;
                                    _loc_75 = _loc_75 * (-_loc_78);
                                }
                                _loc_44.vMassa = _loc_73;
                                _loc_44.vMassb = _loc_75;
                                _loc_44.vMassc = _loc_77;
                                _loc_80 = 2 * Math.PI * _loc_71;
                                _loc_44.lgamma = 1 / (param2 * _loc_80 * (2 + _loc_80 * param2));
                                _loc_81 = 1 / (1 + _loc_44.lgamma);
                                _loc_78 = param2 * _loc_80 * _loc_80 * _loc_44.lgamma;
                                _loc_44.lgamma = _loc_44.lgamma * _loc_81;
                                _loc_79 = _loc_81;
                                _loc_44.vMassa = _loc_44.vMassa * _loc_79;
                                _loc_44.vMassb = _loc_44.vMassb * _loc_79;
                                _loc_44.vMassc = _loc_44.vMassc * _loc_79;
                            }
                            else
                            {
                                _loc_44.vMassa = 0;
                                _loc_44.vMassb = 0;
                                _loc_44.vMassc = 0;
                                _loc_44.lgamma = 0;
                            }
                        }
                        _loc_68 = _loc_54;
                        _loc_44.dampx = _loc_44.dampx * _loc_68;
                        _loc_44.dampy = _loc_44.dampy * _loc_68;
                        _loc_44.adamp = _loc_44.adamp * _loc_54;
                    }
                }
            }
            else if (param1.colarb != null)
            {
                _loc_46 = param1.colarb;
                _loc_6 = true;
                _loc_47 = null;
                _loc_50 = null;
                _loc_51 = _loc_46.innards.next;
                _loc_46.hc2 = false;
                _loc_48 = _loc_46.contacts.next;
                while (_loc_48 != null)
                {
                    
                    _loc_49 = _loc_48;
                    if (_loc_49.stamp + Config.arbiterExpirationDelay < _loc_46.stamp)
                    {
                        _loc_57 = _loc_46.contacts;
                        if (_loc_47 == null)
                        {
                            _loc_58 = _loc_57.next;
                            _loc_59 = _loc_58.next;
                            _loc_57.next = _loc_59;
                            if (_loc_57.next == null)
                            {
                                _loc_57.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_58 = _loc_47.next;
                            _loc_59 = _loc_58.next;
                            _loc_47.next = _loc_59;
                            if (_loc_59 == null)
                            {
                                _loc_57.pushmod = true;
                            }
                        }
                        _loc_58._inuse = false;
                        _loc_57.modified = true;
                        (_loc_57.length - 1);
                        _loc_57.pushmod = true;
                        _loc_48 = _loc_59;
                        _loc_60 = _loc_46.innards;
                        if (_loc_50 == null)
                        {
                            _loc_61 = _loc_60.next;
                            _loc_62 = _loc_61.next;
                            _loc_60.next = _loc_62;
                            if (_loc_60.next == null)
                            {
                                _loc_60.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_61 = _loc_50.next;
                            _loc_62 = _loc_61.next;
                            _loc_50.next = _loc_62;
                            if (_loc_62 == null)
                            {
                                _loc_60.pushmod = true;
                            }
                        }
                        _loc_61._inuse = false;
                        _loc_60.modified = true;
                        (_loc_60.length - 1);
                        _loc_60.pushmod = true;
                        _loc_51 = _loc_62;
                        _loc_57 = _loc_49;
                        _loc_57.arbiter = null;
                        _loc_57.next = ZPP_Contact.zpp_pool;
                        ZPP_Contact.zpp_pool = _loc_57;
                        continue;
                    }
                    _loc_60 = _loc_49.inner;
                    _loc_33 = _loc_49.active;
                    _loc_49.active = _loc_49.stamp == _loc_46.stamp;
                    if (_loc_49.active)
                    {
                        if (_loc_6)
                        {
                            _loc_6 = false;
                            _loc_46.c1 = _loc_60;
                            _loc_46.oc1 = _loc_49;
                        }
                        else
                        {
                            _loc_46.hc2 = true;
                            _loc_46.c2 = _loc_60;
                            _loc_46.oc2 = _loc_49;
                        }
                    }
                    if (_loc_33 != _loc_49.active)
                    {
                        _loc_46.contacts.modified = true;
                    }
                    _loc_47 = _loc_48;
                    _loc_50 = _loc_51;
                    _loc_51 = _loc_51.next;
                    _loc_48 = _loc_48.next;
                }
                if (_loc_46.hc2)
                {
                    _loc_46.hpc2 = true;
                    if (_loc_46.oc1.posOnly)
                    {
                        _loc_60 = _loc_46.c1;
                        _loc_46.c1 = _loc_46.c2;
                        _loc_46.c2 = _loc_60;
                        _loc_48 = _loc_46.oc1;
                        _loc_46.oc1 = _loc_46.oc2;
                        _loc_46.oc2 = _loc_48;
                        _loc_46.hc2 = false;
                    }
                    else if (_loc_46.oc2.posOnly)
                    {
                        _loc_46.hc2 = false;
                    }
                    if (_loc_46.oc1.posOnly)
                    {
                        _loc_6 = true;
                    }
                }
                else
                {
                    _loc_46.hpc2 = false;
                }
                if (_loc_6)
                {
                    param1.active = false;
                }
            }
            if (_loc_5 != param1.active)
            {
                param1.b1.arbiters.modified = true;
                param1.b2.arbiters.modified = true;
                _loc_6 = true;
                c_arbiters_false.modified = _loc_6;
                c_arbiters_true.modified = _loc_6;
                _loc_6 = true;
                f_arbiters.modified = _loc_6;
                s_arbiters.modified = _loc_6;
            }
            return false;
        }// end function

        public function prestep(param1:Number) : void
        {
            var _loc_4:* = null as ZPP_Constraint;
            var _loc_9:* = null as ZPP_ColArbiter;
            var _loc_10:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_11:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_12:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_16:* = null as ZPP_FluidArbiter;
            var _loc_17:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_18:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_19:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_23:* = null as ZPP_SensorArbiter;
            var _loc_24:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_25:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_26:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_2:* = null;
            var _loc_3:* = live_constraints.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                if (_loc_4.preStep(param1))
                {
                    _loc_3 = live_constraints.erase(_loc_2);
                    _loc_4.broken();
                    constraintCbBreak(_loc_4);
                    if (_loc_4.removeOnBreak)
                    {
                        _loc_4.component.sleeping = true;
                        midstep = false;
                        if (_loc_4.compound != null)
                        {
                            _loc_4.compound.wrap_constraints.remove(_loc_4.outer);
                        }
                        else
                        {
                            wrap_constraints.remove(_loc_4.outer);
                        }
                        midstep = true;
                    }
                    else
                    {
                        _loc_4.active = false;
                    }
                    _loc_4.clearcache();
                    continue;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            var _loc_5:* = null;
            var _loc_6:* = c_arbiters_true;
            var _loc_7:* = _loc_6.head;
            var _loc_8:* = c_arbiters_false != null;
            if (_loc_8)
            {
            }
            if (_loc_7 == null)
            {
                _loc_8 = false;
                _loc_7 = c_arbiters_false.head;
                _loc_6 = c_arbiters_false;
                _loc_5 = null;
            }
            while (_loc_7 != null)
            {
                
                _loc_9 = _loc_7.elt;
                if (presteparb(_loc_9, param1))
                {
                    if (_loc_5 == null)
                    {
                        _loc_10 = _loc_6.head;
                        _loc_11 = _loc_10.next;
                        _loc_6.head = _loc_11;
                        if (_loc_6.head == null)
                        {
                            _loc_6.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_10 = _loc_5.next;
                        _loc_11 = _loc_10.next;
                        _loc_5.next = _loc_11;
                        if (_loc_11 == null)
                        {
                            _loc_6.pushmod = true;
                        }
                    }
                    _loc_12 = _loc_10;
                    _loc_12.elt = null;
                    _loc_12.next = ZNPNode_ZPP_ColArbiter.zpp_pool;
                    ZNPNode_ZPP_ColArbiter.zpp_pool = _loc_12;
                    _loc_6.modified = true;
                    (_loc_6.length - 1);
                    _loc_6.pushmod = true;
                    _loc_7 = _loc_11;
                    if (_loc_8)
                    {
                    }
                    if (_loc_7 == null)
                    {
                        _loc_8 = false;
                        _loc_7 = c_arbiters_false.head;
                        _loc_6 = c_arbiters_false;
                        _loc_5 = null;
                    }
                    continue;
                }
                _loc_5 = _loc_7;
                _loc_7 = _loc_7.next;
                if (_loc_8)
                {
                }
                if (_loc_7 == null)
                {
                    _loc_8 = false;
                    _loc_7 = c_arbiters_false.head;
                    _loc_6 = c_arbiters_false;
                    _loc_5 = null;
                }
            }
            var _loc_13:* = null;
            var _loc_14:* = f_arbiters;
            var _loc_15:* = _loc_14.head;
            _loc_8 = false;
            if (_loc_8)
            {
            }
            if (_loc_15 == null)
            {
                _loc_8 = false;
                _loc_15 = null.begin();
                _loc_14 = null;
                _loc_13 = null;
            }
            while (_loc_15 != null)
            {
                
                _loc_16 = _loc_15.elt;
                if (presteparb(_loc_16, param1))
                {
                    if (_loc_13 == null)
                    {
                        _loc_17 = _loc_14.head;
                        _loc_18 = _loc_17.next;
                        _loc_14.head = _loc_18;
                        if (_loc_14.head == null)
                        {
                            _loc_14.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_17 = _loc_13.next;
                        _loc_18 = _loc_17.next;
                        _loc_13.next = _loc_18;
                        if (_loc_18 == null)
                        {
                            _loc_14.pushmod = true;
                        }
                    }
                    _loc_19 = _loc_17;
                    _loc_19.elt = null;
                    _loc_19.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                    ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_19;
                    _loc_14.modified = true;
                    (_loc_14.length - 1);
                    _loc_14.pushmod = true;
                    _loc_15 = _loc_18;
                    if (_loc_8)
                    {
                    }
                    if (_loc_15 == null)
                    {
                        _loc_8 = false;
                        _loc_15 = null.begin();
                        _loc_14 = null;
                        _loc_13 = null;
                    }
                    continue;
                }
                _loc_13 = _loc_15;
                _loc_15 = _loc_15.next;
                if (_loc_8)
                {
                }
                if (_loc_15 == null)
                {
                    _loc_8 = false;
                    _loc_15 = null.begin();
                    _loc_14 = null;
                    _loc_13 = null;
                }
            }
            var _loc_20:* = null;
            var _loc_21:* = s_arbiters;
            var _loc_22:* = _loc_21.head;
            _loc_8 = false;
            if (_loc_8)
            {
            }
            if (_loc_22 == null)
            {
                _loc_8 = false;
                _loc_22 = null.begin();
                _loc_21 = null;
                _loc_20 = null;
            }
            while (_loc_22 != null)
            {
                
                _loc_23 = _loc_22.elt;
                if (presteparb(_loc_23, param1))
                {
                    if (_loc_20 == null)
                    {
                        _loc_24 = _loc_21.head;
                        _loc_25 = _loc_24.next;
                        _loc_21.head = _loc_25;
                        if (_loc_21.head == null)
                        {
                            _loc_21.pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_24 = _loc_20.next;
                        _loc_25 = _loc_24.next;
                        _loc_20.next = _loc_25;
                        if (_loc_25 == null)
                        {
                            _loc_21.pushmod = true;
                        }
                    }
                    _loc_26 = _loc_24;
                    _loc_26.elt = null;
                    _loc_26.next = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                    ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc_26;
                    _loc_21.modified = true;
                    (_loc_21.length - 1);
                    _loc_21.pushmod = true;
                    _loc_22 = _loc_25;
                    if (_loc_8)
                    {
                    }
                    if (_loc_22 == null)
                    {
                        _loc_8 = false;
                        _loc_22 = null.begin();
                        _loc_21 = null;
                        _loc_20 = null;
                    }
                    continue;
                }
                _loc_20 = _loc_22;
                _loc_22 = _loc_22.next;
                if (_loc_8)
                {
                }
                if (_loc_22 == null)
                {
                    _loc_8 = false;
                    _loc_22 = null.begin();
                    _loc_21 = null;
                    _loc_20 = null;
                }
            }
            return;
        }// end function

        public function prepareCast(param1:ZPP_Shape) : void
        {
            var _loc_2:* = null as ZPP_Circle;
            var _loc_3:* = null as ZPP_Polygon;
            var _loc_4:* = NaN;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = NaN;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as ZPP_Body;
            var _loc_12:* = null as ZNPNode_ZPP_Edge;
            var _loc_13:* = null as ZPP_Edge;
            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                _loc_2 = param1.circle;
                if (_loc_2.zip_worldCOM)
                {
                    if (_loc_2.body != null)
                    {
                        _loc_2.zip_worldCOM = false;
                        if (_loc_2.zip_localCOM)
                        {
                            _loc_2.zip_localCOM = false;
                            if (_loc_2.type == ZPP_Flags.id_ShapeType_POLYGON)
                            {
                                _loc_3 = _loc_2.polygon;
                                if (_loc_3.lverts.next == null)
                                {
                                    throw "Error: An empty polygon has no meaningful localCOM";
                                }
                                if (_loc_3.lverts.next.next == null)
                                {
                                    _loc_3.localCOMx = _loc_3.lverts.next.x;
                                    _loc_3.localCOMy = _loc_3.lverts.next.y;
                                }
                                else if (_loc_3.lverts.next.next.next == null)
                                {
                                    _loc_3.localCOMx = _loc_3.lverts.next.x;
                                    _loc_3.localCOMy = _loc_3.lverts.next.y;
                                    _loc_4 = 1;
                                    _loc_3.localCOMx = _loc_3.localCOMx + _loc_3.lverts.next.next.x * _loc_4;
                                    _loc_3.localCOMy = _loc_3.localCOMy + _loc_3.lverts.next.next.y * _loc_4;
                                    _loc_4 = 0.5;
                                    _loc_3.localCOMx = _loc_3.localCOMx * _loc_4;
                                    _loc_3.localCOMy = _loc_3.localCOMy * _loc_4;
                                }
                                else
                                {
                                    _loc_3.localCOMx = 0;
                                    _loc_3.localCOMy = 0;
                                    _loc_4 = 0;
                                    _loc_5 = _loc_3.lverts.next;
                                    _loc_6 = _loc_5;
                                    _loc_5 = _loc_5.next;
                                    _loc_7 = _loc_5;
                                    _loc_5 = _loc_5.next;
                                    while (_loc_5 != null)
                                    {
                                        
                                        _loc_8 = _loc_5;
                                        _loc_4 = _loc_4 + _loc_7.x * (_loc_8.y - _loc_6.y);
                                        _loc_9 = _loc_8.y * _loc_7.x - _loc_8.x * _loc_7.y;
                                        _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_8.x) * _loc_9;
                                        _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_8.y) * _loc_9;
                                        _loc_6 = _loc_7;
                                        _loc_7 = _loc_8;
                                        _loc_5 = _loc_5.next;
                                    }
                                    _loc_5 = _loc_3.lverts.next;
                                    _loc_8 = _loc_5;
                                    _loc_4 = _loc_4 + _loc_7.x * (_loc_8.y - _loc_6.y);
                                    _loc_9 = _loc_8.y * _loc_7.x - _loc_8.x * _loc_7.y;
                                    _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_8.x) * _loc_9;
                                    _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_8.y) * _loc_9;
                                    _loc_6 = _loc_7;
                                    _loc_7 = _loc_8;
                                    _loc_5 = _loc_5.next;
                                    _loc_10 = _loc_5;
                                    _loc_4 = _loc_4 + _loc_7.x * (_loc_10.y - _loc_6.y);
                                    _loc_9 = _loc_10.y * _loc_7.x - _loc_10.x * _loc_7.y;
                                    _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_10.x) * _loc_9;
                                    _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_10.y) * _loc_9;
                                    _loc_4 = 1 / (3 * _loc_4);
                                    _loc_9 = _loc_4;
                                    _loc_3.localCOMx = _loc_3.localCOMx * _loc_9;
                                    _loc_3.localCOMy = _loc_3.localCOMy * _loc_9;
                                }
                            }
                            if (_loc_2.wrap_localCOM != null)
                            {
                                _loc_2.wrap_localCOM.zpp_inner.x = _loc_2.localCOMx;
                                _loc_2.wrap_localCOM.zpp_inner.y = _loc_2.localCOMy;
                            }
                        }
                        _loc_11 = _loc_2.body;
                        if (_loc_11.zip_axis)
                        {
                            _loc_11.zip_axis = false;
                            _loc_11.axisx = Math.sin(_loc_11.rot);
                            _loc_11.axisy = Math.cos(_loc_11.rot);
                        }
                        _loc_2.worldCOMx = _loc_2.body.posx + (_loc_2.body.axisy * _loc_2.localCOMx - _loc_2.body.axisx * _loc_2.localCOMy);
                        _loc_2.worldCOMy = _loc_2.body.posy + (_loc_2.localCOMx * _loc_2.body.axisx + _loc_2.localCOMy * _loc_2.body.axisy);
                    }
                }
            }
            else
            {
                _loc_3 = param1.polygon;
                if (_loc_3.zip_gaxi)
                {
                    if (_loc_3.body != null)
                    {
                        _loc_3.zip_gaxi = false;
                        _loc_3.validate_laxi();
                        _loc_11 = _loc_3.body;
                        if (_loc_11.zip_axis)
                        {
                            _loc_11.zip_axis = false;
                            _loc_11.axisx = Math.sin(_loc_11.rot);
                            _loc_11.axisy = Math.cos(_loc_11.rot);
                        }
                        if (_loc_3.zip_gverts)
                        {
                            if (_loc_3.body != null)
                            {
                                _loc_3.zip_gverts = false;
                                _loc_3.validate_lverts();
                                _loc_11 = _loc_3.body;
                                if (_loc_11.zip_axis)
                                {
                                    _loc_11.zip_axis = false;
                                    _loc_11.axisx = Math.sin(_loc_11.rot);
                                    _loc_11.axisy = Math.cos(_loc_11.rot);
                                }
                                _loc_5 = _loc_3.lverts.next;
                                _loc_6 = _loc_3.gverts.next;
                                while (_loc_6 != null)
                                {
                                    
                                    _loc_7 = _loc_6;
                                    _loc_8 = _loc_5;
                                    _loc_5 = _loc_5.next;
                                    _loc_7.x = _loc_3.body.posx + (_loc_3.body.axisy * _loc_8.x - _loc_3.body.axisx * _loc_8.y);
                                    _loc_7.y = _loc_3.body.posy + (_loc_8.x * _loc_3.body.axisx + _loc_8.y * _loc_3.body.axisy);
                                    _loc_6 = _loc_6.next;
                                }
                            }
                        }
                        _loc_12 = _loc_3.edges.head;
                        _loc_5 = _loc_3.gverts.next;
                        _loc_6 = _loc_5;
                        _loc_5 = _loc_5.next;
                        while (_loc_5 != null)
                        {
                            
                            _loc_7 = _loc_5;
                            _loc_13 = _loc_12.elt;
                            _loc_12 = _loc_12.next;
                            _loc_13.gp0 = _loc_6;
                            _loc_13.gp1 = _loc_7;
                            _loc_13.gnormx = _loc_3.body.axisy * _loc_13.lnormx - _loc_3.body.axisx * _loc_13.lnormy;
                            _loc_13.gnormy = _loc_13.lnormx * _loc_3.body.axisx + _loc_13.lnormy * _loc_3.body.axisy;
                            _loc_13.gprojection = _loc_3.body.posx * _loc_13.gnormx + _loc_3.body.posy * _loc_13.gnormy + _loc_13.lprojection;
                            if (_loc_13.wrap_gnorm != null)
                            {
                                _loc_13.wrap_gnorm.zpp_inner.x = _loc_13.gnormx;
                                _loc_13.wrap_gnorm.zpp_inner.y = _loc_13.gnormy;
                            }
                            _loc_13.tp0 = _loc_13.gp0.y * _loc_13.gnormx - _loc_13.gp0.x * _loc_13.gnormy;
                            _loc_13.tp1 = _loc_13.gp1.y * _loc_13.gnormx - _loc_13.gp1.x * _loc_13.gnormy;
                            _loc_6 = _loc_7;
                            _loc_5 = _loc_5.next;
                        }
                        _loc_7 = _loc_3.gverts.next;
                        _loc_13 = _loc_12.elt;
                        _loc_12 = _loc_12.next;
                        _loc_13.gp0 = _loc_6;
                        _loc_13.gp1 = _loc_7;
                        _loc_13.gnormx = _loc_3.body.axisy * _loc_13.lnormx - _loc_3.body.axisx * _loc_13.lnormy;
                        _loc_13.gnormy = _loc_13.lnormx * _loc_3.body.axisx + _loc_13.lnormy * _loc_3.body.axisy;
                        _loc_13.gprojection = _loc_3.body.posx * _loc_13.gnormx + _loc_3.body.posy * _loc_13.gnormy + _loc_13.lprojection;
                        if (_loc_13.wrap_gnorm != null)
                        {
                            _loc_13.wrap_gnorm.zpp_inner.x = _loc_13.gnormx;
                            _loc_13.wrap_gnorm.zpp_inner.y = _loc_13.gnormy;
                        }
                        _loc_13.tp0 = _loc_13.gp0.y * _loc_13.gnormx - _loc_13.gp0.x * _loc_13.gnormy;
                        _loc_13.tp1 = _loc_13.gp1.y * _loc_13.gnormx - _loc_13.gp1.x * _loc_13.gnormy;
                    }
                }
            }
            return;
        }// end function

        public function nullListenerType(param1:ZPP_CbSet, param2:ZPP_CbSet) : void
        {
            var _loc_4:* = null as ZNPNode_ZPP_Interactor;
            var _loc_5:* = null as ZPP_Interactor;
            var _loc_6:* = null as ZPP_Compound;
            var _loc_7:* = null as ZNPNode_ZPP_Body;
            var _loc_8:* = null as ZPP_Body;
            var _loc_9:* = null as ZNPNode_ZPP_Compound;
            var _loc_10:* = null as ZPP_Compound;
            var _loc_11:* = null as ZPP_Shape;
            var _loc_12:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_13:* = null as ZPP_Arbiter;
            var _loc_14:* = null as ZPP_Interactor;
            var _loc_15:* = null as ZNPNode_ZPP_Interactor;
            var _loc_16:* = null as ZPP_Interactor;
            var _loc_17:* = null as ZPP_CallbackSet;
            var _loc_18:* = null as ZPP_Arbiter;
            var _loc_3:* = new ZNPList_ZPP_Interactor();
            _loc_4 = param1.interactors.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                _loc_3.add(_loc_5);
                _loc_4 = _loc_4.next;
            }
            if (param1 != param2)
            {
                _loc_4 = param2.interactors.head;
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.elt;
                    _loc_3.add(_loc_5);
                    _loc_4 = _loc_4.next;
                }
            }
            while (_loc_3.head != null)
            {
                
                _loc_5 = _loc_3.pop_unsafe();
                if (_loc_5.icompound != null)
                {
                    _loc_6 = _loc_5.icompound;
                    _loc_7 = _loc_6.bodies.head;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.elt;
                        _loc_3.add(_loc_8);
                        _loc_7 = _loc_7.next;
                    }
                    _loc_9 = _loc_6.compounds.head;
                    while (_loc_9 != null)
                    {
                        
                        _loc_10 = _loc_9.elt;
                        _loc_3.add(_loc_10);
                        _loc_9 = _loc_9.next;
                    }
                    continue;
                }
                if (_loc_5.ibody != null)
                {
                    _loc_8 = _loc_5.ibody;
                }
                else
                {
                    _loc_8 = _loc_5.ishape.body;
                }
                if (_loc_5.ishape != null)
                {
                    _loc_11 = _loc_5.ishape;
                }
                else
                {
                    _loc_11 = null;
                }
                _loc_12 = _loc_8.arbiters.head;
                while (_loc_12 != null)
                {
                    
                    _loc_13 = _loc_12.elt;
                    if (_loc_13.present == 0)
                    {
                        _loc_12 = _loc_12.next;
                        continue;
                    }
                    if (_loc_11 != null)
                    {
                        if (_loc_13.ws1 != _loc_11)
                        {
                        }
                    }
                    if (_loc_13.ws2 != _loc_11)
                    {
                        _loc_12 = _loc_12.next;
                        continue;
                    }
                    MRCA_chains(_loc_13.ws1, _loc_13.ws2);
                    _loc_4 = mrca1.head;
                    while (_loc_4 != null)
                    {
                        
                        _loc_14 = _loc_4.elt;
                        if (_loc_14.cbSet != param1)
                        {
                        }
                        if (_loc_14.cbSet != param2)
                        {
                            _loc_4 = _loc_4.next;
                            continue;
                        }
                        _loc_15 = mrca2.head;
                        while (_loc_15 != null)
                        {
                            
                            _loc_16 = _loc_15.elt;
                            if (_loc_14.cbSet == param1)
                            {
                            }
                            if (_loc_16.cbSet == param2)
                            {
                                if (_loc_14.cbSet == param2)
                                {
                                }
                            }
                            if (_loc_16.cbSet != param1)
                            {
                                _loc_15 = _loc_15.next;
                                continue;
                            }
                            _loc_17 = ZPP_Interactor.get(_loc_14, _loc_16);
                            if (_loc_17 != null)
                            {
                                while (_loc_17.arbiters.head != null)
                                {
                                    
                                    _loc_18 = _loc_17.arbiters.pop_unsafe();
                                    (_loc_18.present - 1);
                                }
                                remove_callbackset(_loc_17);
                            }
                            _loc_15 = _loc_15.next;
                        }
                        _loc_4 = _loc_4.next;
                    }
                    _loc_12 = _loc_12.next;
                }
            }
            return;
        }// end function

        public function nullInteractorType(param1:ZPP_Interactor, param2:ZPP_Interactor = undefined) : void
        {
            var _loc_3:* = null as ZPP_Compound;
            var _loc_4:* = null as ZNPNode_ZPP_Body;
            var _loc_5:* = null as ZPP_Body;
            var _loc_6:* = null as ZNPNode_ZPP_Compound;
            var _loc_7:* = null as ZPP_Compound;
            var _loc_8:* = null as ZPP_Shape;
            var _loc_9:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_10:* = null as ZPP_Arbiter;
            var _loc_11:* = null as ZNPNode_ZPP_Interactor;
            var _loc_12:* = null as ZPP_Interactor;
            var _loc_13:* = null as ZNPNode_ZPP_Interactor;
            var _loc_14:* = null as ZPP_Interactor;
            var _loc_15:* = null as ZPP_CallbackSet;
            if (param2 == null)
            {
                param2 = param1;
            }
            if (param1.icompound != null)
            {
                _loc_3 = param1.icompound;
                _loc_4 = _loc_3.bodies.head;
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.elt;
                    nullInteractorType(_loc_5, param2);
                    _loc_4 = _loc_4.next;
                }
                _loc_6 = _loc_3.compounds.head;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6.elt;
                    nullInteractorType(_loc_7, param2);
                    _loc_6 = _loc_6.next;
                }
            }
            else
            {
                if (param1.ibody != null)
                {
                    _loc_5 = param1.ibody;
                }
                else
                {
                    _loc_5 = param1.ishape.body;
                }
                if (param1.ishape != null)
                {
                    _loc_8 = param1.ishape;
                }
                else
                {
                    _loc_8 = null;
                }
                _loc_9 = _loc_5.arbiters.head;
                while (_loc_9 != null)
                {
                    
                    _loc_10 = _loc_9.elt;
                    if (_loc_10.present == 0)
                    {
                        _loc_9 = _loc_9.next;
                        continue;
                    }
                    if (_loc_8 != null)
                    {
                        if (_loc_10.ws1 != _loc_8)
                        {
                        }
                    }
                    if (_loc_10.ws2 != _loc_8)
                    {
                        _loc_9 = _loc_9.next;
                        continue;
                    }
                    MRCA_chains(_loc_10.ws1, _loc_10.ws2);
                    _loc_11 = mrca1.head;
                    while (_loc_11 != null)
                    {
                        
                        _loc_12 = _loc_11.elt;
                        _loc_13 = mrca2.head;
                        while (_loc_13 != null)
                        {
                            
                            _loc_14 = _loc_13.elt;
                            if (_loc_12 != param2)
                            {
                            }
                            if (_loc_14 != param2)
                            {
                                _loc_13 = _loc_13.next;
                                continue;
                            }
                            _loc_15 = ZPP_Interactor.get(_loc_12, _loc_14);
                            if (_loc_15 != null)
                            {
                                (_loc_10.present - 1);
                                _loc_15.remove_arb(_loc_10);
                                if (_loc_15.arbiters.head == null)
                                {
                                    remove_callbackset(_loc_15);
                                }
                            }
                            _loc_13 = _loc_13.next;
                        }
                        _loc_11 = _loc_11.next;
                    }
                    _loc_9 = _loc_9.next;
                }
            }
            return;
        }// end function

        public function non_inlined_wake(param1:ZPP_Body, param2:Boolean = false) : void
        {
            var _loc_3:* = param1;
            if (!_loc_3.world)
            {
                _loc_3.component.waket = stamp + (midstep ? (0) : (1));
                if (_loc_3.type == ZPP_Flags.id_BodyType_KINEMATIC)
                {
                    _loc_3.kinematicDelaySleep = true;
                }
                if (_loc_3.component.sleeping)
                {
                    really_wake(_loc_3, param2);
                }
            }
            return;
        }// end function

        public function narrowPhase(param1:ZPP_Shape, param2:ZPP_Shape, param3:Boolean, param4:ZPP_Arbiter, param5:Boolean) : ZPP_Arbiter
        {
            var _loc_10:* = 0;
            var _loc_11:* = false;
            var _loc_13:* = null as ZPP_Constraint;
            var _loc_14:* = null as ZPP_InteractionGroup;
            var _loc_15:* = null as ZPP_Interactor;
            var _loc_16:* = null as ZPP_InteractionGroup;
            var _loc_17:* = false;
            var _loc_18:* = null as ZPP_InteractionFilter;
            var _loc_19:* = null as ZPP_InteractionFilter;
            var _loc_20:* = null as ZPP_Shape;
            var _loc_21:* = null as ZPP_Shape;
            var _loc_22:* = null as ZPP_Arbiter;
            var _loc_23:* = null as ZPP_Arbiter;
            var _loc_24:* = null as ZPP_Body;
            var _loc_25:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_26:* = null as ZPP_Arbiter;
            var _loc_27:* = null as ZPP_FluidArbiter;
            var _loc_28:* = false;
            var _loc_29:* = null as ZNPList_ZPP_Arbiter;
            var _loc_30:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_31:* = false;
            var _loc_32:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_33:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_34:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_35:* = 0;
            var _loc_36:* = null as ZNPList_ZPP_FluidArbiter;
            var _loc_37:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_38:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_39:* = null as ZPP_Shape;
            var _loc_40:* = null as ZPP_Shape;
            var _loc_41:* = null as ZNPList_ZPP_Interactor;
            var _loc_42:* = null as ZNPNode_ZPP_Interactor;
            var _loc_43:* = null as ZNPNode_ZPP_Interactor;
            var _loc_44:* = null as ZPP_Compound;
            var _loc_45:* = null as ZPP_Compound;
            var _loc_46:* = 0;
            var _loc_47:* = 0;
            var _loc_48:* = null as ZPP_Interactor;
            var _loc_49:* = null as ZPP_CbSet;
            var _loc_50:* = null as ZPP_CbSet;
            var _loc_51:* = null as ZPP_CbSetPair;
            var _loc_52:* = null as ZPP_CbSetPair;
            var _loc_53:* = null as ZNPList_ZPP_CbSetPair;
            var _loc_54:* = null as ZNPNode_ZPP_CbSetPair;
            var _loc_55:* = null as ZPP_CbSetPair;
            var _loc_56:* = null as ZPP_CallbackSet;
            var _loc_57:* = null as ZPP_CallbackSet;
            var _loc_58:* = null as ZNPList_ZPP_InteractionListener;
            var _loc_59:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_60:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_61:* = null as ZPP_InteractionListener;
            var _loc_62:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_63:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_64:* = false;
            var _loc_65:* = false;
            var _loc_66:* = null as ZPP_Callback;
            var _loc_67:* = null as ZPP_Interactor;
            var _loc_68:* = null as ZPP_Interactor;
            var _loc_69:* = null as ZPP_OptionType;
            var _loc_70:* = null as ZNPList_ZPP_CbType;
            var _loc_71:* = null as PreFlag;
            var _loc_72:* = null as ZPP_FluidArbiter;
            var _loc_73:* = null as ZNPList_ZPP_ColArbiter;
            var _loc_74:* = null as ZPP_ColArbiter;
            var _loc_75:* = NaN;
            var _loc_76:* = NaN;
            var _loc_77:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_78:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_79:* = false;
            var _loc_80:* = null as ZPP_Contact;
            var _loc_81:* = null as ZPP_IContact;
            var _loc_82:* = null as ZPP_IContact;
            var _loc_83:* = null as ZPP_Contact;
            var _loc_84:* = null as ZPP_Contact;
            var _loc_85:* = null as ZPP_Contact;
            var _loc_86:* = null as ZPP_Contact;
            var _loc_87:* = null as ZPP_Contact;
            var _loc_88:* = null as ZPP_IContact;
            var _loc_89:* = null as ZPP_IContact;
            var _loc_90:* = null as ZPP_IContact;
            var _loc_91:* = false;
            var _loc_92:* = null as ZPP_ColArbiter;
            var _loc_93:* = null as ZPP_Edge;
            var _loc_94:* = null as ZPP_SensorArbiter;
            var _loc_95:* = null as ZNPList_ZPP_SensorArbiter;
            var _loc_96:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_97:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_98:* = null as ZPP_SensorArbiter;
            var _loc_6:* = this;
            var _loc_7:* = null;
            var _loc_8:* = param1.body;
            var _loc_9:* = param2.body;
            _loc_11 = false;
            var _loc_12:* = _loc_8.constraints.head;
            while (_loc_12 != null)
            {
                
                _loc_13 = _loc_12.elt;
                if (_loc_13.ignore)
                {
                }
                if (_loc_13.pair_exists(_loc_8.id, _loc_9.id))
                {
                    _loc_11 = true;
                    break;
                }
                _loc_12 = _loc_12.next;
            }
            if (!_loc_11)
            {
                _loc_15 = param1;
                do
                {
                    
                    if (_loc_15.ishape != null)
                    {
                        _loc_15 = _loc_15.ishape.body;
                    }
                    else if (_loc_15.icompound != null)
                    {
                        _loc_15 = _loc_15.icompound.compound;
                    }
                    else
                    {
                        _loc_15 = _loc_15.ibody.compound;
                    }
                    if (_loc_15 != null)
                    {
                    }
                }while (_loc_15.group == null)
                if (_loc_15 == null)
                {
                    _loc_14 = null;
                }
                else
                {
                    _loc_14 = _loc_15.group;
                }
                while (_loc_15.group == null)
                {
                    if (_loc_15.ishape != null)
                    {
                        continue;
                    }
                    if (_loc_15.icompound != null)
                    {
                        continue;
                    }
                    if (_loc_15 != null)
                    {
                    }
                }
                if (_loc_15 == null)
                {
                }
                else
                {
                }
                while (_loc_16 != null)
                {
                    if (_loc_14 == _loc_16)
                    {
                        break;
                    }
                    if (_loc_14.depth < _loc_16.depth)
                    {
                        continue;
                    }
                    if (_loc_14 != null)
                    {
                    }
                }
            }
            if (!(_loc_14.depth < _loc_16.depth ? (false) : (_loc_15 = param2, // Jump to 869, // label, if (_loc_15.ishape == null) goto 826, _loc_15 = _loc_15.ishape.body, // Jump to 869, if (_loc_15.icompound == null) goto 856, _loc_15 = _loc_15.icompound.compound, // Jump to 869, _loc_15 = _loc_15.ibody.compound, if (_loc_15 == null) goto 892, if (_loc_15.group == null) goto 795, if (!(_loc_15 == null)) goto 919, _loc_16 = null, // Jump to 929, _loc_16 = _loc_15.group, _loc_16 == null ? (false) : (_loc_17 = false, // Jump to 1011, // label, if (!(_loc_14 == _loc_16)) goto 973, _loc_17 = _loc_14.ignore, // Jump to 1036, if (!(_loc_14.depth < _loc_16.depth)) goto 1001, _loc_16 = _loc_16.group, // Jump to 1011, _loc_14 = _loc_14.group, if (_loc_14 == null) goto 1032, if (_loc_16 != null) goto 952, _loc_17))))
            {
                if (!param1.sensorEnabled)
                {
                }
                if (param2.sensorEnabled)
                {
                    _loc_18 = param1.filter;
                    _loc_19 = param2.filter;
                    if ((_loc_18.sensorMask & _loc_19.sensorGroup) != 0)
                    {
                    }
                }
                if ((_loc_19.sensorMask & _loc_18.sensorGroup) != 0)
                {
                    _loc_10 = 2;
                }
                else
                {
                    if (!param1.fluidEnabled)
                    {
                    }
                    if (param2.fluidEnabled)
                    {
                        _loc_18 = param1.filter;
                        _loc_19 = param2.filter;
                        if ((_loc_18.fluidMask & _loc_19.fluidGroup) != 0)
                        {
                        }
                    }
                    if ((_loc_19.fluidMask & _loc_18.fluidGroup) != 0)
                    {
                        if (_loc_8.imass == 0)
                        {
                        }
                        if (_loc_9.imass == 0)
                        {
                        }
                        if (_loc_8.iinertia == 0)
                        {
                        }
                    }
                    if (_loc_9.iinertia != 0)
                    {
                        _loc_10 = 0;
                    }
                    else
                    {
                        _loc_18 = param1.filter;
                        _loc_19 = param2.filter;
                        if ((_loc_18.collisionMask & _loc_19.collisionGroup) != 0)
                        {
                        }
                        if ((_loc_19.collisionMask & _loc_18.collisionGroup) != 0)
                        {
                            if (_loc_8.imass == 0)
                            {
                            }
                            if (_loc_9.imass == 0)
                            {
                            }
                            if (_loc_8.iinertia == 0)
                            {
                            }
                        }
                        if (_loc_9.iinertia != 0)
                        {
                            _loc_10 = 1;
                        }
                        else
                        {
                            _loc_10 = -1;
                        }
                    }
                }
            }
            else
            {
                _loc_10 = -1;
            }
            if (_loc_10 != -1)
            {
                if (param1.type > param2.type)
                {
                    _loc_20 = param2;
                    _loc_21 = param1;
                }
                else if (param1.type == param2.type)
                {
                    if (param1.id < param2.id)
                    {
                        _loc_20 = param1;
                        _loc_21 = param2;
                    }
                    else
                    {
                        _loc_21 = param1;
                        _loc_20 = param2;
                    }
                }
                else
                {
                    _loc_20 = param1;
                    _loc_21 = param2;
                }
                _loc_11 = _loc_20 == param2;
                if (_loc_10 == 0)
                {
                    if (param4 == null)
                    {
                        _loc_23 = null;
                        if (_loc_8.arbiters.length < _loc_9.arbiters.length)
                        {
                            _loc_24 = _loc_8;
                        }
                        else
                        {
                            _loc_24 = _loc_9;
                        }
                        _loc_25 = _loc_24.arbiters.head;
                        while (_loc_25 != null)
                        {
                            
                            _loc_26 = _loc_25.elt;
                            if (_loc_26.id == _loc_20.id)
                            {
                            }
                            if (_loc_26.di == _loc_21.id)
                            {
                                _loc_23 = _loc_26;
                                break;
                            }
                            _loc_25 = _loc_25.next;
                        }
                        _loc_22 = _loc_23;
                    }
                    else
                    {
                        _loc_22 = param4;
                    }
                    _loc_17 = _loc_22 == null;
                    _loc_28 = false;
                    if (_loc_17)
                    {
                        if (ZPP_FluidArbiter.zpp_pool == null)
                        {
                            _loc_27 = new ZPP_FluidArbiter();
                        }
                        else
                        {
                            _loc_27 = ZPP_FluidArbiter.zpp_pool;
                            ZPP_FluidArbiter.zpp_pool = _loc_27.next;
                            _loc_27.next = null;
                        }
                    }
                    else if (_loc_22.fluidarb == null)
                    {
                        _loc_22.cleared = true;
                        _loc_29 = _loc_22.b1.arbiters;
                        _loc_25 = null;
                        _loc_30 = _loc_29.head;
                        _loc_31 = false;
                        while (_loc_30 != null)
                        {
                            
                            if (_loc_30.elt == _loc_22)
                            {
                                if (_loc_25 == null)
                                {
                                    _loc_32 = _loc_29.head;
                                    _loc_33 = _loc_32.next;
                                    _loc_29.head = _loc_33;
                                    if (_loc_29.head == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_32 = _loc_25.next;
                                    _loc_33 = _loc_32.next;
                                    _loc_25.next = _loc_33;
                                    if (_loc_33 == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                _loc_34 = _loc_32;
                                _loc_34.elt = null;
                                _loc_34.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_34;
                                _loc_29.modified = true;
                                (_loc_29.length - 1);
                                _loc_29.pushmod = true;
                                _loc_31 = true;
                                break;
                            }
                            _loc_25 = _loc_30;
                            _loc_30 = _loc_30.next;
                        }
                        _loc_29 = _loc_22.b2.arbiters;
                        _loc_25 = null;
                        _loc_30 = _loc_29.head;
                        _loc_31 = false;
                        while (_loc_30 != null)
                        {
                            
                            if (_loc_30.elt == _loc_22)
                            {
                                if (_loc_25 == null)
                                {
                                    _loc_32 = _loc_29.head;
                                    _loc_33 = _loc_32.next;
                                    _loc_29.head = _loc_33;
                                    if (_loc_29.head == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_32 = _loc_25.next;
                                    _loc_33 = _loc_32.next;
                                    _loc_25.next = _loc_33;
                                    if (_loc_33 == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                _loc_34 = _loc_32;
                                _loc_34.elt = null;
                                _loc_34.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_34;
                                _loc_29.modified = true;
                                (_loc_29.length - 1);
                                _loc_29.pushmod = true;
                                _loc_31 = true;
                                break;
                            }
                            _loc_25 = _loc_30;
                            _loc_30 = _loc_30.next;
                        }
                        if (_loc_22.pair != null)
                        {
                            _loc_22.pair.arb = null;
                            _loc_22.pair = null;
                        }
                        _loc_22.active = false;
                        f_arbiters.modified = true;
                        if (ZPP_FluidArbiter.zpp_pool == null)
                        {
                            _loc_27 = new ZPP_FluidArbiter();
                        }
                        else
                        {
                            _loc_27 = ZPP_FluidArbiter.zpp_pool;
                            ZPP_FluidArbiter.zpp_pool = _loc_27.next;
                            _loc_27.next = null;
                        }
                        _loc_27.intchange = true;
                        _loc_17 = true;
                        _loc_28 = true;
                    }
                    else
                    {
                        _loc_27 = _loc_22.fluidarb;
                    }
                    _loc_35 = ZPP_Flags.id_InteractionType_FLUID;
                    if (!_loc_17)
                    {
                    }
                    if (_loc_27.stamp == stamp)
                    {
                    }
                    if (param5)
                    {
                        _loc_27.stamp = stamp;
                        if (ZPP_Collide.flowCollide(_loc_20, _loc_21, _loc_27))
                        {
                            if (_loc_17)
                            {
                                _loc_27.b1 = param1.body;
                                _loc_27.ws1 = param1;
                                _loc_27.b2 = param2.body;
                                _loc_27.ws2 = param2;
                                _loc_27.id = _loc_20.id;
                                _loc_27.di = _loc_21.id;
                                _loc_29 = _loc_27.b1.arbiters;
                                if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                {
                                    _loc_30 = new ZNPNode_ZPP_Arbiter();
                                }
                                else
                                {
                                    _loc_30 = ZNPNode_ZPP_Arbiter.zpp_pool;
                                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc_30.next;
                                    _loc_30.next = null;
                                }
                                _loc_30.elt = _loc_27;
                                _loc_25 = _loc_30;
                                _loc_25.next = _loc_29.head;
                                _loc_29.head = _loc_25;
                                _loc_29.modified = true;
                                (_loc_29.length + 1);
                                _loc_29 = _loc_27.b2.arbiters;
                                if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                {
                                    _loc_30 = new ZNPNode_ZPP_Arbiter();
                                }
                                else
                                {
                                    _loc_30 = ZNPNode_ZPP_Arbiter.zpp_pool;
                                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc_30.next;
                                    _loc_30.next = null;
                                }
                                _loc_30.elt = _loc_27;
                                _loc_25 = _loc_30;
                                _loc_25.next = _loc_29.head;
                                _loc_29.head = _loc_25;
                                _loc_29.modified = true;
                                (_loc_29.length + 1);
                                _loc_27.active = true;
                                _loc_27.present = 0;
                                _loc_27.cleared = false;
                                _loc_27.sleeping = false;
                                _loc_27.fresh = false;
                                _loc_27.presentable = false;
                                _loc_27.nx = 0;
                                _loc_27.ny = 1;
                                _loc_27.dampx = 0;
                                _loc_27.dampy = 0;
                                _loc_27.adamp = 0;
                                _loc_36 = f_arbiters;
                                if (ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                                {
                                    _loc_38 = new ZNPNode_ZPP_FluidArbiter();
                                }
                                else
                                {
                                    _loc_38 = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                                    ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_38.next;
                                    _loc_38.next = null;
                                }
                                _loc_38.elt = _loc_27;
                                _loc_37 = _loc_38;
                                _loc_37.next = _loc_36.head;
                                _loc_36.head = _loc_37;
                                _loc_36.modified = true;
                                (_loc_36.length + 1);
                                _loc_27.fresh = !_loc_28;
                            }
                            else
                            {
                                if (_loc_27.up_stamp >= (stamp - 1))
                                {
                                    if (_loc_27.endGenerated == stamp)
                                    {
                                    }
                                }
                                _loc_27.fresh = param5;
                            }
                            _loc_27.up_stamp = _loc_27.stamp;
                            if (!_loc_27.fresh)
                            {
                            }
                            if ((_loc_27.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                            {
                                _loc_27.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                _loc_31 = false;
                                if (_loc_27.ws1.id > _loc_27.ws2.id)
                                {
                                    _loc_39 = _loc_27.ws2;
                                }
                                else
                                {
                                    _loc_39 = _loc_27.ws1;
                                }
                                if (_loc_27.ws1.id > _loc_27.ws2.id)
                                {
                                    _loc_40 = _loc_27.ws1;
                                }
                                else
                                {
                                    _loc_40 = _loc_27.ws2;
                                }
                                _loc_41 = mrca1;
                                while (_loc_41.head != null)
                                {
                                    
                                    _loc_42 = _loc_41.head;
                                    _loc_41.head = _loc_42.next;
                                    _loc_43 = _loc_42;
                                    _loc_43.elt = null;
                                    _loc_43.next = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_43;
                                    if (_loc_41.head == null)
                                    {
                                        _loc_41.pushmod = true;
                                    }
                                    _loc_41.modified = true;
                                    (_loc_41.length - 1);
                                }
                                _loc_41.pushmod = true;
                                _loc_41 = mrca2;
                                while (_loc_41.head != null)
                                {
                                    
                                    _loc_42 = _loc_41.head;
                                    _loc_41.head = _loc_42.next;
                                    _loc_43 = _loc_42;
                                    _loc_43.elt = null;
                                    _loc_43.next = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_43;
                                    if (_loc_41.head == null)
                                    {
                                        _loc_41.pushmod = true;
                                    }
                                    _loc_41.modified = true;
                                    (_loc_41.length - 1);
                                }
                                _loc_41.pushmod = true;
                                if (_loc_39.cbSet != null)
                                {
                                    _loc_41 = mrca1;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_39;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                if (_loc_39.body.cbSet != null)
                                {
                                    _loc_41 = mrca1;
                                    _loc_15 = _loc_39.body;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_15;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                if (_loc_40.cbSet != null)
                                {
                                    _loc_41 = mrca2;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_40;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                if (_loc_40.body.cbSet != null)
                                {
                                    _loc_41 = mrca2;
                                    _loc_15 = _loc_40.body;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_15;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                _loc_44 = _loc_39.body.compound;
                                _loc_45 = _loc_40.body.compound;
                                while (_loc_44 != _loc_45)
                                {
                                    
                                    if (_loc_44 == null)
                                    {
                                        _loc_46 = 0;
                                    }
                                    else
                                    {
                                        _loc_46 = _loc_44.depth;
                                    }
                                    if (_loc_45 == null)
                                    {
                                        _loc_47 = 0;
                                    }
                                    else
                                    {
                                        _loc_47 = _loc_45.depth;
                                    }
                                    if (_loc_46 < _loc_47)
                                    {
                                        if (_loc_45.cbSet != null)
                                        {
                                            _loc_41 = mrca2;
                                            if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                            {
                                                _loc_43 = new ZNPNode_ZPP_Interactor();
                                            }
                                            else
                                            {
                                                _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                                ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                                _loc_43.next = null;
                                            }
                                            _loc_43.elt = _loc_45;
                                            _loc_42 = _loc_43;
                                            _loc_42.next = _loc_41.head;
                                            _loc_41.head = _loc_42;
                                            _loc_41.modified = true;
                                            (_loc_41.length + 1);
                                        }
                                        _loc_45 = _loc_45.compound;
                                        continue;
                                    }
                                    if (_loc_44.cbSet != null)
                                    {
                                        _loc_41 = mrca1;
                                        if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                        {
                                            _loc_43 = new ZNPNode_ZPP_Interactor();
                                        }
                                        else
                                        {
                                            _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                            ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                            _loc_43.next = null;
                                        }
                                        _loc_43.elt = _loc_44;
                                        _loc_42 = _loc_43;
                                        _loc_42.next = _loc_41.head;
                                        _loc_41.head = _loc_42;
                                        _loc_41.modified = true;
                                        (_loc_41.length + 1);
                                    }
                                    _loc_44 = _loc_44.compound;
                                }
                                _loc_42 = mrca1.head;
                                while (_loc_42 != null)
                                {
                                    
                                    _loc_15 = _loc_42.elt;
                                    _loc_43 = mrca2.head;
                                    while (_loc_43 != null)
                                    {
                                        
                                        _loc_48 = _loc_43.elt;
                                        _loc_49 = _loc_15.cbSet;
                                        _loc_50 = _loc_48.cbSet;
                                        _loc_52 = null;
                                        if (_loc_49.cbpairs.length < _loc_50.cbpairs.length)
                                        {
                                            _loc_53 = _loc_49.cbpairs;
                                        }
                                        else
                                        {
                                            _loc_53 = _loc_50.cbpairs;
                                        }
                                        _loc_54 = _loc_53.head;
                                        while (_loc_54 != null)
                                        {
                                            
                                            _loc_55 = _loc_54.elt;
                                            if (_loc_55.a == _loc_49)
                                            {
                                            }
                                            if (_loc_55.b != _loc_50)
                                            {
                                                if (_loc_55.a == _loc_50)
                                                {
                                                }
                                            }
                                            if (_loc_55.b == _loc_49)
                                            {
                                                _loc_52 = _loc_55;
                                                break;
                                            }
                                            _loc_54 = _loc_54.next;
                                        }
                                        if (_loc_52 == null)
                                        {
                                            if (ZPP_CbSetPair.zpp_pool == null)
                                            {
                                                _loc_55 = new ZPP_CbSetPair();
                                            }
                                            else
                                            {
                                                _loc_55 = ZPP_CbSetPair.zpp_pool;
                                                ZPP_CbSetPair.zpp_pool = _loc_55.next;
                                                _loc_55.next = null;
                                            }
                                            _loc_55.zip_listeners = true;
                                            if (ZPP_CbSet.setlt(_loc_49, _loc_50))
                                            {
                                                _loc_55.a = _loc_49;
                                                _loc_55.b = _loc_50;
                                            }
                                            else
                                            {
                                                _loc_55.a = _loc_50;
                                                _loc_55.b = _loc_49;
                                            }
                                            _loc_52 = _loc_55;
                                            _loc_49.cbpairs.add(_loc_52);
                                            if (_loc_50 != _loc_49)
                                            {
                                                _loc_50.cbpairs.add(_loc_52);
                                            }
                                        }
                                        if (_loc_52.zip_listeners)
                                        {
                                            _loc_52.zip_listeners = false;
                                            _loc_52.__validate();
                                        }
                                        _loc_51 = _loc_52;
                                        if (_loc_51.listeners.head == null)
                                        {
                                            _loc_43 = _loc_43.next;
                                            continue;
                                        }
                                        _loc_56 = null;
                                        _loc_57 = null;
                                        _loc_58 = prelisteners;
                                        while (_loc_58.head != null)
                                        {
                                            
                                            _loc_59 = _loc_58.head;
                                            _loc_58.head = _loc_59.next;
                                            _loc_60 = _loc_59;
                                            _loc_60.elt = null;
                                            _loc_60.next = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                            ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_60;
                                            if (_loc_58.head == null)
                                            {
                                                _loc_58.pushmod = true;
                                            }
                                            _loc_58.modified = true;
                                            (_loc_58.length - 1);
                                        }
                                        _loc_58.pushmod = true;
                                        _loc_59 = null;
                                        _loc_46 = ZPP_Flags.id_CbEvent_PRE;
                                        _loc_52 = null;
                                        if (_loc_49.cbpairs.length < _loc_50.cbpairs.length)
                                        {
                                            _loc_53 = _loc_49.cbpairs;
                                        }
                                        else
                                        {
                                            _loc_53 = _loc_50.cbpairs;
                                        }
                                        _loc_54 = _loc_53.head;
                                        while (_loc_54 != null)
                                        {
                                            
                                            _loc_55 = _loc_54.elt;
                                            if (_loc_55.a == _loc_49)
                                            {
                                            }
                                            if (_loc_55.b != _loc_50)
                                            {
                                                if (_loc_55.a == _loc_50)
                                                {
                                                }
                                            }
                                            if (_loc_55.b == _loc_49)
                                            {
                                                _loc_52 = _loc_55;
                                                break;
                                            }
                                            _loc_54 = _loc_54.next;
                                        }
                                        if (_loc_52 == null)
                                        {
                                            if (ZPP_CbSetPair.zpp_pool == null)
                                            {
                                                _loc_55 = new ZPP_CbSetPair();
                                            }
                                            else
                                            {
                                                _loc_55 = ZPP_CbSetPair.zpp_pool;
                                                ZPP_CbSetPair.zpp_pool = _loc_55.next;
                                                _loc_55.next = null;
                                            }
                                            _loc_55.zip_listeners = true;
                                            if (ZPP_CbSet.setlt(_loc_49, _loc_50))
                                            {
                                                _loc_55.a = _loc_49;
                                                _loc_55.b = _loc_50;
                                            }
                                            else
                                            {
                                                _loc_55.a = _loc_50;
                                                _loc_55.b = _loc_49;
                                            }
                                            _loc_52 = _loc_55;
                                            _loc_49.cbpairs.add(_loc_52);
                                            if (_loc_50 != _loc_49)
                                            {
                                                _loc_50.cbpairs.add(_loc_52);
                                            }
                                        }
                                        if (_loc_52.zip_listeners)
                                        {
                                            _loc_52.zip_listeners = false;
                                            _loc_52.__validate();
                                        }
                                        _loc_51 = _loc_52;
                                        _loc_60 = _loc_51.listeners.head;
                                        while (_loc_60 != null)
                                        {
                                            
                                            _loc_61 = _loc_60.elt;
                                            if (_loc_61.event == _loc_46)
                                            {
                                                if ((_loc_61.itype & _loc_35) != 0)
                                                {
                                                    _loc_58 = _loc_6.prelisteners;
                                                    if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                                                    {
                                                        _loc_63 = new ZNPNode_ZPP_InteractionListener();
                                                    }
                                                    else
                                                    {
                                                        _loc_63 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                                        ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_63.next;
                                                        _loc_63.next = null;
                                                    }
                                                    _loc_63.elt = _loc_61;
                                                    _loc_62 = _loc_63;
                                                    if (_loc_59 == null)
                                                    {
                                                        _loc_62.next = _loc_58.head;
                                                        _loc_58.head = _loc_62;
                                                    }
                                                    else
                                                    {
                                                        _loc_62.next = _loc_59.next;
                                                        _loc_59.next = _loc_62;
                                                    }
                                                    _loc_64 = true;
                                                    _loc_58.modified = _loc_64;
                                                    _loc_58.pushmod = _loc_64;
                                                    (_loc_58.length + 1);
                                                    _loc_59 = _loc_62;
                                                    if (!_loc_31)
                                                    {
                                                    }
                                                    _loc_31 = !_loc_61.pure;
                                                }
                                            }
                                            _loc_60 = _loc_60.next;
                                        }
                                        if (prelisteners.head == null)
                                        {
                                            _loc_43 = _loc_43.next;
                                            continue;
                                        }
                                        _loc_56 = ZPP_Interactor.get(_loc_15, _loc_48);
                                        if (_loc_56 == null)
                                        {
                                            _loc_57 = ZPP_CallbackSet.get(_loc_15, _loc_48);
                                            add_callbackset(_loc_57);
                                        }
                                        if (_loc_56 != null)
                                        {
                                            if (_loc_56.FLUIDstamp == stamp)
                                            {
                                            }
                                            if (param5)
                                            {
                                            }
                                        }
                                        if ((_loc_56.FLUIDstate & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                        {
                                            if (_loc_57 != null)
                                            {
                                                _loc_56 = _loc_57;
                                            }
                                            if (_loc_56 != null)
                                            {
                                                _loc_60 = prelisteners.head;
                                                while (_loc_60 != null)
                                                {
                                                    
                                                    _loc_61 = _loc_60.elt;
                                                    if (_loc_61.itype == ZPP_Flags.id_InteractionType_ANY)
                                                    {
                                                        _loc_56.COLLISIONstamp = stamp;
                                                        _loc_56.SENSORstamp = stamp;
                                                        _loc_56.FLUIDstamp = stamp;
                                                    }
                                                    else
                                                    {
                                                        _loc_56.FLUIDstamp = stamp;
                                                    }
                                                    _loc_60 = _loc_60.next;
                                                }
                                            }
                                            _loc_27.mutable = true;
                                            if (_loc_27.wrap_position != null)
                                            {
                                                _loc_27.wrap_position.zpp_inner._immutable = false;
                                            }
                                            _loc_64 = _loc_27.active;
                                            _loc_27.active = true;
                                            _loc_65 = false;
                                            precb.zpp_inner.pre_arbiter = _loc_27;
                                            precb.zpp_inner.set = _loc_56;
                                            _loc_60 = prelisteners.head;
                                            while (_loc_60 != null)
                                            {
                                                
                                                _loc_61 = _loc_60.elt;
                                                precb.zpp_inner.listener = _loc_61;
                                                _loc_66 = precb.zpp_inner;
                                                _loc_67 = _loc_56.int1;
                                                _loc_68 = _loc_56.int2;
                                                _loc_69 = _loc_61.options1;
                                                _loc_70 = _loc_67.cbTypes;
                                                if (_loc_69.nonemptyintersection(_loc_70, _loc_69.includes))
                                                {
                                                }
                                                if (!_loc_69.nonemptyintersection(_loc_70, _loc_69.excludes))
                                                {
                                                    _loc_69 = _loc_61.options2;
                                                    _loc_70 = _loc_68.cbTypes;
                                                    if (_loc_69.nonemptyintersection(_loc_70, _loc_69.includes))
                                                    {
                                                    }
                                                }
                                                if (!_loc_69.nonemptyintersection(_loc_70, _loc_69.excludes))
                                                {
                                                    _loc_66.int1 = _loc_67;
                                                    _loc_66.int2 = _loc_68;
                                                }
                                                else
                                                {
                                                    _loc_66.int1 = _loc_68;
                                                    _loc_66.int2 = _loc_67;
                                                }
                                                precb.zpp_inner.pre_swapped = _loc_15 != precb.zpp_inner.int1;
                                                _loc_71 = _loc_61.handlerp(precb);
                                                if (_loc_71 != null)
                                                {
                                                    if (ZPP_Flags.PreFlag_ACCEPT == null)
                                                    {
                                                        ZPP_Flags.internal = true;
                                                        ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
                                                        ZPP_Flags.internal = false;
                                                    }
                                                    if (_loc_71 == ZPP_Flags.PreFlag_ACCEPT)
                                                    {
                                                        _loc_27.immState = ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS;
                                                    }
                                                    else
                                                    {
                                                        if (ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
                                                        {
                                                            ZPP_Flags.internal = true;
                                                            ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
                                                            ZPP_Flags.internal = false;
                                                        }
                                                        if (_loc_71 == ZPP_Flags.PreFlag_ACCEPT_ONCE)
                                                        {
                                                            _loc_27.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                                        }
                                                        else
                                                        {
                                                            if (ZPP_Flags.PreFlag_IGNORE == null)
                                                            {
                                                                ZPP_Flags.internal = true;
                                                                ZPP_Flags.PreFlag_IGNORE = new PreFlag();
                                                                ZPP_Flags.internal = false;
                                                            }
                                                            if (_loc_71 == ZPP_Flags.PreFlag_IGNORE)
                                                            {
                                                                _loc_27.immState = ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS;
                                                            }
                                                            else
                                                            {
                                                                _loc_27.immState = ZPP_Flags.id_ImmState_IGNORE;
                                                            }
                                                        }
                                                    }
                                                }
                                                _loc_60 = _loc_60.next;
                                            }
                                            _loc_27.mutable = false;
                                            if (_loc_27.wrap_position != null)
                                            {
                                                _loc_27.wrap_position.zpp_inner._immutable = true;
                                            }
                                            _loc_27.active = _loc_64;
                                            if (_loc_56 != null)
                                            {
                                                _loc_60 = prelisteners.head;
                                                while (_loc_60 != null)
                                                {
                                                    
                                                    _loc_61 = _loc_60.elt;
                                                    if (_loc_61.itype == ZPP_Flags.id_InteractionType_ANY)
                                                    {
                                                        _loc_56.COLLISIONstate = _loc_27.immState;
                                                        _loc_56.SENSORstate = _loc_27.immState;
                                                        _loc_56.FLUIDstate = _loc_27.immState;
                                                    }
                                                    else
                                                    {
                                                        _loc_56.FLUIDstate = _loc_27.immState;
                                                    }
                                                    _loc_60 = _loc_60.next;
                                                }
                                            }
                                        }
                                        else if (_loc_56 == null)
                                        {
                                            if ((_loc_27.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                            {
                                                _loc_27.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                            }
                                        }
                                        else
                                        {
                                            _loc_27.immState = _loc_56.FLUIDstate;
                                        }
                                        _loc_43 = _loc_43.next;
                                    }
                                    _loc_42 = _loc_42.next;
                                }
                                if (_loc_31)
                                {
                                }
                                if ((_loc_27.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                {
                                    if (_loc_27.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                                    {
                                        _loc_24 = _loc_27.b1;
                                        if (!_loc_24.world)
                                        {
                                            _loc_24.component.waket = stamp + (midstep ? (0) : (1));
                                            if (_loc_24.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                            {
                                                _loc_24.kinematicDelaySleep = true;
                                            }
                                            if (_loc_24.component.sleeping)
                                            {
                                                really_wake(_loc_24, false);
                                            }
                                        }
                                    }
                                    if (_loc_27.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                                    {
                                        _loc_24 = _loc_27.b2;
                                        if (!_loc_24.world)
                                        {
                                            _loc_24.component.waket = stamp + (midstep ? (0) : (1));
                                            if (_loc_24.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                            {
                                                _loc_24.kinematicDelaySleep = true;
                                            }
                                            if (_loc_24.component.sleeping)
                                            {
                                                really_wake(_loc_24, false);
                                            }
                                        }
                                    }
                                }
                            }
                            if ((_loc_27.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                            {
                                if (_loc_27.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                                {
                                }
                                if (_loc_27.b1.component.sleeping)
                                {
                                    _loc_24 = _loc_27.b1;
                                    if (!_loc_24.world)
                                    {
                                        _loc_24.component.waket = stamp + (midstep ? (0) : (1));
                                        if (_loc_24.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                        {
                                            _loc_24.kinematicDelaySleep = true;
                                        }
                                        if (_loc_24.component.sleeping)
                                        {
                                            really_wake(_loc_24, false);
                                        }
                                    }
                                }
                                if (_loc_27.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
                                {
                                }
                                if (_loc_27.b2.component.sleeping)
                                {
                                    _loc_24 = _loc_27.b2;
                                    if (!_loc_24.world)
                                    {
                                        _loc_24.component.waket = stamp + (midstep ? (0) : (1));
                                        if (_loc_24.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                        {
                                            _loc_24.kinematicDelaySleep = true;
                                        }
                                        if (_loc_24.component.sleeping)
                                        {
                                            really_wake(_loc_24, false);
                                        }
                                    }
                                }
                            }
                            if (_loc_27.sleeping)
                            {
                                _loc_27.sleeping = false;
                                _loc_36 = f_arbiters;
                                if (ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                                {
                                    _loc_38 = new ZNPNode_ZPP_FluidArbiter();
                                }
                                else
                                {
                                    _loc_38 = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                                    ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_38.next;
                                    _loc_38.next = null;
                                }
                                _loc_38.elt = _loc_27;
                                _loc_37 = _loc_38;
                                _loc_37.next = _loc_36.head;
                                _loc_36.head = _loc_37;
                                _loc_36.modified = true;
                                (_loc_36.length + 1);
                            }
                            _loc_7 = _loc_27;
                        }
                        else if (_loc_17)
                        {
                            _loc_72 = _loc_27;
                            _loc_72.next = ZPP_FluidArbiter.zpp_pool;
                            ZPP_FluidArbiter.zpp_pool = _loc_72;
                            _loc_7 = null;
                        }
                        else
                        {
                            _loc_7 = _loc_27;
                        }
                    }
                    else
                    {
                        _loc_7 = _loc_27;
                    }
                }
                else if (_loc_10 == 1)
                {
                    if (param3)
                    {
                        _loc_73 = c_arbiters_true;
                    }
                    else
                    {
                        _loc_73 = c_arbiters_false;
                    }
                    if (param4 == null)
                    {
                        _loc_23 = null;
                        if (_loc_8.arbiters.length < _loc_9.arbiters.length)
                        {
                            _loc_24 = _loc_8;
                        }
                        else
                        {
                            _loc_24 = _loc_9;
                        }
                        _loc_25 = _loc_24.arbiters.head;
                        while (_loc_25 != null)
                        {
                            
                            _loc_26 = _loc_25.elt;
                            if (_loc_26.id == _loc_20.id)
                            {
                            }
                            if (_loc_26.di == _loc_21.id)
                            {
                                _loc_23 = _loc_26;
                                break;
                            }
                            _loc_25 = _loc_25.next;
                        }
                        _loc_22 = _loc_23;
                    }
                    else
                    {
                        _loc_22 = param4;
                    }
                    _loc_17 = _loc_22 == null;
                    _loc_28 = false;
                    if (_loc_17)
                    {
                        if (ZPP_ColArbiter.zpp_pool == null)
                        {
                            _loc_74 = new ZPP_ColArbiter();
                        }
                        else
                        {
                            _loc_74 = ZPP_ColArbiter.zpp_pool;
                            ZPP_ColArbiter.zpp_pool = _loc_74.next;
                            _loc_74.next = null;
                        }
                        _loc_74.stat = param3;
                    }
                    else if (_loc_22.colarb == null)
                    {
                        _loc_22.cleared = true;
                        _loc_29 = _loc_22.b1.arbiters;
                        _loc_25 = null;
                        _loc_30 = _loc_29.head;
                        _loc_31 = false;
                        while (_loc_30 != null)
                        {
                            
                            if (_loc_30.elt == _loc_22)
                            {
                                if (_loc_25 == null)
                                {
                                    _loc_32 = _loc_29.head;
                                    _loc_33 = _loc_32.next;
                                    _loc_29.head = _loc_33;
                                    if (_loc_29.head == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_32 = _loc_25.next;
                                    _loc_33 = _loc_32.next;
                                    _loc_25.next = _loc_33;
                                    if (_loc_33 == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                _loc_34 = _loc_32;
                                _loc_34.elt = null;
                                _loc_34.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_34;
                                _loc_29.modified = true;
                                (_loc_29.length - 1);
                                _loc_29.pushmod = true;
                                _loc_31 = true;
                                break;
                            }
                            _loc_25 = _loc_30;
                            _loc_30 = _loc_30.next;
                        }
                        _loc_29 = _loc_22.b2.arbiters;
                        _loc_25 = null;
                        _loc_30 = _loc_29.head;
                        _loc_31 = false;
                        while (_loc_30 != null)
                        {
                            
                            if (_loc_30.elt == _loc_22)
                            {
                                if (_loc_25 == null)
                                {
                                    _loc_32 = _loc_29.head;
                                    _loc_33 = _loc_32.next;
                                    _loc_29.head = _loc_33;
                                    if (_loc_29.head == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_32 = _loc_25.next;
                                    _loc_33 = _loc_32.next;
                                    _loc_25.next = _loc_33;
                                    if (_loc_33 == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                _loc_34 = _loc_32;
                                _loc_34.elt = null;
                                _loc_34.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_34;
                                _loc_29.modified = true;
                                (_loc_29.length - 1);
                                _loc_29.pushmod = true;
                                _loc_31 = true;
                                break;
                            }
                            _loc_25 = _loc_30;
                            _loc_30 = _loc_30.next;
                        }
                        if (_loc_22.pair != null)
                        {
                            _loc_22.pair.arb = null;
                            _loc_22.pair = null;
                        }
                        _loc_22.active = false;
                        f_arbiters.modified = true;
                        if (ZPP_ColArbiter.zpp_pool == null)
                        {
                            _loc_74 = new ZPP_ColArbiter();
                        }
                        else
                        {
                            _loc_74 = ZPP_ColArbiter.zpp_pool;
                            ZPP_ColArbiter.zpp_pool = _loc_74.next;
                            _loc_74.next = null;
                        }
                        _loc_74.intchange = true;
                        _loc_74.stat = param3;
                        _loc_17 = true;
                        _loc_28 = true;
                    }
                    else
                    {
                        _loc_74 = _loc_22.colarb;
                        _loc_11 = _loc_20 != _loc_74.s1;
                        if (_loc_74.stat != param3)
                        {
                            _loc_74.stat = param3;
                            if (!_loc_74.sleeping)
                            {
                                (param3 ? (c_arbiters_false) : (c_arbiters_true)).remove(_loc_74);
                                _loc_73.add(_loc_74);
                            }
                        }
                    }
                    _loc_35 = ZPP_Flags.id_InteractionType_COLLISION;
                    if (!_loc_17)
                    {
                    }
                    if (_loc_74.stamp == stamp)
                    {
                    }
                    if (param5)
                    {
                        _loc_74.stamp = stamp;
                        if (ZPP_Collide.contactCollide(_loc_20, _loc_21, _loc_74, _loc_11))
                        {
                            if (_loc_17)
                            {
                                _loc_74.b1 = param1.body;
                                _loc_74.ws1 = param1;
                                _loc_74.b2 = param2.body;
                                _loc_74.ws2 = param2;
                                _loc_74.id = _loc_20.id;
                                _loc_74.di = _loc_21.id;
                                _loc_29 = _loc_74.b1.arbiters;
                                if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                {
                                    _loc_30 = new ZNPNode_ZPP_Arbiter();
                                }
                                else
                                {
                                    _loc_30 = ZNPNode_ZPP_Arbiter.zpp_pool;
                                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc_30.next;
                                    _loc_30.next = null;
                                }
                                _loc_30.elt = _loc_74;
                                _loc_25 = _loc_30;
                                _loc_25.next = _loc_29.head;
                                _loc_29.head = _loc_25;
                                _loc_29.modified = true;
                                (_loc_29.length + 1);
                                _loc_29 = _loc_74.b2.arbiters;
                                if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                {
                                    _loc_30 = new ZNPNode_ZPP_Arbiter();
                                }
                                else
                                {
                                    _loc_30 = ZNPNode_ZPP_Arbiter.zpp_pool;
                                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc_30.next;
                                    _loc_30.next = null;
                                }
                                _loc_30.elt = _loc_74;
                                _loc_25 = _loc_30;
                                _loc_25.next = _loc_29.head;
                                _loc_29.head = _loc_25;
                                _loc_29.modified = true;
                                (_loc_29.length + 1);
                                _loc_74.active = true;
                                _loc_74.present = 0;
                                _loc_74.cleared = false;
                                _loc_74.sleeping = false;
                                _loc_74.fresh = false;
                                _loc_74.presentable = false;
                                _loc_74.s1 = param1;
                                _loc_74.s2 = param2;
                                if (!_loc_74.userdef_restitution)
                                {
                                    if (_loc_74.s1.material.elasticity > -17899999999999994000000000000)
                                    {
                                    }
                                    if (_loc_74.s2.material.elasticity <= -17899999999999994000000000000)
                                    {
                                        _loc_74.restitution = 0;
                                    }
                                    else
                                    {
                                        if (_loc_74.s1.material.elasticity < 17899999999999994000000000000)
                                        {
                                        }
                                        if (_loc_74.s2.material.elasticity >= 17899999999999994000000000000)
                                        {
                                            _loc_74.restitution = 1;
                                        }
                                        else
                                        {
                                            _loc_74.restitution = (_loc_74.s1.material.elasticity + _loc_74.s2.material.elasticity) / 2;
                                        }
                                    }
                                    if (_loc_74.restitution < 0)
                                    {
                                        _loc_74.restitution = 0;
                                    }
                                    if (_loc_74.restitution > 1)
                                    {
                                        _loc_74.restitution = 1;
                                    }
                                }
                                if (!_loc_74.userdef_dyn_fric)
                                {
                                    _loc_75 = _loc_74.s1.material.dynamicFriction * _loc_74.s2.material.dynamicFriction;
                                    if (_loc_75 == 0)
                                    {
                                        _loc_74.dyn_fric = 0;
                                    }
                                    else
                                    {
                                        _loc_46 = 1597463007 - (0 >> 1);
                                        _loc_76 = 0;
                                        _loc_46.dyn_fric = 0 / (_loc_76 * (1.5 - 0.5 * _loc_75 * _loc_76 * _loc_76));
                                    }
                                }
                                if (!_loc_74.userdef_stat_fric)
                                {
                                    _loc_75 = _loc_74.s1.material.staticFriction * _loc_74.s2.material.staticFriction;
                                    if (_loc_75 == 0)
                                    {
                                        _loc_74.stat_fric = 0;
                                    }
                                    else
                                    {
                                        _loc_46 = 1597463007 - (0 >> 1);
                                        _loc_76 = 0;
                                        _loc_46.stat_fric = 0 / (_loc_76 * (1.5 - 0.5 * _loc_75 * _loc_76 * _loc_76));
                                    }
                                }
                                if (!_loc_74.userdef_rfric)
                                {
                                    _loc_75 = _loc_74.s1.material.rollingFriction * _loc_74.s2.material.rollingFriction;
                                    if (_loc_75 == 0)
                                    {
                                        _loc_74.rfric = 0;
                                    }
                                    else
                                    {
                                        _loc_46 = 1597463007 - (0 >> 1);
                                        _loc_76 = 0;
                                        _loc_46.rfric = 0 / (_loc_76 * (1.5 - 0.5 * _loc_75 * _loc_76 * _loc_76));
                                    }
                                }
                                if (ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                                {
                                    _loc_78 = new ZNPNode_ZPP_ColArbiter();
                                }
                                else
                                {
                                    _loc_78 = ZNPNode_ZPP_ColArbiter.zpp_pool;
                                    ZNPNode_ZPP_ColArbiter.zpp_pool = _loc_78.next;
                                    _loc_78.next = null;
                                }
                                _loc_78.elt = _loc_74;
                                _loc_77 = _loc_78;
                                _loc_77.next = _loc_73.head;
                                _loc_73.head = _loc_77;
                                _loc_73.modified = true;
                                (_loc_73.length + 1);
                                _loc_74.fresh = !_loc_28;
                            }
                            else
                            {
                                if (_loc_74.up_stamp >= (stamp - 1))
                                {
                                    if (_loc_74.endGenerated == stamp)
                                    {
                                    }
                                }
                                _loc_74.fresh = param5;
                            }
                            _loc_74.up_stamp = _loc_74.stamp;
                            if (!_loc_74.fresh)
                            {
                            }
                            if ((_loc_74.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                            {
                                _loc_74.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                _loc_31 = false;
                                if (_loc_74.ws1.id > _loc_74.ws2.id)
                                {
                                    _loc_39 = _loc_74.ws2;
                                }
                                else
                                {
                                    _loc_39 = _loc_74.ws1;
                                }
                                if (_loc_74.ws1.id > _loc_74.ws2.id)
                                {
                                    _loc_40 = _loc_74.ws1;
                                }
                                else
                                {
                                    _loc_40 = _loc_74.ws2;
                                }
                                _loc_41 = mrca1;
                                while (_loc_41.head != null)
                                {
                                    
                                    _loc_42 = _loc_41.head;
                                    _loc_41.head = _loc_42.next;
                                    _loc_43 = _loc_42;
                                    _loc_43.elt = null;
                                    _loc_43.next = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_43;
                                    if (_loc_41.head == null)
                                    {
                                        _loc_41.pushmod = true;
                                    }
                                    _loc_41.modified = true;
                                    (_loc_41.length - 1);
                                }
                                _loc_41.pushmod = true;
                                _loc_41 = mrca2;
                                while (_loc_41.head != null)
                                {
                                    
                                    _loc_42 = _loc_41.head;
                                    _loc_41.head = _loc_42.next;
                                    _loc_43 = _loc_42;
                                    _loc_43.elt = null;
                                    _loc_43.next = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_43;
                                    if (_loc_41.head == null)
                                    {
                                        _loc_41.pushmod = true;
                                    }
                                    _loc_41.modified = true;
                                    (_loc_41.length - 1);
                                }
                                _loc_41.pushmod = true;
                                if (_loc_39.cbSet != null)
                                {
                                    _loc_41 = mrca1;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_39;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                if (_loc_39.body.cbSet != null)
                                {
                                    _loc_41 = mrca1;
                                    _loc_15 = _loc_39.body;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_15;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                if (_loc_40.cbSet != null)
                                {
                                    _loc_41 = mrca2;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_40;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                if (_loc_40.body.cbSet != null)
                                {
                                    _loc_41 = mrca2;
                                    _loc_15 = _loc_40.body;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_15;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                _loc_44 = _loc_39.body.compound;
                                _loc_45 = _loc_40.body.compound;
                                while (_loc_44 != _loc_45)
                                {
                                    
                                    if (_loc_44 == null)
                                    {
                                        _loc_46 = 0;
                                    }
                                    else
                                    {
                                        _loc_46 = _loc_44.depth;
                                    }
                                    if (_loc_45 == null)
                                    {
                                        _loc_47 = 0;
                                    }
                                    else
                                    {
                                        _loc_47 = _loc_45.depth;
                                    }
                                    if (_loc_46 < _loc_47)
                                    {
                                        if (_loc_45.cbSet != null)
                                        {
                                            _loc_41 = mrca2;
                                            if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                            {
                                                _loc_43 = new ZNPNode_ZPP_Interactor();
                                            }
                                            else
                                            {
                                                _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                                ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                                _loc_43.next = null;
                                            }
                                            _loc_43.elt = _loc_45;
                                            _loc_42 = _loc_43;
                                            _loc_42.next = _loc_41.head;
                                            _loc_41.head = _loc_42;
                                            _loc_41.modified = true;
                                            (_loc_41.length + 1);
                                        }
                                        _loc_45 = _loc_45.compound;
                                        continue;
                                    }
                                    if (_loc_44.cbSet != null)
                                    {
                                        _loc_41 = mrca1;
                                        if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                        {
                                            _loc_43 = new ZNPNode_ZPP_Interactor();
                                        }
                                        else
                                        {
                                            _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                            ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                            _loc_43.next = null;
                                        }
                                        _loc_43.elt = _loc_44;
                                        _loc_42 = _loc_43;
                                        _loc_42.next = _loc_41.head;
                                        _loc_41.head = _loc_42;
                                        _loc_41.modified = true;
                                        (_loc_41.length + 1);
                                    }
                                    _loc_44 = _loc_44.compound;
                                }
                                _loc_42 = mrca1.head;
                                while (_loc_42 != null)
                                {
                                    
                                    _loc_15 = _loc_42.elt;
                                    _loc_43 = mrca2.head;
                                    while (_loc_43 != null)
                                    {
                                        
                                        _loc_48 = _loc_43.elt;
                                        _loc_49 = _loc_15.cbSet;
                                        _loc_50 = _loc_48.cbSet;
                                        _loc_52 = null;
                                        if (_loc_49.cbpairs.length < _loc_50.cbpairs.length)
                                        {
                                            _loc_53 = _loc_49.cbpairs;
                                        }
                                        else
                                        {
                                            _loc_53 = _loc_50.cbpairs;
                                        }
                                        _loc_54 = _loc_53.head;
                                        while (_loc_54 != null)
                                        {
                                            
                                            _loc_55 = _loc_54.elt;
                                            if (_loc_55.a == _loc_49)
                                            {
                                            }
                                            if (_loc_55.b != _loc_50)
                                            {
                                                if (_loc_55.a == _loc_50)
                                                {
                                                }
                                            }
                                            if (_loc_55.b == _loc_49)
                                            {
                                                _loc_52 = _loc_55;
                                                break;
                                            }
                                            _loc_54 = _loc_54.next;
                                        }
                                        if (_loc_52 == null)
                                        {
                                            if (ZPP_CbSetPair.zpp_pool == null)
                                            {
                                                _loc_55 = new ZPP_CbSetPair();
                                            }
                                            else
                                            {
                                                _loc_55 = ZPP_CbSetPair.zpp_pool;
                                                ZPP_CbSetPair.zpp_pool = _loc_55.next;
                                                _loc_55.next = null;
                                            }
                                            _loc_55.zip_listeners = true;
                                            if (ZPP_CbSet.setlt(_loc_49, _loc_50))
                                            {
                                                _loc_55.a = _loc_49;
                                                _loc_55.b = _loc_50;
                                            }
                                            else
                                            {
                                                _loc_55.a = _loc_50;
                                                _loc_55.b = _loc_49;
                                            }
                                            _loc_52 = _loc_55;
                                            _loc_49.cbpairs.add(_loc_52);
                                            if (_loc_50 != _loc_49)
                                            {
                                                _loc_50.cbpairs.add(_loc_52);
                                            }
                                        }
                                        if (_loc_52.zip_listeners)
                                        {
                                            _loc_52.zip_listeners = false;
                                            _loc_52.__validate();
                                        }
                                        _loc_51 = _loc_52;
                                        if (_loc_51.listeners.head == null)
                                        {
                                            _loc_43 = _loc_43.next;
                                            continue;
                                        }
                                        _loc_56 = null;
                                        _loc_57 = null;
                                        _loc_58 = prelisteners;
                                        while (_loc_58.head != null)
                                        {
                                            
                                            _loc_59 = _loc_58.head;
                                            _loc_58.head = _loc_59.next;
                                            _loc_60 = _loc_59;
                                            _loc_60.elt = null;
                                            _loc_60.next = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                            ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_60;
                                            if (_loc_58.head == null)
                                            {
                                                _loc_58.pushmod = true;
                                            }
                                            _loc_58.modified = true;
                                            (_loc_58.length - 1);
                                        }
                                        _loc_58.pushmod = true;
                                        _loc_59 = null;
                                        _loc_46 = ZPP_Flags.id_CbEvent_PRE;
                                        _loc_52 = null;
                                        if (_loc_49.cbpairs.length < _loc_50.cbpairs.length)
                                        {
                                            _loc_53 = _loc_49.cbpairs;
                                        }
                                        else
                                        {
                                            _loc_53 = _loc_50.cbpairs;
                                        }
                                        _loc_54 = _loc_53.head;
                                        while (_loc_54 != null)
                                        {
                                            
                                            _loc_55 = _loc_54.elt;
                                            if (_loc_55.a == _loc_49)
                                            {
                                            }
                                            if (_loc_55.b != _loc_50)
                                            {
                                                if (_loc_55.a == _loc_50)
                                                {
                                                }
                                            }
                                            if (_loc_55.b == _loc_49)
                                            {
                                                _loc_52 = _loc_55;
                                                break;
                                            }
                                            _loc_54 = _loc_54.next;
                                        }
                                        if (_loc_52 == null)
                                        {
                                            if (ZPP_CbSetPair.zpp_pool == null)
                                            {
                                                _loc_55 = new ZPP_CbSetPair();
                                            }
                                            else
                                            {
                                                _loc_55 = ZPP_CbSetPair.zpp_pool;
                                                ZPP_CbSetPair.zpp_pool = _loc_55.next;
                                                _loc_55.next = null;
                                            }
                                            _loc_55.zip_listeners = true;
                                            if (ZPP_CbSet.setlt(_loc_49, _loc_50))
                                            {
                                                _loc_55.a = _loc_49;
                                                _loc_55.b = _loc_50;
                                            }
                                            else
                                            {
                                                _loc_55.a = _loc_50;
                                                _loc_55.b = _loc_49;
                                            }
                                            _loc_52 = _loc_55;
                                            _loc_49.cbpairs.add(_loc_52);
                                            if (_loc_50 != _loc_49)
                                            {
                                                _loc_50.cbpairs.add(_loc_52);
                                            }
                                        }
                                        if (_loc_52.zip_listeners)
                                        {
                                            _loc_52.zip_listeners = false;
                                            _loc_52.__validate();
                                        }
                                        _loc_51 = _loc_52;
                                        _loc_60 = _loc_51.listeners.head;
                                        while (_loc_60 != null)
                                        {
                                            
                                            _loc_61 = _loc_60.elt;
                                            if (_loc_61.event == _loc_46)
                                            {
                                                if ((_loc_61.itype & _loc_35) != 0)
                                                {
                                                    _loc_58 = _loc_6.prelisteners;
                                                    if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                                                    {
                                                        _loc_63 = new ZNPNode_ZPP_InteractionListener();
                                                    }
                                                    else
                                                    {
                                                        _loc_63 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                                        ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_63.next;
                                                        _loc_63.next = null;
                                                    }
                                                    _loc_63.elt = _loc_61;
                                                    _loc_62 = _loc_63;
                                                    if (_loc_59 == null)
                                                    {
                                                        _loc_62.next = _loc_58.head;
                                                        _loc_58.head = _loc_62;
                                                    }
                                                    else
                                                    {
                                                        _loc_62.next = _loc_59.next;
                                                        _loc_59.next = _loc_62;
                                                    }
                                                    _loc_64 = true;
                                                    _loc_58.modified = _loc_64;
                                                    _loc_58.pushmod = _loc_64;
                                                    (_loc_58.length + 1);
                                                    _loc_59 = _loc_62;
                                                    if (!_loc_31)
                                                    {
                                                    }
                                                    _loc_31 = !_loc_61.pure;
                                                }
                                            }
                                            _loc_60 = _loc_60.next;
                                        }
                                        if (prelisteners.head == null)
                                        {
                                            _loc_43 = _loc_43.next;
                                            continue;
                                        }
                                        _loc_56 = ZPP_Interactor.get(_loc_15, _loc_48);
                                        if (_loc_56 == null)
                                        {
                                            _loc_57 = ZPP_CallbackSet.get(_loc_15, _loc_48);
                                            add_callbackset(_loc_57);
                                        }
                                        if (_loc_56 != null)
                                        {
                                            if (_loc_56.COLLISIONstamp == stamp)
                                            {
                                            }
                                            if (param5)
                                            {
                                            }
                                        }
                                        if ((_loc_56.COLLISIONstate & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                        {
                                            if (_loc_57 != null)
                                            {
                                                _loc_56 = _loc_57;
                                            }
                                            if (_loc_56 != null)
                                            {
                                                _loc_60 = prelisteners.head;
                                                while (_loc_60 != null)
                                                {
                                                    
                                                    _loc_61 = _loc_60.elt;
                                                    if (_loc_61.itype == ZPP_Flags.id_InteractionType_ANY)
                                                    {
                                                        _loc_56.COLLISIONstamp = stamp;
                                                        _loc_56.SENSORstamp = stamp;
                                                        _loc_56.FLUIDstamp = stamp;
                                                    }
                                                    else
                                                    {
                                                        _loc_56.COLLISIONstamp = stamp;
                                                    }
                                                    _loc_60 = _loc_60.next;
                                                }
                                            }
                                            _loc_74.mutable = true;
                                            if (_loc_74.wrap_normal != null)
                                            {
                                                _loc_74.wrap_normal.zpp_inner._immutable = false;
                                            }
                                            if (_loc_74.wrap_contacts != null)
                                            {
                                                _loc_74.wrap_contacts.zpp_inner.immutable = false;
                                            }
                                            _loc_64 = _loc_74.active;
                                            _loc_74.active = true;
                                            _loc_65 = false;
                                            _loc_79 = true;
                                            _loc_80 = null;
                                            _loc_81 = null;
                                            _loc_82 = _loc_74.innards.next;
                                            _loc_74.hc2 = false;
                                            _loc_83 = _loc_74.contacts.next;
                                            while (_loc_83 != null)
                                            {
                                                
                                                _loc_84 = _loc_83;
                                                if (_loc_84.stamp + Config.arbiterExpirationDelay < _loc_74.stamp)
                                                {
                                                    _loc_85 = _loc_74.contacts;
                                                    if (_loc_80 == null)
                                                    {
                                                        _loc_86 = _loc_85.next;
                                                        _loc_87 = _loc_86.next;
                                                        _loc_85.next = _loc_87;
                                                        if (_loc_85.next == null)
                                                        {
                                                            _loc_85.pushmod = true;
                                                        }
                                                    }
                                                    else
                                                    {
                                                        _loc_86 = _loc_80.next;
                                                        _loc_87 = _loc_86.next;
                                                        _loc_80.next = _loc_87;
                                                        if (_loc_87 == null)
                                                        {
                                                            _loc_85.pushmod = true;
                                                        }
                                                    }
                                                    _loc_86._inuse = false;
                                                    _loc_85.modified = true;
                                                    (_loc_85.length - 1);
                                                    _loc_85.pushmod = true;
                                                    _loc_83 = _loc_87;
                                                    _loc_88 = _loc_74.innards;
                                                    if (_loc_81 == null)
                                                    {
                                                        _loc_89 = _loc_88.next;
                                                        _loc_90 = _loc_89.next;
                                                        _loc_88.next = _loc_90;
                                                        if (_loc_88.next == null)
                                                        {
                                                            _loc_88.pushmod = true;
                                                        }
                                                    }
                                                    else
                                                    {
                                                        _loc_89 = _loc_81.next;
                                                        _loc_90 = _loc_89.next;
                                                        _loc_81.next = _loc_90;
                                                        if (_loc_90 == null)
                                                        {
                                                            _loc_88.pushmod = true;
                                                        }
                                                    }
                                                    _loc_89._inuse = false;
                                                    _loc_88.modified = true;
                                                    (_loc_88.length - 1);
                                                    _loc_88.pushmod = true;
                                                    _loc_82 = _loc_90;
                                                    _loc_85 = _loc_84;
                                                    _loc_85.arbiter = null;
                                                    _loc_85.next = ZPP_Contact.zpp_pool;
                                                    ZPP_Contact.zpp_pool = _loc_85;
                                                    continue;
                                                }
                                                _loc_88 = _loc_84.inner;
                                                _loc_91 = _loc_84.active;
                                                _loc_84.active = _loc_84.stamp == _loc_74.stamp;
                                                if (_loc_84.active)
                                                {
                                                    if (_loc_79)
                                                    {
                                                        _loc_79 = false;
                                                        _loc_74.c1 = _loc_88;
                                                        _loc_74.oc1 = _loc_84;
                                                    }
                                                    else
                                                    {
                                                        _loc_74.hc2 = true;
                                                        _loc_74.c2 = _loc_88;
                                                        _loc_74.oc2 = _loc_84;
                                                    }
                                                }
                                                if (_loc_91 != _loc_84.active)
                                                {
                                                    _loc_74.contacts.modified = true;
                                                }
                                                _loc_80 = _loc_83;
                                                _loc_81 = _loc_82;
                                                _loc_82 = _loc_82.next;
                                                _loc_83 = _loc_83.next;
                                            }
                                            if (_loc_74.hc2)
                                            {
                                                _loc_74.hpc2 = true;
                                                if (_loc_74.oc1.posOnly)
                                                {
                                                    _loc_88 = _loc_74.c1;
                                                    _loc_74.c1 = _loc_74.c2;
                                                    _loc_74.c2 = _loc_88;
                                                    _loc_83 = _loc_74.oc1;
                                                    _loc_74.oc1 = _loc_74.oc2;
                                                    _loc_74.oc2 = _loc_83;
                                                    _loc_74.hc2 = false;
                                                }
                                                else if (_loc_74.oc2.posOnly)
                                                {
                                                    _loc_74.hc2 = false;
                                                }
                                                if (_loc_74.oc1.posOnly)
                                                {
                                                    _loc_79 = true;
                                                }
                                            }
                                            else
                                            {
                                                _loc_74.hpc2 = false;
                                            }
                                            precb.zpp_inner.pre_arbiter = _loc_74;
                                            precb.zpp_inner.set = _loc_56;
                                            _loc_60 = prelisteners.head;
                                            while (_loc_60 != null)
                                            {
                                                
                                                _loc_61 = _loc_60.elt;
                                                precb.zpp_inner.listener = _loc_61;
                                                _loc_66 = precb.zpp_inner;
                                                _loc_67 = _loc_56.int1;
                                                _loc_68 = _loc_56.int2;
                                                _loc_69 = _loc_61.options1;
                                                _loc_70 = _loc_67.cbTypes;
                                                if (_loc_69.nonemptyintersection(_loc_70, _loc_69.includes))
                                                {
                                                }
                                                if (!_loc_69.nonemptyintersection(_loc_70, _loc_69.excludes))
                                                {
                                                    _loc_69 = _loc_61.options2;
                                                    _loc_70 = _loc_68.cbTypes;
                                                    if (_loc_69.nonemptyintersection(_loc_70, _loc_69.includes))
                                                    {
                                                    }
                                                }
                                                if (!_loc_69.nonemptyintersection(_loc_70, _loc_69.excludes))
                                                {
                                                    _loc_66.int1 = _loc_67;
                                                    _loc_66.int2 = _loc_68;
                                                }
                                                else
                                                {
                                                    _loc_66.int1 = _loc_68;
                                                    _loc_66.int2 = _loc_67;
                                                }
                                                precb.zpp_inner.pre_swapped = _loc_15 != precb.zpp_inner.int1;
                                                _loc_71 = _loc_61.handlerp(precb);
                                                if (_loc_71 != null)
                                                {
                                                    if (ZPP_Flags.PreFlag_ACCEPT == null)
                                                    {
                                                        ZPP_Flags.internal = true;
                                                        ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
                                                        ZPP_Flags.internal = false;
                                                    }
                                                    if (_loc_71 == ZPP_Flags.PreFlag_ACCEPT)
                                                    {
                                                        _loc_74.immState = ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS;
                                                    }
                                                    else
                                                    {
                                                        if (ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
                                                        {
                                                            ZPP_Flags.internal = true;
                                                            ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
                                                            ZPP_Flags.internal = false;
                                                        }
                                                        if (_loc_71 == ZPP_Flags.PreFlag_ACCEPT_ONCE)
                                                        {
                                                            _loc_74.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                                        }
                                                        else
                                                        {
                                                            if (ZPP_Flags.PreFlag_IGNORE == null)
                                                            {
                                                                ZPP_Flags.internal = true;
                                                                ZPP_Flags.PreFlag_IGNORE = new PreFlag();
                                                                ZPP_Flags.internal = false;
                                                            }
                                                            if (_loc_71 == ZPP_Flags.PreFlag_IGNORE)
                                                            {
                                                                _loc_74.immState = ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS;
                                                            }
                                                            else
                                                            {
                                                                _loc_74.immState = ZPP_Flags.id_ImmState_IGNORE;
                                                            }
                                                        }
                                                    }
                                                }
                                                _loc_60 = _loc_60.next;
                                            }
                                            _loc_74.mutable = false;
                                            if (_loc_74.wrap_normal != null)
                                            {
                                                _loc_74.wrap_normal.zpp_inner._immutable = true;
                                            }
                                            if (_loc_74.wrap_contacts != null)
                                            {
                                                _loc_74.wrap_contacts.zpp_inner.immutable = true;
                                            }
                                            _loc_74.active = _loc_64;
                                            if (_loc_56 != null)
                                            {
                                                _loc_60 = prelisteners.head;
                                                while (_loc_60 != null)
                                                {
                                                    
                                                    _loc_61 = _loc_60.elt;
                                                    if (_loc_61.itype == ZPP_Flags.id_InteractionType_ANY)
                                                    {
                                                        _loc_56.COLLISIONstate = _loc_74.immState;
                                                        _loc_56.SENSORstate = _loc_74.immState;
                                                        _loc_56.FLUIDstate = _loc_74.immState;
                                                    }
                                                    else
                                                    {
                                                        _loc_56.COLLISIONstate = _loc_74.immState;
                                                    }
                                                    _loc_60 = _loc_60.next;
                                                }
                                            }
                                        }
                                        else if (_loc_56 == null)
                                        {
                                            if ((_loc_74.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                            {
                                                _loc_74.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                            }
                                        }
                                        else
                                        {
                                            _loc_74.immState = _loc_56.COLLISIONstate;
                                        }
                                        _loc_43 = _loc_43.next;
                                    }
                                    _loc_42 = _loc_42.next;
                                }
                                if (_loc_31)
                                {
                                }
                                if ((_loc_74.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                {
                                    if (_loc_74.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                                    {
                                        _loc_24 = _loc_74.b1;
                                        if (!_loc_24.world)
                                        {
                                            _loc_24.component.waket = stamp + (midstep ? (0) : (1));
                                            if (_loc_24.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                            {
                                                _loc_24.kinematicDelaySleep = true;
                                            }
                                            if (_loc_24.component.sleeping)
                                            {
                                                really_wake(_loc_24, false);
                                            }
                                        }
                                    }
                                    if (_loc_74.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                                    {
                                        _loc_24 = _loc_74.b2;
                                        if (!_loc_24.world)
                                        {
                                            _loc_24.component.waket = stamp + (midstep ? (0) : (1));
                                            if (_loc_24.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                            {
                                                _loc_24.kinematicDelaySleep = true;
                                            }
                                            if (_loc_24.component.sleeping)
                                            {
                                                really_wake(_loc_24, false);
                                            }
                                        }
                                    }
                                }
                            }
                            if ((_loc_74.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                            {
                                if (_loc_74.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                                {
                                }
                                if (_loc_74.b1.component.sleeping)
                                {
                                    _loc_24 = _loc_74.b1;
                                    if (!_loc_24.world)
                                    {
                                        _loc_24.component.waket = stamp + (midstep ? (0) : (1));
                                        if (_loc_24.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                        {
                                            _loc_24.kinematicDelaySleep = true;
                                        }
                                        if (_loc_24.component.sleeping)
                                        {
                                            really_wake(_loc_24, false);
                                        }
                                    }
                                }
                                if (_loc_74.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
                                {
                                }
                                if (_loc_74.b2.component.sleeping)
                                {
                                    _loc_24 = _loc_74.b2;
                                    if (!_loc_24.world)
                                    {
                                        _loc_24.component.waket = stamp + (midstep ? (0) : (1));
                                        if (_loc_24.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                        {
                                            _loc_24.kinematicDelaySleep = true;
                                        }
                                        if (_loc_24.component.sleeping)
                                        {
                                            really_wake(_loc_24, false);
                                        }
                                    }
                                }
                            }
                            if (_loc_74.sleeping)
                            {
                                _loc_74.sleeping = false;
                                if (ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                                {
                                    _loc_78 = new ZNPNode_ZPP_ColArbiter();
                                }
                                else
                                {
                                    _loc_78 = ZNPNode_ZPP_ColArbiter.zpp_pool;
                                    ZNPNode_ZPP_ColArbiter.zpp_pool = _loc_78.next;
                                    _loc_78.next = null;
                                }
                                _loc_78.elt = _loc_74;
                                _loc_77 = _loc_78;
                                _loc_77.next = _loc_73.head;
                                _loc_73.head = _loc_77;
                                _loc_73.modified = true;
                                (_loc_73.length + 1);
                            }
                            _loc_7 = _loc_74;
                        }
                        else if (_loc_17)
                        {
                            _loc_92 = _loc_74;
                            _loc_92.userdef_dyn_fric = false;
                            _loc_92.userdef_stat_fric = false;
                            _loc_92.userdef_restitution = false;
                            _loc_92.userdef_rfric = false;
                            _loc_93 = null;
                            _loc_92.__ref_edge2 = _loc_93;
                            _loc_92.__ref_edge1 = _loc_93;
                            _loc_92.next = ZPP_ColArbiter.zpp_pool;
                            ZPP_ColArbiter.zpp_pool = _loc_92;
                            _loc_7 = null;
                        }
                        else
                        {
                            _loc_7 = _loc_74;
                        }
                    }
                    else
                    {
                        _loc_7 = _loc_74;
                    }
                }
                else
                {
                    if (param4 == null)
                    {
                        _loc_23 = null;
                        if (_loc_8.arbiters.length < _loc_9.arbiters.length)
                        {
                            _loc_24 = _loc_8;
                        }
                        else
                        {
                            _loc_24 = _loc_9;
                        }
                        _loc_25 = _loc_24.arbiters.head;
                        while (_loc_25 != null)
                        {
                            
                            _loc_26 = _loc_25.elt;
                            if (_loc_26.id == _loc_20.id)
                            {
                            }
                            if (_loc_26.di == _loc_21.id)
                            {
                                _loc_23 = _loc_26;
                                break;
                            }
                            _loc_25 = _loc_25.next;
                        }
                        _loc_22 = _loc_23;
                    }
                    else
                    {
                        _loc_22 = param4;
                    }
                    _loc_17 = _loc_22 == null;
                    _loc_28 = false;
                    if (_loc_17)
                    {
                        if (ZPP_SensorArbiter.zpp_pool == null)
                        {
                            _loc_94 = new ZPP_SensorArbiter();
                        }
                        else
                        {
                            _loc_94 = ZPP_SensorArbiter.zpp_pool;
                            ZPP_SensorArbiter.zpp_pool = _loc_94.next;
                            _loc_94.next = null;
                        }
                    }
                    else if (_loc_22.sensorarb == null)
                    {
                        _loc_22.cleared = true;
                        _loc_29 = _loc_22.b1.arbiters;
                        _loc_25 = null;
                        _loc_30 = _loc_29.head;
                        _loc_31 = false;
                        while (_loc_30 != null)
                        {
                            
                            if (_loc_30.elt == _loc_22)
                            {
                                if (_loc_25 == null)
                                {
                                    _loc_32 = _loc_29.head;
                                    _loc_33 = _loc_32.next;
                                    _loc_29.head = _loc_33;
                                    if (_loc_29.head == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_32 = _loc_25.next;
                                    _loc_33 = _loc_32.next;
                                    _loc_25.next = _loc_33;
                                    if (_loc_33 == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                _loc_34 = _loc_32;
                                _loc_34.elt = null;
                                _loc_34.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_34;
                                _loc_29.modified = true;
                                (_loc_29.length - 1);
                                _loc_29.pushmod = true;
                                _loc_31 = true;
                                break;
                            }
                            _loc_25 = _loc_30;
                            _loc_30 = _loc_30.next;
                        }
                        _loc_29 = _loc_22.b2.arbiters;
                        _loc_25 = null;
                        _loc_30 = _loc_29.head;
                        _loc_31 = false;
                        while (_loc_30 != null)
                        {
                            
                            if (_loc_30.elt == _loc_22)
                            {
                                if (_loc_25 == null)
                                {
                                    _loc_32 = _loc_29.head;
                                    _loc_33 = _loc_32.next;
                                    _loc_29.head = _loc_33;
                                    if (_loc_29.head == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                else
                                {
                                    _loc_32 = _loc_25.next;
                                    _loc_33 = _loc_32.next;
                                    _loc_25.next = _loc_33;
                                    if (_loc_33 == null)
                                    {
                                        _loc_29.pushmod = true;
                                    }
                                }
                                _loc_34 = _loc_32;
                                _loc_34.elt = null;
                                _loc_34.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_34;
                                _loc_29.modified = true;
                                (_loc_29.length - 1);
                                _loc_29.pushmod = true;
                                _loc_31 = true;
                                break;
                            }
                            _loc_25 = _loc_30;
                            _loc_30 = _loc_30.next;
                        }
                        if (_loc_22.pair != null)
                        {
                            _loc_22.pair.arb = null;
                            _loc_22.pair = null;
                        }
                        _loc_22.active = false;
                        f_arbiters.modified = true;
                        if (ZPP_SensorArbiter.zpp_pool == null)
                        {
                            _loc_94 = new ZPP_SensorArbiter();
                        }
                        else
                        {
                            _loc_94 = ZPP_SensorArbiter.zpp_pool;
                            ZPP_SensorArbiter.zpp_pool = _loc_94.next;
                            _loc_94.next = null;
                        }
                        _loc_94.intchange = true;
                        _loc_17 = true;
                        _loc_28 = true;
                    }
                    else
                    {
                        _loc_94 = _loc_22.sensorarb;
                    }
                    _loc_35 = ZPP_Flags.id_InteractionType_SENSOR;
                    if (!_loc_17)
                    {
                    }
                    if (_loc_94.stamp == stamp)
                    {
                    }
                    if (param5)
                    {
                        _loc_94.stamp = stamp;
                        if (ZPP_Collide.testCollide(_loc_20, _loc_21))
                        {
                            if (_loc_17)
                            {
                                _loc_94.b1 = param1.body;
                                _loc_94.ws1 = param1;
                                _loc_94.b2 = param2.body;
                                _loc_94.ws2 = param2;
                                _loc_94.id = _loc_20.id;
                                _loc_94.di = _loc_21.id;
                                _loc_29 = _loc_94.b1.arbiters;
                                if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                {
                                    _loc_30 = new ZNPNode_ZPP_Arbiter();
                                }
                                else
                                {
                                    _loc_30 = ZNPNode_ZPP_Arbiter.zpp_pool;
                                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc_30.next;
                                    _loc_30.next = null;
                                }
                                _loc_30.elt = _loc_94;
                                _loc_25 = _loc_30;
                                _loc_25.next = _loc_29.head;
                                _loc_29.head = _loc_25;
                                _loc_29.modified = true;
                                (_loc_29.length + 1);
                                _loc_29 = _loc_94.b2.arbiters;
                                if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                {
                                    _loc_30 = new ZNPNode_ZPP_Arbiter();
                                }
                                else
                                {
                                    _loc_30 = ZNPNode_ZPP_Arbiter.zpp_pool;
                                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc_30.next;
                                    _loc_30.next = null;
                                }
                                _loc_30.elt = _loc_94;
                                _loc_25 = _loc_30;
                                _loc_25.next = _loc_29.head;
                                _loc_29.head = _loc_25;
                                _loc_29.modified = true;
                                (_loc_29.length + 1);
                                _loc_94.active = true;
                                _loc_94.present = 0;
                                _loc_94.cleared = false;
                                _loc_94.sleeping = false;
                                _loc_94.fresh = false;
                                _loc_94.presentable = false;
                                _loc_95 = s_arbiters;
                                if (ZNPNode_ZPP_SensorArbiter.zpp_pool == null)
                                {
                                    _loc_97 = new ZNPNode_ZPP_SensorArbiter();
                                }
                                else
                                {
                                    _loc_97 = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                                    ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc_97.next;
                                    _loc_97.next = null;
                                }
                                _loc_97.elt = _loc_94;
                                _loc_96 = _loc_97;
                                _loc_96.next = _loc_95.head;
                                _loc_95.head = _loc_96;
                                _loc_95.modified = true;
                                (_loc_95.length + 1);
                                _loc_94.fresh = !_loc_28;
                            }
                            else
                            {
                                if (_loc_94.up_stamp >= (stamp - 1))
                                {
                                    if (_loc_94.endGenerated == stamp)
                                    {
                                    }
                                }
                                _loc_94.fresh = param5;
                            }
                            _loc_94.up_stamp = _loc_94.stamp;
                            if (!_loc_94.fresh)
                            {
                            }
                            if ((_loc_94.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                            {
                                _loc_94.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                _loc_31 = false;
                                if (_loc_94.ws1.id > _loc_94.ws2.id)
                                {
                                    _loc_39 = _loc_94.ws2;
                                }
                                else
                                {
                                    _loc_39 = _loc_94.ws1;
                                }
                                if (_loc_94.ws1.id > _loc_94.ws2.id)
                                {
                                    _loc_40 = _loc_94.ws1;
                                }
                                else
                                {
                                    _loc_40 = _loc_94.ws2;
                                }
                                _loc_41 = mrca1;
                                while (_loc_41.head != null)
                                {
                                    
                                    _loc_42 = _loc_41.head;
                                    _loc_41.head = _loc_42.next;
                                    _loc_43 = _loc_42;
                                    _loc_43.elt = null;
                                    _loc_43.next = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_43;
                                    if (_loc_41.head == null)
                                    {
                                        _loc_41.pushmod = true;
                                    }
                                    _loc_41.modified = true;
                                    (_loc_41.length - 1);
                                }
                                _loc_41.pushmod = true;
                                _loc_41 = mrca2;
                                while (_loc_41.head != null)
                                {
                                    
                                    _loc_42 = _loc_41.head;
                                    _loc_41.head = _loc_42.next;
                                    _loc_43 = _loc_42;
                                    _loc_43.elt = null;
                                    _loc_43.next = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_43;
                                    if (_loc_41.head == null)
                                    {
                                        _loc_41.pushmod = true;
                                    }
                                    _loc_41.modified = true;
                                    (_loc_41.length - 1);
                                }
                                _loc_41.pushmod = true;
                                if (_loc_39.cbSet != null)
                                {
                                    _loc_41 = mrca1;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_39;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                if (_loc_39.body.cbSet != null)
                                {
                                    _loc_41 = mrca1;
                                    _loc_15 = _loc_39.body;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_15;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                if (_loc_40.cbSet != null)
                                {
                                    _loc_41 = mrca2;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_40;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                if (_loc_40.body.cbSet != null)
                                {
                                    _loc_41 = mrca2;
                                    _loc_15 = _loc_40.body;
                                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                    {
                                        _loc_43 = new ZNPNode_ZPP_Interactor();
                                    }
                                    else
                                    {
                                        _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                        _loc_43.next = null;
                                    }
                                    _loc_43.elt = _loc_15;
                                    _loc_42 = _loc_43;
                                    _loc_42.next = _loc_41.head;
                                    _loc_41.head = _loc_42;
                                    _loc_41.modified = true;
                                    (_loc_41.length + 1);
                                }
                                _loc_44 = _loc_39.body.compound;
                                _loc_45 = _loc_40.body.compound;
                                while (_loc_44 != _loc_45)
                                {
                                    
                                    if (_loc_44 == null)
                                    {
                                        _loc_46 = 0;
                                    }
                                    else
                                    {
                                        _loc_46 = _loc_44.depth;
                                    }
                                    if (_loc_45 == null)
                                    {
                                        _loc_47 = 0;
                                    }
                                    else
                                    {
                                        _loc_47 = _loc_45.depth;
                                    }
                                    if (_loc_46 < _loc_47)
                                    {
                                        if (_loc_45.cbSet != null)
                                        {
                                            _loc_41 = mrca2;
                                            if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                            {
                                                _loc_43 = new ZNPNode_ZPP_Interactor();
                                            }
                                            else
                                            {
                                                _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                                ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                                _loc_43.next = null;
                                            }
                                            _loc_43.elt = _loc_45;
                                            _loc_42 = _loc_43;
                                            _loc_42.next = _loc_41.head;
                                            _loc_41.head = _loc_42;
                                            _loc_41.modified = true;
                                            (_loc_41.length + 1);
                                        }
                                        _loc_45 = _loc_45.compound;
                                        continue;
                                    }
                                    if (_loc_44.cbSet != null)
                                    {
                                        _loc_41 = mrca1;
                                        if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                                        {
                                            _loc_43 = new ZNPNode_ZPP_Interactor();
                                        }
                                        else
                                        {
                                            _loc_43 = ZNPNode_ZPP_Interactor.zpp_pool;
                                            ZNPNode_ZPP_Interactor.zpp_pool = _loc_43.next;
                                            _loc_43.next = null;
                                        }
                                        _loc_43.elt = _loc_44;
                                        _loc_42 = _loc_43;
                                        _loc_42.next = _loc_41.head;
                                        _loc_41.head = _loc_42;
                                        _loc_41.modified = true;
                                        (_loc_41.length + 1);
                                    }
                                    _loc_44 = _loc_44.compound;
                                }
                                _loc_42 = mrca1.head;
                                while (_loc_42 != null)
                                {
                                    
                                    _loc_15 = _loc_42.elt;
                                    _loc_43 = mrca2.head;
                                    while (_loc_43 != null)
                                    {
                                        
                                        _loc_48 = _loc_43.elt;
                                        _loc_49 = _loc_15.cbSet;
                                        _loc_50 = _loc_48.cbSet;
                                        _loc_52 = null;
                                        if (_loc_49.cbpairs.length < _loc_50.cbpairs.length)
                                        {
                                            _loc_53 = _loc_49.cbpairs;
                                        }
                                        else
                                        {
                                            _loc_53 = _loc_50.cbpairs;
                                        }
                                        _loc_54 = _loc_53.head;
                                        while (_loc_54 != null)
                                        {
                                            
                                            _loc_55 = _loc_54.elt;
                                            if (_loc_55.a == _loc_49)
                                            {
                                            }
                                            if (_loc_55.b != _loc_50)
                                            {
                                                if (_loc_55.a == _loc_50)
                                                {
                                                }
                                            }
                                            if (_loc_55.b == _loc_49)
                                            {
                                                _loc_52 = _loc_55;
                                                break;
                                            }
                                            _loc_54 = _loc_54.next;
                                        }
                                        if (_loc_52 == null)
                                        {
                                            if (ZPP_CbSetPair.zpp_pool == null)
                                            {
                                                _loc_55 = new ZPP_CbSetPair();
                                            }
                                            else
                                            {
                                                _loc_55 = ZPP_CbSetPair.zpp_pool;
                                                ZPP_CbSetPair.zpp_pool = _loc_55.next;
                                                _loc_55.next = null;
                                            }
                                            _loc_55.zip_listeners = true;
                                            if (ZPP_CbSet.setlt(_loc_49, _loc_50))
                                            {
                                                _loc_55.a = _loc_49;
                                                _loc_55.b = _loc_50;
                                            }
                                            else
                                            {
                                                _loc_55.a = _loc_50;
                                                _loc_55.b = _loc_49;
                                            }
                                            _loc_52 = _loc_55;
                                            _loc_49.cbpairs.add(_loc_52);
                                            if (_loc_50 != _loc_49)
                                            {
                                                _loc_50.cbpairs.add(_loc_52);
                                            }
                                        }
                                        if (_loc_52.zip_listeners)
                                        {
                                            _loc_52.zip_listeners = false;
                                            _loc_52.__validate();
                                        }
                                        _loc_51 = _loc_52;
                                        if (_loc_51.listeners.head == null)
                                        {
                                            _loc_43 = _loc_43.next;
                                            continue;
                                        }
                                        _loc_56 = null;
                                        _loc_57 = null;
                                        _loc_58 = prelisteners;
                                        while (_loc_58.head != null)
                                        {
                                            
                                            _loc_59 = _loc_58.head;
                                            _loc_58.head = _loc_59.next;
                                            _loc_60 = _loc_59;
                                            _loc_60.elt = null;
                                            _loc_60.next = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                            ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_60;
                                            if (_loc_58.head == null)
                                            {
                                                _loc_58.pushmod = true;
                                            }
                                            _loc_58.modified = true;
                                            (_loc_58.length - 1);
                                        }
                                        _loc_58.pushmod = true;
                                        _loc_59 = null;
                                        _loc_46 = ZPP_Flags.id_CbEvent_PRE;
                                        _loc_52 = null;
                                        if (_loc_49.cbpairs.length < _loc_50.cbpairs.length)
                                        {
                                            _loc_53 = _loc_49.cbpairs;
                                        }
                                        else
                                        {
                                            _loc_53 = _loc_50.cbpairs;
                                        }
                                        _loc_54 = _loc_53.head;
                                        while (_loc_54 != null)
                                        {
                                            
                                            _loc_55 = _loc_54.elt;
                                            if (_loc_55.a == _loc_49)
                                            {
                                            }
                                            if (_loc_55.b != _loc_50)
                                            {
                                                if (_loc_55.a == _loc_50)
                                                {
                                                }
                                            }
                                            if (_loc_55.b == _loc_49)
                                            {
                                                _loc_52 = _loc_55;
                                                break;
                                            }
                                            _loc_54 = _loc_54.next;
                                        }
                                        if (_loc_52 == null)
                                        {
                                            if (ZPP_CbSetPair.zpp_pool == null)
                                            {
                                                _loc_55 = new ZPP_CbSetPair();
                                            }
                                            else
                                            {
                                                _loc_55 = ZPP_CbSetPair.zpp_pool;
                                                ZPP_CbSetPair.zpp_pool = _loc_55.next;
                                                _loc_55.next = null;
                                            }
                                            _loc_55.zip_listeners = true;
                                            if (ZPP_CbSet.setlt(_loc_49, _loc_50))
                                            {
                                                _loc_55.a = _loc_49;
                                                _loc_55.b = _loc_50;
                                            }
                                            else
                                            {
                                                _loc_55.a = _loc_50;
                                                _loc_55.b = _loc_49;
                                            }
                                            _loc_52 = _loc_55;
                                            _loc_49.cbpairs.add(_loc_52);
                                            if (_loc_50 != _loc_49)
                                            {
                                                _loc_50.cbpairs.add(_loc_52);
                                            }
                                        }
                                        if (_loc_52.zip_listeners)
                                        {
                                            _loc_52.zip_listeners = false;
                                            _loc_52.__validate();
                                        }
                                        _loc_51 = _loc_52;
                                        _loc_60 = _loc_51.listeners.head;
                                        while (_loc_60 != null)
                                        {
                                            
                                            _loc_61 = _loc_60.elt;
                                            if (_loc_61.event == _loc_46)
                                            {
                                                if ((_loc_61.itype & _loc_35) != 0)
                                                {
                                                    _loc_58 = _loc_6.prelisteners;
                                                    if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                                                    {
                                                        _loc_63 = new ZNPNode_ZPP_InteractionListener();
                                                    }
                                                    else
                                                    {
                                                        _loc_63 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                                        ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_63.next;
                                                        _loc_63.next = null;
                                                    }
                                                    _loc_63.elt = _loc_61;
                                                    _loc_62 = _loc_63;
                                                    if (_loc_59 == null)
                                                    {
                                                        _loc_62.next = _loc_58.head;
                                                        _loc_58.head = _loc_62;
                                                    }
                                                    else
                                                    {
                                                        _loc_62.next = _loc_59.next;
                                                        _loc_59.next = _loc_62;
                                                    }
                                                    _loc_64 = true;
                                                    _loc_58.modified = _loc_64;
                                                    _loc_58.pushmod = _loc_64;
                                                    (_loc_58.length + 1);
                                                    _loc_59 = _loc_62;
                                                    if (!_loc_31)
                                                    {
                                                    }
                                                    _loc_31 = !_loc_61.pure;
                                                }
                                            }
                                            _loc_60 = _loc_60.next;
                                        }
                                        if (prelisteners.head == null)
                                        {
                                            _loc_43 = _loc_43.next;
                                            continue;
                                        }
                                        _loc_56 = ZPP_Interactor.get(_loc_15, _loc_48);
                                        if (_loc_56 == null)
                                        {
                                            _loc_57 = ZPP_CallbackSet.get(_loc_15, _loc_48);
                                            add_callbackset(_loc_57);
                                        }
                                        if (_loc_56 != null)
                                        {
                                            if (_loc_56.SENSORstamp == stamp)
                                            {
                                            }
                                            if (param5)
                                            {
                                            }
                                        }
                                        if ((_loc_56.SENSORstate & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                        {
                                            if (_loc_57 != null)
                                            {
                                                _loc_56 = _loc_57;
                                            }
                                            if (_loc_56 != null)
                                            {
                                                _loc_60 = prelisteners.head;
                                                while (_loc_60 != null)
                                                {
                                                    
                                                    _loc_61 = _loc_60.elt;
                                                    if (_loc_61.itype == ZPP_Flags.id_InteractionType_ANY)
                                                    {
                                                        _loc_56.COLLISIONstamp = stamp;
                                                        _loc_56.SENSORstamp = stamp;
                                                        _loc_56.FLUIDstamp = stamp;
                                                    }
                                                    else
                                                    {
                                                        _loc_56.SENSORstamp = stamp;
                                                    }
                                                    _loc_60 = _loc_60.next;
                                                }
                                            }
                                            _loc_64 = _loc_94.active;
                                            _loc_94.active = true;
                                            _loc_65 = false;
                                            precb.zpp_inner.pre_arbiter = _loc_94;
                                            precb.zpp_inner.set = _loc_56;
                                            _loc_60 = prelisteners.head;
                                            while (_loc_60 != null)
                                            {
                                                
                                                _loc_61 = _loc_60.elt;
                                                precb.zpp_inner.listener = _loc_61;
                                                _loc_66 = precb.zpp_inner;
                                                _loc_67 = _loc_56.int1;
                                                _loc_68 = _loc_56.int2;
                                                _loc_69 = _loc_61.options1;
                                                _loc_70 = _loc_67.cbTypes;
                                                if (_loc_69.nonemptyintersection(_loc_70, _loc_69.includes))
                                                {
                                                }
                                                if (!_loc_69.nonemptyintersection(_loc_70, _loc_69.excludes))
                                                {
                                                    _loc_69 = _loc_61.options2;
                                                    _loc_70 = _loc_68.cbTypes;
                                                    if (_loc_69.nonemptyintersection(_loc_70, _loc_69.includes))
                                                    {
                                                    }
                                                }
                                                if (!_loc_69.nonemptyintersection(_loc_70, _loc_69.excludes))
                                                {
                                                    _loc_66.int1 = _loc_67;
                                                    _loc_66.int2 = _loc_68;
                                                }
                                                else
                                                {
                                                    _loc_66.int1 = _loc_68;
                                                    _loc_66.int2 = _loc_67;
                                                }
                                                precb.zpp_inner.pre_swapped = _loc_15 != precb.zpp_inner.int1;
                                                _loc_71 = _loc_61.handlerp(precb);
                                                if (_loc_71 != null)
                                                {
                                                    if (ZPP_Flags.PreFlag_ACCEPT == null)
                                                    {
                                                        ZPP_Flags.internal = true;
                                                        ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
                                                        ZPP_Flags.internal = false;
                                                    }
                                                    if (_loc_71 == ZPP_Flags.PreFlag_ACCEPT)
                                                    {
                                                        _loc_94.immState = ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS;
                                                    }
                                                    else
                                                    {
                                                        if (ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
                                                        {
                                                            ZPP_Flags.internal = true;
                                                            ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
                                                            ZPP_Flags.internal = false;
                                                        }
                                                        if (_loc_71 == ZPP_Flags.PreFlag_ACCEPT_ONCE)
                                                        {
                                                            _loc_94.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                                        }
                                                        else
                                                        {
                                                            if (ZPP_Flags.PreFlag_IGNORE == null)
                                                            {
                                                                ZPP_Flags.internal = true;
                                                                ZPP_Flags.PreFlag_IGNORE = new PreFlag();
                                                                ZPP_Flags.internal = false;
                                                            }
                                                            if (_loc_71 == ZPP_Flags.PreFlag_IGNORE)
                                                            {
                                                                _loc_94.immState = ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS;
                                                            }
                                                            else
                                                            {
                                                                _loc_94.immState = ZPP_Flags.id_ImmState_IGNORE;
                                                            }
                                                        }
                                                    }
                                                }
                                                _loc_60 = _loc_60.next;
                                            }
                                            _loc_94.active = _loc_64;
                                            if (_loc_56 != null)
                                            {
                                                _loc_60 = prelisteners.head;
                                                while (_loc_60 != null)
                                                {
                                                    
                                                    _loc_61 = _loc_60.elt;
                                                    if (_loc_61.itype == ZPP_Flags.id_InteractionType_ANY)
                                                    {
                                                        _loc_56.COLLISIONstate = _loc_94.immState;
                                                        _loc_56.SENSORstate = _loc_94.immState;
                                                        _loc_56.FLUIDstate = _loc_94.immState;
                                                    }
                                                    else
                                                    {
                                                        _loc_56.SENSORstate = _loc_94.immState;
                                                    }
                                                    _loc_60 = _loc_60.next;
                                                }
                                            }
                                        }
                                        else if (_loc_56 == null)
                                        {
                                            if ((_loc_94.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                            {
                                                _loc_94.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                            }
                                        }
                                        else
                                        {
                                            _loc_94.immState = _loc_56.SENSORstate;
                                        }
                                        _loc_43 = _loc_43.next;
                                    }
                                    _loc_42 = _loc_42.next;
                                }
                                if (_loc_31)
                                {
                                }
                                if ((_loc_94.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                {
                                    if (_loc_94.b1.type != ZPP_Flags.id_BodyType_STATIC)
                                    {
                                        _loc_24 = _loc_94.b1;
                                        if (!_loc_24.world)
                                        {
                                            _loc_24.component.waket = stamp + (midstep ? (0) : (1));
                                            if (_loc_24.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                            {
                                                _loc_24.kinematicDelaySleep = true;
                                            }
                                            if (_loc_24.component.sleeping)
                                            {
                                                really_wake(_loc_24, false);
                                            }
                                        }
                                    }
                                    if (_loc_94.b2.type != ZPP_Flags.id_BodyType_STATIC)
                                    {
                                        _loc_24 = _loc_94.b2;
                                        if (!_loc_24.world)
                                        {
                                            _loc_24.component.waket = stamp + (midstep ? (0) : (1));
                                            if (_loc_24.type == ZPP_Flags.id_BodyType_KINEMATIC)
                                            {
                                                _loc_24.kinematicDelaySleep = true;
                                            }
                                            if (_loc_24.component.sleeping)
                                            {
                                                really_wake(_loc_24, false);
                                            }
                                        }
                                    }
                                }
                            }
                            if (_loc_94.sleeping)
                            {
                                _loc_94.sleeping = false;
                                _loc_95 = s_arbiters;
                                if (ZNPNode_ZPP_SensorArbiter.zpp_pool == null)
                                {
                                    _loc_97 = new ZNPNode_ZPP_SensorArbiter();
                                }
                                else
                                {
                                    _loc_97 = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                                    ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc_97.next;
                                    _loc_97.next = null;
                                }
                                _loc_97.elt = _loc_94;
                                _loc_96 = _loc_97;
                                _loc_96.next = _loc_95.head;
                                _loc_95.head = _loc_96;
                                _loc_95.modified = true;
                                (_loc_95.length + 1);
                            }
                            _loc_7 = _loc_94;
                        }
                        else if (_loc_17)
                        {
                            _loc_98 = _loc_94;
                            _loc_98.next = ZPP_SensorArbiter.zpp_pool;
                            ZPP_SensorArbiter.zpp_pool = _loc_98;
                            _loc_7 = null;
                        }
                        else
                        {
                            _loc_7 = _loc_94;
                        }
                    }
                    else
                    {
                        _loc_7 = _loc_94;
                    }
                }
            }
            return _loc_7;
        }// end function

        public function listeners_subber(param1:Listener) : void
        {
            remListener(param1.zpp_inner);
            return;
        }// end function

        public function listeners_modifiable() : void
        {
            if (midstep)
            {
                throw "Error: Space::listeners cannot be set during space step()";
            }
            return;
        }// end function

        public function listeners_adder(param1:Listener) : Boolean
        {
            if (param1.zpp_inner.space != this)
            {
                if (param1.zpp_inner.space != null)
                {
                    param1.zpp_inner.space.outer.zpp_inner.wrap_listeners.remove(param1);
                }
                addListener(param1.zpp_inner);
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function iterateVel(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_5:* = null as ZPP_FluidArbiter;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZNPNode_ZPP_Constraint;
            var _loc_12:* = null as ZNPNode_ZPP_Constraint;
            var _loc_13:* = null as ZPP_Constraint;
            var _loc_14:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_15:* = false;
            var _loc_16:* = null as ZPP_ColArbiter;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_2:* = 0;
            while (_loc_2 < param1)
            {
                
                _loc_2++;
                _loc_3 = _loc_2;
                _loc_4 = f_arbiters.head;
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.elt;
                    if (_loc_5.active)
                    {
                    }
                    if ((_loc_5.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                    {
                        if (!_loc_5.nodrag)
                        {
                            _loc_6 = _loc_5.b1.angvel + _loc_5.b1.kinangvel;
                            _loc_7 = _loc_5.b2.angvel + _loc_5.b2.kinangvel;
                            _loc_8 = _loc_5.b1.velx + _loc_5.b1.kinvelx - _loc_5.r1y * _loc_6 - (_loc_5.b2.velx + _loc_5.b2.kinvelx - _loc_5.r2y * _loc_7);
                            _loc_9 = _loc_5.b1.vely + _loc_5.b1.kinvely + _loc_5.r1x * _loc_6 - (_loc_5.b2.vely + _loc_5.b2.kinvely + _loc_5.r2x * _loc_7);
                            _loc_10 = _loc_5.vMassa * _loc_8 + _loc_5.vMassb * _loc_9;
                            _loc_9 = _loc_5.vMassb * _loc_8 + _loc_5.vMassc * _loc_9;
                            _loc_8 = _loc_10;
                            _loc_10 = _loc_5.lgamma;
                            _loc_8 = _loc_8 - _loc_5.dampx * _loc_10;
                            _loc_9 = _loc_9 - _loc_5.dampy * _loc_10;
                            _loc_10 = 1;
                            _loc_5.dampx = _loc_5.dampx + _loc_8 * _loc_10;
                            _loc_5.dampy = _loc_5.dampy + _loc_9 * _loc_10;
                            _loc_10 = _loc_5.b1.imass;
                            _loc_5.b1.velx = _loc_5.b1.velx - _loc_8 * _loc_10;
                            _loc_5.b1.vely = _loc_5.b1.vely - _loc_9 * _loc_10;
                            _loc_10 = _loc_5.b2.imass;
                            _loc_5.b2.velx = _loc_5.b2.velx + _loc_8 * _loc_10;
                            _loc_5.b2.vely = _loc_5.b2.vely + _loc_9 * _loc_10;
                            _loc_5.b1.angvel = _loc_5.b1.angvel - _loc_5.b1.iinertia * (_loc_9 * _loc_5.r1x - _loc_8 * _loc_5.r1y);
                            _loc_5.b2.angvel = _loc_5.b2.angvel + _loc_5.b2.iinertia * (_loc_9 * _loc_5.r2x - _loc_8 * _loc_5.r2y);
                            _loc_10 = (_loc_6 - _loc_7) * _loc_5.wMass - _loc_5.adamp * _loc_5.agamma;
                            _loc_5.adamp = _loc_5.adamp + _loc_10;
                            _loc_5.b1.angvel = _loc_5.b1.angvel - _loc_10 * _loc_5.b1.iinertia;
                            _loc_5.b2.angvel = _loc_5.b2.angvel + _loc_10 * _loc_5.b2.iinertia;
                        }
                    }
                    _loc_4 = _loc_4.next;
                }
                _loc_11 = null;
                _loc_12 = live_constraints.head;
                while (_loc_12 != null)
                {
                    
                    _loc_13 = _loc_12.elt;
                    if (_loc_13.applyImpulseVel())
                    {
                        _loc_12 = live_constraints.erase(_loc_11);
                        _loc_13.broken();
                        constraintCbBreak(_loc_13);
                        if (_loc_13.removeOnBreak)
                        {
                            _loc_13.component.sleeping = true;
                            midstep = false;
                            if (_loc_13.compound != null)
                            {
                                _loc_13.compound.wrap_constraints.remove(_loc_13.outer);
                            }
                            else
                            {
                                wrap_constraints.remove(_loc_13.outer);
                            }
                            midstep = true;
                        }
                        else
                        {
                            _loc_13.active = false;
                        }
                        _loc_13.clearcache();
                        continue;
                    }
                    _loc_11 = _loc_12;
                    _loc_12 = _loc_12.next;
                }
                _loc_14 = c_arbiters_false.head;
                _loc_15 = true;
                if (_loc_14 == null)
                {
                    _loc_14 = c_arbiters_true.head;
                    _loc_15 = false;
                }
                while (_loc_14 != null)
                {
                    
                    _loc_16 = _loc_14.elt;
                    if (_loc_16.active)
                    {
                    }
                    if ((_loc_16.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                    {
                        _loc_18 = _loc_16.k1x + _loc_16.b2.velx - _loc_16.c1.r2y * _loc_16.b2.angvel - (_loc_16.b1.velx - _loc_16.c1.r1y * _loc_16.b1.angvel);
                        _loc_19 = _loc_16.k1y + _loc_16.b2.vely + _loc_16.c1.r2x * _loc_16.b2.angvel - (_loc_16.b1.vely + _loc_16.c1.r1x * _loc_16.b1.angvel);
                        _loc_8 = (_loc_19 * _loc_16.nx - _loc_18 * _loc_16.ny + _loc_16.surfacex) * _loc_16.c1.tMass;
                        _loc_9 = _loc_16.c1.friction * _loc_16.c1.jnAcc;
                        _loc_10 = _loc_16.c1.jtAcc;
                        _loc_17 = _loc_10 - _loc_8;
                        if (_loc_17 > _loc_9)
                        {
                            _loc_17 = _loc_9;
                        }
                        else if (_loc_17 < -_loc_9)
                        {
                            _loc_17 = -_loc_9;
                        }
                        _loc_8 = _loc_17 - _loc_10;
                        _loc_16.c1.jtAcc = _loc_17;
                        _loc_6 = (-_loc_16.ny) * _loc_8;
                        _loc_7 = _loc_16.nx * _loc_8;
                        _loc_16.b2.velx = _loc_16.b2.velx + _loc_6 * _loc_16.b2.imass;
                        _loc_16.b2.vely = _loc_16.b2.vely + _loc_7 * _loc_16.b2.imass;
                        _loc_16.b1.velx = _loc_16.b1.velx - _loc_6 * _loc_16.b1.imass;
                        _loc_16.b1.vely = _loc_16.b1.vely - _loc_7 * _loc_16.b1.imass;
                        _loc_16.b2.angvel = _loc_16.b2.angvel + _loc_16.rt1b * _loc_8 * _loc_16.b2.iinertia;
                        _loc_16.b1.angvel = _loc_16.b1.angvel - _loc_16.rt1a * _loc_8 * _loc_16.b1.iinertia;
                        if (_loc_16.hc2)
                        {
                            _loc_20 = _loc_16.k2x + _loc_16.b2.velx - _loc_16.c2.r2y * _loc_16.b2.angvel - (_loc_16.b1.velx - _loc_16.c2.r1y * _loc_16.b1.angvel);
                            _loc_21 = _loc_16.k2y + _loc_16.b2.vely + _loc_16.c2.r2x * _loc_16.b2.angvel - (_loc_16.b1.vely + _loc_16.c2.r1x * _loc_16.b1.angvel);
                            _loc_8 = (_loc_21 * _loc_16.nx - _loc_20 * _loc_16.ny + _loc_16.surfacex) * _loc_16.c2.tMass;
                            _loc_9 = _loc_16.c2.friction * _loc_16.c2.jnAcc;
                            _loc_10 = _loc_16.c2.jtAcc;
                            _loc_17 = _loc_10 - _loc_8;
                            if (_loc_17 > _loc_9)
                            {
                                _loc_17 = _loc_9;
                            }
                            else if (_loc_17 < -_loc_9)
                            {
                                _loc_17 = -_loc_9;
                            }
                            _loc_8 = _loc_17 - _loc_10;
                            _loc_16.c2.jtAcc = _loc_17;
                            _loc_6 = (-_loc_16.ny) * _loc_8;
                            _loc_7 = _loc_16.nx * _loc_8;
                            _loc_16.b2.velx = _loc_16.b2.velx + _loc_6 * _loc_16.b2.imass;
                            _loc_16.b2.vely = _loc_16.b2.vely + _loc_7 * _loc_16.b2.imass;
                            _loc_16.b1.velx = _loc_16.b1.velx - _loc_6 * _loc_16.b1.imass;
                            _loc_16.b1.vely = _loc_16.b1.vely - _loc_7 * _loc_16.b1.imass;
                            _loc_16.b2.angvel = _loc_16.b2.angvel + _loc_16.rt2b * _loc_8 * _loc_16.b2.iinertia;
                            _loc_16.b1.angvel = _loc_16.b1.angvel - _loc_16.rt2a * _loc_8 * _loc_16.b1.iinertia;
                            _loc_18 = _loc_16.k1x + _loc_16.b2.velx - _loc_16.c1.r2y * _loc_16.b2.angvel - (_loc_16.b1.velx - _loc_16.c1.r1y * _loc_16.b1.angvel);
                            _loc_19 = _loc_16.k1y + _loc_16.b2.vely + _loc_16.c1.r2x * _loc_16.b2.angvel - (_loc_16.b1.vely + _loc_16.c1.r1x * _loc_16.b1.angvel);
                            _loc_20 = _loc_16.k2x + _loc_16.b2.velx - _loc_16.c2.r2y * _loc_16.b2.angvel - (_loc_16.b1.velx - _loc_16.c2.r1y * _loc_16.b1.angvel);
                            _loc_21 = _loc_16.k2y + _loc_16.b2.vely + _loc_16.c2.r2x * _loc_16.b2.angvel - (_loc_16.b1.vely + _loc_16.c2.r1x * _loc_16.b1.angvel);
                            _loc_22 = _loc_16.c1.jnAcc;
                            _loc_23 = _loc_16.c2.jnAcc;
                            _loc_24 = _loc_18 * _loc_16.nx + _loc_19 * _loc_16.ny + _loc_16.surfacey + _loc_16.c1.bounce - (_loc_16.Ka * _loc_22 + _loc_16.Kb * _loc_23);
                            _loc_25 = _loc_20 * _loc_16.nx + _loc_21 * _loc_16.ny + _loc_16.surfacey + _loc_16.c2.bounce - (_loc_16.Kb * _loc_22 + _loc_16.Kc * _loc_23);
                            _loc_26 = -(_loc_16.kMassa * _loc_24 + _loc_16.kMassb * _loc_25);
                            _loc_27 = -(_loc_16.kMassb * _loc_24 + _loc_16.kMassc * _loc_25);
                            if (_loc_26 >= 0)
                            {
                            }
                            if (_loc_27 >= 0)
                            {
                                _loc_24 = _loc_26 - _loc_22;
                                _loc_25 = _loc_27 - _loc_23;
                                _loc_16.c1.jnAcc = _loc_26;
                                _loc_16.c2.jnAcc = _loc_27;
                            }
                            else
                            {
                                _loc_26 = (-_loc_16.c1.nMass) * _loc_24;
                                if (_loc_26 >= 0)
                                {
                                }
                                if (_loc_16.Kb * _loc_26 + _loc_25 >= 0)
                                {
                                    _loc_24 = _loc_26 - _loc_22;
                                    _loc_25 = -_loc_23;
                                    _loc_16.c1.jnAcc = _loc_26;
                                    _loc_16.c2.jnAcc = 0;
                                }
                                else
                                {
                                    _loc_27 = (-_loc_16.c2.nMass) * _loc_25;
                                    if (_loc_27 >= 0)
                                    {
                                    }
                                    if (_loc_16.Kb * _loc_27 + _loc_24 >= 0)
                                    {
                                        _loc_24 = -_loc_22;
                                        _loc_25 = _loc_27 - _loc_23;
                                        _loc_16.c1.jnAcc = 0;
                                        _loc_16.c2.jnAcc = _loc_27;
                                    }
                                    else
                                    {
                                        if (_loc_24 >= 0)
                                        {
                                        }
                                        if (_loc_25 >= 0)
                                        {
                                            _loc_24 = -_loc_22;
                                            _loc_25 = -_loc_23;
                                            _loc_28 = 0;
                                            _loc_16.c2.jnAcc = _loc_28;
                                            _loc_16.c1.jnAcc = _loc_28;
                                        }
                                        else
                                        {
                                            _loc_24 = 0;
                                            _loc_25 = 0;
                                        }
                                    }
                                }
                            }
                            _loc_8 = _loc_24 + _loc_25;
                            _loc_6 = _loc_16.nx * _loc_8;
                            _loc_7 = _loc_16.ny * _loc_8;
                            _loc_16.b2.velx = _loc_16.b2.velx + _loc_6 * _loc_16.b2.imass;
                            _loc_16.b2.vely = _loc_16.b2.vely + _loc_7 * _loc_16.b2.imass;
                            _loc_16.b1.velx = _loc_16.b1.velx - _loc_6 * _loc_16.b1.imass;
                            _loc_16.b1.vely = _loc_16.b1.vely - _loc_7 * _loc_16.b1.imass;
                            _loc_16.b2.angvel = _loc_16.b2.angvel + (_loc_16.rn1b * _loc_24 + _loc_16.rn2b * _loc_25) * _loc_16.b2.iinertia;
                            _loc_16.b1.angvel = _loc_16.b1.angvel - (_loc_16.rn1a * _loc_24 + _loc_16.rn2a * _loc_25) * _loc_16.b1.iinertia;
                        }
                        else
                        {
                            if (_loc_16.radius != 0)
                            {
                                _loc_20 = _loc_16.b2.angvel - _loc_16.b1.angvel;
                                _loc_8 = _loc_20 * _loc_16.rMass;
                                _loc_9 = _loc_16.rfric * _loc_16.c1.jnAcc;
                                _loc_10 = _loc_16.jrAcc;
                                _loc_16.jrAcc = _loc_16.jrAcc - _loc_8;
                                if (_loc_16.jrAcc > _loc_9)
                                {
                                    _loc_16.jrAcc = _loc_9;
                                }
                                else if (_loc_16.jrAcc < -_loc_9)
                                {
                                    _loc_16.jrAcc = -_loc_9;
                                }
                                _loc_8 = _loc_16.jrAcc - _loc_10;
                                _loc_16.b2.angvel = _loc_16.b2.angvel + _loc_8 * _loc_16.b2.iinertia;
                                _loc_16.b1.angvel = _loc_16.b1.angvel - _loc_8 * _loc_16.b1.iinertia;
                            }
                            _loc_18 = _loc_16.k1x + _loc_16.b2.velx - _loc_16.c1.r2y * _loc_16.b2.angvel - (_loc_16.b1.velx - _loc_16.c1.r1y * _loc_16.b1.angvel);
                            _loc_19 = _loc_16.k1y + _loc_16.b2.vely + _loc_16.c1.r2x * _loc_16.b2.angvel - (_loc_16.b1.vely + _loc_16.c1.r1x * _loc_16.b1.angvel);
                            _loc_8 = (_loc_16.c1.bounce + (_loc_16.nx * _loc_18 + _loc_16.ny * _loc_19) + _loc_16.surfacey) * _loc_16.c1.nMass;
                            _loc_10 = _loc_16.c1.jnAcc;
                            _loc_17 = _loc_10 - _loc_8;
                            if (_loc_17 < 0)
                            {
                                _loc_17 = 0;
                            }
                            _loc_8 = _loc_17 - _loc_10;
                            _loc_16.c1.jnAcc = _loc_17;
                            _loc_6 = _loc_16.nx * _loc_8;
                            _loc_7 = _loc_16.ny * _loc_8;
                            _loc_16.b2.velx = _loc_16.b2.velx + _loc_6 * _loc_16.b2.imass;
                            _loc_16.b2.vely = _loc_16.b2.vely + _loc_7 * _loc_16.b2.imass;
                            _loc_16.b1.velx = _loc_16.b1.velx - _loc_6 * _loc_16.b1.imass;
                            _loc_16.b1.vely = _loc_16.b1.vely - _loc_7 * _loc_16.b1.imass;
                            _loc_16.b2.angvel = _loc_16.b2.angvel + _loc_16.rn1b * _loc_8 * _loc_16.b2.iinertia;
                            _loc_16.b1.angvel = _loc_16.b1.angvel - _loc_16.rn1a * _loc_8 * _loc_16.b1.iinertia;
                        }
                    }
                    _loc_14 = _loc_14.next;
                    if (_loc_15)
                    {
                    }
                    if (_loc_14 == null)
                    {
                        _loc_14 = c_arbiters_true.head;
                        _loc_15 = false;
                    }
                }
            }
            return;
        }// end function

        public function iteratePos(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null as ZNPNode_ZPP_Constraint;
            var _loc_5:* = null as ZNPNode_ZPP_Constraint;
            var _loc_6:* = null as ZPP_Constraint;
            var _loc_7:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_8:* = false;
            var _loc_9:* = null as ZPP_ColArbiter;
            var _loc_10:* = null as ZPP_IContact;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = 0;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            var _loc_33:* = null as ZPP_Body;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = NaN;
            var _loc_40:* = NaN;
            var _loc_41:* = NaN;
            var _loc_42:* = NaN;
            var _loc_43:* = NaN;
            var _loc_44:* = NaN;
            var _loc_45:* = NaN;
            var _loc_46:* = NaN;
            var _loc_47:* = NaN;
            var _loc_48:* = NaN;
            var _loc_2:* = 0;
            while (_loc_2 < param1)
            {
                
                _loc_2++;
                _loc_3 = _loc_2;
                _loc_4 = null;
                _loc_5 = live_constraints.head;
                while (_loc_5 != null)
                {
                    
                    _loc_6 = _loc_5.elt;
                    if (!_loc_6.__velocity)
                    {
                    }
                    if (_loc_6.stiff)
                    {
                        if (_loc_6.applyImpulsePos())
                        {
                            _loc_5 = live_constraints.erase(_loc_4);
                            _loc_6.broken();
                            constraintCbBreak(_loc_6);
                            if (_loc_6.removeOnBreak)
                            {
                                _loc_6.component.sleeping = true;
                                midstep = false;
                                if (_loc_6.compound != null)
                                {
                                    _loc_6.compound.wrap_constraints.remove(_loc_6.outer);
                                }
                                else
                                {
                                    wrap_constraints.remove(_loc_6.outer);
                                }
                                midstep = true;
                            }
                            else
                            {
                                _loc_6.active = false;
                            }
                            _loc_6.clearcache();
                            continue;
                        }
                    }
                    _loc_4 = _loc_5;
                    _loc_5 = _loc_5.next;
                }
                _loc_7 = c_arbiters_false.head;
                _loc_8 = true;
                if (_loc_7 == null)
                {
                    _loc_7 = c_arbiters_true.head;
                    _loc_8 = false;
                }
                while (_loc_7 != null)
                {
                    
                    _loc_9 = _loc_7.elt;
                    if (_loc_9.active)
                    {
                    }
                    if ((_loc_9.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                    {
                        if (_loc_9.ptype == 2)
                        {
                            _loc_10 = _loc_9.c1;
                            _loc_11 = 0;
                            _loc_12 = 0;
                            _loc_13 = 0;
                            _loc_14 = 0;
                            _loc_13 = _loc_9.b2.axisy * _loc_10.lr2x - _loc_9.b2.axisx * _loc_10.lr2y;
                            _loc_14 = _loc_10.lr2x * _loc_9.b2.axisx + _loc_10.lr2y * _loc_9.b2.axisy;
                            _loc_15 = 1;
                            _loc_13 = _loc_13 + _loc_9.b2.posx * _loc_15;
                            _loc_14 = _loc_14 + _loc_9.b2.posy * _loc_15;
                            _loc_15 = 0;
                            _loc_16 = 0;
                            _loc_15 = _loc_9.b1.axisy * _loc_10.lr1x - _loc_9.b1.axisx * _loc_10.lr1y;
                            _loc_16 = _loc_10.lr1x * _loc_9.b1.axisx + _loc_10.lr1y * _loc_9.b1.axisy;
                            _loc_17 = 1;
                            _loc_15 = _loc_15 + _loc_9.b1.posx * _loc_17;
                            _loc_16 = _loc_16 + _loc_9.b1.posy * _loc_17;
                            _loc_17 = 0;
                            _loc_18 = 0;
                            _loc_17 = _loc_13 - _loc_15;
                            _loc_18 = _loc_14 - _loc_16;
                            _loc_20 = _loc_17 * _loc_17 + _loc_18 * _loc_18;
                            if (_loc_20 == 0)
                            {
                                _loc_19 = 0;
                            }
                            else
                            {
                                _loc_21 = 1597463007 - (0 >> 1);
                                _loc_22 = 0;
                                _loc_19 = 0 / (_loc_22 * (1.5 - 0.5 * _loc_20 * _loc_22 * _loc_22));
                            }
                            _loc_20 = _loc_9.radius - Config.collisionSlop;
                            _loc_22 = _loc_19 - _loc_20;
                            if (_loc_17 * _loc_9.nx + _loc_18 * _loc_9.ny < 0)
                            {
                                _loc_17 = -_loc_17;
                                _loc_18 = -_loc_18;
                                _loc_22 = _loc_22 - _loc_9.radius;
                            }
                            if (_loc_22 < 0)
                            {
                                if (_loc_19 < Config.epsilon)
                                {
                                    if (_loc_9.b1.smass != 0)
                                    {
                                        _loc_9.b1.posx = _loc_9.b1.posx + Config.epsilon * 10;
                                    }
                                    else
                                    {
                                        _loc_9.b2.posx = _loc_9.b2.posx + Config.epsilon * 10;
                                    }
                                }
                                else
                                {
                                    _loc_23 = 1 / _loc_19;
                                    _loc_17 = _loc_17 * _loc_23;
                                    _loc_18 = _loc_18 * _loc_23;
                                    _loc_23 = 0.5 * (_loc_15 + _loc_13);
                                    _loc_24 = 0.5 * (_loc_16 + _loc_14);
                                    _loc_25 = _loc_19 - _loc_20;
                                    _loc_15 = _loc_23 - _loc_9.b1.posx;
                                    _loc_16 = _loc_24 - _loc_9.b1.posy;
                                    _loc_13 = _loc_23 - _loc_9.b2.posx;
                                    _loc_14 = _loc_24 - _loc_9.b2.posy;
                                    _loc_26 = _loc_18 * _loc_15 - _loc_17 * _loc_16;
                                    _loc_27 = _loc_18 * _loc_13 - _loc_17 * _loc_14;
                                    _loc_28 = _loc_9.b2.smass + _loc_27 * _loc_27 * _loc_9.b2.sinertia + _loc_9.b1.smass + _loc_26 * _loc_26 * _loc_9.b1.sinertia;
                                    if (_loc_28 != 0)
                                    {
                                        _loc_29 = (-_loc_9.biasCoef) * _loc_25 / _loc_28;
                                        _loc_30 = 0;
                                        _loc_31 = 0;
                                        _loc_32 = _loc_29;
                                        _loc_30 = _loc_17 * _loc_32;
                                        _loc_31 = _loc_18 * _loc_32;
                                        _loc_32 = _loc_9.b1.imass;
                                        _loc_9.b1.posx = _loc_9.b1.posx - _loc_30 * _loc_32;
                                        _loc_9.b1.posy = _loc_9.b1.posy - _loc_31 * _loc_32;
                                        _loc_33 = _loc_9.b1;
                                        _loc_32 = (-_loc_26) * _loc_9.b1.iinertia * _loc_29;
                                        _loc_33.rot = _loc_33.rot + _loc_32;
                                        if (_loc_32 * _loc_32 > 0.0001)
                                        {
                                            _loc_33.axisx = Math.sin(_loc_33.rot);
                                            _loc_33.axisy = Math.cos(_loc_33.rot);
                                        }
                                        else
                                        {
                                            _loc_34 = _loc_32 * _loc_32;
                                            _loc_35 = 1 - 0.5 * _loc_34;
                                            _loc_36 = 1 - _loc_34 * _loc_34 / 8;
                                            _loc_37 = (_loc_35 * _loc_33.axisx + _loc_32 * _loc_33.axisy) * _loc_36;
                                            _loc_33.axisy = (_loc_35 * _loc_33.axisy - _loc_32 * _loc_33.axisx) * _loc_36;
                                            _loc_33.axisx = _loc_37;
                                        }
                                        _loc_32 = _loc_9.b2.imass;
                                        _loc_9.b2.posx = _loc_9.b2.posx + _loc_30 * _loc_32;
                                        _loc_9.b2.posy = _loc_9.b2.posy + _loc_31 * _loc_32;
                                        _loc_33 = _loc_9.b2;
                                        _loc_32 = _loc_27 * _loc_9.b2.iinertia * _loc_29;
                                        _loc_33.rot = _loc_33.rot + _loc_32;
                                        if (_loc_32 * _loc_32 > 0.0001)
                                        {
                                            _loc_33.axisx = Math.sin(_loc_33.rot);
                                            _loc_33.axisy = Math.cos(_loc_33.rot);
                                        }
                                        else
                                        {
                                            _loc_34 = _loc_32 * _loc_32;
                                            _loc_35 = 1 - 0.5 * _loc_34;
                                            _loc_36 = 1 - _loc_34 * _loc_34 / 8;
                                            _loc_37 = (_loc_35 * _loc_33.axisx + _loc_32 * _loc_33.axisy) * _loc_36;
                                            _loc_33.axisy = (_loc_35 * _loc_33.axisy - _loc_32 * _loc_33.axisx) * _loc_36;
                                            _loc_33.axisx = _loc_37;
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            _loc_11 = 0;
                            _loc_12 = 0;
                            _loc_14 = 0;
                            _loc_15 = 0;
                            _loc_16 = 0;
                            _loc_17 = 0;
                            if (_loc_9.ptype == 0)
                            {
                                _loc_11 = _loc_9.b1.axisy * _loc_9.lnormx - _loc_9.b1.axisx * _loc_9.lnormy;
                                _loc_12 = _loc_9.lnormx * _loc_9.b1.axisx + _loc_9.lnormy * _loc_9.b1.axisy;
                                _loc_13 = _loc_9.lproj + (_loc_11 * _loc_9.b1.posx + _loc_12 * _loc_9.b1.posy);
                                _loc_14 = _loc_9.b2.axisy * _loc_9.c1.lr1x - _loc_9.b2.axisx * _loc_9.c1.lr1y;
                                _loc_15 = _loc_9.c1.lr1x * _loc_9.b2.axisx + _loc_9.c1.lr1y * _loc_9.b2.axisy;
                                _loc_18 = 1;
                                _loc_14 = _loc_14 + _loc_9.b2.posx * _loc_18;
                                _loc_15 = _loc_15 + _loc_9.b2.posy * _loc_18;
                                if (_loc_9.hpc2)
                                {
                                    _loc_16 = _loc_9.b2.axisy * _loc_9.c2.lr1x - _loc_9.b2.axisx * _loc_9.c2.lr1y;
                                    _loc_17 = _loc_9.c2.lr1x * _loc_9.b2.axisx + _loc_9.c2.lr1y * _loc_9.b2.axisy;
                                    _loc_18 = 1;
                                    _loc_16 = _loc_16 + _loc_9.b2.posx * _loc_18;
                                    _loc_17 = _loc_17 + _loc_9.b2.posy * _loc_18;
                                }
                            }
                            else
                            {
                                _loc_11 = _loc_9.b2.axisy * _loc_9.lnormx - _loc_9.b2.axisx * _loc_9.lnormy;
                                _loc_12 = _loc_9.lnormx * _loc_9.b2.axisx + _loc_9.lnormy * _loc_9.b2.axisy;
                                _loc_13 = _loc_9.lproj + (_loc_11 * _loc_9.b2.posx + _loc_12 * _loc_9.b2.posy);
                                _loc_14 = _loc_9.b1.axisy * _loc_9.c1.lr1x - _loc_9.b1.axisx * _loc_9.c1.lr1y;
                                _loc_15 = _loc_9.c1.lr1x * _loc_9.b1.axisx + _loc_9.c1.lr1y * _loc_9.b1.axisy;
                                _loc_18 = 1;
                                _loc_14 = _loc_14 + _loc_9.b1.posx * _loc_18;
                                _loc_15 = _loc_15 + _loc_9.b1.posy * _loc_18;
                                if (_loc_9.hpc2)
                                {
                                    _loc_16 = _loc_9.b1.axisy * _loc_9.c2.lr1x - _loc_9.b1.axisx * _loc_9.c2.lr1y;
                                    _loc_17 = _loc_9.c2.lr1x * _loc_9.b1.axisx + _loc_9.c2.lr1y * _loc_9.b1.axisy;
                                    _loc_18 = 1;
                                    _loc_16 = _loc_16 + _loc_9.b1.posx * _loc_18;
                                    _loc_17 = _loc_17 + _loc_9.b1.posy * _loc_18;
                                }
                            }
                            _loc_18 = _loc_14 * _loc_11 + _loc_15 * _loc_12 - _loc_13 - _loc_9.radius;
                            _loc_18 = _loc_18 + Config.collisionSlop;
                            _loc_19 = 0;
                            if (_loc_9.hpc2)
                            {
                                _loc_19 = _loc_16 * _loc_11 + _loc_17 * _loc_12 - _loc_13 - _loc_9.radius;
                                _loc_19 = _loc_19 + Config.collisionSlop;
                            }
                            if (_loc_18 >= 0)
                            {
                            }
                            if (_loc_19 < 0)
                            {
                                if (_loc_9.rev)
                                {
                                    _loc_11 = -_loc_11;
                                    _loc_12 = -_loc_12;
                                }
                                _loc_20 = 0;
                                _loc_22 = 0;
                                _loc_20 = _loc_14 - _loc_9.b1.posx;
                                _loc_22 = _loc_15 - _loc_9.b1.posy;
                                _loc_23 = 0;
                                _loc_24 = 0;
                                _loc_23 = _loc_14 - _loc_9.b2.posx;
                                _loc_24 = _loc_15 - _loc_9.b2.posy;
                                _loc_25 = 0;
                                _loc_26 = 0;
                                _loc_27 = 0;
                                _loc_28 = 0;
                                if (_loc_9.hpc2)
                                {
                                    _loc_25 = _loc_16 - _loc_9.b1.posx;
                                    _loc_26 = _loc_17 - _loc_9.b1.posy;
                                    _loc_27 = _loc_16 - _loc_9.b2.posx;
                                    _loc_28 = _loc_17 - _loc_9.b2.posy;
                                    _loc_29 = _loc_12 * _loc_20 - _loc_11 * _loc_22;
                                    _loc_30 = _loc_12 * _loc_23 - _loc_11 * _loc_24;
                                    _loc_31 = _loc_12 * _loc_25 - _loc_11 * _loc_26;
                                    _loc_32 = _loc_12 * _loc_27 - _loc_11 * _loc_28;
                                    _loc_34 = _loc_9.b1.smass + _loc_9.b2.smass;
                                    _loc_9.kMassa = _loc_34 + _loc_9.b1.sinertia * _loc_29 * _loc_29 + _loc_9.b2.sinertia * _loc_30 * _loc_30;
                                    _loc_9.kMassb = _loc_34 + _loc_9.b1.sinertia * _loc_29 * _loc_31 + _loc_9.b2.sinertia * _loc_30 * _loc_32;
                                    _loc_9.kMassc = _loc_34 + _loc_9.b1.sinertia * _loc_31 * _loc_31 + _loc_9.b2.sinertia * _loc_32 * _loc_32;
                                    _loc_35 = 0;
                                    _loc_36 = 0;
                                    _loc_37 = 0;
                                    _loc_35 = _loc_9.kMassa;
                                    _loc_36 = _loc_9.kMassb;
                                    _loc_37 = _loc_9.kMassc;
                                    _loc_38 = _loc_18 * _loc_9.biasCoef;
                                    _loc_39 = _loc_19 * _loc_9.biasCoef;
                                    do
                                    {
                                        
                                        _loc_40 = 0;
                                        _loc_41 = 0;
                                        _loc_40 = _loc_38;
                                        _loc_41 = _loc_39;
                                        _loc_40 = -_loc_40;
                                        _loc_41 = -_loc_41;
                                        _loc_42 = _loc_9.kMassa * _loc_9.kMassc - _loc_9.kMassb * _loc_9.kMassb;
                                        if (_loc_42 != _loc_42)
                                        {
                                            _loc_41 = 0;
                                            _loc_40 = _loc_41;
                                        }
                                        else if (_loc_42 == 0)
                                        {
                                            if (_loc_9.kMassa != 0)
                                            {
                                                _loc_40 = _loc_40 / _loc_9.kMassa;
                                            }
                                            else
                                            {
                                                _loc_40 = 0;
                                            }
                                            if (_loc_9.kMassc != 0)
                                            {
                                                _loc_41 = _loc_41 / _loc_9.kMassc;
                                            }
                                            else
                                            {
                                                _loc_41 = 0;
                                            }
                                        }
                                        else
                                        {
                                            _loc_42 = 1 / _loc_42;
                                            _loc_43 = _loc_42 * (_loc_9.kMassc * _loc_40 - _loc_9.kMassb * _loc_41);
                                            _loc_41 = _loc_42 * (_loc_9.kMassa * _loc_41 - _loc_9.kMassb * _loc_40);
                                            _loc_40 = _loc_43;
                                        }
                                        if (_loc_40 >= 0)
                                        {
                                        }
                                        if (_loc_41 >= 0)
                                        {
                                            _loc_42 = (_loc_40 + _loc_41) * _loc_9.b1.imass;
                                            _loc_9.b1.posx = _loc_9.b1.posx - _loc_11 * _loc_42;
                                            _loc_9.b1.posy = _loc_9.b1.posy - _loc_12 * _loc_42;
                                            _loc_33 = _loc_9.b1;
                                            _loc_42 = (-_loc_9.b1.iinertia) * (_loc_29 * _loc_40 + _loc_31 * _loc_41);
                                            _loc_33.rot = _loc_33.rot + _loc_42;
                                            if (_loc_42 * _loc_42 > 0.0001)
                                            {
                                                _loc_33.axisx = Math.sin(_loc_33.rot);
                                                _loc_33.axisy = Math.cos(_loc_33.rot);
                                            }
                                            else
                                            {
                                                _loc_43 = _loc_42 * _loc_42;
                                                _loc_44 = 1 - 0.5 * _loc_43;
                                                _loc_45 = 1 - _loc_43 * _loc_43 / 8;
                                                _loc_46 = (_loc_44 * _loc_33.axisx + _loc_42 * _loc_33.axisy) * _loc_45;
                                                _loc_33.axisy = (_loc_44 * _loc_33.axisy - _loc_42 * _loc_33.axisx) * _loc_45;
                                                _loc_33.axisx = _loc_46;
                                            }
                                            _loc_42 = (_loc_40 + _loc_41) * _loc_9.b2.imass;
                                            _loc_9.b2.posx = _loc_9.b2.posx + _loc_11 * _loc_42;
                                            _loc_9.b2.posy = _loc_9.b2.posy + _loc_12 * _loc_42;
                                            _loc_33 = _loc_9.b2;
                                            _loc_42 = _loc_9.b2.iinertia * (_loc_30 * _loc_40 + _loc_32 * _loc_41);
                                            _loc_33.rot = _loc_33.rot + _loc_42;
                                            if (_loc_42 * _loc_42 > 0.0001)
                                            {
                                                _loc_33.axisx = Math.sin(_loc_33.rot);
                                                _loc_33.axisy = Math.cos(_loc_33.rot);
                                            }
                                            else
                                            {
                                                _loc_43 = _loc_42 * _loc_42;
                                                _loc_44 = 1 - 0.5 * _loc_43;
                                                _loc_45 = 1 - _loc_43 * _loc_43 / 8;
                                                _loc_46 = (_loc_44 * _loc_33.axisx + _loc_42 * _loc_33.axisy) * _loc_45;
                                                _loc_33.axisy = (_loc_44 * _loc_33.axisy - _loc_42 * _loc_33.axisx) * _loc_45;
                                                _loc_33.axisx = _loc_46;
                                            }
                                            break;
                                        }
                                        _loc_40 = (-_loc_38) / _loc_35;
                                        _loc_41 = 0;
                                        _loc_42 = _loc_36 * _loc_40 + _loc_39;
                                        if (_loc_40 >= 0)
                                        {
                                        }
                                        if (_loc_42 >= 0)
                                        {
                                            _loc_43 = (_loc_40 + _loc_41) * _loc_9.b1.imass;
                                            _loc_9.b1.posx = _loc_9.b1.posx - _loc_11 * _loc_43;
                                            _loc_9.b1.posy = _loc_9.b1.posy - _loc_12 * _loc_43;
                                            _loc_33 = _loc_9.b1;
                                            _loc_43 = (-_loc_9.b1.iinertia) * (_loc_29 * _loc_40 + _loc_31 * _loc_41);
                                            _loc_33.rot = _loc_33.rot + _loc_43;
                                            if (_loc_43 * _loc_43 > 0.0001)
                                            {
                                                _loc_33.axisx = Math.sin(_loc_33.rot);
                                                _loc_33.axisy = Math.cos(_loc_33.rot);
                                            }
                                            else
                                            {
                                                _loc_44 = _loc_43 * _loc_43;
                                                _loc_45 = 1 - 0.5 * _loc_44;
                                                _loc_46 = 1 - _loc_44 * _loc_44 / 8;
                                                _loc_47 = (_loc_45 * _loc_33.axisx + _loc_43 * _loc_33.axisy) * _loc_46;
                                                _loc_33.axisy = (_loc_45 * _loc_33.axisy - _loc_43 * _loc_33.axisx) * _loc_46;
                                                _loc_33.axisx = _loc_47;
                                            }
                                            _loc_43 = (_loc_40 + _loc_41) * _loc_9.b2.imass;
                                            _loc_9.b2.posx = _loc_9.b2.posx + _loc_11 * _loc_43;
                                            _loc_9.b2.posy = _loc_9.b2.posy + _loc_12 * _loc_43;
                                            _loc_33 = _loc_9.b2;
                                            _loc_43 = _loc_9.b2.iinertia * (_loc_30 * _loc_40 + _loc_32 * _loc_41);
                                            _loc_33.rot = _loc_33.rot + _loc_43;
                                            if (_loc_43 * _loc_43 > 0.0001)
                                            {
                                                _loc_33.axisx = Math.sin(_loc_33.rot);
                                                _loc_33.axisy = Math.cos(_loc_33.rot);
                                            }
                                            else
                                            {
                                                _loc_44 = _loc_43 * _loc_43;
                                                _loc_45 = 1 - 0.5 * _loc_44;
                                                _loc_46 = 1 - _loc_44 * _loc_44 / 8;
                                                _loc_47 = (_loc_45 * _loc_33.axisx + _loc_43 * _loc_33.axisy) * _loc_46;
                                                _loc_33.axisy = (_loc_45 * _loc_33.axisy - _loc_43 * _loc_33.axisx) * _loc_46;
                                                _loc_33.axisx = _loc_47;
                                            }
                                            break;
                                        }
                                        _loc_40 = 0;
                                        _loc_41 = (-_loc_39) / _loc_37;
                                        _loc_43 = _loc_36 * _loc_41 + _loc_38;
                                        if (_loc_41 >= 0)
                                        {
                                        }
                                        if (_loc_43 >= 0)
                                        {
                                            _loc_44 = (_loc_40 + _loc_41) * _loc_9.b1.imass;
                                            _loc_9.b1.posx = _loc_9.b1.posx - _loc_11 * _loc_44;
                                            _loc_9.b1.posy = _loc_9.b1.posy - _loc_12 * _loc_44;
                                            _loc_33 = _loc_9.b1;
                                            _loc_44 = (-_loc_9.b1.iinertia) * (_loc_29 * _loc_40 + _loc_31 * _loc_41);
                                            _loc_33.rot = _loc_33.rot + _loc_44;
                                            if (_loc_44 * _loc_44 > 0.0001)
                                            {
                                                _loc_33.axisx = Math.sin(_loc_33.rot);
                                                _loc_33.axisy = Math.cos(_loc_33.rot);
                                            }
                                            else
                                            {
                                                _loc_45 = _loc_44 * _loc_44;
                                                _loc_46 = 1 - 0.5 * _loc_45;
                                                _loc_47 = 1 - _loc_45 * _loc_45 / 8;
                                                _loc_48 = (_loc_46 * _loc_33.axisx + _loc_44 * _loc_33.axisy) * _loc_47;
                                                _loc_33.axisy = (_loc_46 * _loc_33.axisy - _loc_44 * _loc_33.axisx) * _loc_47;
                                                _loc_33.axisx = _loc_48;
                                            }
                                            _loc_44 = (_loc_40 + _loc_41) * _loc_9.b2.imass;
                                            _loc_9.b2.posx = _loc_9.b2.posx + _loc_11 * _loc_44;
                                            _loc_9.b2.posy = _loc_9.b2.posy + _loc_12 * _loc_44;
                                            _loc_33 = _loc_9.b2;
                                            _loc_44 = _loc_9.b2.iinertia * (_loc_30 * _loc_40 + _loc_32 * _loc_41);
                                            _loc_33.rot = _loc_33.rot + _loc_44;
                                            if (_loc_44 * _loc_44 > 0.0001)
                                            {
                                                _loc_33.axisx = Math.sin(_loc_33.rot);
                                                _loc_33.axisy = Math.cos(_loc_33.rot);
                                            }
                                            else
                                            {
                                                _loc_45 = _loc_44 * _loc_44;
                                                _loc_46 = 1 - 0.5 * _loc_45;
                                                _loc_47 = 1 - _loc_45 * _loc_45 / 8;
                                                _loc_48 = (_loc_46 * _loc_33.axisx + _loc_44 * _loc_33.axisy) * _loc_47;
                                                _loc_33.axisy = (_loc_46 * _loc_33.axisy - _loc_44 * _loc_33.axisx) * _loc_47;
                                                _loc_33.axisx = _loc_48;
                                            }
                                            break;
                                        }
                                    }while (false)
                                }
                                else
                                {
                                    _loc_29 = _loc_12 * _loc_20 - _loc_11 * _loc_22;
                                    _loc_30 = _loc_12 * _loc_23 - _loc_11 * _loc_24;
                                    _loc_31 = _loc_9.b2.smass + _loc_30 * _loc_30 * _loc_9.b2.sinertia + _loc_9.b1.smass + _loc_29 * _loc_29 * _loc_9.b1.sinertia;
                                    if (_loc_31 != 0)
                                    {
                                        _loc_32 = (-_loc_9.biasCoef) * _loc_18 / _loc_31;
                                        _loc_34 = 0;
                                        _loc_35 = 0;
                                        _loc_36 = _loc_32;
                                        _loc_34 = _loc_11 * _loc_36;
                                        _loc_35 = _loc_12 * _loc_36;
                                        _loc_36 = _loc_9.b1.imass;
                                        _loc_9.b1.posx = _loc_9.b1.posx - _loc_34 * _loc_36;
                                        _loc_9.b1.posy = _loc_9.b1.posy - _loc_35 * _loc_36;
                                        _loc_33 = _loc_9.b1;
                                        _loc_36 = (-_loc_29) * _loc_9.b1.iinertia * _loc_32;
                                        _loc_33.rot = _loc_33.rot + _loc_36;
                                        if (_loc_36 * _loc_36 > 0.0001)
                                        {
                                            _loc_33.axisx = Math.sin(_loc_33.rot);
                                            _loc_33.axisy = Math.cos(_loc_33.rot);
                                        }
                                        else
                                        {
                                            _loc_37 = _loc_36 * _loc_36;
                                            _loc_38 = 1 - 0.5 * _loc_37;
                                            _loc_39 = 1 - _loc_37 * _loc_37 / 8;
                                            _loc_40 = (_loc_38 * _loc_33.axisx + _loc_36 * _loc_33.axisy) * _loc_39;
                                            _loc_33.axisy = (_loc_38 * _loc_33.axisy - _loc_36 * _loc_33.axisx) * _loc_39;
                                            _loc_33.axisx = _loc_40;
                                        }
                                        _loc_36 = _loc_9.b2.imass;
                                        _loc_9.b2.posx = _loc_9.b2.posx + _loc_34 * _loc_36;
                                        _loc_9.b2.posy = _loc_9.b2.posy + _loc_35 * _loc_36;
                                        _loc_33 = _loc_9.b2;
                                        _loc_36 = _loc_30 * _loc_9.b2.iinertia * _loc_32;
                                        _loc_33.rot = _loc_33.rot + _loc_36;
                                        if (_loc_36 * _loc_36 > 0.0001)
                                        {
                                            _loc_33.axisx = Math.sin(_loc_33.rot);
                                            _loc_33.axisy = Math.cos(_loc_33.rot);
                                        }
                                        else
                                        {
                                            _loc_37 = _loc_36 * _loc_36;
                                            _loc_38 = 1 - 0.5 * _loc_37;
                                            _loc_39 = 1 - _loc_37 * _loc_37 / 8;
                                            _loc_40 = (_loc_38 * _loc_33.axisx + _loc_36 * _loc_33.axisy) * _loc_39;
                                            _loc_33.axisy = (_loc_38 * _loc_33.axisy - _loc_36 * _loc_33.axisx) * _loc_39;
                                            _loc_33.axisx = _loc_40;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    _loc_7 = _loc_7.next;
                    if (_loc_8)
                    {
                    }
                    if (_loc_7 == null)
                    {
                        _loc_7 = c_arbiters_true.head;
                        _loc_8 = false;
                    }
                }
            }
            return;
        }// end function

        public function interactionType(param1:ZPP_Shape, param2:ZPP_Shape, param3:ZPP_Body, param4:ZPP_Body) : int
        {
            var _loc_7:* = null as ZPP_Constraint;
            var _loc_8:* = null as ZPP_InteractionGroup;
            var _loc_9:* = null as ZPP_Interactor;
            var _loc_10:* = null as ZPP_InteractionGroup;
            var _loc_11:* = false;
            var _loc_12:* = null as ZPP_InteractionFilter;
            var _loc_13:* = null as ZPP_InteractionFilter;
            var _loc_5:* = false;
            var _loc_6:* = param3.constraints.head;
            while (_loc_6 != null)
            {
                
                _loc_7 = _loc_6.elt;
                if (_loc_7.ignore)
                {
                }
                if (_loc_7.pair_exists(param3.id, param4.id))
                {
                    _loc_5 = true;
                    break;
                }
                _loc_6 = _loc_6.next;
            }
            if (!_loc_5)
            {
                _loc_9 = param1;
                do
                {
                    
                    if (_loc_9.ishape != null)
                    {
                        _loc_9 = _loc_9.ishape.body;
                    }
                    else if (_loc_9.icompound != null)
                    {
                        _loc_9 = _loc_9.icompound.compound;
                    }
                    else
                    {
                        _loc_9 = _loc_9.ibody.compound;
                    }
                    if (_loc_9 != null)
                    {
                    }
                }while (_loc_9.group == null)
                if (_loc_9 == null)
                {
                    _loc_8 = null;
                }
                else
                {
                    _loc_8 = _loc_9.group;
                }
                while (_loc_9.group == null)
                {
                    if (_loc_9.ishape != null)
                    {
                        continue;
                    }
                    if (_loc_9.icompound != null)
                    {
                        continue;
                    }
                    if (_loc_9 != null)
                    {
                    }
                }
                if (_loc_9 == null)
                {
                }
                else
                {
                }
                while (_loc_10 != null)
                {
                    if (_loc_8 == _loc_10)
                    {
                        break;
                    }
                    if (_loc_8.depth < _loc_10.depth)
                    {
                        continue;
                    }
                    if (_loc_8 != null)
                    {
                    }
                }
            }
            if (!(_loc_8.depth < _loc_10.depth ? (false) : (_loc_9 = param2, // Jump to 381, // label, if (_loc_9.ishape == null) goto 338, _loc_9 = _loc_9.ishape.body, // Jump to 381, if (_loc_9.icompound == null) goto 368, _loc_9 = _loc_9.icompound.compound, // Jump to 381, _loc_9 = _loc_9.ibody.compound, if (_loc_9 == null) goto 404, if (_loc_9.group == null) goto 307, if (!(_loc_9 == null)) goto 431, _loc_10 = null, // Jump to 441, _loc_10 = _loc_9.group, _loc_10 == null ? (false) : (_loc_11 = false, // Jump to 523, // label, if (!(_loc_8 == _loc_10)) goto 485, _loc_11 = _loc_8.ignore, // Jump to 548, if (!(_loc_8.depth < _loc_10.depth)) goto 513, _loc_10 = _loc_10.group, // Jump to 523, _loc_8 = _loc_8.group, if (_loc_8 == null) goto 544, if (_loc_10 != null) goto 464, _loc_11))))
            {
                if (!param1.sensorEnabled)
                {
                }
                if (param2.sensorEnabled)
                {
                    _loc_12 = param1.filter;
                    _loc_13 = param2.filter;
                    if ((_loc_12.sensorMask & _loc_13.sensorGroup) != 0)
                    {
                    }
                }
                if ((_loc_13.sensorMask & _loc_12.sensorGroup) != 0)
                {
                    return 2;
                }
                else
                {
                    if (!param1.fluidEnabled)
                    {
                    }
                    if (param2.fluidEnabled)
                    {
                        _loc_12 = param1.filter;
                        _loc_13 = param2.filter;
                        if ((_loc_12.fluidMask & _loc_13.fluidGroup) != 0)
                        {
                        }
                    }
                    if ((_loc_13.fluidMask & _loc_12.fluidGroup) != 0)
                    {
                        if (param3.imass == 0)
                        {
                        }
                        if (param4.imass == 0)
                        {
                        }
                        if (param3.iinertia == 0)
                        {
                        }
                    }
                    if (param4.iinertia != 0)
                    {
                        return 0;
                    }
                    else
                    {
                        _loc_12 = param1.filter;
                        _loc_13 = param2.filter;
                        if ((_loc_12.collisionMask & _loc_13.collisionGroup) != 0)
                        {
                        }
                        if ((_loc_13.collisionMask & _loc_12.collisionGroup) != 0)
                        {
                            if (param3.imass == 0)
                            {
                            }
                            if (param4.imass == 0)
                            {
                            }
                            if (param3.iinertia == 0)
                            {
                            }
                        }
                        if (param4.iinertia != 0)
                        {
                            return 1;
                        }
                        else
                        {
                            return -1;
                        }
                    }
                }
            }
            else
            {
                return -1;
            }
        }// end function

        public function inlined_MRCA_chains(param1:ZPP_Shape, param2:ZPP_Shape) : void
        {
            var _loc_3:* = null as ZNPList_ZPP_Interactor;
            var _loc_4:* = null as ZNPNode_ZPP_Interactor;
            var _loc_5:* = null as ZNPNode_ZPP_Interactor;
            var _loc_6:* = null as ZPP_Interactor;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            _loc_3 = mrca1;
            while (_loc_3.head != null)
            {
                
                _loc_4 = _loc_3.head;
                _loc_3.head = _loc_4.next;
                _loc_5 = _loc_4;
                _loc_5.elt = null;
                _loc_5.next = ZNPNode_ZPP_Interactor.zpp_pool;
                ZNPNode_ZPP_Interactor.zpp_pool = _loc_5;
                if (_loc_3.head == null)
                {
                    _loc_3.pushmod = true;
                }
                _loc_3.modified = true;
                (_loc_3.length - 1);
            }
            _loc_3.pushmod = true;
            _loc_3 = mrca2;
            while (_loc_3.head != null)
            {
                
                _loc_4 = _loc_3.head;
                _loc_3.head = _loc_4.next;
                _loc_5 = _loc_4;
                _loc_5.elt = null;
                _loc_5.next = ZNPNode_ZPP_Interactor.zpp_pool;
                ZNPNode_ZPP_Interactor.zpp_pool = _loc_5;
                if (_loc_3.head == null)
                {
                    _loc_3.pushmod = true;
                }
                _loc_3.modified = true;
                (_loc_3.length - 1);
            }
            _loc_3.pushmod = true;
            if (param1.cbSet != null)
            {
                _loc_3 = mrca1;
                if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                {
                    _loc_5 = new ZNPNode_ZPP_Interactor();
                }
                else
                {
                    _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.elt = param1;
                _loc_4 = _loc_5;
                _loc_4.next = _loc_3.head;
                _loc_3.head = _loc_4;
                _loc_3.modified = true;
                (_loc_3.length + 1);
            }
            if (param1.body.cbSet != null)
            {
                _loc_3 = mrca1;
                _loc_6 = param1.body;
                if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                {
                    _loc_5 = new ZNPNode_ZPP_Interactor();
                }
                else
                {
                    _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.elt = _loc_6;
                _loc_4 = _loc_5;
                _loc_4.next = _loc_3.head;
                _loc_3.head = _loc_4;
                _loc_3.modified = true;
                (_loc_3.length + 1);
            }
            if (param2.cbSet != null)
            {
                _loc_3 = mrca2;
                if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                {
                    _loc_5 = new ZNPNode_ZPP_Interactor();
                }
                else
                {
                    _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.elt = param2;
                _loc_4 = _loc_5;
                _loc_4.next = _loc_3.head;
                _loc_3.head = _loc_4;
                _loc_3.modified = true;
                (_loc_3.length + 1);
            }
            if (param2.body.cbSet != null)
            {
                _loc_3 = mrca2;
                _loc_6 = param2.body;
                if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                {
                    _loc_5 = new ZNPNode_ZPP_Interactor();
                }
                else
                {
                    _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.elt = _loc_6;
                _loc_4 = _loc_5;
                _loc_4.next = _loc_3.head;
                _loc_3.head = _loc_4;
                _loc_3.modified = true;
                (_loc_3.length + 1);
            }
            var _loc_7:* = param1.body.compound;
            var _loc_8:* = param2.body.compound;
            while (_loc_7 != _loc_8)
            {
                
                if (_loc_7 == null)
                {
                    _loc_9 = 0;
                }
                else
                {
                    _loc_9 = _loc_7.depth;
                }
                if (_loc_8 == null)
                {
                    _loc_10 = 0;
                }
                else
                {
                    _loc_10 = _loc_8.depth;
                }
                if (_loc_9 < _loc_10)
                {
                    if (_loc_8.cbSet != null)
                    {
                        _loc_3 = mrca2;
                        if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                            _loc_5 = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                            _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                            ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                            _loc_5.next = null;
                        }
                        _loc_5.elt = _loc_8;
                        _loc_4 = _loc_5;
                        _loc_4.next = _loc_3.head;
                        _loc_3.head = _loc_4;
                        _loc_3.modified = true;
                        (_loc_3.length + 1);
                    }
                    _loc_8 = _loc_8.compound;
                    continue;
                }
                if (_loc_7.cbSet != null)
                {
                    _loc_3 = mrca1;
                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                    {
                        _loc_5 = new ZNPNode_ZPP_Interactor();
                    }
                    else
                    {
                        _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                        _loc_5.next = null;
                    }
                    _loc_5.elt = _loc_7;
                    _loc_4 = _loc_5;
                    _loc_4.next = _loc_3.head;
                    _loc_3.head = _loc_4;
                    _loc_3.modified = true;
                    (_loc_3.length + 1);
                }
                _loc_7 = _loc_7.compound;
            }
            return;
        }// end function

        public function group_ignore(param1:ZPP_Shape, param2:ZPP_Shape) : Boolean
        {
            var _loc_3:* = null as ZPP_InteractionGroup;
            var _loc_4:* = null as ZPP_Interactor;
            var _loc_5:* = null as ZPP_InteractionGroup;
            var _loc_6:* = false;
            _loc_4 = param1;
            do
            {
                
                if (_loc_4.ishape != null)
                {
                    _loc_4 = _loc_4.ishape.body;
                }
                else if (_loc_4.icompound != null)
                {
                    _loc_4 = _loc_4.icompound.compound;
                }
                else
                {
                    _loc_4 = _loc_4.ibody.compound;
                }
                if (_loc_4 != null)
                {
                }
            }while (_loc_4.group == null)
            if (_loc_4 == null)
            {
                _loc_3 = null;
            }
            else
            {
                _loc_3 = _loc_4.group;
            }
            if (_loc_3 == null)
            {
                return false;
            }
            else
            {
                _loc_4 = param2;
                do
                {
                    
                    if (_loc_4.ishape != null)
                    {
                        _loc_4 = _loc_4.ishape.body;
                    }
                    else if (_loc_4.icompound != null)
                    {
                        _loc_4 = _loc_4.icompound.compound;
                    }
                    else
                    {
                        _loc_4 = _loc_4.ibody.compound;
                    }
                    if (_loc_4 != null)
                    {
                    }
                }while (_loc_4.group == null)
                if (_loc_4 == null)
                {
                    _loc_5 = null;
                }
                else
                {
                    _loc_5 = _loc_4.group;
                }
                if (_loc_5 == null)
                {
                    return false;
                }
                else
                {
                    _loc_6 = false;
                    do
                    {
                        
                        if (_loc_3 == _loc_5)
                        {
                            _loc_6 = _loc_3.ignore;
                            break;
                        }
                        if (_loc_3.depth < _loc_5.depth)
                        {
                            _loc_5 = _loc_5.group;
                        }
                        else
                        {
                            _loc_3 = _loc_3.group;
                        }
                        if (_loc_3 != null)
                        {
                        }
                    }while (_loc_5 != null)
                    return _loc_6;
                }
            }
        }// end function

        public function gravity_validate() : void
        {
            wrap_gravity.zpp_inner.x = gravityx;
            wrap_gravity.zpp_inner.y = gravityy;
            return;
        }// end function

        public function gravity_invalidate(param1:ZPP_Vec2) : void
        {
            var _loc_3:* = null as ZNPNode_ZPP_Body;
            var _loc_4:* = null as ZPP_Body;
            var _loc_5:* = null as ZPP_Body;
            var _loc_6:* = null as ZNPNode_ZPP_Compound;
            var _loc_7:* = null as ZPP_Compound;
            var _loc_8:* = null as ZPP_Compound;
            if (midstep)
            {
                throw "Error: Space::gravity cannot be set during space step";
            }
            gravityx = param1.x;
            gravityy = param1.y;
            var _loc_2:* = new ZNPList_ZPP_Compound();
            _loc_3 = bodies.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                _loc_5 = _loc_4;
                if (!_loc_5.world)
                {
                    _loc_5.component.waket = stamp + (midstep ? (0) : (1));
                    if (_loc_5.type == ZPP_Flags.id_BodyType_KINEMATIC)
                    {
                        _loc_5.kinematicDelaySleep = true;
                    }
                    if (_loc_5.component.sleeping)
                    {
                        really_wake(_loc_5, false);
                    }
                }
                _loc_3 = _loc_3.next;
            }
            _loc_6 = compounds.head;
            while (_loc_6 != null)
            {
                
                _loc_7 = _loc_6.elt;
                _loc_2.add(_loc_7);
                _loc_6 = _loc_6.next;
            }
            while (_loc_2.head != null)
            {
                
                _loc_7 = _loc_2.pop_unsafe();
                _loc_3 = _loc_7.bodies.head;
                while (_loc_3 != null)
                {
                    
                    _loc_4 = _loc_3.elt;
                    _loc_5 = _loc_4;
                    if (!_loc_5.world)
                    {
                        _loc_5.component.waket = stamp + (midstep ? (0) : (1));
                        if (_loc_5.type == ZPP_Flags.id_BodyType_KINEMATIC)
                        {
                            _loc_5.kinematicDelaySleep = true;
                        }
                        if (_loc_5.component.sleeping)
                        {
                            really_wake(_loc_5, false);
                        }
                    }
                    _loc_3 = _loc_3.next;
                }
                _loc_6 = _loc_7.compounds.head;
                while (_loc_6 != null)
                {
                    
                    _loc_8 = _loc_6.elt;
                    _loc_2.add(_loc_8);
                    _loc_6 = _loc_6.next;
                }
            }
            return;
        }// end function

        public function getgravity() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = gravityx;
            var _loc_2:* = gravityy;
            var _loc_3:* = false;
            if (_loc_1 == _loc_1)
            {
            }
            if (_loc_2 != _loc_2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_4 = new Vec2();
            }
            else
            {
                _loc_4 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_4.zpp_pool;
                _loc_4.zpp_pool = null;
                _loc_4.zpp_disp = false;
                if (_loc_4 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_4.zpp_inner == null)
            {
                _loc_5 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_6 = new ZPP_Vec2();
                }
                else
                {
                    _loc_6 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.weak = false;
                _loc_6._immutable = _loc_5;
                _loc_6.x = _loc_1;
                _loc_6.y = _loc_2;
                _loc_4.zpp_inner = _loc_6;
                _loc_4.zpp_inner.outer = _loc_4;
            }
            else
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_1 == _loc_1)
                {
                }
                if (_loc_2 != _loc_2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_4.zpp_inner.x == _loc_1)
                {
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_4.zpp_inner.y != _loc_2)
                {
                    _loc_4.zpp_inner.x = _loc_1;
                    _loc_4.zpp_inner.y = _loc_2;
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_4.zpp_inner.weak = _loc_3;
            wrap_gravity = _loc_4;
            wrap_gravity.zpp_inner._inuse = true;
            wrap_gravity.zpp_inner._invalidate = gravity_invalidate;
            wrap_gravity.zpp_inner._validate = gravity_validate;
            return;
        }// end function

        public function freshListenerType(param1:ZPP_CbSet, param2:ZPP_CbSet) : void
        {
            var _loc_4:* = null as ZNPNode_ZPP_Interactor;
            var _loc_5:* = null as ZPP_Interactor;
            var _loc_6:* = null as ZPP_Compound;
            var _loc_7:* = null as ZNPNode_ZPP_Body;
            var _loc_8:* = null as ZPP_Body;
            var _loc_9:* = null as ZNPNode_ZPP_Compound;
            var _loc_10:* = null as ZPP_Compound;
            var _loc_11:* = null as ZPP_Shape;
            var _loc_12:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_13:* = null as ZPP_Arbiter;
            var _loc_14:* = null as ZPP_Interactor;
            var _loc_15:* = null as ZNPNode_ZPP_Interactor;
            var _loc_16:* = null as ZPP_Interactor;
            var _loc_17:* = null as ZPP_CallbackSet;
            var _loc_18:* = false;
            var _loc_19:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_20:* = null as ZPP_Arbiter;
            var _loc_21:* = null as ZNPList_ZPP_Arbiter;
            var _loc_22:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_3:* = new ZNPList_ZPP_Interactor();
            _loc_4 = param1.interactors.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                _loc_3.add(_loc_5);
                _loc_4 = _loc_4.next;
            }
            if (param1 != param2)
            {
                _loc_4 = param2.interactors.head;
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.elt;
                    _loc_3.add(_loc_5);
                    _loc_4 = _loc_4.next;
                }
            }
            while (_loc_3.head != null)
            {
                
                _loc_5 = _loc_3.pop_unsafe();
                if (_loc_5.icompound != null)
                {
                    _loc_6 = _loc_5.icompound;
                    _loc_7 = _loc_6.bodies.head;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.elt;
                        _loc_3.add(_loc_8);
                        _loc_7 = _loc_7.next;
                    }
                    _loc_9 = _loc_6.compounds.head;
                    while (_loc_9 != null)
                    {
                        
                        _loc_10 = _loc_9.elt;
                        _loc_3.add(_loc_10);
                        _loc_9 = _loc_9.next;
                    }
                    continue;
                }
                if (_loc_5.ibody != null)
                {
                    _loc_8 = _loc_5.ibody;
                }
                else
                {
                    _loc_8 = _loc_5.ishape.body;
                }
                if (_loc_5.ishape != null)
                {
                    _loc_11 = _loc_5.ishape;
                }
                else
                {
                    _loc_11 = null;
                }
                _loc_12 = _loc_8.arbiters.head;
                while (_loc_12 != null)
                {
                    
                    _loc_13 = _loc_12.elt;
                    if (!_loc_13.presentable)
                    {
                        _loc_12 = _loc_12.next;
                        continue;
                    }
                    if (_loc_11 != null)
                    {
                        if (_loc_13.ws1 != _loc_11)
                        {
                        }
                    }
                    if (_loc_13.ws2 != _loc_11)
                    {
                        _loc_12 = _loc_12.next;
                        continue;
                    }
                    MRCA_chains(_loc_13.ws1, _loc_13.ws2);
                    _loc_4 = mrca1.head;
                    while (_loc_4 != null)
                    {
                        
                        _loc_14 = _loc_4.elt;
                        if (_loc_14.cbSet != param1)
                        {
                        }
                        if (_loc_14.cbSet != param2)
                        {
                            _loc_4 = _loc_4.next;
                            continue;
                        }
                        _loc_15 = mrca2.head;
                        while (_loc_15 != null)
                        {
                            
                            _loc_16 = _loc_15.elt;
                            if (_loc_14.cbSet == param1)
                            {
                            }
                            if (_loc_16.cbSet == param2)
                            {
                                if (_loc_14.cbSet == param2)
                                {
                                }
                            }
                            if (_loc_16.cbSet != param1)
                            {
                                _loc_15 = _loc_15.next;
                                continue;
                            }
                            _loc_17 = ZPP_Interactor.get(_loc_14, _loc_16);
                            if (_loc_17 == null)
                            {
                                _loc_17 = ZPP_CallbackSet.get(_loc_14, _loc_16);
                                add_callbackset(_loc_17);
                            }
                            _loc_18 = false;
                            _loc_19 = _loc_17.arbiters.head;
                            while (_loc_19 != null)
                            {
                                
                                _loc_20 = _loc_19.elt;
                                if (_loc_20 == _loc_13)
                                {
                                    _loc_18 = true;
                                    break;
                                }
                                _loc_19 = _loc_19.next;
                            }
                            if (!_loc_18)
                            {
                                _loc_21 = _loc_17.arbiters;
                                if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                {
                                    _loc_22 = new ZNPNode_ZPP_Arbiter();
                                }
                                else
                                {
                                    _loc_22 = ZNPNode_ZPP_Arbiter.zpp_pool;
                                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc_22.next;
                                    _loc_22.next = null;
                                }
                                _loc_22.elt = _loc_13;
                                _loc_19 = _loc_22;
                                _loc_19.next = _loc_21.head;
                                _loc_21.head = _loc_19;
                                _loc_21.modified = true;
                                (_loc_21.length + 1);
                            }
                            else
                            {
                            }
                            if (false)
                            {
                                (_loc_13.present + 1);
                            }
                            _loc_15 = _loc_15.next;
                        }
                        _loc_4 = _loc_4.next;
                    }
                    _loc_12 = _loc_12.next;
                }
            }
            return;
        }// end function

        public function freshInteractorType(param1:ZPP_Interactor, param2:ZPP_Interactor = undefined) : void
        {
            var _loc_3:* = null as ZPP_Compound;
            var _loc_4:* = null as ZNPNode_ZPP_Body;
            var _loc_5:* = null as ZPP_Body;
            var _loc_6:* = null as ZNPNode_ZPP_Compound;
            var _loc_7:* = null as ZPP_Compound;
            var _loc_8:* = null as ZPP_Shape;
            var _loc_9:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_10:* = null as ZPP_Arbiter;
            var _loc_11:* = null as ZNPNode_ZPP_Interactor;
            var _loc_12:* = null as ZPP_Interactor;
            var _loc_13:* = null as ZNPNode_ZPP_Interactor;
            var _loc_14:* = null as ZPP_Interactor;
            var _loc_15:* = null as ZPP_CbSet;
            var _loc_16:* = null as ZPP_CbSet;
            var _loc_17:* = null as ZPP_CbSetPair;
            var _loc_18:* = null as ZPP_CbSetPair;
            var _loc_19:* = null as ZNPList_ZPP_CbSetPair;
            var _loc_20:* = null as ZNPNode_ZPP_CbSetPair;
            var _loc_21:* = null as ZPP_CbSetPair;
            var _loc_22:* = null as ZPP_CallbackSet;
            var _loc_23:* = false;
            var _loc_24:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_25:* = null as ZPP_Arbiter;
            var _loc_26:* = null as ZNPList_ZPP_Arbiter;
            var _loc_27:* = null as ZNPNode_ZPP_Arbiter;
            if (param2 == null)
            {
                param2 = param1;
            }
            if (param1.icompound != null)
            {
                _loc_3 = param1.icompound;
                _loc_4 = _loc_3.bodies.head;
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.elt;
                    freshInteractorType(_loc_5, param2);
                    _loc_4 = _loc_4.next;
                }
                _loc_6 = _loc_3.compounds.head;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6.elt;
                    freshInteractorType(_loc_7, param2);
                    _loc_6 = _loc_6.next;
                }
            }
            else
            {
                if (param1.ibody != null)
                {
                    _loc_5 = param1.ibody;
                }
                else
                {
                    _loc_5 = param1.ishape.body;
                }
                if (param1.ishape != null)
                {
                    _loc_8 = param1.ishape;
                }
                else
                {
                    _loc_8 = null;
                }
                _loc_9 = _loc_5.arbiters.head;
                while (_loc_9 != null)
                {
                    
                    _loc_10 = _loc_9.elt;
                    if (!_loc_10.presentable)
                    {
                        _loc_9 = _loc_9.next;
                        continue;
                    }
                    if (_loc_8 != null)
                    {
                        if (_loc_10.ws1 != _loc_8)
                        {
                        }
                    }
                    if (_loc_10.ws2 != _loc_8)
                    {
                        _loc_9 = _loc_9.next;
                        continue;
                    }
                    MRCA_chains(_loc_10.ws1, _loc_10.ws2);
                    _loc_11 = mrca1.head;
                    while (_loc_11 != null)
                    {
                        
                        _loc_12 = _loc_11.elt;
                        _loc_13 = mrca2.head;
                        while (_loc_13 != null)
                        {
                            
                            _loc_14 = _loc_13.elt;
                            if (_loc_12 != param2)
                            {
                            }
                            if (_loc_14 != param2)
                            {
                                _loc_13 = _loc_13.next;
                                continue;
                            }
                            _loc_15 = _loc_12.cbSet;
                            _loc_16 = _loc_14.cbSet;
                            _loc_15.validate();
                            _loc_16.validate();
                            _loc_18 = null;
                            if (_loc_15.cbpairs.length < _loc_16.cbpairs.length)
                            {
                                _loc_19 = _loc_15.cbpairs;
                            }
                            else
                            {
                                _loc_19 = _loc_16.cbpairs;
                            }
                            _loc_20 = _loc_19.head;
                            while (_loc_20 != null)
                            {
                                
                                _loc_21 = _loc_20.elt;
                                if (_loc_21.a == _loc_15)
                                {
                                }
                                if (_loc_21.b != _loc_16)
                                {
                                    if (_loc_21.a == _loc_16)
                                    {
                                    }
                                }
                                if (_loc_21.b == _loc_15)
                                {
                                    _loc_18 = _loc_21;
                                    break;
                                }
                                _loc_20 = _loc_20.next;
                            }
                            if (_loc_18 == null)
                            {
                                if (ZPP_CbSetPair.zpp_pool == null)
                                {
                                    _loc_21 = new ZPP_CbSetPair();
                                }
                                else
                                {
                                    _loc_21 = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc_21.next;
                                    _loc_21.next = null;
                                }
                                _loc_21.zip_listeners = true;
                                if (ZPP_CbSet.setlt(_loc_15, _loc_16))
                                {
                                    _loc_21.a = _loc_15;
                                    _loc_21.b = _loc_16;
                                }
                                else
                                {
                                    _loc_21.a = _loc_16;
                                    _loc_21.b = _loc_15;
                                }
                                _loc_18 = _loc_21;
                                _loc_15.cbpairs.add(_loc_18);
                                if (_loc_16 != _loc_15)
                                {
                                    _loc_16.cbpairs.add(_loc_18);
                                }
                            }
                            if (_loc_18.zip_listeners)
                            {
                                _loc_18.zip_listeners = false;
                                _loc_18.__validate();
                            }
                            _loc_17 = _loc_18;
                            if (_loc_17.listeners.head != null)
                            {
                                _loc_22 = ZPP_Interactor.get(_loc_12, _loc_14);
                                if (_loc_22 == null)
                                {
                                    _loc_22 = ZPP_CallbackSet.get(_loc_12, _loc_14);
                                    add_callbackset(_loc_22);
                                }
                                _loc_23 = false;
                                _loc_24 = _loc_22.arbiters.head;
                                while (_loc_24 != null)
                                {
                                    
                                    _loc_25 = _loc_24.elt;
                                    if (_loc_25 == _loc_10)
                                    {
                                        _loc_23 = true;
                                        break;
                                    }
                                    _loc_24 = _loc_24.next;
                                }
                                if (!_loc_23)
                                {
                                    _loc_26 = _loc_22.arbiters;
                                    if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                    {
                                        _loc_27 = new ZNPNode_ZPP_Arbiter();
                                    }
                                    else
                                    {
                                        _loc_27 = ZNPNode_ZPP_Arbiter.zpp_pool;
                                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc_27.next;
                                        _loc_27.next = null;
                                    }
                                    _loc_27.elt = _loc_10;
                                    _loc_24 = _loc_27;
                                    _loc_24.next = _loc_26.head;
                                    _loc_26.head = _loc_24;
                                    _loc_26.modified = true;
                                    (_loc_26.length + 1);
                                }
                                else
                                {
                                }
                                if (false)
                                {
                                    (_loc_10.present + 1);
                                }
                            }
                            _loc_13 = _loc_13.next;
                        }
                        _loc_11 = _loc_11.next;
                    }
                    _loc_9 = _loc_9.next;
                }
            }
            return;
        }// end function

        public function doForests(param1:Number) : void
        {
            var _loc_3:* = null as ZPP_ColArbiter;
            var _loc_4:* = null as ZPP_Component;
            var _loc_5:* = null as ZPP_Component;
            var _loc_6:* = null as ZPP_Component;
            var _loc_7:* = null as ZPP_Component;
            var _loc_8:* = null as ZPP_Component;
            var _loc_10:* = null as ZPP_FluidArbiter;
            var _loc_11:* = null as ZNPNode_ZPP_Constraint;
            var _loc_12:* = null as ZPP_Constraint;
            var _loc_13:* = null as ZPP_Body;
            var _loc_14:* = null as ZNPList_ZPP_Body;
            var _loc_15:* = null as ZPP_Body;
            var _loc_16:* = null as ZPP_Island;
            var _loc_17:* = null as ZPP_Island;
            var _loc_18:* = null as ZPP_Island;
            var _loc_19:* = null as ZNPList_ZPP_Component;
            var _loc_20:* = null as ZNPNode_ZPP_Component;
            var _loc_21:* = null as ZNPNode_ZPP_Component;
            var _loc_22:* = false;
            var _loc_23:* = null as ZNPList_ZPP_Constraint;
            var _loc_24:* = null as ZPP_Constraint;
            var _loc_25:* = null as ZNPNode_ZPP_Shape;
            var _loc_26:* = null as ZPP_Shape;
            var _loc_27:* = null as ZNPNode_ZPP_Body;
            var _loc_28:* = null as ZNPNode_ZPP_Body;
            var _loc_29:* = null as ZNPNode_ZPP_Constraint;
            var _loc_2:* = c_arbiters_false.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                if (!_loc_3.cleared)
                {
                }
                if (_loc_3.up_stamp == stamp)
                {
                }
                if ((_loc_3.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                {
                    if (_loc_3.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                    {
                    }
                    if (_loc_3.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
                    {
                        if (_loc_3.b1.component == _loc_3.b1.component.parent)
                        {
                            _loc_4 = _loc_3.b1.component;
                        }
                        else
                        {
                            _loc_5 = _loc_3.b1.component;
                            _loc_6 = null;
                            while (_loc_5 != _loc_5.parent)
                            {
                                
                                _loc_7 = _loc_5.parent;
                                _loc_5.parent = _loc_6;
                                _loc_6 = _loc_5;
                                _loc_5 = _loc_7;
                            }
                            while (_loc_6 != null)
                            {
                                
                                _loc_7 = _loc_6.parent;
                                _loc_6.parent = _loc_5;
                                _loc_6 = _loc_7;
                            }
                            _loc_4 = _loc_5;
                        }
                        if (_loc_3.b2.component == _loc_3.b2.component.parent)
                        {
                            _loc_5 = _loc_3.b2.component;
                        }
                        else
                        {
                            _loc_6 = _loc_3.b2.component;
                            _loc_7 = null;
                            while (_loc_6 != _loc_6.parent)
                            {
                                
                                _loc_8 = _loc_6.parent;
                                _loc_6.parent = _loc_7;
                                _loc_7 = _loc_6;
                                _loc_6 = _loc_8;
                            }
                            while (_loc_7 != null)
                            {
                                
                                _loc_8 = _loc_7.parent;
                                _loc_7.parent = _loc_6;
                                _loc_7 = _loc_8;
                            }
                            _loc_5 = _loc_6;
                        }
                        if (_loc_4 != _loc_5)
                        {
                            if (_loc_4.rank < _loc_5.rank)
                            {
                                _loc_4.parent = _loc_5;
                            }
                            else if (_loc_4.rank > _loc_5.rank)
                            {
                                _loc_5.parent = _loc_4;
                            }
                            else
                            {
                                _loc_5.parent = _loc_4;
                                (_loc_4.rank + 1);
                            }
                        }
                    }
                }
                _loc_2 = _loc_2.next;
            }
            var _loc_9:* = f_arbiters.head;
            while (_loc_9 != null)
            {
                
                _loc_10 = _loc_9.elt;
                if (!_loc_10.cleared)
                {
                }
                if (_loc_10.up_stamp == stamp)
                {
                }
                if ((_loc_10.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                {
                    if (_loc_10.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                    {
                    }
                    if (_loc_10.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
                    {
                        if (_loc_10.b1.component == _loc_10.b1.component.parent)
                        {
                            _loc_4 = _loc_10.b1.component;
                        }
                        else
                        {
                            _loc_5 = _loc_10.b1.component;
                            _loc_6 = null;
                            while (_loc_5 != _loc_5.parent)
                            {
                                
                                _loc_7 = _loc_5.parent;
                                _loc_5.parent = _loc_6;
                                _loc_6 = _loc_5;
                                _loc_5 = _loc_7;
                            }
                            while (_loc_6 != null)
                            {
                                
                                _loc_7 = _loc_6.parent;
                                _loc_6.parent = _loc_5;
                                _loc_6 = _loc_7;
                            }
                            _loc_4 = _loc_5;
                        }
                        if (_loc_10.b2.component == _loc_10.b2.component.parent)
                        {
                            _loc_5 = _loc_10.b2.component;
                        }
                        else
                        {
                            _loc_6 = _loc_10.b2.component;
                            _loc_7 = null;
                            while (_loc_6 != _loc_6.parent)
                            {
                                
                                _loc_8 = _loc_6.parent;
                                _loc_6.parent = _loc_7;
                                _loc_7 = _loc_6;
                                _loc_6 = _loc_8;
                            }
                            while (_loc_7 != null)
                            {
                                
                                _loc_8 = _loc_7.parent;
                                _loc_7.parent = _loc_6;
                                _loc_7 = _loc_8;
                            }
                            _loc_5 = _loc_6;
                        }
                        if (_loc_4 != _loc_5)
                        {
                            if (_loc_4.rank < _loc_5.rank)
                            {
                                _loc_4.parent = _loc_5;
                            }
                            else if (_loc_4.rank > _loc_5.rank)
                            {
                                _loc_5.parent = _loc_4;
                            }
                            else
                            {
                                _loc_5.parent = _loc_4;
                                (_loc_4.rank + 1);
                            }
                        }
                    }
                }
                _loc_9 = _loc_9.next;
            }
            _loc_11 = live_constraints.head;
            while (_loc_11 != null)
            {
                
                _loc_12 = _loc_11.elt;
                _loc_12.forest();
                _loc_11 = _loc_11.next;
            }
            while (live.head != null)
            {
                
                _loc_14 = live;
                _loc_15 = _loc_14.head.elt;
                _loc_14.pop();
                _loc_13 = _loc_15;
                _loc_4 = _loc_13.component;
                if (_loc_4 == _loc_4.parent)
                {
                    _loc_5 = _loc_4;
                }
                else
                {
                    _loc_6 = _loc_4;
                    _loc_7 = null;
                    while (_loc_6 != _loc_6.parent)
                    {
                        
                        _loc_8 = _loc_6.parent;
                        _loc_6.parent = _loc_7;
                        _loc_7 = _loc_6;
                        _loc_6 = _loc_8;
                    }
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.parent;
                        _loc_7.parent = _loc_6;
                        _loc_7 = _loc_8;
                    }
                    _loc_5 = _loc_6;
                }
                if (_loc_5.island == null)
                {
                    if (ZPP_Island.zpp_pool == null)
                    {
                        _loc_5.island = new ZPP_Island();
                    }
                    else
                    {
                        _loc_5.island = ZPP_Island.zpp_pool;
                        ZPP_Island.zpp_pool = _loc_5.island.next;
                        _loc_5.island.next = null;
                    }
                    _loc_5.island.waket = 0;
                    _loc_16 = islands;
                    _loc_17 = _loc_5.island;
                    _loc_17._inuse = true;
                    _loc_18 = _loc_17;
                    _loc_18.next = _loc_16.next;
                    _loc_16.next = _loc_18;
                    _loc_16.modified = true;
                    (_loc_16.length + 1);
                    _loc_5.island.sleep = true;
                }
                _loc_4.island = _loc_5.island;
                _loc_19 = _loc_4.island.comps;
                if (ZNPNode_ZPP_Component.zpp_pool == null)
                {
                    _loc_21 = new ZNPNode_ZPP_Component();
                }
                else
                {
                    _loc_21 = ZNPNode_ZPP_Component.zpp_pool;
                    ZNPNode_ZPP_Component.zpp_pool = _loc_21.next;
                    _loc_21.next = null;
                }
                _loc_21.elt = _loc_4;
                _loc_20 = _loc_21;
                _loc_20.next = _loc_19.head;
                _loc_19.head = _loc_20;
                _loc_19.modified = true;
                (_loc_19.length + 1);
                _loc_22 = _loc_13.atRest(param1);
                if (_loc_4.island.sleep)
                {
                }
                _loc_4.island.sleep = _loc_22;
                if (_loc_4.waket > _loc_4.island.waket)
                {
                    _loc_4.island.waket = _loc_4.waket;
                }
            }
            while (live_constraints.head != null)
            {
                
                _loc_23 = live_constraints;
                _loc_24 = _loc_23.head.elt;
                _loc_23.pop();
                _loc_12 = _loc_24;
                _loc_4 = _loc_12.component;
                if (_loc_4 == _loc_4.parent)
                {
                    _loc_5 = _loc_4;
                }
                else
                {
                    _loc_6 = _loc_4;
                    _loc_7 = null;
                    while (_loc_6 != _loc_6.parent)
                    {
                        
                        _loc_8 = _loc_6.parent;
                        _loc_6.parent = _loc_7;
                        _loc_7 = _loc_6;
                        _loc_6 = _loc_8;
                    }
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7.parent;
                        _loc_7.parent = _loc_6;
                        _loc_7 = _loc_8;
                    }
                    _loc_5 = _loc_6;
                }
                _loc_4.island = _loc_5.island;
                _loc_19 = _loc_4.island.comps;
                if (ZNPNode_ZPP_Component.zpp_pool == null)
                {
                    _loc_21 = new ZNPNode_ZPP_Component();
                }
                else
                {
                    _loc_21 = ZNPNode_ZPP_Component.zpp_pool;
                    ZNPNode_ZPP_Component.zpp_pool = _loc_21.next;
                    _loc_21.next = null;
                }
                _loc_21.elt = _loc_4;
                _loc_20 = _loc_21;
                _loc_20.next = _loc_19.head;
                _loc_19.head = _loc_20;
                _loc_19.modified = true;
                (_loc_19.length + 1);
                if (_loc_4.waket > _loc_4.island.waket)
                {
                    _loc_4.island.waket = _loc_4.waket;
                }
            }
            while (islands.next != null)
            {
                
                _loc_17 = islands;
                _loc_18 = _loc_17.next;
                _loc_17.pop();
                _loc_16 = _loc_18;
                if (_loc_16.sleep)
                {
                    _loc_20 = _loc_16.comps.head;
                    while (_loc_20 != null)
                    {
                        
                        _loc_4 = _loc_20.elt;
                        if (_loc_4.isBody)
                        {
                            _loc_13 = _loc_4.body;
                            _loc_13.velx = 0;
                            _loc_13.vely = 0;
                            _loc_13.angvel = 0;
                            _loc_4.sleeping = true;
                            _loc_25 = _loc_13.shapes.head;
                            while (_loc_25 != null)
                            {
                                
                                _loc_26 = _loc_25.elt;
                                bphase.sync(_loc_26);
                                _loc_25 = _loc_25.next;
                            }
                            bodyCbSleep(_loc_13);
                        }
                        else
                        {
                            _loc_12 = _loc_4.constraint;
                            constraintCbSleep(_loc_12);
                            _loc_4.sleeping = true;
                        }
                        _loc_20 = _loc_20.next;
                    }
                    continue;
                }
                while (_loc_16.comps.head != null)
                {
                    
                    _loc_19 = _loc_16.comps;
                    _loc_5 = _loc_19.head.elt;
                    _loc_19.pop();
                    _loc_4 = _loc_5;
                    _loc_4.waket = _loc_16.waket;
                    if (_loc_4.isBody)
                    {
                        _loc_14 = live;
                        _loc_13 = _loc_4.body;
                        if (ZNPNode_ZPP_Body.zpp_pool == null)
                        {
                            _loc_28 = new ZNPNode_ZPP_Body();
                        }
                        else
                        {
                            _loc_28 = ZNPNode_ZPP_Body.zpp_pool;
                            ZNPNode_ZPP_Body.zpp_pool = _loc_28.next;
                            _loc_28.next = null;
                        }
                        _loc_28.elt = _loc_13;
                        _loc_27 = _loc_28;
                        _loc_27.next = _loc_14.head;
                        _loc_14.head = _loc_27;
                        _loc_14.modified = true;
                        (_loc_14.length + 1);
                    }
                    else
                    {
                        _loc_23 = live_constraints;
                        _loc_12 = _loc_4.constraint;
                        if (ZNPNode_ZPP_Constraint.zpp_pool == null)
                        {
                            _loc_29 = new ZNPNode_ZPP_Constraint();
                        }
                        else
                        {
                            _loc_29 = ZNPNode_ZPP_Constraint.zpp_pool;
                            ZNPNode_ZPP_Constraint.zpp_pool = _loc_29.next;
                            _loc_29.next = null;
                        }
                        _loc_29.elt = _loc_12;
                        _loc_11 = _loc_29;
                        _loc_11.next = _loc_23.head;
                        _loc_23.head = _loc_11;
                        _loc_23.modified = true;
                        (_loc_23.length + 1);
                    }
                    _loc_4.sleeping = false;
                    _loc_4.island = null;
                    _loc_4.parent = _loc_4;
                    _loc_4.rank = 0;
                }
                _loc_17 = _loc_16;
                _loc_17.next = ZPP_Island.zpp_pool;
                ZPP_Island.zpp_pool = _loc_17;
            }
            return;
        }// end function

        public function convexMultiCast(param1:ZPP_Shape, param2:Number, param3:InteractionFilter, param4:Boolean, param5:ConvexResultList) : ConvexResultList
        {
            var _loc_6:* = null as ZPP_ToiEvent;
            var _loc_7:* = null as ZPP_Shape;
            var _loc_8:* = null as ZPP_Circle;
            var _loc_9:* = null as ZPP_Polygon;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_13:* = null as ZPP_Vec2;
            var _loc_14:* = null as ZPP_Vec2;
            var _loc_15:* = NaN;
            var _loc_16:* = null as ZPP_Vec2;
            var _loc_17:* = null as ZPP_Body;
            var _loc_18:* = null as ZNPNode_ZPP_Edge;
            var _loc_19:* = null as ZPP_Edge;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = null as ZPP_AABB;
            var _loc_28:* = null as ShapeList;
            var _loc_30:* = null as Vec2;
            var _loc_31:* = null as ConvexResultList;
            var _loc_33:* = null as Shape;
            var _loc_34:* = 0;
            var _loc_35:* = null as ZPP_Body;
            var _loc_36:* = NaN;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = null as ConvexResult;
            var _loc_40:* = false;
            var _loc_41:* = false;
            var _loc_42:* = null as ZNPNode_ConvexResult;
            var _loc_43:* = null as ZNPNode_ConvexResult;
            var _loc_44:* = null as ConvexResult;
            var _loc_45:* = null as ZNPList_ConvexResult;
            var _loc_46:* = null as ZNPNode_ConvexResult;
            if (ZPP_ToiEvent.zpp_pool == null)
            {
                _loc_6 = new ZPP_ToiEvent();
            }
            else
            {
                _loc_6 = ZPP_ToiEvent.zpp_pool;
                ZPP_ToiEvent.zpp_pool = _loc_6.next;
                _loc_6.next = null;
            }
            _loc_6.failed = false;
            _loc_7 = null;
            _loc_6.s2 = _loc_7;
            _loc_6.s1 = _loc_7;
            _loc_6.arbiter = null;
            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                _loc_8 = param1.circle;
                if (_loc_8.zip_worldCOM)
                {
                    if (_loc_8.body != null)
                    {
                        _loc_8.zip_worldCOM = false;
                        if (_loc_8.zip_localCOM)
                        {
                            _loc_8.zip_localCOM = false;
                            if (_loc_8.type == ZPP_Flags.id_ShapeType_POLYGON)
                            {
                                _loc_9 = _loc_8.polygon;
                                if (_loc_9.lverts.next == null)
                                {
                                    throw "Error: An empty polygon has no meaningful localCOM";
                                }
                                if (_loc_9.lverts.next.next == null)
                                {
                                    _loc_9.localCOMx = _loc_9.lverts.next.x;
                                    _loc_9.localCOMy = _loc_9.lverts.next.y;
                                }
                                else if (_loc_9.lverts.next.next.next == null)
                                {
                                    _loc_9.localCOMx = _loc_9.lverts.next.x;
                                    _loc_9.localCOMy = _loc_9.lverts.next.y;
                                    _loc_10 = 1;
                                    _loc_9.localCOMx = _loc_9.localCOMx + _loc_9.lverts.next.next.x * _loc_10;
                                    _loc_9.localCOMy = _loc_9.localCOMy + _loc_9.lverts.next.next.y * _loc_10;
                                    _loc_10 = 0.5;
                                    _loc_9.localCOMx = _loc_9.localCOMx * _loc_10;
                                    _loc_9.localCOMy = _loc_9.localCOMy * _loc_10;
                                }
                                else
                                {
                                    _loc_9.localCOMx = 0;
                                    _loc_9.localCOMy = 0;
                                    _loc_10 = 0;
                                    _loc_11 = _loc_9.lverts.next;
                                    _loc_12 = _loc_11;
                                    _loc_11 = _loc_11.next;
                                    _loc_13 = _loc_11;
                                    _loc_11 = _loc_11.next;
                                    while (_loc_11 != null)
                                    {
                                        
                                        _loc_14 = _loc_11;
                                        _loc_10 = _loc_10 + _loc_13.x * (_loc_14.y - _loc_12.y);
                                        _loc_15 = _loc_14.y * _loc_13.x - _loc_14.x * _loc_13.y;
                                        _loc_9.localCOMx = _loc_9.localCOMx + (_loc_13.x + _loc_14.x) * _loc_15;
                                        _loc_9.localCOMy = _loc_9.localCOMy + (_loc_13.y + _loc_14.y) * _loc_15;
                                        _loc_12 = _loc_13;
                                        _loc_13 = _loc_14;
                                        _loc_11 = _loc_11.next;
                                    }
                                    _loc_11 = _loc_9.lverts.next;
                                    _loc_14 = _loc_11;
                                    _loc_10 = _loc_10 + _loc_13.x * (_loc_14.y - _loc_12.y);
                                    _loc_15 = _loc_14.y * _loc_13.x - _loc_14.x * _loc_13.y;
                                    _loc_9.localCOMx = _loc_9.localCOMx + (_loc_13.x + _loc_14.x) * _loc_15;
                                    _loc_9.localCOMy = _loc_9.localCOMy + (_loc_13.y + _loc_14.y) * _loc_15;
                                    _loc_12 = _loc_13;
                                    _loc_13 = _loc_14;
                                    _loc_11 = _loc_11.next;
                                    _loc_16 = _loc_11;
                                    _loc_10 = _loc_10 + _loc_13.x * (_loc_16.y - _loc_12.y);
                                    _loc_15 = _loc_16.y * _loc_13.x - _loc_16.x * _loc_13.y;
                                    _loc_9.localCOMx = _loc_9.localCOMx + (_loc_13.x + _loc_16.x) * _loc_15;
                                    _loc_9.localCOMy = _loc_9.localCOMy + (_loc_13.y + _loc_16.y) * _loc_15;
                                    _loc_10 = 1 / (3 * _loc_10);
                                    _loc_15 = _loc_10;
                                    _loc_9.localCOMx = _loc_9.localCOMx * _loc_15;
                                    _loc_9.localCOMy = _loc_9.localCOMy * _loc_15;
                                }
                            }
                            if (_loc_8.wrap_localCOM != null)
                            {
                                _loc_8.wrap_localCOM.zpp_inner.x = _loc_8.localCOMx;
                                _loc_8.wrap_localCOM.zpp_inner.y = _loc_8.localCOMy;
                            }
                        }
                        _loc_17 = _loc_8.body;
                        if (_loc_17.zip_axis)
                        {
                            _loc_17.zip_axis = false;
                            _loc_17.axisx = Math.sin(_loc_17.rot);
                            _loc_17.axisy = Math.cos(_loc_17.rot);
                        }
                        _loc_8.worldCOMx = _loc_8.body.posx + (_loc_8.body.axisy * _loc_8.localCOMx - _loc_8.body.axisx * _loc_8.localCOMy);
                        _loc_8.worldCOMy = _loc_8.body.posy + (_loc_8.localCOMx * _loc_8.body.axisx + _loc_8.localCOMy * _loc_8.body.axisy);
                    }
                }
            }
            else
            {
                _loc_9 = param1.polygon;
                if (_loc_9.zip_gaxi)
                {
                    if (_loc_9.body != null)
                    {
                        _loc_9.zip_gaxi = false;
                        _loc_9.validate_laxi();
                        _loc_17 = _loc_9.body;
                        if (_loc_17.zip_axis)
                        {
                            _loc_17.zip_axis = false;
                            _loc_17.axisx = Math.sin(_loc_17.rot);
                            _loc_17.axisy = Math.cos(_loc_17.rot);
                        }
                        if (_loc_9.zip_gverts)
                        {
                            if (_loc_9.body != null)
                            {
                                _loc_9.zip_gverts = false;
                                _loc_9.validate_lverts();
                                _loc_17 = _loc_9.body;
                                if (_loc_17.zip_axis)
                                {
                                    _loc_17.zip_axis = false;
                                    _loc_17.axisx = Math.sin(_loc_17.rot);
                                    _loc_17.axisy = Math.cos(_loc_17.rot);
                                }
                                _loc_11 = _loc_9.lverts.next;
                                _loc_12 = _loc_9.gverts.next;
                                while (_loc_12 != null)
                                {
                                    
                                    _loc_13 = _loc_12;
                                    _loc_14 = _loc_11;
                                    _loc_11 = _loc_11.next;
                                    _loc_13.x = _loc_9.body.posx + (_loc_9.body.axisy * _loc_14.x - _loc_9.body.axisx * _loc_14.y);
                                    _loc_13.y = _loc_9.body.posy + (_loc_14.x * _loc_9.body.axisx + _loc_14.y * _loc_9.body.axisy);
                                    _loc_12 = _loc_12.next;
                                }
                            }
                        }
                        _loc_18 = _loc_9.edges.head;
                        _loc_11 = _loc_9.gverts.next;
                        _loc_12 = _loc_11;
                        _loc_11 = _loc_11.next;
                        while (_loc_11 != null)
                        {
                            
                            _loc_13 = _loc_11;
                            _loc_19 = _loc_18.elt;
                            _loc_18 = _loc_18.next;
                            _loc_19.gp0 = _loc_12;
                            _loc_19.gp1 = _loc_13;
                            _loc_19.gnormx = _loc_9.body.axisy * _loc_19.lnormx - _loc_9.body.axisx * _loc_19.lnormy;
                            _loc_19.gnormy = _loc_19.lnormx * _loc_9.body.axisx + _loc_19.lnormy * _loc_9.body.axisy;
                            _loc_19.gprojection = _loc_9.body.posx * _loc_19.gnormx + _loc_9.body.posy * _loc_19.gnormy + _loc_19.lprojection;
                            if (_loc_19.wrap_gnorm != null)
                            {
                                _loc_19.wrap_gnorm.zpp_inner.x = _loc_19.gnormx;
                                _loc_19.wrap_gnorm.zpp_inner.y = _loc_19.gnormy;
                            }
                            _loc_19.tp0 = _loc_19.gp0.y * _loc_19.gnormx - _loc_19.gp0.x * _loc_19.gnormy;
                            _loc_19.tp1 = _loc_19.gp1.y * _loc_19.gnormx - _loc_19.gp1.x * _loc_19.gnormy;
                            _loc_12 = _loc_13;
                            _loc_11 = _loc_11.next;
                        }
                        _loc_13 = _loc_9.gverts.next;
                        _loc_19 = _loc_18.elt;
                        _loc_18 = _loc_18.next;
                        _loc_19.gp0 = _loc_12;
                        _loc_19.gp1 = _loc_13;
                        _loc_19.gnormx = _loc_9.body.axisy * _loc_19.lnormx - _loc_9.body.axisx * _loc_19.lnormy;
                        _loc_19.gnormy = _loc_19.lnormx * _loc_9.body.axisx + _loc_19.lnormy * _loc_9.body.axisy;
                        _loc_19.gprojection = _loc_9.body.posx * _loc_19.gnormx + _loc_9.body.posy * _loc_19.gnormy + _loc_19.lprojection;
                        if (_loc_19.wrap_gnorm != null)
                        {
                            _loc_19.wrap_gnorm.zpp_inner.x = _loc_19.gnormx;
                            _loc_19.wrap_gnorm.zpp_inner.y = _loc_19.gnormy;
                        }
                        _loc_19.tp0 = _loc_19.gp0.y * _loc_19.gnormx - _loc_19.gp0.x * _loc_19.gnormy;
                        _loc_19.tp1 = _loc_19.gp1.y * _loc_19.gnormx - _loc_19.gp1.x * _loc_19.gnormy;
                    }
                }
            }
            _loc_17 = param1.body;
            _loc_10 = _loc_17.posx;
            _loc_15 = _loc_17.posy;
            _loc_17.sweepTime = 0;
            _loc_17.sweep_angvel = _loc_17.angvel;
            var _loc_20:* = param2 - _loc_17.sweepTime;
            if (_loc_20 != 0)
            {
                _loc_17.sweepTime = param2;
                _loc_21 = _loc_20;
                _loc_17.posx = _loc_17.posx + _loc_17.velx * _loc_21;
                _loc_17.posy = _loc_17.posy + _loc_17.vely * _loc_21;
                if (_loc_17.angvel != 0)
                {
                    _loc_21 = _loc_17.sweep_angvel * _loc_20;
                    _loc_17.rot = _loc_17.rot + _loc_21;
                    if (_loc_21 * _loc_21 > 0.0001)
                    {
                        _loc_17.axisx = Math.sin(_loc_17.rot);
                        _loc_17.axisy = Math.cos(_loc_17.rot);
                    }
                    else
                    {
                        _loc_22 = _loc_21 * _loc_21;
                        _loc_23 = 1 - 0.5 * _loc_22;
                        _loc_24 = 1 - _loc_22 * _loc_22 / 8;
                        _loc_25 = (_loc_23 * _loc_17.axisx + _loc_21 * _loc_17.axisy) * _loc_24;
                        _loc_17.axisy = (_loc_23 * _loc_17.axisy - _loc_21 * _loc_17.axisx) * _loc_24;
                        _loc_17.axisx = _loc_25;
                    }
                }
            }
            _loc_20 = _loc_17.posx;
            _loc_21 = _loc_17.posy;
            param1.validate_sweepRadius();
            _loc_22 = param1.sweepRadius;
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_26 = new ZPP_AABB();
            }
            else
            {
                _loc_26 = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_26.next;
                _loc_26.next = null;
            }
            _loc_23 = _loc_10;
            _loc_24 = _loc_20;
            _loc_26.minx = (_loc_23 < _loc_24 ? (_loc_23) : (_loc_24)) - _loc_22;
            _loc_23 = _loc_10;
            _loc_24 = _loc_20;
            _loc_26.maxx = (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24)) + _loc_22;
            _loc_23 = _loc_15;
            _loc_24 = _loc_21;
            _loc_26.miny = (_loc_23 < _loc_24 ? (_loc_23) : (_loc_24)) - _loc_22;
            _loc_23 = _loc_15;
            _loc_24 = _loc_21;
            _loc_26.maxy = (_loc_23 > _loc_24 ? (_loc_23) : (_loc_24)) + _loc_22;
            _loc_28 = bphase.shapesInAABB(_loc_26, false, false, param3 == null ? (null) : (param3.zpp_inner), convexShapeList);
            convexShapeList = _loc_28;
            var _loc_27:* = _loc_28;
            var _loc_29:* = _loc_26;
            if (_loc_29.outer != null)
            {
                _loc_29.outer.zpp_inner = null;
                _loc_29.outer = null;
            }
            _loc_30 = null;
            _loc_29.wrap_max = _loc_30;
            _loc_29.wrap_min = _loc_30;
            _loc_29._invalidate = null;
            _loc_29._validate = null;
            _loc_29.next = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc_29;
            if (param5 == null)
            {
                _loc_31 = new ConvexResultList();
            }
            else
            {
                _loc_31 = param5;
            }
            _loc_27.zpp_inner.valmod();
            var _loc_32:* = ShapeIterator.get(_loc_27);
            do
            {
                
                _loc_32.zpp_critical = false;
                _loc_34 = _loc_32.zpp_i;
                (_loc_32.zpp_i + 1);
                _loc_33 = _loc_32.zpp_inner.at(_loc_34);
                if (_loc_33 != param1.outer)
                {
                }
                if ((_loc_33.zpp_inner.body != null ? (_loc_33.zpp_inner.body.outer) : (null)) != _loc_17.outer)
                {
                    _loc_6.s1 = param1;
                    _loc_6.s2 = _loc_33.zpp_inner;
                    if (param4)
                    {
                        _loc_33.zpp_inner.validate_sweepRadius();
                        (_loc_33.zpp_inner.body != null ? (_loc_33.zpp_inner.body.outer) : (null)).zpp_inner.sweep_angvel = (_loc_33.zpp_inner.body != null ? (_loc_33.zpp_inner.body.outer) : (null)).zpp_inner.angvel;
                        (_loc_33.zpp_inner.body != null ? (_loc_33.zpp_inner.body.outer) : (null)).zpp_inner.sweepTime = 0;
                        ZPP_SweepDistance.dynamicSweep(_loc_6, param2, 0, 0, true);
                        _loc_35 = (_loc_33.zpp_inner.body != null ? (_loc_33.zpp_inner.body.outer) : (null)).zpp_inner;
                        _loc_23 = -_loc_35.sweepTime;
                        if (_loc_23 != 0)
                        {
                            _loc_35.sweepTime = 0;
                            _loc_24 = _loc_23;
                            _loc_35.posx = _loc_35.posx + _loc_35.velx * _loc_24;
                            _loc_35.posy = _loc_35.posy + _loc_35.vely * _loc_24;
                            if (_loc_35.angvel != 0)
                            {
                                _loc_24 = _loc_35.sweep_angvel * _loc_23;
                                _loc_35.rot = _loc_35.rot + _loc_24;
                                if (_loc_24 * _loc_24 > 0.0001)
                                {
                                    _loc_35.axisx = Math.sin(_loc_35.rot);
                                    _loc_35.axisy = Math.cos(_loc_35.rot);
                                }
                                else
                                {
                                    _loc_25 = _loc_24 * _loc_24;
                                    _loc_36 = 1 - 0.5 * _loc_25;
                                    _loc_37 = 1 - _loc_25 * _loc_25 / 8;
                                    _loc_38 = (_loc_36 * _loc_35.axisx + _loc_24 * _loc_35.axisy) * _loc_37;
                                    _loc_35.axisy = (_loc_36 * _loc_35.axisy - _loc_24 * _loc_35.axisx) * _loc_37;
                                    _loc_35.axisx = _loc_38;
                                }
                            }
                        }
                        _loc_35 = (_loc_33.zpp_inner.body != null ? (_loc_33.zpp_inner.body.outer) : (null)).zpp_inner;
                        _loc_7 = _loc_33.zpp_inner;
                        if (_loc_7.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_7.worldCOMx = _loc_35.posx + (_loc_35.axisy * _loc_7.localCOMx - _loc_35.axisx * _loc_7.localCOMy);
                            _loc_7.worldCOMy = _loc_35.posy + (_loc_7.localCOMx * _loc_35.axisx + _loc_7.localCOMy * _loc_35.axisy);
                        }
                        else
                        {
                            _loc_9 = _loc_7.polygon;
                            _loc_11 = _loc_9.lverts.next;
                            _loc_12 = _loc_9.gverts.next;
                            while (_loc_12 != null)
                            {
                                
                                _loc_13 = _loc_12;
                                _loc_14 = _loc_11;
                                _loc_11 = _loc_11.next;
                                _loc_13.x = _loc_35.posx + (_loc_35.axisy * _loc_14.x - _loc_35.axisx * _loc_14.y);
                                _loc_13.y = _loc_35.posy + (_loc_14.x * _loc_35.axisx + _loc_14.y * _loc_35.axisy);
                                _loc_12 = _loc_12.next;
                            }
                            _loc_18 = _loc_9.edges.head;
                            _loc_12 = _loc_9.gverts.next;
                            _loc_13 = _loc_12;
                            _loc_12 = _loc_12.next;
                            while (_loc_12 != null)
                            {
                                
                                _loc_14 = _loc_12;
                                _loc_19 = _loc_18.elt;
                                _loc_18 = _loc_18.next;
                                _loc_19.gnormx = _loc_35.axisy * _loc_19.lnormx - _loc_35.axisx * _loc_19.lnormy;
                                _loc_19.gnormy = _loc_19.lnormx * _loc_35.axisx + _loc_19.lnormy * _loc_35.axisy;
                                _loc_19.gprojection = _loc_35.posx * _loc_19.gnormx + _loc_35.posy * _loc_19.gnormy + _loc_19.lprojection;
                                _loc_19.tp0 = _loc_13.y * _loc_19.gnormx - _loc_13.x * _loc_19.gnormy;
                                _loc_19.tp1 = _loc_14.y * _loc_19.gnormx - _loc_14.x * _loc_19.gnormy;
                                _loc_13 = _loc_14;
                                _loc_12 = _loc_12.next;
                            }
                            _loc_14 = _loc_9.gverts.next;
                            _loc_19 = _loc_18.elt;
                            _loc_18 = _loc_18.next;
                            _loc_19.gnormx = _loc_35.axisy * _loc_19.lnormx - _loc_35.axisx * _loc_19.lnormy;
                            _loc_19.gnormy = _loc_19.lnormx * _loc_35.axisx + _loc_19.lnormy * _loc_35.axisy;
                            _loc_19.gprojection = _loc_35.posx * _loc_19.gnormx + _loc_35.posy * _loc_19.gnormy + _loc_19.lprojection;
                            _loc_19.tp0 = _loc_13.y * _loc_19.gnormx - _loc_13.x * _loc_19.gnormy;
                            _loc_19.tp1 = _loc_14.y * _loc_19.gnormx - _loc_14.x * _loc_19.gnormy;
                        }
                    }
                    else
                    {
                        ZPP_SweepDistance.staticSweep(_loc_6, param2, 0, 0);
                    }
                    _loc_6.toi = _loc_6.toi * param2;
                    if (_loc_6.toi > 0)
                    {
                        _loc_23 = -_loc_6.axis.x;
                        _loc_24 = -_loc_6.axis.y;
                        _loc_40 = false;
                        if (_loc_23 == _loc_23)
                        {
                        }
                        if (_loc_24 != _loc_24)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (ZPP_PubPool.poolVec2 == null)
                        {
                            _loc_30 = new Vec2();
                        }
                        else
                        {
                            _loc_30 = ZPP_PubPool.poolVec2;
                            ZPP_PubPool.poolVec2 = _loc_30.zpp_pool;
                            _loc_30.zpp_pool = null;
                            _loc_30.zpp_disp = false;
                            if (_loc_30 == ZPP_PubPool.nextVec2)
                            {
                                ZPP_PubPool.nextVec2 = null;
                            }
                        }
                        if (_loc_30.zpp_inner == null)
                        {
                            _loc_41 = false;
                            if (ZPP_Vec2.zpp_pool == null)
                            {
                                _loc_11 = new ZPP_Vec2();
                            }
                            else
                            {
                                _loc_11 = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_11.next;
                                _loc_11.next = null;
                            }
                            _loc_11.weak = false;
                            _loc_11._immutable = _loc_41;
                            _loc_11.x = _loc_23;
                            _loc_11.y = _loc_24;
                            _loc_30.zpp_inner = _loc_11;
                            _loc_30.zpp_inner.outer = _loc_30;
                        }
                        else
                        {
                            if (_loc_30 != null)
                            {
                            }
                            if (_loc_30.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_11 = _loc_30.zpp_inner;
                            if (_loc_11._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_11._isimmutable != null)
                            {
                                _loc_11._isimmutable();
                            }
                            if (_loc_23 == _loc_23)
                            {
                            }
                            if (_loc_24 != _loc_24)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (_loc_30 != null)
                            {
                            }
                            if (_loc_30.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_11 = _loc_30.zpp_inner;
                            if (_loc_11._validate != null)
                            {
                                _loc_11._validate();
                            }
                            if (_loc_30.zpp_inner.x == _loc_23)
                            {
                                if (_loc_30 != null)
                                {
                                }
                                if (_loc_30.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_11 = _loc_30.zpp_inner;
                                if (_loc_11._validate != null)
                                {
                                    _loc_11._validate();
                                }
                            }
                            if (_loc_30.zpp_inner.y != _loc_24)
                            {
                                _loc_30.zpp_inner.x = _loc_23;
                                _loc_30.zpp_inner.y = _loc_24;
                                _loc_11 = _loc_30.zpp_inner;
                                if (_loc_11._invalidate != null)
                                {
                                    _loc_11._invalidate(_loc_11);
                                }
                            }
                        }
                        _loc_30.zpp_inner.weak = _loc_40;
                        _loc_23 = _loc_6.c2.x;
                        _loc_24 = _loc_6.c2.y;
                        _loc_40 = false;
                        if (_loc_23 == _loc_23)
                        {
                        }
                        if (_loc_24 != _loc_24)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (ZPP_PubPool.poolVec2 == null)
                        {
                            _loc_30 = new Vec2();
                        }
                        else
                        {
                            _loc_30 = ZPP_PubPool.poolVec2;
                            ZPP_PubPool.poolVec2 = _loc_30.zpp_pool;
                            _loc_30.zpp_pool = null;
                            _loc_30.zpp_disp = false;
                            if (_loc_30 == ZPP_PubPool.nextVec2)
                            {
                                ZPP_PubPool.nextVec2 = null;
                            }
                        }
                        if (_loc_30.zpp_inner == null)
                        {
                            _loc_41 = false;
                            if (ZPP_Vec2.zpp_pool == null)
                            {
                                _loc_11 = new ZPP_Vec2();
                            }
                            else
                            {
                                _loc_11 = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_11.next;
                                _loc_11.next = null;
                            }
                            _loc_11.weak = false;
                            _loc_11._immutable = _loc_41;
                            _loc_11.x = _loc_23;
                            _loc_11.y = _loc_24;
                            _loc_30.zpp_inner = _loc_11;
                            _loc_30.zpp_inner.outer = _loc_30;
                        }
                        else
                        {
                            if (_loc_30 != null)
                            {
                            }
                            if (_loc_30.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_11 = _loc_30.zpp_inner;
                            if (_loc_11._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_11._isimmutable != null)
                            {
                                _loc_11._isimmutable();
                            }
                            if (_loc_23 == _loc_23)
                            {
                            }
                            if (_loc_24 != _loc_24)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (_loc_30 != null)
                            {
                            }
                            if (_loc_30.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_11 = _loc_30.zpp_inner;
                            if (_loc_11._validate != null)
                            {
                                _loc_11._validate();
                            }
                            if (_loc_30.zpp_inner.x == _loc_23)
                            {
                                if (_loc_30 != null)
                                {
                                }
                                if (_loc_30.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_11 = _loc_30.zpp_inner;
                                if (_loc_11._validate != null)
                                {
                                    _loc_11._validate();
                                }
                            }
                            if (_loc_30.zpp_inner.y != _loc_24)
                            {
                                _loc_30.zpp_inner.x = _loc_23;
                                _loc_30.zpp_inner.y = _loc_24;
                                _loc_11 = _loc_30.zpp_inner;
                                if (_loc_11._invalidate != null)
                                {
                                    _loc_11._invalidate(_loc_11);
                                }
                            }
                        }
                        _loc_30.zpp_inner.weak = _loc_40;
                        _loc_39 = ZPP_ConvexRayResult.getConvex(_loc_30, _loc_30, _loc_6.toi, _loc_33);
                        _loc_42 = null;
                        _loc_43 = _loc_31.zpp_inner.inner.head;
                        while (_loc_43 != null)
                        {
                            
                            _loc_44 = _loc_43.elt;
                            if (_loc_39.zpp_inner.next != null)
                            {
                                throw "Error: This object has been disposed of and cannot be used";
                            }
                            if (_loc_44.zpp_inner.next != null)
                            {
                                throw "Error: This object has been disposed of and cannot be used";
                            }
                            if (_loc_39.zpp_inner.toiDistance < _loc_44.zpp_inner.toiDistance)
                            {
                                break;
                            }
                            _loc_42 = _loc_43;
                            _loc_43 = _loc_43.next;
                        }
                        _loc_45 = _loc_31.zpp_inner.inner;
                        if (ZNPNode_ConvexResult.zpp_pool == null)
                        {
                            _loc_46 = new ZNPNode_ConvexResult();
                        }
                        else
                        {
                            _loc_46 = ZNPNode_ConvexResult.zpp_pool;
                            ZNPNode_ConvexResult.zpp_pool = _loc_46.next;
                            _loc_46.next = null;
                        }
                        _loc_46.elt = _loc_39;
                        _loc_43 = _loc_46;
                        if (_loc_42 == null)
                        {
                            _loc_43.next = _loc_45.head;
                            _loc_45.head = _loc_43;
                        }
                        else
                        {
                            _loc_43.next = _loc_42.next;
                            _loc_42.next = _loc_43;
                        }
                        _loc_40 = true;
                        _loc_45.modified = _loc_40;
                        _loc_45.pushmod = _loc_40;
                        (_loc_45.length + 1);
                    }
                }
                _loc_32.zpp_inner.zpp_inner.valmod();
                _loc_28 = _loc_32.zpp_inner;
                _loc_28.zpp_inner.valmod();
                if (_loc_28.zpp_inner.zip_length)
                {
                    _loc_28.zpp_inner.zip_length = false;
                    _loc_28.zpp_inner.user_length = _loc_28.zpp_inner.inner.length;
                }
                _loc_34 = _loc_28.zpp_inner.user_length;
                _loc_32.zpp_critical = true;
            }while (_loc_32.zpp_i < _loc_34 ? (true) : (_loc_32.zpp_next = ShapeIterator.zpp_pool, ShapeIterator.zpp_pool = _loc_32, _loc_32.zpp_inner = null, false))
            _loc_27.clear();
            var _loc_47:* = _loc_6;
            _loc_47.next = ZPP_ToiEvent.zpp_pool;
            ZPP_ToiEvent.zpp_pool = _loc_47;
            _loc_23 = -_loc_17.sweepTime;
            if (_loc_23 != 0)
            {
                _loc_17.sweepTime = 0;
                _loc_24 = _loc_23;
                _loc_17.posx = _loc_17.posx + _loc_17.velx * _loc_24;
                _loc_17.posy = _loc_17.posy + _loc_17.vely * _loc_24;
                if (_loc_17.angvel != 0)
                {
                    _loc_24 = _loc_17.sweep_angvel * _loc_23;
                    _loc_17.rot = _loc_17.rot + _loc_24;
                    if (_loc_24 * _loc_24 > 0.0001)
                    {
                        _loc_17.axisx = Math.sin(_loc_17.rot);
                        _loc_17.axisy = Math.cos(_loc_17.rot);
                    }
                    else
                    {
                        _loc_25 = _loc_24 * _loc_24;
                        _loc_36 = 1 - 0.5 * _loc_25;
                        _loc_37 = 1 - _loc_25 * _loc_25 / 8;
                        _loc_38 = (_loc_36 * _loc_17.axisx + _loc_24 * _loc_17.axisy) * _loc_37;
                        _loc_17.axisy = (_loc_36 * _loc_17.axisy - _loc_24 * _loc_17.axisx) * _loc_37;
                        _loc_17.axisx = _loc_38;
                    }
                }
            }
            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                param1.worldCOMx = _loc_17.posx + (_loc_17.axisy * param1.localCOMx - _loc_17.axisx * param1.localCOMy);
                param1.worldCOMy = _loc_17.posy + (param1.localCOMx * _loc_17.axisx + param1.localCOMy * _loc_17.axisy);
            }
            else
            {
                _loc_9 = param1.polygon;
                _loc_11 = _loc_9.lverts.next;
                _loc_12 = _loc_9.gverts.next;
                while (_loc_12 != null)
                {
                    
                    _loc_13 = _loc_12;
                    _loc_14 = _loc_11;
                    _loc_11 = _loc_11.next;
                    _loc_13.x = _loc_17.posx + (_loc_17.axisy * _loc_14.x - _loc_17.axisx * _loc_14.y);
                    _loc_13.y = _loc_17.posy + (_loc_14.x * _loc_17.axisx + _loc_14.y * _loc_17.axisy);
                    _loc_12 = _loc_12.next;
                }
                _loc_18 = _loc_9.edges.head;
                _loc_12 = _loc_9.gverts.next;
                _loc_13 = _loc_12;
                _loc_12 = _loc_12.next;
                while (_loc_12 != null)
                {
                    
                    _loc_14 = _loc_12;
                    _loc_19 = _loc_18.elt;
                    _loc_18 = _loc_18.next;
                    _loc_19.gnormx = _loc_17.axisy * _loc_19.lnormx - _loc_17.axisx * _loc_19.lnormy;
                    _loc_19.gnormy = _loc_19.lnormx * _loc_17.axisx + _loc_19.lnormy * _loc_17.axisy;
                    _loc_19.gprojection = _loc_17.posx * _loc_19.gnormx + _loc_17.posy * _loc_19.gnormy + _loc_19.lprojection;
                    _loc_19.tp0 = _loc_13.y * _loc_19.gnormx - _loc_13.x * _loc_19.gnormy;
                    _loc_19.tp1 = _loc_14.y * _loc_19.gnormx - _loc_14.x * _loc_19.gnormy;
                    _loc_13 = _loc_14;
                    _loc_12 = _loc_12.next;
                }
                _loc_14 = _loc_9.gverts.next;
                _loc_19 = _loc_18.elt;
                _loc_18 = _loc_18.next;
                _loc_19.gnormx = _loc_17.axisy * _loc_19.lnormx - _loc_17.axisx * _loc_19.lnormy;
                _loc_19.gnormy = _loc_19.lnormx * _loc_17.axisx + _loc_19.lnormy * _loc_17.axisy;
                _loc_19.gprojection = _loc_17.posx * _loc_19.gnormx + _loc_17.posy * _loc_19.gnormy + _loc_19.lprojection;
                _loc_19.tp0 = _loc_13.y * _loc_19.gnormx - _loc_13.x * _loc_19.gnormy;
                _loc_19.tp1 = _loc_14.y * _loc_19.gnormx - _loc_14.x * _loc_19.gnormy;
            }
            return _loc_31;
        }// end function

        public function convexCast(param1:ZPP_Shape, param2:Number, param3:InteractionFilter, param4:Boolean) : ConvexResult
        {
            var _loc_5:* = null as ZPP_ToiEvent;
            var _loc_6:* = null as ZPP_Shape;
            var _loc_7:* = null as ZPP_Circle;
            var _loc_8:* = null as ZPP_Polygon;
            var _loc_9:* = NaN;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_13:* = null as ZPP_Vec2;
            var _loc_14:* = NaN;
            var _loc_15:* = null as ZPP_Vec2;
            var _loc_16:* = null as ZPP_Body;
            var _loc_17:* = null as ZNPNode_ZPP_Edge;
            var _loc_18:* = null as ZPP_Edge;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = null as ZPP_AABB;
            var _loc_27:* = null as ShapeList;
            var _loc_29:* = null as Vec2;
            var _loc_34:* = null as Shape;
            var _loc_35:* = 0;
            var _loc_36:* = null as ZPP_Body;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = NaN;
            var _loc_40:* = NaN;
            var _loc_41:* = NaN;
            var _loc_42:* = NaN;
            var _loc_44:* = false;
            var _loc_45:* = false;
            if (ZPP_ToiEvent.zpp_pool == null)
            {
                _loc_5 = new ZPP_ToiEvent();
            }
            else
            {
                _loc_5 = ZPP_ToiEvent.zpp_pool;
                ZPP_ToiEvent.zpp_pool = _loc_5.next;
                _loc_5.next = null;
            }
            _loc_5.failed = false;
            _loc_6 = null;
            _loc_5.s2 = _loc_6;
            _loc_5.s1 = _loc_6;
            _loc_5.arbiter = null;
            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                _loc_7 = param1.circle;
                if (_loc_7.zip_worldCOM)
                {
                    if (_loc_7.body != null)
                    {
                        _loc_7.zip_worldCOM = false;
                        if (_loc_7.zip_localCOM)
                        {
                            _loc_7.zip_localCOM = false;
                            if (_loc_7.type == ZPP_Flags.id_ShapeType_POLYGON)
                            {
                                _loc_8 = _loc_7.polygon;
                                if (_loc_8.lverts.next == null)
                                {
                                    throw "Error: An empty polygon has no meaningful localCOM";
                                }
                                if (_loc_8.lverts.next.next == null)
                                {
                                    _loc_8.localCOMx = _loc_8.lverts.next.x;
                                    _loc_8.localCOMy = _loc_8.lverts.next.y;
                                }
                                else if (_loc_8.lverts.next.next.next == null)
                                {
                                    _loc_8.localCOMx = _loc_8.lverts.next.x;
                                    _loc_8.localCOMy = _loc_8.lverts.next.y;
                                    _loc_9 = 1;
                                    _loc_8.localCOMx = _loc_8.localCOMx + _loc_8.lverts.next.next.x * _loc_9;
                                    _loc_8.localCOMy = _loc_8.localCOMy + _loc_8.lverts.next.next.y * _loc_9;
                                    _loc_9 = 0.5;
                                    _loc_8.localCOMx = _loc_8.localCOMx * _loc_9;
                                    _loc_8.localCOMy = _loc_8.localCOMy * _loc_9;
                                }
                                else
                                {
                                    _loc_8.localCOMx = 0;
                                    _loc_8.localCOMy = 0;
                                    _loc_9 = 0;
                                    _loc_10 = _loc_8.lverts.next;
                                    _loc_11 = _loc_10;
                                    _loc_10 = _loc_10.next;
                                    _loc_12 = _loc_10;
                                    _loc_10 = _loc_10.next;
                                    while (_loc_10 != null)
                                    {
                                        
                                        _loc_13 = _loc_10;
                                        _loc_9 = _loc_9 + _loc_12.x * (_loc_13.y - _loc_11.y);
                                        _loc_14 = _loc_13.y * _loc_12.x - _loc_13.x * _loc_12.y;
                                        _loc_8.localCOMx = _loc_8.localCOMx + (_loc_12.x + _loc_13.x) * _loc_14;
                                        _loc_8.localCOMy = _loc_8.localCOMy + (_loc_12.y + _loc_13.y) * _loc_14;
                                        _loc_11 = _loc_12;
                                        _loc_12 = _loc_13;
                                        _loc_10 = _loc_10.next;
                                    }
                                    _loc_10 = _loc_8.lverts.next;
                                    _loc_13 = _loc_10;
                                    _loc_9 = _loc_9 + _loc_12.x * (_loc_13.y - _loc_11.y);
                                    _loc_14 = _loc_13.y * _loc_12.x - _loc_13.x * _loc_12.y;
                                    _loc_8.localCOMx = _loc_8.localCOMx + (_loc_12.x + _loc_13.x) * _loc_14;
                                    _loc_8.localCOMy = _loc_8.localCOMy + (_loc_12.y + _loc_13.y) * _loc_14;
                                    _loc_11 = _loc_12;
                                    _loc_12 = _loc_13;
                                    _loc_10 = _loc_10.next;
                                    _loc_15 = _loc_10;
                                    _loc_9 = _loc_9 + _loc_12.x * (_loc_15.y - _loc_11.y);
                                    _loc_14 = _loc_15.y * _loc_12.x - _loc_15.x * _loc_12.y;
                                    _loc_8.localCOMx = _loc_8.localCOMx + (_loc_12.x + _loc_15.x) * _loc_14;
                                    _loc_8.localCOMy = _loc_8.localCOMy + (_loc_12.y + _loc_15.y) * _loc_14;
                                    _loc_9 = 1 / (3 * _loc_9);
                                    _loc_14 = _loc_9;
                                    _loc_8.localCOMx = _loc_8.localCOMx * _loc_14;
                                    _loc_8.localCOMy = _loc_8.localCOMy * _loc_14;
                                }
                            }
                            if (_loc_7.wrap_localCOM != null)
                            {
                                _loc_7.wrap_localCOM.zpp_inner.x = _loc_7.localCOMx;
                                _loc_7.wrap_localCOM.zpp_inner.y = _loc_7.localCOMy;
                            }
                        }
                        _loc_16 = _loc_7.body;
                        if (_loc_16.zip_axis)
                        {
                            _loc_16.zip_axis = false;
                            _loc_16.axisx = Math.sin(_loc_16.rot);
                            _loc_16.axisy = Math.cos(_loc_16.rot);
                        }
                        _loc_7.worldCOMx = _loc_7.body.posx + (_loc_7.body.axisy * _loc_7.localCOMx - _loc_7.body.axisx * _loc_7.localCOMy);
                        _loc_7.worldCOMy = _loc_7.body.posy + (_loc_7.localCOMx * _loc_7.body.axisx + _loc_7.localCOMy * _loc_7.body.axisy);
                    }
                }
            }
            else
            {
                _loc_8 = param1.polygon;
                if (_loc_8.zip_gaxi)
                {
                    if (_loc_8.body != null)
                    {
                        _loc_8.zip_gaxi = false;
                        _loc_8.validate_laxi();
                        _loc_16 = _loc_8.body;
                        if (_loc_16.zip_axis)
                        {
                            _loc_16.zip_axis = false;
                            _loc_16.axisx = Math.sin(_loc_16.rot);
                            _loc_16.axisy = Math.cos(_loc_16.rot);
                        }
                        if (_loc_8.zip_gverts)
                        {
                            if (_loc_8.body != null)
                            {
                                _loc_8.zip_gverts = false;
                                _loc_8.validate_lverts();
                                _loc_16 = _loc_8.body;
                                if (_loc_16.zip_axis)
                                {
                                    _loc_16.zip_axis = false;
                                    _loc_16.axisx = Math.sin(_loc_16.rot);
                                    _loc_16.axisy = Math.cos(_loc_16.rot);
                                }
                                _loc_10 = _loc_8.lverts.next;
                                _loc_11 = _loc_8.gverts.next;
                                while (_loc_11 != null)
                                {
                                    
                                    _loc_12 = _loc_11;
                                    _loc_13 = _loc_10;
                                    _loc_10 = _loc_10.next;
                                    _loc_12.x = _loc_8.body.posx + (_loc_8.body.axisy * _loc_13.x - _loc_8.body.axisx * _loc_13.y);
                                    _loc_12.y = _loc_8.body.posy + (_loc_13.x * _loc_8.body.axisx + _loc_13.y * _loc_8.body.axisy);
                                    _loc_11 = _loc_11.next;
                                }
                            }
                        }
                        _loc_17 = _loc_8.edges.head;
                        _loc_10 = _loc_8.gverts.next;
                        _loc_11 = _loc_10;
                        _loc_10 = _loc_10.next;
                        while (_loc_10 != null)
                        {
                            
                            _loc_12 = _loc_10;
                            _loc_18 = _loc_17.elt;
                            _loc_17 = _loc_17.next;
                            _loc_18.gp0 = _loc_11;
                            _loc_18.gp1 = _loc_12;
                            _loc_18.gnormx = _loc_8.body.axisy * _loc_18.lnormx - _loc_8.body.axisx * _loc_18.lnormy;
                            _loc_18.gnormy = _loc_18.lnormx * _loc_8.body.axisx + _loc_18.lnormy * _loc_8.body.axisy;
                            _loc_18.gprojection = _loc_8.body.posx * _loc_18.gnormx + _loc_8.body.posy * _loc_18.gnormy + _loc_18.lprojection;
                            if (_loc_18.wrap_gnorm != null)
                            {
                                _loc_18.wrap_gnorm.zpp_inner.x = _loc_18.gnormx;
                                _loc_18.wrap_gnorm.zpp_inner.y = _loc_18.gnormy;
                            }
                            _loc_18.tp0 = _loc_18.gp0.y * _loc_18.gnormx - _loc_18.gp0.x * _loc_18.gnormy;
                            _loc_18.tp1 = _loc_18.gp1.y * _loc_18.gnormx - _loc_18.gp1.x * _loc_18.gnormy;
                            _loc_11 = _loc_12;
                            _loc_10 = _loc_10.next;
                        }
                        _loc_12 = _loc_8.gverts.next;
                        _loc_18 = _loc_17.elt;
                        _loc_17 = _loc_17.next;
                        _loc_18.gp0 = _loc_11;
                        _loc_18.gp1 = _loc_12;
                        _loc_18.gnormx = _loc_8.body.axisy * _loc_18.lnormx - _loc_8.body.axisx * _loc_18.lnormy;
                        _loc_18.gnormy = _loc_18.lnormx * _loc_8.body.axisx + _loc_18.lnormy * _loc_8.body.axisy;
                        _loc_18.gprojection = _loc_8.body.posx * _loc_18.gnormx + _loc_8.body.posy * _loc_18.gnormy + _loc_18.lprojection;
                        if (_loc_18.wrap_gnorm != null)
                        {
                            _loc_18.wrap_gnorm.zpp_inner.x = _loc_18.gnormx;
                            _loc_18.wrap_gnorm.zpp_inner.y = _loc_18.gnormy;
                        }
                        _loc_18.tp0 = _loc_18.gp0.y * _loc_18.gnormx - _loc_18.gp0.x * _loc_18.gnormy;
                        _loc_18.tp1 = _loc_18.gp1.y * _loc_18.gnormx - _loc_18.gp1.x * _loc_18.gnormy;
                    }
                }
            }
            _loc_16 = param1.body;
            _loc_9 = _loc_16.posx;
            _loc_14 = _loc_16.posy;
            _loc_16.sweepTime = 0;
            _loc_16.sweep_angvel = _loc_16.angvel;
            var _loc_19:* = param2 - _loc_16.sweepTime;
            if (_loc_19 != 0)
            {
                _loc_16.sweepTime = param2;
                _loc_20 = _loc_19;
                _loc_16.posx = _loc_16.posx + _loc_16.velx * _loc_20;
                _loc_16.posy = _loc_16.posy + _loc_16.vely * _loc_20;
                if (_loc_16.angvel != 0)
                {
                    _loc_20 = _loc_16.sweep_angvel * _loc_19;
                    _loc_16.rot = _loc_16.rot + _loc_20;
                    if (_loc_20 * _loc_20 > 0.0001)
                    {
                        _loc_16.axisx = Math.sin(_loc_16.rot);
                        _loc_16.axisy = Math.cos(_loc_16.rot);
                    }
                    else
                    {
                        _loc_21 = _loc_20 * _loc_20;
                        _loc_22 = 1 - 0.5 * _loc_21;
                        _loc_23 = 1 - _loc_21 * _loc_21 / 8;
                        _loc_24 = (_loc_22 * _loc_16.axisx + _loc_20 * _loc_16.axisy) * _loc_23;
                        _loc_16.axisy = (_loc_22 * _loc_16.axisy - _loc_20 * _loc_16.axisx) * _loc_23;
                        _loc_16.axisx = _loc_24;
                    }
                }
            }
            _loc_19 = _loc_16.posx;
            _loc_20 = _loc_16.posy;
            param1.validate_sweepRadius();
            _loc_21 = param1.sweepRadius;
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_25 = new ZPP_AABB();
            }
            else
            {
                _loc_25 = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_25.next;
                _loc_25.next = null;
            }
            _loc_22 = _loc_9;
            _loc_23 = _loc_19;
            _loc_25.minx = (_loc_22 < _loc_23 ? (_loc_22) : (_loc_23)) - _loc_21;
            _loc_22 = _loc_9;
            _loc_23 = _loc_19;
            _loc_25.maxx = (_loc_22 > _loc_23 ? (_loc_22) : (_loc_23)) + _loc_21;
            _loc_22 = _loc_14;
            _loc_23 = _loc_20;
            _loc_25.miny = (_loc_22 < _loc_23 ? (_loc_22) : (_loc_23)) - _loc_21;
            _loc_22 = _loc_14;
            _loc_23 = _loc_20;
            _loc_25.maxy = (_loc_22 > _loc_23 ? (_loc_22) : (_loc_23)) + _loc_21;
            _loc_27 = bphase.shapesInAABB(_loc_25, false, false, param3 == null ? (null) : (param3.zpp_inner), convexShapeList);
            convexShapeList = _loc_27;
            var _loc_26:* = _loc_27;
            var _loc_28:* = _loc_25;
            if (_loc_28.outer != null)
            {
                _loc_28.outer.zpp_inner = null;
                _loc_28.outer = null;
            }
            _loc_29 = null;
            _loc_28.wrap_max = _loc_29;
            _loc_28.wrap_min = _loc_29;
            _loc_28._invalidate = null;
            _loc_28._validate = null;
            _loc_28.next = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc_28;
            _loc_22 = 0;
            _loc_23 = 0;
            _loc_22 = 0;
            _loc_23 = 0;
            _loc_24 = 0;
            var _loc_30:* = 0;
            _loc_24 = 0;
            _loc_30 = 0;
            var _loc_31:* = null;
            var _loc_32:* = param2 + 1;
            _loc_26.zpp_inner.valmod();
            var _loc_33:* = ShapeIterator.get(_loc_26);
            do
            {
                
                _loc_33.zpp_critical = false;
                _loc_35 = _loc_33.zpp_i;
                (_loc_33.zpp_i + 1);
                _loc_34 = _loc_33.zpp_inner.at(_loc_35);
                if (_loc_34 != param1.outer)
                {
                }
                if ((_loc_34.zpp_inner.body != null ? (_loc_34.zpp_inner.body.outer) : (null)) != _loc_16.outer)
                {
                    _loc_5.s1 = param1;
                    _loc_5.s2 = _loc_34.zpp_inner;
                    if (param4)
                    {
                        _loc_34.zpp_inner.validate_sweepRadius();
                        (_loc_34.zpp_inner.body != null ? (_loc_34.zpp_inner.body.outer) : (null)).zpp_inner.sweep_angvel = (_loc_34.zpp_inner.body != null ? (_loc_34.zpp_inner.body.outer) : (null)).zpp_inner.angvel;
                        (_loc_34.zpp_inner.body != null ? (_loc_34.zpp_inner.body.outer) : (null)).zpp_inner.sweepTime = 0;
                        ZPP_SweepDistance.dynamicSweep(_loc_5, param2, 0, 0, true);
                        _loc_36 = (_loc_34.zpp_inner.body != null ? (_loc_34.zpp_inner.body.outer) : (null)).zpp_inner;
                        _loc_37 = -_loc_36.sweepTime;
                        if (_loc_37 != 0)
                        {
                            _loc_36.sweepTime = 0;
                            _loc_38 = _loc_37;
                            _loc_36.posx = _loc_36.posx + _loc_36.velx * _loc_38;
                            _loc_36.posy = _loc_36.posy + _loc_36.vely * _loc_38;
                            if (_loc_36.angvel != 0)
                            {
                                _loc_38 = _loc_36.sweep_angvel * _loc_37;
                                _loc_36.rot = _loc_36.rot + _loc_38;
                                if (_loc_38 * _loc_38 > 0.0001)
                                {
                                    _loc_36.axisx = Math.sin(_loc_36.rot);
                                    _loc_36.axisy = Math.cos(_loc_36.rot);
                                }
                                else
                                {
                                    _loc_39 = _loc_38 * _loc_38;
                                    _loc_40 = 1 - 0.5 * _loc_39;
                                    _loc_41 = 1 - _loc_39 * _loc_39 / 8;
                                    _loc_42 = (_loc_40 * _loc_36.axisx + _loc_38 * _loc_36.axisy) * _loc_41;
                                    _loc_36.axisy = (_loc_40 * _loc_36.axisy - _loc_38 * _loc_36.axisx) * _loc_41;
                                    _loc_36.axisx = _loc_42;
                                }
                            }
                        }
                        _loc_36 = (_loc_34.zpp_inner.body != null ? (_loc_34.zpp_inner.body.outer) : (null)).zpp_inner;
                        _loc_6 = _loc_34.zpp_inner;
                        if (_loc_6.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_6.worldCOMx = _loc_36.posx + (_loc_36.axisy * _loc_6.localCOMx - _loc_36.axisx * _loc_6.localCOMy);
                            _loc_6.worldCOMy = _loc_36.posy + (_loc_6.localCOMx * _loc_36.axisx + _loc_6.localCOMy * _loc_36.axisy);
                        }
                        else
                        {
                            _loc_8 = _loc_6.polygon;
                            _loc_10 = _loc_8.lverts.next;
                            _loc_11 = _loc_8.gverts.next;
                            while (_loc_11 != null)
                            {
                                
                                _loc_12 = _loc_11;
                                _loc_13 = _loc_10;
                                _loc_10 = _loc_10.next;
                                _loc_12.x = _loc_36.posx + (_loc_36.axisy * _loc_13.x - _loc_36.axisx * _loc_13.y);
                                _loc_12.y = _loc_36.posy + (_loc_13.x * _loc_36.axisx + _loc_13.y * _loc_36.axisy);
                                _loc_11 = _loc_11.next;
                            }
                            _loc_17 = _loc_8.edges.head;
                            _loc_11 = _loc_8.gverts.next;
                            _loc_12 = _loc_11;
                            _loc_11 = _loc_11.next;
                            while (_loc_11 != null)
                            {
                                
                                _loc_13 = _loc_11;
                                _loc_18 = _loc_17.elt;
                                _loc_17 = _loc_17.next;
                                _loc_18.gnormx = _loc_36.axisy * _loc_18.lnormx - _loc_36.axisx * _loc_18.lnormy;
                                _loc_18.gnormy = _loc_18.lnormx * _loc_36.axisx + _loc_18.lnormy * _loc_36.axisy;
                                _loc_18.gprojection = _loc_36.posx * _loc_18.gnormx + _loc_36.posy * _loc_18.gnormy + _loc_18.lprojection;
                                _loc_18.tp0 = _loc_12.y * _loc_18.gnormx - _loc_12.x * _loc_18.gnormy;
                                _loc_18.tp1 = _loc_13.y * _loc_18.gnormx - _loc_13.x * _loc_18.gnormy;
                                _loc_12 = _loc_13;
                                _loc_11 = _loc_11.next;
                            }
                            _loc_13 = _loc_8.gverts.next;
                            _loc_18 = _loc_17.elt;
                            _loc_17 = _loc_17.next;
                            _loc_18.gnormx = _loc_36.axisy * _loc_18.lnormx - _loc_36.axisx * _loc_18.lnormy;
                            _loc_18.gnormy = _loc_18.lnormx * _loc_36.axisx + _loc_18.lnormy * _loc_36.axisy;
                            _loc_18.gprojection = _loc_36.posx * _loc_18.gnormx + _loc_36.posy * _loc_18.gnormy + _loc_18.lprojection;
                            _loc_18.tp0 = _loc_12.y * _loc_18.gnormx - _loc_12.x * _loc_18.gnormy;
                            _loc_18.tp1 = _loc_13.y * _loc_18.gnormx - _loc_13.x * _loc_18.gnormy;
                        }
                    }
                    else
                    {
                        ZPP_SweepDistance.staticSweep(_loc_5, param2, 0, 0);
                    }
                    _loc_5.toi = _loc_5.toi * param2;
                    if (_loc_5.toi > 0)
                    {
                    }
                    if (_loc_5.toi < _loc_32)
                    {
                        _loc_32 = _loc_5.toi;
                        _loc_22 = _loc_5.axis.x;
                        _loc_23 = _loc_5.axis.y;
                        _loc_24 = _loc_5.c2.x;
                        _loc_30 = _loc_5.c2.y;
                        _loc_31 = _loc_34;
                    }
                }
                _loc_33.zpp_inner.zpp_inner.valmod();
                _loc_27 = _loc_33.zpp_inner;
                _loc_27.zpp_inner.valmod();
                if (_loc_27.zpp_inner.zip_length)
                {
                    _loc_27.zpp_inner.zip_length = false;
                    _loc_27.zpp_inner.user_length = _loc_27.zpp_inner.inner.length;
                }
                _loc_35 = _loc_27.zpp_inner.user_length;
                _loc_33.zpp_critical = true;
            }while (_loc_33.zpp_i < _loc_35 ? (true) : (_loc_33.zpp_next = ShapeIterator.zpp_pool, ShapeIterator.zpp_pool = _loc_33, _loc_33.zpp_inner = null, false))
            _loc_26.clear();
            var _loc_43:* = _loc_5;
            _loc_43.next = ZPP_ToiEvent.zpp_pool;
            ZPP_ToiEvent.zpp_pool = _loc_43;
            _loc_37 = -_loc_16.sweepTime;
            if (_loc_37 != 0)
            {
                _loc_16.sweepTime = 0;
                _loc_38 = _loc_37;
                _loc_16.posx = _loc_16.posx + _loc_16.velx * _loc_38;
                _loc_16.posy = _loc_16.posy + _loc_16.vely * _loc_38;
                if (_loc_16.angvel != 0)
                {
                    _loc_38 = _loc_16.sweep_angvel * _loc_37;
                    _loc_16.rot = _loc_16.rot + _loc_38;
                    if (_loc_38 * _loc_38 > 0.0001)
                    {
                        _loc_16.axisx = Math.sin(_loc_16.rot);
                        _loc_16.axisy = Math.cos(_loc_16.rot);
                    }
                    else
                    {
                        _loc_39 = _loc_38 * _loc_38;
                        _loc_40 = 1 - 0.5 * _loc_39;
                        _loc_41 = 1 - _loc_39 * _loc_39 / 8;
                        _loc_42 = (_loc_40 * _loc_16.axisx + _loc_38 * _loc_16.axisy) * _loc_41;
                        _loc_16.axisy = (_loc_40 * _loc_16.axisy - _loc_38 * _loc_16.axisx) * _loc_41;
                        _loc_16.axisx = _loc_42;
                    }
                }
            }
            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                param1.worldCOMx = _loc_16.posx + (_loc_16.axisy * param1.localCOMx - _loc_16.axisx * param1.localCOMy);
                param1.worldCOMy = _loc_16.posy + (param1.localCOMx * _loc_16.axisx + param1.localCOMy * _loc_16.axisy);
            }
            else
            {
                _loc_8 = param1.polygon;
                _loc_10 = _loc_8.lverts.next;
                _loc_11 = _loc_8.gverts.next;
                while (_loc_11 != null)
                {
                    
                    _loc_12 = _loc_11;
                    _loc_13 = _loc_10;
                    _loc_10 = _loc_10.next;
                    _loc_12.x = _loc_16.posx + (_loc_16.axisy * _loc_13.x - _loc_16.axisx * _loc_13.y);
                    _loc_12.y = _loc_16.posy + (_loc_13.x * _loc_16.axisx + _loc_13.y * _loc_16.axisy);
                    _loc_11 = _loc_11.next;
                }
                _loc_17 = _loc_8.edges.head;
                _loc_11 = _loc_8.gverts.next;
                _loc_12 = _loc_11;
                _loc_11 = _loc_11.next;
                while (_loc_11 != null)
                {
                    
                    _loc_13 = _loc_11;
                    _loc_18 = _loc_17.elt;
                    _loc_17 = _loc_17.next;
                    _loc_18.gnormx = _loc_16.axisy * _loc_18.lnormx - _loc_16.axisx * _loc_18.lnormy;
                    _loc_18.gnormy = _loc_18.lnormx * _loc_16.axisx + _loc_18.lnormy * _loc_16.axisy;
                    _loc_18.gprojection = _loc_16.posx * _loc_18.gnormx + _loc_16.posy * _loc_18.gnormy + _loc_18.lprojection;
                    _loc_18.tp0 = _loc_12.y * _loc_18.gnormx - _loc_12.x * _loc_18.gnormy;
                    _loc_18.tp1 = _loc_13.y * _loc_18.gnormx - _loc_13.x * _loc_18.gnormy;
                    _loc_12 = _loc_13;
                    _loc_11 = _loc_11.next;
                }
                _loc_13 = _loc_8.gverts.next;
                _loc_18 = _loc_17.elt;
                _loc_17 = _loc_17.next;
                _loc_18.gnormx = _loc_16.axisy * _loc_18.lnormx - _loc_16.axisx * _loc_18.lnormy;
                _loc_18.gnormy = _loc_18.lnormx * _loc_16.axisx + _loc_18.lnormy * _loc_16.axisy;
                _loc_18.gprojection = _loc_16.posx * _loc_18.gnormx + _loc_16.posy * _loc_18.gnormy + _loc_18.lprojection;
                _loc_18.tp0 = _loc_12.y * _loc_18.gnormx - _loc_12.x * _loc_18.gnormy;
                _loc_18.tp1 = _loc_13.y * _loc_18.gnormx - _loc_13.x * _loc_18.gnormy;
            }
            if (_loc_32 <= param2)
            {
                _loc_37 = -_loc_22;
                _loc_38 = -_loc_23;
                _loc_44 = false;
                if (_loc_37 == _loc_37)
                {
                }
                if (_loc_38 != _loc_38)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_29 = new Vec2();
                }
                else
                {
                    _loc_29 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_29.zpp_pool;
                    _loc_29.zpp_pool = null;
                    _loc_29.zpp_disp = false;
                    if (_loc_29 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_29.zpp_inner == null)
                {
                    _loc_45 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_10 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_10 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_10.next;
                        _loc_10.next = null;
                    }
                    _loc_10.weak = false;
                    _loc_10._immutable = _loc_45;
                    _loc_10.x = _loc_37;
                    _loc_10.y = _loc_38;
                    _loc_29.zpp_inner = _loc_10;
                    _loc_29.zpp_inner.outer = _loc_29;
                }
                else
                {
                    if (_loc_29 != null)
                    {
                    }
                    if (_loc_29.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_29.zpp_inner;
                    if (_loc_10._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_10._isimmutable != null)
                    {
                        _loc_10._isimmutable();
                    }
                    if (_loc_37 == _loc_37)
                    {
                    }
                    if (_loc_38 != _loc_38)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_29 != null)
                    {
                    }
                    if (_loc_29.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_29.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    if (_loc_29.zpp_inner.x == _loc_37)
                    {
                        if (_loc_29 != null)
                        {
                        }
                        if (_loc_29.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_10 = _loc_29.zpp_inner;
                        if (_loc_10._validate != null)
                        {
                            _loc_10._validate();
                        }
                    }
                    if (_loc_29.zpp_inner.y != _loc_38)
                    {
                        _loc_29.zpp_inner.x = _loc_37;
                        _loc_29.zpp_inner.y = _loc_38;
                        _loc_10 = _loc_29.zpp_inner;
                        if (_loc_10._invalidate != null)
                        {
                            _loc_10._invalidate(_loc_10);
                        }
                    }
                }
                _loc_29.zpp_inner.weak = _loc_44;
                _loc_44 = false;
                if (_loc_24 == _loc_24)
                {
                }
                if (_loc_30 != _loc_30)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_29 = new Vec2();
                }
                else
                {
                    _loc_29 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_29.zpp_pool;
                    _loc_29.zpp_pool = null;
                    _loc_29.zpp_disp = false;
                    if (_loc_29 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_29.zpp_inner == null)
                {
                    _loc_45 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_10 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_10 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_10.next;
                        _loc_10.next = null;
                    }
                    _loc_10.weak = false;
                    _loc_10._immutable = _loc_45;
                    _loc_10.x = _loc_24;
                    _loc_10.y = _loc_30;
                    _loc_29.zpp_inner = _loc_10;
                    _loc_29.zpp_inner.outer = _loc_29;
                }
                else
                {
                    if (_loc_29 != null)
                    {
                    }
                    if (_loc_29.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_29.zpp_inner;
                    if (_loc_10._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_10._isimmutable != null)
                    {
                        _loc_10._isimmutable();
                    }
                    if (_loc_24 == _loc_24)
                    {
                    }
                    if (_loc_30 != _loc_30)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_29 != null)
                    {
                    }
                    if (_loc_29.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_29.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    if (_loc_29.zpp_inner.x == _loc_24)
                    {
                        if (_loc_29 != null)
                        {
                        }
                        if (_loc_29.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_10 = _loc_29.zpp_inner;
                        if (_loc_10._validate != null)
                        {
                            _loc_10._validate();
                        }
                    }
                    if (_loc_29.zpp_inner.y != _loc_30)
                    {
                        _loc_29.zpp_inner.x = _loc_24;
                        _loc_29.zpp_inner.y = _loc_30;
                        _loc_10 = _loc_29.zpp_inner;
                        if (_loc_10._invalidate != null)
                        {
                            _loc_10._invalidate(_loc_10);
                        }
                    }
                }
                _loc_29.zpp_inner.weak = _loc_44;
                return ZPP_ConvexRayResult.getConvex(_loc_29, _loc_29, _loc_32, _loc_31);
            }
            else
            {
                return null;
            }
        }// end function

        public function continuousEvent(param1:ZPP_Shape, param2:ZPP_Shape, param3:Boolean, param4:ZPP_Arbiter, param5:Boolean) : ZPP_Arbiter
        {
            var _loc_6:* = null as ZPP_Body;
            var _loc_7:* = null as ZPP_Body;
            var _loc_8:* = false;
            var _loc_9:* = null as ZNPNode_ZPP_Constraint;
            var _loc_10:* = null as ZPP_Constraint;
            var _loc_11:* = null as ZPP_InteractionGroup;
            var _loc_12:* = null as ZPP_Interactor;
            var _loc_13:* = null as ZPP_InteractionGroup;
            var _loc_14:* = false;
            var _loc_15:* = null as ZPP_InteractionFilter;
            var _loc_16:* = null as ZPP_InteractionFilter;
            var _loc_17:* = null as ZPP_ToiEvent;
            var _loc_18:* = null as ZPP_Shape;
            var _loc_19:* = null as ZPP_ToiEvent;
            if (param1.body.sweepFrozen)
            {
            }
            if (param2.body.sweepFrozen)
            {
                return param4;
            }
            if (!param1.body.disableCCD)
            {
            }
            if (param2.body.disableCCD)
            {
                return param4;
            }
            if (param4 != null)
            {
            }
            if (param4.colarb != null)
            {
                _loc_6 = param1.body;
                _loc_7 = param2.body;
                _loc_8 = false;
                _loc_9 = _loc_6.constraints.head;
                while (_loc_9 != null)
                {
                    
                    _loc_10 = _loc_9.elt;
                    if (_loc_10.ignore)
                    {
                    }
                    if (_loc_10.pair_exists(_loc_6.id, _loc_7.id))
                    {
                        _loc_8 = true;
                        break;
                    }
                    _loc_9 = _loc_9.next;
                }
                if (!_loc_8)
                {
                    _loc_12 = param1;
                    do
                    {
                        
                        if (_loc_12.ishape != null)
                        {
                            _loc_12 = _loc_12.ishape.body;
                        }
                        else if (_loc_12.icompound != null)
                        {
                            _loc_12 = _loc_12.icompound.compound;
                        }
                        else
                        {
                            _loc_12 = _loc_12.ibody.compound;
                        }
                        if (_loc_12 != null)
                        {
                        }
                    }while (_loc_12.group == null)
                    if (_loc_12 == null)
                    {
                        _loc_11 = null;
                    }
                    else
                    {
                        _loc_11 = _loc_12.group;
                    }
                    while (_loc_12.group == null)
                    {
                        if (_loc_12.ishape != null)
                        {
                            continue;
                        }
                        if (_loc_12.icompound != null)
                        {
                            continue;
                        }
                        if (_loc_12 != null)
                        {
                        }
                    }
                    if (_loc_12 == null)
                    {
                    }
                    else
                    {
                    }
                    while (_loc_13 != null)
                    {
                        if (_loc_11 == _loc_13)
                        {
                            break;
                        }
                        if (_loc_11.depth < _loc_13.depth)
                        {
                            continue;
                        }
                        if (_loc_11 != null)
                        {
                        }
                    }
                }
                if (!param1.sensorEnabled)
                {
                }
                if (param2.sensorEnabled)
                {
                    if ((_loc_15.sensorMask & _loc_16.sensorGroup) != 0)
                    {
                    }
                }
                if (!param1.fluidEnabled)
                {
                }
                if (param2.fluidEnabled)
                {
                    if ((_loc_15.fluidMask & _loc_16.fluidGroup) != 0)
                    {
                    }
                }
                if ((_loc_16.fluidMask & _loc_15.fluidGroup) != 0)
                {
                    if (_loc_6.imass == 0)
                    {
                    }
                    if (_loc_7.imass == 0)
                    {
                    }
                    if (_loc_6.iinertia == 0)
                    {
                    }
                }
                if ((_loc_15.collisionMask & _loc_16.collisionGroup) != 0)
                {
                }
                if ((_loc_16.collisionMask & _loc_15.collisionGroup) != 0)
                {
                    if (_loc_6.imass == 0)
                    {
                    }
                    if (_loc_7.imass == 0)
                    {
                    }
                    if (_loc_6.iinertia == 0)
                    {
                    }
                }
            }
            if ((!(_loc_11.depth < _loc_13.depth ? (false) : (_loc_12 = param2, // Jump to 527, // label, if (_loc_12.ishape == null) goto 484, _loc_12 = _loc_12.ishape.body, // Jump to 527, if (_loc_12.icompound == null) goto 514, _loc_12 = _loc_12.icompound.compound, // Jump to 527, _loc_12 = _loc_12.ibody.compound, if (_loc_12 == null) goto 550, if (_loc_12.group == null) goto 453, if (!(_loc_12 == null)) goto 577, _loc_13 = null, // Jump to 587, _loc_13 = _loc_12.group, _loc_13 == null ? (false) : (_loc_14 = false, // Jump to 669, // label, if (!(_loc_11 == _loc_13)) goto 631, _loc_14 = _loc_11.ignore, // Jump to 694, if (!(_loc_11.depth < _loc_13.depth)) goto 659, _loc_13 = _loc_13.group, // Jump to 669, _loc_11 = _loc_11.group, if (_loc_11 == null) goto 690, if (_loc_13 != null) goto 610, _loc_14))) ? (if (param1.sensorEnabled) goto 718, if (!param2.sensorEnabled) goto 777, _loc_15 = param1.filter, _loc_16 = param2.filter, if ((_loc_15.sensorMask & _loc_16.sensorGroup) == 0) goto 776, (_loc_16.sensorMask & _loc_15.sensorGroup) != 0 ? (2) : (if (param1.fluidEnabled) goto 804, if (!param2.fluidEnabled) goto 863, _loc_15 = param1.filter, _loc_16 = param2.filter, if ((_loc_15.fluidMask & _loc_16.fluidGroup) == 0) goto 862, if (!((_loc_16.fluidMask & _loc_15.fluidGroup) != 0)) goto 922, if (!(_loc_6.imass == 0)) goto 892, if (!(_loc_7.imass == 0)) goto 906, if (!(_loc_6.iinertia == 0)) goto 920, _loc_7.iinertia != 0 ? (0) : (_loc_15 = param1.filter, _loc_16 = param2.filter, if ((_loc_15.collisionMask & _loc_16.collisionGroup) == 0) goto 986, if (!((_loc_16.collisionMask & _loc_15.collisionGroup) != 0)) goto 1045, if (!(_loc_6.imass == 0)) goto 1015, if (!(_loc_7.imass == 0)) goto 1029, if (!(_loc_6.iinertia == 0)) goto 1043, _loc_7.iinertia != 0 ? (1) : (-1)))) : (-1)) <= 0)
            {
                return param4;
            }
            _loc_6 = param1.body;
            _loc_7 = param2.body;
            if (!param3)
            {
            }
            if (!_loc_6.bullet)
            {
            }
            if (_loc_7.bullet)
            {
                if (ZPP_ToiEvent.zpp_pool == null)
                {
                    _loc_17 = new ZPP_ToiEvent();
                }
                else
                {
                    _loc_17 = ZPP_ToiEvent.zpp_pool;
                    ZPP_ToiEvent.zpp_pool = _loc_17.next;
                    _loc_17.next = null;
                }
                _loc_17.failed = false;
                _loc_18 = null;
                _loc_17.s2 = _loc_18;
                _loc_17.s1 = _loc_18;
                _loc_17.arbiter = null;
                if (_loc_6.type != ZPP_Flags.id_BodyType_KINEMATIC)
                {
                }
                _loc_8 = _loc_7.type == ZPP_Flags.id_BodyType_KINEMATIC;
                if (param3)
                {
                }
                if (!_loc_8)
                {
                    if (param1.body.type != ZPP_Flags.id_BodyType_DYNAMIC)
                    {
                        _loc_17.s2 = param1;
                        _loc_17.s1 = param2;
                    }
                    else
                    {
                        _loc_17.s1 = param1;
                        _loc_17.s2 = param2;
                    }
                    _loc_17.kinematic = false;
                    ZPP_SweepDistance.staticSweep(_loc_17, pre_dt, 0, Config.collisionSlopCCD);
                }
                else
                {
                    _loc_17.s1 = param1;
                    _loc_17.s2 = param2;
                    _loc_17.kinematic = _loc_8;
                    if (!_loc_17.s1.body.sweepFrozen)
                    {
                    }
                    if (_loc_17.s2.body.sweepFrozen)
                    {
                        if (_loc_17.s1.body.sweepFrozen)
                        {
                            _loc_18 = _loc_17.s1;
                            _loc_17.s1 = _loc_17.s2;
                            _loc_17.s2 = _loc_18;
                            _loc_17.frozen1 = false;
                            _loc_17.frozen2 = true;
                        }
                        ZPP_SweepDistance.staticSweep(_loc_17, pre_dt, 0, Config.collisionSlopCCD);
                    }
                    else
                    {
                        ZPP_SweepDistance.dynamicSweep(_loc_17, pre_dt, 0, Config.collisionSlopCCD);
                    }
                }
                if (param3)
                {
                }
                if (_loc_17.toi >= 0)
                {
                }
                if (_loc_17.failed)
                {
                    _loc_19 = _loc_17;
                    _loc_19.next = ZPP_ToiEvent.zpp_pool;
                    ZPP_ToiEvent.zpp_pool = _loc_19;
                }
                else
                {
                    toiEvents.add(_loc_17);
                    _loc_17.frozen1 = _loc_17.s1.body.sweepFrozen;
                    _loc_17.frozen2 = _loc_17.s2.body.sweepFrozen;
                    if (param4 != null)
                    {
                        _loc_17.arbiter = param4.colarb;
                    }
                    else
                    {
                        _loc_17.arbiter = null;
                    }
                }
            }
            return param4;
        }// end function

        public function continuousCollisions(param1:Number) : void
        {
            var _loc_4:* = null as ZPP_ToiEvent;
            var _loc_5:* = NaN;
            var _loc_6:* = false;
            var _loc_7:* = null as ZNPNode_ZPP_ToiEvent;
            var _loc_8:* = null as ZNPNode_ZPP_ToiEvent;
            var _loc_9:* = null as ZNPNode_ZPP_ToiEvent;
            var _loc_10:* = null as ZPP_ToiEvent;
            var _loc_11:* = null as ZPP_Body;
            var _loc_12:* = null as ZPP_Body;
            var _loc_13:* = null as ZPP_ToiEvent;
            var _loc_14:* = null as ZPP_Shape;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = null as ZPP_Polygon;
            var _loc_23:* = null as ZPP_Vec2;
            var _loc_24:* = null as ZPP_Vec2;
            var _loc_25:* = null as ZPP_Vec2;
            var _loc_26:* = null as ZPP_Vec2;
            var _loc_27:* = null as ZNPNode_ZPP_Edge;
            var _loc_28:* = null as ZPP_Edge;
            var _loc_29:* = false;
            var _loc_30:* = null as ZPP_Arbiter;
            var _loc_31:* = null as ZPP_ColArbiter;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = NaN;
            var _loc_40:* = NaN;
            var _loc_41:* = NaN;
            var _loc_2:* = 2 * Math.PI / param1;
            bphase.broadphase(this, false);
            var _loc_3:* = 0;
            do
            {
                
                _loc_4 = null;
                _loc_5 = 2;
                _loc_6 = false;
                _loc_7 = null;
                _loc_8 = null;
                _loc_9 = toiEvents.head;
                while (_loc_9 != null)
                {
                    
                    _loc_10 = _loc_9.elt;
                    _loc_11 = _loc_10.s1.body;
                    _loc_12 = _loc_10.s2.body;
                    if (_loc_11.sweepFrozen)
                    {
                    }
                    if (_loc_12.sweepFrozen)
                    {
                        if (_loc_10.toi != 0)
                        {
                        }
                        if (ZPP_Collide.testCollide_safe(_loc_10.s1, _loc_10.s2))
                        {
                            _loc_10.toi = 0;
                        }
                        else
                        {
                            _loc_9 = toiEvents.erase(_loc_8);
                            _loc_13 = _loc_10;
                            _loc_13.next = ZPP_ToiEvent.zpp_pool;
                            ZPP_ToiEvent.zpp_pool = _loc_13;
                            continue;
                        }
                    }
                    if (_loc_10.frozen1 == _loc_11.sweepFrozen)
                    {
                    }
                    if (_loc_10.frozen2 != _loc_12.sweepFrozen)
                    {
                        if (!_loc_10.kinematic)
                        {
                            _loc_10.frozen1 = _loc_11.sweepFrozen;
                            _loc_10.frozen2 = _loc_12.sweepFrozen;
                            if (_loc_10.frozen1)
                            {
                                _loc_14 = _loc_10.s1;
                                _loc_10.s1 = _loc_10.s2;
                                _loc_10.s2 = _loc_14;
                                _loc_10.frozen1 = false;
                                _loc_10.frozen2 = true;
                            }
                            ZPP_SweepDistance.staticSweep(_loc_10, param1, 0, Config.collisionSlopCCD);
                            if (_loc_10.toi < 0)
                            {
                                _loc_9 = toiEvents.erase(_loc_8);
                                _loc_13 = _loc_10;
                                _loc_13.next = ZPP_ToiEvent.zpp_pool;
                                ZPP_ToiEvent.zpp_pool = _loc_13;
                                continue;
                            }
                        }
                        else
                        {
                            _loc_9 = toiEvents.erase(_loc_8);
                            _loc_13 = _loc_10;
                            _loc_13.next = ZPP_ToiEvent.zpp_pool;
                            ZPP_ToiEvent.zpp_pool = _loc_13;
                            continue;
                        }
                    }
                    if (_loc_10.toi >= 0)
                    {
                        if (_loc_10.toi >= _loc_5)
                        {
                            if (!_loc_6)
                            {
                            }
                        }
                    }
                    if (_loc_10.kinematic)
                    {
                        _loc_4 = _loc_10;
                        _loc_5 = _loc_10.toi;
                        _loc_6 = _loc_10.kinematic;
                        _loc_7 = _loc_8;
                    }
                    _loc_8 = _loc_9;
                    _loc_9 = _loc_9.next;
                }
                if (_loc_4 == null)
                {
                    break;
                }
                toiEvents.erase(_loc_7);
                _loc_3 = _loc_4.toi;
                _loc_11 = _loc_4.s1.body;
                _loc_12 = _loc_4.s2.body;
                if (!_loc_11.sweepFrozen)
                {
                    _loc_15 = _loc_3 * param1;
                    _loc_16 = _loc_15 - _loc_11.sweepTime;
                    if (_loc_16 != 0)
                    {
                        _loc_11.sweepTime = _loc_15;
                        _loc_17 = _loc_16;
                        _loc_11.posx = _loc_11.posx + _loc_11.velx * _loc_17;
                        _loc_11.posy = _loc_11.posy + _loc_11.vely * _loc_17;
                        if (_loc_11.angvel != 0)
                        {
                            _loc_17 = _loc_11.sweep_angvel * _loc_16;
                            _loc_11.rot = _loc_11.rot + _loc_17;
                            if (_loc_17 * _loc_17 > 0.0001)
                            {
                                _loc_11.axisx = Math.sin(_loc_11.rot);
                                _loc_11.axisy = Math.cos(_loc_11.rot);
                            }
                            else
                            {
                                _loc_18 = _loc_17 * _loc_17;
                                _loc_19 = 1 - 0.5 * _loc_18;
                                _loc_20 = 1 - _loc_18 * _loc_18 / 8;
                                _loc_21 = (_loc_19 * _loc_11.axisx + _loc_17 * _loc_11.axisy) * _loc_20;
                                _loc_11.axisy = (_loc_19 * _loc_11.axisy - _loc_17 * _loc_11.axisx) * _loc_20;
                                _loc_11.axisx = _loc_21;
                            }
                        }
                    }
                    _loc_14 = _loc_4.s1;
                    if (_loc_14.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_14.worldCOMx = _loc_11.posx + (_loc_11.axisy * _loc_14.localCOMx - _loc_11.axisx * _loc_14.localCOMy);
                        _loc_14.worldCOMy = _loc_11.posy + (_loc_14.localCOMx * _loc_11.axisx + _loc_14.localCOMy * _loc_11.axisy);
                    }
                    else
                    {
                        _loc_22 = _loc_14.polygon;
                        _loc_23 = _loc_22.lverts.next;
                        _loc_24 = _loc_22.gverts.next;
                        while (_loc_24 != null)
                        {
                            
                            _loc_25 = _loc_24;
                            _loc_26 = _loc_23;
                            _loc_23 = _loc_23.next;
                            _loc_25.x = _loc_11.posx + (_loc_11.axisy * _loc_26.x - _loc_11.axisx * _loc_26.y);
                            _loc_25.y = _loc_11.posy + (_loc_26.x * _loc_11.axisx + _loc_26.y * _loc_11.axisy);
                            _loc_24 = _loc_24.next;
                        }
                        _loc_27 = _loc_22.edges.head;
                        _loc_24 = _loc_22.gverts.next;
                        _loc_25 = _loc_24;
                        _loc_24 = _loc_24.next;
                        while (_loc_24 != null)
                        {
                            
                            _loc_26 = _loc_24;
                            _loc_28 = _loc_27.elt;
                            _loc_27 = _loc_27.next;
                            _loc_28.gnormx = _loc_11.axisy * _loc_28.lnormx - _loc_11.axisx * _loc_28.lnormy;
                            _loc_28.gnormy = _loc_28.lnormx * _loc_11.axisx + _loc_28.lnormy * _loc_11.axisy;
                            _loc_28.gprojection = _loc_11.posx * _loc_28.gnormx + _loc_11.posy * _loc_28.gnormy + _loc_28.lprojection;
                            _loc_28.tp0 = _loc_25.y * _loc_28.gnormx - _loc_25.x * _loc_28.gnormy;
                            _loc_28.tp1 = _loc_26.y * _loc_28.gnormx - _loc_26.x * _loc_28.gnormy;
                            _loc_25 = _loc_26;
                            _loc_24 = _loc_24.next;
                        }
                        _loc_26 = _loc_22.gverts.next;
                        _loc_28 = _loc_27.elt;
                        _loc_27 = _loc_27.next;
                        _loc_28.gnormx = _loc_11.axisy * _loc_28.lnormx - _loc_11.axisx * _loc_28.lnormy;
                        _loc_28.gnormy = _loc_28.lnormx * _loc_11.axisx + _loc_28.lnormy * _loc_11.axisy;
                        _loc_28.gprojection = _loc_11.posx * _loc_28.gnormx + _loc_11.posy * _loc_28.gnormy + _loc_28.lprojection;
                        _loc_28.tp0 = _loc_25.y * _loc_28.gnormx - _loc_25.x * _loc_28.gnormy;
                        _loc_28.tp1 = _loc_26.y * _loc_28.gnormx - _loc_26.x * _loc_28.gnormy;
                    }
                }
                if (!_loc_12.sweepFrozen)
                {
                    _loc_15 = _loc_3 * param1;
                    _loc_16 = _loc_15 - _loc_12.sweepTime;
                    if (_loc_16 != 0)
                    {
                        _loc_12.sweepTime = _loc_15;
                        _loc_17 = _loc_16;
                        _loc_12.posx = _loc_12.posx + _loc_12.velx * _loc_17;
                        _loc_12.posy = _loc_12.posy + _loc_12.vely * _loc_17;
                        if (_loc_12.angvel != 0)
                        {
                            _loc_17 = _loc_12.sweep_angvel * _loc_16;
                            _loc_12.rot = _loc_12.rot + _loc_17;
                            if (_loc_17 * _loc_17 > 0.0001)
                            {
                                _loc_12.axisx = Math.sin(_loc_12.rot);
                                _loc_12.axisy = Math.cos(_loc_12.rot);
                            }
                            else
                            {
                                _loc_18 = _loc_17 * _loc_17;
                                _loc_19 = 1 - 0.5 * _loc_18;
                                _loc_20 = 1 - _loc_18 * _loc_18 / 8;
                                _loc_21 = (_loc_19 * _loc_12.axisx + _loc_17 * _loc_12.axisy) * _loc_20;
                                _loc_12.axisy = (_loc_19 * _loc_12.axisy - _loc_17 * _loc_12.axisx) * _loc_20;
                                _loc_12.axisx = _loc_21;
                            }
                        }
                    }
                    _loc_14 = _loc_4.s2;
                    if (_loc_14.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_14.worldCOMx = _loc_12.posx + (_loc_12.axisy * _loc_14.localCOMx - _loc_12.axisx * _loc_14.localCOMy);
                        _loc_14.worldCOMy = _loc_12.posy + (_loc_14.localCOMx * _loc_12.axisx + _loc_14.localCOMy * _loc_12.axisy);
                    }
                    else
                    {
                        _loc_22 = _loc_14.polygon;
                        _loc_23 = _loc_22.lverts.next;
                        _loc_24 = _loc_22.gverts.next;
                        while (_loc_24 != null)
                        {
                            
                            _loc_25 = _loc_24;
                            _loc_26 = _loc_23;
                            _loc_23 = _loc_23.next;
                            _loc_25.x = _loc_12.posx + (_loc_12.axisy * _loc_26.x - _loc_12.axisx * _loc_26.y);
                            _loc_25.y = _loc_12.posy + (_loc_26.x * _loc_12.axisx + _loc_26.y * _loc_12.axisy);
                            _loc_24 = _loc_24.next;
                        }
                        _loc_27 = _loc_22.edges.head;
                        _loc_24 = _loc_22.gverts.next;
                        _loc_25 = _loc_24;
                        _loc_24 = _loc_24.next;
                        while (_loc_24 != null)
                        {
                            
                            _loc_26 = _loc_24;
                            _loc_28 = _loc_27.elt;
                            _loc_27 = _loc_27.next;
                            _loc_28.gnormx = _loc_12.axisy * _loc_28.lnormx - _loc_12.axisx * _loc_28.lnormy;
                            _loc_28.gnormy = _loc_28.lnormx * _loc_12.axisx + _loc_28.lnormy * _loc_12.axisy;
                            _loc_28.gprojection = _loc_12.posx * _loc_28.gnormx + _loc_12.posy * _loc_28.gnormy + _loc_28.lprojection;
                            _loc_28.tp0 = _loc_25.y * _loc_28.gnormx - _loc_25.x * _loc_28.gnormy;
                            _loc_28.tp1 = _loc_26.y * _loc_28.gnormx - _loc_26.x * _loc_28.gnormy;
                            _loc_25 = _loc_26;
                            _loc_24 = _loc_24.next;
                        }
                        _loc_26 = _loc_22.gverts.next;
                        _loc_28 = _loc_27.elt;
                        _loc_27 = _loc_27.next;
                        _loc_28.gnormx = _loc_12.axisy * _loc_28.lnormx - _loc_12.axisx * _loc_28.lnormy;
                        _loc_28.gnormy = _loc_28.lnormx * _loc_12.axisx + _loc_28.lnormy * _loc_12.axisy;
                        _loc_28.gprojection = _loc_12.posx * _loc_28.gnormx + _loc_12.posy * _loc_28.gnormy + _loc_28.lprojection;
                        _loc_28.tp0 = _loc_25.y * _loc_28.gnormx - _loc_25.x * _loc_28.gnormy;
                        _loc_28.tp1 = _loc_26.y * _loc_28.gnormx - _loc_26.x * _loc_28.gnormy;
                    }
                }
                _loc_29 = _loc_4.arbiter == null;
                _loc_30 = narrowPhase(_loc_4.s1, _loc_4.s2, true, _loc_4.arbiter, true);
                if (_loc_30 == null)
                {
                    if (_loc_4.arbiter != null)
                    {
                    }
                    if (_loc_4.arbiter.pair != null)
                    {
                        _loc_4.arbiter.pair.arb = null;
                        _loc_4.arbiter.pair = null;
                    }
                }
                else if (!presteparb(_loc_30, param1, true))
                {
                    if (_loc_30.type == ZPP_Arbiter.COL)
                    {
                        if (_loc_30.active)
                        {
                        }
                    }
                    if ((_loc_30.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                    {
                        _loc_31 = _loc_30.colarb;
                        _loc_15 = _loc_31.nx * _loc_31.c1.jnAcc - _loc_31.ny * _loc_31.c1.jtAcc;
                        _loc_16 = _loc_31.ny * _loc_31.c1.jnAcc + _loc_31.nx * _loc_31.c1.jtAcc;
                        _loc_17 = _loc_31.b1.imass;
                        _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_17;
                        _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_17;
                        _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.b1.iinertia * (_loc_16 * _loc_31.c1.r1x - _loc_15 * _loc_31.c1.r1y);
                        _loc_17 = _loc_31.b2.imass;
                        _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_17;
                        _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_17;
                        _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.b2.iinertia * (_loc_16 * _loc_31.c1.r2x - _loc_15 * _loc_31.c1.r2y);
                        if (_loc_31.hc2)
                        {
                            _loc_15 = _loc_31.nx * _loc_31.c2.jnAcc - _loc_31.ny * _loc_31.c2.jtAcc;
                            _loc_16 = _loc_31.ny * _loc_31.c2.jnAcc + _loc_31.nx * _loc_31.c2.jtAcc;
                            _loc_17 = _loc_31.b1.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_17;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_17;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.b1.iinertia * (_loc_16 * _loc_31.c2.r1x - _loc_15 * _loc_31.c2.r1y);
                            _loc_17 = _loc_31.b2.imass;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_17;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_17;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.b2.iinertia * (_loc_16 * _loc_31.c2.r2x - _loc_15 * _loc_31.c2.r2y);
                        }
                        _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.jrAcc * _loc_31.b2.iinertia;
                        _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.jrAcc * _loc_31.b1.iinertia;
                        _loc_31 = _loc_30.colarb;
                        _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                        _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                        _loc_17 = (_loc_32 * _loc_31.nx - _loc_21 * _loc_31.ny + _loc_31.surfacex) * _loc_31.c1.tMass;
                        _loc_18 = _loc_31.c1.friction * _loc_31.c1.jnAcc;
                        _loc_19 = _loc_31.c1.jtAcc;
                        _loc_20 = _loc_19 - _loc_17;
                        if (_loc_20 > _loc_18)
                        {
                            _loc_20 = _loc_18;
                        }
                        else if (_loc_20 < -_loc_18)
                        {
                            _loc_20 = -_loc_18;
                        }
                        _loc_17 = _loc_20 - _loc_19;
                        _loc_31.c1.jtAcc = _loc_20;
                        _loc_15 = (-_loc_31.ny) * _loc_17;
                        _loc_16 = _loc_31.nx * _loc_17;
                        _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                        _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                        _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                        _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                        _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rt1b * _loc_17 * _loc_31.b2.iinertia;
                        _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rt1a * _loc_17 * _loc_31.b1.iinertia;
                        if (_loc_31.hc2)
                        {
                            _loc_33 = _loc_31.k2x + _loc_31.b2.velx - _loc_31.c2.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c2.r1y * _loc_31.b1.angvel);
                            _loc_34 = _loc_31.k2y + _loc_31.b2.vely + _loc_31.c2.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c2.r1x * _loc_31.b1.angvel);
                            _loc_17 = (_loc_34 * _loc_31.nx - _loc_33 * _loc_31.ny + _loc_31.surfacex) * _loc_31.c2.tMass;
                            _loc_18 = _loc_31.c2.friction * _loc_31.c2.jnAcc;
                            _loc_19 = _loc_31.c2.jtAcc;
                            _loc_20 = _loc_19 - _loc_17;
                            if (_loc_20 > _loc_18)
                            {
                                _loc_20 = _loc_18;
                            }
                            else if (_loc_20 < -_loc_18)
                            {
                                _loc_20 = -_loc_18;
                            }
                            _loc_17 = _loc_20 - _loc_19;
                            _loc_31.c2.jtAcc = _loc_20;
                            _loc_15 = (-_loc_31.ny) * _loc_17;
                            _loc_16 = _loc_31.nx * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rt2b * _loc_17 * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rt2a * _loc_17 * _loc_31.b1.iinertia;
                            _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                            _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                            _loc_33 = _loc_31.k2x + _loc_31.b2.velx - _loc_31.c2.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c2.r1y * _loc_31.b1.angvel);
                            _loc_34 = _loc_31.k2y + _loc_31.b2.vely + _loc_31.c2.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c2.r1x * _loc_31.b1.angvel);
                            _loc_35 = _loc_31.c1.jnAcc;
                            _loc_36 = _loc_31.c2.jnAcc;
                            _loc_37 = _loc_21 * _loc_31.nx + _loc_32 * _loc_31.ny + _loc_31.surfacey + _loc_31.c1.bounce - (_loc_31.Ka * _loc_35 + _loc_31.Kb * _loc_36);
                            _loc_38 = _loc_33 * _loc_31.nx + _loc_34 * _loc_31.ny + _loc_31.surfacey + _loc_31.c2.bounce - (_loc_31.Kb * _loc_35 + _loc_31.Kc * _loc_36);
                            _loc_39 = -(_loc_31.kMassa * _loc_37 + _loc_31.kMassb * _loc_38);
                            _loc_40 = -(_loc_31.kMassb * _loc_37 + _loc_31.kMassc * _loc_38);
                            if (_loc_39 >= 0)
                            {
                            }
                            if (_loc_40 >= 0)
                            {
                                _loc_37 = _loc_39 - _loc_35;
                                _loc_38 = _loc_40 - _loc_36;
                                _loc_31.c1.jnAcc = _loc_39;
                                _loc_31.c2.jnAcc = _loc_40;
                            }
                            else
                            {
                                _loc_39 = (-_loc_31.c1.nMass) * _loc_37;
                                if (_loc_39 >= 0)
                                {
                                }
                                if (_loc_31.Kb * _loc_39 + _loc_38 >= 0)
                                {
                                    _loc_37 = _loc_39 - _loc_35;
                                    _loc_38 = -_loc_36;
                                    _loc_31.c1.jnAcc = _loc_39;
                                    _loc_31.c2.jnAcc = 0;
                                }
                                else
                                {
                                    _loc_40 = (-_loc_31.c2.nMass) * _loc_38;
                                    if (_loc_40 >= 0)
                                    {
                                    }
                                    if (_loc_31.Kb * _loc_40 + _loc_37 >= 0)
                                    {
                                        _loc_37 = -_loc_35;
                                        _loc_38 = _loc_40 - _loc_36;
                                        _loc_31.c1.jnAcc = 0;
                                        _loc_31.c2.jnAcc = _loc_40;
                                    }
                                    else
                                    {
                                        if (_loc_37 >= 0)
                                        {
                                        }
                                        if (_loc_38 >= 0)
                                        {
                                            _loc_37 = -_loc_35;
                                            _loc_38 = -_loc_36;
                                            _loc_41 = 0;
                                            _loc_31.c2.jnAcc = _loc_41;
                                            _loc_31.c1.jnAcc = _loc_41;
                                        }
                                        else
                                        {
                                            _loc_37 = 0;
                                            _loc_38 = 0;
                                        }
                                    }
                                }
                            }
                            _loc_17 = _loc_37 + _loc_38;
                            _loc_15 = _loc_31.nx * _loc_17;
                            _loc_16 = _loc_31.ny * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + (_loc_31.rn1b * _loc_37 + _loc_31.rn2b * _loc_38) * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - (_loc_31.rn1a * _loc_37 + _loc_31.rn2a * _loc_38) * _loc_31.b1.iinertia;
                        }
                        else
                        {
                            if (_loc_31.radius != 0)
                            {
                                _loc_33 = _loc_31.b2.angvel - _loc_31.b1.angvel;
                                _loc_17 = _loc_33 * _loc_31.rMass;
                                _loc_18 = _loc_31.rfric * _loc_31.c1.jnAcc;
                                _loc_19 = _loc_31.jrAcc;
                                _loc_31.jrAcc = _loc_31.jrAcc - _loc_17;
                                if (_loc_31.jrAcc > _loc_18)
                                {
                                    _loc_31.jrAcc = _loc_18;
                                }
                                else if (_loc_31.jrAcc < -_loc_18)
                                {
                                    _loc_31.jrAcc = -_loc_18;
                                }
                                _loc_17 = _loc_31.jrAcc - _loc_19;
                                _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_17 * _loc_31.b2.iinertia;
                                _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_17 * _loc_31.b1.iinertia;
                            }
                            _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                            _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                            _loc_17 = (_loc_31.c1.bounce + (_loc_31.nx * _loc_21 + _loc_31.ny * _loc_32) + _loc_31.surfacey) * _loc_31.c1.nMass;
                            _loc_19 = _loc_31.c1.jnAcc;
                            _loc_20 = _loc_19 - _loc_17;
                            if (_loc_20 < 0)
                            {
                                _loc_20 = 0;
                            }
                            _loc_17 = _loc_20 - _loc_19;
                            _loc_31.c1.jnAcc = _loc_20;
                            _loc_15 = _loc_31.nx * _loc_17;
                            _loc_16 = _loc_31.ny * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rn1b * _loc_17 * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rn1a * _loc_17 * _loc_31.b1.iinertia;
                        }
                        _loc_31 = _loc_30.colarb;
                        _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                        _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                        _loc_17 = (_loc_32 * _loc_31.nx - _loc_21 * _loc_31.ny + _loc_31.surfacex) * _loc_31.c1.tMass;
                        _loc_18 = _loc_31.c1.friction * _loc_31.c1.jnAcc;
                        _loc_19 = _loc_31.c1.jtAcc;
                        _loc_20 = _loc_19 - _loc_17;
                        if (_loc_20 > _loc_18)
                        {
                            _loc_20 = _loc_18;
                        }
                        else if (_loc_20 < -_loc_18)
                        {
                            _loc_20 = -_loc_18;
                        }
                        _loc_17 = _loc_20 - _loc_19;
                        _loc_31.c1.jtAcc = _loc_20;
                        _loc_15 = (-_loc_31.ny) * _loc_17;
                        _loc_16 = _loc_31.nx * _loc_17;
                        _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                        _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                        _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                        _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                        _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rt1b * _loc_17 * _loc_31.b2.iinertia;
                        _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rt1a * _loc_17 * _loc_31.b1.iinertia;
                        if (_loc_31.hc2)
                        {
                            _loc_33 = _loc_31.k2x + _loc_31.b2.velx - _loc_31.c2.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c2.r1y * _loc_31.b1.angvel);
                            _loc_34 = _loc_31.k2y + _loc_31.b2.vely + _loc_31.c2.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c2.r1x * _loc_31.b1.angvel);
                            _loc_17 = (_loc_34 * _loc_31.nx - _loc_33 * _loc_31.ny + _loc_31.surfacex) * _loc_31.c2.tMass;
                            _loc_18 = _loc_31.c2.friction * _loc_31.c2.jnAcc;
                            _loc_19 = _loc_31.c2.jtAcc;
                            _loc_20 = _loc_19 - _loc_17;
                            if (_loc_20 > _loc_18)
                            {
                                _loc_20 = _loc_18;
                            }
                            else if (_loc_20 < -_loc_18)
                            {
                                _loc_20 = -_loc_18;
                            }
                            _loc_17 = _loc_20 - _loc_19;
                            _loc_31.c2.jtAcc = _loc_20;
                            _loc_15 = (-_loc_31.ny) * _loc_17;
                            _loc_16 = _loc_31.nx * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rt2b * _loc_17 * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rt2a * _loc_17 * _loc_31.b1.iinertia;
                            _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                            _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                            _loc_33 = _loc_31.k2x + _loc_31.b2.velx - _loc_31.c2.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c2.r1y * _loc_31.b1.angvel);
                            _loc_34 = _loc_31.k2y + _loc_31.b2.vely + _loc_31.c2.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c2.r1x * _loc_31.b1.angvel);
                            _loc_35 = _loc_31.c1.jnAcc;
                            _loc_36 = _loc_31.c2.jnAcc;
                            _loc_37 = _loc_21 * _loc_31.nx + _loc_32 * _loc_31.ny + _loc_31.surfacey + _loc_31.c1.bounce - (_loc_31.Ka * _loc_35 + _loc_31.Kb * _loc_36);
                            _loc_38 = _loc_33 * _loc_31.nx + _loc_34 * _loc_31.ny + _loc_31.surfacey + _loc_31.c2.bounce - (_loc_31.Kb * _loc_35 + _loc_31.Kc * _loc_36);
                            _loc_39 = -(_loc_31.kMassa * _loc_37 + _loc_31.kMassb * _loc_38);
                            _loc_40 = -(_loc_31.kMassb * _loc_37 + _loc_31.kMassc * _loc_38);
                            if (_loc_39 >= 0)
                            {
                            }
                            if (_loc_40 >= 0)
                            {
                                _loc_37 = _loc_39 - _loc_35;
                                _loc_38 = _loc_40 - _loc_36;
                                _loc_31.c1.jnAcc = _loc_39;
                                _loc_31.c2.jnAcc = _loc_40;
                            }
                            else
                            {
                                _loc_39 = (-_loc_31.c1.nMass) * _loc_37;
                                if (_loc_39 >= 0)
                                {
                                }
                                if (_loc_31.Kb * _loc_39 + _loc_38 >= 0)
                                {
                                    _loc_37 = _loc_39 - _loc_35;
                                    _loc_38 = -_loc_36;
                                    _loc_31.c1.jnAcc = _loc_39;
                                    _loc_31.c2.jnAcc = 0;
                                }
                                else
                                {
                                    _loc_40 = (-_loc_31.c2.nMass) * _loc_38;
                                    if (_loc_40 >= 0)
                                    {
                                    }
                                    if (_loc_31.Kb * _loc_40 + _loc_37 >= 0)
                                    {
                                        _loc_37 = -_loc_35;
                                        _loc_38 = _loc_40 - _loc_36;
                                        _loc_31.c1.jnAcc = 0;
                                        _loc_31.c2.jnAcc = _loc_40;
                                    }
                                    else
                                    {
                                        if (_loc_37 >= 0)
                                        {
                                        }
                                        if (_loc_38 >= 0)
                                        {
                                            _loc_37 = -_loc_35;
                                            _loc_38 = -_loc_36;
                                            _loc_41 = 0;
                                            _loc_31.c2.jnAcc = _loc_41;
                                            _loc_31.c1.jnAcc = _loc_41;
                                        }
                                        else
                                        {
                                            _loc_37 = 0;
                                            _loc_38 = 0;
                                        }
                                    }
                                }
                            }
                            _loc_17 = _loc_37 + _loc_38;
                            _loc_15 = _loc_31.nx * _loc_17;
                            _loc_16 = _loc_31.ny * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + (_loc_31.rn1b * _loc_37 + _loc_31.rn2b * _loc_38) * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - (_loc_31.rn1a * _loc_37 + _loc_31.rn2a * _loc_38) * _loc_31.b1.iinertia;
                        }
                        else
                        {
                            if (_loc_31.radius != 0)
                            {
                                _loc_33 = _loc_31.b2.angvel - _loc_31.b1.angvel;
                                _loc_17 = _loc_33 * _loc_31.rMass;
                                _loc_18 = _loc_31.rfric * _loc_31.c1.jnAcc;
                                _loc_19 = _loc_31.jrAcc;
                                _loc_31.jrAcc = _loc_31.jrAcc - _loc_17;
                                if (_loc_31.jrAcc > _loc_18)
                                {
                                    _loc_31.jrAcc = _loc_18;
                                }
                                else if (_loc_31.jrAcc < -_loc_18)
                                {
                                    _loc_31.jrAcc = -_loc_18;
                                }
                                _loc_17 = _loc_31.jrAcc - _loc_19;
                                _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_17 * _loc_31.b2.iinertia;
                                _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_17 * _loc_31.b1.iinertia;
                            }
                            _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                            _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                            _loc_17 = (_loc_31.c1.bounce + (_loc_31.nx * _loc_21 + _loc_31.ny * _loc_32) + _loc_31.surfacey) * _loc_31.c1.nMass;
                            _loc_19 = _loc_31.c1.jnAcc;
                            _loc_20 = _loc_19 - _loc_17;
                            if (_loc_20 < 0)
                            {
                                _loc_20 = 0;
                            }
                            _loc_17 = _loc_20 - _loc_19;
                            _loc_31.c1.jnAcc = _loc_20;
                            _loc_15 = _loc_31.nx * _loc_17;
                            _loc_16 = _loc_31.ny * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rn1b * _loc_17 * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rn1a * _loc_17 * _loc_31.b1.iinertia;
                        }
                        _loc_31 = _loc_30.colarb;
                        _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                        _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                        _loc_17 = (_loc_32 * _loc_31.nx - _loc_21 * _loc_31.ny + _loc_31.surfacex) * _loc_31.c1.tMass;
                        _loc_18 = _loc_31.c1.friction * _loc_31.c1.jnAcc;
                        _loc_19 = _loc_31.c1.jtAcc;
                        _loc_20 = _loc_19 - _loc_17;
                        if (_loc_20 > _loc_18)
                        {
                            _loc_20 = _loc_18;
                        }
                        else if (_loc_20 < -_loc_18)
                        {
                            _loc_20 = -_loc_18;
                        }
                        _loc_17 = _loc_20 - _loc_19;
                        _loc_31.c1.jtAcc = _loc_20;
                        _loc_15 = (-_loc_31.ny) * _loc_17;
                        _loc_16 = _loc_31.nx * _loc_17;
                        _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                        _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                        _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                        _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                        _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rt1b * _loc_17 * _loc_31.b2.iinertia;
                        _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rt1a * _loc_17 * _loc_31.b1.iinertia;
                        if (_loc_31.hc2)
                        {
                            _loc_33 = _loc_31.k2x + _loc_31.b2.velx - _loc_31.c2.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c2.r1y * _loc_31.b1.angvel);
                            _loc_34 = _loc_31.k2y + _loc_31.b2.vely + _loc_31.c2.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c2.r1x * _loc_31.b1.angvel);
                            _loc_17 = (_loc_34 * _loc_31.nx - _loc_33 * _loc_31.ny + _loc_31.surfacex) * _loc_31.c2.tMass;
                            _loc_18 = _loc_31.c2.friction * _loc_31.c2.jnAcc;
                            _loc_19 = _loc_31.c2.jtAcc;
                            _loc_20 = _loc_19 - _loc_17;
                            if (_loc_20 > _loc_18)
                            {
                                _loc_20 = _loc_18;
                            }
                            else if (_loc_20 < -_loc_18)
                            {
                                _loc_20 = -_loc_18;
                            }
                            _loc_17 = _loc_20 - _loc_19;
                            _loc_31.c2.jtAcc = _loc_20;
                            _loc_15 = (-_loc_31.ny) * _loc_17;
                            _loc_16 = _loc_31.nx * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rt2b * _loc_17 * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rt2a * _loc_17 * _loc_31.b1.iinertia;
                            _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                            _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                            _loc_33 = _loc_31.k2x + _loc_31.b2.velx - _loc_31.c2.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c2.r1y * _loc_31.b1.angvel);
                            _loc_34 = _loc_31.k2y + _loc_31.b2.vely + _loc_31.c2.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c2.r1x * _loc_31.b1.angvel);
                            _loc_35 = _loc_31.c1.jnAcc;
                            _loc_36 = _loc_31.c2.jnAcc;
                            _loc_37 = _loc_21 * _loc_31.nx + _loc_32 * _loc_31.ny + _loc_31.surfacey + _loc_31.c1.bounce - (_loc_31.Ka * _loc_35 + _loc_31.Kb * _loc_36);
                            _loc_38 = _loc_33 * _loc_31.nx + _loc_34 * _loc_31.ny + _loc_31.surfacey + _loc_31.c2.bounce - (_loc_31.Kb * _loc_35 + _loc_31.Kc * _loc_36);
                            _loc_39 = -(_loc_31.kMassa * _loc_37 + _loc_31.kMassb * _loc_38);
                            _loc_40 = -(_loc_31.kMassb * _loc_37 + _loc_31.kMassc * _loc_38);
                            if (_loc_39 >= 0)
                            {
                            }
                            if (_loc_40 >= 0)
                            {
                                _loc_37 = _loc_39 - _loc_35;
                                _loc_38 = _loc_40 - _loc_36;
                                _loc_31.c1.jnAcc = _loc_39;
                                _loc_31.c2.jnAcc = _loc_40;
                            }
                            else
                            {
                                _loc_39 = (-_loc_31.c1.nMass) * _loc_37;
                                if (_loc_39 >= 0)
                                {
                                }
                                if (_loc_31.Kb * _loc_39 + _loc_38 >= 0)
                                {
                                    _loc_37 = _loc_39 - _loc_35;
                                    _loc_38 = -_loc_36;
                                    _loc_31.c1.jnAcc = _loc_39;
                                    _loc_31.c2.jnAcc = 0;
                                }
                                else
                                {
                                    _loc_40 = (-_loc_31.c2.nMass) * _loc_38;
                                    if (_loc_40 >= 0)
                                    {
                                    }
                                    if (_loc_31.Kb * _loc_40 + _loc_37 >= 0)
                                    {
                                        _loc_37 = -_loc_35;
                                        _loc_38 = _loc_40 - _loc_36;
                                        _loc_31.c1.jnAcc = 0;
                                        _loc_31.c2.jnAcc = _loc_40;
                                    }
                                    else
                                    {
                                        if (_loc_37 >= 0)
                                        {
                                        }
                                        if (_loc_38 >= 0)
                                        {
                                            _loc_37 = -_loc_35;
                                            _loc_38 = -_loc_36;
                                            _loc_41 = 0;
                                            _loc_31.c2.jnAcc = _loc_41;
                                            _loc_31.c1.jnAcc = _loc_41;
                                        }
                                        else
                                        {
                                            _loc_37 = 0;
                                            _loc_38 = 0;
                                        }
                                    }
                                }
                            }
                            _loc_17 = _loc_37 + _loc_38;
                            _loc_15 = _loc_31.nx * _loc_17;
                            _loc_16 = _loc_31.ny * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + (_loc_31.rn1b * _loc_37 + _loc_31.rn2b * _loc_38) * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - (_loc_31.rn1a * _loc_37 + _loc_31.rn2a * _loc_38) * _loc_31.b1.iinertia;
                        }
                        else
                        {
                            if (_loc_31.radius != 0)
                            {
                                _loc_33 = _loc_31.b2.angvel - _loc_31.b1.angvel;
                                _loc_17 = _loc_33 * _loc_31.rMass;
                                _loc_18 = _loc_31.rfric * _loc_31.c1.jnAcc;
                                _loc_19 = _loc_31.jrAcc;
                                _loc_31.jrAcc = _loc_31.jrAcc - _loc_17;
                                if (_loc_31.jrAcc > _loc_18)
                                {
                                    _loc_31.jrAcc = _loc_18;
                                }
                                else if (_loc_31.jrAcc < -_loc_18)
                                {
                                    _loc_31.jrAcc = -_loc_18;
                                }
                                _loc_17 = _loc_31.jrAcc - _loc_19;
                                _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_17 * _loc_31.b2.iinertia;
                                _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_17 * _loc_31.b1.iinertia;
                            }
                            _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                            _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                            _loc_17 = (_loc_31.c1.bounce + (_loc_31.nx * _loc_21 + _loc_31.ny * _loc_32) + _loc_31.surfacey) * _loc_31.c1.nMass;
                            _loc_19 = _loc_31.c1.jnAcc;
                            _loc_20 = _loc_19 - _loc_17;
                            if (_loc_20 < 0)
                            {
                                _loc_20 = 0;
                            }
                            _loc_17 = _loc_20 - _loc_19;
                            _loc_31.c1.jnAcc = _loc_20;
                            _loc_15 = _loc_31.nx * _loc_17;
                            _loc_16 = _loc_31.ny * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rn1b * _loc_17 * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rn1a * _loc_17 * _loc_31.b1.iinertia;
                        }
                        _loc_31 = _loc_30.colarb;
                        _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                        _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                        _loc_17 = (_loc_32 * _loc_31.nx - _loc_21 * _loc_31.ny + _loc_31.surfacex) * _loc_31.c1.tMass;
                        _loc_18 = _loc_31.c1.friction * _loc_31.c1.jnAcc;
                        _loc_19 = _loc_31.c1.jtAcc;
                        _loc_20 = _loc_19 - _loc_17;
                        if (_loc_20 > _loc_18)
                        {
                            _loc_20 = _loc_18;
                        }
                        else if (_loc_20 < -_loc_18)
                        {
                            _loc_20 = -_loc_18;
                        }
                        _loc_17 = _loc_20 - _loc_19;
                        _loc_31.c1.jtAcc = _loc_20;
                        _loc_15 = (-_loc_31.ny) * _loc_17;
                        _loc_16 = _loc_31.nx * _loc_17;
                        _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                        _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                        _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                        _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                        _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rt1b * _loc_17 * _loc_31.b2.iinertia;
                        _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rt1a * _loc_17 * _loc_31.b1.iinertia;
                        if (_loc_31.hc2)
                        {
                            _loc_33 = _loc_31.k2x + _loc_31.b2.velx - _loc_31.c2.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c2.r1y * _loc_31.b1.angvel);
                            _loc_34 = _loc_31.k2y + _loc_31.b2.vely + _loc_31.c2.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c2.r1x * _loc_31.b1.angvel);
                            _loc_17 = (_loc_34 * _loc_31.nx - _loc_33 * _loc_31.ny + _loc_31.surfacex) * _loc_31.c2.tMass;
                            _loc_18 = _loc_31.c2.friction * _loc_31.c2.jnAcc;
                            _loc_19 = _loc_31.c2.jtAcc;
                            _loc_20 = _loc_19 - _loc_17;
                            if (_loc_20 > _loc_18)
                            {
                                _loc_20 = _loc_18;
                            }
                            else if (_loc_20 < -_loc_18)
                            {
                                _loc_20 = -_loc_18;
                            }
                            _loc_17 = _loc_20 - _loc_19;
                            _loc_31.c2.jtAcc = _loc_20;
                            _loc_15 = (-_loc_31.ny) * _loc_17;
                            _loc_16 = _loc_31.nx * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rt2b * _loc_17 * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rt2a * _loc_17 * _loc_31.b1.iinertia;
                            _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                            _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                            _loc_33 = _loc_31.k2x + _loc_31.b2.velx - _loc_31.c2.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c2.r1y * _loc_31.b1.angvel);
                            _loc_34 = _loc_31.k2y + _loc_31.b2.vely + _loc_31.c2.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c2.r1x * _loc_31.b1.angvel);
                            _loc_35 = _loc_31.c1.jnAcc;
                            _loc_36 = _loc_31.c2.jnAcc;
                            _loc_37 = _loc_21 * _loc_31.nx + _loc_32 * _loc_31.ny + _loc_31.surfacey + _loc_31.c1.bounce - (_loc_31.Ka * _loc_35 + _loc_31.Kb * _loc_36);
                            _loc_38 = _loc_33 * _loc_31.nx + _loc_34 * _loc_31.ny + _loc_31.surfacey + _loc_31.c2.bounce - (_loc_31.Kb * _loc_35 + _loc_31.Kc * _loc_36);
                            _loc_39 = -(_loc_31.kMassa * _loc_37 + _loc_31.kMassb * _loc_38);
                            _loc_40 = -(_loc_31.kMassb * _loc_37 + _loc_31.kMassc * _loc_38);
                            if (_loc_39 >= 0)
                            {
                            }
                            if (_loc_40 >= 0)
                            {
                                _loc_37 = _loc_39 - _loc_35;
                                _loc_38 = _loc_40 - _loc_36;
                                _loc_31.c1.jnAcc = _loc_39;
                                _loc_31.c2.jnAcc = _loc_40;
                            }
                            else
                            {
                                _loc_39 = (-_loc_31.c1.nMass) * _loc_37;
                                if (_loc_39 >= 0)
                                {
                                }
                                if (_loc_31.Kb * _loc_39 + _loc_38 >= 0)
                                {
                                    _loc_37 = _loc_39 - _loc_35;
                                    _loc_38 = -_loc_36;
                                    _loc_31.c1.jnAcc = _loc_39;
                                    _loc_31.c2.jnAcc = 0;
                                }
                                else
                                {
                                    _loc_40 = (-_loc_31.c2.nMass) * _loc_38;
                                    if (_loc_40 >= 0)
                                    {
                                    }
                                    if (_loc_31.Kb * _loc_40 + _loc_37 >= 0)
                                    {
                                        _loc_37 = -_loc_35;
                                        _loc_38 = _loc_40 - _loc_36;
                                        _loc_31.c1.jnAcc = 0;
                                        _loc_31.c2.jnAcc = _loc_40;
                                    }
                                    else
                                    {
                                        if (_loc_37 >= 0)
                                        {
                                        }
                                        if (_loc_38 >= 0)
                                        {
                                            _loc_37 = -_loc_35;
                                            _loc_38 = -_loc_36;
                                            _loc_41 = 0;
                                            _loc_31.c2.jnAcc = _loc_41;
                                            _loc_31.c1.jnAcc = _loc_41;
                                        }
                                        else
                                        {
                                            _loc_37 = 0;
                                            _loc_38 = 0;
                                        }
                                    }
                                }
                            }
                            _loc_17 = _loc_37 + _loc_38;
                            _loc_15 = _loc_31.nx * _loc_17;
                            _loc_16 = _loc_31.ny * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + (_loc_31.rn1b * _loc_37 + _loc_31.rn2b * _loc_38) * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - (_loc_31.rn1a * _loc_37 + _loc_31.rn2a * _loc_38) * _loc_31.b1.iinertia;
                        }
                        else
                        {
                            if (_loc_31.radius != 0)
                            {
                                _loc_33 = _loc_31.b2.angvel - _loc_31.b1.angvel;
                                _loc_17 = _loc_33 * _loc_31.rMass;
                                _loc_18 = _loc_31.rfric * _loc_31.c1.jnAcc;
                                _loc_19 = _loc_31.jrAcc;
                                _loc_31.jrAcc = _loc_31.jrAcc - _loc_17;
                                if (_loc_31.jrAcc > _loc_18)
                                {
                                    _loc_31.jrAcc = _loc_18;
                                }
                                else if (_loc_31.jrAcc < -_loc_18)
                                {
                                    _loc_31.jrAcc = -_loc_18;
                                }
                                _loc_17 = _loc_31.jrAcc - _loc_19;
                                _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_17 * _loc_31.b2.iinertia;
                                _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_17 * _loc_31.b1.iinertia;
                            }
                            _loc_21 = _loc_31.k1x + _loc_31.b2.velx - _loc_31.c1.r2y * _loc_31.b2.angvel - (_loc_31.b1.velx - _loc_31.c1.r1y * _loc_31.b1.angvel);
                            _loc_32 = _loc_31.k1y + _loc_31.b2.vely + _loc_31.c1.r2x * _loc_31.b2.angvel - (_loc_31.b1.vely + _loc_31.c1.r1x * _loc_31.b1.angvel);
                            _loc_17 = (_loc_31.c1.bounce + (_loc_31.nx * _loc_21 + _loc_31.ny * _loc_32) + _loc_31.surfacey) * _loc_31.c1.nMass;
                            _loc_19 = _loc_31.c1.jnAcc;
                            _loc_20 = _loc_19 - _loc_17;
                            if (_loc_20 < 0)
                            {
                                _loc_20 = 0;
                            }
                            _loc_17 = _loc_20 - _loc_19;
                            _loc_31.c1.jnAcc = _loc_20;
                            _loc_15 = _loc_31.nx * _loc_17;
                            _loc_16 = _loc_31.ny * _loc_17;
                            _loc_31.b2.velx = _loc_31.b2.velx + _loc_15 * _loc_31.b2.imass;
                            _loc_31.b2.vely = _loc_31.b2.vely + _loc_16 * _loc_31.b2.imass;
                            _loc_31.b1.velx = _loc_31.b1.velx - _loc_15 * _loc_31.b1.imass;
                            _loc_31.b1.vely = _loc_31.b1.vely - _loc_16 * _loc_31.b1.imass;
                            _loc_31.b2.angvel = _loc_31.b2.angvel + _loc_31.rn1b * _loc_17 * _loc_31.b2.iinertia;
                            _loc_31.b1.angvel = _loc_31.b1.angvel - _loc_31.rn1a * _loc_17 * _loc_31.b1.iinertia;
                        }
                        _loc_11.sweep_angvel = _loc_11.angvel % _loc_2;
                        _loc_12.sweep_angvel = _loc_12.angvel % _loc_2;
                    }
                }
                if (_loc_30 != null)
                {
                    if (_loc_30.active)
                    {
                    }
                }
                if ((_loc_30.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                {
                }
                if (_loc_30.type == ZPP_Arbiter.COL)
                {
                    if (!_loc_11.sweepFrozen)
                    {
                    }
                    if (_loc_11.type != ZPP_Flags.id_BodyType_KINEMATIC)
                    {
                        _loc_11.sweepFrozen = true;
                        if (_loc_4.failed)
                        {
                            _loc_15 = 0;
                            _loc_11.sweep_angvel = _loc_15;
                            _loc_11.angvel = _loc_15;
                        }
                        else if (_loc_4.slipped)
                        {
                            _loc_15 = _loc_11.sweep_angvel * Config.angularCCDSlipScale;
                            _loc_11.sweep_angvel = _loc_15;
                            _loc_11.angvel = _loc_15;
                        }
                        else
                        {
                            _loc_11.angvel = _loc_11.sweep_angvel;
                        }
                    }
                    if (!_loc_12.sweepFrozen)
                    {
                    }
                    if (_loc_12.type != ZPP_Flags.id_BodyType_KINEMATIC)
                    {
                        _loc_12.sweepFrozen = true;
                        if (_loc_4.failed)
                        {
                            _loc_15 = 0;
                            _loc_12.sweep_angvel = _loc_15;
                            _loc_12.angvel = _loc_15;
                        }
                        else if (_loc_4.slipped)
                        {
                            _loc_15 = _loc_12.sweep_angvel * Config.angularCCDSlipScale;
                            _loc_12.sweep_angvel = _loc_15;
                            _loc_12.angvel = _loc_15;
                        }
                        else
                        {
                            _loc_12.angvel = _loc_12.sweep_angvel;
                        }
                    }
                }
                if (_loc_3 < 1)
                {
                }
            }while (toiEvents.head != null)
            while (toiEvents.head != null)
            {
                
                _loc_4 = toiEvents.pop_unsafe();
                _loc_10 = _loc_4;
                _loc_10.next = ZPP_ToiEvent.zpp_pool;
                ZPP_ToiEvent.zpp_pool = _loc_10;
            }
            var _loc_42:* = kinematics.head;
            while (_loc_42 != null)
            {
                
                _loc_11 = _loc_42.elt;
                _loc_5 = param1 - _loc_11.sweepTime;
                if (_loc_5 != 0)
                {
                    _loc_11.sweepTime = param1;
                    _loc_15 = _loc_5;
                    _loc_11.posx = _loc_11.posx + _loc_11.velx * _loc_15;
                    _loc_11.posy = _loc_11.posy + _loc_11.vely * _loc_15;
                    if (_loc_11.angvel != 0)
                    {
                        _loc_15 = _loc_11.sweep_angvel * _loc_5;
                        _loc_11.rot = _loc_11.rot + _loc_15;
                        if (_loc_15 * _loc_15 > 0.0001)
                        {
                            _loc_11.axisx = Math.sin(_loc_11.rot);
                            _loc_11.axisy = Math.cos(_loc_11.rot);
                        }
                        else
                        {
                            _loc_16 = _loc_15 * _loc_15;
                            _loc_17 = 1 - 0.5 * _loc_16;
                            _loc_18 = 1 - _loc_16 * _loc_16 / 8;
                            _loc_19 = (_loc_17 * _loc_11.axisx + _loc_15 * _loc_11.axisy) * _loc_18;
                            _loc_11.axisy = (_loc_17 * _loc_11.axisy - _loc_15 * _loc_11.axisx) * _loc_18;
                            _loc_11.axisx = _loc_19;
                        }
                    }
                }
                _loc_11.sweepTime = 0;
                _loc_42 = _loc_42.next;
            }
            _loc_42 = live.head;
            while (_loc_42 != null)
            {
                
                _loc_11 = _loc_42.elt;
                if (!_loc_11.sweepFrozen)
                {
                    _loc_5 = param1 - _loc_11.sweepTime;
                    if (_loc_5 != 0)
                    {
                        _loc_11.sweepTime = param1;
                        _loc_15 = _loc_5;
                        _loc_11.posx = _loc_11.posx + _loc_11.velx * _loc_15;
                        _loc_11.posy = _loc_11.posy + _loc_11.vely * _loc_15;
                        if (_loc_11.angvel != 0)
                        {
                            _loc_15 = _loc_11.sweep_angvel * _loc_5;
                            _loc_11.rot = _loc_11.rot + _loc_15;
                            if (_loc_15 * _loc_15 > 0.0001)
                            {
                                _loc_11.axisx = Math.sin(_loc_11.rot);
                                _loc_11.axisy = Math.cos(_loc_11.rot);
                            }
                            else
                            {
                                _loc_16 = _loc_15 * _loc_15;
                                _loc_17 = 1 - 0.5 * _loc_16;
                                _loc_18 = 1 - _loc_16 * _loc_16 / 8;
                                _loc_19 = (_loc_17 * _loc_11.axisx + _loc_15 * _loc_11.axisy) * _loc_18;
                                _loc_11.axisy = (_loc_17 * _loc_11.axisy - _loc_15 * _loc_11.axisx) * _loc_18;
                                _loc_11.axisx = _loc_19;
                            }
                        }
                    }
                }
                _loc_11.sweepTime = 0;
                _loc_42 = _loc_42.next;
            }
            return;
        }// end function

        public function constraints_subber(param1:Constraint) : void
        {
            remConstraint(param1.zpp_inner);
            return;
        }// end function

        public function constraints_modifiable() : void
        {
            if (midstep)
            {
                throw "Error: Space::constraints cannot be set during space step()";
            }
            return;
        }// end function

        public function constraints_adder(param1:Constraint) : Boolean
        {
            if (param1.zpp_inner.compound != null)
            {
                throw "Error: Cannot set the space of a Constraint belonging to a Compound, only the root Compound space can be set";
            }
            if (param1.zpp_inner.space != this)
            {
                if (param1.zpp_inner.space != null)
                {
                    param1.zpp_inner.space.outer.zpp_inner.wrap_constraints.remove(param1);
                }
                addConstraint(param1.zpp_inner);
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function constraintCbWake(param1:ZPP_Constraint) : void
        {
            var _loc_2:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_3:* = null as ZPP_ConstraintListener;
            var _loc_4:* = null as ZPP_Callback;
            if (param1.cbSet != null)
            {
                if (midstep)
                {
                    _loc_2 = param1.cbSet.conlisteners.head;
                    while (_loc_2 != null)
                    {
                        
                        _loc_3 = _loc_2.elt;
                        if (_loc_3.event != ZPP_Flags.id_CbEvent_WAKE)
                        {
                            _loc_2 = _loc_2.next;
                            continue;
                        }
                        _loc_4 = push_callback(_loc_3);
                        _loc_4.event = ZPP_Flags.id_CbEvent_WAKE;
                        _loc_4.constraint = param1;
                        _loc_2 = _loc_2.next;
                    }
                }
                else
                {
                    param1.component.woken = true;
                }
            }
            return;
        }// end function

        public function constraintCbSleep(param1:ZPP_Constraint) : void
        {
            var _loc_2:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_3:* = null as ZPP_ConstraintListener;
            var _loc_4:* = null as ZPP_Callback;
            if (param1.cbSet != null)
            {
                _loc_2 = param1.cbSet.conlisteners.head;
                while (_loc_2 != null)
                {
                    
                    _loc_3 = _loc_2.elt;
                    if (_loc_3.event != ZPP_Flags.id_CbEvent_SLEEP)
                    {
                        _loc_2 = _loc_2.next;
                        continue;
                    }
                    _loc_4 = push_callback(_loc_3);
                    _loc_4.event = ZPP_Flags.id_CbEvent_SLEEP;
                    _loc_4.constraint = param1;
                    _loc_2 = _loc_2.next;
                }
            }
            return;
        }// end function

        public function constraintCbBreak(param1:ZPP_Constraint) : void
        {
            var _loc_2:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_3:* = null as ZPP_ConstraintListener;
            var _loc_4:* = null as ZPP_Callback;
            if (param1.cbSet != null)
            {
                _loc_2 = param1.cbSet.conlisteners.head;
                while (_loc_2 != null)
                {
                    
                    _loc_3 = _loc_2.elt;
                    if (_loc_3.event != ZPP_Flags.id_CbEvent_BREAK)
                    {
                        _loc_2 = _loc_2.next;
                        continue;
                    }
                    _loc_4 = push_callback(_loc_3);
                    _loc_4.event = ZPP_Flags.id_CbEvent_BREAK;
                    _loc_4.constraint = param1;
                    _loc_2 = _loc_2.next;
                }
            }
            return;
        }// end function

        public function compounds_subber(param1:Compound) : void
        {
            remCompound(param1.zpp_inner);
            return;
        }// end function

        public function compounds_modifiable() : void
        {
            if (midstep)
            {
                throw "Error: Space::compounds cannot be set during space step()";
            }
            return;
        }// end function

        public function compounds_adder(param1:Compound) : Boolean
        {
            if (param1.zpp_inner.compound != null)
            {
                throw "Error: Cannot set the space of an inner Compound, only the root Compound space can be set";
            }
            if (param1.zpp_inner.space != this)
            {
                if (param1.zpp_inner.space != null)
                {
                    param1.zpp_inner.space.wrap_compounds.remove(param1);
                }
                addCompound(param1.zpp_inner);
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function clear() : void
        {
            var _loc_1:* = null as ZPP_Listener;
            var _loc_2:* = null as ZPP_CallbackSet;
            var _loc_3:* = null as ZPP_CallbackSet;
            var _loc_4:* = null as ZPP_Interactor;
            var _loc_5:* = 0;
            var _loc_6:* = null as ZPP_ColArbiter;
            var _loc_7:* = null as ZNPList_ZPP_Arbiter;
            var _loc_8:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_9:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_10:* = false;
            var _loc_11:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_12:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_13:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_14:* = null as ZPP_Body;
            var _loc_15:* = null as ZPP_Contact;
            var _loc_16:* = null as ZPP_Contact;
            var _loc_17:* = null as ZPP_Contact;
            var _loc_18:* = null as ZPP_IContact;
            var _loc_19:* = null as ZPP_IContact;
            var _loc_20:* = null as ZPP_ColArbiter;
            var _loc_21:* = null as ZPP_Edge;
            var _loc_22:* = null as ZPP_SensorArbiter;
            var _loc_23:* = null as ZPP_SensorArbiter;
            var _loc_24:* = null as ZPP_FluidArbiter;
            var _loc_25:* = null as ZPP_FluidArbiter;
            var _loc_26:* = null as ZPP_Island;
            var _loc_27:* = null as ZPP_Component;
            var _loc_28:* = null as ZPP_Island;
            var _loc_29:* = null as ZPP_Constraint;
            var _loc_31:* = null as ZPP_Compound;
            var _loc_32:* = null as ZNPNode_ZPP_Body;
            var _loc_33:* = null as ZNPNode_ZPP_Constraint;
            var _loc_34:* = null as ZNPNode_ZPP_Compound;
            var _loc_35:* = null as ZPP_Compound;
            while (listeners.head != null)
            {
                
                _loc_1 = listeners.pop_unsafe();
                remListener(_loc_1);
            }
            while (callbackset_list.next != null)
            {
                
                _loc_2 = callbackset_list.pop_unsafe();
                _loc_2.arbiters.clear();
                _loc_3 = _loc_2;
                _loc_4 = null;
                _loc_3.int2 = _loc_4;
                _loc_3.int1 = _loc_4;
                _loc_5 = -1;
                _loc_3.di = _loc_5;
                _loc_3.id = _loc_5;
                _loc_3.freed = true;
                _loc_3.next = ZPP_CallbackSet.zpp_pool;
                ZPP_CallbackSet.zpp_pool = _loc_3;
            }
            while (c_arbiters_true.head != null)
            {
                
                _loc_6 = c_arbiters_true.pop_unsafe();
                if (!_loc_6.cleared)
                {
                    _loc_7 = _loc_6.b1.arbiters;
                    _loc_8 = null;
                    _loc_9 = _loc_7.head;
                    _loc_10 = false;
                    while (_loc_9 != null)
                    {
                        
                        if (_loc_9.elt == _loc_6)
                        {
                            if (_loc_8 == null)
                            {
                                _loc_11 = _loc_7.head;
                                _loc_12 = _loc_11.next;
                                _loc_7.head = _loc_12;
                                if (_loc_7.head == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_11 = _loc_8.next;
                                _loc_12 = _loc_11.next;
                                _loc_8.next = _loc_12;
                                if (_loc_12 == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            _loc_13 = _loc_11;
                            _loc_13.elt = null;
                            _loc_13.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                            ZNPNode_ZPP_Arbiter.zpp_pool = _loc_13;
                            _loc_7.modified = true;
                            (_loc_7.length - 1);
                            _loc_7.pushmod = true;
                            _loc_10 = true;
                            break;
                        }
                        _loc_8 = _loc_9;
                        _loc_9 = _loc_9.next;
                    }
                    _loc_7 = _loc_6.b2.arbiters;
                    _loc_8 = null;
                    _loc_9 = _loc_7.head;
                    _loc_10 = false;
                    while (_loc_9 != null)
                    {
                        
                        if (_loc_9.elt == _loc_6)
                        {
                            if (_loc_8 == null)
                            {
                                _loc_11 = _loc_7.head;
                                _loc_12 = _loc_11.next;
                                _loc_7.head = _loc_12;
                                if (_loc_7.head == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_11 = _loc_8.next;
                                _loc_12 = _loc_11.next;
                                _loc_8.next = _loc_12;
                                if (_loc_12 == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            _loc_13 = _loc_11;
                            _loc_13.elt = null;
                            _loc_13.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                            ZNPNode_ZPP_Arbiter.zpp_pool = _loc_13;
                            _loc_7.modified = true;
                            (_loc_7.length - 1);
                            _loc_7.pushmod = true;
                            _loc_10 = true;
                            break;
                        }
                        _loc_8 = _loc_9;
                        _loc_9 = _loc_9.next;
                    }
                    if (_loc_6.pair != null)
                    {
                        _loc_6.pair.arb = null;
                        _loc_6.pair = null;
                    }
                }
                _loc_14 = null;
                _loc_6.b2 = _loc_14;
                _loc_6.b1 = _loc_14;
                _loc_6.active = false;
                _loc_6.intchange = false;
                while (_loc_6.contacts.next != null)
                {
                    
                    _loc_16 = _loc_6.contacts;
                    _loc_17 = _loc_16.next;
                    _loc_16.pop();
                    _loc_15 = _loc_17;
                    _loc_15.arbiter = null;
                    _loc_15.next = ZPP_Contact.zpp_pool;
                    ZPP_Contact.zpp_pool = _loc_15;
                    _loc_18 = _loc_6.innards;
                    _loc_19 = _loc_18.next;
                    _loc_18.next = _loc_19.next;
                    _loc_19._inuse = false;
                    if (_loc_18.next == null)
                    {
                        _loc_18.pushmod = true;
                    }
                    _loc_18.modified = true;
                    (_loc_18.length - 1);
                }
                _loc_20 = _loc_6;
                _loc_20.userdef_dyn_fric = false;
                _loc_20.userdef_stat_fric = false;
                _loc_20.userdef_restitution = false;
                _loc_20.userdef_rfric = false;
                _loc_21 = null;
                _loc_20.__ref_edge2 = _loc_21;
                _loc_20.__ref_edge1 = _loc_21;
                _loc_20.next = ZPP_ColArbiter.zpp_pool;
                ZPP_ColArbiter.zpp_pool = _loc_20;
                _loc_6.pre_dt = -1;
            }
            while (c_arbiters_false.head != null)
            {
                
                _loc_6 = c_arbiters_false.pop_unsafe();
                if (!_loc_6.cleared)
                {
                    _loc_7 = _loc_6.b1.arbiters;
                    _loc_8 = null;
                    _loc_9 = _loc_7.head;
                    _loc_10 = false;
                    while (_loc_9 != null)
                    {
                        
                        if (_loc_9.elt == _loc_6)
                        {
                            if (_loc_8 == null)
                            {
                                _loc_11 = _loc_7.head;
                                _loc_12 = _loc_11.next;
                                _loc_7.head = _loc_12;
                                if (_loc_7.head == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_11 = _loc_8.next;
                                _loc_12 = _loc_11.next;
                                _loc_8.next = _loc_12;
                                if (_loc_12 == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            _loc_13 = _loc_11;
                            _loc_13.elt = null;
                            _loc_13.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                            ZNPNode_ZPP_Arbiter.zpp_pool = _loc_13;
                            _loc_7.modified = true;
                            (_loc_7.length - 1);
                            _loc_7.pushmod = true;
                            _loc_10 = true;
                            break;
                        }
                        _loc_8 = _loc_9;
                        _loc_9 = _loc_9.next;
                    }
                    _loc_7 = _loc_6.b2.arbiters;
                    _loc_8 = null;
                    _loc_9 = _loc_7.head;
                    _loc_10 = false;
                    while (_loc_9 != null)
                    {
                        
                        if (_loc_9.elt == _loc_6)
                        {
                            if (_loc_8 == null)
                            {
                                _loc_11 = _loc_7.head;
                                _loc_12 = _loc_11.next;
                                _loc_7.head = _loc_12;
                                if (_loc_7.head == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_11 = _loc_8.next;
                                _loc_12 = _loc_11.next;
                                _loc_8.next = _loc_12;
                                if (_loc_12 == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            _loc_13 = _loc_11;
                            _loc_13.elt = null;
                            _loc_13.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                            ZNPNode_ZPP_Arbiter.zpp_pool = _loc_13;
                            _loc_7.modified = true;
                            (_loc_7.length - 1);
                            _loc_7.pushmod = true;
                            _loc_10 = true;
                            break;
                        }
                        _loc_8 = _loc_9;
                        _loc_9 = _loc_9.next;
                    }
                    if (_loc_6.pair != null)
                    {
                        _loc_6.pair.arb = null;
                        _loc_6.pair = null;
                    }
                }
                _loc_14 = null;
                _loc_6.b2 = _loc_14;
                _loc_6.b1 = _loc_14;
                _loc_6.active = false;
                _loc_6.intchange = false;
                while (_loc_6.contacts.next != null)
                {
                    
                    _loc_16 = _loc_6.contacts;
                    _loc_17 = _loc_16.next;
                    _loc_16.pop();
                    _loc_15 = _loc_17;
                    _loc_15.arbiter = null;
                    _loc_15.next = ZPP_Contact.zpp_pool;
                    ZPP_Contact.zpp_pool = _loc_15;
                    _loc_18 = _loc_6.innards;
                    _loc_19 = _loc_18.next;
                    _loc_18.next = _loc_19.next;
                    _loc_19._inuse = false;
                    if (_loc_18.next == null)
                    {
                        _loc_18.pushmod = true;
                    }
                    _loc_18.modified = true;
                    (_loc_18.length - 1);
                }
                _loc_20 = _loc_6;
                _loc_20.userdef_dyn_fric = false;
                _loc_20.userdef_stat_fric = false;
                _loc_20.userdef_restitution = false;
                _loc_20.userdef_rfric = false;
                _loc_21 = null;
                _loc_20.__ref_edge2 = _loc_21;
                _loc_20.__ref_edge1 = _loc_21;
                _loc_20.next = ZPP_ColArbiter.zpp_pool;
                ZPP_ColArbiter.zpp_pool = _loc_20;
                _loc_6.pre_dt = -1;
            }
            while (s_arbiters.head != null)
            {
                
                _loc_22 = s_arbiters.pop_unsafe();
                if (!_loc_22.cleared)
                {
                    _loc_7 = _loc_22.b1.arbiters;
                    _loc_8 = null;
                    _loc_9 = _loc_7.head;
                    _loc_10 = false;
                    while (_loc_9 != null)
                    {
                        
                        if (_loc_9.elt == _loc_22)
                        {
                            if (_loc_8 == null)
                            {
                                _loc_11 = _loc_7.head;
                                _loc_12 = _loc_11.next;
                                _loc_7.head = _loc_12;
                                if (_loc_7.head == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_11 = _loc_8.next;
                                _loc_12 = _loc_11.next;
                                _loc_8.next = _loc_12;
                                if (_loc_12 == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            _loc_13 = _loc_11;
                            _loc_13.elt = null;
                            _loc_13.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                            ZNPNode_ZPP_Arbiter.zpp_pool = _loc_13;
                            _loc_7.modified = true;
                            (_loc_7.length - 1);
                            _loc_7.pushmod = true;
                            _loc_10 = true;
                            break;
                        }
                        _loc_8 = _loc_9;
                        _loc_9 = _loc_9.next;
                    }
                    _loc_7 = _loc_22.b2.arbiters;
                    _loc_8 = null;
                    _loc_9 = _loc_7.head;
                    _loc_10 = false;
                    while (_loc_9 != null)
                    {
                        
                        if (_loc_9.elt == _loc_22)
                        {
                            if (_loc_8 == null)
                            {
                                _loc_11 = _loc_7.head;
                                _loc_12 = _loc_11.next;
                                _loc_7.head = _loc_12;
                                if (_loc_7.head == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_11 = _loc_8.next;
                                _loc_12 = _loc_11.next;
                                _loc_8.next = _loc_12;
                                if (_loc_12 == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            _loc_13 = _loc_11;
                            _loc_13.elt = null;
                            _loc_13.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                            ZNPNode_ZPP_Arbiter.zpp_pool = _loc_13;
                            _loc_7.modified = true;
                            (_loc_7.length - 1);
                            _loc_7.pushmod = true;
                            _loc_10 = true;
                            break;
                        }
                        _loc_8 = _loc_9;
                        _loc_9 = _loc_9.next;
                    }
                    if (_loc_22.pair != null)
                    {
                        _loc_22.pair.arb = null;
                        _loc_22.pair = null;
                    }
                }
                _loc_14 = null;
                _loc_22.b2 = _loc_14;
                _loc_22.b1 = _loc_14;
                _loc_22.active = false;
                _loc_22.intchange = false;
                _loc_23 = _loc_22;
                _loc_23.next = ZPP_SensorArbiter.zpp_pool;
                ZPP_SensorArbiter.zpp_pool = _loc_23;
            }
            while (f_arbiters.head != null)
            {
                
                _loc_24 = f_arbiters.pop_unsafe();
                if (!_loc_24.cleared)
                {
                    _loc_7 = _loc_24.b1.arbiters;
                    _loc_8 = null;
                    _loc_9 = _loc_7.head;
                    _loc_10 = false;
                    while (_loc_9 != null)
                    {
                        
                        if (_loc_9.elt == _loc_24)
                        {
                            if (_loc_8 == null)
                            {
                                _loc_11 = _loc_7.head;
                                _loc_12 = _loc_11.next;
                                _loc_7.head = _loc_12;
                                if (_loc_7.head == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_11 = _loc_8.next;
                                _loc_12 = _loc_11.next;
                                _loc_8.next = _loc_12;
                                if (_loc_12 == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            _loc_13 = _loc_11;
                            _loc_13.elt = null;
                            _loc_13.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                            ZNPNode_ZPP_Arbiter.zpp_pool = _loc_13;
                            _loc_7.modified = true;
                            (_loc_7.length - 1);
                            _loc_7.pushmod = true;
                            _loc_10 = true;
                            break;
                        }
                        _loc_8 = _loc_9;
                        _loc_9 = _loc_9.next;
                    }
                    _loc_7 = _loc_24.b2.arbiters;
                    _loc_8 = null;
                    _loc_9 = _loc_7.head;
                    _loc_10 = false;
                    while (_loc_9 != null)
                    {
                        
                        if (_loc_9.elt == _loc_24)
                        {
                            if (_loc_8 == null)
                            {
                                _loc_11 = _loc_7.head;
                                _loc_12 = _loc_11.next;
                                _loc_7.head = _loc_12;
                                if (_loc_7.head == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            else
                            {
                                _loc_11 = _loc_8.next;
                                _loc_12 = _loc_11.next;
                                _loc_8.next = _loc_12;
                                if (_loc_12 == null)
                                {
                                    _loc_7.pushmod = true;
                                }
                            }
                            _loc_13 = _loc_11;
                            _loc_13.elt = null;
                            _loc_13.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                            ZNPNode_ZPP_Arbiter.zpp_pool = _loc_13;
                            _loc_7.modified = true;
                            (_loc_7.length - 1);
                            _loc_7.pushmod = true;
                            _loc_10 = true;
                            break;
                        }
                        _loc_8 = _loc_9;
                        _loc_9 = _loc_9.next;
                    }
                    if (_loc_24.pair != null)
                    {
                        _loc_24.pair.arb = null;
                        _loc_24.pair = null;
                    }
                }
                _loc_14 = null;
                _loc_24.b2 = _loc_14;
                _loc_24.b1 = _loc_14;
                _loc_24.active = false;
                _loc_24.intchange = false;
                _loc_25 = _loc_24;
                _loc_25.next = ZPP_FluidArbiter.zpp_pool;
                ZPP_FluidArbiter.zpp_pool = _loc_25;
                _loc_24.pre_dt = -1;
            }
            bphase.clear();
            while (bodies.head != null)
            {
                
                _loc_14 = bodies.pop_unsafe();
                if (_loc_14.component != null)
                {
                    _loc_26 = _loc_14.component.island;
                    if (_loc_26 != null)
                    {
                        while (_loc_26.comps.head != null)
                        {
                            
                            _loc_27 = _loc_26.comps.pop_unsafe();
                            _loc_27.sleeping = false;
                            _loc_27.island = null;
                            _loc_27.parent = _loc_27;
                            _loc_27.rank = 0;
                        }
                        _loc_28 = _loc_26;
                        _loc_28.next = ZPP_Island.zpp_pool;
                        ZPP_Island.zpp_pool = _loc_28;
                    }
                }
                _loc_14.removedFromSpace();
                _loc_14.space = null;
            }
            while (constraints.head != null)
            {
                
                _loc_29 = constraints.pop_unsafe();
                if (_loc_29.component != null)
                {
                    _loc_26 = _loc_29.component.island;
                    if (_loc_26 != null)
                    {
                        while (_loc_26.comps.head != null)
                        {
                            
                            _loc_27 = _loc_26.comps.pop_unsafe();
                            _loc_27.sleeping = false;
                            _loc_27.island = null;
                            _loc_27.parent = _loc_27;
                            _loc_27.rank = 0;
                        }
                        _loc_28 = _loc_26;
                        _loc_28.next = ZPP_Island.zpp_pool;
                        ZPP_Island.zpp_pool = _loc_28;
                    }
                }
                _loc_29.removedFromSpace();
                _loc_29.space = null;
            }
            kinematics.clear();
            var _loc_30:* = new ZNPList_ZPP_Compound();
            while (compounds.head != null)
            {
                
                _loc_31 = compounds.pop_unsafe();
                _loc_30.add(_loc_31);
            }
            while (_loc_30.head != null)
            {
                
                _loc_31 = _loc_30.pop_unsafe();
                _loc_31.removedFromSpace();
                _loc_31.space = null;
                _loc_32 = _loc_31.bodies.head;
                while (_loc_32 != null)
                {
                    
                    _loc_14 = _loc_32.elt;
                    if (_loc_14.component != null)
                    {
                        _loc_26 = _loc_14.component.island;
                        if (_loc_26 != null)
                        {
                            while (_loc_26.comps.head != null)
                            {
                                
                                _loc_27 = _loc_26.comps.pop_unsafe();
                                _loc_27.sleeping = false;
                                _loc_27.island = null;
                                _loc_27.parent = _loc_27;
                                _loc_27.rank = 0;
                            }
                            _loc_28 = _loc_26;
                            _loc_28.next = ZPP_Island.zpp_pool;
                            ZPP_Island.zpp_pool = _loc_28;
                        }
                    }
                    _loc_14.removedFromSpace();
                    _loc_14.space = null;
                    _loc_32 = _loc_32.next;
                }
                _loc_33 = _loc_31.constraints.head;
                while (_loc_33 != null)
                {
                    
                    _loc_29 = _loc_33.elt;
                    if (_loc_29.component != null)
                    {
                        _loc_26 = _loc_29.component.island;
                        if (_loc_26 != null)
                        {
                            while (_loc_26.comps.head != null)
                            {
                                
                                _loc_27 = _loc_26.comps.pop_unsafe();
                                _loc_27.sleeping = false;
                                _loc_27.island = null;
                                _loc_27.parent = _loc_27;
                                _loc_27.rank = 0;
                            }
                            _loc_28 = _loc_26;
                            _loc_28.next = ZPP_Island.zpp_pool;
                            ZPP_Island.zpp_pool = _loc_28;
                        }
                    }
                    _loc_29.removedFromSpace();
                    _loc_29.space = null;
                    _loc_33 = _loc_33.next;
                }
                _loc_34 = _loc_31.compounds.head;
                while (_loc_34 != null)
                {
                    
                    _loc_35 = _loc_34.elt;
                    _loc_30.add(_loc_35);
                    _loc_34 = _loc_34.next;
                }
            }
            staticsleep.clear();
            live.clear();
            live_constraints.clear();
            stamp = 0;
            time = 0;
            mrca1.clear();
            mrca2.clear();
            prelisteners.clear();
            cbsets.clear();
            return;
        }// end function

        public function bodyCbWake(param1:ZPP_Body) : void
        {
            var _loc_2:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_3:* = null as ZPP_BodyListener;
            var _loc_4:* = null as ZPP_Callback;
            if (param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
            }
            if (param1.cbSet != null)
            {
                if (midstep)
                {
                    _loc_2 = param1.cbSet.bodylisteners.head;
                    while (_loc_2 != null)
                    {
                        
                        _loc_3 = _loc_2.elt;
                        if (_loc_3.event != ZPP_Flags.id_CbEvent_WAKE)
                        {
                            _loc_2 = _loc_2.next;
                            continue;
                        }
                        _loc_4 = push_callback(_loc_3);
                        _loc_4.event = ZPP_Flags.id_CbEvent_WAKE;
                        _loc_4.body = param1;
                        _loc_2 = _loc_2.next;
                    }
                }
                else
                {
                    param1.component.woken = true;
                }
            }
            return;
        }// end function

        public function bodyCbSleep(param1:ZPP_Body) : void
        {
            var _loc_2:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_3:* = null as ZPP_BodyListener;
            var _loc_4:* = null as ZPP_Callback;
            if (param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
            }
            if (param1.cbSet != null)
            {
                _loc_2 = param1.cbSet.bodylisteners.head;
                while (_loc_2 != null)
                {
                    
                    _loc_3 = _loc_2.elt;
                    if (_loc_3.event != ZPP_Flags.id_CbEvent_SLEEP)
                    {
                        _loc_2 = _loc_2.next;
                        continue;
                    }
                    _loc_4 = push_callback(_loc_3);
                    _loc_4.event = ZPP_Flags.id_CbEvent_SLEEP;
                    _loc_4.body = param1;
                    _loc_2 = _loc_2.next;
                }
            }
            return;
        }// end function

        public function bodies_subber(param1:Body) : void
        {
            remBody(param1.zpp_inner);
            return;
        }// end function

        public function bodies_modifiable() : void
        {
            if (midstep)
            {
                throw "Error: Space::bodies cannot be set during space step()";
            }
            return;
        }// end function

        public function bodies_adder(param1:Body) : Boolean
        {
            if (param1.zpp_inner.compound != null)
            {
                throw "Error: Cannot set the space of a Body belonging to a Compound, only the root Compound space can be set";
            }
            if (param1.zpp_inner.space != this)
            {
                if (param1.zpp_inner.space != null)
                {
                    param1.zpp_inner.space.outer.zpp_inner.wrap_bodies.remove(param1);
                }
                addBody(param1.zpp_inner);
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
        {
            return bphase.bodiesUnderPoint(param1, param2, param3, param4);
        }// end function

        public function bodiesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
        {
            return bphase.bodiesInShape(param1, param2, param3, param4);
        }// end function

        public function bodiesInCircle(param1:Vec2, param2:Number, param3:Boolean, param4:ZPP_InteractionFilter, param5:BodyList) : BodyList
        {
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_6:* = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            return bphase.bodiesInCircle(param1.zpp_inner.x, param1.zpp_inner.y, param2, param3, param4, param5);
        }// end function

        public function bodiesInAABB(param1:AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:BodyList) : BodyList
        {
            return bphase.bodiesInAABB(param1.zpp_inner, param2, param3, param4, param5);
        }// end function

        public function added_shape(param1:ZPP_Shape, param2:Boolean = false) : void
        {
            var _loc_3:* = null as ZPP_Body;
            if (!param2)
            {
                _loc_3 = param1.body;
                if (!_loc_3.world)
                {
                    _loc_3.component.waket = stamp + (midstep ? (0) : (1));
                    if (_loc_3.type == ZPP_Flags.id_BodyType_KINEMATIC)
                    {
                        _loc_3.kinematicDelaySleep = true;
                    }
                    if (_loc_3.component.sleeping)
                    {
                        really_wake(_loc_3, false);
                    }
                }
            }
            bphase.insert(param1);
            param1.addedToSpace();
            return;
        }// end function

        public function add_callbackset(param1:ZPP_CallbackSet) : void
        {
            var _loc_4:* = null as ZNPNode_ZPP_CallbackSet;
            var _loc_2:* = param1.int1.cbsets;
            if (ZNPNode_ZPP_CallbackSet.zpp_pool == null)
            {
                _loc_4 = new ZNPNode_ZPP_CallbackSet();
            }
            else
            {
                _loc_4 = ZNPNode_ZPP_CallbackSet.zpp_pool;
                ZNPNode_ZPP_CallbackSet.zpp_pool = _loc_4.next;
                _loc_4.next = null;
            }
            _loc_4.elt = param1;
            var _loc_3:* = _loc_4;
            _loc_3.next = _loc_2.head;
            _loc_2.head = _loc_3;
            _loc_2.modified = true;
            (_loc_2.length + 1);
            _loc_2 = param1.int2.cbsets;
            if (ZNPNode_ZPP_CallbackSet.zpp_pool == null)
            {
                _loc_4 = new ZNPNode_ZPP_CallbackSet();
            }
            else
            {
                _loc_4 = ZNPNode_ZPP_CallbackSet.zpp_pool;
                ZNPNode_ZPP_CallbackSet.zpp_pool = _loc_4.next;
                _loc_4.next = null;
            }
            _loc_4.elt = param1;
            _loc_3 = _loc_4;
            _loc_3.next = _loc_2.head;
            _loc_2.head = _loc_3;
            _loc_2.modified = true;
            (_loc_2.length + 1);
            var _loc_5:* = callbackset_list;
            param1._inuse = true;
            var _loc_6:* = param1;
            _loc_6.next = _loc_5.next;
            _loc_5.next = _loc_6;
            _loc_5.modified = true;
            (_loc_5.length + 1);
            return;
        }// end function

        public function addListener(param1:ZPP_Listener) : void
        {
            param1.space = this;
            param1.addedToSpace();
            if (param1.interaction != null)
            {
            }
            return;
        }// end function

        public function addConstraint(param1:ZPP_Constraint) : void
        {
            param1.space = this;
            param1.addedToSpace();
            if (param1.active)
            {
                param1.component.sleeping = true;
                wake_constraint(param1, true);
            }
            return;
        }// end function

        public function addCompound(param1:ZPP_Compound) : void
        {
            var _loc_3:* = null as ZPP_Body;
            var _loc_5:* = null as ZPP_Constraint;
            var _loc_7:* = null as ZPP_Compound;
            param1.space = this;
            param1.addedToSpace();
            var _loc_2:* = param1.bodies.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                addBody(_loc_3);
                _loc_2 = _loc_2.next;
            }
            var _loc_4:* = param1.constraints.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                addConstraint(_loc_5);
                _loc_4 = _loc_4.next;
            }
            var _loc_6:* = param1.compounds.head;
            while (_loc_6 != null)
            {
                
                _loc_7 = _loc_6.elt;
                addCompound(_loc_7);
                _loc_6 = _loc_6.next;
            }
            return;
        }// end function

        public function addBody(param1:ZPP_Body, param2:int = -1) : void
        {
            var _loc_5:* = null as ZPP_Shape;
            param1.space = this;
            param1.addedToSpace();
            param1.component.sleeping = true;
            var _loc_3:* = param1;
            if (!_loc_3.world)
            {
                _loc_3.component.waket = stamp + (midstep ? (0) : (1));
                if (_loc_3.type == ZPP_Flags.id_BodyType_KINEMATIC)
                {
                    _loc_3.kinematicDelaySleep = true;
                }
                if (_loc_3.component.sleeping)
                {
                    really_wake(_loc_3, true);
                }
            }
            var _loc_4:* = param1.shapes.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                bphase.insert(_loc_5);
                _loc_5.addedToSpace();
                _loc_4 = _loc_4.next;
            }
            if (param1.type == ZPP_Flags.id_BodyType_STATIC)
            {
                static_validation(param1);
            }
            else if (param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
            }
            else if (param2 != ZPP_Flags.id_BodyType_KINEMATIC)
            {
                kinematics.add(param1);
            }
            return;
        }// end function

        public function MRCA_chains(param1:ZPP_Shape, param2:ZPP_Shape) : void
        {
            var _loc_3:* = null as ZNPList_ZPP_Interactor;
            var _loc_4:* = null as ZNPNode_ZPP_Interactor;
            var _loc_5:* = null as ZNPNode_ZPP_Interactor;
            var _loc_6:* = null as ZPP_Interactor;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            _loc_3 = mrca1;
            while (_loc_3.head != null)
            {
                
                _loc_4 = _loc_3.head;
                _loc_3.head = _loc_4.next;
                _loc_5 = _loc_4;
                _loc_5.elt = null;
                _loc_5.next = ZNPNode_ZPP_Interactor.zpp_pool;
                ZNPNode_ZPP_Interactor.zpp_pool = _loc_5;
                if (_loc_3.head == null)
                {
                    _loc_3.pushmod = true;
                }
                _loc_3.modified = true;
                (_loc_3.length - 1);
            }
            _loc_3.pushmod = true;
            _loc_3 = mrca2;
            while (_loc_3.head != null)
            {
                
                _loc_4 = _loc_3.head;
                _loc_3.head = _loc_4.next;
                _loc_5 = _loc_4;
                _loc_5.elt = null;
                _loc_5.next = ZNPNode_ZPP_Interactor.zpp_pool;
                ZNPNode_ZPP_Interactor.zpp_pool = _loc_5;
                if (_loc_3.head == null)
                {
                    _loc_3.pushmod = true;
                }
                _loc_3.modified = true;
                (_loc_3.length - 1);
            }
            _loc_3.pushmod = true;
            if (param1.cbSet != null)
            {
                _loc_3 = mrca1;
                if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                {
                    _loc_5 = new ZNPNode_ZPP_Interactor();
                }
                else
                {
                    _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.elt = param1;
                _loc_4 = _loc_5;
                _loc_4.next = _loc_3.head;
                _loc_3.head = _loc_4;
                _loc_3.modified = true;
                (_loc_3.length + 1);
            }
            if (param1.body.cbSet != null)
            {
                _loc_3 = mrca1;
                _loc_6 = param1.body;
                if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                {
                    _loc_5 = new ZNPNode_ZPP_Interactor();
                }
                else
                {
                    _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.elt = _loc_6;
                _loc_4 = _loc_5;
                _loc_4.next = _loc_3.head;
                _loc_3.head = _loc_4;
                _loc_3.modified = true;
                (_loc_3.length + 1);
            }
            if (param2.cbSet != null)
            {
                _loc_3 = mrca2;
                if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                {
                    _loc_5 = new ZNPNode_ZPP_Interactor();
                }
                else
                {
                    _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.elt = param2;
                _loc_4 = _loc_5;
                _loc_4.next = _loc_3.head;
                _loc_3.head = _loc_4;
                _loc_3.modified = true;
                (_loc_3.length + 1);
            }
            if (param2.body.cbSet != null)
            {
                _loc_3 = mrca2;
                _loc_6 = param2.body;
                if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                {
                    _loc_5 = new ZNPNode_ZPP_Interactor();
                }
                else
                {
                    _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                    ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.elt = _loc_6;
                _loc_4 = _loc_5;
                _loc_4.next = _loc_3.head;
                _loc_3.head = _loc_4;
                _loc_3.modified = true;
                (_loc_3.length + 1);
            }
            var _loc_7:* = param1.body.compound;
            var _loc_8:* = param2.body.compound;
            while (_loc_7 != _loc_8)
            {
                
                if (_loc_7 == null)
                {
                    _loc_9 = 0;
                }
                else
                {
                    _loc_9 = _loc_7.depth;
                }
                if (_loc_8 == null)
                {
                    _loc_10 = 0;
                }
                else
                {
                    _loc_10 = _loc_8.depth;
                }
                if (_loc_9 < _loc_10)
                {
                    if (_loc_8.cbSet != null)
                    {
                        _loc_3 = mrca2;
                        if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                            _loc_5 = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                            _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                            ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                            _loc_5.next = null;
                        }
                        _loc_5.elt = _loc_8;
                        _loc_4 = _loc_5;
                        _loc_4.next = _loc_3.head;
                        _loc_3.head = _loc_4;
                        _loc_3.modified = true;
                        (_loc_3.length + 1);
                    }
                    _loc_8 = _loc_8.compound;
                    continue;
                }
                if (_loc_7.cbSet != null)
                {
                    _loc_3 = mrca1;
                    if (ZNPNode_ZPP_Interactor.zpp_pool == null)
                    {
                        _loc_5 = new ZNPNode_ZPP_Interactor();
                    }
                    else
                    {
                        _loc_5 = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc_5.next;
                        _loc_5.next = null;
                    }
                    _loc_5.elt = _loc_7;
                    _loc_4 = _loc_5;
                    _loc_4.next = _loc_3.head;
                    _loc_3.head = _loc_4;
                    _loc_3.modified = true;
                    (_loc_3.length + 1);
                }
                _loc_7 = _loc_7.compound;
            }
            return;
        }// end function

    }
}
