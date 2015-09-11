package nape.constraint
{
    import flash.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.space.*;
    import zpp_nape.constraint.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;

    final public class MotorJoint extends Constraint
    {
        public var zpp_inner_zn:ZPP_MotorJoint;

        public function MotorJoint(param1:Body = undefined, param2:Body = undefined, param3:Number = 0, param4:Number = 1) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null as ZPP_Body;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner_zn = null;
            zpp_inner_zn = new ZPP_MotorJoint();
            zpp_inner = zpp_inner_zn;
            zpp_inner.outer = this;
            zpp_inner_zn.outer_zn = this;
            ;
            _loc_6 = this;
            zpp_inner.immutable_midstep("Constraint::" + "body1");
            if (param1 == null)
            {
                _loc_7 = null;
            }
            else
            {
                _loc_7 = param1.zpp_inner;
            }
            if (_loc_7 != zpp_inner_zn.b1)
            {
                if (zpp_inner_zn.b1 != null)
                {
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                    }
                    if (zpp_inner_zn.b2 != zpp_inner_zn.b1)
                    {
                        if (zpp_inner_zn.b1 != null)
                        {
                            zpp_inner_zn.b1.constraints.remove(zpp_inner);
                        }
                    }
                    if (zpp_inner.active)
                    {
                    }
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                        zpp_inner_zn.b1.wake();
                    }
                }
                zpp_inner_zn.b1 = _loc_7;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_7 != null)
                {
                }
                if (zpp_inner_zn.b2 != _loc_7)
                {
                    if (_loc_7 != null)
                    {
                        _loc_7.constraints.add(zpp_inner);
                    }
                }
                if (zpp_inner.active)
                {
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.wake();
                    if (_loc_7 != null)
                    {
                        _loc_7.wake();
                    }
                }
            }
            if (zpp_inner_zn.b1 == null)
            {
            }
            else
            {
            }
            zpp_inner.immutable_midstep("Constraint::" + "body2");
            if (param2 == null)
            {
                _loc_7 = null;
            }
            else
            {
                _loc_7 = param2.zpp_inner;
            }
            if (_loc_7 != zpp_inner_zn.b2)
            {
                if (zpp_inner_zn.b2 != null)
                {
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                    }
                    if (zpp_inner_zn.b1 != zpp_inner_zn.b2)
                    {
                        if (zpp_inner_zn.b2 != null)
                        {
                            zpp_inner_zn.b2.constraints.remove(zpp_inner);
                        }
                    }
                    if (zpp_inner.active)
                    {
                    }
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                        zpp_inner_zn.b2.wake();
                    }
                }
                zpp_inner_zn.b2 = _loc_7;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_7 != null)
                {
                }
                if (zpp_inner_zn.b1 != _loc_7)
                {
                    if (_loc_7 != null)
                    {
                        _loc_7.constraints.add(zpp_inner);
                    }
                }
                if (zpp_inner.active)
                {
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.wake();
                    if (_loc_7 != null)
                    {
                        _loc_7.wake();
                    }
                }
            }
            if (zpp_inner_zn.b2 == null)
            {
            }
            else
            {
            }
            zpp_inner.immutable_midstep("MotorJoint::rate");
            if (param3 != param3)
            {
                throw "Error: MotorJoint::rate cannot be NaN";
            }
            if (zpp_inner_zn.rate != param3)
            {
                zpp_inner_zn.rate = param3;
                zpp_inner.wake();
            }
            zpp_inner.immutable_midstep("MotorJoint::ratio");
            if (param4 != param4)
            {
                throw "Error: MotorJoint::ratio cannot be NaN";
            }
            if (zpp_inner_zn.ratio != param4)
            {
                zpp_inner_zn.ratio = param4;
                zpp_inner.wake();
            }
            return;
        }// end function

        override public function visitBodies(param1:Function) : void
        {
            if ((zpp_inner_zn.b1 == null ? (null) : (zpp_inner_zn.b1.outer)) != null)
            {
                this.param1(zpp_inner_zn.b1 == null ? (null) : (zpp_inner_zn.b1.outer));
            }
            if ((zpp_inner_zn.b2 == null ? (null) : (zpp_inner_zn.b2.outer)) != null)
            {
            }
            if ((zpp_inner_zn.b2 == null ? (null) : (zpp_inner_zn.b2.outer)) != (zpp_inner_zn.b1 == null ? (null) : (zpp_inner_zn.b1.outer)))
            {
                this.param1(zpp_inner_zn.b2 == null ? (null) : (zpp_inner_zn.b2.outer));
            }
            return;
        }// end function

        public function set_ratio(param1:Number) : Number
        {
            zpp_inner.immutable_midstep("MotorJoint::ratio");
            if (param1 != param1)
            {
                throw "Error: MotorJoint::ratio cannot be NaN";
            }
            if (zpp_inner_zn.ratio != param1)
            {
                zpp_inner_zn.ratio = param1;
                zpp_inner.wake();
            }
            return zpp_inner_zn.ratio;
        }// end function

        public function set_rate(param1:Number) : Number
        {
            zpp_inner.immutable_midstep("MotorJoint::rate");
            if (param1 != param1)
            {
                throw "Error: MotorJoint::rate cannot be NaN";
            }
            if (zpp_inner_zn.rate != param1)
            {
                zpp_inner_zn.rate = param1;
                zpp_inner.wake();
            }
            return zpp_inner_zn.rate;
        }// end function

        public function set_body2(param1:Body) : Body
        {
            var _loc_2:* = null as ZPP_Body;
            zpp_inner.immutable_midstep("Constraint::" + "body2");
            if (param1 == null)
            {
                _loc_2 = null;
            }
            else
            {
                _loc_2 = param1.zpp_inner;
            }
            if (_loc_2 != zpp_inner_zn.b2)
            {
                if (zpp_inner_zn.b2 != null)
                {
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                    }
                    if (zpp_inner_zn.b1 != zpp_inner_zn.b2)
                    {
                        if (zpp_inner_zn.b2 != null)
                        {
                            zpp_inner_zn.b2.constraints.remove(zpp_inner);
                        }
                    }
                    if (zpp_inner.active)
                    {
                    }
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                        zpp_inner_zn.b2.wake();
                    }
                }
                zpp_inner_zn.b2 = _loc_2;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_2 != null)
                {
                }
                if (zpp_inner_zn.b1 != _loc_2)
                {
                    if (_loc_2 != null)
                    {
                        _loc_2.constraints.add(zpp_inner);
                    }
                }
                if (zpp_inner.active)
                {
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.wake();
                    if (_loc_2 != null)
                    {
                        _loc_2.wake();
                    }
                }
            }
            if (zpp_inner_zn.b2 == null)
            {
                return null;
            }
            else
            {
                return zpp_inner_zn.b2.outer;
            }
        }// end function

        public function set_body1(param1:Body) : Body
        {
            var _loc_2:* = null as ZPP_Body;
            zpp_inner.immutable_midstep("Constraint::" + "body1");
            if (param1 == null)
            {
                _loc_2 = null;
            }
            else
            {
                _loc_2 = param1.zpp_inner;
            }
            if (_loc_2 != zpp_inner_zn.b1)
            {
                if (zpp_inner_zn.b1 != null)
                {
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                    }
                    if (zpp_inner_zn.b2 != zpp_inner_zn.b1)
                    {
                        if (zpp_inner_zn.b1 != null)
                        {
                            zpp_inner_zn.b1.constraints.remove(zpp_inner);
                        }
                    }
                    if (zpp_inner.active)
                    {
                    }
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                        zpp_inner_zn.b1.wake();
                    }
                }
                zpp_inner_zn.b1 = _loc_2;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_2 != null)
                {
                }
                if (zpp_inner_zn.b2 != _loc_2)
                {
                    if (_loc_2 != null)
                    {
                        _loc_2.constraints.add(zpp_inner);
                    }
                }
                if (zpp_inner.active)
                {
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.wake();
                    if (_loc_2 != null)
                    {
                        _loc_2.wake();
                    }
                }
            }
            if (zpp_inner_zn.b1 == null)
            {
                return null;
            }
            else
            {
                return zpp_inner_zn.b1.outer;
            }
        }// end function

        override public function impulse() : MatMN
        {
            var _loc_1:* = new MatMN(1, 1);
            if (_loc_1.zpp_inner.m > 0)
            {
            }
            if (_loc_1.zpp_inner.n <= 0)
            {
                throw "Error: MatMN indices out of range";
            }
            _loc_1.zpp_inner.x[0 * _loc_1.zpp_inner.n] = zpp_inner_zn.jAcc;
            return _loc_1;
        }// end function

        public function get_ratio() : Number
        {
            return zpp_inner_zn.ratio;
        }// end function

        public function get_rate() : Number
        {
            return zpp_inner_zn.rate;
        }// end function

        public function get_body2() : Body
        {
            if (zpp_inner_zn.b2 == null)
            {
                return null;
            }
            else
            {
                return zpp_inner_zn.b2.outer;
            }
        }// end function

        public function get_body1() : Body
        {
            if (zpp_inner_zn.b1 == null)
            {
                return null;
            }
            else
            {
                return zpp_inner_zn.b1.outer;
            }
        }// end function

        override public function bodyImpulse(param1:Body) : Vec3
        {
            if (param1 == null)
            {
                throw "Error: Cannot evaluate impulse on null body";
            }
            if (param1 != (zpp_inner_zn.b1 == null ? (null) : (zpp_inner_zn.b1.outer)))
            {
            }
            if (param1 != (zpp_inner_zn.b2 == null ? (null) : (zpp_inner_zn.b2.outer)))
            {
                throw "Error: Body is not linked to this constraint";
            }
            if (!zpp_inner.active)
            {
                return Vec3.get();
            }
            else
            {
                return zpp_inner_zn.bodyImpulse(param1.zpp_inner);
            }
        }// end function

    }
}
