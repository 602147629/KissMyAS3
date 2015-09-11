package nape.shape
{
    import flash.*;
    import nape.geom.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    final public class Edge extends Object
    {
        public var zpp_inner:ZPP_Edge;

        public function Edge() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (!ZPP_Edge.internal)
            {
                throw "Error: Cannot instantiate an Edge derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = null as ZPP_Polygon;
            var _loc_2:* = null as ZPP_Body;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZNPNode_ZPP_Edge;
            var _loc_8:* = null as ZPP_Edge;
            if (zpp_inner.polygon == null)
            {
                return "Edge(object-pooled)";
            }
            else if (zpp_inner.polygon.body == null)
            {
                zpp_inner.polygon.validate_laxi();
                return "{ localNormal : " + ("{ x: " + zpp_inner.lnormx + " y: " + zpp_inner.lnormy + " }") + " }";
            }
            else
            {
                _loc_1 = zpp_inner.polygon;
                if (_loc_1.zip_gaxi)
                {
                    if (_loc_1.body != null)
                    {
                        _loc_1.zip_gaxi = false;
                        _loc_1.validate_laxi();
                        _loc_2 = _loc_1.body;
                        if (_loc_2.zip_axis)
                        {
                            _loc_2.zip_axis = false;
                            _loc_2.axisx = Math.sin(_loc_2.rot);
                            _loc_2.axisy = Math.cos(_loc_2.rot);
                        }
                        if (_loc_1.zip_gverts)
                        {
                            if (_loc_1.body != null)
                            {
                                _loc_1.zip_gverts = false;
                                _loc_1.validate_lverts();
                                _loc_2 = _loc_1.body;
                                if (_loc_2.zip_axis)
                                {
                                    _loc_2.zip_axis = false;
                                    _loc_2.axisx = Math.sin(_loc_2.rot);
                                    _loc_2.axisy = Math.cos(_loc_2.rot);
                                }
                                _loc_3 = _loc_1.lverts.next;
                                _loc_4 = _loc_1.gverts.next;
                                while (_loc_4 != null)
                                {
                                    
                                    _loc_5 = _loc_4;
                                    _loc_6 = _loc_3;
                                    _loc_3 = _loc_3.next;
                                    _loc_5.x = _loc_1.body.posx + (_loc_1.body.axisy * _loc_6.x - _loc_1.body.axisx * _loc_6.y);
                                    _loc_5.y = _loc_1.body.posy + (_loc_6.x * _loc_1.body.axisx + _loc_6.y * _loc_1.body.axisy);
                                    _loc_4 = _loc_4.next;
                                }
                            }
                        }
                        _loc_7 = _loc_1.edges.head;
                        _loc_3 = _loc_1.gverts.next;
                        _loc_4 = _loc_3;
                        _loc_3 = _loc_3.next;
                        while (_loc_3 != null)
                        {
                            
                            _loc_5 = _loc_3;
                            _loc_8 = _loc_7.elt;
                            _loc_7 = _loc_7.next;
                            _loc_8.gp0 = _loc_4;
                            _loc_8.gp1 = _loc_5;
                            _loc_8.gnormx = _loc_1.body.axisy * _loc_8.lnormx - _loc_1.body.axisx * _loc_8.lnormy;
                            _loc_8.gnormy = _loc_8.lnormx * _loc_1.body.axisx + _loc_8.lnormy * _loc_1.body.axisy;
                            _loc_8.gprojection = _loc_1.body.posx * _loc_8.gnormx + _loc_1.body.posy * _loc_8.gnormy + _loc_8.lprojection;
                            if (_loc_8.wrap_gnorm != null)
                            {
                                _loc_8.wrap_gnorm.zpp_inner.x = _loc_8.gnormx;
                                _loc_8.wrap_gnorm.zpp_inner.y = _loc_8.gnormy;
                            }
                            _loc_8.tp0 = _loc_8.gp0.y * _loc_8.gnormx - _loc_8.gp0.x * _loc_8.gnormy;
                            _loc_8.tp1 = _loc_8.gp1.y * _loc_8.gnormx - _loc_8.gp1.x * _loc_8.gnormy;
                            _loc_4 = _loc_5;
                            _loc_3 = _loc_3.next;
                        }
                        _loc_5 = _loc_1.gverts.next;
                        _loc_8 = _loc_7.elt;
                        _loc_7 = _loc_7.next;
                        _loc_8.gp0 = _loc_4;
                        _loc_8.gp1 = _loc_5;
                        _loc_8.gnormx = _loc_1.body.axisy * _loc_8.lnormx - _loc_1.body.axisx * _loc_8.lnormy;
                        _loc_8.gnormy = _loc_8.lnormx * _loc_1.body.axisx + _loc_8.lnormy * _loc_1.body.axisy;
                        _loc_8.gprojection = _loc_1.body.posx * _loc_8.gnormx + _loc_1.body.posy * _loc_8.gnormy + _loc_8.lprojection;
                        if (_loc_8.wrap_gnorm != null)
                        {
                            _loc_8.wrap_gnorm.zpp_inner.x = _loc_8.gnormx;
                            _loc_8.wrap_gnorm.zpp_inner.y = _loc_8.gnormy;
                        }
                        _loc_8.tp0 = _loc_8.gp0.y * _loc_8.gnormx - _loc_8.gp0.x * _loc_8.gnormy;
                        _loc_8.tp1 = _loc_8.gp1.y * _loc_8.gnormx - _loc_8.gp1.x * _loc_8.gnormy;
                    }
                }
                return "{ localNormal : " + ("{ x: " + zpp_inner.lnormx + " y: " + zpp_inner.lnormy + " }") + " worldNormal : " + ("{ x: " + zpp_inner.gnormx + " y: " + zpp_inner.gnormy + " }") + " }";
            }
        }// end function

        public function get_worldVertex2() : Vec2
        {
            var _loc_2:* = null as ZPP_Body;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZNPNode_ZPP_Edge;
            var _loc_8:* = null as ZPP_Edge;
            if (zpp_inner.polygon == null)
            {
                throw "Error: Edge not current in use";
            }
            var _loc_1:* = zpp_inner.polygon;
            if (_loc_1.zip_gaxi)
            {
                if (_loc_1.body != null)
                {
                    _loc_1.zip_gaxi = false;
                    _loc_1.validate_laxi();
                    _loc_2 = _loc_1.body;
                    if (_loc_2.zip_axis)
                    {
                        _loc_2.zip_axis = false;
                        _loc_2.axisx = Math.sin(_loc_2.rot);
                        _loc_2.axisy = Math.cos(_loc_2.rot);
                    }
                    if (_loc_1.zip_gverts)
                    {
                        if (_loc_1.body != null)
                        {
                            _loc_1.zip_gverts = false;
                            _loc_1.validate_lverts();
                            _loc_2 = _loc_1.body;
                            if (_loc_2.zip_axis)
                            {
                                _loc_2.zip_axis = false;
                                _loc_2.axisx = Math.sin(_loc_2.rot);
                                _loc_2.axisy = Math.cos(_loc_2.rot);
                            }
                            _loc_3 = _loc_1.lverts.next;
                            _loc_4 = _loc_1.gverts.next;
                            while (_loc_4 != null)
                            {
                                
                                _loc_5 = _loc_4;
                                _loc_6 = _loc_3;
                                _loc_3 = _loc_3.next;
                                _loc_5.x = _loc_1.body.posx + (_loc_1.body.axisy * _loc_6.x - _loc_1.body.axisx * _loc_6.y);
                                _loc_5.y = _loc_1.body.posy + (_loc_6.x * _loc_1.body.axisx + _loc_6.y * _loc_1.body.axisy);
                                _loc_4 = _loc_4.next;
                            }
                        }
                    }
                    _loc_7 = _loc_1.edges.head;
                    _loc_3 = _loc_1.gverts.next;
                    _loc_4 = _loc_3;
                    _loc_3 = _loc_3.next;
                    while (_loc_3 != null)
                    {
                        
                        _loc_5 = _loc_3;
                        _loc_8 = _loc_7.elt;
                        _loc_7 = _loc_7.next;
                        _loc_8.gp0 = _loc_4;
                        _loc_8.gp1 = _loc_5;
                        _loc_8.gnormx = _loc_1.body.axisy * _loc_8.lnormx - _loc_1.body.axisx * _loc_8.lnormy;
                        _loc_8.gnormy = _loc_8.lnormx * _loc_1.body.axisx + _loc_8.lnormy * _loc_1.body.axisy;
                        _loc_8.gprojection = _loc_1.body.posx * _loc_8.gnormx + _loc_1.body.posy * _loc_8.gnormy + _loc_8.lprojection;
                        if (_loc_8.wrap_gnorm != null)
                        {
                            _loc_8.wrap_gnorm.zpp_inner.x = _loc_8.gnormx;
                            _loc_8.wrap_gnorm.zpp_inner.y = _loc_8.gnormy;
                        }
                        _loc_8.tp0 = _loc_8.gp0.y * _loc_8.gnormx - _loc_8.gp0.x * _loc_8.gnormy;
                        _loc_8.tp1 = _loc_8.gp1.y * _loc_8.gnormx - _loc_8.gp1.x * _loc_8.gnormy;
                        _loc_4 = _loc_5;
                        _loc_3 = _loc_3.next;
                    }
                    _loc_5 = _loc_1.gverts.next;
                    _loc_8 = _loc_7.elt;
                    _loc_7 = _loc_7.next;
                    _loc_8.gp0 = _loc_4;
                    _loc_8.gp1 = _loc_5;
                    _loc_8.gnormx = _loc_1.body.axisy * _loc_8.lnormx - _loc_1.body.axisx * _loc_8.lnormy;
                    _loc_8.gnormy = _loc_8.lnormx * _loc_1.body.axisx + _loc_8.lnormy * _loc_1.body.axisy;
                    _loc_8.gprojection = _loc_1.body.posx * _loc_8.gnormx + _loc_1.body.posy * _loc_8.gnormy + _loc_8.lprojection;
                    if (_loc_8.wrap_gnorm != null)
                    {
                        _loc_8.wrap_gnorm.zpp_inner.x = _loc_8.gnormx;
                        _loc_8.wrap_gnorm.zpp_inner.y = _loc_8.gnormy;
                    }
                    _loc_8.tp0 = _loc_8.gp0.y * _loc_8.gnormx - _loc_8.gp0.x * _loc_8.gnormy;
                    _loc_8.tp1 = _loc_8.gp1.y * _loc_8.gnormx - _loc_8.gp1.x * _loc_8.gnormy;
                }
            }
            _loc_3 = zpp_inner.gp1;
            if (_loc_3.outer == null)
            {
                _loc_3.outer = new Vec2();
                _loc_4 = _loc_3.outer.zpp_inner;
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
                _loc_3.outer.zpp_inner = _loc_3;
            }
            return _loc_3.outer;
        }// end function

        public function get_worldVertex1() : Vec2
        {
            var _loc_2:* = null as ZPP_Body;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZNPNode_ZPP_Edge;
            var _loc_8:* = null as ZPP_Edge;
            if (zpp_inner.polygon == null)
            {
                throw "Error: Edge not current in use";
            }
            var _loc_1:* = zpp_inner.polygon;
            if (_loc_1.zip_gaxi)
            {
                if (_loc_1.body != null)
                {
                    _loc_1.zip_gaxi = false;
                    _loc_1.validate_laxi();
                    _loc_2 = _loc_1.body;
                    if (_loc_2.zip_axis)
                    {
                        _loc_2.zip_axis = false;
                        _loc_2.axisx = Math.sin(_loc_2.rot);
                        _loc_2.axisy = Math.cos(_loc_2.rot);
                    }
                    if (_loc_1.zip_gverts)
                    {
                        if (_loc_1.body != null)
                        {
                            _loc_1.zip_gverts = false;
                            _loc_1.validate_lverts();
                            _loc_2 = _loc_1.body;
                            if (_loc_2.zip_axis)
                            {
                                _loc_2.zip_axis = false;
                                _loc_2.axisx = Math.sin(_loc_2.rot);
                                _loc_2.axisy = Math.cos(_loc_2.rot);
                            }
                            _loc_3 = _loc_1.lverts.next;
                            _loc_4 = _loc_1.gverts.next;
                            while (_loc_4 != null)
                            {
                                
                                _loc_5 = _loc_4;
                                _loc_6 = _loc_3;
                                _loc_3 = _loc_3.next;
                                _loc_5.x = _loc_1.body.posx + (_loc_1.body.axisy * _loc_6.x - _loc_1.body.axisx * _loc_6.y);
                                _loc_5.y = _loc_1.body.posy + (_loc_6.x * _loc_1.body.axisx + _loc_6.y * _loc_1.body.axisy);
                                _loc_4 = _loc_4.next;
                            }
                        }
                    }
                    _loc_7 = _loc_1.edges.head;
                    _loc_3 = _loc_1.gverts.next;
                    _loc_4 = _loc_3;
                    _loc_3 = _loc_3.next;
                    while (_loc_3 != null)
                    {
                        
                        _loc_5 = _loc_3;
                        _loc_8 = _loc_7.elt;
                        _loc_7 = _loc_7.next;
                        _loc_8.gp0 = _loc_4;
                        _loc_8.gp1 = _loc_5;
                        _loc_8.gnormx = _loc_1.body.axisy * _loc_8.lnormx - _loc_1.body.axisx * _loc_8.lnormy;
                        _loc_8.gnormy = _loc_8.lnormx * _loc_1.body.axisx + _loc_8.lnormy * _loc_1.body.axisy;
                        _loc_8.gprojection = _loc_1.body.posx * _loc_8.gnormx + _loc_1.body.posy * _loc_8.gnormy + _loc_8.lprojection;
                        if (_loc_8.wrap_gnorm != null)
                        {
                            _loc_8.wrap_gnorm.zpp_inner.x = _loc_8.gnormx;
                            _loc_8.wrap_gnorm.zpp_inner.y = _loc_8.gnormy;
                        }
                        _loc_8.tp0 = _loc_8.gp0.y * _loc_8.gnormx - _loc_8.gp0.x * _loc_8.gnormy;
                        _loc_8.tp1 = _loc_8.gp1.y * _loc_8.gnormx - _loc_8.gp1.x * _loc_8.gnormy;
                        _loc_4 = _loc_5;
                        _loc_3 = _loc_3.next;
                    }
                    _loc_5 = _loc_1.gverts.next;
                    _loc_8 = _loc_7.elt;
                    _loc_7 = _loc_7.next;
                    _loc_8.gp0 = _loc_4;
                    _loc_8.gp1 = _loc_5;
                    _loc_8.gnormx = _loc_1.body.axisy * _loc_8.lnormx - _loc_1.body.axisx * _loc_8.lnormy;
                    _loc_8.gnormy = _loc_8.lnormx * _loc_1.body.axisx + _loc_8.lnormy * _loc_1.body.axisy;
                    _loc_8.gprojection = _loc_1.body.posx * _loc_8.gnormx + _loc_1.body.posy * _loc_8.gnormy + _loc_8.lprojection;
                    if (_loc_8.wrap_gnorm != null)
                    {
                        _loc_8.wrap_gnorm.zpp_inner.x = _loc_8.gnormx;
                        _loc_8.wrap_gnorm.zpp_inner.y = _loc_8.gnormy;
                    }
                    _loc_8.tp0 = _loc_8.gp0.y * _loc_8.gnormx - _loc_8.gp0.x * _loc_8.gnormy;
                    _loc_8.tp1 = _loc_8.gp1.y * _loc_8.gnormx - _loc_8.gp1.x * _loc_8.gnormy;
                }
            }
            _loc_3 = zpp_inner.gp0;
            if (_loc_3.outer == null)
            {
                _loc_3.outer = new Vec2();
                _loc_4 = _loc_3.outer.zpp_inner;
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
                _loc_3.outer.zpp_inner = _loc_3;
            }
            return _loc_3.outer;
        }// end function

        public function get_worldProjection() : Number
        {
            var _loc_2:* = null as ZPP_Body;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZNPNode_ZPP_Edge;
            var _loc_8:* = null as ZPP_Edge;
            if (zpp_inner.polygon == null)
            {
                throw "Error: Edge not current in use";
            }
            if (zpp_inner.polygon.body == null)
            {
                throw "Error: Edge world projection only makes sense for Polygons contained within a rigid body";
            }
            var _loc_1:* = zpp_inner.polygon;
            if (_loc_1.zip_gaxi)
            {
                if (_loc_1.body != null)
                {
                    _loc_1.zip_gaxi = false;
                    _loc_1.validate_laxi();
                    _loc_2 = _loc_1.body;
                    if (_loc_2.zip_axis)
                    {
                        _loc_2.zip_axis = false;
                        _loc_2.axisx = Math.sin(_loc_2.rot);
                        _loc_2.axisy = Math.cos(_loc_2.rot);
                    }
                    if (_loc_1.zip_gverts)
                    {
                        if (_loc_1.body != null)
                        {
                            _loc_1.zip_gverts = false;
                            _loc_1.validate_lverts();
                            _loc_2 = _loc_1.body;
                            if (_loc_2.zip_axis)
                            {
                                _loc_2.zip_axis = false;
                                _loc_2.axisx = Math.sin(_loc_2.rot);
                                _loc_2.axisy = Math.cos(_loc_2.rot);
                            }
                            _loc_3 = _loc_1.lverts.next;
                            _loc_4 = _loc_1.gverts.next;
                            while (_loc_4 != null)
                            {
                                
                                _loc_5 = _loc_4;
                                _loc_6 = _loc_3;
                                _loc_3 = _loc_3.next;
                                _loc_5.x = _loc_1.body.posx + (_loc_1.body.axisy * _loc_6.x - _loc_1.body.axisx * _loc_6.y);
                                _loc_5.y = _loc_1.body.posy + (_loc_6.x * _loc_1.body.axisx + _loc_6.y * _loc_1.body.axisy);
                                _loc_4 = _loc_4.next;
                            }
                        }
                    }
                    _loc_7 = _loc_1.edges.head;
                    _loc_3 = _loc_1.gverts.next;
                    _loc_4 = _loc_3;
                    _loc_3 = _loc_3.next;
                    while (_loc_3 != null)
                    {
                        
                        _loc_5 = _loc_3;
                        _loc_8 = _loc_7.elt;
                        _loc_7 = _loc_7.next;
                        _loc_8.gp0 = _loc_4;
                        _loc_8.gp1 = _loc_5;
                        _loc_8.gnormx = _loc_1.body.axisy * _loc_8.lnormx - _loc_1.body.axisx * _loc_8.lnormy;
                        _loc_8.gnormy = _loc_8.lnormx * _loc_1.body.axisx + _loc_8.lnormy * _loc_1.body.axisy;
                        _loc_8.gprojection = _loc_1.body.posx * _loc_8.gnormx + _loc_1.body.posy * _loc_8.gnormy + _loc_8.lprojection;
                        if (_loc_8.wrap_gnorm != null)
                        {
                            _loc_8.wrap_gnorm.zpp_inner.x = _loc_8.gnormx;
                            _loc_8.wrap_gnorm.zpp_inner.y = _loc_8.gnormy;
                        }
                        _loc_8.tp0 = _loc_8.gp0.y * _loc_8.gnormx - _loc_8.gp0.x * _loc_8.gnormy;
                        _loc_8.tp1 = _loc_8.gp1.y * _loc_8.gnormx - _loc_8.gp1.x * _loc_8.gnormy;
                        _loc_4 = _loc_5;
                        _loc_3 = _loc_3.next;
                    }
                    _loc_5 = _loc_1.gverts.next;
                    _loc_8 = _loc_7.elt;
                    _loc_7 = _loc_7.next;
                    _loc_8.gp0 = _loc_4;
                    _loc_8.gp1 = _loc_5;
                    _loc_8.gnormx = _loc_1.body.axisy * _loc_8.lnormx - _loc_1.body.axisx * _loc_8.lnormy;
                    _loc_8.gnormy = _loc_8.lnormx * _loc_1.body.axisx + _loc_8.lnormy * _loc_1.body.axisy;
                    _loc_8.gprojection = _loc_1.body.posx * _loc_8.gnormx + _loc_1.body.posy * _loc_8.gnormy + _loc_8.lprojection;
                    if (_loc_8.wrap_gnorm != null)
                    {
                        _loc_8.wrap_gnorm.zpp_inner.x = _loc_8.gnormx;
                        _loc_8.wrap_gnorm.zpp_inner.y = _loc_8.gnormy;
                    }
                    _loc_8.tp0 = _loc_8.gp0.y * _loc_8.gnormx - _loc_8.gp0.x * _loc_8.gnormy;
                    _loc_8.tp1 = _loc_8.gp1.y * _loc_8.gnormx - _loc_8.gp1.x * _loc_8.gnormy;
                }
            }
            return zpp_inner.gprojection;
        }// end function

        public function get_worldNormal() : Vec2
        {
            if (zpp_inner.polygon == null)
            {
                throw "Error: Edge not current in use";
            }
            if (zpp_inner.wrap_gnorm == null)
            {
                zpp_inner.getgnorm();
            }
            return zpp_inner.wrap_gnorm;
        }// end function

        public function get_polygon() : Polygon
        {
            if (zpp_inner.polygon == null)
            {
                throw "Error: Edge not current in use";
            }
            return zpp_inner.polygon.outer_zn;
        }// end function

        public function get_localVertex2() : Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            if (zpp_inner.polygon == null)
            {
                throw "Error: Edge not current in use";
            }
            zpp_inner.polygon.validate_laxi();
            var _loc_1:* = zpp_inner.lp1;
            if (_loc_1.outer == null)
            {
                _loc_1.outer = new Vec2();
                _loc_2 = _loc_1.outer.zpp_inner;
                if (_loc_2.outer != null)
                {
                    _loc_2.outer.zpp_inner = null;
                    _loc_2.outer = null;
                }
                _loc_2._isimmutable = null;
                _loc_2._validate = null;
                _loc_2._invalidate = null;
                _loc_2.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_2;
                _loc_1.outer.zpp_inner = _loc_1;
            }
            return _loc_1.outer;
        }// end function

        public function get_localVertex1() : Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            if (zpp_inner.polygon == null)
            {
                throw "Error: Edge not current in use";
            }
            zpp_inner.polygon.validate_laxi();
            var _loc_1:* = zpp_inner.lp0;
            if (_loc_1.outer == null)
            {
                _loc_1.outer = new Vec2();
                _loc_2 = _loc_1.outer.zpp_inner;
                if (_loc_2.outer != null)
                {
                    _loc_2.outer.zpp_inner = null;
                    _loc_2.outer = null;
                }
                _loc_2._isimmutable = null;
                _loc_2._validate = null;
                _loc_2._invalidate = null;
                _loc_2.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_2;
                _loc_1.outer.zpp_inner = _loc_1;
            }
            return _loc_1.outer;
        }// end function

        public function get_localProjection() : Number
        {
            if (zpp_inner.polygon == null)
            {
                throw "Error: Edge not current in use";
            }
            zpp_inner.polygon.validate_laxi();
            return zpp_inner.lprojection;
        }// end function

        public function get_localNormal() : Vec2
        {
            if (zpp_inner.polygon == null)
            {
                throw "Error: Edge not current in use";
            }
            if (zpp_inner.wrap_lnorm == null)
            {
                zpp_inner.getlnorm();
            }
            return zpp_inner.wrap_lnorm;
        }// end function

        public function get_length() : Number
        {
            if (zpp_inner.polygon == null)
            {
                throw "Error: Edge not current in use";
            }
            zpp_inner.polygon.validate_laxi();
            return zpp_inner.length;
        }// end function

    }
}
