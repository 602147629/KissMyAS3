package nape.dynamics
{
    import flash.*;
    import nape.callbacks.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.util.*;

    public class Arbiter extends Object
    {
        public var zpp_inner:ZPP_Arbiter;

        public function Arbiter() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (!ZPP_Arbiter.internal)
            {
                throw "Error: Cannot instantiate Arbiter derp!";
            }
            return;
        }// end function

        public function totalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (param1 != null)
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
            }
            if (param1 != (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.b2.outer) : (zpp_inner.b1.outer)))
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
            }
            if (param1 != (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.b1.outer) : (zpp_inner.b2.outer)))
            {
                throw "Error: Arbiter does not relate to body";
            }
            return Vec3.get(0, 0, 0);
        }// end function

        public function toString() : String
        {
            var _loc_1:* = null as String;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (zpp_inner.type == ZPP_Arbiter.COL)
            {
                _loc_1 = "CollisionArbiter";
            }
            else if (zpp_inner.type == ZPP_Arbiter.FLUID)
            {
                _loc_1 = "FluidArbiter";
            }
            else
            {
                _loc_1 = "SensorArbiter";
            }
            if (zpp_inner.cleared)
            {
                return _loc_1 + "(object-pooled)";
            }
            else
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
                _loc_2 = zpp_inner.immState;
                _loc_3 = _loc_2;
                if (ZPP_Flags.PreFlag_ACCEPT == null)
                {
                }
                if (ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
                {
                }
                if (ZPP_Flags.PreFlag_IGNORE == null)
                {
                }
                if (ZPP_Flags.PreFlag_IGNORE_ONCE == null)
                {
                }
                return _loc_1 + "(" + (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.ws2.outer) : (zpp_inner.ws1.outer)).toString() + "|" + (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.ws1.outer) : (zpp_inner.ws2.outer)).toString() + ")" + (zpp_inner.type == ZPP_Arbiter.COL ? ("[" + ["SD", "DD"][zpp_inner.colarb.stat ? (0) : (1)] + "]") : ("")) + "<-" + (_loc_3 == (ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS) ? (if (!(ZPP_Flags.PreFlag_ACCEPT == null)) goto 465, ZPP_Flags.internal = true, ZPP_Flags.PreFlag_ACCEPT = new PreFlag(), ZPP_Flags.internal = false, ZPP_Flags.PreFlag_ACCEPT) : (_loc_4 = _loc_2, _loc_5 = _loc_2, _loc_5 == ZPP_Flags.id_ImmState_ACCEPT ? (if (!(ZPP_Flags.PreFlag_ACCEPT_ONCE == null)) goto 536, ZPP_Flags.internal = true, ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag(), ZPP_Flags.internal = false, ZPP_Flags.PreFlag_ACCEPT_ONCE) : (_loc_4 == (ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS) ? (if (!(ZPP_Flags.PreFlag_IGNORE == null)) goto 606, ZPP_Flags.internal = true, ZPP_Flags.PreFlag_IGNORE = new PreFlag(), ZPP_Flags.internal = false, ZPP_Flags.PreFlag_IGNORE) : (if (!(ZPP_Flags.PreFlag_IGNORE_ONCE == null)) goto 657, ZPP_Flags.internal = true, ZPP_Flags.PreFlag_IGNORE_ONCE = new PreFlag(), ZPP_Flags.internal = false, ZPP_Flags.PreFlag_IGNORE_ONCE)))).toString();
            }
        }// end function

        public function isSensorArbiter() : Boolean
        {
            return zpp_inner.type == ZPP_Arbiter.SENSOR;
        }// end function

        public function isFluidArbiter() : Boolean
        {
            return zpp_inner.type == ZPP_Arbiter.FLUID;
        }// end function

        public function isCollisionArbiter() : Boolean
        {
            return zpp_inner.type == ZPP_Arbiter.COL;
        }// end function

        public function get_type() : ArbiterType
        {
            return ZPP_Arbiter.types[zpp_inner.type];
        }// end function

        public function get_state() : PreFlag
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            var _loc_1:* = zpp_inner.immState;
            var _loc_2:* = _loc_1;
            if (_loc_2 == (ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS))
            {
                if (ZPP_Flags.PreFlag_ACCEPT == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.PreFlag_ACCEPT;
            }
            else
            {
                _loc_3 = _loc_1;
                _loc_4 = _loc_1;
                if (_loc_4 == ZPP_Flags.id_ImmState_ACCEPT)
                {
                    if (ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
                        ZPP_Flags.internal = false;
                    }
                    return ZPP_Flags.PreFlag_ACCEPT_ONCE;
                }
                else if (_loc_3 == (ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS))
                {
                    if (ZPP_Flags.PreFlag_IGNORE == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.PreFlag_IGNORE = new PreFlag();
                        ZPP_Flags.internal = false;
                    }
                    return ZPP_Flags.PreFlag_IGNORE;
                }
                else
                {
                    if (ZPP_Flags.PreFlag_IGNORE_ONCE == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.PreFlag_IGNORE_ONCE = new PreFlag();
                        ZPP_Flags.internal = false;
                    }
                    return ZPP_Flags.PreFlag_IGNORE_ONCE;
                }
            }
            return;
        }// end function

        public function get_shape2() : Shape
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (zpp_inner.ws1.id > zpp_inner.ws2.id)
            {
                return zpp_inner.ws1.outer;
            }
            else
            {
                return zpp_inner.ws2.outer;
            }
        }// end function

        public function get_shape1() : Shape
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (zpp_inner.ws1.id > zpp_inner.ws2.id)
            {
                return zpp_inner.ws2.outer;
            }
            else
            {
                return zpp_inner.ws1.outer;
            }
        }// end function

        public function get_isSleeping() : Boolean
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            return zpp_inner.sleeping;
        }// end function

        public function get_fluidArbiter() : FluidArbiter
        {
            if (zpp_inner.type == ZPP_Arbiter.FLUID)
            {
                return zpp_inner.fluidarb.outer_zn;
            }
            else
            {
                return null;
            }
        }// end function

        public function get_collisionArbiter() : CollisionArbiter
        {
            if (zpp_inner.type == ZPP_Arbiter.COL)
            {
                return zpp_inner.colarb.outer_zn;
            }
            else
            {
                return null;
            }
        }// end function

        public function get_body2() : Body
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (zpp_inner.ws1.id > zpp_inner.ws2.id)
            {
                return zpp_inner.b1.outer;
            }
            else
            {
                return zpp_inner.b2.outer;
            }
        }// end function

        public function get_body1() : Body
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (zpp_inner.ws1.id > zpp_inner.ws2.id)
            {
                return zpp_inner.b2.outer;
            }
            else
            {
                return zpp_inner.b1.outer;
            }
        }// end function

    }
}
