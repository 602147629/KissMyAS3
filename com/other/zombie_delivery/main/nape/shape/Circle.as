package nape.shape
{
    import flash.*;
    import nape.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    final public class Circle extends Shape
    {
        public var zpp_inner_zn:ZPP_Circle;

        public function Circle(param1:Number = 0, param2:Vec2 = undefined, param3:Material = undefined, param4:InteractionFilter = undefined) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner_zn = null;
            ;
            _loc_6 = this;
            zpp_inner_zn = new ZPP_Circle();
            zpp_inner_zn.outer = this;
            zpp_inner_zn.outer_zn = this;
            zpp_inner = zpp_inner_zn;
            zpp_inner_i = zpp_inner;
            zpp_inner_i.outer_i = this;
            zpp_inner.immutable_midstep("Circle::radius");
            if (zpp_inner.body != null)
            {
            }
            if (zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
            {
            }
            if (zpp_inner.body.space != null)
            {
                throw "Error: Cannot modifiy radius of Circle contained in static object once added to space";
            }
            if (param1 != zpp_inner_zn.radius)
            {
                if (param1 != param1)
                {
                    throw "Error: Circle::radius cannot be NaN";
                }
                if (param1 < Config.epsilon)
                {
                    throw "Error: Circle::radius (" + param1 + ") must be > Config.epsilon";
                }
                if (param1 > 1000000000000000000000000000000)
                {
                    throw "Error: Circle::radius (" + param1 + ") must be < PR(Const).FMAX";
                }
                zpp_inner_zn.radius = param1;
                zpp_inner_zn.invalidate_radius();
            }
            if (param2 == null)
            {
                zpp_inner.localCOMx = 0;
                zpp_inner.localCOMy = 0;
            }
            else
            {
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param2.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                zpp_inner.localCOMx = param2.zpp_inner.x;
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param2.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                zpp_inner.localCOMy = param2.zpp_inner.y;
                if (param2.zpp_inner.weak)
                {
                    if (param2 != null)
                    {
                    }
                    if (param2.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = param2.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (param2.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_7 = param2.zpp_inner;
                    param2.zpp_inner.outer = null;
                    param2.zpp_inner = null;
                    _loc_8 = param2;
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
                    _loc_9 = _loc_7;
                    if (_loc_9.outer != null)
                    {
                        _loc_9.outer.zpp_inner = null;
                        _loc_9.outer = null;
                    }
                    _loc_9._isimmutable = null;
                    _loc_9._validate = null;
                    _loc_9._invalidate = null;
                    _loc_9.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_9;
                }
                else
                {
                }
            }
            if (param3 == null)
            {
                if (ZPP_Material.zpp_pool == null)
                {
                    zpp_inner.material = new ZPP_Material();
                }
                else
                {
                    zpp_inner.material = ZPP_Material.zpp_pool;
                    ZPP_Material.zpp_pool = zpp_inner.material.next;
                    zpp_inner.material.next = null;
                }
            }
            else
            {
                zpp_inner.immutable_midstep("Shape::material");
                if (param3 == null)
                {
                    throw "Error: Cannot assign null as Shape material";
                }
                zpp_inner.setMaterial(param3.zpp_inner);
                zpp_inner.material.wrapper();
            }
            if (param4 == null)
            {
                if (ZPP_InteractionFilter.zpp_pool == null)
                {
                    zpp_inner.filter = new ZPP_InteractionFilter();
                }
                else
                {
                    zpp_inner.filter = ZPP_InteractionFilter.zpp_pool;
                    ZPP_InteractionFilter.zpp_pool = zpp_inner.filter.next;
                    zpp_inner.filter.next = null;
                }
            }
            else
            {
                zpp_inner.immutable_midstep("Shape::filter");
                if (param4 == null)
                {
                    throw "Error: Cannot assign null as Shape filter";
                }
                zpp_inner.setFilter(param4.zpp_inner);
                zpp_inner.filter.wrapper();
            }
            zpp_inner_i.insert_cbtype(ZPP_CbType.ANY_SHAPE.zpp_inner);
            return;
        }// end function

        public function set_radius(param1:Number) : Number
        {
            zpp_inner.immutable_midstep("Circle::radius");
            if (zpp_inner.body != null)
            {
            }
            if (zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
            {
            }
            if (zpp_inner.body.space != null)
            {
                throw "Error: Cannot modifiy radius of Circle contained in static object once added to space";
            }
            if (param1 != zpp_inner_zn.radius)
            {
                if (param1 != param1)
                {
                    throw "Error: Circle::radius cannot be NaN";
                }
                if (param1 < Config.epsilon)
                {
                    throw "Error: Circle::radius (" + param1 + ") must be > Config.epsilon";
                }
                if (param1 > 1000000000000000000000000000000)
                {
                    throw "Error: Circle::radius (" + param1 + ") must be < PR(Const).FMAX";
                }
                zpp_inner_zn.radius = param1;
                zpp_inner_zn.invalidate_radius();
            }
            return zpp_inner_zn.radius;
        }// end function

        public function get_radius() : Number
        {
            return zpp_inner_zn.radius;
        }// end function

    }
}
