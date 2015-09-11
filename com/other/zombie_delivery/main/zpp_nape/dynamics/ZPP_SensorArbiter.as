package zpp_nape.dynamics
{
    import flash.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_SensorArbiter extends ZPP_Arbiter
    {
        public var next:ZPP_SensorArbiter;
        public static var zpp_pool:ZPP_SensorArbiter;

        public function ZPP_SensorArbiter() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            next = null;
            type = ZPP_Arbiter.SENSOR;
            sensorarb = this;
            return;
        }// end function

        public function retire() : void
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
            var _loc_9:* = this;
            _loc_9.next = ZPP_SensorArbiter.zpp_pool;
            ZPP_SensorArbiter.zpp_pool = _loc_9;
            return;
        }// end function

        public function makemutable() : void
        {
            return;
        }// end function

        public function makeimmutable() : void
        {
            return;
        }// end function

        public function free() : void
        {
            return;
        }// end function

        public function assign(param1:ZPP_Shape, param2:ZPP_Shape, param3:int, param4:int) : void
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

        public function alloc() : void
        {
            return;
        }// end function

    }
}
