package zpp_nape.shape
{
    import flash.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_Shape extends ZPP_Interactor
    {
        public var zip_worldCOM:Boolean;
        public var zip_sweepRadius:Boolean;
        public var zip_localCOM:Boolean;
        public var zip_area_inertia:Boolean;
        public var zip_angDrag:Boolean;
        public var zip_aabb:Boolean;
        public var wrap_worldCOM:Vec2;
        public var wrap_localCOM:Vec2;
        public var worldCOMy:Number;
        public var worldCOMx:Number;
        public var type:int;
        public var sweepRadius:Number;
        public var sweepCoef:Number;
        public var sweep:ZPP_SweepData;
        public var sensorEnabled:Boolean;
        public var refmaterial:ZPP_Material;
        public var polygon:ZPP_Polygon;
        public var pairs:ZNPList_ZPP_AABBPair;
        public var outer:Shape;
        public var node:ZPP_AABBNode;
        public var material:ZPP_Material;
        public var localCOMy:Number;
        public var localCOMx:Number;
        public var inertia:Number;
        public var fluidProperties:ZPP_FluidProperties;
        public var fluidEnabled:Boolean;
        public var filter:ZPP_InteractionFilter;
        public var circle:ZPP_Circle;
        public var body:ZPP_Body;
        public var area:Number;
        public var angDrag:Number;
        public var aabb:ZPP_AABB;
        public static var init__:Boolean;
        public static var types:Array;

        public function ZPP_Shape(param1:int = 0) : void
        {
            var _loc_2:* = null as ZPP_AABB;
            if (Boot.skip_constructor)
            {
                return;
            }
            zip_aabb = false;
            aabb = null;
            pairs = null;
            node = null;
            sweep = null;
            sensorEnabled = false;
            fluidEnabled = false;
            fluidProperties = null;
            filter = null;
            material = null;
            refmaterial = null;
            polygon = null;
            circle = null;
            sweepCoef = 0;
            zip_sweepRadius = false;
            sweepRadius = 0;
            wrap_worldCOM = null;
            wrap_localCOM = null;
            zip_worldCOM = false;
            worldCOMy = 0;
            worldCOMx = 0;
            zip_localCOM = false;
            localCOMy = 0;
            localCOMx = 0;
            zip_angDrag = false;
            angDrag = 0;
            inertia = 0;
            zip_area_inertia = false;
            area = 0;
            type = 0;
            body = null;
            outer = null;
            pairs = new ZNPList_ZPP_AABBPair();
            ishape = this;
            type = param1;
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_2 = new ZPP_AABB();
            }
            else
            {
                _loc_2 = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            _loc_2.minx = 0;
            _loc_2.miny = 0;
            _loc_2.maxx = 0;
            _loc_2.maxy = 0;
            aabb = _loc_2;
            aabb._immutable = true;
            var _loc_3:* = this;
            aabb._validate = aabb_validate;
            var _loc_4:* = true;
            zip_sweepRadius = true;
            _loc_4 = _loc_4;
            zip_localCOM = _loc_4;
            _loc_4 = _loc_4;
            zip_angDrag = _loc_4;
            zip_area_inertia = _loc_4;
            localCOMx = 0;
            localCOMy = 0;
            worldCOMx = 0;
            worldCOMy = 0;
            fluidEnabled = false;
            sensorEnabled = false;
            fluidProperties = null;
            body = null;
            refmaterial = new ZPP_Material();
            var _loc_5:* = 0;
            sweepCoef = 0;
            sweepRadius = _loc_5;
            return;
        }// end function

        public function validate_worldCOM() : void
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
            return;
        }// end function

        public function validate_sweepRadius() : void
        {
            if (zip_sweepRadius)
            {
                zip_sweepRadius = false;
                if (type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    circle.__validate_sweepRadius();
                }
                else
                {
                    polygon.__validate_sweepRadius();
                }
            }
            return;
        }// end function

        public function validate_localCOM() : void
        {
            var _loc_1:* = null as ZPP_Polygon;
            var _loc_2:* = NaN;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = NaN;
            var _loc_8:* = null as ZPP_Vec2;
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
            return;
        }// end function

        public function validate_area_inertia() : void
        {
            if (zip_area_inertia)
            {
                zip_area_inertia = false;
                if (type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    circle.__validate_area_inertia();
                }
                else
                {
                    polygon.__validate_area_inertia();
                }
            }
            return;
        }// end function

        public function validate_angDrag() : void
        {
            if (!zip_angDrag)
            {
            }
            if (refmaterial.dynamicFriction != material.dynamicFriction)
            {
                zip_angDrag = false;
                refmaterial.dynamicFriction = material.dynamicFriction;
                if (type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    circle.__validate_angDrag();
                }
                else
                {
                    polygon.__validate_angDrag();
                }
            }
            return;
        }// end function

        public function validate_aabb() : void
        {
            var _loc_1:* = null as ZPP_Circle;
            var _loc_2:* = null as ZPP_Polygon;
            var _loc_3:* = NaN;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = NaN;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = null as ZPP_Body;
            if (zip_aabb)
            {
                if (body != null)
                {
                    zip_aabb = false;
                    if (type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_1 = circle;
                        if (_loc_1.zip_worldCOM)
                        {
                            if (_loc_1.body != null)
                            {
                                _loc_1.zip_worldCOM = false;
                                if (_loc_1.zip_localCOM)
                                {
                                    _loc_1.zip_localCOM = false;
                                    if (_loc_1.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                        _loc_2 = _loc_1.polygon;
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
                                            _loc_3 = 1;
                                            _loc_2.localCOMx = _loc_2.localCOMx + _loc_2.lverts.next.next.x * _loc_3;
                                            _loc_2.localCOMy = _loc_2.localCOMy + _loc_2.lverts.next.next.y * _loc_3;
                                            _loc_3 = 0.5;
                                            _loc_2.localCOMx = _loc_2.localCOMx * _loc_3;
                                            _loc_2.localCOMy = _loc_2.localCOMy * _loc_3;
                                        }
                                        else
                                        {
                                            _loc_2.localCOMx = 0;
                                            _loc_2.localCOMy = 0;
                                            _loc_3 = 0;
                                            _loc_4 = _loc_2.lverts.next;
                                            _loc_5 = _loc_4;
                                            _loc_4 = _loc_4.next;
                                            _loc_6 = _loc_4;
                                            _loc_4 = _loc_4.next;
                                            while (_loc_4 != null)
                                            {
                                                
                                                _loc_7 = _loc_4;
                                                _loc_3 = _loc_3 + _loc_6.x * (_loc_7.y - _loc_5.y);
                                                _loc_8 = _loc_7.y * _loc_6.x - _loc_7.x * _loc_6.y;
                                                _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_7.x) * _loc_8;
                                                _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_7.y) * _loc_8;
                                                _loc_5 = _loc_6;
                                                _loc_6 = _loc_7;
                                                _loc_4 = _loc_4.next;
                                            }
                                            _loc_4 = _loc_2.lverts.next;
                                            _loc_7 = _loc_4;
                                            _loc_3 = _loc_3 + _loc_6.x * (_loc_7.y - _loc_5.y);
                                            _loc_8 = _loc_7.y * _loc_6.x - _loc_7.x * _loc_6.y;
                                            _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_7.x) * _loc_8;
                                            _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_7.y) * _loc_8;
                                            _loc_5 = _loc_6;
                                            _loc_6 = _loc_7;
                                            _loc_4 = _loc_4.next;
                                            _loc_9 = _loc_4;
                                            _loc_3 = _loc_3 + _loc_6.x * (_loc_9.y - _loc_5.y);
                                            _loc_8 = _loc_9.y * _loc_6.x - _loc_9.x * _loc_6.y;
                                            _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_9.x) * _loc_8;
                                            _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_9.y) * _loc_8;
                                            _loc_3 = 1 / (3 * _loc_3);
                                            _loc_8 = _loc_3;
                                            _loc_2.localCOMx = _loc_2.localCOMx * _loc_8;
                                            _loc_2.localCOMy = _loc_2.localCOMy * _loc_8;
                                        }
                                    }
                                    if (_loc_1.wrap_localCOM != null)
                                    {
                                        _loc_1.wrap_localCOM.zpp_inner.x = _loc_1.localCOMx;
                                        _loc_1.wrap_localCOM.zpp_inner.y = _loc_1.localCOMy;
                                    }
                                }
                                _loc_10 = _loc_1.body;
                                if (_loc_10.zip_axis)
                                {
                                    _loc_10.zip_axis = false;
                                    _loc_10.axisx = Math.sin(_loc_10.rot);
                                    _loc_10.axisy = Math.cos(_loc_10.rot);
                                }
                                _loc_1.worldCOMx = _loc_1.body.posx + (_loc_1.body.axisy * _loc_1.localCOMx - _loc_1.body.axisx * _loc_1.localCOMy);
                                _loc_1.worldCOMy = _loc_1.body.posy + (_loc_1.localCOMx * _loc_1.body.axisx + _loc_1.localCOMy * _loc_1.body.axisy);
                            }
                        }
                        _loc_3 = _loc_1.radius;
                        _loc_8 = _loc_1.radius;
                        _loc_1.aabb.minx = _loc_1.worldCOMx - _loc_3;
                        _loc_1.aabb.miny = _loc_1.worldCOMy - _loc_8;
                        _loc_1.aabb.maxx = _loc_1.worldCOMx + _loc_3;
                        _loc_1.aabb.maxy = _loc_1.worldCOMy + _loc_8;
                    }
                    else
                    {
                        _loc_2 = polygon;
                        if (_loc_2.zip_gverts)
                        {
                            if (_loc_2.body != null)
                            {
                                _loc_2.zip_gverts = false;
                                _loc_2.validate_lverts();
                                _loc_10 = _loc_2.body;
                                if (_loc_10.zip_axis)
                                {
                                    _loc_10.zip_axis = false;
                                    _loc_10.axisx = Math.sin(_loc_10.rot);
                                    _loc_10.axisy = Math.cos(_loc_10.rot);
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
            return;
        }// end function

        public function setMaterial(param1:ZPP_Material) : void
        {
            if (material != param1)
            {
                if (body != null)
                {
                }
                if (body.space != null)
                {
                    if (material != null)
                    {
                        material.shapes.remove(this);
                    }
                }
                material = param1;
                if (body != null)
                {
                }
                if (body.space != null)
                {
                    param1.shapes.add(this);
                }
                wake();
                if (body != null)
                {
                    body.refreshArbiters();
                }
            }
            return;
        }// end function

        public function setFluid(param1:ZPP_FluidProperties) : void
        {
            if (fluidProperties != param1)
            {
                if (body != null)
                {
                }
                if (body.space != null)
                {
                    if (fluidProperties != null)
                    {
                        fluidProperties.shapes.remove(this);
                    }
                }
                fluidProperties = param1;
                if (body != null)
                {
                }
                if (body.space != null)
                {
                    param1.shapes.add(this);
                }
                if (fluidEnabled)
                {
                    wake();
                }
            }
            return;
        }// end function

        public function setFilter(param1:ZPP_InteractionFilter) : void
        {
            if (filter != param1)
            {
                if (body != null)
                {
                }
                if (body.space != null)
                {
                    if (filter != null)
                    {
                        filter.shapes.remove(this);
                    }
                }
                filter = param1;
                if (body != null)
                {
                }
                if (body.space != null)
                {
                    param1.shapes.add(this);
                }
                wake();
            }
            return;
        }// end function

        public function removedFromSpace() : void
        {
            __iremovedFromSpace();
            material.shapes.remove(this);
            filter.shapes.remove(this);
            if (fluidProperties != null)
            {
                fluidProperties.shapes.remove(this);
            }
            return;
        }// end function

        public function removedFromBody() : void
        {
            return;
        }// end function

        public function isPolygon() : Boolean
        {
            return type == ZPP_Flags.id_ShapeType_POLYGON;
        }// end function

        public function isCircle() : Boolean
        {
            return type == ZPP_Flags.id_ShapeType_CIRCLE;
        }// end function

        public function invalidate_worldCOM() : void
        {
            zip_worldCOM = true;
            zip_aabb = true;
            if (body != null)
            {
                body.zip_aabb = true;
            }
            return;
        }// end function

        public function invalidate_sweepRadius() : void
        {
            zip_sweepRadius = true;
            return;
        }// end function

        public function invalidate_material(param1:int) : void
        {
            var _loc_2:* = null as ZPP_Body;
            if ((param1 & ZPP_Material.WAKE) != 0)
            {
                wake();
            }
            if ((param1 & ZPP_Material.ARBITERS) != 0)
            {
                if (body != null)
                {
                    body.refreshArbiters();
                }
            }
            if ((param1 & ZPP_Material.PROPS) != 0)
            {
                if (body != null)
                {
                    _loc_2 = body;
                    _loc_2.zip_localCOM = true;
                    _loc_2.zip_worldCOM = true;
                    body.invalidate_mass();
                    body.invalidate_inertia();
                }
            }
            if ((param1 & ZPP_Material.ANGDRAG) != 0)
            {
                invalidate_angDrag();
            }
            refmaterial.set(material);
            return;
        }// end function

        public function invalidate_localCOM() : void
        {
            var _loc_1:* = null as ZPP_Body;
            zip_localCOM = true;
            invalidate_area_inertia();
            if (type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                zip_sweepRadius = true;
            }
            invalidate_angDrag();
            invalidate_worldCOM();
            if (body != null)
            {
                _loc_1 = body;
                _loc_1.zip_localCOM = true;
                _loc_1.zip_worldCOM = true;
            }
            return;
        }// end function

        public function invalidate_fluidprops() : void
        {
            if (fluidEnabled)
            {
                wake();
            }
            return;
        }// end function

        public function invalidate_filter() : void
        {
            wake();
            return;
        }// end function

        public function invalidate_area_inertia() : void
        {
            var _loc_1:* = null as ZPP_Body;
            zip_area_inertia = true;
            if (body != null)
            {
                _loc_1 = body;
                _loc_1.zip_localCOM = true;
                _loc_1.zip_worldCOM = true;
                body.invalidate_mass();
                body.invalidate_inertia();
            }
            return;
        }// end function

        public function invalidate_angDrag() : void
        {
            zip_angDrag = true;
            return;
        }// end function

        public function invalidate_aabb() : void
        {
            zip_aabb = true;
            if (body != null)
            {
                body.zip_aabb = true;
            }
            return;
        }// end function

        public function getworldCOM() : void
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
            if (body == null)
            {
                throw "Error: worldCOM only makes sense when Shape belongs to a Body";
            }
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
            wrap_worldCOM.zpp_inner.x = worldCOMx;
            wrap_worldCOM.zpp_inner.y = worldCOMy;
            return;
        }// end function

        public function force_validate_aabb() : void
        {
            var _loc_1:* = null as ZPP_Circle;
            var _loc_2:* = null as ZPP_Polygon;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            if (type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                _loc_1 = circle;
                _loc_1.worldCOMx = _loc_1.body.posx + (_loc_1.body.axisy * _loc_1.localCOMx - _loc_1.body.axisx * _loc_1.localCOMy);
                _loc_1.worldCOMy = _loc_1.body.posy + (_loc_1.localCOMx * _loc_1.body.axisx + _loc_1.localCOMy * _loc_1.body.axisy);
                _loc_1.aabb.minx = _loc_1.worldCOMx - _loc_1.radius;
                _loc_1.aabb.miny = _loc_1.worldCOMy - _loc_1.radius;
                _loc_1.aabb.maxx = _loc_1.worldCOMx + _loc_1.radius;
                _loc_1.aabb.maxy = _loc_1.worldCOMy + _loc_1.radius;
            }
            else
            {
                _loc_2 = polygon;
                _loc_3 = _loc_2.lverts.next;
                _loc_4 = _loc_2.gverts.next;
                _loc_5 = _loc_3;
                _loc_3 = _loc_3.next;
                _loc_4.x = _loc_2.body.posx + (_loc_2.body.axisy * _loc_5.x - _loc_2.body.axisx * _loc_5.y);
                _loc_4.y = _loc_2.body.posy + (_loc_5.x * _loc_2.body.axisx + _loc_5.y * _loc_2.body.axisy);
                _loc_2.aabb.minx = _loc_4.x;
                _loc_2.aabb.miny = _loc_4.y;
                _loc_2.aabb.maxx = _loc_4.x;
                _loc_2.aabb.maxy = _loc_4.y;
                _loc_6 = _loc_2.gverts.next.next;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6;
                    _loc_8 = _loc_3;
                    _loc_3 = _loc_3.next;
                    _loc_7.x = _loc_2.body.posx + (_loc_2.body.axisy * _loc_8.x - _loc_2.body.axisx * _loc_8.y);
                    _loc_7.y = _loc_2.body.posy + (_loc_8.x * _loc_2.body.axisx + _loc_8.y * _loc_2.body.axisy);
                    if (_loc_7.x < _loc_2.aabb.minx)
                    {
                        _loc_2.aabb.minx = _loc_7.x;
                    }
                    if (_loc_7.x > _loc_2.aabb.maxx)
                    {
                        _loc_2.aabb.maxx = _loc_7.x;
                    }
                    if (_loc_7.y < _loc_2.aabb.miny)
                    {
                        _loc_2.aabb.miny = _loc_7.y;
                    }
                    if (_loc_7.y > _loc_2.aabb.maxy)
                    {
                        _loc_2.aabb.maxy = _loc_7.y;
                    }
                    _loc_6 = _loc_6.next;
                }
            }
            return;
        }// end function

        public function copy() : Shape
        {
            var _loc_1:* = null;
            if (type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                _loc_1 = circle.__copy();
            }
            else
            {
                _loc_1 = polygon.__copy();
            }
            if (!zip_area_inertia)
            {
                _loc_1.area = area;
                _loc_1.inertia = inertia;
            }
            else
            {
                _loc_1.invalidate_area_inertia();
            }
            if (!zip_sweepRadius)
            {
                _loc_1.sweepRadius = sweepRadius;
                _loc_1.sweepCoef = sweepCoef;
            }
            else
            {
                _loc_1.zip_sweepRadius = true;
            }
            if (!zip_angDrag)
            {
                _loc_1.angDrag = angDrag;
            }
            else
            {
                _loc_1.invalidate_angDrag();
            }
            if (!zip_aabb)
            {
                _loc_1.aabb.minx = aabb.minx;
                _loc_1.aabb.miny = aabb.miny;
                _loc_1.aabb.maxx = aabb.maxx;
                _loc_1.aabb.maxy = aabb.maxy;
            }
            else
            {
                _loc_1.zip_aabb = true;
                if (_loc_1.body != null)
                {
                    _loc_1.body.zip_aabb = true;
                }
            }
            var _loc_2:* = _loc_1.material;
            _loc_2.outer = null;
            _loc_2.next = ZPP_Material.zpp_pool;
            ZPP_Material.zpp_pool = _loc_2;
            var _loc_3:* = _loc_1.filter;
            _loc_3.outer = null;
            _loc_3.next = ZPP_InteractionFilter.zpp_pool;
            ZPP_InteractionFilter.zpp_pool = _loc_3;
            _loc_1.material = material;
            _loc_1.filter = filter;
            if (fluidProperties != null)
            {
                _loc_1.fluidProperties = fluidProperties;
            }
            _loc_1.fluidEnabled = fluidEnabled;
            _loc_1.sensorEnabled = sensorEnabled;
            if (userData != null)
            {
                _loc_1.userData = Reflect.copy(userData);
            }
            copyto(_loc_1.outer);
            return _loc_1.outer;
        }// end function

        public function clear() : void
        {
            if (type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                circle.__clear();
            }
            else
            {
                polygon.__clear();
            }
            return;
        }// end function

        public function addedToSpace() : void
        {
            __iaddedToSpace();
            material.shapes.add(this);
            filter.shapes.add(this);
            if (fluidProperties != null)
            {
                fluidProperties.shapes.add(this);
            }
            return;
        }// end function

        public function addedToBody() : void
        {
            invalidate_worldCOM();
            zip_aabb = true;
            if (body != null)
            {
                body.zip_aabb = true;
            }
            return;
        }// end function

        public function aabb_validate() : void
        {
            var _loc_1:* = null as ZPP_Circle;
            var _loc_2:* = null as ZPP_Polygon;
            var _loc_3:* = NaN;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = NaN;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = null as ZPP_Body;
            if (body == null)
            {
                throw "Error: bounds only makes sense when Shape belongs to a Body";
            }
            if (zip_aabb)
            {
                if (body != null)
                {
                    zip_aabb = false;
                    if (type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_1 = circle;
                        if (_loc_1.zip_worldCOM)
                        {
                            if (_loc_1.body != null)
                            {
                                _loc_1.zip_worldCOM = false;
                                if (_loc_1.zip_localCOM)
                                {
                                    _loc_1.zip_localCOM = false;
                                    if (_loc_1.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                        _loc_2 = _loc_1.polygon;
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
                                            _loc_3 = 1;
                                            _loc_2.localCOMx = _loc_2.localCOMx + _loc_2.lverts.next.next.x * _loc_3;
                                            _loc_2.localCOMy = _loc_2.localCOMy + _loc_2.lverts.next.next.y * _loc_3;
                                            _loc_3 = 0.5;
                                            _loc_2.localCOMx = _loc_2.localCOMx * _loc_3;
                                            _loc_2.localCOMy = _loc_2.localCOMy * _loc_3;
                                        }
                                        else
                                        {
                                            _loc_2.localCOMx = 0;
                                            _loc_2.localCOMy = 0;
                                            _loc_3 = 0;
                                            _loc_4 = _loc_2.lverts.next;
                                            _loc_5 = _loc_4;
                                            _loc_4 = _loc_4.next;
                                            _loc_6 = _loc_4;
                                            _loc_4 = _loc_4.next;
                                            while (_loc_4 != null)
                                            {
                                                
                                                _loc_7 = _loc_4;
                                                _loc_3 = _loc_3 + _loc_6.x * (_loc_7.y - _loc_5.y);
                                                _loc_8 = _loc_7.y * _loc_6.x - _loc_7.x * _loc_6.y;
                                                _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_7.x) * _loc_8;
                                                _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_7.y) * _loc_8;
                                                _loc_5 = _loc_6;
                                                _loc_6 = _loc_7;
                                                _loc_4 = _loc_4.next;
                                            }
                                            _loc_4 = _loc_2.lverts.next;
                                            _loc_7 = _loc_4;
                                            _loc_3 = _loc_3 + _loc_6.x * (_loc_7.y - _loc_5.y);
                                            _loc_8 = _loc_7.y * _loc_6.x - _loc_7.x * _loc_6.y;
                                            _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_7.x) * _loc_8;
                                            _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_7.y) * _loc_8;
                                            _loc_5 = _loc_6;
                                            _loc_6 = _loc_7;
                                            _loc_4 = _loc_4.next;
                                            _loc_9 = _loc_4;
                                            _loc_3 = _loc_3 + _loc_6.x * (_loc_9.y - _loc_5.y);
                                            _loc_8 = _loc_9.y * _loc_6.x - _loc_9.x * _loc_6.y;
                                            _loc_2.localCOMx = _loc_2.localCOMx + (_loc_6.x + _loc_9.x) * _loc_8;
                                            _loc_2.localCOMy = _loc_2.localCOMy + (_loc_6.y + _loc_9.y) * _loc_8;
                                            _loc_3 = 1 / (3 * _loc_3);
                                            _loc_8 = _loc_3;
                                            _loc_2.localCOMx = _loc_2.localCOMx * _loc_8;
                                            _loc_2.localCOMy = _loc_2.localCOMy * _loc_8;
                                        }
                                    }
                                    if (_loc_1.wrap_localCOM != null)
                                    {
                                        _loc_1.wrap_localCOM.zpp_inner.x = _loc_1.localCOMx;
                                        _loc_1.wrap_localCOM.zpp_inner.y = _loc_1.localCOMy;
                                    }
                                }
                                _loc_10 = _loc_1.body;
                                if (_loc_10.zip_axis)
                                {
                                    _loc_10.zip_axis = false;
                                    _loc_10.axisx = Math.sin(_loc_10.rot);
                                    _loc_10.axisy = Math.cos(_loc_10.rot);
                                }
                                _loc_1.worldCOMx = _loc_1.body.posx + (_loc_1.body.axisy * _loc_1.localCOMx - _loc_1.body.axisx * _loc_1.localCOMy);
                                _loc_1.worldCOMy = _loc_1.body.posy + (_loc_1.localCOMx * _loc_1.body.axisx + _loc_1.localCOMy * _loc_1.body.axisy);
                            }
                        }
                        _loc_3 = _loc_1.radius;
                        _loc_8 = _loc_1.radius;
                        _loc_1.aabb.minx = _loc_1.worldCOMx - _loc_3;
                        _loc_1.aabb.miny = _loc_1.worldCOMy - _loc_8;
                        _loc_1.aabb.maxx = _loc_1.worldCOMx + _loc_3;
                        _loc_1.aabb.maxy = _loc_1.worldCOMy + _loc_8;
                    }
                    else
                    {
                        _loc_2 = polygon;
                        if (_loc_2.zip_gverts)
                        {
                            if (_loc_2.body != null)
                            {
                                _loc_2.zip_gverts = false;
                                _loc_2.validate_lverts();
                                _loc_10 = _loc_2.body;
                                if (_loc_10.zip_axis)
                                {
                                    _loc_10.zip_axis = false;
                                    _loc_10.axisx = Math.sin(_loc_10.rot);
                                    _loc_10.axisy = Math.cos(_loc_10.rot);
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
            return;
        }// end function

        public function __immutable_midstep(param1:String) : void
        {
            if (body != null)
            {
            }
            if (body.space != null)
            {
            }
            if (body.space.midstep)
            {
                throw "Error: " + param1 + " cannot be set during a space step()";
            }
            return;
        }// end function

    }
}
