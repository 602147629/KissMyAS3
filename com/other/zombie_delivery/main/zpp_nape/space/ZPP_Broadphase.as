package zpp_nape.space
{
    import flash.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_Broadphase extends Object
    {
        public var sweep:ZPP_SweepPhase;
        public var space:ZPP_Space;
        public var matrix:Mat23;
        public var is_sweep:Boolean;
        public var dynab:ZPP_DynAABBPhase;
        public var circShape:Shape;
        public var aabbShape:Shape;

        public function ZPP_Broadphase() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            circShape = null;
            matrix = null;
            aabbShape = null;
            dynab = null;
            sweep = null;
            is_sweep = false;
            space = null;
            return;
        }// end function

        public function validateShape(param1:ZPP_Shape) : void
        {
            var _loc_2:* = null as ZPP_Polygon;
            var _loc_3:* = null as ZPP_Body;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZNPNode_ZPP_Edge;
            var _loc_9:* = null as ZPP_Edge;
            var _loc_10:* = null as ZPP_Circle;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = null as ZPP_Vec2;
            if (param1.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
                _loc_2 = param1.polygon;
                if (_loc_2.zip_gaxi)
                {
                    if (_loc_2.body != null)
                    {
                        _loc_2.zip_gaxi = false;
                        _loc_2.validate_laxi();
                        _loc_3 = _loc_2.body;
                        if (_loc_3.zip_axis)
                        {
                            _loc_3.zip_axis = false;
                            _loc_3.axisx = Math.sin(_loc_3.rot);
                            _loc_3.axisy = Math.cos(_loc_3.rot);
                        }
                        if (_loc_2.zip_gverts)
                        {
                            if (_loc_2.body != null)
                            {
                                _loc_2.zip_gverts = false;
                                _loc_2.validate_lverts();
                                _loc_3 = _loc_2.body;
                                if (_loc_3.zip_axis)
                                {
                                    _loc_3.zip_axis = false;
                                    _loc_3.axisx = Math.sin(_loc_3.rot);
                                    _loc_3.axisy = Math.cos(_loc_3.rot);
                                }
                                _loc_4 = _loc_2.lverts.next;
                                _loc_5 = _loc_2.gverts.next;
                                while (_loc_5 != null)
                                {
                                    
                                    _loc_6 = _loc_5;
                                    _loc_7 = _loc_4;
                                    _loc_4 = _loc_4.next;
                                    _loc_6.x = _loc_2.body.posx + (_loc_2.body.axisy * _loc_7.x - _loc_2.body.axisx * _loc_7.y);
                                    _loc_6.y = _loc_2.body.posy + (_loc_7.x * _loc_2.body.axisx + _loc_7.y * _loc_2.body.axisy);
                                    _loc_5 = _loc_5.next;
                                }
                            }
                        }
                        _loc_8 = _loc_2.edges.head;
                        _loc_4 = _loc_2.gverts.next;
                        _loc_5 = _loc_4;
                        _loc_4 = _loc_4.next;
                        while (_loc_4 != null)
                        {
                            
                            _loc_6 = _loc_4;
                            _loc_9 = _loc_8.elt;
                            _loc_8 = _loc_8.next;
                            _loc_9.gp0 = _loc_5;
                            _loc_9.gp1 = _loc_6;
                            _loc_9.gnormx = _loc_2.body.axisy * _loc_9.lnormx - _loc_2.body.axisx * _loc_9.lnormy;
                            _loc_9.gnormy = _loc_9.lnormx * _loc_2.body.axisx + _loc_9.lnormy * _loc_2.body.axisy;
                            _loc_9.gprojection = _loc_2.body.posx * _loc_9.gnormx + _loc_2.body.posy * _loc_9.gnormy + _loc_9.lprojection;
                            if (_loc_9.wrap_gnorm != null)
                            {
                                _loc_9.wrap_gnorm.zpp_inner.x = _loc_9.gnormx;
                                _loc_9.wrap_gnorm.zpp_inner.y = _loc_9.gnormy;
                            }
                            _loc_9.tp0 = _loc_9.gp0.y * _loc_9.gnormx - _loc_9.gp0.x * _loc_9.gnormy;
                            _loc_9.tp1 = _loc_9.gp1.y * _loc_9.gnormx - _loc_9.gp1.x * _loc_9.gnormy;
                            _loc_5 = _loc_6;
                            _loc_4 = _loc_4.next;
                        }
                        _loc_6 = _loc_2.gverts.next;
                        _loc_9 = _loc_8.elt;
                        _loc_8 = _loc_8.next;
                        _loc_9.gp0 = _loc_5;
                        _loc_9.gp1 = _loc_6;
                        _loc_9.gnormx = _loc_2.body.axisy * _loc_9.lnormx - _loc_2.body.axisx * _loc_9.lnormy;
                        _loc_9.gnormy = _loc_9.lnormx * _loc_2.body.axisx + _loc_9.lnormy * _loc_2.body.axisy;
                        _loc_9.gprojection = _loc_2.body.posx * _loc_9.gnormx + _loc_2.body.posy * _loc_9.gnormy + _loc_9.lprojection;
                        if (_loc_9.wrap_gnorm != null)
                        {
                            _loc_9.wrap_gnorm.zpp_inner.x = _loc_9.gnormx;
                            _loc_9.wrap_gnorm.zpp_inner.y = _loc_9.gnormy;
                        }
                        _loc_9.tp0 = _loc_9.gp0.y * _loc_9.gnormx - _loc_9.gp0.x * _loc_9.gnormy;
                        _loc_9.tp1 = _loc_9.gp1.y * _loc_9.gnormx - _loc_9.gp1.x * _loc_9.gnormy;
                    }
                }
            }
            if (param1.zip_aabb)
            {
                if (param1.body != null)
                {
                    param1.zip_aabb = false;
                    if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_10 = param1.circle;
                        if (_loc_10.zip_worldCOM)
                        {
                            if (_loc_10.body != null)
                            {
                                _loc_10.zip_worldCOM = false;
                                if (_loc_10.zip_localCOM)
                                {
                                    _loc_10.zip_localCOM = false;
                                    if (_loc_10.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                        _loc_2 = _loc_10.polygon;
                                        if (_loc_2.lverts.next == null)
                                        {
                                            throw "Error: An empty polygon has no meaningful localCOM";
                                        }
                                        if (_loc_2.lverts.next.next == null)
                                        {
                                            _loc_2.localCOMx = _loc_2.lverts.next.x;
                                            _loc_2.localCOMy = _loc_2.lverts.next.y;
                                        }
                                        else if (_loc_2.lverts.next.next.next == null)
                                        {
                                            _loc_2.localCOMx = _loc_2.lverts.next.x;
                                            _loc_2.localCOMy = _loc_2.lverts.next.y;
                                            _loc_11 = 1;
                                            _loc_2.localCOMx = _loc_2.localCOMx + _loc_2.lverts.next.next.x * _loc_11;
                                            _loc_2.localCOMy = _loc_2.localCOMy + _loc_2.lverts.next.next.y * _loc_11;
                                            _loc_11 = 0.5;
                                            _loc_2.localCOMx = _loc_2.localCOMx * _loc_11;
                                            _loc_2.localCOMy = _loc_2.localCOMy * _loc_11;
                                        }
                                        else
                                        {
                                            _loc_2.localCOMx = 0;
                                            _loc_2.localCOMy = 0;
                                            _loc_11 = 0;
                                            _loc_4 = _loc_2.lverts.next;
                                            _loc_5 = _loc_4;
                                            _loc_4 = _loc_4.next;
                                            _loc_6 = _loc_4;
                                            _loc_4 = _loc_4.next;
                                            while (_loc_4 != null)
                                            {
                                                
                                                _loc_7 = _loc_4;
                                                _loc_11 = _loc_11 + _loc_6.x * (_loc_7.y - _loc_5.y);
                                                _loc_12 = _loc_7.y * _loc_6.x - _loc_7.x * _loc_6.y;
                                                _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_7.x) * _loc_12;
                                                _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_7.y) * _loc_12;
                                                _loc_5 = _loc_6;
                                                _loc_6 = _loc_7;
                                                _loc_4 = _loc_4.next;
                                            }
                                            _loc_4 = _loc_2.lverts.next;
                                            _loc_7 = _loc_4;
                                            _loc_11 = _loc_11 + _loc_6.x * (_loc_7.y - _loc_5.y);
                                            _loc_12 = _loc_7.y * _loc_6.x - _loc_7.x * _loc_6.y;
                                            _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_7.x) * _loc_12;
                                            _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_7.y) * _loc_12;
                                            _loc_5 = _loc_6;
                                            _loc_6 = _loc_7;
                                            _loc_4 = _loc_4.next;
                                            _loc_13 = _loc_4;
                                            _loc_11 = _loc_11 + _loc_6.x * (_loc_13.y - _loc_5.y);
                                            _loc_12 = _loc_13.y * _loc_6.x - _loc_13.x * _loc_6.y;
                                            _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_13.x) * _loc_12;
                                            _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_13.y) * _loc_12;
                                            _loc_11 = 1 / (3 * _loc_11);
                                            _loc_12 = _loc_11;
                                            _loc_2.localCOMx = _loc_2.localCOMx * _loc_12;
                                            _loc_2.localCOMy = _loc_2.localCOMy * _loc_12;
                                        }
                                    }
                                    if (_loc_10.wrap_localCOM != null)
                                    {
                                        _loc_10.wrap_localCOM.zpp_inner.x = _loc_10.localCOMx;
                                        _loc_10.wrap_localCOM.zpp_inner.y = _loc_10.localCOMy;
                                    }
                                }
                                _loc_3 = _loc_10.body;
                                if (_loc_3.zip_axis)
                                {
                                    _loc_3.zip_axis = false;
                                    _loc_3.axisx = Math.sin(_loc_3.rot);
                                    _loc_3.axisy = Math.cos(_loc_3.rot);
                                }
                                _loc_10.worldCOMx = _loc_10.body.posx + (_loc_10.body.axisy * _loc_10.localCOMx - _loc_10.body.axisx * _loc_10.localCOMy);
                                _loc_10.worldCOMy = _loc_10.body.posy + (_loc_10.localCOMx * _loc_10.body.axisx + _loc_10.localCOMy * _loc_10.body.axisy);
                            }
                        }
                        _loc_11 = _loc_10.radius;
                        _loc_12 = _loc_10.radius;
                        _loc_10.aabb.minx = _loc_10.worldCOMx - _loc_11;
                        _loc_10.aabb.miny = _loc_10.worldCOMy - _loc_12;
                        _loc_10.aabb.maxx = _loc_10.worldCOMx + _loc_11;
                        _loc_10.aabb.maxy = _loc_10.worldCOMy + _loc_12;
                    }
                    else
                    {
                        _loc_2 = param1.polygon;
                        if (_loc_2.zip_gverts)
                        {
                            if (_loc_2.body != null)
                            {
                                _loc_2.zip_gverts = false;
                                _loc_2.validate_lverts();
                                _loc_3 = _loc_2.body;
                                if (_loc_3.zip_axis)
                                {
                                    _loc_3.zip_axis = false;
                                    _loc_3.axisx = Math.sin(_loc_3.rot);
                                    _loc_3.axisy = Math.cos(_loc_3.rot);
                                }
                                _loc_4 = _loc_2.lverts.next;
                                _loc_5 = _loc_2.gverts.next;
                                while (_loc_5 != null)
                                {
                                    
                                    _loc_6 = _loc_5;
                                    _loc_7 = _loc_4;
                                    _loc_4 = _loc_4.next;
                                    _loc_6.x = _loc_2.body.posx + (_loc_2.body.axisy * _loc_7.x - _loc_2.body.axisx * _loc_7.y);
                                    _loc_6.y = _loc_2.body.posy + (_loc_7.x * _loc_2.body.axisx + _loc_7.y * _loc_2.body.axisy);
                                    _loc_5 = _loc_5.next;
                                }
                            }
                        }
                        if (_loc_2.lverts.next == null)
                        {
                            throw "Error: An empty polygon has no meaningful bounds";
                        }
                        _loc_4 = _loc_2.gverts.next;
                        _loc_2.aabb.minx = _loc_4.x;
                        _loc_2.aabb.miny = _loc_4.y;
                        _loc_2.aabb.maxx = _loc_4.x;
                        _loc_2.aabb.maxy = _loc_4.y;
                        _loc_5 = _loc_2.gverts.next.next;
                        while (_loc_5 != null)
                        {
                            
                            _loc_6 = _loc_5;
                            if (_loc_6.x < _loc_2.aabb.minx)
                            {
                                _loc_2.aabb.minx = _loc_6.x;
                            }
                            if (_loc_6.x > _loc_2.aabb.maxx)
                            {
                                _loc_2.aabb.maxx = _loc_6.x;
                            }
                            if (_loc_6.y < _loc_2.aabb.miny)
                            {
                                _loc_2.aabb.miny = _loc_6.y;
                            }
                            if (_loc_6.y > _loc_2.aabb.maxy)
                            {
                                _loc_2.aabb.maxy = _loc_6.y;
                            }
                            _loc_5 = _loc_5.next;
                        }
                    }
                }
            }
            if (param1.zip_worldCOM)
            {
                if (param1.body != null)
                {
                    param1.zip_worldCOM = false;
                    if (param1.zip_localCOM)
                    {
                        param1.zip_localCOM = false;
                        if (param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_2 = param1.polygon;
                            if (_loc_2.lverts.next == null)
                            {
                                throw "Error: An empty polygon has no meaningful localCOM";
                            }
                            if (_loc_2.lverts.next.next == null)
                            {
                                _loc_2.localCOMx = _loc_2.lverts.next.x;
                                _loc_2.localCOMy = _loc_2.lverts.next.y;
                            }
                            else if (_loc_2.lverts.next.next.next == null)
                            {
                                _loc_2.localCOMx = _loc_2.lverts.next.x;
                                _loc_2.localCOMy = _loc_2.lverts.next.y;
                                _loc_11 = 1;
                                _loc_2.localCOMx = _loc_2.localCOMx + _loc_2.lverts.next.next.x * _loc_11;
                                _loc_2.localCOMy = _loc_2.localCOMy + _loc_2.lverts.next.next.y * _loc_11;
                                _loc_11 = 0.5;
                                _loc_2.localCOMx = _loc_2.localCOMx * _loc_11;
                                _loc_2.localCOMy = _loc_2.localCOMy * _loc_11;
                            }
                            else
                            {
                                _loc_2.localCOMx = 0;
                                _loc_2.localCOMy = 0;
                                _loc_11 = 0;
                                _loc_4 = _loc_2.lverts.next;
                                _loc_5 = _loc_4;
                                _loc_4 = _loc_4.next;
                                _loc_6 = _loc_4;
                                _loc_4 = _loc_4.next;
                                while (_loc_4 != null)
                                {
                                    
                                    _loc_7 = _loc_4;
                                    _loc_11 = _loc_11 + _loc_6.x * (_loc_7.y - _loc_5.y);
                                    _loc_12 = _loc_7.y * _loc_6.x - _loc_7.x * _loc_6.y;
                                    _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_7.x) * _loc_12;
                                    _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_7.y) * _loc_12;
                                    _loc_5 = _loc_6;
                                    _loc_6 = _loc_7;
                                    _loc_4 = _loc_4.next;
                                }
                                _loc_4 = _loc_2.lverts.next;
                                _loc_7 = _loc_4;
                                _loc_11 = _loc_11 + _loc_6.x * (_loc_7.y - _loc_5.y);
                                _loc_12 = _loc_7.y * _loc_6.x - _loc_7.x * _loc_6.y;
                                _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_7.x) * _loc_12;
                                _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_7.y) * _loc_12;
                                _loc_5 = _loc_6;
                                _loc_6 = _loc_7;
                                _loc_4 = _loc_4.next;
                                _loc_13 = _loc_4;
                                _loc_11 = _loc_11 + _loc_6.x * (_loc_13.y - _loc_5.y);
                                _loc_12 = _loc_13.y * _loc_6.x - _loc_13.x * _loc_6.y;
                                _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_13.x) * _loc_12;
                                _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_13.y) * _loc_12;
                                _loc_11 = 1 / (3 * _loc_11);
                                _loc_12 = _loc_11;
                                _loc_2.localCOMx = _loc_2.localCOMx * _loc_12;
                                _loc_2.localCOMy = _loc_2.localCOMy * _loc_12;
                            }
                        }
                        if (param1.wrap_localCOM != null)
                        {
                            param1.wrap_localCOM.zpp_inner.x = param1.localCOMx;
                            param1.wrap_localCOM.zpp_inner.y = param1.localCOMy;
                        }
                    }
                    _loc_3 = param1.body;
                    if (_loc_3.zip_axis)
                    {
                        _loc_3.zip_axis = false;
                        _loc_3.axisx = Math.sin(_loc_3.rot);
                        _loc_3.axisy = Math.cos(_loc_3.rot);
                    }
                    param1.worldCOMx = param1.body.posx + (param1.body.axisy * param1.localCOMx - param1.body.axisx * param1.localCOMy);
                    param1.worldCOMy = param1.body.posy + (param1.localCOMx * param1.body.axisx + param1.localCOMy * param1.body.axisy);
                }
            }
            return;
        }// end function

        public function updateCircShape(param1:Number, param2:Number, param3:Number) : void
        {
            var _loc_4:* = null as Body;
            var _loc_5:* = null as ShapeList;
            var _loc_6:* = null as Shape;
            var _loc_7:* = false;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = false;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as Shape;
            var _loc_12:* = null as ZPP_Circle;
            var _loc_13:* = NaN;
            var _loc_14:* = null as Mat23;
            var _loc_15:* = NaN;
            var _loc_16:* = null as Mat23;
            var _loc_17:* = null as ZPP_Mat23;
            var _loc_19:* = null as ZPP_Polygon;
            var _loc_20:* = null as ZPP_Vec2;
            var _loc_21:* = null as ZPP_Vec2;
            var _loc_22:* = null as ZPP_Vec2;
            var _loc_23:* = null as ZPP_Vec2;
            var _loc_24:* = null as ZPP_Body;
            if (circShape == null)
            {
                if (ZPP_Flags.BodyType_STATIC == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.BodyType_STATIC = new BodyType();
                    ZPP_Flags.internal = false;
                }
                _loc_4 = new Body(ZPP_Flags.BodyType_STATIC);
                _loc_5 = _loc_4.zpp_inner.wrap_shapes;
                _loc_7 = false;
                if (param1 == param1)
                {
                }
                if (param2 != param2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_8 = new Vec2();
                }
                else
                {
                    _loc_8 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_8.zpp_pool;
                    _loc_8.zpp_pool = null;
                    _loc_8.zpp_disp = false;
                    if (_loc_8 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_8.zpp_inner == null)
                {
                    _loc_9 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_10 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_10 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_10.next;
                        _loc_10.next = null;
                    }
                    _loc_10.weak = false;
                    _loc_10._immutable = _loc_9;
                    _loc_10.x = param1;
                    _loc_10.y = param2;
                    _loc_8.zpp_inner = _loc_10;
                    _loc_8.zpp_inner.outer = _loc_8;
                }
                else
                {
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_8.zpp_inner;
                    if (_loc_10._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_10._isimmutable != null)
                    {
                        _loc_10._isimmutable();
                    }
                    if (param1 == param1)
                    {
                    }
                    if (param2 != param2)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_8.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    if (_loc_8.zpp_inner.x == param1)
                    {
                        if (_loc_8 != null)
                        {
                        }
                        if (_loc_8.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_10 = _loc_8.zpp_inner;
                        if (_loc_10._validate != null)
                        {
                            _loc_10._validate();
                        }
                    }
                    if (_loc_8.zpp_inner.y != param2)
                    {
                        _loc_8.zpp_inner.x = param1;
                        _loc_8.zpp_inner.y = param2;
                        _loc_10 = _loc_8.zpp_inner;
                        if (_loc_10._invalidate != null)
                        {
                            _loc_10._invalidate(_loc_10);
                        }
                    }
                }
                _loc_8.zpp_inner.weak = _loc_7;
                _loc_11 = new Circle(param3, _loc_8);
                circShape = _loc_11;
                _loc_6 = _loc_11;
                if (_loc_5.zpp_inner.reverse_flag)
                {
                    _loc_5.push(_loc_6);
                }
                else
                {
                    _loc_5.unshift(_loc_6);
                }
            }
            else
            {
                _loc_12 = circShape.zpp_inner.circle;
                _loc_13 = param3 / _loc_12.radius;
                if (matrix == null)
                {
                    matrix = new Mat23();
                }
                _loc_14 = matrix;
                _loc_16 = matrix;
                if (_loc_13 != _loc_13)
                {
                    throw "Error: Mat23::" + "d" + " cannot be NaN";
                }
                _loc_16.zpp_inner.d = _loc_13;
                _loc_17 = _loc_16.zpp_inner;
                if (_loc_17._invalidate != null)
                {
                    _loc_17._invalidate();
                }
                _loc_15 = _loc_16.zpp_inner.d;
                if (_loc_15 != _loc_15)
                {
                    throw "Error: Mat23::" + "a" + " cannot be NaN";
                }
                _loc_14.zpp_inner.a = _loc_15;
                _loc_17 = _loc_14.zpp_inner;
                if (_loc_17._invalidate != null)
                {
                    _loc_17._invalidate();
                }
                _loc_14 = matrix;
                _loc_16 = matrix;
                _loc_16.zpp_inner.c = 0;
                _loc_17 = _loc_16.zpp_inner;
                if (_loc_17._invalidate != null)
                {
                    _loc_17._invalidate();
                }
                _loc_15 = _loc_16.zpp_inner.c;
                if (_loc_15 != _loc_15)
                {
                    throw "Error: Mat23::" + "b" + " cannot be NaN";
                }
                _loc_14.zpp_inner.b = _loc_15;
                _loc_17 = _loc_14.zpp_inner;
                if (_loc_17._invalidate != null)
                {
                    _loc_17._invalidate();
                }
                _loc_14 = matrix;
                _loc_15 = param1 - _loc_13 * _loc_12.localCOMx;
                if (_loc_15 != _loc_15)
                {
                    throw "Error: Mat23::" + "tx" + " cannot be NaN";
                }
                _loc_14.zpp_inner.tx = _loc_15;
                _loc_17 = _loc_14.zpp_inner;
                if (_loc_17._invalidate != null)
                {
                    _loc_17._invalidate();
                }
                _loc_14 = matrix;
                _loc_15 = param2 - _loc_13 * _loc_12.localCOMy;
                if (_loc_15 != _loc_15)
                {
                    throw "Error: Mat23::" + "ty" + " cannot be NaN";
                }
                _loc_14.zpp_inner.ty = _loc_15;
                _loc_17 = _loc_14.zpp_inner;
                if (_loc_17._invalidate != null)
                {
                    _loc_17._invalidate();
                }
                circShape.transform(matrix);
            }
            var _loc_18:* = circShape.zpp_inner;
            if (_loc_18.zip_aabb)
            {
                if (_loc_18.body != null)
                {
                    _loc_18.zip_aabb = false;
                    if (_loc_18.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_12 = _loc_18.circle;
                        if (_loc_12.zip_worldCOM)
                        {
                            if (_loc_12.body != null)
                            {
                                _loc_12.zip_worldCOM = false;
                                if (_loc_12.zip_localCOM)
                                {
                                    _loc_12.zip_localCOM = false;
                                    if (_loc_12.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                        _loc_19 = _loc_12.polygon;
                                        if (_loc_19.lverts.next == null)
                                        {
                                            throw "Error: An empty polygon has no meaningful localCOM";
                                        }
                                        if (_loc_19.lverts.next.next == null)
                                        {
                                            _loc_19.localCOMx = _loc_19.lverts.next.x;
                                            _loc_19.localCOMy = _loc_19.lverts.next.y;
                                        }
                                        else if (_loc_19.lverts.next.next.next == null)
                                        {
                                            _loc_19.localCOMx = _loc_19.lverts.next.x;
                                            _loc_19.localCOMy = _loc_19.lverts.next.y;
                                            _loc_13 = 1;
                                            _loc_19.localCOMx = _loc_19.localCOMx + _loc_19.lverts.next.next.x * _loc_13;
                                            _loc_19.localCOMy = _loc_19.localCOMy + _loc_19.lverts.next.next.y * _loc_13;
                                            _loc_13 = 0.5;
                                            _loc_19.localCOMx = _loc_19.localCOMx * _loc_13;
                                            _loc_19.localCOMy = _loc_19.localCOMy * _loc_13;
                                        }
                                        else
                                        {
                                            _loc_19.localCOMx = 0;
                                            _loc_19.localCOMy = 0;
                                            _loc_13 = 0;
                                            _loc_10 = _loc_19.lverts.next;
                                            _loc_20 = _loc_10;
                                            _loc_10 = _loc_10.next;
                                            _loc_21 = _loc_10;
                                            _loc_10 = _loc_10.next;
                                            while (_loc_10 != null)
                                            {
                                                
                                                _loc_22 = _loc_10;
                                                _loc_13 = _loc_13 + _loc_21.x * (_loc_22.y - _loc_20.y);
                                                _loc_15 = _loc_22.y * _loc_21.x - _loc_22.x * _loc_21.y;
                                                _loc_19.localCOMx = _loc_19.localCOMx + (_loc_21.x + _loc_22.x) * _loc_15;
                                                _loc_19.localCOMy = _loc_19.localCOMy + (_loc_21.y + _loc_22.y) * _loc_15;
                                                _loc_20 = _loc_21;
                                                _loc_21 = _loc_22;
                                                _loc_10 = _loc_10.next;
                                            }
                                            _loc_10 = _loc_19.lverts.next;
                                            _loc_22 = _loc_10;
                                            _loc_13 = _loc_13 + _loc_21.x * (_loc_22.y - _loc_20.y);
                                            _loc_15 = _loc_22.y * _loc_21.x - _loc_22.x * _loc_21.y;
                                            _loc_19.localCOMx = _loc_19.localCOMx + (_loc_21.x + _loc_22.x) * _loc_15;
                                            _loc_19.localCOMy = _loc_19.localCOMy + (_loc_21.y + _loc_22.y) * _loc_15;
                                            _loc_20 = _loc_21;
                                            _loc_21 = _loc_22;
                                            _loc_10 = _loc_10.next;
                                            _loc_23 = _loc_10;
                                            _loc_13 = _loc_13 + _loc_21.x * (_loc_23.y - _loc_20.y);
                                            _loc_15 = _loc_23.y * _loc_21.x - _loc_23.x * _loc_21.y;
                                            _loc_19.localCOMx = _loc_19.localCOMx + (_loc_21.x + _loc_23.x) * _loc_15;
                                            _loc_19.localCOMy = _loc_19.localCOMy + (_loc_21.y + _loc_23.y) * _loc_15;
                                            _loc_13 = 1 / (3 * _loc_13);
                                            _loc_15 = _loc_13;
                                            _loc_19.localCOMx = _loc_19.localCOMx * _loc_15;
                                            _loc_19.localCOMy = _loc_19.localCOMy * _loc_15;
                                        }
                                    }
                                    if (_loc_12.wrap_localCOM != null)
                                    {
                                        _loc_12.wrap_localCOM.zpp_inner.x = _loc_12.localCOMx;
                                        _loc_12.wrap_localCOM.zpp_inner.y = _loc_12.localCOMy;
                                    }
                                }
                                _loc_24 = _loc_12.body;
                                if (_loc_24.zip_axis)
                                {
                                    _loc_24.zip_axis = false;
                                    _loc_24.axisx = Math.sin(_loc_24.rot);
                                    _loc_24.axisy = Math.cos(_loc_24.rot);
                                }
                                _loc_12.worldCOMx = _loc_12.body.posx + (_loc_12.body.axisy * _loc_12.localCOMx - _loc_12.body.axisx * _loc_12.localCOMy);
                                _loc_12.worldCOMy = _loc_12.body.posy + (_loc_12.localCOMx * _loc_12.body.axisx + _loc_12.localCOMy * _loc_12.body.axisy);
                            }
                        }
                        _loc_13 = _loc_12.radius;
                        _loc_15 = _loc_12.radius;
                        _loc_12.aabb.minx = _loc_12.worldCOMx - _loc_13;
                        _loc_12.aabb.miny = _loc_12.worldCOMy - _loc_15;
                        _loc_12.aabb.maxx = _loc_12.worldCOMx + _loc_13;
                        _loc_12.aabb.maxy = _loc_12.worldCOMy + _loc_15;
                    }
                    else
                    {
                        _loc_19 = _loc_18.polygon;
                        if (_loc_19.zip_gverts)
                        {
                            if (_loc_19.body != null)
                            {
                                _loc_19.zip_gverts = false;
                                _loc_19.validate_lverts();
                                _loc_24 = _loc_19.body;
                                if (_loc_24.zip_axis)
                                {
                                    _loc_24.zip_axis = false;
                                    _loc_24.axisx = Math.sin(_loc_24.rot);
                                    _loc_24.axisy = Math.cos(_loc_24.rot);
                                }
                                _loc_10 = _loc_19.lverts.next;
                                _loc_20 = _loc_19.gverts.next;
                                while (_loc_20 != null)
                                {
                                    
                                    _loc_21 = _loc_20;
                                    _loc_22 = _loc_10;
                                    _loc_10 = _loc_10.next;
                                    _loc_21.x = _loc_19.body.posx + (_loc_19.body.axisy * _loc_22.x - _loc_19.body.axisx * _loc_22.y);
                                    _loc_21.y = _loc_19.body.posy + (_loc_22.x * _loc_19.body.axisx + _loc_22.y * _loc_19.body.axisy);
                                    _loc_20 = _loc_20.next;
                                }
                            }
                        }
                        if (_loc_19.lverts.next == null)
                        {
                            throw "Error: An empty polygon has no meaningful bounds";
                        }
                        _loc_10 = _loc_19.gverts.next;
                        _loc_19.aabb.minx = _loc_10.x;
                        _loc_19.aabb.miny = _loc_10.y;
                        _loc_19.aabb.maxx = _loc_10.x;
                        _loc_19.aabb.maxy = _loc_10.y;
                        _loc_20 = _loc_19.gverts.next.next;
                        while (_loc_20 != null)
                        {
                            
                            _loc_21 = _loc_20;
                            if (_loc_21.x < _loc_19.aabb.minx)
                            {
                                _loc_19.aabb.minx = _loc_21.x;
                            }
                            if (_loc_21.x > _loc_19.aabb.maxx)
                            {
                                _loc_19.aabb.maxx = _loc_21.x;
                            }
                            if (_loc_21.y < _loc_19.aabb.miny)
                            {
                                _loc_19.aabb.miny = _loc_21.y;
                            }
                            if (_loc_21.y > _loc_19.aabb.maxy)
                            {
                                _loc_19.aabb.maxy = _loc_21.y;
                            }
                            _loc_20 = _loc_20.next;
                        }
                    }
                }
            }
            return;
        }// end function

        public function updateAABBShape(param1:ZPP_AABB) : void
        {
            var _loc_2:* = null as Body;
            var _loc_3:* = null as ShapeList;
            var _loc_4:* = null as Shape;
            var _loc_5:* = null as Shape;
            var _loc_6:* = null as ZPP_AABB;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = null as Mat23;
            var _loc_10:* = null as ZPP_Mat23;
            var _loc_11:* = NaN;
            var _loc_12:* = null as Mat23;
            var _loc_14:* = null as ZPP_Circle;
            var _loc_15:* = null as ZPP_Polygon;
            var _loc_16:* = null as ZPP_Vec2;
            var _loc_17:* = null as ZPP_Vec2;
            var _loc_18:* = null as ZPP_Vec2;
            var _loc_19:* = null as ZPP_Vec2;
            var _loc_20:* = null as ZPP_Vec2;
            var _loc_21:* = null as ZPP_Body;
            var _loc_22:* = null as ZNPNode_ZPP_Edge;
            var _loc_23:* = null as ZPP_Edge;
            if (aabbShape == null)
            {
                if (ZPP_Flags.BodyType_STATIC == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.BodyType_STATIC = new BodyType();
                    ZPP_Flags.internal = false;
                }
                _loc_2 = new Body(ZPP_Flags.BodyType_STATIC);
                _loc_3 = _loc_2.zpp_inner.wrap_shapes;
                _loc_5 = new Polygon(Polygon.rect(param1.minx, param1.miny, param1.maxx - param1.minx, param1.maxy - param1.miny));
                aabbShape = _loc_5;
                _loc_4 = _loc_5;
                if (_loc_3.zpp_inner.reverse_flag)
                {
                    _loc_3.push(_loc_4);
                }
                else
                {
                    _loc_3.unshift(_loc_4);
                }
            }
            else
            {
                _loc_6 = aabbShape.zpp_inner.aabb;
                _loc_7 = (param1.maxx - param1.minx) / (_loc_6.maxx - _loc_6.minx);
                _loc_8 = (param1.maxy - param1.miny) / (_loc_6.maxy - _loc_6.miny);
                if (matrix == null)
                {
                    matrix = new Mat23();
                }
                _loc_9 = matrix;
                if (_loc_7 != _loc_7)
                {
                    throw "Error: Mat23::" + "a" + " cannot be NaN";
                }
                _loc_9.zpp_inner.a = _loc_7;
                _loc_10 = _loc_9.zpp_inner;
                if (_loc_10._invalidate != null)
                {
                    _loc_10._invalidate();
                }
                _loc_9 = matrix;
                _loc_12 = matrix;
                _loc_12.zpp_inner.c = 0;
                _loc_10 = _loc_12.zpp_inner;
                if (_loc_10._invalidate != null)
                {
                    _loc_10._invalidate();
                }
                _loc_11 = _loc_12.zpp_inner.c;
                if (_loc_11 != _loc_11)
                {
                    throw "Error: Mat23::" + "b" + " cannot be NaN";
                }
                _loc_9.zpp_inner.b = _loc_11;
                _loc_10 = _loc_9.zpp_inner;
                if (_loc_10._invalidate != null)
                {
                    _loc_10._invalidate();
                }
                _loc_9 = matrix;
                if (_loc_8 != _loc_8)
                {
                    throw "Error: Mat23::" + "d" + " cannot be NaN";
                }
                _loc_9.zpp_inner.d = _loc_8;
                _loc_10 = _loc_9.zpp_inner;
                if (_loc_10._invalidate != null)
                {
                    _loc_10._invalidate();
                }
                _loc_9 = matrix;
                _loc_11 = param1.minx - _loc_7 * _loc_6.minx;
                if (_loc_11 != _loc_11)
                {
                    throw "Error: Mat23::" + "tx" + " cannot be NaN";
                }
                _loc_9.zpp_inner.tx = _loc_11;
                _loc_10 = _loc_9.zpp_inner;
                if (_loc_10._invalidate != null)
                {
                    _loc_10._invalidate();
                }
                _loc_9 = matrix;
                _loc_11 = param1.miny - _loc_8 * _loc_6.miny;
                if (_loc_11 != _loc_11)
                {
                    throw "Error: Mat23::" + "ty" + " cannot be NaN";
                }
                _loc_9.zpp_inner.ty = _loc_11;
                _loc_10 = _loc_9.zpp_inner;
                if (_loc_10._invalidate != null)
                {
                    _loc_10._invalidate();
                }
                aabbShape.transform(matrix);
            }
            var _loc_13:* = aabbShape.zpp_inner;
            if (_loc_13.zip_aabb)
            {
                if (_loc_13.body != null)
                {
                    _loc_13.zip_aabb = false;
                    if (_loc_13.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_14 = _loc_13.circle;
                        if (_loc_14.zip_worldCOM)
                        {
                            if (_loc_14.body != null)
                            {
                                _loc_14.zip_worldCOM = false;
                                if (_loc_14.zip_localCOM)
                                {
                                    _loc_14.zip_localCOM = false;
                                    if (_loc_14.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                        _loc_15 = _loc_14.polygon;
                                        if (_loc_15.lverts.next == null)
                                        {
                                            throw "Error: An empty polygon has no meaningful localCOM";
                                        }
                                        if (_loc_15.lverts.next.next == null)
                                        {
                                            _loc_15.localCOMx = _loc_15.lverts.next.x;
                                            _loc_15.localCOMy = _loc_15.lverts.next.y;
                                        }
                                        else if (_loc_15.lverts.next.next.next == null)
                                        {
                                            _loc_15.localCOMx = _loc_15.lverts.next.x;
                                            _loc_15.localCOMy = _loc_15.lverts.next.y;
                                            _loc_7 = 1;
                                            _loc_15.localCOMx = _loc_15.localCOMx + _loc_15.lverts.next.next.x * _loc_7;
                                            _loc_15.localCOMy = _loc_15.localCOMy + _loc_15.lverts.next.next.y * _loc_7;
                                            _loc_7 = 0.5;
                                            _loc_15.localCOMx = _loc_15.localCOMx * _loc_7;
                                            _loc_15.localCOMy = _loc_15.localCOMy * _loc_7;
                                        }
                                        else
                                        {
                                            _loc_15.localCOMx = 0;
                                            _loc_15.localCOMy = 0;
                                            _loc_7 = 0;
                                            _loc_16 = _loc_15.lverts.next;
                                            _loc_17 = _loc_16;
                                            _loc_16 = _loc_16.next;
                                            _loc_18 = _loc_16;
                                            _loc_16 = _loc_16.next;
                                            while (_loc_16 != null)
                                            {
                                                
                                                _loc_19 = _loc_16;
                                                _loc_7 = _loc_7 + _loc_18.x * (_loc_19.y - _loc_17.y);
                                                _loc_8 = _loc_19.y * _loc_18.x - _loc_19.x * _loc_18.y;
                                                _loc_15.localCOMx = _loc_15.localCOMx + (_loc_18.x + _loc_19.x) * _loc_8;
                                                _loc_15.localCOMy = _loc_15.localCOMy + (_loc_18.y + _loc_19.y) * _loc_8;
                                                _loc_17 = _loc_18;
                                                _loc_18 = _loc_19;
                                                _loc_16 = _loc_16.next;
                                            }
                                            _loc_16 = _loc_15.lverts.next;
                                            _loc_19 = _loc_16;
                                            _loc_7 = _loc_7 + _loc_18.x * (_loc_19.y - _loc_17.y);
                                            _loc_8 = _loc_19.y * _loc_18.x - _loc_19.x * _loc_18.y;
                                            _loc_15.localCOMx = _loc_15.localCOMx + (_loc_18.x + _loc_19.x) * _loc_8;
                                            _loc_15.localCOMy = _loc_15.localCOMy + (_loc_18.y + _loc_19.y) * _loc_8;
                                            _loc_17 = _loc_18;
                                            _loc_18 = _loc_19;
                                            _loc_16 = _loc_16.next;
                                            _loc_20 = _loc_16;
                                            _loc_7 = _loc_7 + _loc_18.x * (_loc_20.y - _loc_17.y);
                                            _loc_8 = _loc_20.y * _loc_18.x - _loc_20.x * _loc_18.y;
                                            _loc_15.localCOMx = _loc_15.localCOMx + (_loc_18.x + _loc_20.x) * _loc_8;
                                            _loc_15.localCOMy = _loc_15.localCOMy + (_loc_18.y + _loc_20.y) * _loc_8;
                                            _loc_7 = 1 / (3 * _loc_7);
                                            _loc_8 = _loc_7;
                                            _loc_15.localCOMx = _loc_15.localCOMx * _loc_8;
                                            _loc_15.localCOMy = _loc_15.localCOMy * _loc_8;
                                        }
                                    }
                                    if (_loc_14.wrap_localCOM != null)
                                    {
                                        _loc_14.wrap_localCOM.zpp_inner.x = _loc_14.localCOMx;
                                        _loc_14.wrap_localCOM.zpp_inner.y = _loc_14.localCOMy;
                                    }
                                }
                                _loc_21 = _loc_14.body;
                                if (_loc_21.zip_axis)
                                {
                                    _loc_21.zip_axis = false;
                                    _loc_21.axisx = Math.sin(_loc_21.rot);
                                    _loc_21.axisy = Math.cos(_loc_21.rot);
                                }
                                _loc_14.worldCOMx = _loc_14.body.posx + (_loc_14.body.axisy * _loc_14.localCOMx - _loc_14.body.axisx * _loc_14.localCOMy);
                                _loc_14.worldCOMy = _loc_14.body.posy + (_loc_14.localCOMx * _loc_14.body.axisx + _loc_14.localCOMy * _loc_14.body.axisy);
                            }
                        }
                        _loc_7 = _loc_14.radius;
                        _loc_8 = _loc_14.radius;
                        _loc_14.aabb.minx = _loc_14.worldCOMx - _loc_7;
                        _loc_14.aabb.miny = _loc_14.worldCOMy - _loc_8;
                        _loc_14.aabb.maxx = _loc_14.worldCOMx + _loc_7;
                        _loc_14.aabb.maxy = _loc_14.worldCOMy + _loc_8;
                    }
                    else
                    {
                        _loc_15 = _loc_13.polygon;
                        if (_loc_15.zip_gverts)
                        {
                            if (_loc_15.body != null)
                            {
                                _loc_15.zip_gverts = false;
                                _loc_15.validate_lverts();
                                _loc_21 = _loc_15.body;
                                if (_loc_21.zip_axis)
                                {
                                    _loc_21.zip_axis = false;
                                    _loc_21.axisx = Math.sin(_loc_21.rot);
                                    _loc_21.axisy = Math.cos(_loc_21.rot);
                                }
                                _loc_16 = _loc_15.lverts.next;
                                _loc_17 = _loc_15.gverts.next;
                                while (_loc_17 != null)
                                {
                                    
                                    _loc_18 = _loc_17;
                                    _loc_19 = _loc_16;
                                    _loc_16 = _loc_16.next;
                                    _loc_18.x = _loc_15.body.posx + (_loc_15.body.axisy * _loc_19.x - _loc_15.body.axisx * _loc_19.y);
                                    _loc_18.y = _loc_15.body.posy + (_loc_19.x * _loc_15.body.axisx + _loc_19.y * _loc_15.body.axisy);
                                    _loc_17 = _loc_17.next;
                                }
                            }
                        }
                        if (_loc_15.lverts.next == null)
                        {
                            throw "Error: An empty polygon has no meaningful bounds";
                        }
                        _loc_16 = _loc_15.gverts.next;
                        _loc_15.aabb.minx = _loc_16.x;
                        _loc_15.aabb.miny = _loc_16.y;
                        _loc_15.aabb.maxx = _loc_16.x;
                        _loc_15.aabb.maxy = _loc_16.y;
                        _loc_17 = _loc_15.gverts.next.next;
                        while (_loc_17 != null)
                        {
                            
                            _loc_18 = _loc_17;
                            if (_loc_18.x < _loc_15.aabb.minx)
                            {
                                _loc_15.aabb.minx = _loc_18.x;
                            }
                            if (_loc_18.x > _loc_15.aabb.maxx)
                            {
                                _loc_15.aabb.maxx = _loc_18.x;
                            }
                            if (_loc_18.y < _loc_15.aabb.miny)
                            {
                                _loc_15.aabb.miny = _loc_18.y;
                            }
                            if (_loc_18.y > _loc_15.aabb.maxy)
                            {
                                _loc_15.aabb.maxy = _loc_18.y;
                            }
                            _loc_17 = _loc_17.next;
                        }
                    }
                }
            }
            _loc_15 = aabbShape.zpp_inner.polygon;
            if (_loc_15.zip_gaxi)
            {
                if (_loc_15.body != null)
                {
                    _loc_15.zip_gaxi = false;
                    _loc_15.validate_laxi();
                    _loc_21 = _loc_15.body;
                    if (_loc_21.zip_axis)
                    {
                        _loc_21.zip_axis = false;
                        _loc_21.axisx = Math.sin(_loc_21.rot);
                        _loc_21.axisy = Math.cos(_loc_21.rot);
                    }
                    if (_loc_15.zip_gverts)
                    {
                        if (_loc_15.body != null)
                        {
                            _loc_15.zip_gverts = false;
                            _loc_15.validate_lverts();
                            _loc_21 = _loc_15.body;
                            if (_loc_21.zip_axis)
                            {
                                _loc_21.zip_axis = false;
                                _loc_21.axisx = Math.sin(_loc_21.rot);
                                _loc_21.axisy = Math.cos(_loc_21.rot);
                            }
                            _loc_16 = _loc_15.lverts.next;
                            _loc_17 = _loc_15.gverts.next;
                            while (_loc_17 != null)
                            {
                                
                                _loc_18 = _loc_17;
                                _loc_19 = _loc_16;
                                _loc_16 = _loc_16.next;
                                _loc_18.x = _loc_15.body.posx + (_loc_15.body.axisy * _loc_19.x - _loc_15.body.axisx * _loc_19.y);
                                _loc_18.y = _loc_15.body.posy + (_loc_19.x * _loc_15.body.axisx + _loc_19.y * _loc_15.body.axisy);
                                _loc_17 = _loc_17.next;
                            }
                        }
                    }
                    _loc_22 = _loc_15.edges.head;
                    _loc_16 = _loc_15.gverts.next;
                    _loc_17 = _loc_16;
                    _loc_16 = _loc_16.next;
                    while (_loc_16 != null)
                    {
                        
                        _loc_18 = _loc_16;
                        _loc_23 = _loc_22.elt;
                        _loc_22 = _loc_22.next;
                        _loc_23.gp0 = _loc_17;
                        _loc_23.gp1 = _loc_18;
                        _loc_23.gnormx = _loc_15.body.axisy * _loc_23.lnormx - _loc_15.body.axisx * _loc_23.lnormy;
                        _loc_23.gnormy = _loc_23.lnormx * _loc_15.body.axisx + _loc_23.lnormy * _loc_15.body.axisy;
                        _loc_23.gprojection = _loc_15.body.posx * _loc_23.gnormx + _loc_15.body.posy * _loc_23.gnormy + _loc_23.lprojection;
                        if (_loc_23.wrap_gnorm != null)
                        {
                            _loc_23.wrap_gnorm.zpp_inner.x = _loc_23.gnormx;
                            _loc_23.wrap_gnorm.zpp_inner.y = _loc_23.gnormy;
                        }
                        _loc_23.tp0 = _loc_23.gp0.y * _loc_23.gnormx - _loc_23.gp0.x * _loc_23.gnormy;
                        _loc_23.tp1 = _loc_23.gp1.y * _loc_23.gnormx - _loc_23.gp1.x * _loc_23.gnormy;
                        _loc_17 = _loc_18;
                        _loc_16 = _loc_16.next;
                    }
                    _loc_18 = _loc_15.gverts.next;
                    _loc_23 = _loc_22.elt;
                    _loc_22 = _loc_22.next;
                    _loc_23.gp0 = _loc_17;
                    _loc_23.gp1 = _loc_18;
                    _loc_23.gnormx = _loc_15.body.axisy * _loc_23.lnormx - _loc_15.body.axisx * _loc_23.lnormy;
                    _loc_23.gnormy = _loc_23.lnormx * _loc_15.body.axisx + _loc_23.lnormy * _loc_15.body.axisy;
                    _loc_23.gprojection = _loc_15.body.posx * _loc_23.gnormx + _loc_15.body.posy * _loc_23.gnormy + _loc_23.lprojection;
                    if (_loc_23.wrap_gnorm != null)
                    {
                        _loc_23.wrap_gnorm.zpp_inner.x = _loc_23.gnormx;
                        _loc_23.wrap_gnorm.zpp_inner.y = _loc_23.gnormy;
                    }
                    _loc_23.tp0 = _loc_23.gp0.y * _loc_23.gnormx - _loc_23.gp0.x * _loc_23.gnormy;
                    _loc_23.tp1 = _loc_23.gp1.y * _loc_23.gnormx - _loc_23.gp1.x * _loc_23.gnormy;
                }
            }
            return;
        }// end function

        public function sync(param1:ZPP_Shape) : void
        {
            var _loc_2:* = null as ZPP_Circle;
            var _loc_3:* = null as ZPP_Polygon;
            var _loc_4:* = NaN;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = NaN;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as ZPP_Body;
            var _loc_12:* = null as ZPP_DynAABBPhase;
            var _loc_13:* = null as ZPP_AABBNode;
            var _loc_14:* = false;
            var _loc_15:* = null as ZPP_AABB;
            var _loc_16:* = null as ZPP_AABB;
            if (is_sweep)
            {
                if (!sweep.space.continuous)
                {
                    if (param1.zip_aabb)
                    {
                        if (param1.body != null)
                        {
                            param1.zip_aabb = false;
                            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_2 = param1.circle;
                                if (_loc_2.zip_worldCOM)
                                {
                                    if (_loc_2.body != null)
                                    {
                                        _loc_2.zip_worldCOM = false;
                                        if (_loc_2.zip_localCOM)
                                        {
                                            _loc_2.zip_localCOM = false;
                                            if (_loc_2.type == ZPP_Flags.id_ShapeType_POLYGON)
                                            {
                                                _loc_3 = _loc_2.polygon;
                                                if (_loc_3.lverts.next == null)
                                                {
                                                    throw "Error: An empty polygon has no meaningful localCOM";
                                                }
                                                if (_loc_3.lverts.next.next == null)
                                                {
                                                    _loc_3.localCOMx = _loc_3.lverts.next.x;
                                                    _loc_3.localCOMy = _loc_3.lverts.next.y;
                                                }
                                                else if (_loc_3.lverts.next.next.next == null)
                                                {
                                                    _loc_3.localCOMx = _loc_3.lverts.next.x;
                                                    _loc_3.localCOMy = _loc_3.lverts.next.y;
                                                    _loc_4 = 1;
                                                    _loc_3.localCOMx = _loc_3.localCOMx + _loc_3.lverts.next.next.x * _loc_4;
                                                    _loc_3.localCOMy = _loc_3.localCOMy + _loc_3.lverts.next.next.y * _loc_4;
                                                    _loc_4 = 0.5;
                                                    _loc_3.localCOMx = _loc_3.localCOMx * _loc_4;
                                                    _loc_3.localCOMy = _loc_3.localCOMy * _loc_4;
                                                }
                                                else
                                                {
                                                    _loc_3.localCOMx = 0;
                                                    _loc_3.localCOMy = 0;
                                                    _loc_4 = 0;
                                                    _loc_5 = _loc_3.lverts.next;
                                                    _loc_6 = _loc_5;
                                                    _loc_5 = _loc_5.next;
                                                    _loc_7 = _loc_5;
                                                    _loc_5 = _loc_5.next;
                                                    while (_loc_5 != null)
                                                    {
                                                        
                                                        _loc_8 = _loc_5;
                                                        _loc_4 = _loc_4 + _loc_7.x * (_loc_8.y - _loc_6.y);
                                                        _loc_9 = _loc_8.y * _loc_7.x - _loc_8.x * _loc_7.y;
                                                        _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_8.x) * _loc_9;
                                                        _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_8.y) * _loc_9;
                                                        _loc_6 = _loc_7;
                                                        _loc_7 = _loc_8;
                                                        _loc_5 = _loc_5.next;
                                                    }
                                                    _loc_5 = _loc_3.lverts.next;
                                                    _loc_8 = _loc_5;
                                                    _loc_4 = _loc_4 + _loc_7.x * (_loc_8.y - _loc_6.y);
                                                    _loc_9 = _loc_8.y * _loc_7.x - _loc_8.x * _loc_7.y;
                                                    _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_8.x) * _loc_9;
                                                    _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_8.y) * _loc_9;
                                                    _loc_6 = _loc_7;
                                                    _loc_7 = _loc_8;
                                                    _loc_5 = _loc_5.next;
                                                    _loc_10 = _loc_5;
                                                    _loc_4 = _loc_4 + _loc_7.x * (_loc_10.y - _loc_6.y);
                                                    _loc_9 = _loc_10.y * _loc_7.x - _loc_10.x * _loc_7.y;
                                                    _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_10.x) * _loc_9;
                                                    _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_10.y) * _loc_9;
                                                    _loc_4 = 1 / (3 * _loc_4);
                                                    _loc_9 = _loc_4;
                                                    _loc_3.localCOMx = _loc_3.localCOMx * _loc_9;
                                                    _loc_3.localCOMy = _loc_3.localCOMy * _loc_9;
                                                }
                                            }
                                            if (_loc_2.wrap_localCOM != null)
                                            {
                                                _loc_2.wrap_localCOM.zpp_inner.x = _loc_2.localCOMx;
                                                _loc_2.wrap_localCOM.zpp_inner.y = _loc_2.localCOMy;
                                            }
                                        }
                                        _loc_11 = _loc_2.body;
                                        if (_loc_11.zip_axis)
                                        {
                                            _loc_11.zip_axis = false;
                                            _loc_11.axisx = Math.sin(_loc_11.rot);
                                            _loc_11.axisy = Math.cos(_loc_11.rot);
                                        }
                                        _loc_2.worldCOMx = _loc_2.body.posx + (_loc_2.body.axisy * _loc_2.localCOMx - _loc_2.body.axisx * _loc_2.localCOMy);
                                        _loc_2.worldCOMy = _loc_2.body.posy + (_loc_2.localCOMx * _loc_2.body.axisx + _loc_2.localCOMy * _loc_2.body.axisy);
                                    }
                                }
                                _loc_4 = _loc_2.radius;
                                _loc_9 = _loc_2.radius;
                                _loc_2.aabb.minx = _loc_2.worldCOMx - _loc_4;
                                _loc_2.aabb.miny = _loc_2.worldCOMy - _loc_9;
                                _loc_2.aabb.maxx = _loc_2.worldCOMx + _loc_4;
                                _loc_2.aabb.maxy = _loc_2.worldCOMy + _loc_9;
                            }
                            else
                            {
                                _loc_3 = param1.polygon;
                                if (_loc_3.zip_gverts)
                                {
                                    if (_loc_3.body != null)
                                    {
                                        _loc_3.zip_gverts = false;
                                        _loc_3.validate_lverts();
                                        _loc_11 = _loc_3.body;
                                        if (_loc_11.zip_axis)
                                        {
                                            _loc_11.zip_axis = false;
                                            _loc_11.axisx = Math.sin(_loc_11.rot);
                                            _loc_11.axisy = Math.cos(_loc_11.rot);
                                        }
                                        _loc_5 = _loc_3.lverts.next;
                                        _loc_6 = _loc_3.gverts.next;
                                        while (_loc_6 != null)
                                        {
                                            
                                            _loc_7 = _loc_6;
                                            _loc_8 = _loc_5;
                                            _loc_5 = _loc_5.next;
                                            _loc_7.x = _loc_3.body.posx + (_loc_3.body.axisy * _loc_8.x - _loc_3.body.axisx * _loc_8.y);
                                            _loc_7.y = _loc_3.body.posy + (_loc_8.x * _loc_3.body.axisx + _loc_8.y * _loc_3.body.axisy);
                                            _loc_6 = _loc_6.next;
                                        }
                                    }
                                }
                                if (_loc_3.lverts.next == null)
                                {
                                    throw "Error: An empty polygon has no meaningful bounds";
                                }
                                _loc_5 = _loc_3.gverts.next;
                                _loc_3.aabb.minx = _loc_5.x;
                                _loc_3.aabb.miny = _loc_5.y;
                                _loc_3.aabb.maxx = _loc_5.x;
                                _loc_3.aabb.maxy = _loc_5.y;
                                _loc_6 = _loc_3.gverts.next.next;
                                while (_loc_6 != null)
                                {
                                    
                                    _loc_7 = _loc_6;
                                    if (_loc_7.x < _loc_3.aabb.minx)
                                    {
                                        _loc_3.aabb.minx = _loc_7.x;
                                    }
                                    if (_loc_7.x > _loc_3.aabb.maxx)
                                    {
                                        _loc_3.aabb.maxx = _loc_7.x;
                                    }
                                    if (_loc_7.y < _loc_3.aabb.miny)
                                    {
                                        _loc_3.aabb.miny = _loc_7.y;
                                    }
                                    if (_loc_7.y > _loc_3.aabb.maxy)
                                    {
                                        _loc_3.aabb.maxy = _loc_7.y;
                                    }
                                    _loc_6 = _loc_6.next;
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                _loc_12 = dynab;
                _loc_13 = param1.node;
                if (!_loc_13.synced)
                {
                    if (!_loc_12.space.continuous)
                    {
                        if (param1.zip_aabb)
                        {
                            if (param1.body != null)
                            {
                                param1.zip_aabb = false;
                                if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                {
                                    _loc_2 = param1.circle;
                                    if (_loc_2.zip_worldCOM)
                                    {
                                        if (_loc_2.body != null)
                                        {
                                            _loc_2.zip_worldCOM = false;
                                            if (_loc_2.zip_localCOM)
                                            {
                                                _loc_2.zip_localCOM = false;
                                                if (_loc_2.type == ZPP_Flags.id_ShapeType_POLYGON)
                                                {
                                                    _loc_3 = _loc_2.polygon;
                                                    if (_loc_3.lverts.next == null)
                                                    {
                                                        throw "Error: An empty polygon has no meaningful localCOM";
                                                    }
                                                    if (_loc_3.lverts.next.next == null)
                                                    {
                                                        _loc_3.localCOMx = _loc_3.lverts.next.x;
                                                        _loc_3.localCOMy = _loc_3.lverts.next.y;
                                                    }
                                                    else if (_loc_3.lverts.next.next.next == null)
                                                    {
                                                        _loc_3.localCOMx = _loc_3.lverts.next.x;
                                                        _loc_3.localCOMy = _loc_3.lverts.next.y;
                                                        _loc_4 = 1;
                                                        _loc_3.localCOMx = _loc_3.localCOMx + _loc_3.lverts.next.next.x * _loc_4;
                                                        _loc_3.localCOMy = _loc_3.localCOMy + _loc_3.lverts.next.next.y * _loc_4;
                                                        _loc_4 = 0.5;
                                                        _loc_3.localCOMx = _loc_3.localCOMx * _loc_4;
                                                        _loc_3.localCOMy = _loc_3.localCOMy * _loc_4;
                                                    }
                                                    else
                                                    {
                                                        _loc_3.localCOMx = 0;
                                                        _loc_3.localCOMy = 0;
                                                        _loc_4 = 0;
                                                        _loc_5 = _loc_3.lverts.next;
                                                        _loc_6 = _loc_5;
                                                        _loc_5 = _loc_5.next;
                                                        _loc_7 = _loc_5;
                                                        _loc_5 = _loc_5.next;
                                                        while (_loc_5 != null)
                                                        {
                                                            
                                                            _loc_8 = _loc_5;
                                                            _loc_4 = _loc_4 + _loc_7.x * (_loc_8.y - _loc_6.y);
                                                            _loc_9 = _loc_8.y * _loc_7.x - _loc_8.x * _loc_7.y;
                                                            _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_8.x) * _loc_9;
                                                            _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_8.y) * _loc_9;
                                                            _loc_6 = _loc_7;
                                                            _loc_7 = _loc_8;
                                                            _loc_5 = _loc_5.next;
                                                        }
                                                        _loc_5 = _loc_3.lverts.next;
                                                        _loc_8 = _loc_5;
                                                        _loc_4 = _loc_4 + _loc_7.x * (_loc_8.y - _loc_6.y);
                                                        _loc_9 = _loc_8.y * _loc_7.x - _loc_8.x * _loc_7.y;
                                                        _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_8.x) * _loc_9;
                                                        _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_8.y) * _loc_9;
                                                        _loc_6 = _loc_7;
                                                        _loc_7 = _loc_8;
                                                        _loc_5 = _loc_5.next;
                                                        _loc_10 = _loc_5;
                                                        _loc_4 = _loc_4 + _loc_7.x * (_loc_10.y - _loc_6.y);
                                                        _loc_9 = _loc_10.y * _loc_7.x - _loc_10.x * _loc_7.y;
                                                        _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_10.x) * _loc_9;
                                                        _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_10.y) * _loc_9;
                                                        _loc_4 = 1 / (3 * _loc_4);
                                                        _loc_9 = _loc_4;
                                                        _loc_3.localCOMx = _loc_3.localCOMx * _loc_9;
                                                        _loc_3.localCOMy = _loc_3.localCOMy * _loc_9;
                                                    }
                                                }
                                                if (_loc_2.wrap_localCOM != null)
                                                {
                                                    _loc_2.wrap_localCOM.zpp_inner.x = _loc_2.localCOMx;
                                                    _loc_2.wrap_localCOM.zpp_inner.y = _loc_2.localCOMy;
                                                }
                                            }
                                            _loc_11 = _loc_2.body;
                                            if (_loc_11.zip_axis)
                                            {
                                                _loc_11.zip_axis = false;
                                                _loc_11.axisx = Math.sin(_loc_11.rot);
                                                _loc_11.axisy = Math.cos(_loc_11.rot);
                                            }
                                            _loc_2.worldCOMx = _loc_2.body.posx + (_loc_2.body.axisy * _loc_2.localCOMx - _loc_2.body.axisx * _loc_2.localCOMy);
                                            _loc_2.worldCOMy = _loc_2.body.posy + (_loc_2.localCOMx * _loc_2.body.axisx + _loc_2.localCOMy * _loc_2.body.axisy);
                                        }
                                    }
                                    _loc_4 = _loc_2.radius;
                                    _loc_9 = _loc_2.radius;
                                    _loc_2.aabb.minx = _loc_2.worldCOMx - _loc_4;
                                    _loc_2.aabb.miny = _loc_2.worldCOMy - _loc_9;
                                    _loc_2.aabb.maxx = _loc_2.worldCOMx + _loc_4;
                                    _loc_2.aabb.maxy = _loc_2.worldCOMy + _loc_9;
                                }
                                else
                                {
                                    _loc_3 = param1.polygon;
                                    if (_loc_3.zip_gverts)
                                    {
                                        if (_loc_3.body != null)
                                        {
                                            _loc_3.zip_gverts = false;
                                            _loc_3.validate_lverts();
                                            _loc_11 = _loc_3.body;
                                            if (_loc_11.zip_axis)
                                            {
                                                _loc_11.zip_axis = false;
                                                _loc_11.axisx = Math.sin(_loc_11.rot);
                                                _loc_11.axisy = Math.cos(_loc_11.rot);
                                            }
                                            _loc_5 = _loc_3.lverts.next;
                                            _loc_6 = _loc_3.gverts.next;
                                            while (_loc_6 != null)
                                            {
                                                
                                                _loc_7 = _loc_6;
                                                _loc_8 = _loc_5;
                                                _loc_5 = _loc_5.next;
                                                _loc_7.x = _loc_3.body.posx + (_loc_3.body.axisy * _loc_8.x - _loc_3.body.axisx * _loc_8.y);
                                                _loc_7.y = _loc_3.body.posy + (_loc_8.x * _loc_3.body.axisx + _loc_8.y * _loc_3.body.axisy);
                                                _loc_6 = _loc_6.next;
                                            }
                                        }
                                    }
                                    if (_loc_3.lverts.next == null)
                                    {
                                        throw "Error: An empty polygon has no meaningful bounds";
                                    }
                                    _loc_5 = _loc_3.gverts.next;
                                    _loc_3.aabb.minx = _loc_5.x;
                                    _loc_3.aabb.miny = _loc_5.y;
                                    _loc_3.aabb.maxx = _loc_5.x;
                                    _loc_3.aabb.maxy = _loc_5.y;
                                    _loc_6 = _loc_3.gverts.next.next;
                                    while (_loc_6 != null)
                                    {
                                        
                                        _loc_7 = _loc_6;
                                        if (_loc_7.x < _loc_3.aabb.minx)
                                        {
                                            _loc_3.aabb.minx = _loc_7.x;
                                        }
                                        if (_loc_7.x > _loc_3.aabb.maxx)
                                        {
                                            _loc_3.aabb.maxx = _loc_7.x;
                                        }
                                        if (_loc_7.y < _loc_3.aabb.miny)
                                        {
                                            _loc_3.aabb.miny = _loc_7.y;
                                        }
                                        if (_loc_7.y > _loc_3.aabb.maxy)
                                        {
                                            _loc_3.aabb.maxy = _loc_7.y;
                                        }
                                        _loc_6 = _loc_6.next;
                                    }
                                }
                            }
                        }
                    }
                    if (_loc_13.dyn == (param1.body.type == ZPP_Flags.id_BodyType_STATIC ? (false) : (!param1.body.component.sleeping)))
                    {
                        _loc_15 = _loc_13.aabb;
                        _loc_16 = param1.aabb;
                        if (_loc_16.minx >= _loc_15.minx)
                        {
                        }
                        if (_loc_16.miny >= _loc_15.miny)
                        {
                        }
                        if (_loc_16.maxx <= _loc_15.maxx)
                        {
                        }
                    }
                    _loc_14 = _loc_16.maxy > _loc_15.maxy;
                    if (_loc_14)
                    {
                        _loc_13.synced = true;
                        _loc_13.snext = _loc_12.syncs;
                        _loc_12.syncs = _loc_13;
                    }
                }
            }
            return;
        }// end function

        public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
        {
            return null;
        }// end function

        public function shapesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
        {
            return null;
        }// end function

        public function shapesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:ShapeList) : ShapeList
        {
            return null;
        }// end function

        public function shapesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:ShapeList) : ShapeList
        {
            return null;
        }// end function

        public function remove(param1:ZPP_Shape) : void
        {
            if (is_sweep)
            {
                sweep.__remove(param1);
            }
            else
            {
                dynab.__remove(param1);
            }
            return;
        }// end function

        public function rayMultiCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter, param4:RayResultList) : RayResultList
        {
            return null;
        }// end function

        public function rayCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter) : RayResult
        {
            return null;
        }// end function

        public function insert(param1:ZPP_Shape) : void
        {
            if (is_sweep)
            {
                sweep.__insert(param1);
            }
            else
            {
                dynab.__insert(param1);
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function broadphase(param1:ZPP_Space, param2:Boolean) : void
        {
            return;
        }// end function

        public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
        {
            return null;
        }// end function

        public function bodiesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
        {
            return null;
        }// end function

        public function bodiesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:BodyList) : BodyList
        {
            return null;
        }// end function

        public function bodiesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:BodyList) : BodyList
        {
            return null;
        }// end function

    }
}
