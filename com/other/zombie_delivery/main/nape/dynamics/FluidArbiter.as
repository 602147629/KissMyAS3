package nape.dynamics
{
    import flash.*;
    import nape.geom.*;
    import nape.phys.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    final public class FluidArbiter extends Arbiter
    {

        public function FluidArbiter() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Arbiter.internal)
            {
                throw "Error: Cannot instantiate FluidArbiter derp!";
            }
            return;
        }// end function

        override public function totalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
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
            var _loc_3:* = buoyancyImpulse(param1);
            var _loc_4:* = dragImpulse(param1);
            var _loc_5:* = _loc_4;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_7:* = _loc_5.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_3.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            var _loc_6:* = _loc_5.zpp_inner.x + _loc_3.zpp_inner.x;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (_loc_5.zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            _loc_5.zpp_inner.x = _loc_6;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_5.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_5 = _loc_4;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_5.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_3.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_6 = _loc_5.zpp_inner.y + _loc_3.zpp_inner.y;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (_loc_5.zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            _loc_5.zpp_inner.y = _loc_6;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_5.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_5 = _loc_4;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_5.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_3.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_6 = _loc_5.zpp_inner.z + _loc_3.zpp_inner.z;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (_loc_5.zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            _loc_5.zpp_inner.z = _loc_6;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_5.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_3.dispose();
            return _loc_4;
        }// end function

        public function set_position(param1:Vec2) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            if (!zpp_inner.fluidarb.mutable)
            {
                throw "Error: Arbiter is mutable only within a pre-handler";
            }
            if (param1 == null)
            {
                throw "Error: FluidArbiter::position cannot be null";
            }
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (zpp_inner.fluidarb.wrap_position == null)
            {
                zpp_inner.fluidarb.getposition();
            }
            var _loc_2:* = zpp_inner.fluidarb.wrap_position;
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_2.zpp_inner;
            if (_loc_3._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_3._isimmutable != null)
            {
                _loc_3._isimmutable();
            }
            if (param1 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_5:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_6:* = param1.zpp_inner.y;
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_2.zpp_inner;
            if (_loc_3._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_3._isimmutable != null)
            {
                _loc_3._isimmutable();
            }
            if (_loc_5 == _loc_5)
            {
            }
            if (_loc_6 != _loc_6)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_2.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (_loc_2.zpp_inner.x == _loc_5)
            {
                if (_loc_2 != null)
                {
                }
                if (_loc_2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = _loc_2.zpp_inner;
                if (_loc_3._validate != null)
                {
                    _loc_3._validate();
                }
            }
            if (_loc_2.zpp_inner.y != _loc_6)
            {
                _loc_2.zpp_inner.x = _loc_5;
                _loc_2.zpp_inner.y = _loc_6;
                _loc_3 = _loc_2.zpp_inner;
                if (_loc_3._invalidate != null)
                {
                    _loc_3._invalidate(_loc_3);
                }
            }
            var _loc_4:* = _loc_2;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = param1.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_3 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_7 = param1;
                _loc_7.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_7;
                }
                ZPP_PubPool.nextVec2 = _loc_7;
                _loc_7.zpp_disp = true;
                _loc_8 = _loc_3;
                if (_loc_8.outer != null)
                {
                    _loc_8.outer.zpp_inner = null;
                    _loc_8.outer = null;
                }
                _loc_8._isimmutable = null;
                _loc_8._validate = null;
                _loc_8._invalidate = null;
                _loc_8.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_8;
            }
            else
            {
            }
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (zpp_inner.fluidarb.wrap_position == null)
            {
                zpp_inner.fluidarb.getposition();
            }
            return zpp_inner.fluidarb.wrap_position;
        }// end function

        public function set_overlap(param1:Number) : Number
        {
            if (!zpp_inner.fluidarb.mutable)
            {
                throw "Error: Arbiter is mutable only within a pre-handler";
            }
            if (param1 != param1)
            {
                throw "Error: FluidArbiter::overlap cannot be NaN";
            }
            if (param1 > 0)
            {
            }
            if (param1 == Math.POSITIVE_INFINITY)
            {
                throw "Error: FluidArbiter::overlap must be strictly positive and non infinite";
            }
            zpp_inner.fluidarb.overlap = param1;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            return zpp_inner.fluidarb.overlap;
        }// end function

        public function get_position() : Vec2
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (zpp_inner.fluidarb.wrap_position == null)
            {
                zpp_inner.fluidarb.getposition();
            }
            return zpp_inner.fluidarb.wrap_position;
        }// end function

        public function get_overlap() : Number
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            return zpp_inner.fluidarb.overlap;
        }// end function

        public function dragImpulse(param1:Body = undefined) : Vec3
        {
            var _loc_3:* = 0;
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
            var _loc_2:* = zpp_inner.fluidarb;
            if (param1 != null)
            {
            }
            if (param1.zpp_inner == zpp_inner.b2)
            {
                _loc_3 = 1;
            }
            else
            {
                _loc_3 = -1;
            }
            return Vec3.get(_loc_2.dampx * _loc_3, _loc_2.dampy * _loc_3, _loc_2.adamp * _loc_3);
        }// end function

        public function buoyancyImpulse(param1:Body = undefined) : Vec3
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
            var _loc_2:* = zpp_inner.fluidarb;
            if (param1 == null)
            {
                return Vec3.get(_loc_2.buoyx, _loc_2.buoyy, 0);
            }
            else if (param1.zpp_inner == zpp_inner.b2)
            {
                return Vec3.get(_loc_2.buoyx, _loc_2.buoyy, _loc_2.buoyy * _loc_2.r2x - _loc_2.buoyx * _loc_2.r2y);
            }
            else
            {
                return Vec3.get(-_loc_2.buoyx, -_loc_2.buoyy, -(_loc_2.buoyy * _loc_2.r1x - _loc_2.buoyx * _loc_2.r1y));
            }
        }// end function

    }
}
