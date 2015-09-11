package zpp_nape.dynamics
{
    import flash.*;
    import nape.dynamics.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_Arbiter extends Object
    {
        public var ws2:ZPP_Shape;
        public var ws1:ZPP_Shape;
        public var up_stamp:int;
        public var type:int;
        public var stamp:int;
        public var sleeping:Boolean;
        public var sleep_stamp:int;
        public var sensorarb:ZPP_SensorArbiter;
        public var presentable:Boolean;
        public var present:int;
        public var pair:ZPP_AABBPair;
        public var outer:Arbiter;
        public var invalidated:Boolean;
        public var intchange:Boolean;
        public var immState:int;
        public var id:int;
        public var hnext:ZPP_Arbiter;
        public var fresh:Boolean;
        public var fluidarb:ZPP_FluidArbiter;
        public var endGenerated:int;
        public var di:int;
        public var continuous:Boolean;
        public var colarb:ZPP_ColArbiter;
        public var cleared:Boolean;
        public var b2:ZPP_Body;
        public var b1:ZPP_Body;
        public var active:Boolean;
        public static var init__:Boolean;
        public static var internal:Boolean;
        public static var COL:int;
        public static var FLUID:int;
        public static var SENSOR:int;
        public static var types:Array;

        public function ZPP_Arbiter() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            sensorarb = null;
            fluidarb = null;
            colarb = null;
            type = 0;
            pair = null;
            ws2 = null;
            ws1 = null;
            b2 = null;
            b1 = null;
            invalidated = false;
            immState = 0;
            fresh = false;
            continuous = false;
            presentable = false;
            intchange = false;
            present = 0;
            sleeping = false;
            cleared = false;
            active = false;
            endGenerated = 0;
            sleep_stamp = 0;
            up_stamp = 0;
            stamp = 0;
            di = 0;
            id = 0;
            hnext = null;
            outer = null;
            return;
        }// end function

        public function wrapper() : Arbiter
        {
            if (outer == null)
            {
                ZPP_Arbiter.internal = true;
                if (type == ZPP_Arbiter.COL)
                {
                    colarb.outer_zn = new CollisionArbiter();
                    outer = colarb.outer_zn;
                }
                else if (type == ZPP_Arbiter.FLUID)
                {
                    fluidarb.outer_zn = new FluidArbiter();
                    outer = fluidarb.outer_zn;
                }
                else
                {
                    outer = new Arbiter();
                }
                outer.zpp_inner = this;
                ZPP_Arbiter.internal = false;
            }
            return outer;
        }// end function

        public function swap_features() : void
        {
            var _loc_1:* = b1;
            b1 = b2;
            b2 = _loc_1;
            var _loc_2:* = ws1;
            ws1 = ws2;
            ws2 = _loc_2;
            _loc_2 = colarb.s1;
            colarb.s1 = colarb.s2;
            colarb.s2 = _loc_2;
            return;
        }// end function

        public function sup_retire() : void
        {
            var _loc_1:* = null as ZNPList_ZPP_Arbiter;
            var _loc_2:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_3:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_4:* = false;
            var _loc_5:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_6:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            if (!cleared)
            {
                _loc_1 = b1.arbiters;
                _loc_2 = null;
                _loc_3 = _loc_1.head;
                _loc_4 = false;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3.elt == this)
                    {
                        if (_loc_2 == null)
                        {
                            _loc_5 = _loc_1.head;
                            _loc_6 = _loc_5.next;
                            _loc_1.head = _loc_6;
                            if (_loc_1.head == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_5 = _loc_2.next;
                            _loc_6 = _loc_5.next;
                            _loc_2.next = _loc_6;
                            if (_loc_6 == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        _loc_7 = _loc_5;
                        _loc_7.elt = null;
                        _loc_7.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7;
                        _loc_1.modified = true;
                        (_loc_1.length - 1);
                        _loc_1.pushmod = true;
                        _loc_4 = true;
                        break;
                    }
                    _loc_2 = _loc_3;
                    _loc_3 = _loc_3.next;
                }
                _loc_1 = b2.arbiters;
                _loc_2 = null;
                _loc_3 = _loc_1.head;
                _loc_4 = false;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3.elt == this)
                    {
                        if (_loc_2 == null)
                        {
                            _loc_5 = _loc_1.head;
                            _loc_6 = _loc_5.next;
                            _loc_1.head = _loc_6;
                            if (_loc_1.head == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_5 = _loc_2.next;
                            _loc_6 = _loc_5.next;
                            _loc_2.next = _loc_6;
                            if (_loc_6 == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        _loc_7 = _loc_5;
                        _loc_7.elt = null;
                        _loc_7.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7;
                        _loc_1.modified = true;
                        (_loc_1.length - 1);
                        _loc_1.pushmod = true;
                        _loc_4 = true;
                        break;
                    }
                    _loc_2 = _loc_3;
                    _loc_3 = _loc_3.next;
                }
                if (pair != null)
                {
                    pair.arb = null;
                    pair = null;
                }
            }
            var _loc_8:* = null;
            b2 = null;
            b1 = _loc_8;
            active = false;
            intchange = false;
            return;
        }// end function

        public function sup_assign(param1:ZPP_Shape, param2:ZPP_Shape, param3:int, param4:int) : void
        {
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            b1 = param1.body;
            ws1 = param1;
            b2 = param2.body;
            ws2 = param2;
            id = param3;
            di = param4;
            var _loc_5:* = b1.arbiters;
            if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
            {
                _loc_7 = new ZNPNode_ZPP_Arbiter();
            }
            else
            {
                _loc_7 = ZNPNode_ZPP_Arbiter.zpp_pool;
                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7.next;
                _loc_7.next = null;
            }
            _loc_7.elt = this;
            var _loc_6:* = _loc_7;
            _loc_6.next = _loc_5.head;
            _loc_5.head = _loc_6;
            _loc_5.modified = true;
            (_loc_5.length + 1);
            _loc_5 = b2.arbiters;
            if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
            {
                _loc_7 = new ZNPNode_ZPP_Arbiter();
            }
            else
            {
                _loc_7 = ZNPNode_ZPP_Arbiter.zpp_pool;
                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7.next;
                _loc_7.next = null;
            }
            _loc_7.elt = this;
            _loc_6 = _loc_7;
            _loc_6.next = _loc_5.head;
            _loc_5.head = _loc_6;
            _loc_5.modified = true;
            (_loc_5.length + 1);
            active = true;
            present = 0;
            cleared = false;
            sleeping = false;
            fresh = false;
            presentable = false;
            return;
        }// end function

        public function lazyRetire(param1:ZPP_Space, param2:ZPP_Body = undefined) : void
        {
            var _loc_3:* = null as ZNPList_ZPP_Arbiter;
            var _loc_4:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_5:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_6:* = false;
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_8:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_9:* = null as ZNPNode_ZPP_Arbiter;
            cleared = true;
            if (param2 != null)
            {
            }
            if (b2 == param2)
            {
                _loc_3 = b1.arbiters;
                _loc_4 = null;
                _loc_5 = _loc_3.head;
                _loc_6 = false;
                while (_loc_5 != null)
                {
                    
                    if (_loc_5.elt == this)
                    {
                        if (_loc_4 == null)
                        {
                            _loc_7 = _loc_3.head;
                            _loc_8 = _loc_7.next;
                            _loc_3.head = _loc_8;
                            if (_loc_3.head == null)
                            {
                                _loc_3.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_7 = _loc_4.next;
                            _loc_8 = _loc_7.next;
                            _loc_4.next = _loc_8;
                            if (_loc_8 == null)
                            {
                                _loc_3.pushmod = true;
                            }
                        }
                        _loc_9 = _loc_7;
                        _loc_9.elt = null;
                        _loc_9.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc_9;
                        _loc_3.modified = true;
                        (_loc_3.length - 1);
                        _loc_3.pushmod = true;
                        _loc_6 = true;
                        break;
                    }
                    _loc_4 = _loc_5;
                    _loc_5 = _loc_5.next;
                }
            }
            if (param2 != null)
            {
            }
            if (b1 == param2)
            {
                _loc_3 = b2.arbiters;
                _loc_4 = null;
                _loc_5 = _loc_3.head;
                _loc_6 = false;
                while (_loc_5 != null)
                {
                    
                    if (_loc_5.elt == this)
                    {
                        if (_loc_4 == null)
                        {
                            _loc_7 = _loc_3.head;
                            _loc_8 = _loc_7.next;
                            _loc_3.head = _loc_8;
                            if (_loc_3.head == null)
                            {
                                _loc_3.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_7 = _loc_4.next;
                            _loc_8 = _loc_7.next;
                            _loc_4.next = _loc_8;
                            if (_loc_8 == null)
                            {
                                _loc_3.pushmod = true;
                            }
                        }
                        _loc_9 = _loc_7;
                        _loc_9.elt = null;
                        _loc_9.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc_9;
                        _loc_3.modified = true;
                        (_loc_3.length - 1);
                        _loc_3.pushmod = true;
                        _loc_6 = true;
                        break;
                    }
                    _loc_4 = _loc_5;
                    _loc_5 = _loc_5.next;
                }
            }
            if (pair != null)
            {
                pair.arb = null;
                pair = null;
            }
            active = false;
            param1.f_arbiters.modified = true;
            return;
        }// end function

        public function inactiveme() : Boolean
        {
            return !active;
        }// end function

        public function acting() : Boolean
        {
            if (active)
            {
            }
            return (immState & ZPP_Flags.id_ImmState_ACCEPT) != 0;
        }// end function

    }
}
