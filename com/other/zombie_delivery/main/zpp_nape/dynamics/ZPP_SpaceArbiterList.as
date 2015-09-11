package zpp_nape.dynamics
{
    import flash.*;
    import nape.dynamics.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_SpaceArbiterList extends ArbiterList
    {
        public var zip_length:Boolean;
        public var space:ZPP_Space;
        public var lengths:Array;
        public var ite_3:ZNPNode_ZPP_SensorArbiter;
        public var ite_2:ZNPNode_ZPP_FluidArbiter;
        public var ite_1:ZNPNode_ZPP_ColArbiter;
        public var ite_0:ZNPNode_ZPP_ColArbiter;
        public var at_index_3:int;
        public var at_index_2:int;
        public var at_index_1:int;
        public var at_index_0:int;
        public var _length:int;

        public function ZPP_SpaceArbiterList() : void
        {
            var _loc_2:* = 0;
            if (Boot.skip_constructor)
            {
                return;
            }
            at_index_3 = 0;
            at_index_2 = 0;
            at_index_1 = 0;
            at_index_0 = 0;
            ite_3 = null;
            ite_2 = null;
            ite_1 = null;
            ite_0 = null;
            lengths = null;
            zip_length = false;
            _length = 0;
            space = null;
            at_index_0 = 0;
            at_index_1 = 0;
            at_index_2 = 0;
            at_index_3 = 0;
            zip_length = true;
            _length = 0;
            lengths = [];
            var _loc_1:* = 0;
            while (_loc_1 < 4)
            {
                
                _loc_1++;
                _loc_2 = _loc_1;
                lengths.push(0);
            }
            return;
        }// end function

        override public function zpp_vm() : void
        {
            var _loc_1:* = false;
            if (space.c_arbiters_true.modified)
            {
                _loc_1 = true;
                space.c_arbiters_true.modified = false;
            }
            if (space.c_arbiters_false.modified)
            {
                _loc_1 = true;
                space.c_arbiters_false.modified = false;
            }
            if (space.f_arbiters.modified)
            {
                _loc_1 = true;
                space.f_arbiters.modified = false;
            }
            if (space.s_arbiters.modified)
            {
                _loc_1 = true;
                space.s_arbiters.modified = false;
            }
            if (_loc_1)
            {
                zip_length = true;
                _length = 0;
                ite_0 = null;
                ite_1 = null;
                ite_2 = null;
                ite_3 = null;
            }
            return;
        }// end function

        override public function zpp_gl() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_4:* = null as ZPP_ColArbiter;
            var _loc_5:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_6:* = null as ZPP_FluidArbiter;
            var _loc_7:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_8:* = null as ZPP_SensorArbiter;
            zpp_vm();
            if (zip_length)
            {
                _length = 0;
                _loc_1 = 0;
                _loc_2 = 0;
                _loc_3 = space.c_arbiters_true.head;
                while (_loc_3 != null)
                {
                    
                    _loc_4 = _loc_3.elt;
                    if (_loc_4.active)
                    {
                        _loc_2++;
                    }
                    _loc_3 = _loc_3.next;
                }
                _loc_1++;
                lengths[_loc_1] = _loc_2;
                _length = _length + _loc_2;
                _loc_2 = 0;
                _loc_3 = space.c_arbiters_false.head;
                while (_loc_3 != null)
                {
                    
                    _loc_4 = _loc_3.elt;
                    if (_loc_4.active)
                    {
                        _loc_2++;
                    }
                    _loc_3 = _loc_3.next;
                }
                _loc_1++;
                lengths[_loc_1] = _loc_2;
                _length = _length + _loc_2;
                _loc_2 = 0;
                _loc_5 = space.f_arbiters.head;
                while (_loc_5 != null)
                {
                    
                    _loc_6 = _loc_5.elt;
                    if (_loc_6.active)
                    {
                        _loc_2++;
                    }
                    _loc_5 = _loc_5.next;
                }
                _loc_1++;
                lengths[_loc_1] = _loc_2;
                _length = _length + _loc_2;
                _loc_2 = 0;
                _loc_7 = space.s_arbiters.head;
                while (_loc_7 != null)
                {
                    
                    _loc_8 = _loc_7.elt;
                    if (_loc_8.active)
                    {
                        _loc_2++;
                    }
                    _loc_7 = _loc_7.next;
                }
                _loc_1++;
                lengths[_loc_1] = _loc_2;
                _length = _length + _loc_2;
                zip_length = false;
            }
            return _length;
        }// end function

        override public function unshift(param1:Arbiter) : Boolean
        {
            throw "Error: ArbiterList is immutable";
            return false;
        }// end function

        override public function shift() : Arbiter
        {
            throw "Error: ArbiterList is immutable";
            return null;
        }// end function

        override public function remove(param1:Arbiter) : Boolean
        {
            throw "Error: ArbiterList is immutable";
            return false;
        }// end function

        override public function push(param1:Arbiter) : Boolean
        {
            throw "Error: ArbiterList is immutable";
            return false;
        }// end function

        override public function pop() : Arbiter
        {
            throw "Error: ArbiterList is immutable";
            return null;
        }// end function

        override public function clear() : void
        {
            throw "Error: ArbiterList is immutable";
            return;
        }// end function

        override public function at(param1:int) : Arbiter
        {
            var _loc_4:* = 0;
            var _loc_5:* = null as ZPP_ColArbiter;
            var _loc_6:* = null as ZPP_FluidArbiter;
            var _loc_7:* = null as ZPP_SensorArbiter;
            zpp_vm();
            if (param1 >= 0)
            {
            }
            if (param1 >= zpp_gl())
            {
                throw "Error: Index out of bounds";
            }
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (_loc_2 == null)
            {
                if (param1 < _loc_3 + lengths[0])
                {
                    _loc_4 = param1 - _loc_3;
                    if (_loc_4 >= at_index_0)
                    {
                    }
                    if (ite_0 == null)
                    {
                        at_index_0 = 0;
                        ite_0 = space.c_arbiters_true.head;
                        while (true)
                        {
                            
                            _loc_5 = ite_0.elt;
                            if (_loc_5.active)
                            {
                                break;
                            }
                            ite_0 = ite_0.next;
                        }
                    }
                    while (at_index_0 != _loc_4)
                    {
                        
                        (at_index_0 + 1);
                        ite_0 = ite_0.next;
                        while (true)
                        {
                            
                            _loc_5 = ite_0.elt;
                            if (_loc_5.active)
                            {
                                break;
                            }
                            ite_0 = ite_0.next;
                        }
                    }
                    _loc_2 = ite_0.elt.wrapper();
                }
                else
                {
                    _loc_3 = _loc_3 + lengths[0];
                }
            }
            if (_loc_2 == null)
            {
                if (param1 < _loc_3 + lengths[1])
                {
                    _loc_4 = param1 - _loc_3;
                    if (_loc_4 >= at_index_1)
                    {
                    }
                    if (ite_1 == null)
                    {
                        at_index_1 = 0;
                        ite_1 = space.c_arbiters_false.head;
                        while (true)
                        {
                            
                            _loc_5 = ite_1.elt;
                            if (_loc_5.active)
                            {
                                break;
                            }
                            ite_1 = ite_1.next;
                        }
                    }
                    while (at_index_1 != _loc_4)
                    {
                        
                        (at_index_1 + 1);
                        ite_1 = ite_1.next;
                        while (true)
                        {
                            
                            _loc_5 = ite_1.elt;
                            if (_loc_5.active)
                            {
                                break;
                            }
                            ite_1 = ite_1.next;
                        }
                    }
                    _loc_2 = ite_1.elt.wrapper();
                }
                else
                {
                    _loc_3 = _loc_3 + lengths[1];
                }
            }
            if (_loc_2 == null)
            {
                if (param1 < _loc_3 + lengths[2])
                {
                    _loc_4 = param1 - _loc_3;
                    if (_loc_4 >= at_index_2)
                    {
                    }
                    if (ite_2 == null)
                    {
                        at_index_2 = 0;
                        ite_2 = space.f_arbiters.head;
                        while (true)
                        {
                            
                            _loc_6 = ite_2.elt;
                            if (_loc_6.active)
                            {
                                break;
                            }
                            ite_2 = ite_2.next;
                        }
                    }
                    while (at_index_2 != _loc_4)
                    {
                        
                        (at_index_2 + 1);
                        ite_2 = ite_2.next;
                        while (true)
                        {
                            
                            _loc_6 = ite_2.elt;
                            if (_loc_6.active)
                            {
                                break;
                            }
                            ite_2 = ite_2.next;
                        }
                    }
                    _loc_2 = ite_2.elt.wrapper();
                }
                else
                {
                    _loc_3 = _loc_3 + lengths[2];
                }
            }
            if (_loc_2 == null)
            {
                if (param1 < _loc_3 + lengths[3])
                {
                    _loc_4 = param1 - _loc_3;
                    if (_loc_4 >= at_index_3)
                    {
                    }
                    if (ite_3 == null)
                    {
                        at_index_3 = 0;
                        ite_3 = space.s_arbiters.head;
                        while (true)
                        {
                            
                            _loc_7 = ite_3.elt;
                            if (_loc_7.active)
                            {
                                break;
                            }
                            ite_3 = ite_3.next;
                        }
                    }
                    while (at_index_3 != _loc_4)
                    {
                        
                        (at_index_3 + 1);
                        ite_3 = ite_3.next;
                        while (true)
                        {
                            
                            _loc_7 = ite_3.elt;
                            if (_loc_7.active)
                            {
                                break;
                            }
                            ite_3 = ite_3.next;
                        }
                    }
                    _loc_2 = ite_3.elt.wrapper();
                }
                else
                {
                    _loc_3 = _loc_3 + lengths[3];
                }
            }
            return _loc_2;
        }// end function

    }
}
