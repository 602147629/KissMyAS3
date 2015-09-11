package nape.constraint
{
    import flash.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.space.*;
    import zpp_nape.constraint.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    final public class PulleyJoint extends Constraint
    {
        public var zpp_inner_zn:ZPP_PulleyJoint;

        public function PulleyJoint(param1:Body = undefined, param2:Body = undefined, param3:Body = undefined, param4:Body = undefined, param5:Vec2 = undefined, param6:Vec2 = undefined, param7:Vec2 = undefined, param8:Vec2 = undefined, param9:Number = 0, param10:Number = 0, param11:Number = 1) : void
        {
            var _loc_13:* = null;
            var _loc_14:* = null as ZPP_Body;
            var _loc_16:* = null as ZPP_Vec2;
            var _loc_20:* = null as Vec2;
            var _loc_21:* = null as ZPP_Vec2;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner_zn = null;
            zpp_inner_zn = new ZPP_PulleyJoint();
            zpp_inner = zpp_inner_zn;
            zpp_inner.outer = this;
            zpp_inner_zn.outer_zn = this;
            ;
            _loc_13 = this;
            zpp_inner.immutable_midstep("Constraint::" + "body1");
            if (param1 == null)
            {
                _loc_14 = null;
            }
            else
            {
                _loc_14 = param1.zpp_inner;
            }
            if (_loc_14 != zpp_inner_zn.b1)
            {
                if (zpp_inner_zn.b1 != null)
                {
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                    }
                    if (zpp_inner_zn.b2 != zpp_inner_zn.b1)
                    {
                    }
                    if (zpp_inner_zn.b3 != zpp_inner_zn.b1)
                    {
                    }
                    if (zpp_inner_zn.b4 != zpp_inner_zn.b1)
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
                zpp_inner_zn.b1 = _loc_14;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_14 != null)
                {
                }
                if (zpp_inner_zn.b2 != _loc_14)
                {
                }
                if (zpp_inner_zn.b3 != _loc_14)
                {
                }
                if (zpp_inner_zn.b4 != _loc_14)
                {
                    if (_loc_14 != null)
                    {
                        _loc_14.constraints.add(zpp_inner);
                    }
                }
                if (zpp_inner.active)
                {
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.wake();
                    if (_loc_14 != null)
                    {
                        _loc_14.wake();
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
                _loc_14 = null;
            }
            else
            {
                _loc_14 = param2.zpp_inner;
            }
            if (_loc_14 != zpp_inner_zn.b2)
            {
                if (zpp_inner_zn.b2 != null)
                {
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                    }
                    if (zpp_inner_zn.b1 != zpp_inner_zn.b2)
                    {
                    }
                    if (zpp_inner_zn.b3 != zpp_inner_zn.b2)
                    {
                    }
                    if (zpp_inner_zn.b4 != zpp_inner_zn.b2)
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
                zpp_inner_zn.b2 = _loc_14;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_14 != null)
                {
                }
                if (zpp_inner_zn.b1 != _loc_14)
                {
                }
                if (zpp_inner_zn.b3 != _loc_14)
                {
                }
                if (zpp_inner_zn.b4 != _loc_14)
                {
                    if (_loc_14 != null)
                    {
                        _loc_14.constraints.add(zpp_inner);
                    }
                }
                if (zpp_inner.active)
                {
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.wake();
                    if (_loc_14 != null)
                    {
                        _loc_14.wake();
                    }
                }
            }
            if (zpp_inner_zn.b2 == null)
            {
            }
            else
            {
            }
            zpp_inner.immutable_midstep("Constraint::" + "body3");
            if (param3 == null)
            {
                _loc_14 = null;
            }
            else
            {
                _loc_14 = param3.zpp_inner;
            }
            if (_loc_14 != zpp_inner_zn.b3)
            {
                if (zpp_inner_zn.b3 != null)
                {
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                    }
                    if (zpp_inner_zn.b1 != zpp_inner_zn.b3)
                    {
                    }
                    if (zpp_inner_zn.b2 != zpp_inner_zn.b3)
                    {
                    }
                    if (zpp_inner_zn.b4 != zpp_inner_zn.b3)
                    {
                        if (zpp_inner_zn.b3 != null)
                        {
                            zpp_inner_zn.b3.constraints.remove(zpp_inner);
                        }
                    }
                    if (zpp_inner.active)
                    {
                    }
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                        zpp_inner_zn.b3.wake();
                    }
                }
                zpp_inner_zn.b3 = _loc_14;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_14 != null)
                {
                }
                if (zpp_inner_zn.b1 != _loc_14)
                {
                }
                if (zpp_inner_zn.b2 != _loc_14)
                {
                }
                if (zpp_inner_zn.b4 != _loc_14)
                {
                    if (_loc_14 != null)
                    {
                        _loc_14.constraints.add(zpp_inner);
                    }
                }
                if (zpp_inner.active)
                {
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.wake();
                    if (_loc_14 != null)
                    {
                        _loc_14.wake();
                    }
                }
            }
            if (zpp_inner_zn.b3 == null)
            {
            }
            else
            {
            }
            zpp_inner.immutable_midstep("Constraint::" + "body4");
            if (param4 == null)
            {
                _loc_14 = null;
            }
            else
            {
                _loc_14 = param4.zpp_inner;
            }
            if (_loc_14 != zpp_inner_zn.b4)
            {
                if (zpp_inner_zn.b4 != null)
                {
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                    }
                    if (zpp_inner_zn.b1 != zpp_inner_zn.b4)
                    {
                    }
                    if (zpp_inner_zn.b2 != zpp_inner_zn.b4)
                    {
                    }
                    if (zpp_inner_zn.b3 != zpp_inner_zn.b4)
                    {
                        if (zpp_inner_zn.b4 != null)
                        {
                            zpp_inner_zn.b4.constraints.remove(zpp_inner);
                        }
                    }
                    if (zpp_inner.active)
                    {
                    }
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                        zpp_inner_zn.b4.wake();
                    }
                }
                zpp_inner_zn.b4 = _loc_14;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_14 != null)
                {
                }
                if (zpp_inner_zn.b1 != _loc_14)
                {
                }
                if (zpp_inner_zn.b2 != _loc_14)
                {
                }
                if (zpp_inner_zn.b3 != _loc_14)
                {
                    if (_loc_14 != null)
                    {
                        _loc_14.constraints.add(zpp_inner);
                    }
                }
                if (zpp_inner.active)
                {
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.wake();
                    if (_loc_14 != null)
                    {
                        _loc_14.wake();
                    }
                }
            }
            if (zpp_inner_zn.b4 == null)
            {
            }
            else
            {
            }
            if (param5 != null)
            {
            }
            if (param5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param5 == null)
            {
                throw "Error: Constraint::" + "anchor1" + " cannot be null";
            }
            if (zpp_inner_zn.wrap_a1 == null)
            {
                zpp_inner_zn.setup_a1();
            }
            var _loc_15:* = zpp_inner_zn.wrap_a1;
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param5 != null)
            {
            }
            if (param5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_16._isimmutable != null)
            {
                _loc_16._isimmutable();
            }
            if (param5 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param5 != null)
            {
            }
            if (param5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = param5.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            var _loc_18:* = param5.zpp_inner.x;
            if (param5 != null)
            {
            }
            if (param5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = param5.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            var _loc_19:* = param5.zpp_inner.y;
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_16._isimmutable != null)
            {
                _loc_16._isimmutable();
            }
            if (_loc_18 == _loc_18)
            {
            }
            if (_loc_19 != _loc_19)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            if (_loc_15.zpp_inner.x == _loc_18)
            {
                if (_loc_15 != null)
                {
                }
                if (_loc_15.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_16 = _loc_15.zpp_inner;
                if (_loc_16._validate != null)
                {
                    _loc_16._validate();
                }
            }
            if (_loc_15.zpp_inner.y != _loc_19)
            {
                _loc_15.zpp_inner.x = _loc_18;
                _loc_15.zpp_inner.y = _loc_19;
                _loc_16 = _loc_15.zpp_inner;
                if (_loc_16._invalidate != null)
                {
                    _loc_16._invalidate(_loc_16);
                }
            }
            var _loc_17:* = _loc_15;
            if (param5.zpp_inner.weak)
            {
                if (param5 != null)
                {
                }
                if (param5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_16 = param5.zpp_inner;
                if (_loc_16._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_16._isimmutable != null)
                {
                    _loc_16._isimmutable();
                }
                if (param5.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_16 = param5.zpp_inner;
                param5.zpp_inner.outer = null;
                param5.zpp_inner = null;
                _loc_20 = param5;
                _loc_20.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_20;
                }
                ZPP_PubPool.nextVec2 = _loc_20;
                _loc_20.zpp_disp = true;
                _loc_21 = _loc_16;
                if (_loc_21.outer != null)
                {
                    _loc_21.outer.zpp_inner = null;
                    _loc_21.outer = null;
                }
                _loc_21._isimmutable = null;
                _loc_21._validate = null;
                _loc_21._invalidate = null;
                _loc_21.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_21;
            }
            else
            {
            }
            if (zpp_inner_zn.wrap_a1 == null)
            {
                zpp_inner_zn.setup_a1();
            }
            if (param6 != null)
            {
            }
            if (param6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param6 == null)
            {
                throw "Error: Constraint::" + "anchor2" + " cannot be null";
            }
            if (zpp_inner_zn.wrap_a2 == null)
            {
                zpp_inner_zn.setup_a2();
            }
            _loc_15 = zpp_inner_zn.wrap_a2;
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param6 != null)
            {
            }
            if (param6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_16._isimmutable != null)
            {
                _loc_16._isimmutable();
            }
            if (param6 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param6 != null)
            {
            }
            if (param6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = param6.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            _loc_18 = param6.zpp_inner.x;
            if (param6 != null)
            {
            }
            if (param6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = param6.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            _loc_19 = param6.zpp_inner.y;
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_16._isimmutable != null)
            {
                _loc_16._isimmutable();
            }
            if (_loc_18 == _loc_18)
            {
            }
            if (_loc_19 != _loc_19)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            if (_loc_15.zpp_inner.x == _loc_18)
            {
                if (_loc_15 != null)
                {
                }
                if (_loc_15.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_16 = _loc_15.zpp_inner;
                if (_loc_16._validate != null)
                {
                    _loc_16._validate();
                }
            }
            if (_loc_15.zpp_inner.y != _loc_19)
            {
                _loc_15.zpp_inner.x = _loc_18;
                _loc_15.zpp_inner.y = _loc_19;
                _loc_16 = _loc_15.zpp_inner;
                if (_loc_16._invalidate != null)
                {
                    _loc_16._invalidate(_loc_16);
                }
            }
            _loc_17 = _loc_15;
            if (param6.zpp_inner.weak)
            {
                if (param6 != null)
                {
                }
                if (param6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_16 = param6.zpp_inner;
                if (_loc_16._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_16._isimmutable != null)
                {
                    _loc_16._isimmutable();
                }
                if (param6.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_16 = param6.zpp_inner;
                param6.zpp_inner.outer = null;
                param6.zpp_inner = null;
                _loc_20 = param6;
                _loc_20.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_20;
                }
                ZPP_PubPool.nextVec2 = _loc_20;
                _loc_20.zpp_disp = true;
                _loc_21 = _loc_16;
                if (_loc_21.outer != null)
                {
                    _loc_21.outer.zpp_inner = null;
                    _loc_21.outer = null;
                }
                _loc_21._isimmutable = null;
                _loc_21._validate = null;
                _loc_21._invalidate = null;
                _loc_21.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_21;
            }
            else
            {
            }
            if (zpp_inner_zn.wrap_a2 == null)
            {
                zpp_inner_zn.setup_a2();
            }
            if (param7 != null)
            {
            }
            if (param7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param7 == null)
            {
                throw "Error: Constraint::" + "anchor3" + " cannot be null";
            }
            if (zpp_inner_zn.wrap_a3 == null)
            {
                zpp_inner_zn.setup_a3();
            }
            _loc_15 = zpp_inner_zn.wrap_a3;
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param7 != null)
            {
            }
            if (param7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_16._isimmutable != null)
            {
                _loc_16._isimmutable();
            }
            if (param7 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param7 != null)
            {
            }
            if (param7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = param7.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            _loc_18 = param7.zpp_inner.x;
            if (param7 != null)
            {
            }
            if (param7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = param7.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            _loc_19 = param7.zpp_inner.y;
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_16._isimmutable != null)
            {
                _loc_16._isimmutable();
            }
            if (_loc_18 == _loc_18)
            {
            }
            if (_loc_19 != _loc_19)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            if (_loc_15.zpp_inner.x == _loc_18)
            {
                if (_loc_15 != null)
                {
                }
                if (_loc_15.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_16 = _loc_15.zpp_inner;
                if (_loc_16._validate != null)
                {
                    _loc_16._validate();
                }
            }
            if (_loc_15.zpp_inner.y != _loc_19)
            {
                _loc_15.zpp_inner.x = _loc_18;
                _loc_15.zpp_inner.y = _loc_19;
                _loc_16 = _loc_15.zpp_inner;
                if (_loc_16._invalidate != null)
                {
                    _loc_16._invalidate(_loc_16);
                }
            }
            _loc_17 = _loc_15;
            if (param7.zpp_inner.weak)
            {
                if (param7 != null)
                {
                }
                if (param7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_16 = param7.zpp_inner;
                if (_loc_16._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_16._isimmutable != null)
                {
                    _loc_16._isimmutable();
                }
                if (param7.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_16 = param7.zpp_inner;
                param7.zpp_inner.outer = null;
                param7.zpp_inner = null;
                _loc_20 = param7;
                _loc_20.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_20;
                }
                ZPP_PubPool.nextVec2 = _loc_20;
                _loc_20.zpp_disp = true;
                _loc_21 = _loc_16;
                if (_loc_21.outer != null)
                {
                    _loc_21.outer.zpp_inner = null;
                    _loc_21.outer = null;
                }
                _loc_21._isimmutable = null;
                _loc_21._validate = null;
                _loc_21._invalidate = null;
                _loc_21.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_21;
            }
            else
            {
            }
            if (zpp_inner_zn.wrap_a3 == null)
            {
                zpp_inner_zn.setup_a3();
            }
            if (param8 != null)
            {
            }
            if (param8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param8 == null)
            {
                throw "Error: Constraint::" + "anchor4" + " cannot be null";
            }
            if (zpp_inner_zn.wrap_a4 == null)
            {
                zpp_inner_zn.setup_a4();
            }
            _loc_15 = zpp_inner_zn.wrap_a4;
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param8 != null)
            {
            }
            if (param8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_16._isimmutable != null)
            {
                _loc_16._isimmutable();
            }
            if (param8 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param8 != null)
            {
            }
            if (param8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = param8.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            _loc_18 = param8.zpp_inner.x;
            if (param8 != null)
            {
            }
            if (param8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = param8.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            _loc_19 = param8.zpp_inner.y;
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_16._isimmutable != null)
            {
                _loc_16._isimmutable();
            }
            if (_loc_18 == _loc_18)
            {
            }
            if (_loc_19 != _loc_19)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_15.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            if (_loc_15.zpp_inner.x == _loc_18)
            {
                if (_loc_15 != null)
                {
                }
                if (_loc_15.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_16 = _loc_15.zpp_inner;
                if (_loc_16._validate != null)
                {
                    _loc_16._validate();
                }
            }
            if (_loc_15.zpp_inner.y != _loc_19)
            {
                _loc_15.zpp_inner.x = _loc_18;
                _loc_15.zpp_inner.y = _loc_19;
                _loc_16 = _loc_15.zpp_inner;
                if (_loc_16._invalidate != null)
                {
                    _loc_16._invalidate(_loc_16);
                }
            }
            _loc_17 = _loc_15;
            if (param8.zpp_inner.weak)
            {
                if (param8 != null)
                {
                }
                if (param8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_16 = param8.zpp_inner;
                if (_loc_16._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_16._isimmutable != null)
                {
                    _loc_16._isimmutable();
                }
                if (param8.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_16 = param8.zpp_inner;
                param8.zpp_inner.outer = null;
                param8.zpp_inner = null;
                _loc_20 = param8;
                _loc_20.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_20;
                }
                ZPP_PubPool.nextVec2 = _loc_20;
                _loc_20.zpp_disp = true;
                _loc_21 = _loc_16;
                if (_loc_21.outer != null)
                {
                    _loc_21.outer.zpp_inner = null;
                    _loc_21.outer = null;
                }
                _loc_21._isimmutable = null;
                _loc_21._validate = null;
                _loc_21._invalidate = null;
                _loc_21.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_21;
            }
            else
            {
            }
            if (zpp_inner_zn.wrap_a4 == null)
            {
                zpp_inner_zn.setup_a4();
            }
            zpp_inner.immutable_midstep("PulleyJoint::ratio");
            if (param11 != param11)
            {
                throw "Error: PulleyJoint::ratio cannot be NaN";
            }
            if (zpp_inner_zn.ratio != param11)
            {
                zpp_inner_zn.ratio = param11;
                zpp_inner.wake();
            }
            zpp_inner.immutable_midstep("PulleyJoint::jointMin");
            if (param9 != param9)
            {
                throw "Error: PulleyJoint::jointMin cannot be NaN";
            }
            if (param9 < 0)
            {
                throw "Error: PulleyJoint::jointMin must be >= 0";
            }
            if (zpp_inner_zn.jointMin != param9)
            {
                zpp_inner_zn.jointMin = param9;
                zpp_inner.wake();
            }
            zpp_inner.immutable_midstep("PulleyJoint::jointMax");
            if (param10 != param10)
            {
                throw "Error: PulleyJoint::jointMax cannot be NaN";
            }
            if (param10 < 0)
            {
                throw "Error: PulleyJoint::jointMax must be >= 0";
            }
            if (zpp_inner_zn.jointMax != param10)
            {
                zpp_inner_zn.jointMax = param10;
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
            if ((zpp_inner_zn.b3 == null ? (null) : (zpp_inner_zn.b3.outer)) != null)
            {
            }
            if ((zpp_inner_zn.b3 == null ? (null) : (zpp_inner_zn.b3.outer)) != (zpp_inner_zn.b1 == null ? (null) : (zpp_inner_zn.b1.outer)))
            {
            }
            if ((zpp_inner_zn.b3 == null ? (null) : (zpp_inner_zn.b3.outer)) != (zpp_inner_zn.b2 == null ? (null) : (zpp_inner_zn.b2.outer)))
            {
                this.param1(zpp_inner_zn.b3 == null ? (null) : (zpp_inner_zn.b3.outer));
            }
            if ((zpp_inner_zn.b4 == null ? (null) : (zpp_inner_zn.b4.outer)) != null)
            {
            }
            if ((zpp_inner_zn.b4 == null ? (null) : (zpp_inner_zn.b4.outer)) != (zpp_inner_zn.b1 == null ? (null) : (zpp_inner_zn.b1.outer)))
            {
            }
            if ((zpp_inner_zn.b4 == null ? (null) : (zpp_inner_zn.b4.outer)) != (zpp_inner_zn.b2 == null ? (null) : (zpp_inner_zn.b2.outer)))
            {
            }
            if ((zpp_inner_zn.b4 == null ? (null) : (zpp_inner_zn.b4.outer)) != (zpp_inner_zn.b3 == null ? (null) : (zpp_inner_zn.b3.outer)))
            {
                this.param1(zpp_inner_zn.b4 == null ? (null) : (zpp_inner_zn.b4.outer));
            }
            return;
        }// end function

        public function set_ratio(param1:Number) : Number
        {
            zpp_inner.immutable_midstep("PulleyJoint::ratio");
            if (param1 != param1)
            {
                throw "Error: PulleyJoint::ratio cannot be NaN";
            }
            if (zpp_inner_zn.ratio != param1)
            {
                zpp_inner_zn.ratio = param1;
                zpp_inner.wake();
            }
            return zpp_inner_zn.ratio;
        }// end function

        public function set_jointMin(param1:Number) : Number
        {
            zpp_inner.immutable_midstep("PulleyJoint::jointMin");
            if (param1 != param1)
            {
                throw "Error: PulleyJoint::jointMin cannot be NaN";
            }
            if (param1 < 0)
            {
                throw "Error: PulleyJoint::jointMin must be >= 0";
            }
            if (zpp_inner_zn.jointMin != param1)
            {
                zpp_inner_zn.jointMin = param1;
                zpp_inner.wake();
            }
            return zpp_inner_zn.jointMin;
        }// end function

        public function set_jointMax(param1:Number) : Number
        {
            zpp_inner.immutable_midstep("PulleyJoint::jointMax");
            if (param1 != param1)
            {
                throw "Error: PulleyJoint::jointMax cannot be NaN";
            }
            if (param1 < 0)
            {
                throw "Error: PulleyJoint::jointMax must be >= 0";
            }
            if (zpp_inner_zn.jointMax != param1)
            {
                zpp_inner_zn.jointMax = param1;
                zpp_inner.wake();
            }
            return zpp_inner_zn.jointMax;
        }// end function

        public function set_body4(param1:Body) : Body
        {
            var _loc_2:* = null as ZPP_Body;
            zpp_inner.immutable_midstep("Constraint::" + "body4");
            if (param1 == null)
            {
                _loc_2 = null;
            }
            else
            {
                _loc_2 = param1.zpp_inner;
            }
            if (_loc_2 != zpp_inner_zn.b4)
            {
                if (zpp_inner_zn.b4 != null)
                {
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                    }
                    if (zpp_inner_zn.b1 != zpp_inner_zn.b4)
                    {
                    }
                    if (zpp_inner_zn.b2 != zpp_inner_zn.b4)
                    {
                    }
                    if (zpp_inner_zn.b3 != zpp_inner_zn.b4)
                    {
                        if (zpp_inner_zn.b4 != null)
                        {
                            zpp_inner_zn.b4.constraints.remove(zpp_inner);
                        }
                    }
                    if (zpp_inner.active)
                    {
                    }
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                        zpp_inner_zn.b4.wake();
                    }
                }
                zpp_inner_zn.b4 = _loc_2;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_2 != null)
                {
                }
                if (zpp_inner_zn.b1 != _loc_2)
                {
                }
                if (zpp_inner_zn.b2 != _loc_2)
                {
                }
                if (zpp_inner_zn.b3 != _loc_2)
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
            if (zpp_inner_zn.b4 == null)
            {
                return null;
            }
            else
            {
                return zpp_inner_zn.b4.outer;
            }
        }// end function

        public function set_body3(param1:Body) : Body
        {
            var _loc_2:* = null as ZPP_Body;
            zpp_inner.immutable_midstep("Constraint::" + "body3");
            if (param1 == null)
            {
                _loc_2 = null;
            }
            else
            {
                _loc_2 = param1.zpp_inner;
            }
            if (_loc_2 != zpp_inner_zn.b3)
            {
                if (zpp_inner_zn.b3 != null)
                {
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                    }
                    if (zpp_inner_zn.b1 != zpp_inner_zn.b3)
                    {
                    }
                    if (zpp_inner_zn.b2 != zpp_inner_zn.b3)
                    {
                    }
                    if (zpp_inner_zn.b4 != zpp_inner_zn.b3)
                    {
                        if (zpp_inner_zn.b3 != null)
                        {
                            zpp_inner_zn.b3.constraints.remove(zpp_inner);
                        }
                    }
                    if (zpp_inner.active)
                    {
                    }
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                        zpp_inner_zn.b3.wake();
                    }
                }
                zpp_inner_zn.b3 = _loc_2;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_2 != null)
                {
                }
                if (zpp_inner_zn.b1 != _loc_2)
                {
                }
                if (zpp_inner_zn.b2 != _loc_2)
                {
                }
                if (zpp_inner_zn.b4 != _loc_2)
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
            if (zpp_inner_zn.b3 == null)
            {
                return null;
            }
            else
            {
                return zpp_inner_zn.b3.outer;
            }
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
                    }
                    if (zpp_inner_zn.b3 != zpp_inner_zn.b2)
                    {
                    }
                    if (zpp_inner_zn.b4 != zpp_inner_zn.b2)
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
                }
                if (zpp_inner_zn.b3 != _loc_2)
                {
                }
                if (zpp_inner_zn.b4 != _loc_2)
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
                    }
                    if (zpp_inner_zn.b3 != zpp_inner_zn.b1)
                    {
                    }
                    if (zpp_inner_zn.b4 != zpp_inner_zn.b1)
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
                }
                if (zpp_inner_zn.b3 != _loc_2)
                {
                }
                if (zpp_inner_zn.b4 != _loc_2)
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

        public function set_anchor4(param1:Vec2) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Constraint::" + "anchor4" + " cannot be null";
            }
            if (zpp_inner_zn.wrap_a4 == null)
            {
                zpp_inner_zn.setup_a4();
            }
            var _loc_2:* = zpp_inner_zn.wrap_a4;
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
            if (zpp_inner_zn.wrap_a4 == null)
            {
                zpp_inner_zn.setup_a4();
            }
            return zpp_inner_zn.wrap_a4;
        }// end function

        public function set_anchor3(param1:Vec2) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Constraint::" + "anchor3" + " cannot be null";
            }
            if (zpp_inner_zn.wrap_a3 == null)
            {
                zpp_inner_zn.setup_a3();
            }
            var _loc_2:* = zpp_inner_zn.wrap_a3;
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
            if (zpp_inner_zn.wrap_a3 == null)
            {
                zpp_inner_zn.setup_a3();
            }
            return zpp_inner_zn.wrap_a3;
        }// end function

        public function set_anchor2(param1:Vec2) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Constraint::" + "anchor2" + " cannot be null";
            }
            if (zpp_inner_zn.wrap_a2 == null)
            {
                zpp_inner_zn.setup_a2();
            }
            var _loc_2:* = zpp_inner_zn.wrap_a2;
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
            if (zpp_inner_zn.wrap_a2 == null)
            {
                zpp_inner_zn.setup_a2();
            }
            return zpp_inner_zn.wrap_a2;
        }// end function

        public function set_anchor1(param1:Vec2) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Constraint::" + "anchor1" + " cannot be null";
            }
            if (zpp_inner_zn.wrap_a1 == null)
            {
                zpp_inner_zn.setup_a1();
            }
            var _loc_2:* = zpp_inner_zn.wrap_a1;
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
            if (zpp_inner_zn.wrap_a1 == null)
            {
                zpp_inner_zn.setup_a1();
            }
            return zpp_inner_zn.wrap_a1;
        }// end function

        public function isSlack() : Boolean
        {
            if ((zpp_inner_zn.b1 == null ? (null) : (zpp_inner_zn.b1.outer)) != null)
            {
            }
            if ((zpp_inner_zn.b2 == null ? (null) : (zpp_inner_zn.b2.outer)) != null)
            {
            }
            if ((zpp_inner_zn.b3 == null ? (null) : (zpp_inner_zn.b3.outer)) != null)
            {
            }
            if ((zpp_inner_zn.b4 == null ? (null) : (zpp_inner_zn.b4.outer)) == null)
            {
                throw "Error: Cannot compute slack for PulleyJoint if either body is null.";
            }
            return zpp_inner_zn.slack;
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

        public function get_jointMin() : Number
        {
            return zpp_inner_zn.jointMin;
        }// end function

        public function get_jointMax() : Number
        {
            return zpp_inner_zn.jointMax;
        }// end function

        public function get_body4() : Body
        {
            if (zpp_inner_zn.b4 == null)
            {
                return null;
            }
            else
            {
                return zpp_inner_zn.b4.outer;
            }
        }// end function

        public function get_body3() : Body
        {
            if (zpp_inner_zn.b3 == null)
            {
                return null;
            }
            else
            {
                return zpp_inner_zn.b3.outer;
            }
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

        public function get_anchor4() : Vec2
        {
            if (zpp_inner_zn.wrap_a4 == null)
            {
                zpp_inner_zn.setup_a4();
            }
            return zpp_inner_zn.wrap_a4;
        }// end function

        public function get_anchor3() : Vec2
        {
            if (zpp_inner_zn.wrap_a3 == null)
            {
                zpp_inner_zn.setup_a3();
            }
            return zpp_inner_zn.wrap_a3;
        }// end function

        public function get_anchor2() : Vec2
        {
            if (zpp_inner_zn.wrap_a2 == null)
            {
                zpp_inner_zn.setup_a2();
            }
            return zpp_inner_zn.wrap_a2;
        }// end function

        public function get_anchor1() : Vec2
        {
            if (zpp_inner_zn.wrap_a1 == null)
            {
                zpp_inner_zn.setup_a1();
            }
            return zpp_inner_zn.wrap_a1;
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
            }
            if (param1 != (zpp_inner_zn.b3 == null ? (null) : (zpp_inner_zn.b3.outer)))
            {
            }
            if (param1 != (zpp_inner_zn.b4 == null ? (null) : (zpp_inner_zn.b4.outer)))
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
