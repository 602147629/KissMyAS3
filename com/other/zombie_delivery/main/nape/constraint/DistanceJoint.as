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

    final public class DistanceJoint extends Constraint
    {
        public var zpp_inner_zn:ZPP_DistanceJoint;

        public function DistanceJoint(param1:Body = undefined, param2:Body = undefined, param3:Vec2 = undefined, param4:Vec2 = undefined, param5:Number = 0, param6:Number = 0) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null as ZPP_Body;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_15:* = null as Vec2;
            var _loc_16:* = null as ZPP_Vec2;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner_zn = null;
            zpp_inner_zn = new ZPP_DistanceJoint();
            zpp_inner = zpp_inner_zn;
            zpp_inner.outer = this;
            zpp_inner_zn.outer_zn = this;
            ;
            _loc_8 = this;
            zpp_inner.immutable_midstep("Constraint::" + "body1");
            if (param1 == null)
            {
                _loc_9 = null;
            }
            else
            {
                _loc_9 = param1.zpp_inner;
            }
            if (_loc_9 != zpp_inner_zn.b1)
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
                zpp_inner_zn.b1 = _loc_9;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_9 != null)
                {
                }
                if (zpp_inner_zn.b2 != _loc_9)
                {
                    if (_loc_9 != null)
                    {
                        _loc_9.constraints.add(zpp_inner);
                    }
                }
                if (zpp_inner.active)
                {
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.wake();
                    if (_loc_9 != null)
                    {
                        _loc_9.wake();
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
                _loc_9 = null;
            }
            else
            {
                _loc_9 = param2.zpp_inner;
            }
            if (_loc_9 != zpp_inner_zn.b2)
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
                zpp_inner_zn.b2 = _loc_9;
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                }
                if (_loc_9 != null)
                {
                }
                if (zpp_inner_zn.b1 != _loc_9)
                {
                    if (_loc_9 != null)
                    {
                        _loc_9.constraints.add(zpp_inner);
                    }
                }
                if (zpp_inner.active)
                {
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.wake();
                    if (_loc_9 != null)
                    {
                        _loc_9.wake();
                    }
                }
            }
            if (zpp_inner_zn.b2 == null)
            {
            }
            else
            {
            }
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param3 == null)
            {
                throw "Error: Constraint::" + "anchor1" + " cannot be null";
            }
            if (zpp_inner_zn.wrap_a1 == null)
            {
                zpp_inner_zn.setup_a1();
            }
            var _loc_10:* = zpp_inner_zn.wrap_a1;
            if (_loc_10 != null)
            {
            }
            if (_loc_10.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = _loc_10.zpp_inner;
            if (_loc_11._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_11._isimmutable != null)
            {
                _loc_11._isimmutable();
            }
            if (param3 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = param3.zpp_inner;
            if (_loc_11._validate != null)
            {
                _loc_11._validate();
            }
            var _loc_13:* = param3.zpp_inner.x;
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = param3.zpp_inner;
            if (_loc_11._validate != null)
            {
                _loc_11._validate();
            }
            var _loc_14:* = param3.zpp_inner.y;
            if (_loc_10 != null)
            {
            }
            if (_loc_10.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = _loc_10.zpp_inner;
            if (_loc_11._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_11._isimmutable != null)
            {
                _loc_11._isimmutable();
            }
            if (_loc_13 == _loc_13)
            {
            }
            if (_loc_14 != _loc_14)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_10 != null)
            {
            }
            if (_loc_10.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = _loc_10.zpp_inner;
            if (_loc_11._validate != null)
            {
                _loc_11._validate();
            }
            if (_loc_10.zpp_inner.x == _loc_13)
            {
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
            }
            if (_loc_10.zpp_inner.y != _loc_14)
            {
                _loc_10.zpp_inner.x = _loc_13;
                _loc_10.zpp_inner.y = _loc_14;
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._invalidate != null)
                {
                    _loc_11._invalidate(_loc_11);
                }
            }
            var _loc_12:* = _loc_10;
            if (param3.zpp_inner.weak)
            {
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = param3.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (param3.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_11 = param3.zpp_inner;
                param3.zpp_inner.outer = null;
                param3.zpp_inner = null;
                _loc_15 = param3;
                _loc_15.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_15;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_15;
                }
                ZPP_PubPool.nextVec2 = _loc_15;
                _loc_15.zpp_disp = true;
                _loc_16 = _loc_11;
                if (_loc_16.outer != null)
                {
                    _loc_16.outer.zpp_inner = null;
                    _loc_16.outer = null;
                }
                _loc_16._isimmutable = null;
                _loc_16._validate = null;
                _loc_16._invalidate = null;
                _loc_16.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_16;
            }
            else
            {
            }
            if (zpp_inner_zn.wrap_a1 == null)
            {
                zpp_inner_zn.setup_a1();
            }
            if (param4 != null)
            {
            }
            if (param4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param4 == null)
            {
                throw "Error: Constraint::" + "anchor2" + " cannot be null";
            }
            if (zpp_inner_zn.wrap_a2 == null)
            {
                zpp_inner_zn.setup_a2();
            }
            _loc_10 = zpp_inner_zn.wrap_a2;
            if (_loc_10 != null)
            {
            }
            if (_loc_10.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param4 != null)
            {
            }
            if (param4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = _loc_10.zpp_inner;
            if (_loc_11._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_11._isimmutable != null)
            {
                _loc_11._isimmutable();
            }
            if (param4 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param4 != null)
            {
            }
            if (param4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = param4.zpp_inner;
            if (_loc_11._validate != null)
            {
                _loc_11._validate();
            }
            _loc_13 = param4.zpp_inner.x;
            if (param4 != null)
            {
            }
            if (param4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = param4.zpp_inner;
            if (_loc_11._validate != null)
            {
                _loc_11._validate();
            }
            _loc_14 = param4.zpp_inner.y;
            if (_loc_10 != null)
            {
            }
            if (_loc_10.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = _loc_10.zpp_inner;
            if (_loc_11._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_11._isimmutable != null)
            {
                _loc_11._isimmutable();
            }
            if (_loc_13 == _loc_13)
            {
            }
            if (_loc_14 != _loc_14)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_10 != null)
            {
            }
            if (_loc_10.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = _loc_10.zpp_inner;
            if (_loc_11._validate != null)
            {
                _loc_11._validate();
            }
            if (_loc_10.zpp_inner.x == _loc_13)
            {
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
            }
            if (_loc_10.zpp_inner.y != _loc_14)
            {
                _loc_10.zpp_inner.x = _loc_13;
                _loc_10.zpp_inner.y = _loc_14;
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._invalidate != null)
                {
                    _loc_11._invalidate(_loc_11);
                }
            }
            _loc_12 = _loc_10;
            if (param4.zpp_inner.weak)
            {
                if (param4 != null)
                {
                }
                if (param4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = param4.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (param4.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_11 = param4.zpp_inner;
                param4.zpp_inner.outer = null;
                param4.zpp_inner = null;
                _loc_15 = param4;
                _loc_15.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_15;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_15;
                }
                ZPP_PubPool.nextVec2 = _loc_15;
                _loc_15.zpp_disp = true;
                _loc_16 = _loc_11;
                if (_loc_16.outer != null)
                {
                    _loc_16.outer.zpp_inner = null;
                    _loc_16.outer = null;
                }
                _loc_16._isimmutable = null;
                _loc_16._validate = null;
                _loc_16._invalidate = null;
                _loc_16.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_16;
            }
            else
            {
            }
            if (zpp_inner_zn.wrap_a2 == null)
            {
                zpp_inner_zn.setup_a2();
            }
            zpp_inner.immutable_midstep("DistanceJoint::jointMin");
            if (param5 != param5)
            {
                throw "Error: DistanceJoint::jointMin cannot be NaN";
            }
            if (param5 < 0)
            {
                throw "Error: DistanceJoint::jointMin must be >= 0";
            }
            if (zpp_inner_zn.jointMin != param5)
            {
                zpp_inner_zn.jointMin = param5;
                zpp_inner.wake();
            }
            zpp_inner.immutable_midstep("DistanceJoint::jointMax");
            if (param6 != param6)
            {
                throw "Error: DistanceJoint::jointMax cannot be NaN";
            }
            if (param6 < 0)
            {
                throw "Error: DistanceJoint::jointMax must be >= 0";
            }
            if (zpp_inner_zn.jointMax != param6)
            {
                zpp_inner_zn.jointMax = param6;
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

        public function set_jointMin(param1:Number) : Number
        {
            zpp_inner.immutable_midstep("DistanceJoint::jointMin");
            if (param1 != param1)
            {
                throw "Error: DistanceJoint::jointMin cannot be NaN";
            }
            if (param1 < 0)
            {
                throw "Error: DistanceJoint::jointMin must be >= 0";
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
            zpp_inner.immutable_midstep("DistanceJoint::jointMax");
            if (param1 != param1)
            {
                throw "Error: DistanceJoint::jointMax cannot be NaN";
            }
            if (param1 < 0)
            {
                throw "Error: DistanceJoint::jointMax must be >= 0";
            }
            if (zpp_inner_zn.jointMax != param1)
            {
                zpp_inner_zn.jointMax = param1;
                zpp_inner.wake();
            }
            return zpp_inner_zn.jointMax;
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
            if ((zpp_inner_zn.b2 == null ? (null) : (zpp_inner_zn.b2.outer)) == null)
            {
                throw "Error: Cannot compute slack for DistanceJoint if either body is null.";
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

        public function get_jointMin() : Number
        {
            return zpp_inner_zn.jointMin;
        }// end function

        public function get_jointMax() : Number
        {
            return zpp_inner_zn.jointMax;
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
