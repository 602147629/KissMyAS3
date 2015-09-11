package zpp_nape.geom
{
    import nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_Geom extends Object
    {

        public function ZPP_Geom() : void
        {
            return;
        }// end function

        public static function validateShape(param1:ZPP_Shape) : void
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

    }
}
