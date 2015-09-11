package zpp_nape.phys
{
    import flash.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.geom.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_FluidProperties extends Object
    {
        public var wrap_shapes:ShapeList;
        public var wrap_gravity:Vec2;
        public var viscosity:Number;
        public var userData:Object;
        public var shapes:ZNPList_ZPP_Shape;
        public var outer:FluidProperties;
        public var next:ZPP_FluidProperties;
        public var gravityy:Number;
        public var gravityx:Number;
        public var density:Number;
        public static var zpp_pool:ZPP_FluidProperties;

        public function ZPP_FluidProperties() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            wrap_gravity = null;
            gravityy = 0;
            gravityx = 0;
            density = 0;
            viscosity = 0;
            wrap_shapes = null;
            shapes = null;
            outer = null;
            userData = null;
            next = null;
            shapes = new ZNPList_ZPP_Shape();
            var _loc_1:* = 1;
            viscosity = 1;
            density = _loc_1;
            wrap_gravity = null;
            gravityx = 0;
            gravityy = 0;
            return;
        }// end function

        public function wrapper() : FluidProperties
        {
            var _loc_1:* = null as ZPP_FluidProperties;
            if (outer == null)
            {
                outer = new FluidProperties();
                _loc_1 = outer.zpp_inner;
                _loc_1.outer = null;
                _loc_1.next = ZPP_FluidProperties.zpp_pool;
                ZPP_FluidProperties.zpp_pool = _loc_1;
                outer.zpp_inner = this;
            }
            return outer;
        }// end function

        public function remShape(param1:ZPP_Shape) : void
        {
            shapes.remove(param1);
            return;
        }// end function

        public function invalidate() : void
        {
            var _loc_2:* = null as ZPP_Shape;
            var _loc_1:* = shapes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.invalidate_fluidprops();
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function gravity_validate() : void
        {
            wrap_gravity.zpp_inner.x = gravityx;
            wrap_gravity.zpp_inner.y = gravityy;
            return;
        }// end function

        public function gravity_invalidate(param1:ZPP_Vec2) : void
        {
            gravityx = param1.x;
            gravityy = param1.y;
            invalidate();
            return;
        }// end function

        public function getgravity() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = gravityx;
            var _loc_2:* = gravityy;
            var _loc_3:* = false;
            if (_loc_1 == _loc_1)
            {
            }
            if (_loc_2 != _loc_2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_4 = new Vec2();
            }
            else
            {
                _loc_4 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_4.zpp_pool;
                _loc_4.zpp_pool = null;
                _loc_4.zpp_disp = false;
                if (_loc_4 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_4.zpp_inner == null)
            {
                _loc_5 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_6 = new ZPP_Vec2();
                }
                else
                {
                    _loc_6 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.weak = false;
                _loc_6._immutable = _loc_5;
                _loc_6.x = _loc_1;
                _loc_6.y = _loc_2;
                _loc_4.zpp_inner = _loc_6;
                _loc_4.zpp_inner.outer = _loc_4;
            }
            else
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_1 == _loc_1)
                {
                }
                if (_loc_2 != _loc_2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_4.zpp_inner.x == _loc_1)
                {
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_4.zpp_inner.y != _loc_2)
                {
                    _loc_4.zpp_inner.x = _loc_1;
                    _loc_4.zpp_inner.y = _loc_2;
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_4.zpp_inner.weak = _loc_3;
            wrap_gravity = _loc_4;
            wrap_gravity.zpp_inner._inuse = true;
            wrap_gravity.zpp_inner._invalidate = gravity_invalidate;
            wrap_gravity.zpp_inner._validate = gravity_validate;
            return;
        }// end function

        public function free() : void
        {
            outer = null;
            return;
        }// end function

        public function feature_cons() : void
        {
            shapes = new ZNPList_ZPP_Shape();
            return;
        }// end function

        public function copy() : ZPP_FluidProperties
        {
            var _loc_1:* = null as ZPP_FluidProperties;
            if (ZPP_FluidProperties.zpp_pool == null)
            {
                _loc_1 = new ZPP_FluidProperties();
            }
            else
            {
                _loc_1 = ZPP_FluidProperties.zpp_pool;
                ZPP_FluidProperties.zpp_pool = _loc_1.next;
                _loc_1.next = null;
            }
            _loc_1.viscosity = viscosity;
            _loc_1.density = density;
            return _loc_1;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public function addShape(param1:ZPP_Shape) : void
        {
            shapes.add(param1);
            return;
        }// end function

    }
}
