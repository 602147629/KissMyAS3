package nape.shape
{
    import flash.*;
    import nape.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class Shape extends Interactor
    {
        public var zpp_inner:ZPP_Shape;

        public function Shape() : void
        {
            var _loc_2:* = null;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            ;
            _loc_2 = this;
            throw "Error: Shape cannot be instantiated derp!";
            return;
        }// end function

        public function translate(param1:Vec2) : Shape
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            zpp_inner.immutable_midstep("Shape::translate()");
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.body != null)
            {
            }
            if (zpp_inner.body.space != null)
            {
            }
            if (zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
            {
                throw "Error: Cannot modify Shape belonging to a static Object once inside a Space";
            }
            if (param1 == null)
            {
                throw "Error: Cannot displace Shape by null Vec2";
            }
            if (param1.lsq() > 0)
            {
                if (zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    if (param1 != null)
                    {
                    }
                    if (param1.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_2 = param1.zpp_inner;
                    if (_loc_2._validate != null)
                    {
                        _loc_2._validate();
                    }
                    if (param1 != null)
                    {
                    }
                    if (param1.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_2 = param1.zpp_inner;
                    if (_loc_2._validate != null)
                    {
                        _loc_2._validate();
                    }
                    zpp_inner.circle.__translate(param1.zpp_inner.x, param1.zpp_inner.y);
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
                    _loc_2 = param1.zpp_inner;
                    if (_loc_2._validate != null)
                    {
                        _loc_2._validate();
                    }
                    if (param1 != null)
                    {
                    }
                    if (param1.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_2 = param1.zpp_inner;
                    if (_loc_2._validate != null)
                    {
                        _loc_2._validate();
                    }
                    zpp_inner.polygon.__translate(param1.zpp_inner.x, param1.zpp_inner.y);
                }
            }
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = param1.zpp_inner;
                if (_loc_2._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_2._isimmutable != null)
                {
                    _loc_2._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_2 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_3 = param1;
                _loc_3.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_3;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_3;
                }
                ZPP_PubPool.nextVec2 = _loc_3;
                _loc_3.zpp_disp = true;
                _loc_4 = _loc_2;
                if (_loc_4.outer != null)
                {
                    _loc_4.outer.zpp_inner = null;
                    _loc_4.outer = null;
                }
                _loc_4._isimmutable = null;
                _loc_4._validate = null;
                _loc_4._invalidate = null;
                _loc_4.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_4;
            }
            else
            {
            }
            return this;
        }// end function

        public function transform(param1:Mat23) : Shape
        {
            zpp_inner.immutable_midstep("Shape::transform()");
            if (zpp_inner.body != null)
            {
            }
            if (zpp_inner.body.space != null)
            {
            }
            if (zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
            {
                throw "Error: Cannot modify Shape belonging to a static Object once inside a Space";
            }
            if (param1 == null)
            {
                throw "Error: Cannot transform Shape by null matrix";
            }
            if (param1.singular())
            {
                throw "Error: Cannot transform Shape by a singular matrix";
            }
            if (zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                if (param1.equiorthogonal())
                {
                    zpp_inner.circle.__transform(param1);
                }
                else
                {
                    throw "Error: Cannot transform Circle by a non equiorthogonal matrix";
                }
            }
            else
            {
                zpp_inner.polygon.__transform(param1);
            }
            return this;
        }// end function

        override public function toString() : String
        {
            var _loc_1:* = null as String;
            if (zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                _loc_1 = "Circle";
            }
            else
            {
                _loc_1 = "Polygon";
            }
            return _loc_1 + "#" + zpp_inner_i.id;
        }// end function

        public function set_sensorEnabled(param1:Boolean) : Boolean
        {
            zpp_inner.immutable_midstep("Shape::sensorEnabled");
            zpp_inner.sensorEnabled = param1;
            zpp_inner.wake();
            return zpp_inner.sensorEnabled;
        }// end function

        public function set_material(param1:Material) : Material
        {
            zpp_inner.immutable_midstep("Shape::material");
            if (param1 == null)
            {
                throw "Error: Cannot assign null as Shape material";
            }
            zpp_inner.setMaterial(param1.zpp_inner);
            return zpp_inner.material.wrapper();
        }// end function

        public function set_localCOM(param1:Vec2) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            zpp_inner.immutable_midstep("Body::localCOM");
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.body != null)
            {
            }
            if (zpp_inner.body.space != null)
            {
            }
            if (zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
            {
                throw "Error: Cannot modify Shape belonging to a static Object once inside a Space";
            }
            if (param1 == null)
            {
                throw "Error: Shape::localCOM cannot be null";
            }
            if (zpp_inner.wrap_localCOM == null)
            {
                if (zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    zpp_inner.circle.setupLocalCOM();
                }
                else
                {
                    zpp_inner.polygon.setupLocalCOM();
                }
            }
            var _loc_2:* = zpp_inner.wrap_localCOM;
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
            if (zpp_inner.wrap_localCOM == null)
            {
                if (zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    zpp_inner.circle.setupLocalCOM();
                }
                else
                {
                    zpp_inner.polygon.setupLocalCOM();
                }
            }
            return zpp_inner.wrap_localCOM;
        }// end function

        public function set_fluidProperties(param1:FluidProperties) : FluidProperties
        {
            if (param1 == null)
            {
                throw "Error: Cannot assign null as Shape fluidProperties, disable fluids by setting fluidEnabled to false";
            }
            zpp_inner.setFluid(param1.zpp_inner);
            zpp_inner.immutable_midstep("Shape::fluidProperties");
            if (zpp_inner.fluidProperties == null)
            {
                zpp_inner.setFluid(new FluidProperties().zpp_inner);
            }
            return zpp_inner.fluidProperties.wrapper();
        }// end function

        public function set_fluidEnabled(param1:Boolean) : Boolean
        {
            var _loc_2:* = null as FluidProperties;
            zpp_inner.immutable_midstep("Shape::fluidEnabled");
            zpp_inner.fluidEnabled = param1;
            if (param1)
            {
            }
            if (zpp_inner.fluidProperties == null)
            {
                _loc_2 = new FluidProperties();
                if (_loc_2 == null)
                {
                    throw "Error: Cannot assign null as Shape fluidProperties, disable fluids by setting fluidEnabled to false";
                }
                zpp_inner.setFluid(_loc_2.zpp_inner);
                zpp_inner.immutable_midstep("Shape::fluidProperties");
                if (zpp_inner.fluidProperties == null)
                {
                    zpp_inner.setFluid(new FluidProperties().zpp_inner);
                }
                zpp_inner.fluidProperties.wrapper();
            }
            zpp_inner.wake();
            return zpp_inner.fluidEnabled;
        }// end function

        public function set_filter(param1:InteractionFilter) : InteractionFilter
        {
            zpp_inner.immutable_midstep("Shape::filter");
            if (param1 == null)
            {
                throw "Error: Cannot assign null as Shape filter";
            }
            zpp_inner.setFilter(param1.zpp_inner);
            return zpp_inner.filter.wrapper();
        }// end function

        public function set_body(param1:Body) : Body
        {
            var _loc_2:* = null as ShapeList;
            zpp_inner.immutable_midstep("Shape::body");
            if ((zpp_inner.body != null ? (zpp_inner.body.outer) : (null)) != param1)
            {
                if (zpp_inner.body != null)
                {
                    (zpp_inner.body != null ? (zpp_inner.body.outer) : (null)).zpp_inner.wrap_shapes.remove(this);
                }
                if (param1 != null)
                {
                    _loc_2 = param1.zpp_inner.wrap_shapes;
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
            if (zpp_inner.body != null)
            {
                return zpp_inner.body.outer;
            }
            else
            {
                return null;
            }
        }// end function

        public function scale(param1:Number, param2:Number) : Shape
        {
            var _loc_3:* = NaN;
            zpp_inner.immutable_midstep("Shape::scale()");
            if (zpp_inner.body != null)
            {
            }
            if (zpp_inner.body.space != null)
            {
            }
            if (zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
            {
                throw "Error: Cannot modify Shape belonging to a static Object once inside a Space";
            }
            if (param1 == param1)
            {
            }
            if (param2 != param2)
            {
                throw "Error: Cannot scale Shape by NaN";
            }
            if (param1 != 0)
            {
            }
            if (param2 == 0)
            {
                throw "Error: Cannot Scale shape by a factor of 0";
            }
            if (zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                _loc_3 = param1 * param1 - param2 * param2;
                if (_loc_3 * _loc_3 < Config.epsilon * Config.epsilon)
                {
                    zpp_inner.circle.__scale(param1, param2);
                }
                else
                {
                    throw "Error: Cannot perform a non equal scaling on a Circle";
                }
            }
            else
            {
                zpp_inner.polygon.__scale(param1, param2);
            }
            return this;
        }// end function

        public function rotate(param1:Number) : Shape
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            zpp_inner.immutable_midstep("Shape::rotate()");
            if (zpp_inner.body != null)
            {
            }
            if (zpp_inner.body.space != null)
            {
            }
            if (zpp_inner.body.type == ZPP_Flags.id_BodyType_STATIC)
            {
                throw "Error: Cannot modify Shape belonging to a static Object once inside a Space";
            }
            if (param1 != param1)
            {
                throw "Error: Cannot rotate Shape by NaN";
            }
            var _loc_2:* = param1 % (2 * Math.PI);
            if (_loc_2 != 0)
            {
                _loc_3 = Math.cos(param1);
                _loc_4 = Math.sin(param1);
                if (zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    zpp_inner.circle.__rotate(_loc_4, _loc_3);
                }
                else
                {
                    zpp_inner.polygon.__rotate(_loc_4, _loc_3);
                }
            }
            return this;
        }// end function

        public function isPolygon() : Boolean
        {
            return zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON;
        }// end function

        public function isCircle() : Boolean
        {
            return zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE;
        }// end function

        public function get_worldCOM() : Vec2
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = false;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            if (zpp_inner.wrap_worldCOM == null)
            {
                _loc_1 = zpp_inner.worldCOMx;
                _loc_2 = zpp_inner.worldCOMy;
                _loc_3 = false;
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
                zpp_inner.wrap_worldCOM = _loc_4;
                zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                zpp_inner.wrap_worldCOM.zpp_inner._validate = zpp_inner.getworldCOM;
            }
            return zpp_inner.wrap_worldCOM;
        }// end function

        public function get_type() : ShapeType
        {
            return ZPP_Shape.types[zpp_inner.type];
        }// end function

        public function get_sensorEnabled() : Boolean
        {
            return zpp_inner.sensorEnabled;
        }// end function

        public function get_material() : Material
        {
            return zpp_inner.material.wrapper();
        }// end function

        public function get_localCOM() : Vec2
        {
            if (zpp_inner.wrap_localCOM == null)
            {
                if (zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    zpp_inner.circle.setupLocalCOM();
                }
                else
                {
                    zpp_inner.polygon.setupLocalCOM();
                }
            }
            return zpp_inner.wrap_localCOM;
        }// end function

        public function get_inertia() : Number
        {
            zpp_inner.validate_area_inertia();
            return zpp_inner.inertia;
        }// end function

        public function get_fluidProperties() : FluidProperties
        {
            zpp_inner.immutable_midstep("Shape::fluidProperties");
            if (zpp_inner.fluidProperties == null)
            {
                zpp_inner.setFluid(new FluidProperties().zpp_inner);
            }
            return zpp_inner.fluidProperties.wrapper();
        }// end function

        public function get_fluidEnabled() : Boolean
        {
            return zpp_inner.fluidEnabled;
        }// end function

        public function get_filter() : InteractionFilter
        {
            return zpp_inner.filter.wrapper();
        }// end function

        public function get_castPolygon() : Polygon
        {
            if (zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
                return zpp_inner.polygon.outer_zn;
            }
            else
            {
                return null;
            }
        }// end function

        public function get_castCircle() : Circle
        {
            if (zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                return zpp_inner.circle.outer_zn;
            }
            else
            {
                return null;
            }
        }// end function

        public function get_bounds() : AABB
        {
            return zpp_inner.aabb.wrapper();
        }// end function

        public function get_body() : Body
        {
            if (zpp_inner.body != null)
            {
                return zpp_inner.body.outer;
            }
            else
            {
                return null;
            }
        }// end function

        public function get_area() : Number
        {
            zpp_inner.validate_area_inertia();
            return zpp_inner.area;
        }// end function

        public function get_angDrag() : Number
        {
            zpp_inner.validate_angDrag();
            return zpp_inner.angDrag;
        }// end function

        public function copy() : Shape
        {
            return zpp_inner.copy();
        }// end function

        public function contains(param1:Vec2) : Boolean
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Cannot check null point for containment";
            }
            if ((zpp_inner.body != null ? (zpp_inner.body.outer) : (null)) == null)
            {
                throw "Error: Shape is not well defined without a Body";
            }
            ZPP_Geom.validateShape(zpp_inner);
            _loc_2 = param1.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_3:* = ZPP_Collide.shapeContains(zpp_inner, param1.zpp_inner);
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = param1.zpp_inner;
                if (_loc_2._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_2._isimmutable != null)
                {
                    _loc_2._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_2 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_4 = param1;
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
                _loc_5 = _loc_2;
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
            return _loc_3;
        }// end function

    }
}
