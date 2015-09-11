package nape.constraint
{
    import flash.*;
    import nape.callbacks.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.space.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.constraint.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;

    public class Constraint extends Object
    {
        public var zpp_inner:ZPP_Constraint;
        public var debugDraw:Boolean;

        public function Constraint() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            debugDraw = true;
            zpp_inner.insert_cbtype(ZPP_CbType.ANY_CONSTRAINT.zpp_inner);
            throw "Error: Constraint cannot be instantiated derp!";
            return;
        }// end function

        public function visitBodies(param1:Function) : void
        {
            return;
        }// end function

        public function toString() : String
        {
            return "{Constraint}";
        }// end function

        public function set_stiff(param1:Boolean) : Boolean
        {
            if (zpp_inner.stiff != param1)
            {
                zpp_inner.stiff = param1;
                zpp_inner.wake();
            }
            return zpp_inner.stiff;
        }// end function

        public function set_space(param1:Space) : Space
        {
            var _loc_2:* = null as ConstraintList;
            if (zpp_inner.compound != null)
            {
                throw "Error: Cannot set the space of a Constraint belonging to" + " a Compound, only the root Compound space can be set";
            }
            if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != param1)
            {
                if (zpp_inner.component != null)
                {
                    zpp_inner.component.woken = false;
                }
                zpp_inner.clearcache();
                if (zpp_inner.space != null)
                {
                    zpp_inner.space.outer.zpp_inner.wrap_constraints.remove(this);
                }
                if (param1 != null)
                {
                    _loc_2 = param1.zpp_inner.wrap_constraints;
                    if (_loc_2.zpp_inner.reverse_flag)
                    {
                        _loc_2.push(this);
                    }
                    else
                    {
                        _loc_2.unshift(this);
                    }
                }
                else
                {
                    zpp_inner.space = null;
                }
            }
            if (zpp_inner.space == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.space.outer;
            }
        }// end function

        public function set_removeOnBreak(param1:Boolean) : Boolean
        {
            zpp_inner.removeOnBreak = param1;
            return zpp_inner.removeOnBreak;
        }// end function

        public function set_maxForce(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: Constraint::maxForce cannot be NaN";
            }
            if (param1 < 0)
            {
                throw "Error: Constraint::maxForce must be >=0";
            }
            if (zpp_inner.maxForce != param1)
            {
                zpp_inner.maxForce = param1;
                zpp_inner.wake();
            }
            return zpp_inner.maxForce;
        }// end function

        public function set_maxError(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: Constraint::maxError cannot be NaN";
            }
            if (param1 < 0)
            {
                throw "Error: Constraint::maxError must be >=0";
            }
            if (zpp_inner.maxError != param1)
            {
                zpp_inner.maxError = param1;
                zpp_inner.wake();
            }
            return zpp_inner.maxError;
        }// end function

        public function set_ignore(param1:Boolean) : Boolean
        {
            if (zpp_inner.ignore != param1)
            {
                zpp_inner.ignore = param1;
                zpp_inner.wake();
            }
            return zpp_inner.ignore;
        }// end function

        public function set_frequency(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: Constraint::Frequency cannot be NaN";
            }
            if (param1 <= 0)
            {
                throw "Error: Constraint::Frequency must be >0";
            }
            if (zpp_inner.frequency != param1)
            {
                zpp_inner.frequency = param1;
                if (!zpp_inner.stiff)
                {
                    zpp_inner.wake();
                }
            }
            return zpp_inner.frequency;
        }// end function

        public function set_damping(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: Constraint::Damping cannot be Nan";
            }
            if (param1 < 0)
            {
                throw "Error: Constraint::Damping must be >=0";
            }
            if (zpp_inner.damping != param1)
            {
                zpp_inner.damping = param1;
                if (!zpp_inner.stiff)
                {
                    zpp_inner.wake();
                }
            }
            return zpp_inner.damping;
        }// end function

        public function set_compound(param1:Compound) : Compound
        {
            var _loc_2:* = null as ConstraintList;
            if ((zpp_inner.compound == null ? (null) : (zpp_inner.compound.outer)) != param1)
            {
                if ((zpp_inner.compound == null ? (null) : (zpp_inner.compound.outer)) != null)
                {
                    (zpp_inner.compound == null ? (null) : (zpp_inner.compound.outer)).zpp_inner.wrap_constraints.remove(this);
                }
                if (param1 != null)
                {
                    _loc_2 = param1.zpp_inner.wrap_constraints;
                    if (_loc_2.zpp_inner.reverse_flag)
                    {
                        _loc_2.push(this);
                    }
                    else
                    {
                        _loc_2.unshift(this);
                    }
                }
            }
            if (zpp_inner.compound == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.compound.outer;
            }
        }// end function

        public function set_breakUnderForce(param1:Boolean) : Boolean
        {
            if (zpp_inner.breakUnderForce != param1)
            {
                zpp_inner.breakUnderForce = param1;
                zpp_inner.wake();
            }
            return zpp_inner.breakUnderForce;
        }// end function

        public function set_breakUnderError(param1:Boolean) : Boolean
        {
            if (zpp_inner.breakUnderError != param1)
            {
                zpp_inner.breakUnderError = param1;
                zpp_inner.wake();
            }
            return zpp_inner.breakUnderError;
        }// end function

        public function set_active(param1:Boolean) : Boolean
        {
            if (zpp_inner.active != param1)
            {
                if (zpp_inner.component != null)
                {
                    zpp_inner.component.woken = false;
                }
                zpp_inner.clearcache();
                if (param1)
                {
                    zpp_inner.active = param1;
                    zpp_inner.activate();
                    if (zpp_inner.space != null)
                    {
                        if (zpp_inner.component != null)
                        {
                            zpp_inner.component.sleeping = true;
                        }
                        zpp_inner.space.wake_constraint(zpp_inner, true);
                    }
                }
                else
                {
                    if (zpp_inner.space != null)
                    {
                        zpp_inner.wake();
                        zpp_inner.space.live_constraints.remove(zpp_inner);
                    }
                    zpp_inner.active = param1;
                    zpp_inner.deactivate();
                }
            }
            return zpp_inner.active;
        }// end function

        public function impulse() : MatMN
        {
            return null;
        }// end function

        public function get_userData()
        {
            if (zpp_inner.userData == null)
            {
                zpp_inner.userData = {};
            }
            return zpp_inner.userData;
        }// end function

        public function get_stiff() : Boolean
        {
            return zpp_inner.stiff;
        }// end function

        public function get_space() : Space
        {
            if (zpp_inner.space == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.space.outer;
            }
        }// end function

        public function get_removeOnBreak() : Boolean
        {
            return zpp_inner.removeOnBreak;
        }// end function

        public function get_maxForce() : Number
        {
            return zpp_inner.maxForce;
        }// end function

        public function get_maxError() : Number
        {
            return zpp_inner.maxError;
        }// end function

        public function get_isSleeping() : Boolean
        {
            if (zpp_inner.space != null)
            {
            }
            if (!zpp_inner.active)
            {
                throw "Error: isSleeping only makes sense if constraint is" + " active and inside a space";
            }
            return zpp_inner.component.sleeping;
        }// end function

        public function get_ignore() : Boolean
        {
            return zpp_inner.ignore;
        }// end function

        public function get_frequency() : Number
        {
            return zpp_inner.frequency;
        }// end function

        public function get_damping() : Number
        {
            return zpp_inner.damping;
        }// end function

        public function get_compound() : Compound
        {
            if (zpp_inner.compound == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.compound.outer;
            }
        }// end function

        public function get_cbTypes() : CbTypeList
        {
            if (zpp_inner.wrap_cbTypes == null)
            {
                zpp_inner.setupcbTypes();
            }
            return zpp_inner.wrap_cbTypes;
        }// end function

        public function get_breakUnderForce() : Boolean
        {
            return zpp_inner.breakUnderForce;
        }// end function

        public function get_breakUnderError() : Boolean
        {
            return zpp_inner.breakUnderError;
        }// end function

        public function get_active() : Boolean
        {
            return zpp_inner.active;
        }// end function

        public function copy() : Constraint
        {
            return zpp_inner.copy();
        }// end function

        public function bodyImpulse(param1:Body) : Vec3
        {
            return null;
        }// end function

    }
}
