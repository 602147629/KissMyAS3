package zpp_nape.geom
{
    import nape.*;
    import nape.geom.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_Collide extends Object
    {
        public static var init__:Boolean;
        public static var flowpoly:ZNPList_ZPP_Vec2;
        public static var flowsegs:ZNPList_ZPP_Vec2;

        public function ZPP_Collide() : void
        {
            return;
        }// end function

        public static function circleContains(param1:ZPP_Circle, param2:ZPP_Vec2) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_3 = param2.x - param1.worldCOMx;
            _loc_4 = param2.y - param1.worldCOMy;
            return _loc_3 * _loc_3 + _loc_4 * _loc_4 < param1.radius * param1.radius;
        }// end function

        public static function polyContains(param1:ZPP_Polygon, param2:ZPP_Vec2) : Boolean
        {
            var _loc_5:* = null as ZPP_Edge;
            var _loc_3:* = true;
            var _loc_4:* = param1.edges.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                if (_loc_5.gnormx * param2.x + _loc_5.gnormy * param2.y <= _loc_5.gprojection)
                {
                    _loc_4 = _loc_4.next;
                    continue;
                }
                else
                {
                    _loc_3 = false;
                    break;
                }
                _loc_4 = _loc_4.next;
            }
            return _loc_3;
        }// end function

        public static function shapeContains(param1:ZPP_Shape, param2:ZPP_Vec2) : Boolean
        {
            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                return ZPP_Collide.circleContains(param1.circle, param2);
            }
            else
            {
                return ZPP_Collide.polyContains(param1.polygon, param2);
            }
        }// end function

        public static function bodyContains(param1:ZPP_Body, param2:ZPP_Vec2) : Boolean
        {
            var _loc_5:* = null as ZPP_Shape;
            var _loc_3:* = false;
            var _loc_4:* = param1.shapes.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                if (ZPP_Collide.shapeContains(_loc_5, param2))
                {
                    _loc_3 = true;
                    break;
                }
                _loc_4 = _loc_4.next;
            }
            return _loc_3;
        }// end function

        public static function containTest(param1:ZPP_Shape, param2:ZPP_Shape) : Boolean
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = false;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZNPNode_ZPP_Edge;
            var _loc_13:* = null as ZPP_Edge;
            var _loc_3:* = param1.aabb;
            var _loc_4:* = param2.aabb;
            if (_loc_4.minx >= _loc_3.minx)
            {
            }
            if (_loc_4.miny >= _loc_3.miny)
            {
            }
            if (_loc_4.maxx <= _loc_3.maxx)
            {
            }
            if (_loc_4.maxy <= _loc_3.maxy)
            {
                if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    if (param2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_5 = param1.circle.radius + (-param2.circle.radius);
                        _loc_6 = 0;
                        _loc_7 = 0;
                        _loc_6 = param2.circle.worldCOMx - param1.circle.worldCOMx;
                        _loc_7 = param2.circle.worldCOMy - param1.circle.worldCOMy;
                        _loc_8 = _loc_6 * _loc_6 + _loc_7 * _loc_7;
                        return _loc_8 <= _loc_5 * _loc_5;
                    }
                    else
                    {
                        _loc_9 = true;
                        _loc_10 = param2.polygon.gverts.next;
                        while (_loc_10 != null)
                        {
                            
                            _loc_11 = _loc_10;
                            _loc_5 = param1.circle.radius;
                            _loc_6 = 0;
                            _loc_7 = 0;
                            _loc_6 = _loc_11.x - param1.circle.worldCOMx;
                            _loc_7 = _loc_11.y - param1.circle.worldCOMy;
                            _loc_8 = _loc_6 * _loc_6 + _loc_7 * _loc_7;
                            if (_loc_8 <= _loc_5 * _loc_5)
                            {
                                _loc_10 = _loc_10.next;
                                continue;
                            }
                            else
                            {
                                _loc_9 = false;
                                break;
                            }
                            _loc_10 = _loc_10.next;
                        }
                        return _loc_9;
                    }
                }
                else if (param2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    _loc_9 = true;
                    _loc_12 = param1.polygon.edges.head;
                    while (_loc_12 != null)
                    {
                        
                        _loc_13 = _loc_12.elt;
                        if (_loc_13.gnormx * param2.circle.worldCOMx + _loc_13.gnormy * param2.circle.worldCOMy + param2.circle.radius <= _loc_13.gprojection)
                        {
                            _loc_12 = _loc_12.next;
                            continue;
                        }
                        else
                        {
                            _loc_9 = false;
                            break;
                        }
                        _loc_12 = _loc_12.next;
                    }
                    return _loc_9;
                }
                else
                {
                    _loc_9 = true;
                    _loc_12 = param1.polygon.edges.head;
                    while (_loc_12 != null)
                    {
                        
                        _loc_13 = _loc_12.elt;
                        _loc_5 = -1000000000000000000000000000000;
                        _loc_10 = param2.polygon.gverts.next;
                        while (_loc_10 != null)
                        {
                            
                            _loc_11 = _loc_10;
                            _loc_6 = _loc_13.gnormx * _loc_11.x + _loc_13.gnormy * _loc_11.y;
                            if (_loc_6 > _loc_5)
                            {
                                _loc_5 = _loc_6;
                            }
                            _loc_10 = _loc_10.next;
                        }
                        if (_loc_5 <= _loc_13.gprojection)
                        {
                            _loc_12 = _loc_12.next;
                            continue;
                        }
                        else
                        {
                            _loc_9 = false;
                            break;
                        }
                        _loc_12 = _loc_12.next;
                    }
                    return _loc_9;
                }
            }
            else
            {
                return false;
            }
        }// end function

        public static function contactCollide(param1:ZPP_Shape, param2:ZPP_Shape, param3:ZPP_ColArbiter, param4:Boolean) : Boolean
        {
            var _loc_5:* = false;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_9:* = null as ZPP_Edge;
            var _loc_10:* = null as ZPP_Edge;
            var _loc_11:* = null as ZNPNode_ZPP_Edge;
            var _loc_12:* = null as ZPP_Edge;
            var _loc_13:* = NaN;
            var _loc_14:* = null as ZPP_Vec2;
            var _loc_15:* = null as ZPP_Vec2;
            var _loc_16:* = NaN;
            var _loc_17:* = null as ZPP_Polygon;
            var _loc_18:* = null as ZPP_Polygon;
            var _loc_19:* = null as ZPP_Edge;
            var _loc_20:* = null as ZPP_Edge;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = null as ZPP_Contact;
            var _loc_37:* = 0;
            var _loc_38:* = null as ZPP_Contact;
            var _loc_39:* = null as ZPP_Contact;
            var _loc_40:* = null as ZPP_Contact;
            var _loc_41:* = null as ZPP_IContact;
            var _loc_42:* = NaN;
            var _loc_43:* = null as ZPP_Vec2;
            var _loc_44:* = null as ZPP_Vec2;
            var _loc_45:* = false;
            if (param2.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
                if (param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_5 = true;
                    _loc_6 = -1000000000000000000000000000000;
                    _loc_7 = -1000000000000000000000000000000;
                    _loc_8 = -1;
                    _loc_9 = null;
                    _loc_10 = null;
                    _loc_11 = param1.polygon.edges.head;
                    while (_loc_11 != null)
                    {
                        
                        _loc_12 = _loc_11.elt;
                        _loc_13 = 1000000000000000000000000000000;
                        _loc_14 = param2.polygon.gverts.next;
                        while (_loc_14 != null)
                        {
                            
                            _loc_15 = _loc_14;
                            _loc_16 = _loc_12.gnormx * _loc_15.x + _loc_12.gnormy * _loc_15.y;
                            if (_loc_16 < _loc_13)
                            {
                                _loc_13 = _loc_16;
                            }
                            if (_loc_13 - _loc_12.gprojection <= _loc_6)
                            {
                                break;
                            }
                            _loc_14 = _loc_14.next;
                        }
                        _loc_13 = _loc_13 - _loc_12.gprojection;
                        if (_loc_13 >= 0)
                        {
                            _loc_5 = false;
                            break;
                        }
                        if (_loc_13 > _loc_6)
                        {
                            _loc_6 = _loc_13;
                            _loc_9 = _loc_12;
                            _loc_8 = 1;
                        }
                        _loc_11 = _loc_11.next;
                    }
                    if (_loc_5)
                    {
                        _loc_11 = param2.polygon.edges.head;
                        while (_loc_11 != null)
                        {
                            
                            _loc_12 = _loc_11.elt;
                            _loc_13 = 1000000000000000000000000000000;
                            _loc_14 = param1.polygon.gverts.next;
                            while (_loc_14 != null)
                            {
                                
                                _loc_15 = _loc_14;
                                _loc_16 = _loc_12.gnormx * _loc_15.x + _loc_12.gnormy * _loc_15.y;
                                if (_loc_16 < _loc_13)
                                {
                                    _loc_13 = _loc_16;
                                }
                                if (_loc_13 - _loc_12.gprojection <= _loc_6)
                                {
                                    break;
                                }
                                _loc_14 = _loc_14.next;
                            }
                            _loc_13 = _loc_13 - _loc_12.gprojection;
                            if (_loc_13 >= 0)
                            {
                                _loc_5 = false;
                                break;
                            }
                            if (_loc_13 > _loc_6)
                            {
                                _loc_6 = _loc_13;
                                _loc_10 = _loc_12;
                                _loc_8 = 2;
                            }
                            _loc_11 = _loc_11.next;
                        }
                        if (!_loc_5)
                        {
                            return false;
                        }
                        else
                        {
                            if (_loc_8 == 1)
                            {
                                _loc_17 = param1.polygon;
                                _loc_18 = param2.polygon;
                                _loc_12 = _loc_9;
                                _loc_13 = 1;
                            }
                            else
                            {
                                _loc_17 = param2.polygon;
                                _loc_18 = param1.polygon;
                                _loc_12 = _loc_10;
                                _loc_13 = -1;
                            }
                            _loc_19 = null;
                            _loc_16 = 1000000000000000000000000000000;
                            _loc_11 = _loc_18.edges.head;
                            while (_loc_11 != null)
                            {
                                
                                _loc_20 = _loc_11.elt;
                                _loc_21 = _loc_12.gnormx * _loc_20.gnormx + _loc_12.gnormy * _loc_20.gnormy;
                                if (_loc_21 < _loc_16)
                                {
                                    _loc_16 = _loc_21;
                                    _loc_19 = _loc_20;
                                }
                                _loc_11 = _loc_11.next;
                            }
                            _loc_21 = 0;
                            _loc_22 = 0;
                            _loc_21 = _loc_19.gp0.x;
                            _loc_22 = _loc_19.gp0.y;
                            _loc_23 = 0;
                            _loc_24 = 0;
                            _loc_23 = _loc_19.gp1.x;
                            _loc_24 = _loc_19.gp1.y;
                            _loc_25 = 0;
                            _loc_26 = 0;
                            _loc_25 = _loc_23 - _loc_21;
                            _loc_26 = _loc_24 - _loc_22;
                            _loc_27 = _loc_12.gnormy * _loc_21 - _loc_12.gnormx * _loc_22;
                            _loc_28 = _loc_12.gnormy * _loc_23 - _loc_12.gnormx * _loc_24;
                            _loc_29 = 1 / (_loc_28 - _loc_27);
                            _loc_30 = (-_loc_12.tp1 - _loc_27) * _loc_29;
                            if (_loc_30 > Config.epsilon)
                            {
                                _loc_31 = _loc_30;
                                _loc_21 = _loc_21 + _loc_25 * _loc_31;
                                _loc_22 = _loc_22 + _loc_26 * _loc_31;
                            }
                            _loc_31 = (-_loc_12.tp0 - _loc_28) * _loc_29;
                            if (_loc_31 < -Config.epsilon)
                            {
                                _loc_32 = _loc_31;
                                _loc_23 = _loc_23 + _loc_25 * _loc_32;
                                _loc_24 = _loc_24 + _loc_26 * _loc_32;
                            }
                            _loc_32 = 0;
                            _loc_33 = 0;
                            _loc_34 = _loc_13;
                            _loc_32 = _loc_12.gnormx * _loc_34;
                            _loc_33 = _loc_12.gnormy * _loc_34;
                            param3.lnormx = _loc_12.lnormx;
                            param3.lnormy = _loc_12.lnormy;
                            param3.lproj = _loc_12.lprojection;
                            param3.radius = 0;
                            param3.rev = param4 != (_loc_13 == -1);
                            if (param3.rev)
                            {
                                param3.ptype = 1;
                            }
                            else
                            {
                                param3.ptype = 0;
                            }
                            _loc_34 = _loc_21 * _loc_12.gnormx + _loc_22 * _loc_12.gnormy - _loc_12.gprojection;
                            _loc_35 = _loc_23 * _loc_12.gnormx + _loc_24 * _loc_12.gnormy - _loc_12.gprojection;
                            if (_loc_34 > 0)
                            {
                            }
                            if (_loc_35 > 0)
                            {
                                return false;
                            }
                            else
                            {
                                if (param4)
                                {
                                    _loc_32 = -_loc_32;
                                    _loc_33 = -_loc_33;
                                }
                                if (param3.rev)
                                {
                                    _loc_37 = 1;
                                }
                                else
                                {
                                    _loc_37 = 0;
                                }
                                _loc_38 = null;
                                _loc_39 = param3.contacts.next;
                                while (_loc_39 != null)
                                {
                                    
                                    _loc_40 = _loc_39;
                                    if (_loc_37 == _loc_40.hash)
                                    {
                                        _loc_38 = _loc_40;
                                        break;
                                    }
                                    _loc_39 = _loc_39.next;
                                }
                                if (_loc_38 == null)
                                {
                                    if (ZPP_Contact.zpp_pool == null)
                                    {
                                        _loc_38 = new ZPP_Contact();
                                    }
                                    else
                                    {
                                        _loc_38 = ZPP_Contact.zpp_pool;
                                        ZPP_Contact.zpp_pool = _loc_38.next;
                                        _loc_38.next = null;
                                    }
                                    _loc_41 = _loc_38.inner;
                                    _loc_42 = 0;
                                    _loc_41.jtAcc = _loc_42;
                                    _loc_41.jnAcc = _loc_42;
                                    _loc_38.hash = _loc_37;
                                    _loc_38.fresh = true;
                                    _loc_38.arbiter = param3;
                                    param3.jrAcc = 0;
                                    _loc_39 = param3.contacts;
                                    _loc_38._inuse = true;
                                    _loc_40 = _loc_38;
                                    _loc_40.next = _loc_39.next;
                                    _loc_39.next = _loc_40;
                                    _loc_39.modified = true;
                                    (_loc_39.length + 1);
                                    param3.innards.add(_loc_41);
                                }
                                else
                                {
                                    _loc_38.fresh = false;
                                }
                                _loc_38.px = _loc_21 - _loc_12.gnormx * _loc_34 * 0.5;
                                _loc_38.py = _loc_22 - _loc_12.gnormy * _loc_34 * 0.5;
                                param3.nx = _loc_32;
                                param3.ny = _loc_33;
                                _loc_38.dist = _loc_34;
                                _loc_38.stamp = param3.stamp;
                                _loc_38.posOnly = _loc_34 > 0;
                                _loc_36 = _loc_38;
                                _loc_42 = 1;
                                _loc_21 = _loc_21 - _loc_18.body.posx * _loc_42;
                                _loc_22 = _loc_22 - _loc_18.body.posy * _loc_42;
                                _loc_36.inner.lr1x = _loc_21 * _loc_18.body.axisy + _loc_22 * _loc_18.body.axisx;
                                _loc_36.inner.lr1y = _loc_22 * _loc_18.body.axisy - _loc_21 * _loc_18.body.axisx;
                                if (param3.rev)
                                {
                                    _loc_37 = 0;
                                }
                                else
                                {
                                    _loc_37 = 1;
                                }
                                _loc_38 = null;
                                _loc_39 = param3.contacts.next;
                                while (_loc_39 != null)
                                {
                                    
                                    _loc_40 = _loc_39;
                                    if (_loc_37 == _loc_40.hash)
                                    {
                                        _loc_38 = _loc_40;
                                        break;
                                    }
                                    _loc_39 = _loc_39.next;
                                }
                                if (_loc_38 == null)
                                {
                                    if (ZPP_Contact.zpp_pool == null)
                                    {
                                        _loc_38 = new ZPP_Contact();
                                    }
                                    else
                                    {
                                        _loc_38 = ZPP_Contact.zpp_pool;
                                        ZPP_Contact.zpp_pool = _loc_38.next;
                                        _loc_38.next = null;
                                    }
                                    _loc_41 = _loc_38.inner;
                                    _loc_42 = 0;
                                    _loc_41.jtAcc = _loc_42;
                                    _loc_41.jnAcc = _loc_42;
                                    _loc_38.hash = _loc_37;
                                    _loc_38.fresh = true;
                                    _loc_38.arbiter = param3;
                                    param3.jrAcc = 0;
                                    _loc_39 = param3.contacts;
                                    _loc_38._inuse = true;
                                    _loc_40 = _loc_38;
                                    _loc_40.next = _loc_39.next;
                                    _loc_39.next = _loc_40;
                                    _loc_39.modified = true;
                                    (_loc_39.length + 1);
                                    param3.innards.add(_loc_41);
                                }
                                else
                                {
                                    _loc_38.fresh = false;
                                }
                                _loc_38.px = _loc_23 - _loc_12.gnormx * _loc_35 * 0.5;
                                _loc_38.py = _loc_24 - _loc_12.gnormy * _loc_35 * 0.5;
                                param3.nx = _loc_32;
                                param3.ny = _loc_33;
                                _loc_38.dist = _loc_35;
                                _loc_38.stamp = param3.stamp;
                                _loc_38.posOnly = _loc_35 > 0;
                                _loc_36 = _loc_38;
                                _loc_42 = 1;
                                _loc_23 = _loc_23 - _loc_18.body.posx * _loc_42;
                                _loc_24 = _loc_24 - _loc_18.body.posy * _loc_42;
                                _loc_36.inner.lr1x = _loc_23 * _loc_18.body.axisy + _loc_24 * _loc_18.body.axisx;
                                _loc_36.inner.lr1y = _loc_24 * _loc_18.body.axisy - _loc_23 * _loc_18.body.axisx;
                                if (_loc_8 == 1)
                                {
                                    param3.__ref_edge1 = _loc_12;
                                    param3.__ref_edge2 = _loc_19;
                                }
                                else
                                {
                                    param3.__ref_edge2 = _loc_12;
                                    param3.__ref_edge1 = _loc_19;
                                }
                                return true;
                            }
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    _loc_6 = -1000000000000000000000000000000;
                    _loc_7 = -1000000000000000000000000000000;
                    _loc_5 = true;
                    _loc_9 = null;
                    _loc_14 = null;
                    _loc_15 = param2.polygon.gverts.next;
                    _loc_11 = param2.polygon.edges.head;
                    while (_loc_11 != null)
                    {
                        
                        _loc_10 = _loc_11.elt;
                        _loc_13 = _loc_10.gnormx * param1.circle.worldCOMx + _loc_10.gnormy * param1.circle.worldCOMy - _loc_10.gprojection - param1.circle.radius;
                        if (_loc_13 > 0)
                        {
                            _loc_5 = false;
                            break;
                        }
                        if (_loc_13 > _loc_6)
                        {
                            _loc_6 = _loc_13;
                            _loc_9 = _loc_10;
                            _loc_14 = _loc_15;
                        }
                        _loc_15 = _loc_15.next;
                        _loc_11 = _loc_11.next;
                    }
                    if (_loc_5)
                    {
                        _loc_43 = _loc_14;
                        if (_loc_14.next == null)
                        {
                            _loc_44 = param2.polygon.gverts.next;
                        }
                        else
                        {
                            _loc_44 = _loc_14.next;
                        }
                        _loc_13 = param1.circle.worldCOMy * _loc_9.gnormx - param1.circle.worldCOMx * _loc_9.gnormy;
                        if (_loc_13 <= _loc_43.y * _loc_9.gnormx - _loc_43.x * _loc_9.gnormy)
                        {
                            _loc_16 = param1.circle.radius;
                            _loc_21 = 0;
                            _loc_22 = 0;
                            _loc_21 = _loc_43.x - param1.circle.worldCOMx;
                            _loc_22 = _loc_43.y - param1.circle.worldCOMy;
                            _loc_23 = _loc_21 * _loc_21 + _loc_22 * _loc_22;
                            if (_loc_23 > _loc_16 * _loc_16)
                            {
                                _loc_36 = null;
                            }
                            else if (_loc_23 < Config.epsilon * Config.epsilon)
                            {
                                _loc_45 = false;
                                _loc_38 = null;
                                _loc_39 = param3.contacts.next;
                                while (_loc_39 != null)
                                {
                                    
                                    _loc_40 = _loc_39;
                                    if (_loc_40.hash == 0)
                                    {
                                        _loc_38 = _loc_40;
                                        break;
                                    }
                                    _loc_39 = _loc_39.next;
                                }
                                if (_loc_38 == null)
                                {
                                    if (ZPP_Contact.zpp_pool == null)
                                    {
                                        _loc_38 = new ZPP_Contact();
                                    }
                                    else
                                    {
                                        _loc_38 = ZPP_Contact.zpp_pool;
                                        ZPP_Contact.zpp_pool = _loc_38.next;
                                        _loc_38.next = null;
                                    }
                                    _loc_41 = _loc_38.inner;
                                    _loc_24 = 0;
                                    _loc_41.jtAcc = _loc_24;
                                    _loc_41.jnAcc = _loc_24;
                                    _loc_38.hash = 0;
                                    _loc_38.fresh = true;
                                    _loc_38.arbiter = param3;
                                    param3.jrAcc = 0;
                                    _loc_39 = param3.contacts;
                                    _loc_38._inuse = true;
                                    _loc_40 = _loc_38;
                                    _loc_40.next = _loc_39.next;
                                    _loc_39.next = _loc_40;
                                    _loc_39.modified = true;
                                    (_loc_39.length + 1);
                                    param3.innards.add(_loc_41);
                                }
                                else
                                {
                                    _loc_38.fresh = false;
                                }
                                _loc_38.px = param1.circle.worldCOMx;
                                _loc_38.py = param1.circle.worldCOMy;
                                param3.nx = 1;
                                param3.ny = 0;
                                _loc_38.dist = -_loc_16;
                                _loc_38.stamp = param3.stamp;
                                _loc_38.posOnly = _loc_45;
                                _loc_36 = _loc_38;
                            }
                            else
                            {
                                _loc_8 = 1597463007 - (0 >> 1);
                                _loc_25 = 0;
                                _loc_24 = _loc_25 * (1.5 - 0.5 * _loc_23 * _loc_25 * _loc_25);
                                if (_loc_24 < Config.epsilon)
                                {
                                    _loc_25 = 1000000000000000000000000000000;
                                }
                                else
                                {
                                    _loc_25 = 1 / _loc_24;
                                }
                                _loc_26 = 0.5 + (param1.circle.radius - 0.5 * _loc_16) * _loc_24;
                                if (param4)
                                {
                                    _loc_45 = false;
                                    _loc_38 = null;
                                    _loc_39 = param3.contacts.next;
                                    while (_loc_39 != null)
                                    {
                                        
                                        _loc_40 = _loc_39;
                                        if (_loc_40.hash == 0)
                                        {
                                            _loc_38 = _loc_40;
                                            break;
                                        }
                                        _loc_39 = _loc_39.next;
                                    }
                                    if (_loc_38 == null)
                                    {
                                        if (ZPP_Contact.zpp_pool == null)
                                        {
                                            _loc_38 = new ZPP_Contact();
                                        }
                                        else
                                        {
                                            _loc_38 = ZPP_Contact.zpp_pool;
                                            ZPP_Contact.zpp_pool = _loc_38.next;
                                            _loc_38.next = null;
                                        }
                                        _loc_41 = _loc_38.inner;
                                        _loc_27 = 0;
                                        _loc_41.jtAcc = _loc_27;
                                        _loc_41.jnAcc = _loc_27;
                                        _loc_38.hash = 0;
                                        _loc_38.fresh = true;
                                        _loc_38.arbiter = param3;
                                        param3.jrAcc = 0;
                                        _loc_39 = param3.contacts;
                                        _loc_38._inuse = true;
                                        _loc_40 = _loc_38;
                                        _loc_40.next = _loc_39.next;
                                        _loc_39.next = _loc_40;
                                        _loc_39.modified = true;
                                        (_loc_39.length + 1);
                                        param3.innards.add(_loc_41);
                                    }
                                    else
                                    {
                                        _loc_38.fresh = false;
                                    }
                                    _loc_38.px = param1.circle.worldCOMx + _loc_21 * _loc_26;
                                    _loc_38.py = param1.circle.worldCOMy + _loc_22 * _loc_26;
                                    param3.nx = (-_loc_21) * _loc_24;
                                    param3.ny = (-_loc_22) * _loc_24;
                                    _loc_38.dist = _loc_25 - _loc_16;
                                    _loc_38.stamp = param3.stamp;
                                    _loc_38.posOnly = _loc_45;
                                    _loc_36 = _loc_38;
                                }
                                else
                                {
                                    _loc_45 = false;
                                    _loc_38 = null;
                                    _loc_39 = param3.contacts.next;
                                    while (_loc_39 != null)
                                    {
                                        
                                        _loc_40 = _loc_39;
                                        if (_loc_40.hash == 0)
                                        {
                                            _loc_38 = _loc_40;
                                            break;
                                        }
                                        _loc_39 = _loc_39.next;
                                    }
                                    if (_loc_38 == null)
                                    {
                                        if (ZPP_Contact.zpp_pool == null)
                                        {
                                            _loc_38 = new ZPP_Contact();
                                        }
                                        else
                                        {
                                            _loc_38 = ZPP_Contact.zpp_pool;
                                            ZPP_Contact.zpp_pool = _loc_38.next;
                                            _loc_38.next = null;
                                        }
                                        _loc_41 = _loc_38.inner;
                                        _loc_27 = 0;
                                        _loc_41.jtAcc = _loc_27;
                                        _loc_41.jnAcc = _loc_27;
                                        _loc_38.hash = 0;
                                        _loc_38.fresh = true;
                                        _loc_38.arbiter = param3;
                                        param3.jrAcc = 0;
                                        _loc_39 = param3.contacts;
                                        _loc_38._inuse = true;
                                        _loc_40 = _loc_38;
                                        _loc_40.next = _loc_39.next;
                                        _loc_39.next = _loc_40;
                                        _loc_39.modified = true;
                                        (_loc_39.length + 1);
                                        param3.innards.add(_loc_41);
                                    }
                                    else
                                    {
                                        _loc_38.fresh = false;
                                    }
                                    _loc_38.px = param1.circle.worldCOMx + _loc_21 * _loc_26;
                                    _loc_38.py = param1.circle.worldCOMy + _loc_22 * _loc_26;
                                    param3.nx = _loc_21 * _loc_24;
                                    param3.ny = _loc_22 * _loc_24;
                                    _loc_38.dist = _loc_25 - _loc_16;
                                    _loc_38.stamp = param3.stamp;
                                    _loc_38.posOnly = _loc_45;
                                    _loc_36 = _loc_38;
                                }
                            }
                            if (_loc_36 != null)
                            {
                                _loc_41 = _loc_36.inner;
                                param3.ptype = 2;
                                _loc_16 = 0;
                                _loc_21 = 0;
                                _loc_16 = _loc_43.x - param2.polygon.body.posx;
                                _loc_21 = _loc_43.y - param2.polygon.body.posy;
                                param3.__ref_edge1 = _loc_9;
                                param3.__ref_vertex = -1;
                                if (param4)
                                {
                                    _loc_41.lr1x = _loc_16 * param2.polygon.body.axisy + _loc_21 * param2.polygon.body.axisx;
                                    _loc_41.lr1y = _loc_21 * param2.polygon.body.axisy - _loc_16 * param2.polygon.body.axisx;
                                    _loc_41.lr2x = param1.circle.localCOMx;
                                    _loc_41.lr2y = param1.circle.localCOMy;
                                }
                                else
                                {
                                    _loc_41.lr2x = _loc_16 * param2.polygon.body.axisy + _loc_21 * param2.polygon.body.axisx;
                                    _loc_41.lr2y = _loc_21 * param2.polygon.body.axisy - _loc_16 * param2.polygon.body.axisx;
                                    _loc_41.lr1x = param1.circle.localCOMx;
                                    _loc_41.lr1y = param1.circle.localCOMy;
                                }
                                param3.radius = param1.circle.radius;
                            }
                            return _loc_36 != null;
                        }
                        else if (_loc_13 >= _loc_44.y * _loc_9.gnormx - _loc_44.x * _loc_9.gnormy)
                        {
                            _loc_16 = param1.circle.radius;
                            _loc_21 = 0;
                            _loc_22 = 0;
                            _loc_21 = _loc_44.x - param1.circle.worldCOMx;
                            _loc_22 = _loc_44.y - param1.circle.worldCOMy;
                            _loc_23 = _loc_21 * _loc_21 + _loc_22 * _loc_22;
                            if (_loc_23 > _loc_16 * _loc_16)
                            {
                                _loc_36 = null;
                            }
                            else if (_loc_23 < Config.epsilon * Config.epsilon)
                            {
                                _loc_45 = false;
                                _loc_38 = null;
                                _loc_39 = param3.contacts.next;
                                while (_loc_39 != null)
                                {
                                    
                                    _loc_40 = _loc_39;
                                    if (_loc_40.hash == 0)
                                    {
                                        _loc_38 = _loc_40;
                                        break;
                                    }
                                    _loc_39 = _loc_39.next;
                                }
                                if (_loc_38 == null)
                                {
                                    if (ZPP_Contact.zpp_pool == null)
                                    {
                                        _loc_38 = new ZPP_Contact();
                                    }
                                    else
                                    {
                                        _loc_38 = ZPP_Contact.zpp_pool;
                                        ZPP_Contact.zpp_pool = _loc_38.next;
                                        _loc_38.next = null;
                                    }
                                    _loc_41 = _loc_38.inner;
                                    _loc_24 = 0;
                                    _loc_41.jtAcc = _loc_24;
                                    _loc_41.jnAcc = _loc_24;
                                    _loc_38.hash = 0;
                                    _loc_38.fresh = true;
                                    _loc_38.arbiter = param3;
                                    param3.jrAcc = 0;
                                    _loc_39 = param3.contacts;
                                    _loc_38._inuse = true;
                                    _loc_40 = _loc_38;
                                    _loc_40.next = _loc_39.next;
                                    _loc_39.next = _loc_40;
                                    _loc_39.modified = true;
                                    (_loc_39.length + 1);
                                    param3.innards.add(_loc_41);
                                }
                                else
                                {
                                    _loc_38.fresh = false;
                                }
                                _loc_38.px = param1.circle.worldCOMx;
                                _loc_38.py = param1.circle.worldCOMy;
                                param3.nx = 1;
                                param3.ny = 0;
                                _loc_38.dist = -_loc_16;
                                _loc_38.stamp = param3.stamp;
                                _loc_38.posOnly = _loc_45;
                                _loc_36 = _loc_38;
                            }
                            else
                            {
                                _loc_8 = 1597463007 - (0 >> 1);
                                _loc_25 = 0;
                                _loc_24 = _loc_25 * (1.5 - 0.5 * _loc_23 * _loc_25 * _loc_25);
                                if (_loc_24 < Config.epsilon)
                                {
                                    _loc_25 = 1000000000000000000000000000000;
                                }
                                else
                                {
                                    _loc_25 = 1 / _loc_24;
                                }
                                _loc_26 = 0.5 + (param1.circle.radius - 0.5 * _loc_16) * _loc_24;
                                if (param4)
                                {
                                    _loc_45 = false;
                                    _loc_38 = null;
                                    _loc_39 = param3.contacts.next;
                                    while (_loc_39 != null)
                                    {
                                        
                                        _loc_40 = _loc_39;
                                        if (_loc_40.hash == 0)
                                        {
                                            _loc_38 = _loc_40;
                                            break;
                                        }
                                        _loc_39 = _loc_39.next;
                                    }
                                    if (_loc_38 == null)
                                    {
                                        if (ZPP_Contact.zpp_pool == null)
                                        {
                                            _loc_38 = new ZPP_Contact();
                                        }
                                        else
                                        {
                                            _loc_38 = ZPP_Contact.zpp_pool;
                                            ZPP_Contact.zpp_pool = _loc_38.next;
                                            _loc_38.next = null;
                                        }
                                        _loc_41 = _loc_38.inner;
                                        _loc_27 = 0;
                                        _loc_41.jtAcc = _loc_27;
                                        _loc_41.jnAcc = _loc_27;
                                        _loc_38.hash = 0;
                                        _loc_38.fresh = true;
                                        _loc_38.arbiter = param3;
                                        param3.jrAcc = 0;
                                        _loc_39 = param3.contacts;
                                        _loc_38._inuse = true;
                                        _loc_40 = _loc_38;
                                        _loc_40.next = _loc_39.next;
                                        _loc_39.next = _loc_40;
                                        _loc_39.modified = true;
                                        (_loc_39.length + 1);
                                        param3.innards.add(_loc_41);
                                    }
                                    else
                                    {
                                        _loc_38.fresh = false;
                                    }
                                    _loc_38.px = param1.circle.worldCOMx + _loc_21 * _loc_26;
                                    _loc_38.py = param1.circle.worldCOMy + _loc_22 * _loc_26;
                                    param3.nx = (-_loc_21) * _loc_24;
                                    param3.ny = (-_loc_22) * _loc_24;
                                    _loc_38.dist = _loc_25 - _loc_16;
                                    _loc_38.stamp = param3.stamp;
                                    _loc_38.posOnly = _loc_45;
                                    _loc_36 = _loc_38;
                                }
                                else
                                {
                                    _loc_45 = false;
                                    _loc_38 = null;
                                    _loc_39 = param3.contacts.next;
                                    while (_loc_39 != null)
                                    {
                                        
                                        _loc_40 = _loc_39;
                                        if (_loc_40.hash == 0)
                                        {
                                            _loc_38 = _loc_40;
                                            break;
                                        }
                                        _loc_39 = _loc_39.next;
                                    }
                                    if (_loc_38 == null)
                                    {
                                        if (ZPP_Contact.zpp_pool == null)
                                        {
                                            _loc_38 = new ZPP_Contact();
                                        }
                                        else
                                        {
                                            _loc_38 = ZPP_Contact.zpp_pool;
                                            ZPP_Contact.zpp_pool = _loc_38.next;
                                            _loc_38.next = null;
                                        }
                                        _loc_41 = _loc_38.inner;
                                        _loc_27 = 0;
                                        _loc_41.jtAcc = _loc_27;
                                        _loc_41.jnAcc = _loc_27;
                                        _loc_38.hash = 0;
                                        _loc_38.fresh = true;
                                        _loc_38.arbiter = param3;
                                        param3.jrAcc = 0;
                                        _loc_39 = param3.contacts;
                                        _loc_38._inuse = true;
                                        _loc_40 = _loc_38;
                                        _loc_40.next = _loc_39.next;
                                        _loc_39.next = _loc_40;
                                        _loc_39.modified = true;
                                        (_loc_39.length + 1);
                                        param3.innards.add(_loc_41);
                                    }
                                    else
                                    {
                                        _loc_38.fresh = false;
                                    }
                                    _loc_38.px = param1.circle.worldCOMx + _loc_21 * _loc_26;
                                    _loc_38.py = param1.circle.worldCOMy + _loc_22 * _loc_26;
                                    param3.nx = _loc_21 * _loc_24;
                                    param3.ny = _loc_22 * _loc_24;
                                    _loc_38.dist = _loc_25 - _loc_16;
                                    _loc_38.stamp = param3.stamp;
                                    _loc_38.posOnly = _loc_45;
                                    _loc_36 = _loc_38;
                                }
                            }
                            if (_loc_36 != null)
                            {
                                _loc_41 = _loc_36.inner;
                                param3.ptype = 2;
                                _loc_16 = 0;
                                _loc_21 = 0;
                                _loc_16 = _loc_44.x - param2.polygon.body.posx;
                                _loc_21 = _loc_44.y - param2.polygon.body.posy;
                                param3.__ref_edge1 = _loc_9;
                                param3.__ref_vertex = 1;
                                if (param4)
                                {
                                    _loc_41.lr1x = _loc_16 * param2.polygon.body.axisy + _loc_21 * param2.polygon.body.axisx;
                                    _loc_41.lr1y = _loc_21 * param2.polygon.body.axisy - _loc_16 * param2.polygon.body.axisx;
                                    _loc_41.lr2x = param1.circle.localCOMx;
                                    _loc_41.lr2y = param1.circle.localCOMy;
                                }
                                else
                                {
                                    _loc_41.lr2x = _loc_16 * param2.polygon.body.axisy + _loc_21 * param2.polygon.body.axisx;
                                    _loc_41.lr2y = _loc_21 * param2.polygon.body.axisy - _loc_16 * param2.polygon.body.axisx;
                                    _loc_41.lr1x = param1.circle.localCOMx;
                                    _loc_41.lr1y = param1.circle.localCOMy;
                                }
                                param3.radius = param1.circle.radius;
                            }
                            return _loc_36 != null;
                        }
                        else
                        {
                            _loc_16 = 0;
                            _loc_21 = 0;
                            _loc_22 = param1.circle.radius + _loc_6 * 0.5;
                            _loc_16 = _loc_9.gnormx * _loc_22;
                            _loc_21 = _loc_9.gnormy * _loc_22;
                            _loc_22 = 0;
                            _loc_23 = 0;
                            _loc_22 = param1.circle.worldCOMx - _loc_16;
                            _loc_23 = param1.circle.worldCOMy - _loc_21;
                            if (param4)
                            {
                                _loc_45 = false;
                                _loc_38 = null;
                                _loc_39 = param3.contacts.next;
                                while (_loc_39 != null)
                                {
                                    
                                    _loc_40 = _loc_39;
                                    if (_loc_40.hash == 0)
                                    {
                                        _loc_38 = _loc_40;
                                        break;
                                    }
                                    _loc_39 = _loc_39.next;
                                }
                                if (_loc_38 == null)
                                {
                                    if (ZPP_Contact.zpp_pool == null)
                                    {
                                        _loc_38 = new ZPP_Contact();
                                    }
                                    else
                                    {
                                        _loc_38 = ZPP_Contact.zpp_pool;
                                        ZPP_Contact.zpp_pool = _loc_38.next;
                                        _loc_38.next = null;
                                    }
                                    _loc_41 = _loc_38.inner;
                                    _loc_24 = 0;
                                    _loc_41.jtAcc = _loc_24;
                                    _loc_41.jnAcc = _loc_24;
                                    _loc_38.hash = 0;
                                    _loc_38.fresh = true;
                                    _loc_38.arbiter = param3;
                                    param3.jrAcc = 0;
                                    _loc_39 = param3.contacts;
                                    _loc_38._inuse = true;
                                    _loc_40 = _loc_38;
                                    _loc_40.next = _loc_39.next;
                                    _loc_39.next = _loc_40;
                                    _loc_39.modified = true;
                                    (_loc_39.length + 1);
                                    param3.innards.add(_loc_41);
                                }
                                else
                                {
                                    _loc_38.fresh = false;
                                }
                                _loc_38.px = _loc_22;
                                _loc_38.py = _loc_23;
                                param3.nx = _loc_9.gnormx;
                                param3.ny = _loc_9.gnormy;
                                _loc_38.dist = _loc_6;
                                _loc_38.stamp = param3.stamp;
                                _loc_38.posOnly = _loc_45;
                                _loc_36 = _loc_38;
                            }
                            else
                            {
                                _loc_45 = false;
                                _loc_38 = null;
                                _loc_39 = param3.contacts.next;
                                while (_loc_39 != null)
                                {
                                    
                                    _loc_40 = _loc_39;
                                    if (_loc_40.hash == 0)
                                    {
                                        _loc_38 = _loc_40;
                                        break;
                                    }
                                    _loc_39 = _loc_39.next;
                                }
                                if (_loc_38 == null)
                                {
                                    if (ZPP_Contact.zpp_pool == null)
                                    {
                                        _loc_38 = new ZPP_Contact();
                                    }
                                    else
                                    {
                                        _loc_38 = ZPP_Contact.zpp_pool;
                                        ZPP_Contact.zpp_pool = _loc_38.next;
                                        _loc_38.next = null;
                                    }
                                    _loc_41 = _loc_38.inner;
                                    _loc_24 = 0;
                                    _loc_41.jtAcc = _loc_24;
                                    _loc_41.jnAcc = _loc_24;
                                    _loc_38.hash = 0;
                                    _loc_38.fresh = true;
                                    _loc_38.arbiter = param3;
                                    param3.jrAcc = 0;
                                    _loc_39 = param3.contacts;
                                    _loc_38._inuse = true;
                                    _loc_40 = _loc_38;
                                    _loc_40.next = _loc_39.next;
                                    _loc_39.next = _loc_40;
                                    _loc_39.modified = true;
                                    (_loc_39.length + 1);
                                    param3.innards.add(_loc_41);
                                }
                                else
                                {
                                    _loc_38.fresh = false;
                                }
                                _loc_38.px = _loc_22;
                                _loc_38.py = _loc_23;
                                param3.nx = -_loc_9.gnormx;
                                param3.ny = -_loc_9.gnormy;
                                _loc_38.dist = _loc_6;
                                _loc_38.stamp = param3.stamp;
                                _loc_38.posOnly = _loc_45;
                                _loc_36 = _loc_38;
                            }
                            if (param4)
                            {
                                param3.ptype = 0;
                            }
                            else
                            {
                                param3.ptype = 1;
                            }
                            param3.lnormx = _loc_9.lnormx;
                            param3.lnormy = _loc_9.lnormy;
                            param3.rev = !param4;
                            param3.lproj = _loc_9.lprojection;
                            param3.radius = param1.circle.radius;
                            _loc_36.inner.lr1x = param1.circle.localCOMx;
                            _loc_36.inner.lr1y = param1.circle.localCOMy;
                            param3.__ref_edge1 = _loc_9;
                            param3.__ref_vertex = 0;
                            return true;
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            else
            {
                _loc_6 = param1.circle.radius + param2.circle.radius;
                _loc_7 = 0;
                _loc_13 = 0;
                _loc_7 = param2.circle.worldCOMx - param1.circle.worldCOMx;
                _loc_13 = param2.circle.worldCOMy - param1.circle.worldCOMy;
                _loc_16 = _loc_7 * _loc_7 + _loc_13 * _loc_13;
                if (_loc_16 > _loc_6 * _loc_6)
                {
                    _loc_36 = null;
                }
                else if (_loc_16 < Config.epsilon * Config.epsilon)
                {
                    _loc_5 = false;
                    _loc_38 = null;
                    _loc_39 = param3.contacts.next;
                    while (_loc_39 != null)
                    {
                        
                        _loc_40 = _loc_39;
                        if (_loc_40.hash == 0)
                        {
                            _loc_38 = _loc_40;
                            break;
                        }
                        _loc_39 = _loc_39.next;
                    }
                    if (_loc_38 == null)
                    {
                        if (ZPP_Contact.zpp_pool == null)
                        {
                            _loc_38 = new ZPP_Contact();
                        }
                        else
                        {
                            _loc_38 = ZPP_Contact.zpp_pool;
                            ZPP_Contact.zpp_pool = _loc_38.next;
                            _loc_38.next = null;
                        }
                        _loc_41 = _loc_38.inner;
                        _loc_21 = 0;
                        _loc_41.jtAcc = _loc_21;
                        _loc_41.jnAcc = _loc_21;
                        _loc_38.hash = 0;
                        _loc_38.fresh = true;
                        _loc_38.arbiter = param3;
                        param3.jrAcc = 0;
                        _loc_39 = param3.contacts;
                        _loc_38._inuse = true;
                        _loc_40 = _loc_38;
                        _loc_40.next = _loc_39.next;
                        _loc_39.next = _loc_40;
                        _loc_39.modified = true;
                        (_loc_39.length + 1);
                        param3.innards.add(_loc_41);
                    }
                    else
                    {
                        _loc_38.fresh = false;
                    }
                    _loc_38.px = param1.circle.worldCOMx;
                    _loc_38.py = param1.circle.worldCOMy;
                    param3.nx = 1;
                    param3.ny = 0;
                    _loc_38.dist = -_loc_6;
                    _loc_38.stamp = param3.stamp;
                    _loc_38.posOnly = _loc_5;
                    _loc_36 = _loc_38;
                }
                else
                {
                    _loc_8 = 1597463007 - (0 >> 1);
                    _loc_22 = 0;
                    _loc_21 = _loc_22 * (1.5 - 0.5 * _loc_16 * _loc_22 * _loc_22);
                    if (_loc_21 < Config.epsilon)
                    {
                        _loc_22 = 1000000000000000000000000000000;
                    }
                    else
                    {
                        _loc_22 = 1 / _loc_21;
                    }
                    _loc_23 = 0.5 + (param1.circle.radius - 0.5 * _loc_6) * _loc_21;
                    if (param4)
                    {
                        _loc_5 = false;
                        _loc_38 = null;
                        _loc_39 = param3.contacts.next;
                        while (_loc_39 != null)
                        {
                            
                            _loc_40 = _loc_39;
                            if (_loc_40.hash == 0)
                            {
                                _loc_38 = _loc_40;
                                break;
                            }
                            _loc_39 = _loc_39.next;
                        }
                        if (_loc_38 == null)
                        {
                            if (ZPP_Contact.zpp_pool == null)
                            {
                                _loc_38 = new ZPP_Contact();
                            }
                            else
                            {
                                _loc_38 = ZPP_Contact.zpp_pool;
                                ZPP_Contact.zpp_pool = _loc_38.next;
                                _loc_38.next = null;
                            }
                            _loc_41 = _loc_38.inner;
                            _loc_24 = 0;
                            _loc_41.jtAcc = _loc_24;
                            _loc_41.jnAcc = _loc_24;
                            _loc_38.hash = 0;
                            _loc_38.fresh = true;
                            _loc_38.arbiter = param3;
                            param3.jrAcc = 0;
                            _loc_39 = param3.contacts;
                            _loc_38._inuse = true;
                            _loc_40 = _loc_38;
                            _loc_40.next = _loc_39.next;
                            _loc_39.next = _loc_40;
                            _loc_39.modified = true;
                            (_loc_39.length + 1);
                            param3.innards.add(_loc_41);
                        }
                        else
                        {
                            _loc_38.fresh = false;
                        }
                        _loc_38.px = param1.circle.worldCOMx + _loc_7 * _loc_23;
                        _loc_38.py = param1.circle.worldCOMy + _loc_13 * _loc_23;
                        param3.nx = (-_loc_7) * _loc_21;
                        param3.ny = (-_loc_13) * _loc_21;
                        _loc_38.dist = _loc_22 - _loc_6;
                        _loc_38.stamp = param3.stamp;
                        _loc_38.posOnly = _loc_5;
                        _loc_36 = _loc_38;
                    }
                    else
                    {
                        _loc_5 = false;
                        _loc_38 = null;
                        _loc_39 = param3.contacts.next;
                        while (_loc_39 != null)
                        {
                            
                            _loc_40 = _loc_39;
                            if (_loc_40.hash == 0)
                            {
                                _loc_38 = _loc_40;
                                break;
                            }
                            _loc_39 = _loc_39.next;
                        }
                        if (_loc_38 == null)
                        {
                            if (ZPP_Contact.zpp_pool == null)
                            {
                                _loc_38 = new ZPP_Contact();
                            }
                            else
                            {
                                _loc_38 = ZPP_Contact.zpp_pool;
                                ZPP_Contact.zpp_pool = _loc_38.next;
                                _loc_38.next = null;
                            }
                            _loc_41 = _loc_38.inner;
                            _loc_24 = 0;
                            _loc_41.jtAcc = _loc_24;
                            _loc_41.jnAcc = _loc_24;
                            _loc_38.hash = 0;
                            _loc_38.fresh = true;
                            _loc_38.arbiter = param3;
                            param3.jrAcc = 0;
                            _loc_39 = param3.contacts;
                            _loc_38._inuse = true;
                            _loc_40 = _loc_38;
                            _loc_40.next = _loc_39.next;
                            _loc_39.next = _loc_40;
                            _loc_39.modified = true;
                            (_loc_39.length + 1);
                            param3.innards.add(_loc_41);
                        }
                        else
                        {
                            _loc_38.fresh = false;
                        }
                        _loc_38.px = param1.circle.worldCOMx + _loc_7 * _loc_23;
                        _loc_38.py = param1.circle.worldCOMy + _loc_13 * _loc_23;
                        param3.nx = _loc_7 * _loc_21;
                        param3.ny = _loc_13 * _loc_21;
                        _loc_38.dist = _loc_22 - _loc_6;
                        _loc_38.stamp = param3.stamp;
                        _loc_38.posOnly = _loc_5;
                        _loc_36 = _loc_38;
                    }
                }
                if (_loc_36 != null)
                {
                    _loc_41 = _loc_36.inner;
                    if (param4)
                    {
                        _loc_41.lr1x = param2.circle.localCOMx;
                        _loc_41.lr1y = param2.circle.localCOMy;
                        _loc_41.lr2x = param1.circle.localCOMx;
                        _loc_41.lr2y = param1.circle.localCOMy;
                    }
                    else
                    {
                        _loc_41.lr1x = param1.circle.localCOMx;
                        _loc_41.lr1y = param1.circle.localCOMy;
                        _loc_41.lr2x = param2.circle.localCOMx;
                        _loc_41.lr2y = param2.circle.localCOMy;
                    }
                    param3.radius = param1.circle.radius + param2.circle.radius;
                    param3.ptype = 2;
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }// end function

        public static function testCollide_safe(param1:ZPP_Shape, param2:ZPP_Shape) : Boolean
        {
            var _loc_3:* = null as ZPP_Shape;
            if (param2.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                _loc_3 = param1;
                param1 = param2;
                param2 = _loc_3;
            }
            return ZPP_Collide.testCollide(param1, param2);
        }// end function

        public static function testCollide(param1:ZPP_Shape, param2:ZPP_Shape) : Boolean
        {
            var _loc_3:* = false;
            var _loc_4:* = null as ZNPNode_ZPP_Edge;
            var _loc_5:* = null as ZPP_Edge;
            var _loc_6:* = NaN;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = NaN;
            var _loc_10:* = null as ZPP_Edge;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            if (param2.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
                if (param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_3 = true;
                    _loc_4 = param1.polygon.edges.head;
                    while (_loc_4 != null)
                    {
                        
                        _loc_5 = _loc_4.elt;
                        _loc_6 = 1000000000000000000000000000000;
                        _loc_7 = param2.polygon.gverts.next;
                        while (_loc_7 != null)
                        {
                            
                            _loc_8 = _loc_7;
                            _loc_9 = _loc_5.gnormx * _loc_8.x + _loc_5.gnormy * _loc_8.y;
                            if (_loc_9 < _loc_6)
                            {
                                _loc_6 = _loc_9;
                            }
                            _loc_7 = _loc_7.next;
                        }
                        _loc_6 = _loc_6 - _loc_5.gprojection;
                        if (_loc_6 > 0)
                        {
                            _loc_3 = false;
                            break;
                        }
                        _loc_4 = _loc_4.next;
                    }
                    if (_loc_3)
                    {
                        _loc_4 = param2.polygon.edges.head;
                        while (_loc_4 != null)
                        {
                            
                            _loc_5 = _loc_4.elt;
                            _loc_6 = 1000000000000000000000000000000;
                            _loc_7 = param1.polygon.gverts.next;
                            while (_loc_7 != null)
                            {
                                
                                _loc_8 = _loc_7;
                                _loc_9 = _loc_5.gnormx * _loc_8.x + _loc_5.gnormy * _loc_8.y;
                                if (_loc_9 < _loc_6)
                                {
                                    _loc_6 = _loc_9;
                                }
                                _loc_7 = _loc_7.next;
                            }
                            _loc_6 = _loc_6 - _loc_5.gprojection;
                            if (_loc_6 > 0)
                            {
                                _loc_3 = false;
                                break;
                            }
                            _loc_4 = _loc_4.next;
                        }
                        return _loc_3;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    _loc_5 = null;
                    _loc_7 = null;
                    _loc_3 = true;
                    _loc_6 = -1000000000000000000000000000000;
                    _loc_8 = param2.polygon.gverts.next;
                    _loc_4 = param2.polygon.edges.head;
                    while (_loc_4 != null)
                    {
                        
                        _loc_10 = _loc_4.elt;
                        _loc_9 = _loc_10.gnormx * param1.circle.worldCOMx + _loc_10.gnormy * param1.circle.worldCOMy - _loc_10.gprojection - param1.circle.radius;
                        if (_loc_9 > 0)
                        {
                            _loc_3 = false;
                            break;
                        }
                        if (_loc_9 > _loc_6)
                        {
                            _loc_6 = _loc_9;
                            _loc_5 = _loc_10;
                            _loc_7 = _loc_8;
                        }
                        _loc_8 = _loc_8.next;
                        _loc_4 = _loc_4.next;
                    }
                    if (_loc_3)
                    {
                        _loc_11 = _loc_7;
                        if (_loc_7.next == null)
                        {
                            _loc_12 = param2.polygon.gverts.next;
                        }
                        else
                        {
                            _loc_12 = _loc_7.next;
                        }
                        _loc_9 = param1.circle.worldCOMy * _loc_5.gnormx - param1.circle.worldCOMx * _loc_5.gnormy;
                        if (_loc_9 <= _loc_11.y * _loc_5.gnormx - _loc_11.x * _loc_5.gnormy)
                        {
                            _loc_13 = param1.circle.radius;
                            _loc_14 = 0;
                            _loc_15 = 0;
                            _loc_14 = _loc_11.x - param1.circle.worldCOMx;
                            _loc_15 = _loc_11.y - param1.circle.worldCOMy;
                            _loc_16 = _loc_14 * _loc_14 + _loc_15 * _loc_15;
                            return _loc_16 <= _loc_13 * _loc_13;
                        }
                        else if (_loc_9 >= _loc_12.y * _loc_5.gnormx - _loc_12.x * _loc_5.gnormy)
                        {
                            _loc_13 = param1.circle.radius;
                            _loc_14 = 0;
                            _loc_15 = 0;
                            _loc_14 = _loc_12.x - param1.circle.worldCOMx;
                            _loc_15 = _loc_12.y - param1.circle.worldCOMy;
                            _loc_16 = _loc_14 * _loc_14 + _loc_15 * _loc_15;
                            return _loc_16 <= _loc_13 * _loc_13;
                        }
                        else
                        {
                            return true;
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            else
            {
                _loc_6 = param1.circle.radius + param2.circle.radius;
                _loc_9 = 0;
                _loc_13 = 0;
                _loc_9 = param2.circle.worldCOMx - param1.circle.worldCOMx;
                _loc_13 = param2.circle.worldCOMy - param1.circle.worldCOMy;
                _loc_14 = _loc_9 * _loc_9 + _loc_13 * _loc_13;
                return _loc_14 <= _loc_6 * _loc_6;
            }
        }// end function

        public static function flowCollide(param1:ZPP_Shape, param2:ZPP_Shape, param3:ZPP_FluidArbiter) : Boolean
        {
            var _loc_4:* = null as Array;
            var _loc_5:* = null as Array;
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = null as ZNPNode_ZPP_Edge;
            var _loc_9:* = null as ZPP_Edge;
            var _loc_10:* = NaN;
            var _loc_11:* = 0;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_13:* = null as ZPP_Vec2;
            var _loc_14:* = NaN;
            var _loc_15:* = null as ZPP_Polygon;
            var _loc_16:* = null as ZPP_Polygon;
            var _loc_17:* = null as ZPP_Vec2;
            var _loc_18:* = null as ZPP_Vec2;
            var _loc_19:* = null as ZPP_Vec2;
            var _loc_20:* = null as ZPP_Body;
            var _loc_21:* = false;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = false;
            var _loc_27:* = null as ZPP_Vec2;
            var _loc_28:* = null as ZPP_Vec2;
            var _loc_29:* = false;
            var _loc_30:* = null as ZPP_Vec2;
            var _loc_31:* = null as ZPP_Vec2;
            var _loc_32:* = null as ZPP_Vec2;
            var _loc_33:* = null as ZPP_Vec2;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = NaN;
            var _loc_40:* = NaN;
            var _loc_41:* = NaN;
            var _loc_42:* = NaN;
            var _loc_43:* = null as ZPP_Vec2;
            var _loc_44:* = null as ZNPNode_ZPP_Vec2;
            var _loc_45:* = null as ZPP_Edge;
            var _loc_46:* = NaN;
            var _loc_47:* = null as ZPP_Vec2;
            var _loc_48:* = NaN;
            var _loc_49:* = NaN;
            var _loc_50:* = NaN;
            var _loc_51:* = NaN;
            var _loc_52:* = NaN;
            var _loc_53:* = NaN;
            var _loc_54:* = null as ZPP_Circle;
            var _loc_55:* = null as ZPP_Circle;
            if (param2.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
                if (param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_4 = [];
                    _loc_5 = [];
                    _loc_6 = true;
                    _loc_7 = true;
                    _loc_8 = param1.polygon.edges.head;
                    while (_loc_8 != null)
                    {
                        
                        _loc_9 = _loc_8.elt;
                        _loc_10 = 1000000000000000000000000000000;
                        _loc_11 = 0;
                        _loc_12 = param2.polygon.gverts.next;
                        while (_loc_12 != null)
                        {
                            
                            _loc_13 = _loc_12;
                            _loc_14 = _loc_9.gnormx * _loc_13.x + _loc_9.gnormy * _loc_13.y;
                            if (_loc_14 < _loc_10)
                            {
                                _loc_10 = _loc_14;
                            }
                            if (_loc_14 >= _loc_9.gprojection + Config.epsilon)
                            {
                                _loc_5[_loc_11] = true;
                                _loc_7 = false;
                            }
                            _loc_11++;
                            _loc_12 = _loc_12.next;
                        }
                        _loc_10 = _loc_10 - _loc_9.gprojection;
                        if (_loc_10 > 0)
                        {
                            _loc_6 = false;
                            break;
                        }
                        _loc_8 = _loc_8.next;
                    }
                    if (_loc_7)
                    {
                        _loc_15 = param2.polygon;
                        if (_loc_15.zip_worldCOM)
                        {
                            if (_loc_15.body != null)
                            {
                                _loc_15.zip_worldCOM = false;
                                if (_loc_15.zip_localCOM)
                                {
                                    _loc_15.zip_localCOM = false;
                                    if (_loc_15.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                        _loc_16 = _loc_15.polygon;
                                        if (_loc_16.lverts.next == null)
                                        {
                                            throw "Error: An empty polygon has no meaningful localCOM";
                                        }
                                        if (_loc_16.lverts.next.next == null)
                                        {
                                            _loc_16.localCOMx = _loc_16.lverts.next.x;
                                            _loc_16.localCOMy = _loc_16.lverts.next.y;
                                        }
                                        else if (_loc_16.lverts.next.next.next == null)
                                        {
                                            _loc_16.localCOMx = _loc_16.lverts.next.x;
                                            _loc_16.localCOMy = _loc_16.lverts.next.y;
                                            _loc_10 = 1;
                                            _loc_16.localCOMx = _loc_16.localCOMx + _loc_16.lverts.next.next.x * _loc_10;
                                            _loc_16.localCOMy = _loc_16.localCOMy + _loc_16.lverts.next.next.y * _loc_10;
                                            _loc_10 = 0.5;
                                            _loc_16.localCOMx = _loc_16.localCOMx * _loc_10;
                                            _loc_16.localCOMy = _loc_16.localCOMy * _loc_10;
                                        }
                                        else
                                        {
                                            _loc_16.localCOMx = 0;
                                            _loc_16.localCOMy = 0;
                                            _loc_10 = 0;
                                            _loc_12 = _loc_16.lverts.next;
                                            _loc_13 = _loc_12;
                                            _loc_12 = _loc_12.next;
                                            _loc_17 = _loc_12;
                                            _loc_12 = _loc_12.next;
                                            while (_loc_12 != null)
                                            {
                                                
                                                _loc_18 = _loc_12;
                                                _loc_10 = _loc_10 + _loc_17.x * (_loc_18.y - _loc_13.y);
                                                _loc_14 = _loc_18.y * _loc_17.x - _loc_18.x * _loc_17.y;
                                                _loc_16.localCOMx = _loc_16.localCOMx + (_loc_17.x + _loc_18.x) * _loc_14;
                                                _loc_16.localCOMy = _loc_16.localCOMy + (_loc_17.y + _loc_18.y) * _loc_14;
                                                _loc_13 = _loc_17;
                                                _loc_17 = _loc_18;
                                                _loc_12 = _loc_12.next;
                                            }
                                            _loc_12 = _loc_16.lverts.next;
                                            _loc_18 = _loc_12;
                                            _loc_10 = _loc_10 + _loc_17.x * (_loc_18.y - _loc_13.y);
                                            _loc_14 = _loc_18.y * _loc_17.x - _loc_18.x * _loc_17.y;
                                            _loc_16.localCOMx = _loc_16.localCOMx + (_loc_17.x + _loc_18.x) * _loc_14;
                                            _loc_16.localCOMy = _loc_16.localCOMy + (_loc_17.y + _loc_18.y) * _loc_14;
                                            _loc_13 = _loc_17;
                                            _loc_17 = _loc_18;
                                            _loc_12 = _loc_12.next;
                                            _loc_19 = _loc_12;
                                            _loc_10 = _loc_10 + _loc_17.x * (_loc_19.y - _loc_13.y);
                                            _loc_14 = _loc_19.y * _loc_17.x - _loc_19.x * _loc_17.y;
                                            _loc_16.localCOMx = _loc_16.localCOMx + (_loc_17.x + _loc_19.x) * _loc_14;
                                            _loc_16.localCOMy = _loc_16.localCOMy + (_loc_17.y + _loc_19.y) * _loc_14;
                                            _loc_10 = 1 / (3 * _loc_10);
                                            _loc_14 = _loc_10;
                                            _loc_16.localCOMx = _loc_16.localCOMx * _loc_14;
                                            _loc_16.localCOMy = _loc_16.localCOMy * _loc_14;
                                        }
                                    }
                                    if (_loc_15.wrap_localCOM != null)
                                    {
                                        _loc_15.wrap_localCOM.zpp_inner.x = _loc_15.localCOMx;
                                        _loc_15.wrap_localCOM.zpp_inner.y = _loc_15.localCOMy;
                                    }
                                }
                                _loc_20 = _loc_15.body;
                                if (_loc_20.zip_axis)
                                {
                                    _loc_20.zip_axis = false;
                                    _loc_20.axisx = Math.sin(_loc_20.rot);
                                    _loc_20.axisy = Math.cos(_loc_20.rot);
                                }
                                _loc_15.worldCOMx = _loc_15.body.posx + (_loc_15.body.axisy * _loc_15.localCOMx - _loc_15.body.axisx * _loc_15.localCOMy);
                                _loc_15.worldCOMy = _loc_15.body.posy + (_loc_15.localCOMx * _loc_15.body.axisx + _loc_15.localCOMy * _loc_15.body.axisy);
                            }
                        }
                        param3.overlap = param2.polygon.area;
                        param3.centroidx = param2.polygon.worldCOMx;
                        param3.centroidy = param2.polygon.worldCOMy;
                        return true;
                    }
                    else if (_loc_6)
                    {
                        _loc_7 = true;
                        _loc_8 = param2.polygon.edges.head;
                        while (_loc_8 != null)
                        {
                            
                            _loc_9 = _loc_8.elt;
                            _loc_10 = 1000000000000000000000000000000;
                            _loc_11 = 0;
                            _loc_12 = param1.polygon.gverts.next;
                            while (_loc_12 != null)
                            {
                                
                                _loc_13 = _loc_12;
                                _loc_14 = _loc_9.gnormx * _loc_13.x + _loc_9.gnormy * _loc_13.y;
                                if (_loc_14 < _loc_10)
                                {
                                    _loc_10 = _loc_14;
                                }
                                if (_loc_14 >= _loc_9.gprojection + Config.epsilon)
                                {
                                    _loc_4[_loc_11] = true;
                                    _loc_7 = false;
                                }
                                _loc_11++;
                                _loc_12 = _loc_12.next;
                            }
                            _loc_10 = _loc_10 - _loc_9.gprojection;
                            if (_loc_10 > 0)
                            {
                                _loc_6 = false;
                                break;
                            }
                            _loc_8 = _loc_8.next;
                        }
                        if (_loc_7)
                        {
                            _loc_15 = param1.polygon;
                            if (_loc_15.zip_worldCOM)
                            {
                                if (_loc_15.body != null)
                                {
                                    _loc_15.zip_worldCOM = false;
                                    if (_loc_15.zip_localCOM)
                                    {
                                        _loc_15.zip_localCOM = false;
                                        if (_loc_15.type == ZPP_Flags.id_ShapeType_POLYGON)
                                        {
                                            _loc_16 = _loc_15.polygon;
                                            if (_loc_16.lverts.next == null)
                                            {
                                                throw "Error: An empty polygon has no meaningful localCOM";
                                            }
                                            if (_loc_16.lverts.next.next == null)
                                            {
                                                _loc_16.localCOMx = _loc_16.lverts.next.x;
                                                _loc_16.localCOMy = _loc_16.lverts.next.y;
                                            }
                                            else if (_loc_16.lverts.next.next.next == null)
                                            {
                                                _loc_16.localCOMx = _loc_16.lverts.next.x;
                                                _loc_16.localCOMy = _loc_16.lverts.next.y;
                                                _loc_10 = 1;
                                                _loc_16.localCOMx = _loc_16.localCOMx + _loc_16.lverts.next.next.x * _loc_10;
                                                _loc_16.localCOMy = _loc_16.localCOMy + _loc_16.lverts.next.next.y * _loc_10;
                                                _loc_10 = 0.5;
                                                _loc_16.localCOMx = _loc_16.localCOMx * _loc_10;
                                                _loc_16.localCOMy = _loc_16.localCOMy * _loc_10;
                                            }
                                            else
                                            {
                                                _loc_16.localCOMx = 0;
                                                _loc_16.localCOMy = 0;
                                                _loc_10 = 0;
                                                _loc_12 = _loc_16.lverts.next;
                                                _loc_13 = _loc_12;
                                                _loc_12 = _loc_12.next;
                                                _loc_17 = _loc_12;
                                                _loc_12 = _loc_12.next;
                                                while (_loc_12 != null)
                                                {
                                                    
                                                    _loc_18 = _loc_12;
                                                    _loc_10 = _loc_10 + _loc_17.x * (_loc_18.y - _loc_13.y);
                                                    _loc_14 = _loc_18.y * _loc_17.x - _loc_18.x * _loc_17.y;
                                                    _loc_16.localCOMx = _loc_16.localCOMx + (_loc_17.x + _loc_18.x) * _loc_14;
                                                    _loc_16.localCOMy = _loc_16.localCOMy + (_loc_17.y + _loc_18.y) * _loc_14;
                                                    _loc_13 = _loc_17;
                                                    _loc_17 = _loc_18;
                                                    _loc_12 = _loc_12.next;
                                                }
                                                _loc_12 = _loc_16.lverts.next;
                                                _loc_18 = _loc_12;
                                                _loc_10 = _loc_10 + _loc_17.x * (_loc_18.y - _loc_13.y);
                                                _loc_14 = _loc_18.y * _loc_17.x - _loc_18.x * _loc_17.y;
                                                _loc_16.localCOMx = _loc_16.localCOMx + (_loc_17.x + _loc_18.x) * _loc_14;
                                                _loc_16.localCOMy = _loc_16.localCOMy + (_loc_17.y + _loc_18.y) * _loc_14;
                                                _loc_13 = _loc_17;
                                                _loc_17 = _loc_18;
                                                _loc_12 = _loc_12.next;
                                                _loc_19 = _loc_12;
                                                _loc_10 = _loc_10 + _loc_17.x * (_loc_19.y - _loc_13.y);
                                                _loc_14 = _loc_19.y * _loc_17.x - _loc_19.x * _loc_17.y;
                                                _loc_16.localCOMx = _loc_16.localCOMx + (_loc_17.x + _loc_19.x) * _loc_14;
                                                _loc_16.localCOMy = _loc_16.localCOMy + (_loc_17.y + _loc_19.y) * _loc_14;
                                                _loc_10 = 1 / (3 * _loc_10);
                                                _loc_14 = _loc_10;
                                                _loc_16.localCOMx = _loc_16.localCOMx * _loc_14;
                                                _loc_16.localCOMy = _loc_16.localCOMy * _loc_14;
                                            }
                                        }
                                        if (_loc_15.wrap_localCOM != null)
                                        {
                                            _loc_15.wrap_localCOM.zpp_inner.x = _loc_15.localCOMx;
                                            _loc_15.wrap_localCOM.zpp_inner.y = _loc_15.localCOMy;
                                        }
                                    }
                                    _loc_20 = _loc_15.body;
                                    if (_loc_20.zip_axis)
                                    {
                                        _loc_20.zip_axis = false;
                                        _loc_20.axisx = Math.sin(_loc_20.rot);
                                        _loc_20.axisy = Math.cos(_loc_20.rot);
                                    }
                                    _loc_15.worldCOMx = _loc_15.body.posx + (_loc_15.body.axisy * _loc_15.localCOMx - _loc_15.body.axisx * _loc_15.localCOMy);
                                    _loc_15.worldCOMy = _loc_15.body.posy + (_loc_15.localCOMx * _loc_15.body.axisx + _loc_15.localCOMy * _loc_15.body.axisy);
                                }
                            }
                            param3.overlap = param1.polygon.area;
                            param3.centroidx = param1.polygon.worldCOMx;
                            param3.centroidy = param1.polygon.worldCOMy;
                            return true;
                        }
                        else if (_loc_6)
                        {
                            while (ZPP_Collide.flowpoly.head != null)
                            {
                                
                                _loc_12 = ZPP_Collide.flowpoly.pop_unsafe();
                                if (!_loc_12._inuse)
                                {
                                    _loc_13 = _loc_12;
                                    if (_loc_13.outer != null)
                                    {
                                        _loc_13.outer.zpp_inner = null;
                                        _loc_13.outer = null;
                                    }
                                    _loc_13._isimmutable = null;
                                    _loc_13._validate = null;
                                    _loc_13._invalidate = null;
                                    _loc_13.next = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_13;
                                }
                            }
                            _loc_12 = null;
                            _loc_21 = false;
                            _loc_13 = param1.polygon.gverts.next;
                            _loc_11 = 0;
                            _loc_17 = param2.polygon.gverts.next;
                            _loc_22 = 0;
                            _loc_23 = 0;
                            _loc_24 = param2.polygon.edgeCnt;
                            while (_loc_23 < _loc_24)
                            {
                                
                                _loc_23++;
                                _loc_25 = _loc_23;
                                if (!_loc_5[_loc_25])
                                {
                                    _loc_22 = _loc_25;
                                    break;
                                    continue;
                                }
                                _loc_17 = _loc_17.next;
                            }
                            if (_loc_17 == null)
                            {
                                _loc_17 = param2.polygon.gverts.next;
                                _loc_21 = true;
                                _loc_23 = 0;
                                _loc_24 = param1.polygon.edgeCnt;
                                while (_loc_23 < _loc_24)
                                {
                                    
                                    _loc_23++;
                                    _loc_25 = _loc_23;
                                    if (!_loc_4[_loc_25])
                                    {
                                        _loc_11 = _loc_25;
                                        break;
                                        continue;
                                    }
                                    _loc_13 = _loc_13.next;
                                }
                                if (_loc_13 == null)
                                {
                                    _loc_13 = param1.polygon.gverts.next;
                                }
                                else
                                {
                                    ZPP_Collide.flowpoly.add(_loc_13);
                                    _loc_12 = ZPP_Collide.flowpoly.head.elt;
                                }
                            }
                            else
                            {
                                ZPP_Collide.flowpoly.add(_loc_17);
                                _loc_12 = ZPP_Collide.flowpoly.head.elt;
                            }
                            _loc_23 = 1;
                            if (ZPP_Collide.flowpoly.head == null)
                            {
                                _loc_26 = true;
                                _loc_18 = param1.polygon.gverts.next;
                                _loc_19 = _loc_18;
                                _loc_27 = _loc_18.next;
                                while (_loc_27 != null)
                                {
                                    
                                    _loc_28 = _loc_27;
                                    _loc_10 = 2;
                                    _loc_29 = true;
                                    _loc_30 = param2.polygon.gverts.next;
                                    _loc_31 = _loc_30;
                                    _loc_32 = _loc_30.next;
                                    while (_loc_32 != null)
                                    {
                                        
                                        _loc_33 = _loc_32;
                                        _loc_14 = 0;
                                        _loc_34 = 0;
                                        _loc_35 = 0;
                                        _loc_34 = _loc_19.x - _loc_31.x;
                                        _loc_35 = _loc_19.y - _loc_31.y;
                                        _loc_36 = 0;
                                        _loc_37 = 0;
                                        _loc_36 = _loc_28.x - _loc_19.x;
                                        _loc_37 = _loc_28.y - _loc_19.y;
                                        _loc_38 = 0;
                                        _loc_39 = 0;
                                        _loc_38 = _loc_33.x - _loc_31.x;
                                        _loc_39 = _loc_33.y - _loc_31.y;
                                        _loc_40 = _loc_37 * _loc_38 - _loc_36 * _loc_39;
                                        if (_loc_41 > Config.epsilon)
                                        {
                                        }
                                        if (_loc_42 > Config.epsilon)
                                        {
                                        }
                                        if (_loc_40 * _loc_40 > Config.epsilon * Config.epsilon ? (_loc_40 = 1 / _loc_40, _loc_41 = (_loc_39 * _loc_34 - _loc_38 * _loc_35) * _loc_40, if (!(_loc_41 > Config.epsilon)) goto 3564, _loc_41 < 1 - Config.epsilon ? (_loc_42 = (_loc_37 * _loc_34 - _loc_36 * _loc_35) * _loc_40, if (!(_loc_42 > Config.epsilon)) goto 3612, _loc_42 < 1 - Config.epsilon ? (_loc_14 = _loc_41, true) : (false)) : (false)) : (false))
                                        {
                                            if (_loc_14 < _loc_10)
                                            {
                                                _loc_10 = _loc_14;
                                                _loc_17 = _loc_30;
                                            }
                                        }
                                        _loc_30 = _loc_32;
                                        _loc_31 = _loc_33;
                                        _loc_32 = _loc_32.next;
                                    }
                                    if (_loc_29)
                                    {
                                        do
                                        {
                                            
                                            _loc_32 = param2.polygon.gverts.next;
                                            _loc_33 = _loc_32;
                                            _loc_14 = 0;
                                            _loc_34 = 0;
                                            _loc_35 = 0;
                                            _loc_34 = _loc_19.x - _loc_31.x;
                                            _loc_35 = _loc_19.y - _loc_31.y;
                                            _loc_36 = 0;
                                            _loc_37 = 0;
                                            _loc_36 = _loc_28.x - _loc_19.x;
                                            _loc_37 = _loc_28.y - _loc_19.y;
                                            _loc_38 = 0;
                                            _loc_39 = 0;
                                            _loc_38 = _loc_33.x - _loc_31.x;
                                            _loc_39 = _loc_33.y - _loc_31.y;
                                            _loc_40 = _loc_37 * _loc_38 - _loc_36 * _loc_39;
                                            if (_loc_41 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_42 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_40 * _loc_40 > Config.epsilon * Config.epsilon ? (_loc_40 = 1 / _loc_40, _loc_41 = (_loc_39 * _loc_34 - _loc_38 * _loc_35) * _loc_40, if (!(_loc_41 > Config.epsilon)) goto 3933, _loc_41 < 1 - Config.epsilon ? (_loc_42 = (_loc_37 * _loc_34 - _loc_36 * _loc_35) * _loc_40, if (!(_loc_42 > Config.epsilon)) goto 3981, _loc_42 < 1 - Config.epsilon ? (_loc_14 = _loc_41, true) : (false)) : (false)) : (false))
                                            {
                                                if (_loc_14 < _loc_10)
                                                {
                                                    _loc_10 = _loc_14;
                                                    _loc_17 = _loc_30;
                                                }
                                            }
                                        }while (false)
                                    }
                                    if (_loc_10 != 2)
                                    {
                                        _loc_14 = 0;
                                        _loc_34 = 0;
                                        _loc_35 = _loc_10;
                                        _loc_14 = _loc_19.x + (_loc_28.x - _loc_19.x) * _loc_35;
                                        _loc_34 = _loc_19.y + (_loc_28.y - _loc_19.y) * _loc_35;
                                        _loc_29 = false;
                                        if (ZPP_Vec2.zpp_pool == null)
                                        {
                                            _loc_30 = new ZPP_Vec2();
                                        }
                                        else
                                        {
                                            _loc_30 = ZPP_Vec2.zpp_pool;
                                            ZPP_Vec2.zpp_pool = _loc_30.next;
                                            _loc_30.next = null;
                                        }
                                        _loc_30.weak = false;
                                        _loc_30._immutable = _loc_29;
                                        _loc_30.x = _loc_14;
                                        _loc_30.y = _loc_34;
                                        _loc_12 = _loc_30;
                                        ZPP_Collide.flowpoly.add(_loc_12);
                                        _loc_21 = true;
                                        _loc_13 = _loc_18;
                                        _loc_26 = false;
                                        break;
                                    }
                                    _loc_18 = _loc_27;
                                    _loc_19 = _loc_28;
                                    _loc_27 = _loc_27.next;
                                }
                                if (_loc_26)
                                {
                                    do
                                    {
                                        
                                        _loc_27 = param1.polygon.gverts.next;
                                        _loc_28 = _loc_27;
                                        _loc_10 = 2;
                                        _loc_29 = true;
                                        _loc_30 = param2.polygon.gverts.next;
                                        _loc_31 = _loc_30;
                                        _loc_32 = _loc_30.next;
                                        while (_loc_32 != null)
                                        {
                                            
                                            _loc_33 = _loc_32;
                                            _loc_14 = 0;
                                            _loc_34 = 0;
                                            _loc_35 = 0;
                                            _loc_34 = _loc_19.x - _loc_31.x;
                                            _loc_35 = _loc_19.y - _loc_31.y;
                                            _loc_36 = 0;
                                            _loc_37 = 0;
                                            _loc_36 = _loc_28.x - _loc_19.x;
                                            _loc_37 = _loc_28.y - _loc_19.y;
                                            _loc_38 = 0;
                                            _loc_39 = 0;
                                            _loc_38 = _loc_33.x - _loc_31.x;
                                            _loc_39 = _loc_33.y - _loc_31.y;
                                            _loc_40 = _loc_37 * _loc_38 - _loc_36 * _loc_39;
                                            if (_loc_41 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_42 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_40 * _loc_40 > Config.epsilon * Config.epsilon ? (_loc_40 = 1 / _loc_40, _loc_41 = (_loc_39 * _loc_34 - _loc_38 * _loc_35) * _loc_40, if (!(_loc_41 > Config.epsilon)) goto 4556, _loc_41 < 1 - Config.epsilon ? (_loc_42 = (_loc_37 * _loc_34 - _loc_36 * _loc_35) * _loc_40, if (!(_loc_42 > Config.epsilon)) goto 4604, _loc_42 < 1 - Config.epsilon ? (_loc_14 = _loc_41, true) : (false)) : (false)) : (false))
                                            {
                                                if (_loc_14 < _loc_10)
                                                {
                                                    _loc_10 = _loc_14;
                                                    _loc_17 = _loc_30;
                                                }
                                            }
                                            _loc_30 = _loc_32;
                                            _loc_31 = _loc_33;
                                            _loc_32 = _loc_32.next;
                                        }
                                        if (_loc_29)
                                        {
                                            do
                                            {
                                                
                                                _loc_32 = param2.polygon.gverts.next;
                                                _loc_33 = _loc_32;
                                                _loc_14 = 0;
                                                _loc_34 = 0;
                                                _loc_35 = 0;
                                                _loc_34 = _loc_19.x - _loc_31.x;
                                                _loc_35 = _loc_19.y - _loc_31.y;
                                                _loc_36 = 0;
                                                _loc_37 = 0;
                                                _loc_36 = _loc_28.x - _loc_19.x;
                                                _loc_37 = _loc_28.y - _loc_19.y;
                                                _loc_38 = 0;
                                                _loc_39 = 0;
                                                _loc_38 = _loc_33.x - _loc_31.x;
                                                _loc_39 = _loc_33.y - _loc_31.y;
                                                _loc_40 = _loc_37 * _loc_38 - _loc_36 * _loc_39;
                                                if (_loc_41 > Config.epsilon)
                                                {
                                                }
                                                if (_loc_42 > Config.epsilon)
                                                {
                                                }
                                                if (_loc_40 * _loc_40 > Config.epsilon * Config.epsilon ? (_loc_40 = 1 / _loc_40, _loc_41 = (_loc_39 * _loc_34 - _loc_38 * _loc_35) * _loc_40, if (!(_loc_41 > Config.epsilon)) goto 4925, _loc_41 < 1 - Config.epsilon ? (_loc_42 = (_loc_37 * _loc_34 - _loc_36 * _loc_35) * _loc_40, if (!(_loc_42 > Config.epsilon)) goto 4973, _loc_42 < 1 - Config.epsilon ? (_loc_14 = _loc_41, true) : (false)) : (false)) : (false))
                                                {
                                                    if (_loc_14 < _loc_10)
                                                    {
                                                        _loc_10 = _loc_14;
                                                        _loc_17 = _loc_30;
                                                    }
                                                }
                                            }while (false)
                                        }
                                        if (_loc_10 != 2)
                                        {
                                            _loc_14 = 0;
                                            _loc_34 = 0;
                                            _loc_35 = _loc_10;
                                            _loc_14 = _loc_19.x + (_loc_28.x - _loc_19.x) * _loc_35;
                                            _loc_34 = _loc_19.y + (_loc_28.y - _loc_19.y) * _loc_35;
                                            _loc_29 = false;
                                            if (ZPP_Vec2.zpp_pool == null)
                                            {
                                                _loc_30 = new ZPP_Vec2();
                                            }
                                            else
                                            {
                                                _loc_30 = ZPP_Vec2.zpp_pool;
                                                ZPP_Vec2.zpp_pool = _loc_30.next;
                                                _loc_30.next = null;
                                            }
                                            _loc_30.weak = false;
                                            _loc_30._immutable = _loc_29;
                                            _loc_30.x = _loc_14;
                                            _loc_30.y = _loc_34;
                                            _loc_12 = _loc_30;
                                            ZPP_Collide.flowpoly.add(_loc_12);
                                            _loc_21 = true;
                                            _loc_13 = _loc_18;
                                            break;
                                        }
                                    }while (false)
                                }
                                _loc_23 = 2;
                            }
                            while (true)
                            {
                                
                                if (_loc_21)
                                {
                                    _loc_13 = _loc_13.next;
                                    _loc_11++;
                                    if (_loc_13 == null)
                                    {
                                        _loc_13 = param1.polygon.gverts.next;
                                        _loc_11 = 0;
                                    }
                                    if (!_loc_4[_loc_11])
                                    {
                                        _loc_18 = _loc_13;
                                        if (_loc_12 != null)
                                        {
                                            _loc_10 = 0;
                                            _loc_14 = 0;
                                            _loc_10 = _loc_18.x - _loc_12.x;
                                            _loc_14 = _loc_18.y - _loc_12.y;
                                        }
                                        if (_loc_10 * _loc_10 + _loc_14 * _loc_14 < Config.epsilon)
                                        {
                                            break;
                                        }
                                        ZPP_Collide.flowpoly.add(_loc_18);
                                        if (_loc_12 == null)
                                        {
                                            _loc_12 = ZPP_Collide.flowpoly.head.elt;
                                        }
                                        _loc_23 = 1;
                                    }
                                    else
                                    {
                                        _loc_18 = ZPP_Collide.flowpoly.head.elt;
                                        _loc_19 = _loc_13;
                                        _loc_27 = _loc_17;
                                        _loc_28 = _loc_17.next;
                                        if (_loc_28 == null)
                                        {
                                            _loc_28 = param2.polygon.gverts.next;
                                        }
                                        _loc_10 = -1;
                                        _loc_30 = null;
                                        _loc_24 = 0;
                                        _loc_25 = 0;
                                        _loc_31 = _loc_28;
                                        _loc_32 = _loc_28;
                                        do
                                        {
                                            
                                            _loc_33 = _loc_32;
                                            _loc_14 = 0;
                                            _loc_34 = 0;
                                            _loc_35 = 0;
                                            _loc_34 = _loc_27.x - _loc_18.x;
                                            _loc_35 = _loc_27.y - _loc_18.y;
                                            _loc_36 = 0;
                                            _loc_37 = 0;
                                            _loc_36 = _loc_33.x - _loc_27.x;
                                            _loc_37 = _loc_33.y - _loc_27.y;
                                            _loc_38 = 0;
                                            _loc_39 = 0;
                                            _loc_38 = _loc_19.x - _loc_18.x;
                                            _loc_39 = _loc_19.y - _loc_18.y;
                                            _loc_40 = _loc_37 * _loc_38 - _loc_36 * _loc_39;
                                            if (_loc_41 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_42 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_40 * _loc_40 > Config.epsilon * Config.epsilon ? (_loc_40 = 1 / _loc_40, _loc_41 = (_loc_39 * _loc_34 - _loc_38 * _loc_35) * _loc_40, if (!(_loc_41 > Config.epsilon)) goto 5747, _loc_41 < 1 - Config.epsilon ? (_loc_42 = (_loc_37 * _loc_34 - _loc_36 * _loc_35) * _loc_40, if (!(_loc_42 > Config.epsilon)) goto 5795, _loc_42 < 1 - Config.epsilon ? (_loc_14 = _loc_41, true) : (false)) : (false)) : (false))
                                            {
                                                if (_loc_14 >= _loc_10)
                                                {
                                                    _loc_30 = _loc_17;
                                                    _loc_24 = _loc_22;
                                                    _loc_25++;
                                                    if (_loc_25 == _loc_23)
                                                    {
                                                        _loc_10 = _loc_14;
                                                        _loc_32 = _loc_31;
                                                        break;
                                                    }
                                                    else
                                                    {
                                                        _loc_10 = _loc_14;
                                                    }
                                                }
                                            }
                                            _loc_27 = _loc_33;
                                            _loc_17 = _loc_32;
                                            _loc_22++;
                                            if (_loc_22 >= param2.polygon.edgeCnt)
                                            {
                                                _loc_22 = 0;
                                            }
                                            _loc_32 = _loc_32.next;
                                            if (_loc_32 == null)
                                            {
                                                _loc_32 = param2.polygon.gverts.next;
                                            }
                                        }while (false)
                                        while (_loc_32 != _loc_31)
                                        {
                                            
                                            _loc_33 = _loc_32;
                                            _loc_14 = 0;
                                            _loc_34 = 0;
                                            _loc_35 = 0;
                                            _loc_34 = _loc_27.x - _loc_18.x;
                                            _loc_35 = _loc_27.y - _loc_18.y;
                                            _loc_36 = 0;
                                            _loc_37 = 0;
                                            _loc_36 = _loc_33.x - _loc_27.x;
                                            _loc_37 = _loc_33.y - _loc_27.y;
                                            _loc_38 = 0;
                                            _loc_39 = 0;
                                            _loc_38 = _loc_19.x - _loc_18.x;
                                            _loc_39 = _loc_19.y - _loc_18.y;
                                            _loc_40 = _loc_37 * _loc_38 - _loc_36 * _loc_39;
                                            if (_loc_41 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_42 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_40 * _loc_40 > Config.epsilon * Config.epsilon ? (_loc_40 = 1 / _loc_40, _loc_41 = (_loc_39 * _loc_34 - _loc_38 * _loc_35) * _loc_40, if (!(_loc_41 > Config.epsilon)) goto 6170, _loc_41 < 1 - Config.epsilon ? (_loc_42 = (_loc_37 * _loc_34 - _loc_36 * _loc_35) * _loc_40, if (!(_loc_42 > Config.epsilon)) goto 6218, _loc_42 < 1 - Config.epsilon ? (_loc_14 = _loc_41, true) : (false)) : (false)) : (false))
                                            {
                                                if (_loc_14 >= _loc_10)
                                                {
                                                    _loc_30 = _loc_17;
                                                    _loc_24 = _loc_22;
                                                    _loc_25++;
                                                    if (_loc_25 == _loc_23)
                                                    {
                                                        _loc_10 = _loc_14;
                                                        _loc_32 = _loc_31;
                                                        break;
                                                    }
                                                    else
                                                    {
                                                        _loc_10 = _loc_14;
                                                    }
                                                }
                                            }
                                            _loc_27 = _loc_33;
                                            _loc_17 = _loc_32;
                                            _loc_22++;
                                            if (_loc_22 >= param2.polygon.edgeCnt)
                                            {
                                                _loc_22 = 0;
                                            }
                                            _loc_32 = _loc_32.next;
                                            if (_loc_32 == null)
                                            {
                                                _loc_32 = param2.polygon.gverts.next;
                                            }
                                        }
                                        if (_loc_30 == null)
                                        {
                                            break;
                                        }
                                        _loc_31 = _loc_30;
                                        _loc_32 = _loc_30.next;
                                        if (_loc_32 == null)
                                        {
                                            _loc_32 = param2.polygon.gverts.next;
                                        }
                                        _loc_33 = _loc_32;
                                        _loc_14 = 0;
                                        _loc_34 = 0;
                                        _loc_35 = _loc_10;
                                        _loc_14 = _loc_31.x + (_loc_33.x - _loc_31.x) * _loc_35;
                                        _loc_34 = _loc_31.y + (_loc_33.y - _loc_31.y) * _loc_35;
                                        if (_loc_12 != null)
                                        {
                                            _loc_35 = 0;
                                            _loc_36 = 0;
                                            _loc_35 = _loc_14 - _loc_12.x;
                                            _loc_36 = _loc_34 - _loc_12.y;
                                        }
                                        if (_loc_35 * _loc_35 + _loc_36 * _loc_36 < Config.epsilon)
                                        {
                                            break;
                                        }
                                        _loc_26 = false;
                                        if (ZPP_Vec2.zpp_pool == null)
                                        {
                                            _loc_43 = new ZPP_Vec2();
                                        }
                                        else
                                        {
                                            _loc_43 = ZPP_Vec2.zpp_pool;
                                            ZPP_Vec2.zpp_pool = _loc_43.next;
                                            _loc_43.next = null;
                                        }
                                        _loc_43.weak = false;
                                        _loc_43._immutable = _loc_26;
                                        _loc_43.x = _loc_14;
                                        _loc_43.y = _loc_34;
                                        ZPP_Collide.flowpoly.add(_loc_43);
                                        if (_loc_12 == null)
                                        {
                                            _loc_12 = ZPP_Collide.flowpoly.head.elt;
                                        }
                                        _loc_17 = _loc_30;
                                        _loc_22 = _loc_24;
                                        _loc_21 = !_loc_21;
                                        _loc_23 = 2;
                                    }
                                    continue;
                                }
                                _loc_17 = _loc_17.next;
                                _loc_22++;
                                if (_loc_17 == null)
                                {
                                    _loc_17 = param2.polygon.gverts.next;
                                    _loc_22 = 0;
                                }
                                if (!_loc_5[_loc_22])
                                {
                                    _loc_18 = _loc_17;
                                    if (_loc_12 != null)
                                    {
                                        _loc_10 = 0;
                                        _loc_14 = 0;
                                        _loc_10 = _loc_18.x - _loc_12.x;
                                        _loc_14 = _loc_18.y - _loc_12.y;
                                    }
                                    if (_loc_10 * _loc_10 + _loc_14 * _loc_14 < Config.epsilon)
                                    {
                                        break;
                                    }
                                    ZPP_Collide.flowpoly.add(_loc_18);
                                    if (_loc_12 == null)
                                    {
                                        _loc_12 = ZPP_Collide.flowpoly.head.elt;
                                    }
                                    _loc_23 = 1;
                                    continue;
                                }
                                _loc_18 = ZPP_Collide.flowpoly.head.elt;
                                _loc_19 = _loc_17;
                                _loc_27 = _loc_13;
                                _loc_28 = _loc_13.next;
                                if (_loc_28 == null)
                                {
                                    _loc_28 = param1.polygon.gverts.next;
                                }
                                _loc_10 = -1;
                                _loc_30 = null;
                                _loc_24 = 0;
                                _loc_25 = 0;
                                _loc_31 = _loc_28;
                                _loc_32 = _loc_28;
                                do
                                {
                                    
                                    _loc_33 = _loc_32;
                                    _loc_14 = 0;
                                    _loc_34 = 0;
                                    _loc_35 = 0;
                                    _loc_34 = _loc_27.x - _loc_18.x;
                                    _loc_35 = _loc_27.y - _loc_18.y;
                                    _loc_36 = 0;
                                    _loc_37 = 0;
                                    _loc_36 = _loc_33.x - _loc_27.x;
                                    _loc_37 = _loc_33.y - _loc_27.y;
                                    _loc_38 = 0;
                                    _loc_39 = 0;
                                    _loc_38 = _loc_19.x - _loc_18.x;
                                    _loc_39 = _loc_19.y - _loc_18.y;
                                    _loc_40 = _loc_37 * _loc_38 - _loc_36 * _loc_39;
                                    if (_loc_41 > Config.epsilon)
                                    {
                                    }
                                    if (_loc_42 > Config.epsilon)
                                    {
                                    }
                                    if (_loc_40 * _loc_40 > Config.epsilon * Config.epsilon ? (_loc_40 = 1 / _loc_40, _loc_41 = (_loc_39 * _loc_34 - _loc_38 * _loc_35) * _loc_40, if (!(_loc_41 > Config.epsilon)) goto 7233, _loc_41 < 1 - Config.epsilon ? (_loc_42 = (_loc_37 * _loc_34 - _loc_36 * _loc_35) * _loc_40, if (!(_loc_42 > Config.epsilon)) goto 7281, _loc_42 < 1 - Config.epsilon ? (_loc_14 = _loc_41, true) : (false)) : (false)) : (false))
                                    {
                                        if (_loc_14 >= _loc_10)
                                        {
                                            _loc_30 = _loc_13;
                                            _loc_24 = _loc_11;
                                            _loc_25++;
                                            if (_loc_25 == _loc_23)
                                            {
                                                _loc_10 = _loc_14;
                                                _loc_32 = _loc_31;
                                                break;
                                            }
                                            else
                                            {
                                                _loc_10 = _loc_14;
                                            }
                                        }
                                    }
                                    _loc_27 = _loc_33;
                                    _loc_13 = _loc_32;
                                    _loc_11++;
                                    if (_loc_11 >= param1.polygon.edgeCnt)
                                    {
                                        _loc_11 = 0;
                                    }
                                    _loc_32 = _loc_32.next;
                                    if (_loc_32 == null)
                                    {
                                        _loc_32 = param1.polygon.gverts.next;
                                    }
                                }while (false)
                                while (_loc_32 != _loc_31)
                                {
                                    
                                    _loc_33 = _loc_32;
                                    _loc_14 = 0;
                                    _loc_34 = 0;
                                    _loc_35 = 0;
                                    _loc_34 = _loc_27.x - _loc_18.x;
                                    _loc_35 = _loc_27.y - _loc_18.y;
                                    _loc_36 = 0;
                                    _loc_37 = 0;
                                    _loc_36 = _loc_33.x - _loc_27.x;
                                    _loc_37 = _loc_33.y - _loc_27.y;
                                    _loc_38 = 0;
                                    _loc_39 = 0;
                                    _loc_38 = _loc_19.x - _loc_18.x;
                                    _loc_39 = _loc_19.y - _loc_18.y;
                                    _loc_40 = _loc_37 * _loc_38 - _loc_36 * _loc_39;
                                    if (_loc_41 > Config.epsilon)
                                    {
                                    }
                                    if (_loc_42 > Config.epsilon)
                                    {
                                    }
                                    if (_loc_40 * _loc_40 > Config.epsilon * Config.epsilon ? (_loc_40 = 1 / _loc_40, _loc_41 = (_loc_39 * _loc_34 - _loc_38 * _loc_35) * _loc_40, if (!(_loc_41 > Config.epsilon)) goto 7656, _loc_41 < 1 - Config.epsilon ? (_loc_42 = (_loc_37 * _loc_34 - _loc_36 * _loc_35) * _loc_40, if (!(_loc_42 > Config.epsilon)) goto 7704, _loc_42 < 1 - Config.epsilon ? (_loc_14 = _loc_41, true) : (false)) : (false)) : (false))
                                    {
                                        if (_loc_14 >= _loc_10)
                                        {
                                            _loc_30 = _loc_13;
                                            _loc_24 = _loc_11;
                                            _loc_25++;
                                            if (_loc_25 == _loc_23)
                                            {
                                                _loc_10 = _loc_14;
                                                _loc_32 = _loc_31;
                                                break;
                                            }
                                            else
                                            {
                                                _loc_10 = _loc_14;
                                            }
                                        }
                                    }
                                    _loc_27 = _loc_33;
                                    _loc_13 = _loc_32;
                                    _loc_11++;
                                    if (_loc_11 >= param1.polygon.edgeCnt)
                                    {
                                        _loc_11 = 0;
                                    }
                                    _loc_32 = _loc_32.next;
                                    if (_loc_32 == null)
                                    {
                                        _loc_32 = param1.polygon.gverts.next;
                                    }
                                }
                                if (_loc_30 == null)
                                {
                                    break;
                                }
                                _loc_31 = _loc_30;
                                _loc_32 = _loc_30.next;
                                if (_loc_32 == null)
                                {
                                    _loc_32 = param1.polygon.gverts.next;
                                }
                                _loc_33 = _loc_32;
                                _loc_14 = 0;
                                _loc_34 = 0;
                                _loc_35 = _loc_10;
                                _loc_14 = _loc_31.x + (_loc_33.x - _loc_31.x) * _loc_35;
                                _loc_34 = _loc_31.y + (_loc_33.y - _loc_31.y) * _loc_35;
                                if (_loc_12 != null)
                                {
                                    _loc_35 = 0;
                                    _loc_36 = 0;
                                    _loc_35 = _loc_14 - _loc_12.x;
                                    _loc_36 = _loc_34 - _loc_12.y;
                                }
                                if (_loc_35 * _loc_35 + _loc_36 * _loc_36 < Config.epsilon)
                                {
                                    break;
                                }
                                _loc_26 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_43 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_43 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_43.next;
                                    _loc_43.next = null;
                                }
                                _loc_43.weak = false;
                                _loc_43._immutable = _loc_26;
                                _loc_43.x = _loc_14;
                                _loc_43.y = _loc_34;
                                ZPP_Collide.flowpoly.add(_loc_43);
                                if (_loc_12 == null)
                                {
                                    _loc_12 = ZPP_Collide.flowpoly.head.elt;
                                }
                                _loc_13 = _loc_30;
                                _loc_11 = _loc_24;
                                _loc_21 = !_loc_21;
                                _loc_23 = 2;
                            }
                            if (ZPP_Collide.flowpoly.head != null)
                            {
                            }
                            if (ZPP_Collide.flowpoly.head.next != null)
                            {
                            }
                            if (ZPP_Collide.flowpoly.head.next.next != null)
                            {
                                _loc_10 = 0;
                                _loc_14 = 0;
                                _loc_34 = 0;
                                _loc_14 = 0;
                                _loc_34 = 0;
                                _loc_10 = 0;
                                _loc_44 = ZPP_Collide.flowpoly.head;
                                _loc_18 = _loc_44.elt;
                                _loc_44 = _loc_44.next;
                                _loc_19 = _loc_44.elt;
                                _loc_44 = _loc_44.next;
                                while (_loc_44 != null)
                                {
                                    
                                    _loc_27 = _loc_44.elt;
                                    _loc_10 = _loc_10 + _loc_19.x * (_loc_27.y - _loc_18.y);
                                    _loc_35 = _loc_27.y * _loc_19.x - _loc_27.x * _loc_19.y;
                                    _loc_14 = _loc_14 + (_loc_19.x + _loc_27.x) * _loc_35;
                                    _loc_34 = _loc_34 + (_loc_19.y + _loc_27.y) * _loc_35;
                                    _loc_18 = _loc_19;
                                    _loc_19 = _loc_27;
                                    _loc_44 = _loc_44.next;
                                }
                                _loc_44 = ZPP_Collide.flowpoly.head;
                                _loc_27 = _loc_44.elt;
                                _loc_10 = _loc_10 + _loc_19.x * (_loc_27.y - _loc_18.y);
                                _loc_35 = _loc_27.y * _loc_19.x - _loc_27.x * _loc_19.y;
                                _loc_14 = _loc_14 + (_loc_19.x + _loc_27.x) * _loc_35;
                                _loc_34 = _loc_34 + (_loc_19.y + _loc_27.y) * _loc_35;
                                _loc_18 = _loc_19;
                                _loc_19 = _loc_27;
                                _loc_44 = _loc_44.next;
                                _loc_28 = _loc_44.elt;
                                _loc_10 = _loc_10 + _loc_19.x * (_loc_28.y - _loc_18.y);
                                _loc_35 = _loc_28.y * _loc_19.x - _loc_28.x * _loc_19.y;
                                _loc_14 = _loc_14 + (_loc_19.x + _loc_28.x) * _loc_35;
                                _loc_34 = _loc_34 + (_loc_19.y + _loc_28.y) * _loc_35;
                                _loc_10 = _loc_10 * 0.5;
                                _loc_35 = 1 / (6 * _loc_10);
                                _loc_36 = _loc_35;
                                _loc_14 = _loc_14 * _loc_36;
                                _loc_34 = _loc_34 * _loc_36;
                                param3.overlap = -_loc_10;
                                param3.centroidx = _loc_14;
                                param3.centroidy = _loc_34;
                                return true;
                            }
                            else
                            {
                                return false;
                            }
                        }
                        else
                        {
                            return false;
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    _loc_4 = [];
                    _loc_6 = true;
                    _loc_9 = null;
                    _loc_12 = null;
                    _loc_10 = -1000000000000000000000000000000;
                    _loc_7 = true;
                    _loc_13 = param2.polygon.gverts.next;
                    _loc_11 = 0;
                    _loc_8 = param2.polygon.edges.head;
                    while (_loc_8 != null)
                    {
                        
                        _loc_45 = _loc_8.elt;
                        _loc_14 = _loc_45.gnormx * param1.circle.worldCOMx + _loc_45.gnormy * param1.circle.worldCOMy;
                        if (_loc_14 > _loc_45.gprojection + param1.circle.radius)
                        {
                            _loc_7 = false;
                            break;
                        }
                        else if (_loc_14 + param1.circle.radius > _loc_45.gprojection + Config.epsilon)
                        {
                            _loc_6 = false;
                            _loc_4[_loc_11] = true;
                        }
                        _loc_14 = _loc_14 - (_loc_45.gprojection + param1.circle.radius);
                        if (_loc_14 > _loc_10)
                        {
                            _loc_10 = _loc_14;
                            _loc_9 = _loc_45;
                            _loc_12 = _loc_13;
                        }
                        _loc_13 = _loc_13.next;
                        _loc_11++;
                        _loc_8 = _loc_8.next;
                    }
                    if (_loc_7)
                    {
                        if (_loc_6)
                        {
                            param3.overlap = param1.circle.area;
                            param3.centroidx = param1.circle.worldCOMx;
                            param3.centroidy = param1.circle.worldCOMy;
                            return true;
                        }
                        else
                        {
                            _loc_17 = _loc_12;
                            if (_loc_12.next == null)
                            {
                                _loc_18 = param2.polygon.gverts.next;
                            }
                            else
                            {
                                _loc_18 = _loc_12.next;
                            }
                            _loc_14 = param1.circle.worldCOMy * _loc_9.gnormx - param1.circle.worldCOMx * _loc_9.gnormy;
                            if (_loc_14 <= _loc_17.y * _loc_9.gnormx - _loc_17.x * _loc_9.gnormy ? (_loc_34 = param1.circle.radius, _loc_35 = 0, _loc_36 = 0, _loc_35 = _loc_17.x - param1.circle.worldCOMx, _loc_36 = _loc_17.y - param1.circle.worldCOMy, _loc_37 = _loc_35 * _loc_35 + _loc_36 * _loc_36, _loc_37 <= _loc_34 * _loc_34) : (_loc_14 >= _loc_18.y * _loc_9.gnormx - _loc_18.x * _loc_9.gnormy ? (_loc_34 = param1.circle.radius, _loc_35 = 0, _loc_36 = 0, _loc_35 = _loc_18.x - param1.circle.worldCOMx, _loc_36 = _loc_18.y - param1.circle.worldCOMy, _loc_37 = _loc_35 * _loc_35 + _loc_36 * _loc_36, _loc_37 <= _loc_34 * _loc_34) : (true)))
                            {
                                _loc_5 = [];
                                _loc_22 = 0;
                                _loc_21 = true;
                                _loc_19 = null;
                                _loc_23 = 0;
                                _loc_27 = param2.polygon.gverts.next;
                                while (_loc_27 != null)
                                {
                                    
                                    _loc_28 = _loc_27;
                                    _loc_35 = 0;
                                    _loc_36 = 0;
                                    _loc_35 = _loc_28.x - param1.circle.worldCOMx;
                                    _loc_36 = _loc_28.y - param1.circle.worldCOMy;
                                    _loc_34 = _loc_35 * _loc_35 + _loc_36 * _loc_36;
                                    _loc_26 = _loc_34 <= param1.circle.radius * param1.circle.radius;
                                    _loc_5[_loc_22] = _loc_26;
                                    if (!_loc_26)
                                    {
                                        _loc_21 = false;
                                    }
                                    else
                                    {
                                        _loc_23 = _loc_22;
                                        _loc_19 = _loc_27;
                                    }
                                    _loc_22++;
                                    _loc_27 = _loc_27.next;
                                }
                                if (_loc_21)
                                {
                                    _loc_15 = param2.polygon;
                                    if (_loc_15.zip_worldCOM)
                                    {
                                        if (_loc_15.body != null)
                                        {
                                            _loc_15.zip_worldCOM = false;
                                            if (_loc_15.zip_localCOM)
                                            {
                                                _loc_15.zip_localCOM = false;
                                                if (_loc_15.type == ZPP_Flags.id_ShapeType_POLYGON)
                                                {
                                                    _loc_16 = _loc_15.polygon;
                                                    if (_loc_16.lverts.next == null)
                                                    {
                                                        throw "Error: An empty polygon has no meaningful localCOM";
                                                    }
                                                    if (_loc_16.lverts.next.next == null)
                                                    {
                                                        _loc_16.localCOMx = _loc_16.lverts.next.x;
                                                        _loc_16.localCOMy = _loc_16.lverts.next.y;
                                                    }
                                                    else if (_loc_16.lverts.next.next.next == null)
                                                    {
                                                        _loc_16.localCOMx = _loc_16.lverts.next.x;
                                                        _loc_16.localCOMy = _loc_16.lverts.next.y;
                                                        _loc_34 = 1;
                                                        _loc_16.localCOMx = _loc_16.localCOMx + _loc_16.lverts.next.next.x * _loc_34;
                                                        _loc_16.localCOMy = _loc_16.localCOMy + _loc_16.lverts.next.next.y * _loc_34;
                                                        _loc_34 = 0.5;
                                                        _loc_16.localCOMx = _loc_16.localCOMx * _loc_34;
                                                        _loc_16.localCOMy = _loc_16.localCOMy * _loc_34;
                                                    }
                                                    else
                                                    {
                                                        _loc_16.localCOMx = 0;
                                                        _loc_16.localCOMy = 0;
                                                        _loc_34 = 0;
                                                        _loc_27 = _loc_16.lverts.next;
                                                        _loc_28 = _loc_27;
                                                        _loc_27 = _loc_27.next;
                                                        _loc_30 = _loc_27;
                                                        _loc_27 = _loc_27.next;
                                                        while (_loc_27 != null)
                                                        {
                                                            
                                                            _loc_31 = _loc_27;
                                                            _loc_34 = _loc_34 + _loc_30.x * (_loc_31.y - _loc_28.y);
                                                            _loc_35 = _loc_31.y * _loc_30.x - _loc_31.x * _loc_30.y;
                                                            _loc_16.localCOMx = _loc_16.localCOMx + (_loc_30.x + _loc_31.x) * _loc_35;
                                                            _loc_16.localCOMy = _loc_16.localCOMy + (_loc_30.y + _loc_31.y) * _loc_35;
                                                            _loc_28 = _loc_30;
                                                            _loc_30 = _loc_31;
                                                            _loc_27 = _loc_27.next;
                                                        }
                                                        _loc_27 = _loc_16.lverts.next;
                                                        _loc_31 = _loc_27;
                                                        _loc_34 = _loc_34 + _loc_30.x * (_loc_31.y - _loc_28.y);
                                                        _loc_35 = _loc_31.y * _loc_30.x - _loc_31.x * _loc_30.y;
                                                        _loc_16.localCOMx = _loc_16.localCOMx + (_loc_30.x + _loc_31.x) * _loc_35;
                                                        _loc_16.localCOMy = _loc_16.localCOMy + (_loc_30.y + _loc_31.y) * _loc_35;
                                                        _loc_28 = _loc_30;
                                                        _loc_30 = _loc_31;
                                                        _loc_27 = _loc_27.next;
                                                        _loc_32 = _loc_27;
                                                        _loc_34 = _loc_34 + _loc_30.x * (_loc_32.y - _loc_28.y);
                                                        _loc_35 = _loc_32.y * _loc_30.x - _loc_32.x * _loc_30.y;
                                                        _loc_16.localCOMx = _loc_16.localCOMx + (_loc_30.x + _loc_32.x) * _loc_35;
                                                        _loc_16.localCOMy = _loc_16.localCOMy + (_loc_30.y + _loc_32.y) * _loc_35;
                                                        _loc_34 = 1 / (3 * _loc_34);
                                                        _loc_35 = _loc_34;
                                                        _loc_16.localCOMx = _loc_16.localCOMx * _loc_35;
                                                        _loc_16.localCOMy = _loc_16.localCOMy * _loc_35;
                                                    }
                                                }
                                                if (_loc_15.wrap_localCOM != null)
                                                {
                                                    _loc_15.wrap_localCOM.zpp_inner.x = _loc_15.localCOMx;
                                                    _loc_15.wrap_localCOM.zpp_inner.y = _loc_15.localCOMy;
                                                }
                                            }
                                            _loc_20 = _loc_15.body;
                                            if (_loc_20.zip_axis)
                                            {
                                                _loc_20.zip_axis = false;
                                                _loc_20.axisx = Math.sin(_loc_20.rot);
                                                _loc_20.axisy = Math.cos(_loc_20.rot);
                                            }
                                            _loc_15.worldCOMx = _loc_15.body.posx + (_loc_15.body.axisy * _loc_15.localCOMx - _loc_15.body.axisx * _loc_15.localCOMy);
                                            _loc_15.worldCOMy = _loc_15.body.posy + (_loc_15.localCOMx * _loc_15.body.axisx + _loc_15.localCOMy * _loc_15.body.axisy);
                                        }
                                    }
                                    param3.overlap = param2.polygon.area;
                                    param3.centroidx = param2.polygon.worldCOMx;
                                    param3.centroidy = param2.polygon.worldCOMy;
                                    return true;
                                }
                                else
                                {
                                    while (ZPP_Collide.flowpoly.head != null)
                                    {
                                        
                                        _loc_27 = ZPP_Collide.flowpoly.pop_unsafe();
                                        if (!_loc_27._inuse)
                                        {
                                            _loc_28 = _loc_27;
                                            if (_loc_28.outer != null)
                                            {
                                                _loc_28.outer.zpp_inner = null;
                                                _loc_28.outer = null;
                                            }
                                            _loc_28._isimmutable = null;
                                            _loc_28._validate = null;
                                            _loc_28._invalidate = null;
                                            _loc_28.next = ZPP_Vec2.zpp_pool;
                                            ZPP_Vec2.zpp_pool = _loc_28;
                                        }
                                    }
                                    ZPP_Collide.flowsegs.clear();
                                    _loc_27 = null;
                                    _loc_24 = 1;
                                    if (_loc_19 == null)
                                    {
                                        _loc_19 = param2.polygon.gverts.next;
                                        _loc_24 = 2;
                                    }
                                    else
                                    {
                                        _loc_27 = _loc_19;
                                        ZPP_Collide.flowpoly.add(_loc_27);
                                    }
                                    while (_loc_24 != 0)
                                    {
                                        
                                        if (_loc_24 == 1)
                                        {
                                            _loc_19 = _loc_19.next;
                                            if (_loc_19 == null)
                                            {
                                                _loc_19 = param2.polygon.gverts.next;
                                            }
                                            _loc_23++;
                                            if (_loc_23 >= param2.polygon.edgeCnt)
                                            {
                                                _loc_23 = 0;
                                            }
                                            if (_loc_5[_loc_23])
                                            {
                                                _loc_34 = 0;
                                                _loc_35 = 0;
                                                _loc_34 = _loc_27.x - _loc_19.x;
                                                _loc_35 = _loc_27.y - _loc_19.y;
                                                if (_loc_34 * _loc_34 + _loc_35 * _loc_35 < Config.epsilon)
                                                {
                                                    break;
                                                }
                                                ZPP_Collide.flowpoly.add(_loc_19);
                                            }
                                            else
                                            {
                                                _loc_28 = ZPP_Collide.flowpoly.head.elt;
                                                _loc_30 = _loc_19;
                                                _loc_35 = 0;
                                                _loc_36 = 0;
                                                _loc_35 = _loc_30.x - _loc_28.x;
                                                _loc_36 = _loc_30.y - _loc_28.y;
                                                _loc_37 = 0;
                                                _loc_38 = 0;
                                                _loc_37 = _loc_28.x - param1.circle.worldCOMx;
                                                _loc_38 = _loc_28.y - param1.circle.worldCOMy;
                                                _loc_39 = _loc_35 * _loc_35 + _loc_36 * _loc_36;
                                                _loc_40 = 2 * (_loc_37 * _loc_35 + _loc_38 * _loc_36);
                                                _loc_41 = _loc_37 * _loc_37 + _loc_38 * _loc_38 - param1.circle.radius * param1.circle.radius;
                                                _loc_42 = Math.sqrt(_loc_40 * _loc_40 - 4 * _loc_39 * _loc_41);
                                                _loc_39 = 1 / (2 * _loc_39);
                                                _loc_46 = (-_loc_40 - _loc_42) * _loc_39;
                                                if (_loc_46 < Config.epsilon)
                                                {
                                                    _loc_34 = (-_loc_40 + _loc_42) * _loc_39;
                                                }
                                                else
                                                {
                                                    _loc_34 = _loc_46;
                                                }
                                                _loc_35 = 0;
                                                _loc_36 = 0;
                                                _loc_37 = _loc_34;
                                                _loc_35 = _loc_28.x + (_loc_30.x - _loc_28.x) * _loc_37;
                                                _loc_36 = _loc_28.y + (_loc_30.y - _loc_28.y) * _loc_37;
                                                _loc_37 = 0;
                                                _loc_38 = 0;
                                                _loc_37 = _loc_27.x - _loc_35;
                                                _loc_38 = _loc_27.y - _loc_36;
                                                if (_loc_37 * _loc_37 + _loc_38 * _loc_38 < Config.epsilon)
                                                {
                                                    break;
                                                }
                                                _loc_26 = false;
                                                if (ZPP_Vec2.zpp_pool == null)
                                                {
                                                    _loc_31 = new ZPP_Vec2();
                                                }
                                                else
                                                {
                                                    _loc_31 = ZPP_Vec2.zpp_pool;
                                                    ZPP_Vec2.zpp_pool = _loc_31.next;
                                                    _loc_31.next = null;
                                                }
                                                _loc_31.weak = false;
                                                _loc_31._immutable = _loc_26;
                                                _loc_31.x = _loc_35;
                                                _loc_31.y = _loc_36;
                                                ZPP_Collide.flowpoly.add(_loc_31);
                                                _loc_24 = 2;
                                            }
                                            continue;
                                        }
                                        if (_loc_24 == 2)
                                        {
                                            _loc_28 = _loc_19.next;
                                            if (_loc_28 == null)
                                            {
                                                _loc_28 = param2.polygon.gverts.next;
                                            }
                                            _loc_30 = _loc_19;
                                            _loc_24 = 0;
                                            _loc_31 = _loc_28;
                                            _loc_32 = _loc_28;
                                            do
                                            {
                                                
                                                _loc_33 = _loc_32;
                                                _loc_25 = _loc_23 + 1;
                                                if (_loc_25 == param2.polygon.edgeCnt)
                                                {
                                                    _loc_25 = 0;
                                                }
                                                if (_loc_4[_loc_23])
                                                {
                                                    if (_loc_5[_loc_25])
                                                    {
                                                        _loc_35 = 0;
                                                        _loc_36 = 0;
                                                        _loc_35 = _loc_33.x - _loc_30.x;
                                                        _loc_36 = _loc_33.y - _loc_30.y;
                                                        _loc_37 = 0;
                                                        _loc_38 = 0;
                                                        _loc_37 = _loc_30.x - param1.circle.worldCOMx;
                                                        _loc_38 = _loc_30.y - param1.circle.worldCOMy;
                                                        _loc_39 = _loc_35 * _loc_35 + _loc_36 * _loc_36;
                                                        _loc_40 = 2 * (_loc_37 * _loc_35 + _loc_38 * _loc_36);
                                                        _loc_41 = _loc_37 * _loc_37 + _loc_38 * _loc_38 - param1.circle.radius * param1.circle.radius;
                                                        _loc_42 = Math.sqrt(_loc_40 * _loc_40 - 4 * _loc_39 * _loc_41);
                                                        _loc_39 = 1 / (2 * _loc_39);
                                                        _loc_46 = (-_loc_40 - _loc_42) * _loc_39;
                                                        if (_loc_46 < Config.epsilon)
                                                        {
                                                            _loc_34 = (-_loc_40 + _loc_42) * _loc_39;
                                                        }
                                                        else
                                                        {
                                                            _loc_34 = _loc_46;
                                                        }
                                                        _loc_35 = 0;
                                                        _loc_36 = 0;
                                                        _loc_37 = _loc_34;
                                                        _loc_35 = _loc_30.x + (_loc_33.x - _loc_30.x) * _loc_37;
                                                        _loc_36 = _loc_30.y + (_loc_33.y - _loc_30.y) * _loc_37;
                                                        _loc_37 = 0;
                                                        _loc_38 = 0;
                                                        _loc_37 = _loc_27.x - _loc_35;
                                                        _loc_38 = _loc_27.y - _loc_36;
                                                        if (_loc_37 * _loc_37 + _loc_38 * _loc_38 < Config.epsilon)
                                                        {
                                                            _loc_24 = 0;
                                                            _loc_32 = _loc_31;
                                                            break;
                                                        }
                                                        _loc_26 = false;
                                                        if (ZPP_Vec2.zpp_pool == null)
                                                        {
                                                            _loc_47 = new ZPP_Vec2();
                                                        }
                                                        else
                                                        {
                                                            _loc_47 = ZPP_Vec2.zpp_pool;
                                                            ZPP_Vec2.zpp_pool = _loc_47.next;
                                                            _loc_47.next = null;
                                                        }
                                                        _loc_47.weak = false;
                                                        _loc_47._immutable = _loc_26;
                                                        _loc_47.x = _loc_35;
                                                        _loc_47.y = _loc_36;
                                                        _loc_43 = _loc_47;
                                                        ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.elt);
                                                        ZPP_Collide.flowsegs.add(_loc_43);
                                                        ZPP_Collide.flowpoly.add(_loc_43);
                                                        _loc_24 = 1;
                                                        _loc_32 = _loc_31;
                                                        break;
                                                    }
                                                    else
                                                    {
                                                        _loc_34 = 0;
                                                        _loc_35 = 0;
                                                        _loc_36 = 0;
                                                        _loc_37 = 0;
                                                        _loc_36 = _loc_33.x - _loc_30.x;
                                                        _loc_37 = _loc_33.y - _loc_30.y;
                                                        _loc_38 = 0;
                                                        _loc_39 = 0;
                                                        _loc_38 = _loc_30.x - param1.circle.worldCOMx;
                                                        _loc_39 = _loc_30.y - param1.circle.worldCOMy;
                                                        _loc_40 = _loc_36 * _loc_36 + _loc_37 * _loc_37;
                                                        _loc_41 = 2 * (_loc_38 * _loc_36 + _loc_39 * _loc_37);
                                                        _loc_42 = _loc_38 * _loc_38 + _loc_39 * _loc_39 - param1.circle.radius * param1.circle.radius;
                                                        _loc_46 = _loc_41 * _loc_41 - 4 * _loc_40 * _loc_42;
                                                        if (_loc_46 * _loc_46 < Config.epsilon)
                                                        {
                                                            if (_loc_46 < 0)
                                                            {
                                                                _loc_34 = 10;
                                                            }
                                                            else
                                                            {
                                                                _loc_35 = (-_loc_41) / (2 * _loc_40);
                                                                _loc_34 = _loc_35;
                                                            }
                                                            _loc_26 = false;
                                                        }
                                                        else
                                                        {
                                                            _loc_46 = Math.sqrt(_loc_46);
                                                            _loc_40 = 1 / (2 * _loc_40);
                                                            _loc_34 = (-_loc_41 - _loc_46) * _loc_40;
                                                            _loc_35 = (-_loc_41 + _loc_46) * _loc_40;
                                                            _loc_26 = true;
                                                        }
                                                        if (_loc_34 < 1 - Config.epsilon)
                                                        {
                                                        }
                                                        if (_loc_35 > Config.epsilon)
                                                        {
                                                            _loc_36 = 0;
                                                            _loc_37 = 0;
                                                            _loc_38 = _loc_34;
                                                            _loc_36 = _loc_30.x + (_loc_33.x - _loc_30.x) * _loc_38;
                                                            _loc_37 = _loc_30.y + (_loc_33.y - _loc_30.y) * _loc_38;
                                                            if (_loc_27 != null)
                                                            {
                                                                _loc_38 = 0;
                                                                _loc_39 = 0;
                                                                _loc_38 = _loc_27.x - _loc_36;
                                                                _loc_39 = _loc_27.y - _loc_37;
                                                            }
                                                            if (_loc_38 * _loc_38 + _loc_39 * _loc_39 < Config.epsilon)
                                                            {
                                                                _loc_24 = 0;
                                                                _loc_32 = _loc_31;
                                                                break;
                                                            }
                                                            _loc_29 = false;
                                                            if (ZPP_Vec2.zpp_pool == null)
                                                            {
                                                                _loc_47 = new ZPP_Vec2();
                                                            }
                                                            else
                                                            {
                                                                _loc_47 = ZPP_Vec2.zpp_pool;
                                                                ZPP_Vec2.zpp_pool = _loc_47.next;
                                                                _loc_47.next = null;
                                                            }
                                                            _loc_47.weak = false;
                                                            _loc_47._immutable = _loc_29;
                                                            _loc_47.x = _loc_36;
                                                            _loc_47.y = _loc_37;
                                                            _loc_43 = _loc_47;
                                                            if (ZPP_Collide.flowpoly.head != null)
                                                            {
                                                                ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.elt);
                                                                ZPP_Collide.flowsegs.add(_loc_43);
                                                            }
                                                            ZPP_Collide.flowpoly.add(_loc_43);
                                                            if (_loc_27 == null)
                                                            {
                                                                _loc_27 = ZPP_Collide.flowpoly.head.elt;
                                                            }
                                                            if (_loc_26)
                                                            {
                                                                _loc_38 = 0;
                                                                _loc_39 = 0;
                                                                _loc_40 = _loc_35;
                                                                _loc_38 = _loc_30.x + (_loc_33.x - _loc_30.x) * _loc_40;
                                                                _loc_39 = _loc_30.y + (_loc_33.y - _loc_30.y) * _loc_40;
                                                                _loc_29 = false;
                                                                if (ZPP_Vec2.zpp_pool == null)
                                                                {
                                                                    _loc_47 = new ZPP_Vec2();
                                                                }
                                                                else
                                                                {
                                                                    _loc_47 = ZPP_Vec2.zpp_pool;
                                                                    ZPP_Vec2.zpp_pool = _loc_47.next;
                                                                    _loc_47.next = null;
                                                                }
                                                                _loc_47.weak = false;
                                                                _loc_47._immutable = _loc_29;
                                                                _loc_47.x = _loc_38;
                                                                _loc_47.y = _loc_39;
                                                                ZPP_Collide.flowpoly.add(_loc_47);
                                                            }
                                                        }
                                                    }
                                                }
                                                _loc_30 = _loc_33;
                                                _loc_19 = _loc_32;
                                                _loc_23 = _loc_25;
                                                _loc_32 = _loc_32.next;
                                                if (_loc_32 == null)
                                                {
                                                    _loc_32 = param2.polygon.gverts.next;
                                                }
                                            }while (false)
                                            while (_loc_32 != _loc_31)
                                            {
                                                
                                                _loc_33 = _loc_32;
                                                _loc_25 = _loc_23 + 1;
                                                if (_loc_25 == param2.polygon.edgeCnt)
                                                {
                                                    _loc_25 = 0;
                                                }
                                                if (_loc_4[_loc_23])
                                                {
                                                    if (_loc_5[_loc_25])
                                                    {
                                                        _loc_35 = 0;
                                                        _loc_36 = 0;
                                                        _loc_35 = _loc_33.x - _loc_30.x;
                                                        _loc_36 = _loc_33.y - _loc_30.y;
                                                        _loc_37 = 0;
                                                        _loc_38 = 0;
                                                        _loc_37 = _loc_30.x - param1.circle.worldCOMx;
                                                        _loc_38 = _loc_30.y - param1.circle.worldCOMy;
                                                        _loc_39 = _loc_35 * _loc_35 + _loc_36 * _loc_36;
                                                        _loc_40 = 2 * (_loc_37 * _loc_35 + _loc_38 * _loc_36);
                                                        _loc_41 = _loc_37 * _loc_37 + _loc_38 * _loc_38 - param1.circle.radius * param1.circle.radius;
                                                        _loc_42 = Math.sqrt(_loc_40 * _loc_40 - 4 * _loc_39 * _loc_41);
                                                        _loc_39 = 1 / (2 * _loc_39);
                                                        _loc_46 = (-_loc_40 - _loc_42) * _loc_39;
                                                        if (_loc_46 < Config.epsilon)
                                                        {
                                                            _loc_34 = (-_loc_40 + _loc_42) * _loc_39;
                                                        }
                                                        else
                                                        {
                                                            _loc_34 = _loc_46;
                                                        }
                                                        _loc_35 = 0;
                                                        _loc_36 = 0;
                                                        _loc_37 = _loc_34;
                                                        _loc_35 = _loc_30.x + (_loc_33.x - _loc_30.x) * _loc_37;
                                                        _loc_36 = _loc_30.y + (_loc_33.y - _loc_30.y) * _loc_37;
                                                        _loc_37 = 0;
                                                        _loc_38 = 0;
                                                        _loc_37 = _loc_27.x - _loc_35;
                                                        _loc_38 = _loc_27.y - _loc_36;
                                                        if (_loc_37 * _loc_37 + _loc_38 * _loc_38 < Config.epsilon)
                                                        {
                                                            _loc_24 = 0;
                                                            _loc_32 = _loc_31;
                                                            break;
                                                        }
                                                        _loc_26 = false;
                                                        if (ZPP_Vec2.zpp_pool == null)
                                                        {
                                                            _loc_47 = new ZPP_Vec2();
                                                        }
                                                        else
                                                        {
                                                            _loc_47 = ZPP_Vec2.zpp_pool;
                                                            ZPP_Vec2.zpp_pool = _loc_47.next;
                                                            _loc_47.next = null;
                                                        }
                                                        _loc_47.weak = false;
                                                        _loc_47._immutable = _loc_26;
                                                        _loc_47.x = _loc_35;
                                                        _loc_47.y = _loc_36;
                                                        _loc_43 = _loc_47;
                                                        ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.elt);
                                                        ZPP_Collide.flowsegs.add(_loc_43);
                                                        ZPP_Collide.flowpoly.add(_loc_43);
                                                        _loc_24 = 1;
                                                        _loc_32 = _loc_31;
                                                        break;
                                                    }
                                                    else
                                                    {
                                                        _loc_34 = 0;
                                                        _loc_35 = 0;
                                                        _loc_36 = 0;
                                                        _loc_37 = 0;
                                                        _loc_36 = _loc_33.x - _loc_30.x;
                                                        _loc_37 = _loc_33.y - _loc_30.y;
                                                        _loc_38 = 0;
                                                        _loc_39 = 0;
                                                        _loc_38 = _loc_30.x - param1.circle.worldCOMx;
                                                        _loc_39 = _loc_30.y - param1.circle.worldCOMy;
                                                        _loc_40 = _loc_36 * _loc_36 + _loc_37 * _loc_37;
                                                        _loc_41 = 2 * (_loc_38 * _loc_36 + _loc_39 * _loc_37);
                                                        _loc_42 = _loc_38 * _loc_38 + _loc_39 * _loc_39 - param1.circle.radius * param1.circle.radius;
                                                        _loc_46 = _loc_41 * _loc_41 - 4 * _loc_40 * _loc_42;
                                                        if (_loc_46 * _loc_46 < Config.epsilon)
                                                        {
                                                            if (_loc_46 < 0)
                                                            {
                                                                _loc_34 = 10;
                                                            }
                                                            else
                                                            {
                                                                _loc_35 = (-_loc_41) / (2 * _loc_40);
                                                                _loc_34 = _loc_35;
                                                            }
                                                            _loc_26 = false;
                                                        }
                                                        else
                                                        {
                                                            _loc_46 = Math.sqrt(_loc_46);
                                                            _loc_40 = 1 / (2 * _loc_40);
                                                            _loc_34 = (-_loc_41 - _loc_46) * _loc_40;
                                                            _loc_35 = (-_loc_41 + _loc_46) * _loc_40;
                                                            _loc_26 = true;
                                                        }
                                                        if (_loc_34 < 1 - Config.epsilon)
                                                        {
                                                        }
                                                        if (_loc_35 > Config.epsilon)
                                                        {
                                                            _loc_36 = 0;
                                                            _loc_37 = 0;
                                                            _loc_38 = _loc_34;
                                                            _loc_36 = _loc_30.x + (_loc_33.x - _loc_30.x) * _loc_38;
                                                            _loc_37 = _loc_30.y + (_loc_33.y - _loc_30.y) * _loc_38;
                                                            if (_loc_27 != null)
                                                            {
                                                                _loc_38 = 0;
                                                                _loc_39 = 0;
                                                                _loc_38 = _loc_27.x - _loc_36;
                                                                _loc_39 = _loc_27.y - _loc_37;
                                                            }
                                                            if (_loc_38 * _loc_38 + _loc_39 * _loc_39 < Config.epsilon)
                                                            {
                                                                _loc_24 = 0;
                                                                _loc_32 = _loc_31;
                                                                break;
                                                            }
                                                            _loc_29 = false;
                                                            if (ZPP_Vec2.zpp_pool == null)
                                                            {
                                                                _loc_47 = new ZPP_Vec2();
                                                            }
                                                            else
                                                            {
                                                                _loc_47 = ZPP_Vec2.zpp_pool;
                                                                ZPP_Vec2.zpp_pool = _loc_47.next;
                                                                _loc_47.next = null;
                                                            }
                                                            _loc_47.weak = false;
                                                            _loc_47._immutable = _loc_29;
                                                            _loc_47.x = _loc_36;
                                                            _loc_47.y = _loc_37;
                                                            _loc_43 = _loc_47;
                                                            if (ZPP_Collide.flowpoly.head != null)
                                                            {
                                                                ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.elt);
                                                                ZPP_Collide.flowsegs.add(_loc_43);
                                                            }
                                                            ZPP_Collide.flowpoly.add(_loc_43);
                                                            if (_loc_27 == null)
                                                            {
                                                                _loc_27 = ZPP_Collide.flowpoly.head.elt;
                                                            }
                                                            if (_loc_26)
                                                            {
                                                                _loc_38 = 0;
                                                                _loc_39 = 0;
                                                                _loc_40 = _loc_35;
                                                                _loc_38 = _loc_30.x + (_loc_33.x - _loc_30.x) * _loc_40;
                                                                _loc_39 = _loc_30.y + (_loc_33.y - _loc_30.y) * _loc_40;
                                                                _loc_29 = false;
                                                                if (ZPP_Vec2.zpp_pool == null)
                                                                {
                                                                    _loc_47 = new ZPP_Vec2();
                                                                }
                                                                else
                                                                {
                                                                    _loc_47 = ZPP_Vec2.zpp_pool;
                                                                    ZPP_Vec2.zpp_pool = _loc_47.next;
                                                                    _loc_47.next = null;
                                                                }
                                                                _loc_47.weak = false;
                                                                _loc_47._immutable = _loc_29;
                                                                _loc_47.x = _loc_38;
                                                                _loc_47.y = _loc_39;
                                                                ZPP_Collide.flowpoly.add(_loc_47);
                                                            }
                                                        }
                                                    }
                                                }
                                                _loc_30 = _loc_33;
                                                _loc_19 = _loc_32;
                                                _loc_23 = _loc_25;
                                                _loc_32 = _loc_32.next;
                                                if (_loc_32 == null)
                                                {
                                                    _loc_32 = param2.polygon.gverts.next;
                                                }
                                            }
                                        }
                                    }
                                    if (ZPP_Collide.flowpoly.head == null)
                                    {
                                        return false;
                                    }
                                    else if (ZPP_Collide.flowpoly.head.next == null)
                                    {
                                        _loc_26 = true;
                                        _loc_8 = param2.polygon.edges.head;
                                        while (_loc_8 != null)
                                        {
                                            
                                            _loc_45 = _loc_8.elt;
                                            _loc_34 = _loc_45.gnormx * param1.circle.worldCOMx + _loc_45.gnormy * param1.circle.worldCOMy;
                                            if (_loc_34 > _loc_45.gprojection)
                                            {
                                                _loc_26 = false;
                                                break;
                                            }
                                            _loc_8 = _loc_8.next;
                                        }
                                        if (_loc_26)
                                        {
                                            param3.overlap = param1.circle.area;
                                            param3.centroidx = param1.circle.worldCOMx;
                                            param3.centroidy = param1.circle.worldCOMy;
                                            return true;
                                        }
                                        else
                                        {
                                            return false;
                                        }
                                    }
                                    else
                                    {
                                        _loc_34 = 0;
                                        _loc_35 = 0;
                                        _loc_36 = 0;
                                        if (ZPP_Collide.flowpoly.head.next.next != null)
                                        {
                                            _loc_37 = 0;
                                            _loc_38 = 0;
                                            _loc_39 = 0;
                                            _loc_38 = 0;
                                            _loc_39 = 0;
                                            _loc_37 = 0;
                                            _loc_44 = ZPP_Collide.flowpoly.head;
                                            _loc_28 = _loc_44.elt;
                                            _loc_44 = _loc_44.next;
                                            _loc_30 = _loc_44.elt;
                                            _loc_44 = _loc_44.next;
                                            while (_loc_44 != null)
                                            {
                                                
                                                _loc_31 = _loc_44.elt;
                                                _loc_37 = _loc_37 + _loc_30.x * (_loc_31.y - _loc_28.y);
                                                _loc_40 = _loc_31.y * _loc_30.x - _loc_31.x * _loc_30.y;
                                                _loc_38 = _loc_38 + (_loc_30.x + _loc_31.x) * _loc_40;
                                                _loc_39 = _loc_39 + (_loc_30.y + _loc_31.y) * _loc_40;
                                                _loc_28 = _loc_30;
                                                _loc_30 = _loc_31;
                                                _loc_44 = _loc_44.next;
                                            }
                                            _loc_44 = ZPP_Collide.flowpoly.head;
                                            _loc_31 = _loc_44.elt;
                                            _loc_37 = _loc_37 + _loc_30.x * (_loc_31.y - _loc_28.y);
                                            _loc_40 = _loc_31.y * _loc_30.x - _loc_31.x * _loc_30.y;
                                            _loc_38 = _loc_38 + (_loc_30.x + _loc_31.x) * _loc_40;
                                            _loc_39 = _loc_39 + (_loc_30.y + _loc_31.y) * _loc_40;
                                            _loc_28 = _loc_30;
                                            _loc_30 = _loc_31;
                                            _loc_44 = _loc_44.next;
                                            _loc_32 = _loc_44.elt;
                                            _loc_37 = _loc_37 + _loc_30.x * (_loc_32.y - _loc_28.y);
                                            _loc_40 = _loc_32.y * _loc_30.x - _loc_32.x * _loc_30.y;
                                            _loc_38 = _loc_38 + (_loc_30.x + _loc_32.x) * _loc_40;
                                            _loc_39 = _loc_39 + (_loc_30.y + _loc_32.y) * _loc_40;
                                            _loc_37 = _loc_37 * 0.5;
                                            _loc_40 = 1 / (6 * _loc_37);
                                            _loc_41 = _loc_40;
                                            _loc_38 = _loc_38 * _loc_41;
                                            _loc_39 = _loc_39 * _loc_41;
                                            _loc_40 = -_loc_37;
                                            _loc_34 = _loc_34 + _loc_38 * _loc_40;
                                            _loc_35 = _loc_35 + _loc_39 * _loc_40;
                                            _loc_36 = _loc_36 - _loc_37;
                                        }
                                        else
                                        {
                                            ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.elt);
                                            ZPP_Collide.flowsegs.add(ZPP_Collide.flowpoly.head.next.elt);
                                        }
                                        while (ZPP_Collide.flowsegs.head != null)
                                        {
                                            
                                            _loc_28 = ZPP_Collide.flowsegs.pop_unsafe();
                                            _loc_30 = ZPP_Collide.flowsegs.pop_unsafe();
                                            _loc_37 = 0;
                                            _loc_38 = 0;
                                            _loc_37 = _loc_30.x - _loc_28.x;
                                            _loc_38 = _loc_30.y - _loc_28.y;
                                            _loc_39 = 0;
                                            _loc_40 = 0;
                                            _loc_39 = _loc_37;
                                            _loc_40 = _loc_38;
                                            _loc_41 = _loc_39 * _loc_39 + _loc_40 * _loc_40;
                                            _loc_25 = 1597463007 - (0 >> 1);
                                            _loc_46 = 0;
                                            _loc_42 = _loc_46 * (1.5 - 0.5 * _loc_41 * _loc_46 * _loc_46);
                                            _loc_46 = _loc_42;
                                            _loc_39 = _loc_39 * _loc_46;
                                            _loc_40 = _loc_40 * _loc_46;
                                            _loc_41 = _loc_39;
                                            _loc_39 = -_loc_40;
                                            _loc_40 = _loc_41;
                                            _loc_41 = 0;
                                            _loc_42 = 0;
                                            _loc_41 = _loc_28.x + _loc_30.x;
                                            _loc_42 = _loc_28.y + _loc_30.y;
                                            _loc_46 = 0.5;
                                            _loc_41 = _loc_41 * _loc_46;
                                            _loc_42 = _loc_42 * _loc_46;
                                            _loc_46 = 1;
                                            _loc_41 = _loc_41 - param1.circle.worldCOMx * _loc_46;
                                            _loc_42 = _loc_42 - param1.circle.worldCOMy * _loc_46;
                                            _loc_46 = _loc_39 * _loc_41 + _loc_40 * _loc_42;
                                            _loc_48 = 0;
                                            _loc_49 = 0;
                                            _loc_50 = _loc_46;
                                            _loc_51 = _loc_50 / param1.circle.radius;
                                            _loc_52 = Math.sqrt(1 - _loc_51 * _loc_51);
                                            _loc_53 = Math.acos(_loc_51);
                                            _loc_48 = param1.circle.radius * (param1.circle.radius * _loc_53 - _loc_50 * _loc_52);
                                            _loc_49 = 0.666667 * param1.circle.radius * _loc_52 * _loc_52 * _loc_52 / (_loc_53 - _loc_51 * _loc_52);
                                            _loc_41 = param1.circle.worldCOMx;
                                            _loc_42 = param1.circle.worldCOMy;
                                            _loc_50 = _loc_49;
                                            _loc_41 = _loc_41 + _loc_39 * _loc_50;
                                            _loc_42 = _loc_42 + _loc_40 * _loc_50;
                                            _loc_50 = _loc_48;
                                            _loc_34 = _loc_34 + _loc_41 * _loc_50;
                                            _loc_35 = _loc_35 + _loc_42 * _loc_50;
                                            _loc_36 = _loc_36 + _loc_48;
                                        }
                                        _loc_37 = 1 / _loc_36;
                                        _loc_34 = _loc_34 * _loc_37;
                                        _loc_35 = _loc_35 * _loc_37;
                                        param3.overlap = _loc_36;
                                        param3.centroidx = _loc_34;
                                        param3.centroidy = _loc_35;
                                        return true;
                                    }
                                }
                            }
                            else
                            {
                                return false;
                            }
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            else
            {
                _loc_54 = param1.circle;
                _loc_55 = param2.circle;
                _loc_10 = 0;
                _loc_14 = 0;
                _loc_10 = _loc_55.worldCOMx - _loc_54.worldCOMx;
                _loc_14 = _loc_55.worldCOMy - _loc_54.worldCOMy;
                _loc_34 = _loc_54.radius + _loc_55.radius;
                _loc_35 = _loc_10 * _loc_10 + _loc_14 * _loc_14;
                if (_loc_35 > _loc_34 * _loc_34)
                {
                    return false;
                }
                else if (_loc_35 < Config.epsilon * Config.epsilon)
                {
                    if (_loc_54.radius < _loc_55.radius)
                    {
                        param3.overlap = _loc_54.area;
                        param3.centroidx = _loc_54.worldCOMx;
                        param3.centroidy = _loc_54.worldCOMy;
                    }
                    else
                    {
                        param3.overlap = _loc_55.area;
                        param3.centroidx = _loc_55.worldCOMx;
                        param3.centroidy = _loc_55.worldCOMy;
                    }
                    return true;
                }
                else
                {
                    _loc_36 = Math.sqrt(_loc_35);
                    _loc_37 = 1 / _loc_36;
                    _loc_38 = 0.5 * (_loc_36 - (_loc_55.radius * _loc_55.radius - _loc_54.radius * _loc_54.radius) * _loc_37);
                    if (_loc_38 <= -_loc_54.radius)
                    {
                        param3.overlap = _loc_54.area;
                        param3.centroidx = _loc_54.worldCOMx;
                        param3.centroidy = _loc_54.worldCOMy;
                    }
                    else
                    {
                        _loc_39 = _loc_36 - _loc_38;
                        if (_loc_39 <= -_loc_55.radius)
                        {
                            param3.overlap = _loc_55.area;
                            param3.centroidx = _loc_55.worldCOMx;
                            param3.centroidy = _loc_55.worldCOMy;
                        }
                        else
                        {
                            _loc_40 = 0;
                            _loc_41 = 0;
                            _loc_42 = 0;
                            _loc_46 = 0;
                            _loc_48 = _loc_38;
                            _loc_49 = _loc_48 / _loc_54.radius;
                            _loc_50 = Math.sqrt(1 - _loc_49 * _loc_49);
                            _loc_51 = Math.acos(_loc_49);
                            _loc_40 = _loc_54.radius * (_loc_54.radius * _loc_51 - _loc_48 * _loc_50);
                            _loc_41 = 0.666667 * _loc_54.radius * _loc_50 * _loc_50 * _loc_50 / (_loc_51 - _loc_49 * _loc_50);
                            _loc_48 = _loc_39;
                            _loc_49 = _loc_48 / _loc_55.radius;
                            _loc_50 = Math.sqrt(1 - _loc_49 * _loc_49);
                            _loc_51 = Math.acos(_loc_49);
                            _loc_42 = _loc_55.radius * (_loc_55.radius * _loc_51 - _loc_48 * _loc_50);
                            _loc_46 = 0.666667 * _loc_55.radius * _loc_50 * _loc_50 * _loc_50 / (_loc_51 - _loc_49 * _loc_50);
                            _loc_48 = _loc_40 + _loc_42;
                            _loc_49 = (_loc_41 * _loc_40 + (_loc_36 - _loc_46) * _loc_42) / _loc_48 * _loc_37;
                            param3.overlap = _loc_48;
                            param3.centroidx = _loc_54.worldCOMx + _loc_10 * _loc_49;
                            param3.centroidy = _loc_54.worldCOMy + _loc_14 * _loc_49;
                        }
                    }
                    return true;
                }
            }
        }// end function

    }
}
