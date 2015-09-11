package nape.geom
{
    import nape.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    final public class Geom extends Object
    {

        public function Geom() : void
        {
            return;
        }// end function

        public static function distanceBody(param1:Body, param2:Body, param3:Vec2, param4:Vec2) : Number
        {
            var _loc_6:* = null as ShapeList;
            var _loc_8:* = null as ZPP_Shape;
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param4 != null)
            {
            }
            if (param4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_5:* = param3.zpp_inner;
            if (_loc_5._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_5._isimmutable != null)
            {
                _loc_5._isimmutable();
            }
            _loc_5 = param4.zpp_inner;
            if (_loc_5._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_5._isimmutable != null)
            {
                _loc_5._isimmutable();
            }
            _loc_6 = param1.zpp_inner.wrap_shapes;
            if (_loc_6.zpp_inner.inner.head != null)
            {
                _loc_6 = param2.zpp_inner.wrap_shapes;
            }
            if (_loc_6.zpp_inner.inner.head == null)
            {
                throw "Error: Bodies cannot be empty in calculating distances";
            }
            var _loc_7:* = param1.zpp_inner.shapes.head;
            while (_loc_7 != null)
            {
                
                _loc_8 = _loc_7.elt;
                ZPP_Geom.validateShape(_loc_8);
                _loc_7 = _loc_7.next;
            }
            _loc_7 = param2.zpp_inner.shapes.head;
            while (_loc_7 != null)
            {
                
                _loc_8 = _loc_7.elt;
                ZPP_Geom.validateShape(_loc_8);
                _loc_7 = _loc_7.next;
            }
            return ZPP_SweepDistance.distanceBody(param1.zpp_inner, param2.zpp_inner, param3.zpp_inner, param4.zpp_inner);
        }// end function

        public static function distance(param1:Shape, param2:Shape, param3:Vec2, param4:Vec2) : Number
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = NaN;
            var _loc_11:* = null as ZPP_Circle;
            var _loc_12:* = null as ZPP_Circle;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = 0;
            var _loc_19:* = NaN;
            var _loc_20:* = false;
            var _loc_21:* = null as ZPP_Shape;
            var _loc_22:* = null as ZPP_Vec2;
            var _loc_23:* = null as ZPP_Polygon;
            var _loc_24:* = null as ZPP_Edge;
            var _loc_25:* = null as ZNPNode_ZPP_Edge;
            var _loc_26:* = null as ZPP_Edge;
            var _loc_27:* = null as ZPP_Vec2;
            var _loc_28:* = NaN;
            var _loc_29:* = null as ZPP_Polygon;
            var _loc_30:* = null as ZPP_Edge;
            var _loc_31:* = null as ZPP_Polygon;
            var _loc_32:* = null as ZPP_Polygon;
            var _loc_33:* = null as ZPP_Edge;
            var _loc_34:* = null as ZPP_Edge;
            var _loc_35:* = null as ZPP_Vec2;
            var _loc_36:* = null as ZPP_Vec2;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = NaN;
            var _loc_40:* = NaN;
            var _loc_41:* = NaN;
            var _loc_42:* = NaN;
            var _loc_43:* = NaN;
            var _loc_44:* = NaN;
            var _loc_45:* = NaN;
            var _loc_46:* = NaN;
            var _loc_47:* = NaN;
            var _loc_48:* = NaN;
            var _loc_49:* = NaN;
            var _loc_50:* = NaN;
            var _loc_51:* = NaN;
            var _loc_52:* = NaN;
            var _loc_53:* = NaN;
            var _loc_54:* = NaN;
            var _loc_55:* = NaN;
            var _loc_56:* = null as ZPP_Vec2;
            var _loc_57:* = NaN;
            var _loc_58:* = NaN;
            var _loc_59:* = null as ZPP_Vec2;
            var _loc_60:* = NaN;
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param4 != null)
            {
            }
            if (param4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = param3.zpp_inner;
            if (_loc_5._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_5._isimmutable != null)
            {
                _loc_5._isimmutable();
            }
            _loc_5 = param4.zpp_inner;
            if (_loc_5._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_5._isimmutable != null)
            {
                _loc_5._isimmutable();
            }
            if ((param1.zpp_inner.body != null ? (param1.zpp_inner.body.outer) : (null)) != null)
            {
            }
            if ((param2.zpp_inner.body != null ? (param2.zpp_inner.body.outer) : (null)) == null)
            {
                throw "Error: Shape must be part of a Body to calculate distances";
            }
            ZPP_Geom.validateShape(param1.zpp_inner);
            ZPP_Geom.validateShape(param2.zpp_inner);
            if (ZPP_Vec2.zpp_pool == null)
            {
                _loc_5 = new ZPP_Vec2();
            }
            else
            {
                _loc_5 = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_5.next;
                _loc_5.next = null;
            }
            _loc_5.weak = false;
            var _loc_7:* = param1.zpp_inner;
            var _loc_8:* = param2.zpp_inner;
            var _loc_9:* = param3.zpp_inner;
            var _loc_10:* = param4.zpp_inner;
            if (_loc_7.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
            }
            if (_loc_8.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                _loc_11 = _loc_7.circle;
                _loc_12 = _loc_8.circle;
                _loc_14 = 0;
                _loc_15 = 0;
                _loc_14 = _loc_12.worldCOMx - _loc_11.worldCOMx;
                _loc_15 = _loc_12.worldCOMy - _loc_11.worldCOMy;
                _loc_17 = _loc_14 * _loc_14 + _loc_15 * _loc_15;
                if (_loc_17 == 0)
                {
                    _loc_16 = 0;
                }
                else
                {
                    _loc_18 = 1597463007 - (0 >> 1);
                    _loc_19 = 0;
                    _loc_16 = 0 / (_loc_19 * (1.5 - 0.5 * _loc_17 * _loc_19 * _loc_19));
                }
                _loc_13 = _loc_16 - (_loc_11.radius + _loc_12.radius);
                if (_loc_13 < 1000000000000000000000000000000)
                {
                    if (_loc_16 == 0)
                    {
                        _loc_14 = 1;
                        _loc_15 = 0;
                    }
                    else
                    {
                        _loc_17 = 1 / _loc_16;
                        _loc_14 = _loc_14 * _loc_17;
                        _loc_15 = _loc_15 * _loc_17;
                    }
                    _loc_17 = _loc_11.radius;
                    _loc_9.x = _loc_11.worldCOMx + _loc_14 * _loc_17;
                    _loc_9.y = _loc_11.worldCOMy + _loc_15 * _loc_17;
                    _loc_17 = -_loc_12.radius;
                    _loc_10.x = _loc_12.worldCOMx + _loc_14 * _loc_17;
                    _loc_10.y = _loc_12.worldCOMy + _loc_15 * _loc_17;
                    _loc_5.x = _loc_14;
                    _loc_5.y = _loc_15;
                }
                _loc_6 = _loc_13;
            }
            else
            {
                _loc_20 = false;
                if (_loc_7.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                }
                if (_loc_8.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_21 = _loc_7;
                    _loc_7 = _loc_8;
                    _loc_8 = _loc_21;
                    _loc_22 = _loc_9;
                    _loc_9 = _loc_10;
                    _loc_10 = _loc_22;
                    _loc_20 = true;
                }
                if (_loc_7.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                }
                if (_loc_8.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    _loc_23 = _loc_7.polygon;
                    _loc_11 = _loc_8.circle;
                    _loc_13 = -1000000000000000000000000000000;
                    _loc_24 = null;
                    _loc_25 = _loc_23.edges.head;
                    while (_loc_25 != null)
                    {
                        
                        _loc_26 = _loc_25.elt;
                        _loc_14 = _loc_26.gnormx * _loc_11.worldCOMx + _loc_26.gnormy * _loc_11.worldCOMy - _loc_26.gprojection - _loc_11.radius;
                        if (_loc_14 > 1000000000000000000000000000000)
                        {
                            _loc_13 = _loc_14;
                            break;
                        }
                        if (_loc_14 > 0)
                        {
                            if (_loc_14 > _loc_13)
                            {
                                _loc_13 = _loc_14;
                                _loc_24 = _loc_26;
                            }
                        }
                        else
                        {
                            if (_loc_13 < 0)
                            {
                            }
                            if (_loc_14 > _loc_13)
                            {
                                _loc_13 = _loc_14;
                                _loc_24 = _loc_26;
                            }
                        }
                        _loc_25 = _loc_25.next;
                    }
                    if (_loc_13 < 1000000000000000000000000000000)
                    {
                        _loc_22 = _loc_24.gp0;
                        _loc_27 = _loc_24.gp1;
                        _loc_14 = _loc_11.worldCOMy * _loc_24.gnormx - _loc_11.worldCOMx * _loc_24.gnormy;
                        if (_loc_14 <= _loc_22.y * _loc_24.gnormx - _loc_22.x * _loc_24.gnormy)
                        {
                            _loc_15 = 0;
                            _loc_16 = 0;
                            _loc_15 = _loc_11.worldCOMx - _loc_22.x;
                            _loc_16 = _loc_11.worldCOMy - _loc_22.y;
                            _loc_19 = _loc_15 * _loc_15 + _loc_16 * _loc_16;
                            if (_loc_19 == 0)
                            {
                                _loc_17 = 0;
                            }
                            else
                            {
                                _loc_18 = 1597463007 - (0 >> 1);
                                _loc_28 = 0;
                                _loc_17 = 0 / (_loc_28 * (1.5 - 0.5 * _loc_19 * _loc_28 * _loc_28));
                            }
                            _loc_13 = _loc_17 - _loc_11.radius;
                            if (_loc_13 < 1000000000000000000000000000000)
                            {
                                if (_loc_17 == 0)
                                {
                                    _loc_15 = 1;
                                    _loc_16 = 0;
                                }
                                else
                                {
                                    _loc_19 = 1 / _loc_17;
                                    _loc_15 = _loc_15 * _loc_19;
                                    _loc_16 = _loc_16 * _loc_19;
                                }
                                _loc_18 = 0;
                                _loc_9.x = _loc_22.x + _loc_15 * _loc_18;
                                _loc_9.y = _loc_22.y + _loc_16 * _loc_18;
                                _loc_19 = -_loc_11.radius;
                                _loc_10.x = _loc_11.worldCOMx + _loc_15 * _loc_19;
                                _loc_10.y = _loc_11.worldCOMy + _loc_16 * _loc_19;
                                _loc_5.x = _loc_15;
                                _loc_5.y = _loc_16;
                            }
                        }
                        else if (_loc_14 >= _loc_27.y * _loc_24.gnormx - _loc_27.x * _loc_24.gnormy)
                        {
                            _loc_15 = 0;
                            _loc_16 = 0;
                            _loc_15 = _loc_11.worldCOMx - _loc_27.x;
                            _loc_16 = _loc_11.worldCOMy - _loc_27.y;
                            _loc_19 = _loc_15 * _loc_15 + _loc_16 * _loc_16;
                            if (_loc_19 == 0)
                            {
                                _loc_17 = 0;
                            }
                            else
                            {
                                _loc_18 = 1597463007 - (0 >> 1);
                                _loc_28 = 0;
                                _loc_17 = 0 / (_loc_28 * (1.5 - 0.5 * _loc_19 * _loc_28 * _loc_28));
                            }
                            _loc_13 = _loc_17 - _loc_11.radius;
                            if (_loc_13 < 1000000000000000000000000000000)
                            {
                                if (_loc_17 == 0)
                                {
                                    _loc_15 = 1;
                                    _loc_16 = 0;
                                }
                                else
                                {
                                    _loc_19 = 1 / _loc_17;
                                    _loc_15 = _loc_15 * _loc_19;
                                    _loc_16 = _loc_16 * _loc_19;
                                }
                                _loc_18 = 0;
                                _loc_9.x = _loc_27.x + _loc_15 * _loc_18;
                                _loc_9.y = _loc_27.y + _loc_16 * _loc_18;
                                _loc_19 = -_loc_11.radius;
                                _loc_10.x = _loc_11.worldCOMx + _loc_15 * _loc_19;
                                _loc_10.y = _loc_11.worldCOMy + _loc_16 * _loc_19;
                                _loc_5.x = _loc_15;
                                _loc_5.y = _loc_16;
                            }
                        }
                        else
                        {
                            _loc_15 = -_loc_11.radius;
                            _loc_10.x = _loc_11.worldCOMx + _loc_24.gnormx * _loc_15;
                            _loc_10.y = _loc_11.worldCOMy + _loc_24.gnormy * _loc_15;
                            _loc_15 = -_loc_13;
                            _loc_9.x = _loc_10.x + _loc_24.gnormx * _loc_15;
                            _loc_9.y = _loc_10.y + _loc_24.gnormy * _loc_15;
                            _loc_5.x = _loc_24.gnormx;
                            _loc_5.y = _loc_24.gnormy;
                        }
                    }
                    if (_loc_20)
                    {
                        _loc_5.x = -_loc_5.x;
                        _loc_5.y = -_loc_5.y;
                    }
                    _loc_6 = _loc_13;
                }
                else
                {
                    _loc_23 = _loc_7.polygon;
                    _loc_29 = _loc_8.polygon;
                    _loc_13 = -1000000000000000000000000000000;
                    _loc_24 = null;
                    _loc_26 = null;
                    _loc_18 = 0;
                    _loc_25 = _loc_23.edges.head;
                    while (_loc_25 != null)
                    {
                        
                        _loc_30 = _loc_25.elt;
                        _loc_14 = 1000000000000000000000000000000;
                        _loc_22 = _loc_29.gverts.next;
                        while (_loc_22 != null)
                        {
                            
                            _loc_27 = _loc_22;
                            _loc_15 = _loc_30.gnormx * _loc_27.x + _loc_30.gnormy * _loc_27.y;
                            if (_loc_15 < _loc_14)
                            {
                                _loc_14 = _loc_15;
                            }
                            _loc_22 = _loc_22.next;
                        }
                        _loc_14 = _loc_14 - _loc_30.gprojection;
                        if (_loc_14 > 1000000000000000000000000000000)
                        {
                            _loc_13 = _loc_14;
                            break;
                        }
                        if (_loc_14 > 0)
                        {
                            if (_loc_14 > _loc_13)
                            {
                                _loc_13 = _loc_14;
                                _loc_24 = _loc_30;
                                _loc_18 = 1;
                            }
                        }
                        else
                        {
                            if (_loc_13 < 0)
                            {
                            }
                            if (_loc_14 > _loc_13)
                            {
                                _loc_13 = _loc_14;
                                _loc_24 = _loc_30;
                                _loc_18 = 1;
                            }
                        }
                        _loc_25 = _loc_25.next;
                    }
                    if (_loc_13 < 1000000000000000000000000000000)
                    {
                        _loc_25 = _loc_29.edges.head;
                        while (_loc_25 != null)
                        {
                            
                            _loc_30 = _loc_25.elt;
                            _loc_14 = 1000000000000000000000000000000;
                            _loc_22 = _loc_23.gverts.next;
                            while (_loc_22 != null)
                            {
                                
                                _loc_27 = _loc_22;
                                _loc_15 = _loc_30.gnormx * _loc_27.x + _loc_30.gnormy * _loc_27.y;
                                if (_loc_15 < _loc_14)
                                {
                                    _loc_14 = _loc_15;
                                }
                                _loc_22 = _loc_22.next;
                            }
                            _loc_14 = _loc_14 - _loc_30.gprojection;
                            if (_loc_14 > 1000000000000000000000000000000)
                            {
                                _loc_13 = _loc_14;
                                break;
                            }
                            if (_loc_14 > 0)
                            {
                                if (_loc_14 > _loc_13)
                                {
                                    _loc_13 = _loc_14;
                                    _loc_26 = _loc_30;
                                    _loc_18 = 2;
                                }
                            }
                            else
                            {
                                if (_loc_13 < 0)
                                {
                                }
                                if (_loc_14 > _loc_13)
                                {
                                    _loc_13 = _loc_14;
                                    _loc_26 = _loc_30;
                                    _loc_18 = 2;
                                }
                            }
                            _loc_25 = _loc_25.next;
                        }
                        if (_loc_13 < 1000000000000000000000000000000)
                        {
                            if (_loc_18 == 1)
                            {
                                _loc_31 = _loc_23;
                                _loc_32 = _loc_29;
                                _loc_30 = _loc_24;
                            }
                            else
                            {
                                _loc_31 = _loc_29;
                                _loc_32 = _loc_23;
                                _loc_30 = _loc_26;
                                _loc_22 = _loc_9;
                                _loc_9 = _loc_10;
                                _loc_10 = _loc_22;
                                _loc_20 = !_loc_20;
                            }
                            _loc_33 = null;
                            _loc_14 = 1000000000000000000000000000000;
                            _loc_25 = _loc_32.edges.head;
                            while (_loc_25 != null)
                            {
                                
                                _loc_34 = _loc_25.elt;
                                _loc_15 = _loc_30.gnormx * _loc_34.gnormx + _loc_30.gnormy * _loc_34.gnormy;
                                if (_loc_15 < _loc_14)
                                {
                                    _loc_14 = _loc_15;
                                    _loc_33 = _loc_34;
                                }
                                _loc_25 = _loc_25.next;
                            }
                            if (_loc_20)
                            {
                                _loc_5.x = -_loc_30.gnormx;
                                _loc_5.y = -_loc_30.gnormy;
                            }
                            else
                            {
                                _loc_5.x = _loc_30.gnormx;
                                _loc_5.y = _loc_30.gnormy;
                            }
                            if (_loc_13 >= 0)
                            {
                                _loc_22 = _loc_30.gp0;
                                _loc_27 = _loc_30.gp1;
                                _loc_35 = _loc_33.gp0;
                                _loc_36 = _loc_33.gp1;
                                _loc_15 = 0;
                                _loc_16 = 0;
                                _loc_17 = 0;
                                _loc_19 = 0;
                                _loc_15 = _loc_27.x - _loc_22.x;
                                _loc_16 = _loc_27.y - _loc_22.y;
                                _loc_17 = _loc_36.x - _loc_35.x;
                                _loc_19 = _loc_36.y - _loc_35.y;
                                _loc_28 = 1 / (_loc_15 * _loc_15 + _loc_16 * _loc_16);
                                _loc_37 = 1 / (_loc_17 * _loc_17 + _loc_19 * _loc_19);
                                _loc_38 = (-(_loc_15 * (_loc_22.x - _loc_35.x) + _loc_16 * (_loc_22.y - _loc_35.y))) * _loc_28;
                                _loc_39 = (-(_loc_15 * (_loc_22.x - _loc_36.x) + _loc_16 * (_loc_22.y - _loc_36.y))) * _loc_28;
                                _loc_40 = (-(_loc_17 * (_loc_35.x - _loc_22.x) + _loc_19 * (_loc_35.y - _loc_22.y))) * _loc_37;
                                _loc_41 = (-(_loc_17 * (_loc_35.x - _loc_27.x) + _loc_19 * (_loc_35.y - _loc_27.y))) * _loc_37;
                                if (_loc_38 < 0)
                                {
                                    _loc_38 = 0;
                                }
                                else if (_loc_38 > 1)
                                {
                                    _loc_38 = 1;
                                }
                                if (_loc_39 < 0)
                                {
                                    _loc_39 = 0;
                                }
                                else if (_loc_39 > 1)
                                {
                                    _loc_39 = 1;
                                }
                                if (_loc_40 < 0)
                                {
                                    _loc_40 = 0;
                                }
                                else if (_loc_40 > 1)
                                {
                                    _loc_40 = 1;
                                }
                                if (_loc_41 < 0)
                                {
                                    _loc_41 = 0;
                                }
                                else if (_loc_41 > 1)
                                {
                                    _loc_41 = 1;
                                }
                                _loc_42 = 0;
                                _loc_43 = 0;
                                _loc_44 = _loc_38;
                                _loc_42 = _loc_22.x + _loc_15 * _loc_44;
                                _loc_43 = _loc_22.y + _loc_16 * _loc_44;
                                _loc_44 = 0;
                                _loc_45 = 0;
                                _loc_46 = _loc_39;
                                _loc_44 = _loc_22.x + _loc_15 * _loc_46;
                                _loc_45 = _loc_22.y + _loc_16 * _loc_46;
                                _loc_46 = 0;
                                _loc_47 = 0;
                                _loc_48 = _loc_40;
                                _loc_46 = _loc_35.x + _loc_17 * _loc_48;
                                _loc_47 = _loc_35.y + _loc_19 * _loc_48;
                                _loc_48 = 0;
                                _loc_49 = 0;
                                _loc_50 = _loc_41;
                                _loc_48 = _loc_35.x + _loc_17 * _loc_50;
                                _loc_49 = _loc_35.y + _loc_19 * _loc_50;
                                _loc_51 = 0;
                                _loc_52 = 0;
                                _loc_51 = _loc_42 - _loc_35.x;
                                _loc_52 = _loc_43 - _loc_35.y;
                                _loc_50 = _loc_51 * _loc_51 + _loc_52 * _loc_52;
                                _loc_52 = 0;
                                _loc_53 = 0;
                                _loc_52 = _loc_44 - _loc_36.x;
                                _loc_53 = _loc_45 - _loc_36.y;
                                _loc_51 = _loc_52 * _loc_52 + _loc_53 * _loc_53;
                                _loc_53 = 0;
                                _loc_54 = 0;
                                _loc_53 = _loc_46 - _loc_22.x;
                                _loc_54 = _loc_47 - _loc_22.y;
                                _loc_52 = _loc_53 * _loc_53 + _loc_54 * _loc_54;
                                _loc_54 = 0;
                                _loc_55 = 0;
                                _loc_54 = _loc_48 - _loc_27.x;
                                _loc_55 = _loc_49 - _loc_27.y;
                                _loc_53 = _loc_54 * _loc_54 + _loc_55 * _loc_55;
                                _loc_54 = 0;
                                _loc_55 = 0;
                                _loc_56 = null;
                                if (_loc_50 < _loc_51)
                                {
                                    _loc_54 = _loc_42;
                                    _loc_55 = _loc_43;
                                    _loc_56 = _loc_35;
                                }
                                else
                                {
                                    _loc_54 = _loc_44;
                                    _loc_55 = _loc_45;
                                    _loc_56 = _loc_36;
                                    _loc_50 = _loc_51;
                                }
                                _loc_57 = 0;
                                _loc_58 = 0;
                                _loc_59 = null;
                                if (_loc_52 < _loc_53)
                                {
                                    _loc_57 = _loc_46;
                                    _loc_58 = _loc_47;
                                    _loc_59 = _loc_22;
                                }
                                else
                                {
                                    _loc_57 = _loc_48;
                                    _loc_58 = _loc_49;
                                    _loc_59 = _loc_27;
                                    _loc_52 = _loc_53;
                                }
                                if (_loc_50 < _loc_52)
                                {
                                    _loc_9.x = _loc_54;
                                    _loc_9.y = _loc_55;
                                    _loc_10.x = _loc_56.x;
                                    _loc_10.y = _loc_56.y;
                                    _loc_13 = Math.sqrt(_loc_50);
                                }
                                else
                                {
                                    _loc_10.x = _loc_57;
                                    _loc_10.y = _loc_58;
                                    _loc_9.x = _loc_59.x;
                                    _loc_9.y = _loc_59.y;
                                    _loc_13 = Math.sqrt(_loc_52);
                                }
                                if (_loc_13 != 0)
                                {
                                    _loc_5.x = _loc_10.x - _loc_9.x;
                                    _loc_5.y = _loc_10.y - _loc_9.y;
                                    _loc_60 = 1 / _loc_13;
                                    _loc_5.x = _loc_5.x * _loc_60;
                                    _loc_5.y = _loc_5.y * _loc_60;
                                    if (_loc_20)
                                    {
                                        _loc_5.x = -_loc_5.x;
                                        _loc_5.y = -_loc_5.y;
                                    }
                                }
                                _loc_6 = _loc_13;
                            }
                            else
                            {
                                _loc_15 = 0;
                                _loc_16 = 0;
                                _loc_15 = _loc_33.gp0.x;
                                _loc_16 = _loc_33.gp0.y;
                                _loc_17 = 0;
                                _loc_19 = 0;
                                _loc_17 = _loc_33.gp1.x;
                                _loc_19 = _loc_33.gp1.y;
                                _loc_28 = 0;
                                _loc_37 = 0;
                                _loc_28 = _loc_17 - _loc_15;
                                _loc_37 = _loc_19 - _loc_16;
                                _loc_38 = _loc_30.gnormy * _loc_15 - _loc_30.gnormx * _loc_16;
                                _loc_39 = _loc_30.gnormy * _loc_17 - _loc_30.gnormx * _loc_19;
                                _loc_40 = 1 / (_loc_39 - _loc_38);
                                _loc_41 = (-_loc_30.tp1 - _loc_38) * _loc_40;
                                if (_loc_41 > Config.epsilon)
                                {
                                    _loc_42 = _loc_41;
                                    _loc_15 = _loc_15 + _loc_28 * _loc_42;
                                    _loc_16 = _loc_16 + _loc_37 * _loc_42;
                                }
                                _loc_42 = (-_loc_30.tp0 - _loc_39) * _loc_40;
                                if (_loc_42 < -Config.epsilon)
                                {
                                    _loc_43 = _loc_42;
                                    _loc_17 = _loc_17 + _loc_28 * _loc_43;
                                    _loc_19 = _loc_19 + _loc_37 * _loc_43;
                                }
                                _loc_43 = _loc_15 * _loc_30.gnormx + _loc_16 * _loc_30.gnormy - _loc_30.gprojection;
                                _loc_44 = _loc_17 * _loc_30.gnormx + _loc_19 * _loc_30.gnormy - _loc_30.gprojection;
                                if (_loc_43 < _loc_44)
                                {
                                    _loc_10.x = _loc_15;
                                    _loc_10.y = _loc_16;
                                    _loc_45 = -_loc_43;
                                    _loc_9.x = _loc_10.x + _loc_30.gnormx * _loc_45;
                                    _loc_9.y = _loc_10.y + _loc_30.gnormy * _loc_45;
                                    _loc_6 = _loc_43;
                                }
                                else
                                {
                                    _loc_10.x = _loc_17;
                                    _loc_10.y = _loc_19;
                                    _loc_45 = -_loc_44;
                                    _loc_9.x = _loc_10.x + _loc_30.gnormx * _loc_45;
                                    _loc_9.y = _loc_10.y + _loc_30.gnormy * _loc_45;
                                    _loc_6 = _loc_44;
                                }
                            }
                        }
                        else
                        {
                            _loc_6 = 1000000000000000000000000000000;
                        }
                    }
                    else
                    {
                        _loc_6 = 1000000000000000000000000000000;
                    }
                }
            }
            _loc_9 = _loc_5;
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
            return _loc_6;
        }// end function

        public static function intersectsBody(param1:Body, param2:Body) : Boolean
        {
            var _loc_3:* = null as ShapeList;
            var _loc_4:* = null as ZNPNode_ZPP_Shape;
            var _loc_5:* = null as ZPP_Shape;
            var _loc_8:* = null as ZNPNode_ZPP_Shape;
            var _loc_9:* = null as ZPP_Shape;
            _loc_3 = param1.zpp_inner.wrap_shapes;
            if (_loc_3.zpp_inner.inner.head != null)
            {
                _loc_3 = param2.zpp_inner.wrap_shapes;
            }
            if (_loc_3.zpp_inner.inner.head == null)
            {
                throw "Error: Bodies must have shapes to test for intersection.";
            }
            _loc_4 = param1.zpp_inner.shapes.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                ZPP_Geom.validateShape(_loc_5);
                _loc_4 = _loc_4.next;
            }
            _loc_4 = param2.zpp_inner.shapes.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                ZPP_Geom.validateShape(_loc_5);
                _loc_4 = _loc_4.next;
            }
            var _loc_6:* = param1.zpp_inner.aabb;
            var _loc_7:* = param2.zpp_inner.aabb;
            if (_loc_7.miny <= _loc_6.maxy)
            {
            }
            if (_loc_6.miny <= _loc_7.maxy)
            {
            }
            if (_loc_7.minx <= _loc_6.maxx)
            {
            }
            if (_loc_6.minx > _loc_7.maxx)
            {
                return false;
            }
            else
            {
                _loc_4 = param1.zpp_inner.shapes.head;
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.elt;
                    _loc_8 = param2.zpp_inner.shapes.head;
                    while (_loc_8 != null)
                    {
                        
                        _loc_9 = _loc_8.elt;
                        if (ZPP_Collide.testCollide_safe(_loc_5, _loc_9))
                        {
                            return true;
                        }
                        _loc_8 = _loc_8.next;
                    }
                    _loc_4 = _loc_4.next;
                }
                return false;
            }
        }// end function

        public static function intersects(param1:Shape, param2:Shape) : Boolean
        {
            if ((param1.zpp_inner.body != null ? (param1.zpp_inner.body.outer) : (null)) != null)
            {
            }
            if ((param2.zpp_inner.body != null ? (param2.zpp_inner.body.outer) : (null)) == null)
            {
                throw "Error: Shape must be part of a Body to calculate intersection";
            }
            ZPP_Geom.validateShape(param1.zpp_inner);
            ZPP_Geom.validateShape(param2.zpp_inner);
            var _loc_3:* = param1.zpp_inner.aabb;
            var _loc_4:* = param2.zpp_inner.aabb;
            if (_loc_4.miny <= _loc_3.maxy)
            {
            }
            if (_loc_3.miny <= _loc_4.maxy)
            {
            }
            if (_loc_4.minx <= _loc_3.maxx)
            {
            }
            if (_loc_3.minx <= _loc_4.maxx)
            {
            }
            return ZPP_Collide.testCollide_safe(param1.zpp_inner, param2.zpp_inner);
        }// end function

        public static function contains(param1:Shape, param2:Shape) : Boolean
        {
            if ((param1.zpp_inner.body != null ? (param1.zpp_inner.body.outer) : (null)) != null)
            {
            }
            if ((param2.zpp_inner.body != null ? (param2.zpp_inner.body.outer) : (null)) == null)
            {
                throw "Error: Shape must be part of a Body to calculate containment";
            }
            ZPP_Geom.validateShape(param1.zpp_inner);
            ZPP_Geom.validateShape(param2.zpp_inner);
            return ZPP_Collide.containTest(param1.zpp_inner, param2.zpp_inner);
        }// end function

    }
}
