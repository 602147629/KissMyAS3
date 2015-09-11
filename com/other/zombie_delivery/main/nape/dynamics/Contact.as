package nape.dynamics
{
    import flash.*;
    import nape.geom.*;
    import nape.phys.*;
    import zpp_nape.dynamics.*;

    final public class Contact extends Object
    {
        public var zpp_inner:ZPP_Contact;

        public function Contact() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (!ZPP_Contact.internal)
            {
                throw "Error: Cannot instantiate Contact derp!";
            }
            return;
        }// end function

        public function totalImpulse(param1:Body = undefined) : Vec3
        {
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            if (zpp_inner.inactiveme())
            {
                throw "Error: Contact not currently in use";
            }
            var _loc_2:* = zpp_inner.arbiter.colarb;
            var _loc_3:* = zpp_inner.inner;
            var _loc_4:* = _loc_3.jnAcc;
            var _loc_5:* = _loc_3.jtAcc;
            var _loc_6:* = _loc_2.jrAcc;
            if (param1 == null)
            {
                return Vec3.get(_loc_2.nx * _loc_4 - _loc_2.ny * _loc_5, _loc_2.ny * _loc_4 + _loc_2.nx * _loc_5, _loc_6);
            }
            else
            {
                if (param1 != _loc_2.b1.outer)
                {
                }
                if (param1 != _loc_2.b2.outer)
                {
                    throw "Error: Contact does not relate to the given body";
                }
                _loc_7 = _loc_2.nx * _loc_4 - _loc_2.ny * _loc_5;
                _loc_8 = _loc_2.ny * _loc_4 + _loc_2.nx * _loc_5;
                if (param1 == _loc_2.b1.outer)
                {
                    return Vec3.get(-_loc_7, -_loc_8, -(_loc_8 * _loc_3.r1x - _loc_7 * _loc_3.r1y) - _loc_6);
                }
                else
                {
                    return Vec3.get(_loc_7, _loc_8, _loc_8 * _loc_3.r2x - _loc_7 * _loc_3.r2y + _loc_6);
                }
            }
        }// end function

        public function toString() : String
        {
            if (zpp_inner.arbiter != null)
            {
            }
            if (zpp_inner.arbiter.cleared)
            {
                return "{object-pooled}";
            }
            else
            {
                return "{Contact}";
            }
        }// end function

        public function tangentImpulse(param1:Body = undefined) : Vec3
        {
            if (zpp_inner.inactiveme())
            {
                throw "Error: Contact not currently in use";
            }
            var _loc_2:* = zpp_inner.arbiter.colarb;
            var _loc_3:* = zpp_inner.inner;
            var _loc_4:* = _loc_3.jtAcc;
            if (param1 == null)
            {
                return Vec3.get((-_loc_2.ny) * _loc_4, _loc_2.nx * _loc_4);
            }
            else
            {
                if (param1 != _loc_2.b1.outer)
                {
                }
                if (param1 != _loc_2.b2.outer)
                {
                    throw "Error: Contact does not relate to the given body";
                }
                if (param1 == _loc_2.b1.outer)
                {
                    return Vec3.get(_loc_2.ny * _loc_4, (-_loc_2.nx) * _loc_4, (-(_loc_3.r1x * _loc_2.nx + _loc_3.r1y * _loc_2.ny)) * _loc_4);
                }
                else
                {
                    return Vec3.get((-_loc_2.ny) * _loc_4, _loc_2.nx * _loc_4, (_loc_3.r2x * _loc_2.nx + _loc_3.r2y * _loc_2.ny) * _loc_4);
                }
            }
        }// end function

        public function rollingImpulse(param1:Body = undefined) : Number
        {
            if (zpp_inner.inactiveme())
            {
                throw "Error: Contact not currently in use";
            }
            var _loc_2:* = zpp_inner.arbiter.colarb;
            var _loc_3:* = zpp_inner.arbiter.colarb.jrAcc;
            if (param1 == null)
            {
                return _loc_3;
            }
            else
            {
                if (param1 != _loc_2.b1.outer)
                {
                }
                if (param1 != _loc_2.b2.outer)
                {
                    throw "Error: Contact does not relate to the given body";
                }
                if (param1 == _loc_2.b1.outer)
                {
                    return -_loc_3;
                }
                else
                {
                    return _loc_3;
                }
            }
        }// end function

        public function normalImpulse(param1:Body = undefined) : Vec3
        {
            if (zpp_inner.inactiveme())
            {
                throw "Error: Contact not currently in use";
            }
            var _loc_2:* = zpp_inner.arbiter.colarb;
            var _loc_3:* = zpp_inner.inner;
            var _loc_4:* = _loc_3.jnAcc;
            if (param1 == null)
            {
                return Vec3.get(_loc_2.nx * _loc_4, _loc_2.ny * _loc_4);
            }
            else
            {
                if (param1 != _loc_2.b1.outer)
                {
                }
                if (param1 != _loc_2.b2.outer)
                {
                    throw "Error: Contact does not relate to the given body";
                }
                if (param1 == _loc_2.b1.outer)
                {
                    return Vec3.get(_loc_2.nx * (-_loc_4), _loc_2.ny * (-_loc_4), (-(_loc_2.ny * _loc_3.r1x - _loc_2.nx * _loc_3.r1y)) * _loc_4);
                }
                else
                {
                    return Vec3.get(_loc_2.nx * _loc_4, _loc_2.ny * _loc_4, (_loc_2.ny * _loc_3.r2x - _loc_2.nx * _loc_3.r2y) * _loc_4);
                }
            }
        }// end function

        public function get_position() : Vec2
        {
            if (zpp_inner.inactiveme())
            {
                throw "Error: Contact not currently in use";
            }
            if (zpp_inner.wrap_position == null)
            {
                zpp_inner.getposition();
            }
            return zpp_inner.wrap_position;
        }// end function

        public function get_penetration() : Number
        {
            if (zpp_inner.inactiveme())
            {
                throw "Error: Contact not currently in use";
            }
            return -zpp_inner.dist;
        }// end function

        public function get_friction() : Number
        {
            if (zpp_inner.inactiveme())
            {
                throw "Error: Contact not currently in use";
            }
            return zpp_inner.inner.friction;
        }// end function

        public function get_fresh() : Boolean
        {
            if (zpp_inner.inactiveme())
            {
                throw "Error: Contact not currently in use";
            }
            return zpp_inner.fresh;
        }// end function

        public function get_arbiter() : CollisionArbiter
        {
            var _loc_1:* = null as Arbiter;
            if (zpp_inner.arbiter == null)
            {
                return null;
            }
            else
            {
                _loc_1 = zpp_inner.arbiter.outer;
                if (_loc_1.zpp_inner.type == ZPP_Arbiter.COL)
                {
                    return _loc_1.zpp_inner.colarb.outer_zn;
                }
                else
                {
                    return null;
                }
            }
        }// end function

    }
}
