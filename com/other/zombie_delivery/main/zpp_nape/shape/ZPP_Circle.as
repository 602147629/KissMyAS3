package zpp_nape.shape
{
    import flash.*;
    import nape.*;
    import nape.geom.*;
    import nape.shape.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_Circle extends ZPP_Shape
    {
        public var radius:Number;
        public var outer_zn:Circle;

        public function ZPP_Circle() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            radius = 0;
            outer_zn = null;
            super(ZPP_Flags.id_ShapeType_CIRCLE);
            circle = this;
            zip_localCOM = false;
            return;
        }// end function

        public function setupLocalCOM() : void
        {
            var _loc_5:* = null as Vec2;
            var _loc_6:* = false;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_1:* = this;
            var _loc_2:* = localCOMx;
            var _loc_3:* = localCOMy;
            var _loc_4:* = false;
            if (_loc_2 == _loc_2)
            {
            }
            if (_loc_3 != _loc_3)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_5 = new Vec2();
            }
            else
            {
                _loc_5 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_5.zpp_pool;
                _loc_5.zpp_pool = null;
                _loc_5.zpp_disp = false;
                if (_loc_5 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_5.zpp_inner == null)
            {
                _loc_6 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_7 = new ZPP_Vec2();
                }
                else
                {
                    _loc_7 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_7.next;
                    _loc_7.next = null;
                }
                _loc_7.weak = false;
                _loc_7._immutable = _loc_6;
                _loc_7.x = _loc_2;
                _loc_7.y = _loc_3;
                _loc_5.zpp_inner = _loc_7;
                _loc_5.zpp_inner.outer = _loc_5;
            }
            else
            {
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_5.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_2 == _loc_2)
                {
                }
                if (_loc_3 != _loc_3)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_5.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                if (_loc_5.zpp_inner.x == _loc_2)
                {
                    if (_loc_5 != null)
                    {
                    }
                    if (_loc_5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_5.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                }
                if (_loc_5.zpp_inner.y != _loc_3)
                {
                    _loc_5.zpp_inner.x = _loc_2;
                    _loc_5.zpp_inner.y = _loc_3;
                    _loc_7 = _loc_5.zpp_inner;
                    if (_loc_7._invalidate != null)
                    {
                        _loc_7._invalidate(_loc_7);
                    }
                }
            }
            _loc_5.zpp_inner.weak = _loc_4;
            wrap_localCOM = _loc_5;
            wrap_localCOM.zpp_inner._inuse = true;
            wrap_localCOM.zpp_inner._validate = localCOM_validate;
            wrap_localCOM.zpp_inner._invalidate = localCOM_invalidate;
            wrap_localCOM.zpp_inner._isimmutable = localCOM_immutable;
            return;
        }// end function

        public function localCOM_validate() : void
        {
            wrap_localCOM.zpp_inner.x = localCOMx;
            wrap_localCOM.zpp_inner.y = localCOMy;
            return;
        }// end function

        public function localCOM_invalidate(param1:ZPP_Vec2) : void
        {
            localCOMx = param1.x;
            localCOMy = param1.y;
            invalidate_localCOM();
            if (body != null)
            {
                body.wake();
            }
            return;
        }// end function

        public function localCOM_immutable() : void
        {
            if (body != null)
            {
            }
            if (body.type == ZPP_Flags.id_BodyType_STATIC)
            {
            }
            if (body.space != null)
            {
                throw "Error: Cannot modify localCOM of Circle added to a static Body whilst within a Space";
            }
            return;
        }// end function

        public function invalidate_radius() : void
        {
            invalidate_area_inertia();
            invalidate_angDrag();
            zip_aabb = true;
            if (body != null)
            {
                body.zip_aabb = true;
            }
            if (body != null)
            {
                body.wake();
            }
            return;
        }// end function

        public function _force_validate_aabb() : void
        {
            worldCOMx = body.posx + (body.axisy * localCOMx - body.axisx * localCOMy);
            worldCOMy = body.posy + (localCOMx * body.axisx + localCOMy * body.axisy);
            aabb.minx = worldCOMx - radius;
            aabb.miny = worldCOMy - radius;
            aabb.maxx = worldCOMx + radius;
            aabb.maxy = worldCOMy + radius;
            return;
        }// end function

        public function __validate_sweepRadius() : void
        {
            sweepCoef = Math.sqrt(localCOMx * localCOMx + localCOMy * localCOMy);
            sweepRadius = sweepCoef + radius;
            return;
        }// end function

        public function __validate_area_inertia() : void
        {
            var _loc_1:* = radius * radius;
            area = _loc_1 * Math.PI;
            inertia = _loc_1 * 0.5 + (localCOMx * localCOMx + localCOMy * localCOMy);
            return;
        }// end function

        public function __validate_angDrag() : void
        {
            var _loc_1:* = localCOMx * localCOMx + localCOMy * localCOMy;
            var _loc_2:* = radius * radius;
            var _loc_3:* = material.dynamicFriction * Config.fluidAngularDragFriction;
            angDrag = (_loc_1 + 2 * _loc_2) * _loc_3 + 0.5 * Config.fluidAngularDrag * (1 + Config.fluidVacuumDrag) * _loc_1;
            angDrag = angDrag / (2 * (_loc_1 + 0.5 * _loc_2));
            return;
        }// end function

        public function __validate_aabb() : void
        {
            var _loc_1:* = null as ZPP_Polygon;
            var _loc_2:* = NaN;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = NaN;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as ZPP_Body;
            if (zip_worldCOM)
            {
                if (body != null)
                {
                    zip_worldCOM = false;
                    if (zip_localCOM)
                    {
                        zip_localCOM = false;
                        if (type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_1 = polygon;
                            if (_loc_1.lverts.next == null)
                            {
                                throw "Error: An empty polygon has no meaningful localCOM";
                            }
                            if (_loc_1.lverts.next.next == null)
                            {
                                _loc_1.localCOMx = _loc_1.lverts.next.x;
                                _loc_1.localCOMy = _loc_1.lverts.next.y;
                            }
                            else if (_loc_1.lverts.next.next.next == null)
                            {
                                _loc_1.localCOMx = _loc_1.lverts.next.x;
                                _loc_1.localCOMy = _loc_1.lverts.next.y;
                                _loc_2 = 1;
                                _loc_1.localCOMx = _loc_1.localCOMx + _loc_1.lverts.next.next.x * _loc_2;
                                _loc_1.localCOMy = _loc_1.localCOMy + _loc_1.lverts.next.next.y * _loc_2;
                                _loc_2 = 0.5;
                                _loc_1.localCOMx = _loc_1.localCOMx * _loc_2;
                                _loc_1.localCOMy = _loc_1.localCOMy * _loc_2;
                            }
                            else
                            {
                                _loc_1.localCOMx = 0;
                                _loc_1.localCOMy = 0;
                                _loc_2 = 0;
                                _loc_3 = _loc_1.lverts.next;
                                _loc_4 = _loc_3;
                                _loc_3 = _loc_3.next;
                                _loc_5 = _loc_3;
                                _loc_3 = _loc_3.next;
                                while (_loc_3 != null)
                                {
                                    
                                    _loc_6 = _loc_3;
                                    _loc_2 = _loc_2 + _loc_5.x * (_loc_6.y - _loc_4.y);
                                    _loc_7 = _loc_6.y * _loc_5.x - _loc_6.x * _loc_5.y;
                                    _loc_1.localCOMx = _loc_1.localCOMx + (_loc_5.x + _loc_6.x) * _loc_7;
                                    _loc_1.localCOMy = _loc_1.localCOMy + (_loc_5.y + _loc_6.y) * _loc_7;
                                    _loc_4 = _loc_5;
                                    _loc_5 = _loc_6;
                                    _loc_3 = _loc_3.next;
                                }
                                _loc_3 = _loc_1.lverts.next;
                                _loc_6 = _loc_3;
                                _loc_2 = _loc_2 + _loc_5.x * (_loc_6.y - _loc_4.y);
                                _loc_7 = _loc_6.y * _loc_5.x - _loc_6.x * _loc_5.y;
                                _loc_1.localCOMx = _loc_1.localCOMx + (_loc_5.x + _loc_6.x) * _loc_7;
                                _loc_1.localCOMy = _loc_1.localCOMy + (_loc_5.y + _loc_6.y) * _loc_7;
                                _loc_4 = _loc_5;
                                _loc_5 = _loc_6;
                                _loc_3 = _loc_3.next;
                                _loc_8 = _loc_3;
                                _loc_2 = _loc_2 + _loc_5.x * (_loc_8.y - _loc_4.y);
                                _loc_7 = _loc_8.y * _loc_5.x - _loc_8.x * _loc_5.y;
                                _loc_1.localCOMx = _loc_1.localCOMx + (_loc_5.x + _loc_8.x) * _loc_7;
                                _loc_1.localCOMy = _loc_1.localCOMy + (_loc_5.y + _loc_8.y) * _loc_7;
                                _loc_2 = 1 / (3 * _loc_2);
                                _loc_7 = _loc_2;
                                _loc_1.localCOMx = _loc_1.localCOMx * _loc_7;
                                _loc_1.localCOMy = _loc_1.localCOMy * _loc_7;
                            }
                        }
                        if (wrap_localCOM != null)
                        {
                            wrap_localCOM.zpp_inner.x = localCOMx;
                            wrap_localCOM.zpp_inner.y = localCOMy;
                        }
                    }
                    _loc_9 = body;
                    if (_loc_9.zip_axis)
                    {
                        _loc_9.zip_axis = false;
                        _loc_9.axisx = Math.sin(_loc_9.rot);
                        _loc_9.axisy = Math.cos(_loc_9.rot);
                    }
                    worldCOMx = body.posx + (body.axisy * localCOMx - body.axisx * localCOMy);
                    worldCOMy = body.posy + (localCOMx * body.axisx + localCOMy * body.axisy);
                }
            }
            _loc_2 = radius;
            _loc_7 = radius;
            aabb.minx = worldCOMx - _loc_2;
            aabb.miny = worldCOMy - _loc_7;
            aabb.maxx = worldCOMx + _loc_2;
            aabb.maxy = worldCOMy + _loc_7;
            return;
        }// end function

        public function __translate(param1:Number, param2:Number) : void
        {
            var _loc_3:* = 1;
            localCOMx = localCOMx + param1 * _loc_3;
            localCOMy = localCOMy + param2 * _loc_3;
            invalidate_localCOM();
            return;
        }// end function

        public function __transform(param1:Mat23) : void
        {
            var _loc_2:* = param1.zpp_inner.a * param1.zpp_inner.d - param1.zpp_inner.b * param1.zpp_inner.c;
            if (_loc_2 < 0)
            {
                _loc_2 = -_loc_2;
            }
            radius = radius * Math.sqrt(_loc_2);
            var _loc_3:* = param1.zpp_inner.a * localCOMx + param1.zpp_inner.b * localCOMy + param1.zpp_inner.tx;
            localCOMy = param1.zpp_inner.c * localCOMx + param1.zpp_inner.d * localCOMy + param1.zpp_inner.ty;
            localCOMx = _loc_3;
            invalidate_radius();
            invalidate_localCOM();
            return;
        }// end function

        public function __scale(param1:Number, param2:Number) : void
        {
            var _loc_3:* = ((param1 < 0 ? (-param1) : (param1)) + (param2 < 0 ? (-param2) : (param2))) / 2;
            if (_loc_3 < 0)
            {
                radius = radius * (-_loc_3);
            }
            else
            {
                radius = radius * _loc_3;
            }
            invalidate_radius();
            if (localCOMx * localCOMx + localCOMy * localCOMy > 0)
            {
                localCOMx = localCOMx * param1;
                localCOMy = localCOMy * param2;
                invalidate_localCOM();
            }
            return;
        }// end function

        public function __rotate(param1:Number, param2:Number) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            if (localCOMx * localCOMx + localCOMy * localCOMy > 0)
            {
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_3 = param2 * localCOMx - param1 * localCOMy;
                _loc_4 = localCOMx * param1 + localCOMy * param2;
                localCOMx = _loc_3;
                localCOMy = _loc_4;
                invalidate_localCOM();
            }
            return;
        }// end function

        public function __copy() : ZPP_Circle
        {
            var _loc_1:* = new Circle(radius).zpp_inner_zn;
            _loc_1.localCOMx = localCOMx;
            _loc_1.localCOMy = localCOMy;
            _loc_1.zip_localCOM = false;
            return _loc_1;
        }// end function

        public function __clear() : void
        {
            return;
        }// end function

    }
}
