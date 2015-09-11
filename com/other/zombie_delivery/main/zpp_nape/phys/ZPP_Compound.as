package zpp_nape.phys
{
    import flash.*;
    import nape.constraint.*;
    import nape.phys.*;
    import zpp_nape.constraint.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_Compound extends ZPP_Interactor
    {
        public var wrap_constraints:ConstraintList;
        public var wrap_compounds:CompoundList;
        public var wrap_bodies:BodyList;
        public var space:ZPP_Space;
        public var outer:Compound;
        public var depth:int;
        public var constraints:ZNPList_ZPP_Constraint;
        public var compounds:ZNPList_ZPP_Compound;
        public var compound:ZPP_Compound;
        public var bodies:ZNPList_ZPP_Body;

        public function ZPP_Compound() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            space = null;
            compound = null;
            depth = 0;
            wrap_compounds = null;
            wrap_constraints = null;
            wrap_bodies = null;
            compounds = null;
            constraints = null;
            bodies = null;
            outer = null;
            icompound = this;
            depth = 1;
            var _loc_1:* = this;
            bodies = new ZNPList_ZPP_Body();
            wrap_bodies = ZPP_BodyList.get(bodies);
            wrap_bodies.zpp_inner.adder = bodies_adder;
            wrap_bodies.zpp_inner.subber = bodies_subber;
            wrap_bodies.zpp_inner._modifiable = bodies_modifiable;
            constraints = new ZNPList_ZPP_Constraint();
            wrap_constraints = ZPP_ConstraintList.get(constraints);
            wrap_constraints.zpp_inner.adder = constraints_adder;
            wrap_constraints.zpp_inner.subber = constraints_subber;
            wrap_constraints.zpp_inner._modifiable = constraints_modifiable;
            compounds = new ZNPList_ZPP_Compound();
            wrap_compounds = ZPP_CompoundList.get(compounds);
            wrap_compounds.zpp_inner.adder = compounds_adder;
            wrap_compounds.zpp_inner.subber = compounds_subber;
            wrap_compounds.zpp_inner._modifiable = compounds_modifiable;
            return;
        }// end function

        public function removedFromSpace() : void
        {
            __iremovedFromSpace();
            return;
        }// end function

        public function copy(param1:Array = undefined, param2:Array = undefined) : Compound
        {
            var _loc_6:* = null as ZPP_Compound;
            var _loc_7:* = null as Compound;
            var _loc_8:* = null as CompoundList;
            var _loc_10:* = null as ZPP_Body;
            var _loc_11:* = null as Body;
            var _loc_12:* = null as BodyList;
            var _loc_14:* = null as ZPP_Constraint;
            var _loc_15:* = null as Constraint;
            var _loc_16:* = null as ConstraintList;
            var _loc_17:* = null as ZPP_CopyHelper;
            var _loc_18:* = 0;
            var _loc_19:* = null as ZPP_CopyHelper;
            var _loc_3:* = param1 == null;
            if (param1 == null)
            {
                param1 = [];
            }
            if (param2 == null)
            {
                param2 = [];
            }
            var _loc_4:* = new Compound();
            var _loc_5:* = compounds.head;
            while (_loc_5 != null)
            {
                
                _loc_6 = _loc_5.elt;
                _loc_7 = _loc_6.copy(param1, param2);
                _loc_7.zpp_inner.immutable_midstep("Compound::compound");
                if ((_loc_7.zpp_inner.compound == null ? (null) : (_loc_7.zpp_inner.compound.outer)) != _loc_4)
                {
                    if ((_loc_7.zpp_inner.compound == null ? (null) : (_loc_7.zpp_inner.compound.outer)) != null)
                    {
                        (_loc_7.zpp_inner.compound == null ? (null) : (_loc_7.zpp_inner.compound.outer)).zpp_inner.wrap_compounds.remove(_loc_7);
                    }
                    if (_loc_4 != null)
                    {
                        _loc_8 = _loc_4.zpp_inner.wrap_compounds;
                        if (_loc_8.zpp_inner.reverse_flag)
                        {
                            _loc_8.push(_loc_7);
                        }
                        else
                        {
                            _loc_8.unshift(_loc_7);
                        }
                    }
                }
                if (_loc_7.zpp_inner.compound == null)
                {
                }
                else
                {
                }
                _loc_5 = _loc_5.next;
            }
            var _loc_9:* = bodies.head;
            while (_loc_9 != null)
            {
                
                _loc_10 = _loc_9.elt;
                _loc_11 = _loc_10.outer.copy();
                param1.push(ZPP_CopyHelper.dict(_loc_10.id, _loc_11));
                if ((_loc_11.zpp_inner.compound == null ? (null) : (_loc_11.zpp_inner.compound.outer)) != _loc_4)
                {
                    if ((_loc_11.zpp_inner.compound == null ? (null) : (_loc_11.zpp_inner.compound.outer)) != null)
                    {
                        (_loc_11.zpp_inner.compound == null ? (null) : (_loc_11.zpp_inner.compound.outer)).zpp_inner.wrap_bodies.remove(_loc_11);
                    }
                    if (_loc_4 != null)
                    {
                        _loc_12 = _loc_4.zpp_inner.wrap_bodies;
                        if (_loc_12.zpp_inner.reverse_flag)
                        {
                            _loc_12.push(_loc_11);
                        }
                        else
                        {
                            _loc_12.unshift(_loc_11);
                        }
                    }
                }
                if (_loc_11.zpp_inner.compound == null)
                {
                }
                else
                {
                }
                _loc_9 = _loc_9.next;
            }
            var _loc_13:* = constraints.head;
            while (_loc_13 != null)
            {
                
                _loc_14 = _loc_13.elt;
                _loc_15 = _loc_14.copy(param1, param2);
                if ((_loc_15.zpp_inner.compound == null ? (null) : (_loc_15.zpp_inner.compound.outer)) != _loc_4)
                {
                    if ((_loc_15.zpp_inner.compound == null ? (null) : (_loc_15.zpp_inner.compound.outer)) != null)
                    {
                        (_loc_15.zpp_inner.compound == null ? (null) : (_loc_15.zpp_inner.compound.outer)).zpp_inner.wrap_constraints.remove(_loc_15);
                    }
                    if (_loc_4 != null)
                    {
                        _loc_16 = _loc_4.zpp_inner.wrap_constraints;
                        if (_loc_16.zpp_inner.reverse_flag)
                        {
                            _loc_16.push(_loc_15);
                        }
                        else
                        {
                            _loc_16.unshift(_loc_15);
                        }
                    }
                }
                if (_loc_15.zpp_inner.compound == null)
                {
                }
                else
                {
                }
                _loc_13 = _loc_13.next;
            }
            if (_loc_3)
            {
                while (param2.length > 0)
                {
                    
                    _loc_17 = param2.pop();
                    _loc_18 = 0;
                    while (_loc_18 < param1.length)
                    {
                        
                        _loc_19 = param1[_loc_18];
                        _loc_18++;
                        if (_loc_19.id == _loc_17.id)
                        {
                            _loc_17.cb(_loc_19.bc);
                            break;
                        }
                    }
                }
            }
            copyto(_loc_4);
            return _loc_4;
        }// end function

        public function constraints_subber(param1:Constraint) : void
        {
            param1.zpp_inner.compound = null;
            if (space != null)
            {
                space.remConstraint(param1.zpp_inner);
            }
            return;
        }// end function

        public function constraints_modifiable() : void
        {
            immutable_midstep("Compound::" + "constraints");
            return;
        }// end function

        public function constraints_adder(param1:Constraint) : Boolean
        {
            if (param1.zpp_inner.compound != this)
            {
                if (param1.zpp_inner.compound != null)
                {
                    param1.zpp_inner.compound.wrap_constraints.remove(param1);
                }
                else if (param1.zpp_inner.space != null)
                {
                    param1.zpp_inner.space.wrap_constraints.remove(param1);
                }
                param1.zpp_inner.compound = this;
                if (space != null)
                {
                    space.addConstraint(param1.zpp_inner);
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function compounds_subber(param1:Compound) : void
        {
            param1.zpp_inner.compound = null;
            param1.zpp_inner.depth = 1;
            if (space != null)
            {
                space.remCompound(param1.zpp_inner);
            }
            return;
        }// end function

        public function compounds_modifiable() : void
        {
            immutable_midstep("Compound::" + "compounds");
            return;
        }// end function

        public function compounds_adder(param1:Compound) : Boolean
        {
            var _loc_2:* = this;
            do
            {
                
                _loc_2 = _loc_2.compound;
                if (_loc_2 != null)
                {
                }
            }while (_loc_2 != param1.zpp_inner)
            if (_loc_2 == param1.zpp_inner)
            {
                throw "Error: Assignment would cause a cycle in the Compound tree: assigning " + param1.toString() + ".compound = " + outer.toString();
                return false;
            }
            if (param1.zpp_inner.compound != this)
            {
                if (param1.zpp_inner.compound != null)
                {
                    param1.zpp_inner.compound.wrap_compounds.remove(param1);
                }
                else if (param1.zpp_inner.space != null)
                {
                    param1.zpp_inner.space.wrap_compounds.remove(param1);
                }
                param1.zpp_inner.compound = this;
                param1.zpp_inner.depth = depth + 1;
                if (space != null)
                {
                    space.addCompound(param1.zpp_inner);
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function breakApart() : void
        {
            var _loc_1:* = null as ZPP_Body;
            var _loc_2:* = null as ZPP_Compound;
            var _loc_3:* = null as ZPP_Constraint;
            var _loc_4:* = null as ZPP_Compound;
            if (space != null)
            {
                __iremovedFromSpace();
                space.nullInteractorType(this);
            }
            if (compound != null)
            {
                compound.compounds.remove(this);
            }
            else if (space != null)
            {
                space.compounds.remove(this);
            }
            while (bodies.head != null)
            {
                
                _loc_1 = bodies.pop_unsafe();
                _loc_2 = compound;
                _loc_1.compound = _loc_2;
                if (_loc_2 != null)
                {
                    compound.bodies.add(_loc_1);
                }
                else if (space != null)
                {
                    space.bodies.add(_loc_1);
                }
                if (space != null)
                {
                    space.freshInteractorType(_loc_1);
                }
            }
            while (constraints.head != null)
            {
                
                _loc_3 = constraints.pop_unsafe();
                _loc_2 = compound;
                _loc_3.compound = _loc_2;
                if (_loc_2 != null)
                {
                    compound.constraints.add(_loc_3);
                    continue;
                }
                if (space != null)
                {
                    space.constraints.add(_loc_3);
                }
            }
            while (compounds.head != null)
            {
                
                _loc_2 = compounds.pop_unsafe();
                _loc_4 = compound;
                _loc_2.compound = _loc_4;
                if (_loc_4 != null)
                {
                    compound.compounds.add(_loc_2);
                }
                else if (space != null)
                {
                    space.compounds.add(_loc_2);
                }
                if (space != null)
                {
                    space.freshInteractorType(_loc_2);
                }
            }
            compound = null;
            space = null;
            return;
        }// end function

        public function bodies_subber(param1:Body) : void
        {
            param1.zpp_inner.compound = null;
            if (space != null)
            {
                space.remBody(param1.zpp_inner);
            }
            return;
        }// end function

        public function bodies_modifiable() : void
        {
            immutable_midstep("Compound::" + "bodies");
            return;
        }// end function

        public function bodies_adder(param1:Body) : Boolean
        {
            if (param1.zpp_inner.compound != this)
            {
                if (param1.zpp_inner.compound != null)
                {
                    param1.zpp_inner.compound.wrap_bodies.remove(param1);
                }
                else if (param1.zpp_inner.space != null)
                {
                    param1.zpp_inner.space.wrap_bodies.remove(param1);
                }
                param1.zpp_inner.compound = this;
                if (space != null)
                {
                    space.addBody(param1.zpp_inner);
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public function addedToSpace() : void
        {
            __iaddedToSpace();
            return;
        }// end function

        public function __imutable_midstep(param1:String) : void
        {
            if (space != null)
            {
            }
            if (space.midstep)
            {
                throw "Error: " + param1 + " cannot be set during space step()";
            }
            return;
        }// end function

    }
}
