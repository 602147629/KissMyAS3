package zpp_nape.shape
{
    import flash.*;
    import nape.geom.*;
    import nape.shape.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.util.*;

    public class ZPP_Edge extends Object
    {
        public var wrap_lnorm:Vec2;
        public var wrap_gnorm:Vec2;
        public var tp1:Number;
        public var tp0:Number;
        public var polygon:ZPP_Polygon;
        public var outer:Edge;
        public var next:ZPP_Edge;
        public var lprojection:Number;
        public var lp1:ZPP_Vec2;
        public var lp0:ZPP_Vec2;
        public var lnormy:Number;
        public var lnormx:Number;
        public var length:Number;
        public var gprojection:Number;
        public var gp1:ZPP_Vec2;
        public var gp0:ZPP_Vec2;
        public var gnormy:Number;
        public var gnormx:Number;
        public static var zpp_pool:ZPP_Edge;
        public static var internal:Boolean;

        public function ZPP_Edge() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            tp1 = 0;
            tp0 = 0;
            gp1 = null;
            lp1 = null;
            gp0 = null;
            lp0 = null;
            gprojection = 0;
            lprojection = 0;
            length = 0;
            wrap_gnorm = null;
            gnormy = 0;
            gnormx = 0;
            wrap_lnorm = null;
            lnormy = 0;
            lnormx = 0;
            outer = null;
            polygon = null;
            next = null;
            lnormx = 0;
            lnormy = 0;
            gnormx = 0;
            gnormy = 0;
            length = 0;
            lprojection = 0;
            gprojection = 0;
            return;
        }// end function

        public function wrapper() : Edge
        {
            if (outer == null)
            {
                ZPP_Edge.internal = true;
                outer = new Edge();
                ZPP_Edge.internal = false;
                outer.zpp_inner = this;
            }
            return outer;
        }// end function

        public function lnorm_validate() : void
        {
            if (polygon == null)
            {
                throw "Error: Edge not currently in use";
            }
            polygon.validate_laxi();
            wrap_lnorm.zpp_inner.x = lnormx;
            wrap_lnorm.zpp_inner.y = lnormy;
            return;
        }// end function

        public function gnorm_validate() : void
        {
            var _loc_2:* = null as ZPP_Body;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZNPNode_ZPP_Edge;
            var _loc_8:* = null as ZPP_Edge;
            if (polygon == null)
            {
                throw "Error: Edge not currently in use";
            }
            if (polygon.body == null)
            {
                throw "Error: Edge worldNormal only makes sense if the parent Polygon is contained within a rigid body";
            }
            var _loc_1:* = polygon;
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
            wrap_gnorm.zpp_inner.x = gnormx;
            wrap_gnorm.zpp_inner.y = gnormy;
            return;
        }// end function

        public function getlnorm() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = lnormx;
            var _loc_2:* = lnormy;
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
            wrap_lnorm = _loc_4;
            wrap_lnorm.zpp_inner._immutable = true;
            wrap_lnorm.zpp_inner._validate = lnorm_validate;
            return;
        }// end function

        public function getgnorm() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = gnormx;
            var _loc_2:* = gnormy;
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
            wrap_gnorm = _loc_4;
            wrap_gnorm.zpp_inner._immutable = true;
            wrap_gnorm.zpp_inner._validate = gnorm_validate;
            return;
        }// end function

        public function free() : void
        {
            polygon = null;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
