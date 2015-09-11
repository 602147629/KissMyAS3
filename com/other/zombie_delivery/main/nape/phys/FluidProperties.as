package nape.phys
{
    import flash.*;
    import nape.geom.*;
    import nape.shape.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.util.*;

    final public class FluidProperties extends Object
    {
        public var zpp_inner:ZPP_FluidProperties;

        public function FluidProperties(param1:Number = 1, param2:Number = 1) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (ZPP_FluidProperties.zpp_pool == null)
            {
                zpp_inner = new ZPP_FluidProperties();
            }
            else
            {
                zpp_inner = ZPP_FluidProperties.zpp_pool;
                ZPP_FluidProperties.zpp_pool = zpp_inner.next;
                zpp_inner.next = null;
            }
            zpp_inner.outer = this;
            if (param1 != zpp_inner.density * 1000)
            {
                if (param1 != param1)
                {
                    throw "Error: FluidProperties::" + "density" + " cannot be NaN";
                }
                zpp_inner.density = param1 / 1000;
                zpp_inner.invalidate();
            }
            if (param2 != zpp_inner.viscosity)
            {
                if (param2 != param2)
                {
                    throw "Error: FluidProperties::" + "viscosity" + " cannot be NaN";
                }
                if (param2 < 0)
                {
                    throw "Error: FluidProperties::" + "viscosity" + " (" + param2 + ") must be >= 0";
                }
                zpp_inner.viscosity = param2 / 1;
                zpp_inner.invalidate();
            }
            return;
        }// end function

        public function toString() : String
        {
            return "{ density: " + zpp_inner.density * 1000 + " viscosity: " + zpp_inner.viscosity + " gravity: " + Std.string(zpp_inner.wrap_gravity) + " }";
        }// end function

        public function set_viscosity(param1:Number) : Number
        {
            if (param1 != zpp_inner.viscosity)
            {
                if (param1 != param1)
                {
                    throw "Error: FluidProperties::" + "viscosity" + " cannot be NaN";
                }
                if (param1 < 0)
                {
                    throw "Error: FluidProperties::" + "viscosity" + " (" + param1 + ") must be >= 0";
                }
                zpp_inner.viscosity = param1 / 1;
                zpp_inner.invalidate();
            }
            return zpp_inner.viscosity;
        }// end function

        public function set_gravity(param1:Vec2) : Vec2
        {
            var _loc_2:* = null as Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = null as Vec2;
            if (param1 == null)
            {
                if (zpp_inner.wrap_gravity != null)
                {
                    zpp_inner.wrap_gravity.zpp_inner._inuse = false;
                    _loc_2 = zpp_inner.wrap_gravity;
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
                    if (_loc_2.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_3 = _loc_2.zpp_inner;
                    _loc_2.zpp_inner.outer = null;
                    _loc_2.zpp_inner = null;
                    _loc_4 = _loc_2;
                    _loc_4.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_4;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_4;
                    }
                    ZPP_PubPool.nextVec2 = _loc_4;
                    _loc_4.zpp_disp = true;
                    _loc_5 = _loc_3;
                    if (_loc_5.outer != null)
                    {
                        _loc_5.outer.zpp_inner = null;
                        _loc_5.outer = null;
                    }
                    _loc_5._isimmutable = null;
                    _loc_5._validate = null;
                    _loc_5._invalidate = null;
                    _loc_5.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_5;
                    zpp_inner.wrap_gravity = null;
                }
            }
            else
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (zpp_inner.wrap_gravity == null)
                {
                    zpp_inner.getgravity();
                }
                _loc_2 = zpp_inner.wrap_gravity;
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
                _loc_6 = param1.zpp_inner.x;
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
                _loc_7 = param1.zpp_inner.y;
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
                if (_loc_6 == _loc_6)
                {
                }
                if (_loc_7 != _loc_7)
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
                if (_loc_2.zpp_inner.x == _loc_6)
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
                if (_loc_2.zpp_inner.y != _loc_7)
                {
                    _loc_2.zpp_inner.x = _loc_6;
                    _loc_2.zpp_inner.y = _loc_7;
                    _loc_3 = _loc_2.zpp_inner;
                    if (_loc_3._invalidate != null)
                    {
                        _loc_3._invalidate(_loc_3);
                    }
                }
                _loc_4 = _loc_2;
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
                    _loc_8 = param1;
                    _loc_8.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_8;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_8;
                    }
                    ZPP_PubPool.nextVec2 = _loc_8;
                    _loc_8.zpp_disp = true;
                    _loc_5 = _loc_3;
                    if (_loc_5.outer != null)
                    {
                        _loc_5.outer.zpp_inner = null;
                        _loc_5.outer = null;
                    }
                    _loc_5._isimmutable = null;
                    _loc_5._validate = null;
                    _loc_5._invalidate = null;
                    _loc_5.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_5;
                }
                else
                {
                }
            }
            return zpp_inner.wrap_gravity;
        }// end function

        public function set_density(param1:Number) : Number
        {
            if (param1 != zpp_inner.density * 1000)
            {
                if (param1 != param1)
                {
                    throw "Error: FluidProperties::" + "density" + " cannot be NaN";
                }
                zpp_inner.density = param1 / 1000;
                zpp_inner.invalidate();
            }
            return zpp_inner.density * 1000;
        }// end function

        public function get_viscosity() : Number
        {
            return zpp_inner.viscosity;
        }// end function

        public function get_userData()
        {
            if (zpp_inner.userData == null)
            {
                zpp_inner.userData = {};
            }
            return zpp_inner.userData;
        }// end function

        public function get_shapes() : ShapeList
        {
            if (zpp_inner.wrap_shapes == null)
            {
                zpp_inner.wrap_shapes = ZPP_ShapeList.get(zpp_inner.shapes, true);
            }
            return zpp_inner.wrap_shapes;
        }// end function

        public function get_gravity() : Vec2
        {
            return zpp_inner.wrap_gravity;
        }// end function

        public function get_density() : Number
        {
            return zpp_inner.density * 1000;
        }// end function

        public function copy() : FluidProperties
        {
            var _loc_3:* = null as Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = null as Vec2;
            var _loc_1:* = new FluidProperties(zpp_inner.density * 1000, zpp_inner.viscosity);
            if (zpp_inner.userData != null)
            {
                _loc_1.zpp_inner.userData = Reflect.copy(zpp_inner.userData);
            }
            var _loc_2:* = zpp_inner.wrap_gravity;
            if (_loc_2 == null)
            {
                if (_loc_1.zpp_inner.wrap_gravity != null)
                {
                    _loc_1.zpp_inner.wrap_gravity.zpp_inner._inuse = false;
                    _loc_3 = _loc_1.zpp_inner.wrap_gravity;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_4 = _loc_3.zpp_inner;
                    if (_loc_4._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_4._isimmutable != null)
                    {
                        _loc_4._isimmutable();
                    }
                    if (_loc_3.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_4 = _loc_3.zpp_inner;
                    _loc_3.zpp_inner.outer = null;
                    _loc_3.zpp_inner = null;
                    _loc_5 = _loc_3;
                    _loc_5.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_5;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_5;
                    }
                    ZPP_PubPool.nextVec2 = _loc_5;
                    _loc_5.zpp_disp = true;
                    _loc_6 = _loc_4;
                    if (_loc_6.outer != null)
                    {
                        _loc_6.outer.zpp_inner = null;
                        _loc_6.outer = null;
                    }
                    _loc_6._isimmutable = null;
                    _loc_6._validate = null;
                    _loc_6._invalidate = null;
                    _loc_6.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_6;
                    _loc_1.zpp_inner.wrap_gravity = null;
                }
            }
            else
            {
                if (_loc_2 != null)
                {
                }
                if (_loc_2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (_loc_1.zpp_inner.wrap_gravity == null)
                {
                    _loc_1.zpp_inner.getgravity();
                }
                _loc_3 = _loc_1.zpp_inner.wrap_gravity;
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (_loc_2 != null)
                {
                }
                if (_loc_2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_3.zpp_inner;
                if (_loc_4._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_4._isimmutable != null)
                {
                    _loc_4._isimmutable();
                }
                if (_loc_2 == null)
                {
                    throw "Error: Cannot assign null Vec2";
                }
                if (_loc_2 != null)
                {
                }
                if (_loc_2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_2.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                _loc_7 = _loc_2.zpp_inner.x;
                if (_loc_2 != null)
                {
                }
                if (_loc_2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_2.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                _loc_8 = _loc_2.zpp_inner.y;
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_3.zpp_inner;
                if (_loc_4._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_4._isimmutable != null)
                {
                    _loc_4._isimmutable();
                }
                if (_loc_7 == _loc_7)
                {
                }
                if (_loc_8 != _loc_8)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_3.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                if (_loc_3.zpp_inner.x == _loc_7)
                {
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_4 = _loc_3.zpp_inner;
                    if (_loc_4._validate != null)
                    {
                        _loc_4._validate();
                    }
                }
                if (_loc_3.zpp_inner.y != _loc_8)
                {
                    _loc_3.zpp_inner.x = _loc_7;
                    _loc_3.zpp_inner.y = _loc_8;
                    _loc_4 = _loc_3.zpp_inner;
                    if (_loc_4._invalidate != null)
                    {
                        _loc_4._invalidate(_loc_4);
                    }
                }
                _loc_5 = _loc_3;
                if (_loc_2.zpp_inner.weak)
                {
                    if (_loc_2 != null)
                    {
                    }
                    if (_loc_2.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_4 = _loc_2.zpp_inner;
                    if (_loc_4._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_4._isimmutable != null)
                    {
                        _loc_4._isimmutable();
                    }
                    if (_loc_2.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_4 = _loc_2.zpp_inner;
                    _loc_2.zpp_inner.outer = null;
                    _loc_2.zpp_inner = null;
                    _loc_9 = _loc_2;
                    _loc_9.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_9;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_9;
                    }
                    ZPP_PubPool.nextVec2 = _loc_9;
                    _loc_9.zpp_disp = true;
                    _loc_6 = _loc_4;
                    if (_loc_6.outer != null)
                    {
                        _loc_6.outer.zpp_inner = null;
                        _loc_6.outer = null;
                    }
                    _loc_6._isimmutable = null;
                    _loc_6._validate = null;
                    _loc_6._invalidate = null;
                    _loc_6.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_6;
                }
                else
                {
                }
            }
            return _loc_1;
        }// end function

    }
}
