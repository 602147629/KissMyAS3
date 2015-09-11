package zpp_nape.geom
{
    import nape.*;
    import nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_SweepDistance extends Object
    {

        public function ZPP_SweepDistance() : void
        {
            return;
        }// end function

        public static function dynamicSweep(event:ZPP_ToiEvent, param2:Number, param3:Number, param4:Number, param5:Boolean = false) : void
        {
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = null as ZPP_Polygon;
            var _loc_28:* = null as ZPP_Vec2;
            var _loc_29:* = null as ZPP_Vec2;
            var _loc_30:* = null as ZPP_Vec2;
            var _loc_31:* = null as ZPP_Vec2;
            var _loc_32:* = null as ZNPNode_ZPP_Edge;
            var _loc_33:* = null as ZPP_Edge;
            var _loc_34:* = null as ZPP_Shape;
            var _loc_35:* = null as ZPP_Shape;
            var _loc_36:* = null as ZPP_Circle;
            var _loc_37:* = null as ZPP_Circle;
            var _loc_38:* = 0;
            var _loc_39:* = NaN;
            var _loc_40:* = false;
            var _loc_41:* = null as ZPP_Shape;
            var _loc_42:* = null as ZPP_Edge;
            var _loc_43:* = NaN;
            var _loc_44:* = null as ZPP_Polygon;
            var _loc_45:* = null as ZPP_Edge;
            var _loc_46:* = null as ZPP_Polygon;
            var _loc_47:* = null as ZPP_Polygon;
            var _loc_48:* = null as ZPP_Edge;
            var _loc_49:* = null as ZPP_Edge;
            var _loc_50:* = null as ZPP_Vec2;
            var _loc_51:* = null as ZPP_Vec2;
            var _loc_52:* = NaN;
            var _loc_53:* = NaN;
            var _loc_54:* = NaN;
            var _loc_55:* = NaN;
            var _loc_56:* = NaN;
            var _loc_57:* = NaN;
            var _loc_58:* = NaN;
            var _loc_59:* = NaN;
            var _loc_60:* = NaN;
            var _loc_61:* = NaN;
            var _loc_62:* = NaN;
            var _loc_63:* = NaN;
            var _loc_64:* = NaN;
            var _loc_65:* = NaN;
            var _loc_66:* = NaN;
            var _loc_67:* = NaN;
            var _loc_68:* = NaN;
            var _loc_69:* = NaN;
            var _loc_70:* = NaN;
            var _loc_71:* = null as ZPP_Vec2;
            var _loc_72:* = NaN;
            var _loc_73:* = NaN;
            var _loc_74:* = null as ZPP_Vec2;
            var _loc_75:* = NaN;
            var _loc_76:* = NaN;
            var _loc_77:* = NaN;
            var _loc_78:* = NaN;
            var _loc_79:* = NaN;
            var _loc_6:* = event.s1;
            var _loc_7:* = event.s2;
            var _loc_8:* = _loc_6.body;
            var _loc_9:* = _loc_7.body;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            _loc_10 = _loc_9.velx - _loc_8.velx;
            _loc_11 = _loc_9.vely - _loc_8.vely;
            var _loc_12:* = _loc_8.angvel;
            if (_loc_12 < 0)
            {
                _loc_12 = -_loc_12;
            }
            var _loc_13:* = _loc_9.angvel;
            if (_loc_13 < 0)
            {
                _loc_13 = -_loc_13;
            }
            var _loc_14:* = _loc_6.sweepCoef * _loc_12 + _loc_7.sweepCoef * _loc_13;
            if (!param5)
            {
            }
            if (!event.kinematic)
            {
            }
            if (_loc_10 * _loc_10 + _loc_11 * _loc_11 < Config.dynamicSweepLinearThreshold * Config.dynamicSweepLinearThreshold)
            {
            }
            if (_loc_14 < Config.dynamicSweepAngularThreshold)
            {
                event.toi = -1;
                event.failed = true;
                return;
            }
            var _loc_15:* = event.c1;
            var _loc_16:* = event.c2;
            var _loc_17:* = event.axis;
            var _loc_18:* = param3;
            var _loc_19:* = 0;
            while (true)
            {
                
                _loc_20 = _loc_18 * param2;
                _loc_21 = _loc_20 - _loc_8.sweepTime;
                if (_loc_21 != 0)
                {
                    _loc_8.sweepTime = _loc_20;
                    _loc_22 = _loc_21;
                    _loc_8.posx = _loc_8.posx + _loc_8.velx * _loc_22;
                    _loc_8.posy = _loc_8.posy + _loc_8.vely * _loc_22;
                    if (_loc_8.angvel != 0)
                    {
                        _loc_22 = _loc_8.sweep_angvel * _loc_21;
                        _loc_8.rot = _loc_8.rot + _loc_22;
                        if (_loc_22 * _loc_22 > 0.0001)
                        {
                            _loc_8.axisx = Math.sin(_loc_8.rot);
                            _loc_8.axisy = Math.cos(_loc_8.rot);
                        }
                        else
                        {
                            _loc_23 = _loc_22 * _loc_22;
                            _loc_24 = 1 - 0.5 * _loc_23;
                            _loc_25 = 1 - _loc_23 * _loc_23 / 8;
                            _loc_26 = (_loc_24 * _loc_8.axisx + _loc_22 * _loc_8.axisy) * _loc_25;
                            _loc_8.axisy = (_loc_24 * _loc_8.axisy - _loc_22 * _loc_8.axisx) * _loc_25;
                            _loc_8.axisx = _loc_26;
                        }
                    }
                }
                if (_loc_6.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    _loc_6.worldCOMx = _loc_8.posx + (_loc_8.axisy * _loc_6.localCOMx - _loc_8.axisx * _loc_6.localCOMy);
                    _loc_6.worldCOMy = _loc_8.posy + (_loc_6.localCOMx * _loc_8.axisx + _loc_6.localCOMy * _loc_8.axisy);
                }
                else
                {
                    _loc_27 = _loc_6.polygon;
                    _loc_28 = _loc_27.lverts.next;
                    _loc_29 = _loc_27.gverts.next;
                    while (_loc_29 != null)
                    {
                        
                        _loc_30 = _loc_29;
                        _loc_31 = _loc_28;
                        _loc_28 = _loc_28.next;
                        _loc_30.x = _loc_8.posx + (_loc_8.axisy * _loc_31.x - _loc_8.axisx * _loc_31.y);
                        _loc_30.y = _loc_8.posy + (_loc_31.x * _loc_8.axisx + _loc_31.y * _loc_8.axisy);
                        _loc_29 = _loc_29.next;
                    }
                    _loc_32 = _loc_27.edges.head;
                    _loc_29 = _loc_27.gverts.next;
                    _loc_30 = _loc_29;
                    _loc_29 = _loc_29.next;
                    while (_loc_29 != null)
                    {
                        
                        _loc_31 = _loc_29;
                        _loc_33 = _loc_32.elt;
                        _loc_32 = _loc_32.next;
                        _loc_33.gnormx = _loc_8.axisy * _loc_33.lnormx - _loc_8.axisx * _loc_33.lnormy;
                        _loc_33.gnormy = _loc_33.lnormx * _loc_8.axisx + _loc_33.lnormy * _loc_8.axisy;
                        _loc_33.gprojection = _loc_8.posx * _loc_33.gnormx + _loc_8.posy * _loc_33.gnormy + _loc_33.lprojection;
                        _loc_33.tp0 = _loc_30.y * _loc_33.gnormx - _loc_30.x * _loc_33.gnormy;
                        _loc_33.tp1 = _loc_31.y * _loc_33.gnormx - _loc_31.x * _loc_33.gnormy;
                        _loc_30 = _loc_31;
                        _loc_29 = _loc_29.next;
                    }
                    _loc_31 = _loc_27.gverts.next;
                    _loc_33 = _loc_32.elt;
                    _loc_32 = _loc_32.next;
                    _loc_33.gnormx = _loc_8.axisy * _loc_33.lnormx - _loc_8.axisx * _loc_33.lnormy;
                    _loc_33.gnormy = _loc_33.lnormx * _loc_8.axisx + _loc_33.lnormy * _loc_8.axisy;
                    _loc_33.gprojection = _loc_8.posx * _loc_33.gnormx + _loc_8.posy * _loc_33.gnormy + _loc_33.lprojection;
                    _loc_33.tp0 = _loc_30.y * _loc_33.gnormx - _loc_30.x * _loc_33.gnormy;
                    _loc_33.tp1 = _loc_31.y * _loc_33.gnormx - _loc_31.x * _loc_33.gnormy;
                }
                _loc_20 = _loc_18 * param2;
                _loc_21 = _loc_20 - _loc_9.sweepTime;
                if (_loc_21 != 0)
                {
                    _loc_9.sweepTime = _loc_20;
                    _loc_22 = _loc_21;
                    _loc_9.posx = _loc_9.posx + _loc_9.velx * _loc_22;
                    _loc_9.posy = _loc_9.posy + _loc_9.vely * _loc_22;
                    if (_loc_9.angvel != 0)
                    {
                        _loc_22 = _loc_9.sweep_angvel * _loc_21;
                        _loc_9.rot = _loc_9.rot + _loc_22;
                        if (_loc_22 * _loc_22 > 0.0001)
                        {
                            _loc_9.axisx = Math.sin(_loc_9.rot);
                            _loc_9.axisy = Math.cos(_loc_9.rot);
                        }
                        else
                        {
                            _loc_23 = _loc_22 * _loc_22;
                            _loc_24 = 1 - 0.5 * _loc_23;
                            _loc_25 = 1 - _loc_23 * _loc_23 / 8;
                            _loc_26 = (_loc_24 * _loc_9.axisx + _loc_22 * _loc_9.axisy) * _loc_25;
                            _loc_9.axisy = (_loc_24 * _loc_9.axisy - _loc_22 * _loc_9.axisx) * _loc_25;
                            _loc_9.axisx = _loc_26;
                        }
                    }
                }
                if (_loc_7.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    _loc_7.worldCOMx = _loc_9.posx + (_loc_9.axisy * _loc_7.localCOMx - _loc_9.axisx * _loc_7.localCOMy);
                    _loc_7.worldCOMy = _loc_9.posy + (_loc_7.localCOMx * _loc_9.axisx + _loc_7.localCOMy * _loc_9.axisy);
                }
                else
                {
                    _loc_27 = _loc_7.polygon;
                    _loc_28 = _loc_27.lverts.next;
                    _loc_29 = _loc_27.gverts.next;
                    while (_loc_29 != null)
                    {
                        
                        _loc_30 = _loc_29;
                        _loc_31 = _loc_28;
                        _loc_28 = _loc_28.next;
                        _loc_30.x = _loc_9.posx + (_loc_9.axisy * _loc_31.x - _loc_9.axisx * _loc_31.y);
                        _loc_30.y = _loc_9.posy + (_loc_31.x * _loc_9.axisx + _loc_31.y * _loc_9.axisy);
                        _loc_29 = _loc_29.next;
                    }
                    _loc_32 = _loc_27.edges.head;
                    _loc_29 = _loc_27.gverts.next;
                    _loc_30 = _loc_29;
                    _loc_29 = _loc_29.next;
                    while (_loc_29 != null)
                    {
                        
                        _loc_31 = _loc_29;
                        _loc_33 = _loc_32.elt;
                        _loc_32 = _loc_32.next;
                        _loc_33.gnormx = _loc_9.axisy * _loc_33.lnormx - _loc_9.axisx * _loc_33.lnormy;
                        _loc_33.gnormy = _loc_33.lnormx * _loc_9.axisx + _loc_33.lnormy * _loc_9.axisy;
                        _loc_33.gprojection = _loc_9.posx * _loc_33.gnormx + _loc_9.posy * _loc_33.gnormy + _loc_33.lprojection;
                        _loc_33.tp0 = _loc_30.y * _loc_33.gnormx - _loc_30.x * _loc_33.gnormy;
                        _loc_33.tp1 = _loc_31.y * _loc_33.gnormx - _loc_31.x * _loc_33.gnormy;
                        _loc_30 = _loc_31;
                        _loc_29 = _loc_29.next;
                    }
                    _loc_31 = _loc_27.gverts.next;
                    _loc_33 = _loc_32.elt;
                    _loc_32 = _loc_32.next;
                    _loc_33.gnormx = _loc_9.axisy * _loc_33.lnormx - _loc_9.axisx * _loc_33.lnormy;
                    _loc_33.gnormy = _loc_33.lnormx * _loc_9.axisx + _loc_33.lnormy * _loc_9.axisy;
                    _loc_33.gprojection = _loc_9.posx * _loc_33.gnormx + _loc_9.posy * _loc_33.gnormy + _loc_33.lprojection;
                    _loc_33.tp0 = _loc_30.y * _loc_33.gnormx - _loc_30.x * _loc_33.gnormy;
                    _loc_33.tp1 = _loc_31.y * _loc_33.gnormx - _loc_31.x * _loc_33.gnormy;
                }
                _loc_34 = _loc_6;
                _loc_35 = _loc_7;
                _loc_28 = _loc_15;
                _loc_29 = _loc_16;
                _loc_21 = 1000000000000000000000000000000;
                if (_loc_34.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                }
                if (_loc_35.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    _loc_36 = _loc_34.circle;
                    _loc_37 = _loc_35.circle;
                    _loc_23 = 0;
                    _loc_24 = 0;
                    _loc_23 = _loc_37.worldCOMx - _loc_36.worldCOMx;
                    _loc_24 = _loc_37.worldCOMy - _loc_36.worldCOMy;
                    _loc_26 = _loc_23 * _loc_23 + _loc_24 * _loc_24;
                    if (_loc_26 == 0)
                    {
                        _loc_25 = 0;
                    }
                    else
                    {
                        _loc_38 = 1597463007 - (0 >> 1);
                        _loc_39 = 0;
                        _loc_25 = 0 / (_loc_39 * (1.5 - 0.5 * _loc_26 * _loc_39 * _loc_39));
                    }
                    _loc_22 = _loc_25 - (_loc_36.radius + _loc_37.radius);
                    if (_loc_22 < _loc_21)
                    {
                        if (_loc_25 == 0)
                        {
                            _loc_23 = 1;
                            _loc_24 = 0;
                        }
                        else
                        {
                            _loc_26 = 1 / _loc_25;
                            _loc_23 = _loc_23 * _loc_26;
                            _loc_24 = _loc_24 * _loc_26;
                        }
                        _loc_26 = _loc_36.radius;
                        _loc_28.x = _loc_36.worldCOMx + _loc_23 * _loc_26;
                        _loc_28.y = _loc_36.worldCOMy + _loc_24 * _loc_26;
                        _loc_26 = -_loc_37.radius;
                        _loc_29.x = _loc_37.worldCOMx + _loc_23 * _loc_26;
                        _loc_29.y = _loc_37.worldCOMy + _loc_24 * _loc_26;
                        _loc_17.x = _loc_23;
                        _loc_17.y = _loc_24;
                    }
                }
                else
                {
                    _loc_40 = false;
                    if (_loc_34.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                    }
                    if (_loc_35.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                        _loc_41 = _loc_34;
                        _loc_34 = _loc_35;
                        _loc_35 = _loc_41;
                        _loc_30 = _loc_28;
                        _loc_28 = _loc_29;
                        _loc_29 = _loc_30;
                        _loc_40 = true;
                    }
                    if (_loc_34.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                    }
                    if (_loc_35.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_27 = _loc_34.polygon;
                        _loc_36 = _loc_35.circle;
                        _loc_22 = -1000000000000000000000000000000;
                        _loc_33 = null;
                        _loc_32 = _loc_27.edges.head;
                        while (_loc_32 != null)
                        {
                            
                            _loc_42 = _loc_32.elt;
                            _loc_23 = _loc_42.gnormx * _loc_36.worldCOMx + _loc_42.gnormy * _loc_36.worldCOMy - _loc_42.gprojection - _loc_36.radius;
                            if (_loc_23 > _loc_21)
                            {
                                _loc_22 = _loc_23;
                                break;
                            }
                            if (_loc_23 > 0)
                            {
                                if (_loc_23 > _loc_22)
                                {
                                    _loc_22 = _loc_23;
                                    _loc_33 = _loc_42;
                                }
                            }
                            else
                            {
                                if (_loc_22 < 0)
                                {
                                }
                                if (_loc_23 > _loc_22)
                                {
                                    _loc_22 = _loc_23;
                                    _loc_33 = _loc_42;
                                }
                            }
                            _loc_32 = _loc_32.next;
                        }
                        if (_loc_22 < _loc_21)
                        {
                            _loc_30 = _loc_33.gp0;
                            _loc_31 = _loc_33.gp1;
                            _loc_23 = _loc_36.worldCOMy * _loc_33.gnormx - _loc_36.worldCOMx * _loc_33.gnormy;
                            if (_loc_23 <= _loc_30.y * _loc_33.gnormx - _loc_30.x * _loc_33.gnormy)
                            {
                                _loc_24 = 0;
                                _loc_25 = 0;
                                _loc_24 = _loc_36.worldCOMx - _loc_30.x;
                                _loc_25 = _loc_36.worldCOMy - _loc_30.y;
                                _loc_39 = _loc_24 * _loc_24 + _loc_25 * _loc_25;
                                if (_loc_39 == 0)
                                {
                                    _loc_26 = 0;
                                }
                                else
                                {
                                    _loc_38 = 1597463007 - (0 >> 1);
                                    _loc_43 = 0;
                                    _loc_26 = 0 / (_loc_43 * (1.5 - 0.5 * _loc_39 * _loc_43 * _loc_43));
                                }
                                _loc_22 = _loc_26 - _loc_36.radius;
                                if (_loc_22 < _loc_21)
                                {
                                    if (_loc_26 == 0)
                                    {
                                        _loc_24 = 1;
                                        _loc_25 = 0;
                                    }
                                    else
                                    {
                                        _loc_39 = 1 / _loc_26;
                                        _loc_24 = _loc_24 * _loc_39;
                                        _loc_25 = _loc_25 * _loc_39;
                                    }
                                    _loc_38 = 0;
                                    _loc_28.x = _loc_30.x + _loc_24 * _loc_38;
                                    _loc_28.y = _loc_30.y + _loc_25 * _loc_38;
                                    _loc_39 = -_loc_36.radius;
                                    _loc_29.x = _loc_36.worldCOMx + _loc_24 * _loc_39;
                                    _loc_29.y = _loc_36.worldCOMy + _loc_25 * _loc_39;
                                    _loc_17.x = _loc_24;
                                    _loc_17.y = _loc_25;
                                }
                            }
                            else if (_loc_23 >= _loc_31.y * _loc_33.gnormx - _loc_31.x * _loc_33.gnormy)
                            {
                                _loc_24 = 0;
                                _loc_25 = 0;
                                _loc_24 = _loc_36.worldCOMx - _loc_31.x;
                                _loc_25 = _loc_36.worldCOMy - _loc_31.y;
                                _loc_39 = _loc_24 * _loc_24 + _loc_25 * _loc_25;
                                if (_loc_39 == 0)
                                {
                                    _loc_26 = 0;
                                }
                                else
                                {
                                    _loc_38 = 1597463007 - (0 >> 1);
                                    _loc_43 = 0;
                                    _loc_26 = 0 / (_loc_43 * (1.5 - 0.5 * _loc_39 * _loc_43 * _loc_43));
                                }
                                _loc_22 = _loc_26 - _loc_36.radius;
                                if (_loc_22 < _loc_21)
                                {
                                    if (_loc_26 == 0)
                                    {
                                        _loc_24 = 1;
                                        _loc_25 = 0;
                                    }
                                    else
                                    {
                                        _loc_39 = 1 / _loc_26;
                                        _loc_24 = _loc_24 * _loc_39;
                                        _loc_25 = _loc_25 * _loc_39;
                                    }
                                    _loc_38 = 0;
                                    _loc_28.x = _loc_31.x + _loc_24 * _loc_38;
                                    _loc_28.y = _loc_31.y + _loc_25 * _loc_38;
                                    _loc_39 = -_loc_36.radius;
                                    _loc_29.x = _loc_36.worldCOMx + _loc_24 * _loc_39;
                                    _loc_29.y = _loc_36.worldCOMy + _loc_25 * _loc_39;
                                    _loc_17.x = _loc_24;
                                    _loc_17.y = _loc_25;
                                }
                            }
                            else
                            {
                                _loc_24 = -_loc_36.radius;
                                _loc_29.x = _loc_36.worldCOMx + _loc_33.gnormx * _loc_24;
                                _loc_29.y = _loc_36.worldCOMy + _loc_33.gnormy * _loc_24;
                                _loc_24 = -_loc_22;
                                _loc_28.x = _loc_29.x + _loc_33.gnormx * _loc_24;
                                _loc_28.y = _loc_29.y + _loc_33.gnormy * _loc_24;
                                _loc_17.x = _loc_33.gnormx;
                                _loc_17.y = _loc_33.gnormy;
                            }
                        }
                        if (_loc_40)
                        {
                            _loc_17.x = -_loc_17.x;
                            _loc_17.y = -_loc_17.y;
                        }
                    }
                    else
                    {
                        _loc_27 = _loc_34.polygon;
                        _loc_44 = _loc_35.polygon;
                        _loc_22 = -1000000000000000000000000000000;
                        _loc_33 = null;
                        _loc_42 = null;
                        _loc_38 = 0;
                        _loc_32 = _loc_27.edges.head;
                        while (_loc_32 != null)
                        {
                            
                            _loc_45 = _loc_32.elt;
                            _loc_23 = 1000000000000000000000000000000;
                            _loc_30 = _loc_44.gverts.next;
                            while (_loc_30 != null)
                            {
                                
                                _loc_31 = _loc_30;
                                _loc_24 = _loc_45.gnormx * _loc_31.x + _loc_45.gnormy * _loc_31.y;
                                if (_loc_24 < _loc_23)
                                {
                                    _loc_23 = _loc_24;
                                }
                                _loc_30 = _loc_30.next;
                            }
                            _loc_23 = _loc_23 - _loc_45.gprojection;
                            if (_loc_23 > _loc_21)
                            {
                                _loc_22 = _loc_23;
                                break;
                            }
                            if (_loc_23 > 0)
                            {
                                if (_loc_23 > _loc_22)
                                {
                                    _loc_22 = _loc_23;
                                    _loc_33 = _loc_45;
                                    _loc_38 = 1;
                                }
                            }
                            else
                            {
                                if (_loc_22 < 0)
                                {
                                }
                                if (_loc_23 > _loc_22)
                                {
                                    _loc_22 = _loc_23;
                                    _loc_33 = _loc_45;
                                    _loc_38 = 1;
                                }
                            }
                            _loc_32 = _loc_32.next;
                        }
                        if (_loc_22 < _loc_21)
                        {
                            _loc_32 = _loc_44.edges.head;
                            while (_loc_32 != null)
                            {
                                
                                _loc_45 = _loc_32.elt;
                                _loc_23 = 1000000000000000000000000000000;
                                _loc_30 = _loc_27.gverts.next;
                                while (_loc_30 != null)
                                {
                                    
                                    _loc_31 = _loc_30;
                                    _loc_24 = _loc_45.gnormx * _loc_31.x + _loc_45.gnormy * _loc_31.y;
                                    if (_loc_24 < _loc_23)
                                    {
                                        _loc_23 = _loc_24;
                                    }
                                    _loc_30 = _loc_30.next;
                                }
                                _loc_23 = _loc_23 - _loc_45.gprojection;
                                if (_loc_23 > _loc_21)
                                {
                                    _loc_22 = _loc_23;
                                    break;
                                }
                                if (_loc_23 > 0)
                                {
                                    if (_loc_23 > _loc_22)
                                    {
                                        _loc_22 = _loc_23;
                                        _loc_42 = _loc_45;
                                        _loc_38 = 2;
                                    }
                                }
                                else
                                {
                                    if (_loc_22 < 0)
                                    {
                                    }
                                    if (_loc_23 > _loc_22)
                                    {
                                        _loc_22 = _loc_23;
                                        _loc_42 = _loc_45;
                                        _loc_38 = 2;
                                    }
                                }
                                _loc_32 = _loc_32.next;
                            }
                            if (_loc_22 < _loc_21)
                            {
                                if (_loc_38 == 1)
                                {
                                    _loc_46 = _loc_27;
                                    _loc_47 = _loc_44;
                                    _loc_45 = _loc_33;
                                }
                                else
                                {
                                    _loc_46 = _loc_44;
                                    _loc_47 = _loc_27;
                                    _loc_45 = _loc_42;
                                    _loc_30 = _loc_28;
                                    _loc_28 = _loc_29;
                                    _loc_29 = _loc_30;
                                    _loc_40 = !_loc_40;
                                }
                                _loc_48 = null;
                                _loc_23 = 1000000000000000000000000000000;
                                _loc_32 = _loc_47.edges.head;
                                while (_loc_32 != null)
                                {
                                    
                                    _loc_49 = _loc_32.elt;
                                    _loc_24 = _loc_45.gnormx * _loc_49.gnormx + _loc_45.gnormy * _loc_49.gnormy;
                                    if (_loc_24 < _loc_23)
                                    {
                                        _loc_23 = _loc_24;
                                        _loc_48 = _loc_49;
                                    }
                                    _loc_32 = _loc_32.next;
                                }
                                if (_loc_40)
                                {
                                    _loc_17.x = -_loc_45.gnormx;
                                    _loc_17.y = -_loc_45.gnormy;
                                }
                                else
                                {
                                    _loc_17.x = _loc_45.gnormx;
                                    _loc_17.y = _loc_45.gnormy;
                                }
                                if (_loc_22 >= 0)
                                {
                                    _loc_30 = _loc_45.gp0;
                                    _loc_31 = _loc_45.gp1;
                                    _loc_50 = _loc_48.gp0;
                                    _loc_51 = _loc_48.gp1;
                                    _loc_24 = 0;
                                    _loc_25 = 0;
                                    _loc_26 = 0;
                                    _loc_39 = 0;
                                    _loc_24 = _loc_31.x - _loc_30.x;
                                    _loc_25 = _loc_31.y - _loc_30.y;
                                    _loc_26 = _loc_51.x - _loc_50.x;
                                    _loc_39 = _loc_51.y - _loc_50.y;
                                    _loc_43 = 1 / (_loc_24 * _loc_24 + _loc_25 * _loc_25);
                                    _loc_52 = 1 / (_loc_26 * _loc_26 + _loc_39 * _loc_39);
                                    _loc_53 = (-(_loc_24 * (_loc_30.x - _loc_50.x) + _loc_25 * (_loc_30.y - _loc_50.y))) * _loc_43;
                                    _loc_54 = (-(_loc_24 * (_loc_30.x - _loc_51.x) + _loc_25 * (_loc_30.y - _loc_51.y))) * _loc_43;
                                    _loc_55 = (-(_loc_26 * (_loc_50.x - _loc_30.x) + _loc_39 * (_loc_50.y - _loc_30.y))) * _loc_52;
                                    _loc_56 = (-(_loc_26 * (_loc_50.x - _loc_31.x) + _loc_39 * (_loc_50.y - _loc_31.y))) * _loc_52;
                                    if (_loc_53 < 0)
                                    {
                                        _loc_53 = 0;
                                    }
                                    else if (_loc_53 > 1)
                                    {
                                        _loc_53 = 1;
                                    }
                                    if (_loc_54 < 0)
                                    {
                                        _loc_54 = 0;
                                    }
                                    else if (_loc_54 > 1)
                                    {
                                        _loc_54 = 1;
                                    }
                                    if (_loc_55 < 0)
                                    {
                                        _loc_55 = 0;
                                    }
                                    else if (_loc_55 > 1)
                                    {
                                        _loc_55 = 1;
                                    }
                                    if (_loc_56 < 0)
                                    {
                                        _loc_56 = 0;
                                    }
                                    else if (_loc_56 > 1)
                                    {
                                        _loc_56 = 1;
                                    }
                                    _loc_57 = 0;
                                    _loc_58 = 0;
                                    _loc_59 = _loc_53;
                                    _loc_57 = _loc_30.x + _loc_24 * _loc_59;
                                    _loc_58 = _loc_30.y + _loc_25 * _loc_59;
                                    _loc_59 = 0;
                                    _loc_60 = 0;
                                    _loc_61 = _loc_54;
                                    _loc_59 = _loc_30.x + _loc_24 * _loc_61;
                                    _loc_60 = _loc_30.y + _loc_25 * _loc_61;
                                    _loc_61 = 0;
                                    _loc_62 = 0;
                                    _loc_63 = _loc_55;
                                    _loc_61 = _loc_50.x + _loc_26 * _loc_63;
                                    _loc_62 = _loc_50.y + _loc_39 * _loc_63;
                                    _loc_63 = 0;
                                    _loc_64 = 0;
                                    _loc_65 = _loc_56;
                                    _loc_63 = _loc_50.x + _loc_26 * _loc_65;
                                    _loc_64 = _loc_50.y + _loc_39 * _loc_65;
                                    _loc_66 = 0;
                                    _loc_67 = 0;
                                    _loc_66 = _loc_57 - _loc_50.x;
                                    _loc_67 = _loc_58 - _loc_50.y;
                                    _loc_65 = _loc_66 * _loc_66 + _loc_67 * _loc_67;
                                    _loc_67 = 0;
                                    _loc_68 = 0;
                                    _loc_67 = _loc_59 - _loc_51.x;
                                    _loc_68 = _loc_60 - _loc_51.y;
                                    _loc_66 = _loc_67 * _loc_67 + _loc_68 * _loc_68;
                                    _loc_68 = 0;
                                    _loc_69 = 0;
                                    _loc_68 = _loc_61 - _loc_30.x;
                                    _loc_69 = _loc_62 - _loc_30.y;
                                    _loc_67 = _loc_68 * _loc_68 + _loc_69 * _loc_69;
                                    _loc_69 = 0;
                                    _loc_70 = 0;
                                    _loc_69 = _loc_63 - _loc_31.x;
                                    _loc_70 = _loc_64 - _loc_31.y;
                                    _loc_68 = _loc_69 * _loc_69 + _loc_70 * _loc_70;
                                    _loc_69 = 0;
                                    _loc_70 = 0;
                                    _loc_71 = null;
                                    if (_loc_65 < _loc_66)
                                    {
                                        _loc_69 = _loc_57;
                                        _loc_70 = _loc_58;
                                        _loc_71 = _loc_50;
                                    }
                                    else
                                    {
                                        _loc_69 = _loc_59;
                                        _loc_70 = _loc_60;
                                        _loc_71 = _loc_51;
                                        _loc_65 = _loc_66;
                                    }
                                    _loc_72 = 0;
                                    _loc_73 = 0;
                                    _loc_74 = null;
                                    if (_loc_67 < _loc_68)
                                    {
                                        _loc_72 = _loc_61;
                                        _loc_73 = _loc_62;
                                        _loc_74 = _loc_30;
                                    }
                                    else
                                    {
                                        _loc_72 = _loc_63;
                                        _loc_73 = _loc_64;
                                        _loc_74 = _loc_31;
                                        _loc_67 = _loc_68;
                                    }
                                    if (_loc_65 < _loc_67)
                                    {
                                        _loc_28.x = _loc_69;
                                        _loc_28.y = _loc_70;
                                        _loc_29.x = _loc_71.x;
                                        _loc_29.y = _loc_71.y;
                                        _loc_22 = Math.sqrt(_loc_65);
                                    }
                                    else
                                    {
                                        _loc_29.x = _loc_72;
                                        _loc_29.y = _loc_73;
                                        _loc_28.x = _loc_74.x;
                                        _loc_28.y = _loc_74.y;
                                        _loc_22 = Math.sqrt(_loc_67);
                                    }
                                    if (_loc_22 != 0)
                                    {
                                        _loc_17.x = _loc_29.x - _loc_28.x;
                                        _loc_17.y = _loc_29.y - _loc_28.y;
                                        _loc_75 = 1 / _loc_22;
                                        _loc_17.x = _loc_17.x * _loc_75;
                                        _loc_17.y = _loc_17.y * _loc_75;
                                        if (_loc_40)
                                        {
                                            _loc_17.x = -_loc_17.x;
                                            _loc_17.y = -_loc_17.y;
                                        }
                                    }
                                }
                                else
                                {
                                    _loc_24 = 0;
                                    _loc_25 = 0;
                                    _loc_24 = _loc_48.gp0.x;
                                    _loc_25 = _loc_48.gp0.y;
                                    _loc_26 = 0;
                                    _loc_39 = 0;
                                    _loc_26 = _loc_48.gp1.x;
                                    _loc_39 = _loc_48.gp1.y;
                                    _loc_43 = 0;
                                    _loc_52 = 0;
                                    _loc_43 = _loc_26 - _loc_24;
                                    _loc_52 = _loc_39 - _loc_25;
                                    _loc_53 = _loc_45.gnormy * _loc_24 - _loc_45.gnormx * _loc_25;
                                    _loc_54 = _loc_45.gnormy * _loc_26 - _loc_45.gnormx * _loc_39;
                                    _loc_55 = 1 / (_loc_54 - _loc_53);
                                    _loc_56 = (-_loc_45.tp1 - _loc_53) * _loc_55;
                                    if (_loc_56 > Config.epsilon)
                                    {
                                        _loc_57 = _loc_56;
                                        _loc_24 = _loc_24 + _loc_43 * _loc_57;
                                        _loc_25 = _loc_25 + _loc_52 * _loc_57;
                                    }
                                    _loc_57 = (-_loc_45.tp0 - _loc_54) * _loc_55;
                                    if (_loc_57 < -Config.epsilon)
                                    {
                                        _loc_58 = _loc_57;
                                        _loc_26 = _loc_26 + _loc_43 * _loc_58;
                                        _loc_39 = _loc_39 + _loc_52 * _loc_58;
                                    }
                                    _loc_58 = _loc_24 * _loc_45.gnormx + _loc_25 * _loc_45.gnormy - _loc_45.gprojection;
                                    _loc_59 = _loc_26 * _loc_45.gnormx + _loc_39 * _loc_45.gnormy - _loc_45.gprojection;
                                }
                            }
                            else
                            {
                            }
                        }
                        else
                        {
                        }
                    }
                }
                _loc_20 = _loc_21 + param4;
                _loc_21 = _loc_10 * _loc_17.x + _loc_11 * _loc_17.y;
                if (_loc_20 < Config.distanceThresholdCCD)
                {
                    if (param5)
                    {
                        break;
                    }
                    _loc_22 = 0;
                    _loc_23 = 0;
                    _loc_22 = _loc_15.x - _loc_8.posx;
                    _loc_23 = _loc_15.y - _loc_8.posy;
                    _loc_24 = 0;
                    _loc_25 = 0;
                    _loc_24 = _loc_16.x - _loc_9.posx;
                    _loc_25 = _loc_16.y - _loc_9.posy;
                    _loc_26 = _loc_21 - _loc_8.sweep_angvel * (_loc_17.y * _loc_22 - _loc_17.x * _loc_23) + _loc_9.sweep_angvel * (_loc_17.y * _loc_24 - _loc_17.x * _loc_25);
                    if (_loc_26 > 0)
                    {
                        event.slipped = true;
                    }
                    if (_loc_26 > 0)
                    {
                    }
                    if (_loc_20 < Config.distanceThresholdCCD * 0.5)
                    {
                        break;
                    }
                }
                _loc_22 = (_loc_14 - _loc_21) * param2;
                if (_loc_22 <= 0)
                {
                    _loc_18 = -1;
                    break;
                }
                _loc_23 = _loc_20 / _loc_22;
                if (_loc_23 < 1e-006)
                {
                    _loc_23 = 1e-006;
                }
                _loc_18 = _loc_18 + _loc_23;
                if (_loc_18 >= 1)
                {
                    _loc_18 = 1;
                    _loc_24 = _loc_18 * param2;
                    _loc_25 = _loc_24 - _loc_8.sweepTime;
                    if (_loc_25 != 0)
                    {
                        _loc_8.sweepTime = _loc_24;
                        _loc_26 = _loc_25;
                        _loc_8.posx = _loc_8.posx + _loc_8.velx * _loc_26;
                        _loc_8.posy = _loc_8.posy + _loc_8.vely * _loc_26;
                        if (_loc_8.angvel != 0)
                        {
                            _loc_26 = _loc_8.sweep_angvel * _loc_25;
                            _loc_8.rot = _loc_8.rot + _loc_26;
                            if (_loc_26 * _loc_26 > 0.0001)
                            {
                                _loc_8.axisx = Math.sin(_loc_8.rot);
                                _loc_8.axisy = Math.cos(_loc_8.rot);
                            }
                            else
                            {
                                _loc_39 = _loc_26 * _loc_26;
                                _loc_43 = 1 - 0.5 * _loc_39;
                                _loc_52 = 1 - _loc_39 * _loc_39 / 8;
                                _loc_53 = (_loc_43 * _loc_8.axisx + _loc_26 * _loc_8.axisy) * _loc_52;
                                _loc_8.axisy = (_loc_43 * _loc_8.axisy - _loc_26 * _loc_8.axisx) * _loc_52;
                                _loc_8.axisx = _loc_53;
                            }
                        }
                    }
                    if (_loc_6.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_6.worldCOMx = _loc_8.posx + (_loc_8.axisy * _loc_6.localCOMx - _loc_8.axisx * _loc_6.localCOMy);
                        _loc_6.worldCOMy = _loc_8.posy + (_loc_6.localCOMx * _loc_8.axisx + _loc_6.localCOMy * _loc_8.axisy);
                    }
                    else
                    {
                        _loc_27 = _loc_6.polygon;
                        _loc_28 = _loc_27.lverts.next;
                        _loc_29 = _loc_27.gverts.next;
                        while (_loc_29 != null)
                        {
                            
                            _loc_30 = _loc_29;
                            _loc_31 = _loc_28;
                            _loc_28 = _loc_28.next;
                            _loc_30.x = _loc_8.posx + (_loc_8.axisy * _loc_31.x - _loc_8.axisx * _loc_31.y);
                            _loc_30.y = _loc_8.posy + (_loc_31.x * _loc_8.axisx + _loc_31.y * _loc_8.axisy);
                            _loc_29 = _loc_29.next;
                        }
                        _loc_32 = _loc_27.edges.head;
                        _loc_29 = _loc_27.gverts.next;
                        _loc_30 = _loc_29;
                        _loc_29 = _loc_29.next;
                        while (_loc_29 != null)
                        {
                            
                            _loc_31 = _loc_29;
                            _loc_33 = _loc_32.elt;
                            _loc_32 = _loc_32.next;
                            _loc_33.gnormx = _loc_8.axisy * _loc_33.lnormx - _loc_8.axisx * _loc_33.lnormy;
                            _loc_33.gnormy = _loc_33.lnormx * _loc_8.axisx + _loc_33.lnormy * _loc_8.axisy;
                            _loc_33.gprojection = _loc_8.posx * _loc_33.gnormx + _loc_8.posy * _loc_33.gnormy + _loc_33.lprojection;
                            _loc_33.tp0 = _loc_30.y * _loc_33.gnormx - _loc_30.x * _loc_33.gnormy;
                            _loc_33.tp1 = _loc_31.y * _loc_33.gnormx - _loc_31.x * _loc_33.gnormy;
                            _loc_30 = _loc_31;
                            _loc_29 = _loc_29.next;
                        }
                        _loc_31 = _loc_27.gverts.next;
                        _loc_33 = _loc_32.elt;
                        _loc_32 = _loc_32.next;
                        _loc_33.gnormx = _loc_8.axisy * _loc_33.lnormx - _loc_8.axisx * _loc_33.lnormy;
                        _loc_33.gnormy = _loc_33.lnormx * _loc_8.axisx + _loc_33.lnormy * _loc_8.axisy;
                        _loc_33.gprojection = _loc_8.posx * _loc_33.gnormx + _loc_8.posy * _loc_33.gnormy + _loc_33.lprojection;
                        _loc_33.tp0 = _loc_30.y * _loc_33.gnormx - _loc_30.x * _loc_33.gnormy;
                        _loc_33.tp1 = _loc_31.y * _loc_33.gnormx - _loc_31.x * _loc_33.gnormy;
                    }
                    _loc_24 = _loc_18 * param2;
                    _loc_25 = _loc_24 - _loc_9.sweepTime;
                    if (_loc_25 != 0)
                    {
                        _loc_9.sweepTime = _loc_24;
                        _loc_26 = _loc_25;
                        _loc_9.posx = _loc_9.posx + _loc_9.velx * _loc_26;
                        _loc_9.posy = _loc_9.posy + _loc_9.vely * _loc_26;
                        if (_loc_9.angvel != 0)
                        {
                            _loc_26 = _loc_9.sweep_angvel * _loc_25;
                            _loc_9.rot = _loc_9.rot + _loc_26;
                            if (_loc_26 * _loc_26 > 0.0001)
                            {
                                _loc_9.axisx = Math.sin(_loc_9.rot);
                                _loc_9.axisy = Math.cos(_loc_9.rot);
                            }
                            else
                            {
                                _loc_39 = _loc_26 * _loc_26;
                                _loc_43 = 1 - 0.5 * _loc_39;
                                _loc_52 = 1 - _loc_39 * _loc_39 / 8;
                                _loc_53 = (_loc_43 * _loc_9.axisx + _loc_26 * _loc_9.axisy) * _loc_52;
                                _loc_9.axisy = (_loc_43 * _loc_9.axisy - _loc_26 * _loc_9.axisx) * _loc_52;
                                _loc_9.axisx = _loc_53;
                            }
                        }
                    }
                    if (_loc_7.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_7.worldCOMx = _loc_9.posx + (_loc_9.axisy * _loc_7.localCOMx - _loc_9.axisx * _loc_7.localCOMy);
                        _loc_7.worldCOMy = _loc_9.posy + (_loc_7.localCOMx * _loc_9.axisx + _loc_7.localCOMy * _loc_9.axisy);
                    }
                    else
                    {
                        _loc_27 = _loc_7.polygon;
                        _loc_28 = _loc_27.lverts.next;
                        _loc_29 = _loc_27.gverts.next;
                        while (_loc_29 != null)
                        {
                            
                            _loc_30 = _loc_29;
                            _loc_31 = _loc_28;
                            _loc_28 = _loc_28.next;
                            _loc_30.x = _loc_9.posx + (_loc_9.axisy * _loc_31.x - _loc_9.axisx * _loc_31.y);
                            _loc_30.y = _loc_9.posy + (_loc_31.x * _loc_9.axisx + _loc_31.y * _loc_9.axisy);
                            _loc_29 = _loc_29.next;
                        }
                        _loc_32 = _loc_27.edges.head;
                        _loc_29 = _loc_27.gverts.next;
                        _loc_30 = _loc_29;
                        _loc_29 = _loc_29.next;
                        while (_loc_29 != null)
                        {
                            
                            _loc_31 = _loc_29;
                            _loc_33 = _loc_32.elt;
                            _loc_32 = _loc_32.next;
                            _loc_33.gnormx = _loc_9.axisy * _loc_33.lnormx - _loc_9.axisx * _loc_33.lnormy;
                            _loc_33.gnormy = _loc_33.lnormx * _loc_9.axisx + _loc_33.lnormy * _loc_9.axisy;
                            _loc_33.gprojection = _loc_9.posx * _loc_33.gnormx + _loc_9.posy * _loc_33.gnormy + _loc_33.lprojection;
                            _loc_33.tp0 = _loc_30.y * _loc_33.gnormx - _loc_30.x * _loc_33.gnormy;
                            _loc_33.tp1 = _loc_31.y * _loc_33.gnormx - _loc_31.x * _loc_33.gnormy;
                            _loc_30 = _loc_31;
                            _loc_29 = _loc_29.next;
                        }
                        _loc_31 = _loc_27.gverts.next;
                        _loc_33 = _loc_32.elt;
                        _loc_32 = _loc_32.next;
                        _loc_33.gnormx = _loc_9.axisy * _loc_33.lnormx - _loc_9.axisx * _loc_33.lnormy;
                        _loc_33.gnormy = _loc_33.lnormx * _loc_9.axisx + _loc_33.lnormy * _loc_9.axisy;
                        _loc_33.gprojection = _loc_9.posx * _loc_33.gnormx + _loc_9.posy * _loc_33.gnormy + _loc_33.lprojection;
                        _loc_33.tp0 = _loc_30.y * _loc_33.gnormx - _loc_30.x * _loc_33.gnormy;
                        _loc_33.tp1 = _loc_31.y * _loc_33.gnormx - _loc_31.x * _loc_33.gnormy;
                    }
                    _loc_34 = _loc_6;
                    _loc_35 = _loc_7;
                    _loc_28 = _loc_15;
                    _loc_29 = _loc_16;
                    _loc_25 = 1000000000000000000000000000000;
                    if (_loc_34.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                    }
                    if (_loc_35.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_36 = _loc_34.circle;
                        _loc_37 = _loc_35.circle;
                        _loc_39 = 0;
                        _loc_43 = 0;
                        _loc_39 = _loc_37.worldCOMx - _loc_36.worldCOMx;
                        _loc_43 = _loc_37.worldCOMy - _loc_36.worldCOMy;
                        _loc_53 = _loc_39 * _loc_39 + _loc_43 * _loc_43;
                        if (_loc_53 == 0)
                        {
                            _loc_52 = 0;
                        }
                        else
                        {
                            _loc_38 = 1597463007 - (0 >> 1);
                            _loc_54 = 0;
                            _loc_52 = 0 / (_loc_54 * (1.5 - 0.5 * _loc_53 * _loc_54 * _loc_54));
                        }
                        _loc_26 = _loc_52 - (_loc_36.radius + _loc_37.radius);
                        if (_loc_26 < _loc_25)
                        {
                            if (_loc_52 == 0)
                            {
                                _loc_39 = 1;
                                _loc_43 = 0;
                            }
                            else
                            {
                                _loc_53 = 1 / _loc_52;
                                _loc_39 = _loc_39 * _loc_53;
                                _loc_43 = _loc_43 * _loc_53;
                            }
                            _loc_53 = _loc_36.radius;
                            _loc_28.x = _loc_36.worldCOMx + _loc_39 * _loc_53;
                            _loc_28.y = _loc_36.worldCOMy + _loc_43 * _loc_53;
                            _loc_53 = -_loc_37.radius;
                            _loc_29.x = _loc_37.worldCOMx + _loc_39 * _loc_53;
                            _loc_29.y = _loc_37.worldCOMy + _loc_43 * _loc_53;
                            _loc_17.x = _loc_39;
                            _loc_17.y = _loc_43;
                        }
                    }
                    else
                    {
                        _loc_40 = false;
                        if (_loc_34.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                        }
                        if (_loc_35.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_41 = _loc_34;
                            _loc_34 = _loc_35;
                            _loc_35 = _loc_41;
                            _loc_30 = _loc_28;
                            _loc_28 = _loc_29;
                            _loc_29 = _loc_30;
                            _loc_40 = true;
                        }
                        if (_loc_34.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                        }
                        if (_loc_35.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_27 = _loc_34.polygon;
                            _loc_36 = _loc_35.circle;
                            _loc_26 = -1000000000000000000000000000000;
                            _loc_33 = null;
                            _loc_32 = _loc_27.edges.head;
                            while (_loc_32 != null)
                            {
                                
                                _loc_42 = _loc_32.elt;
                                _loc_39 = _loc_42.gnormx * _loc_36.worldCOMx + _loc_42.gnormy * _loc_36.worldCOMy - _loc_42.gprojection - _loc_36.radius;
                                if (_loc_39 > _loc_25)
                                {
                                    _loc_26 = _loc_39;
                                    break;
                                }
                                if (_loc_39 > 0)
                                {
                                    if (_loc_39 > _loc_26)
                                    {
                                        _loc_26 = _loc_39;
                                        _loc_33 = _loc_42;
                                    }
                                }
                                else
                                {
                                    if (_loc_26 < 0)
                                    {
                                    }
                                    if (_loc_39 > _loc_26)
                                    {
                                        _loc_26 = _loc_39;
                                        _loc_33 = _loc_42;
                                    }
                                }
                                _loc_32 = _loc_32.next;
                            }
                            if (_loc_26 < _loc_25)
                            {
                                _loc_30 = _loc_33.gp0;
                                _loc_31 = _loc_33.gp1;
                                _loc_39 = _loc_36.worldCOMy * _loc_33.gnormx - _loc_36.worldCOMx * _loc_33.gnormy;
                                if (_loc_39 <= _loc_30.y * _loc_33.gnormx - _loc_30.x * _loc_33.gnormy)
                                {
                                    _loc_43 = 0;
                                    _loc_52 = 0;
                                    _loc_43 = _loc_36.worldCOMx - _loc_30.x;
                                    _loc_52 = _loc_36.worldCOMy - _loc_30.y;
                                    _loc_54 = _loc_43 * _loc_43 + _loc_52 * _loc_52;
                                    if (_loc_54 == 0)
                                    {
                                        _loc_53 = 0;
                                    }
                                    else
                                    {
                                        _loc_38 = 1597463007 - (0 >> 1);
                                        _loc_55 = 0;
                                        _loc_53 = 0 / (_loc_55 * (1.5 - 0.5 * _loc_54 * _loc_55 * _loc_55));
                                    }
                                    _loc_26 = _loc_53 - _loc_36.radius;
                                    if (_loc_26 < _loc_25)
                                    {
                                        if (_loc_53 == 0)
                                        {
                                            _loc_43 = 1;
                                            _loc_52 = 0;
                                        }
                                        else
                                        {
                                            _loc_54 = 1 / _loc_53;
                                            _loc_43 = _loc_43 * _loc_54;
                                            _loc_52 = _loc_52 * _loc_54;
                                        }
                                        _loc_38 = 0;
                                        _loc_28.x = _loc_30.x + _loc_43 * _loc_38;
                                        _loc_28.y = _loc_30.y + _loc_52 * _loc_38;
                                        _loc_54 = -_loc_36.radius;
                                        _loc_29.x = _loc_36.worldCOMx + _loc_43 * _loc_54;
                                        _loc_29.y = _loc_36.worldCOMy + _loc_52 * _loc_54;
                                        _loc_17.x = _loc_43;
                                        _loc_17.y = _loc_52;
                                    }
                                }
                                else if (_loc_39 >= _loc_31.y * _loc_33.gnormx - _loc_31.x * _loc_33.gnormy)
                                {
                                    _loc_43 = 0;
                                    _loc_52 = 0;
                                    _loc_43 = _loc_36.worldCOMx - _loc_31.x;
                                    _loc_52 = _loc_36.worldCOMy - _loc_31.y;
                                    _loc_54 = _loc_43 * _loc_43 + _loc_52 * _loc_52;
                                    if (_loc_54 == 0)
                                    {
                                        _loc_53 = 0;
                                    }
                                    else
                                    {
                                        _loc_38 = 1597463007 - (0 >> 1);
                                        _loc_55 = 0;
                                        _loc_53 = 0 / (_loc_55 * (1.5 - 0.5 * _loc_54 * _loc_55 * _loc_55));
                                    }
                                    _loc_26 = _loc_53 - _loc_36.radius;
                                    if (_loc_26 < _loc_25)
                                    {
                                        if (_loc_53 == 0)
                                        {
                                            _loc_43 = 1;
                                            _loc_52 = 0;
                                        }
                                        else
                                        {
                                            _loc_54 = 1 / _loc_53;
                                            _loc_43 = _loc_43 * _loc_54;
                                            _loc_52 = _loc_52 * _loc_54;
                                        }
                                        _loc_38 = 0;
                                        _loc_28.x = _loc_31.x + _loc_43 * _loc_38;
                                        _loc_28.y = _loc_31.y + _loc_52 * _loc_38;
                                        _loc_54 = -_loc_36.radius;
                                        _loc_29.x = _loc_36.worldCOMx + _loc_43 * _loc_54;
                                        _loc_29.y = _loc_36.worldCOMy + _loc_52 * _loc_54;
                                        _loc_17.x = _loc_43;
                                        _loc_17.y = _loc_52;
                                    }
                                }
                                else
                                {
                                    _loc_43 = -_loc_36.radius;
                                    _loc_29.x = _loc_36.worldCOMx + _loc_33.gnormx * _loc_43;
                                    _loc_29.y = _loc_36.worldCOMy + _loc_33.gnormy * _loc_43;
                                    _loc_43 = -_loc_26;
                                    _loc_28.x = _loc_29.x + _loc_33.gnormx * _loc_43;
                                    _loc_28.y = _loc_29.y + _loc_33.gnormy * _loc_43;
                                    _loc_17.x = _loc_33.gnormx;
                                    _loc_17.y = _loc_33.gnormy;
                                }
                            }
                            if (_loc_40)
                            {
                                _loc_17.x = -_loc_17.x;
                                _loc_17.y = -_loc_17.y;
                            }
                        }
                        else
                        {
                            _loc_27 = _loc_34.polygon;
                            _loc_44 = _loc_35.polygon;
                            _loc_26 = -1000000000000000000000000000000;
                            _loc_33 = null;
                            _loc_42 = null;
                            _loc_38 = 0;
                            _loc_32 = _loc_27.edges.head;
                            while (_loc_32 != null)
                            {
                                
                                _loc_45 = _loc_32.elt;
                                _loc_39 = 1000000000000000000000000000000;
                                _loc_30 = _loc_44.gverts.next;
                                while (_loc_30 != null)
                                {
                                    
                                    _loc_31 = _loc_30;
                                    _loc_43 = _loc_45.gnormx * _loc_31.x + _loc_45.gnormy * _loc_31.y;
                                    if (_loc_43 < _loc_39)
                                    {
                                        _loc_39 = _loc_43;
                                    }
                                    _loc_30 = _loc_30.next;
                                }
                                _loc_39 = _loc_39 - _loc_45.gprojection;
                                if (_loc_39 > _loc_25)
                                {
                                    _loc_26 = _loc_39;
                                    break;
                                }
                                if (_loc_39 > 0)
                                {
                                    if (_loc_39 > _loc_26)
                                    {
                                        _loc_26 = _loc_39;
                                        _loc_33 = _loc_45;
                                        _loc_38 = 1;
                                    }
                                }
                                else
                                {
                                    if (_loc_26 < 0)
                                    {
                                    }
                                    if (_loc_39 > _loc_26)
                                    {
                                        _loc_26 = _loc_39;
                                        _loc_33 = _loc_45;
                                        _loc_38 = 1;
                                    }
                                }
                                _loc_32 = _loc_32.next;
                            }
                            if (_loc_26 < _loc_25)
                            {
                                _loc_32 = _loc_44.edges.head;
                                while (_loc_32 != null)
                                {
                                    
                                    _loc_45 = _loc_32.elt;
                                    _loc_39 = 1000000000000000000000000000000;
                                    _loc_30 = _loc_27.gverts.next;
                                    while (_loc_30 != null)
                                    {
                                        
                                        _loc_31 = _loc_30;
                                        _loc_43 = _loc_45.gnormx * _loc_31.x + _loc_45.gnormy * _loc_31.y;
                                        if (_loc_43 < _loc_39)
                                        {
                                            _loc_39 = _loc_43;
                                        }
                                        _loc_30 = _loc_30.next;
                                    }
                                    _loc_39 = _loc_39 - _loc_45.gprojection;
                                    if (_loc_39 > _loc_25)
                                    {
                                        _loc_26 = _loc_39;
                                        break;
                                    }
                                    if (_loc_39 > 0)
                                    {
                                        if (_loc_39 > _loc_26)
                                        {
                                            _loc_26 = _loc_39;
                                            _loc_42 = _loc_45;
                                            _loc_38 = 2;
                                        }
                                    }
                                    else
                                    {
                                        if (_loc_26 < 0)
                                        {
                                        }
                                        if (_loc_39 > _loc_26)
                                        {
                                            _loc_26 = _loc_39;
                                            _loc_42 = _loc_45;
                                            _loc_38 = 2;
                                        }
                                    }
                                    _loc_32 = _loc_32.next;
                                }
                                if (_loc_26 < _loc_25)
                                {
                                    if (_loc_38 == 1)
                                    {
                                        _loc_46 = _loc_27;
                                        _loc_47 = _loc_44;
                                        _loc_45 = _loc_33;
                                    }
                                    else
                                    {
                                        _loc_46 = _loc_44;
                                        _loc_47 = _loc_27;
                                        _loc_45 = _loc_42;
                                        _loc_30 = _loc_28;
                                        _loc_28 = _loc_29;
                                        _loc_29 = _loc_30;
                                        _loc_40 = !_loc_40;
                                    }
                                    _loc_48 = null;
                                    _loc_39 = 1000000000000000000000000000000;
                                    _loc_32 = _loc_47.edges.head;
                                    while (_loc_32 != null)
                                    {
                                        
                                        _loc_49 = _loc_32.elt;
                                        _loc_43 = _loc_45.gnormx * _loc_49.gnormx + _loc_45.gnormy * _loc_49.gnormy;
                                        if (_loc_43 < _loc_39)
                                        {
                                            _loc_39 = _loc_43;
                                            _loc_48 = _loc_49;
                                        }
                                        _loc_32 = _loc_32.next;
                                    }
                                    if (_loc_40)
                                    {
                                        _loc_17.x = -_loc_45.gnormx;
                                        _loc_17.y = -_loc_45.gnormy;
                                    }
                                    else
                                    {
                                        _loc_17.x = _loc_45.gnormx;
                                        _loc_17.y = _loc_45.gnormy;
                                    }
                                    if (_loc_26 >= 0)
                                    {
                                        _loc_30 = _loc_45.gp0;
                                        _loc_31 = _loc_45.gp1;
                                        _loc_50 = _loc_48.gp0;
                                        _loc_51 = _loc_48.gp1;
                                        _loc_43 = 0;
                                        _loc_52 = 0;
                                        _loc_53 = 0;
                                        _loc_54 = 0;
                                        _loc_43 = _loc_31.x - _loc_30.x;
                                        _loc_52 = _loc_31.y - _loc_30.y;
                                        _loc_53 = _loc_51.x - _loc_50.x;
                                        _loc_54 = _loc_51.y - _loc_50.y;
                                        _loc_55 = 1 / (_loc_43 * _loc_43 + _loc_52 * _loc_52);
                                        _loc_56 = 1 / (_loc_53 * _loc_53 + _loc_54 * _loc_54);
                                        _loc_57 = (-(_loc_43 * (_loc_30.x - _loc_50.x) + _loc_52 * (_loc_30.y - _loc_50.y))) * _loc_55;
                                        _loc_58 = (-(_loc_43 * (_loc_30.x - _loc_51.x) + _loc_52 * (_loc_30.y - _loc_51.y))) * _loc_55;
                                        _loc_59 = (-(_loc_53 * (_loc_50.x - _loc_30.x) + _loc_54 * (_loc_50.y - _loc_30.y))) * _loc_56;
                                        _loc_60 = (-(_loc_53 * (_loc_50.x - _loc_31.x) + _loc_54 * (_loc_50.y - _loc_31.y))) * _loc_56;
                                        if (_loc_57 < 0)
                                        {
                                            _loc_57 = 0;
                                        }
                                        else if (_loc_57 > 1)
                                        {
                                            _loc_57 = 1;
                                        }
                                        if (_loc_58 < 0)
                                        {
                                            _loc_58 = 0;
                                        }
                                        else if (_loc_58 > 1)
                                        {
                                            _loc_58 = 1;
                                        }
                                        if (_loc_59 < 0)
                                        {
                                            _loc_59 = 0;
                                        }
                                        else if (_loc_59 > 1)
                                        {
                                            _loc_59 = 1;
                                        }
                                        if (_loc_60 < 0)
                                        {
                                            _loc_60 = 0;
                                        }
                                        else if (_loc_60 > 1)
                                        {
                                            _loc_60 = 1;
                                        }
                                        _loc_61 = 0;
                                        _loc_62 = 0;
                                        _loc_63 = _loc_57;
                                        _loc_61 = _loc_30.x + _loc_43 * _loc_63;
                                        _loc_62 = _loc_30.y + _loc_52 * _loc_63;
                                        _loc_63 = 0;
                                        _loc_64 = 0;
                                        _loc_65 = _loc_58;
                                        _loc_63 = _loc_30.x + _loc_43 * _loc_65;
                                        _loc_64 = _loc_30.y + _loc_52 * _loc_65;
                                        _loc_65 = 0;
                                        _loc_66 = 0;
                                        _loc_67 = _loc_59;
                                        _loc_65 = _loc_50.x + _loc_53 * _loc_67;
                                        _loc_66 = _loc_50.y + _loc_54 * _loc_67;
                                        _loc_67 = 0;
                                        _loc_68 = 0;
                                        _loc_69 = _loc_60;
                                        _loc_67 = _loc_50.x + _loc_53 * _loc_69;
                                        _loc_68 = _loc_50.y + _loc_54 * _loc_69;
                                        _loc_70 = 0;
                                        _loc_72 = 0;
                                        _loc_70 = _loc_61 - _loc_50.x;
                                        _loc_72 = _loc_62 - _loc_50.y;
                                        _loc_69 = _loc_70 * _loc_70 + _loc_72 * _loc_72;
                                        _loc_72 = 0;
                                        _loc_73 = 0;
                                        _loc_72 = _loc_63 - _loc_51.x;
                                        _loc_73 = _loc_64 - _loc_51.y;
                                        _loc_70 = _loc_72 * _loc_72 + _loc_73 * _loc_73;
                                        _loc_73 = 0;
                                        _loc_75 = 0;
                                        _loc_73 = _loc_65 - _loc_30.x;
                                        _loc_75 = _loc_66 - _loc_30.y;
                                        _loc_72 = _loc_73 * _loc_73 + _loc_75 * _loc_75;
                                        _loc_75 = 0;
                                        _loc_76 = 0;
                                        _loc_75 = _loc_67 - _loc_31.x;
                                        _loc_76 = _loc_68 - _loc_31.y;
                                        _loc_73 = _loc_75 * _loc_75 + _loc_76 * _loc_76;
                                        _loc_75 = 0;
                                        _loc_76 = 0;
                                        _loc_71 = null;
                                        if (_loc_69 < _loc_70)
                                        {
                                            _loc_75 = _loc_61;
                                            _loc_76 = _loc_62;
                                            _loc_71 = _loc_50;
                                        }
                                        else
                                        {
                                            _loc_75 = _loc_63;
                                            _loc_76 = _loc_64;
                                            _loc_71 = _loc_51;
                                            _loc_69 = _loc_70;
                                        }
                                        _loc_77 = 0;
                                        _loc_78 = 0;
                                        _loc_74 = null;
                                        if (_loc_72 < _loc_73)
                                        {
                                            _loc_77 = _loc_65;
                                            _loc_78 = _loc_66;
                                            _loc_74 = _loc_30;
                                        }
                                        else
                                        {
                                            _loc_77 = _loc_67;
                                            _loc_78 = _loc_68;
                                            _loc_74 = _loc_31;
                                            _loc_72 = _loc_73;
                                        }
                                        if (_loc_69 < _loc_72)
                                        {
                                            _loc_28.x = _loc_75;
                                            _loc_28.y = _loc_76;
                                            _loc_29.x = _loc_71.x;
                                            _loc_29.y = _loc_71.y;
                                            _loc_26 = Math.sqrt(_loc_69);
                                        }
                                        else
                                        {
                                            _loc_29.x = _loc_77;
                                            _loc_29.y = _loc_78;
                                            _loc_28.x = _loc_74.x;
                                            _loc_28.y = _loc_74.y;
                                            _loc_26 = Math.sqrt(_loc_72);
                                        }
                                        if (_loc_26 != 0)
                                        {
                                            _loc_17.x = _loc_29.x - _loc_28.x;
                                            _loc_17.y = _loc_29.y - _loc_28.y;
                                            _loc_79 = 1 / _loc_26;
                                            _loc_17.x = _loc_17.x * _loc_79;
                                            _loc_17.y = _loc_17.y * _loc_79;
                                            if (_loc_40)
                                            {
                                                _loc_17.x = -_loc_17.x;
                                                _loc_17.y = -_loc_17.y;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        _loc_43 = 0;
                                        _loc_52 = 0;
                                        _loc_43 = _loc_48.gp0.x;
                                        _loc_52 = _loc_48.gp0.y;
                                        _loc_53 = 0;
                                        _loc_54 = 0;
                                        _loc_53 = _loc_48.gp1.x;
                                        _loc_54 = _loc_48.gp1.y;
                                        _loc_55 = 0;
                                        _loc_56 = 0;
                                        _loc_55 = _loc_53 - _loc_43;
                                        _loc_56 = _loc_54 - _loc_52;
                                        _loc_57 = _loc_45.gnormy * _loc_43 - _loc_45.gnormx * _loc_52;
                                        _loc_58 = _loc_45.gnormy * _loc_53 - _loc_45.gnormx * _loc_54;
                                        _loc_59 = 1 / (_loc_58 - _loc_57);
                                        _loc_60 = (-_loc_45.tp1 - _loc_57) * _loc_59;
                                        if (_loc_60 > Config.epsilon)
                                        {
                                            _loc_61 = _loc_60;
                                            _loc_43 = _loc_43 + _loc_55 * _loc_61;
                                            _loc_52 = _loc_52 + _loc_56 * _loc_61;
                                        }
                                        _loc_61 = (-_loc_45.tp0 - _loc_58) * _loc_59;
                                        if (_loc_61 < -Config.epsilon)
                                        {
                                            _loc_62 = _loc_61;
                                            _loc_53 = _loc_53 + _loc_55 * _loc_62;
                                            _loc_54 = _loc_54 + _loc_56 * _loc_62;
                                        }
                                        _loc_62 = _loc_43 * _loc_45.gnormx + _loc_52 * _loc_45.gnormy - _loc_45.gprojection;
                                        _loc_63 = _loc_53 * _loc_45.gnormx + _loc_54 * _loc_45.gnormy - _loc_45.gprojection;
                                    }
                                }
                                else
                                {
                                }
                            }
                            else
                            {
                            }
                        }
                    }
                    _loc_24 = _loc_25 + param4;
                    _loc_25 = _loc_10 * _loc_17.x + _loc_11 * _loc_17.y;
                    if (_loc_24 < Config.distanceThresholdCCD)
                    {
                        if (param5)
                        {
                            break;
                        }
                        _loc_26 = 0;
                        _loc_39 = 0;
                        _loc_26 = _loc_15.x - _loc_8.posx;
                        _loc_39 = _loc_15.y - _loc_8.posy;
                        _loc_43 = 0;
                        _loc_52 = 0;
                        _loc_43 = _loc_16.x - _loc_9.posx;
                        _loc_52 = _loc_16.y - _loc_9.posy;
                        _loc_53 = _loc_25 - _loc_8.sweep_angvel * (_loc_17.y * _loc_26 - _loc_17.x * _loc_39) + _loc_9.sweep_angvel * (_loc_17.y * _loc_43 - _loc_17.x * _loc_52);
                        if (_loc_53 > 0)
                        {
                            event.slipped = true;
                        }
                        if (_loc_53 > 0)
                        {
                        }
                        if (_loc_24 < Config.distanceThresholdCCD * 0.5)
                        {
                            break;
                        }
                    }
                    _loc_18 = -1;
                    break;
                }
                _loc_19++;
                if (_loc_19 >= 40)
                {
                    if (_loc_20 > param4)
                    {
                        event.failed = true;
                    }
                    break;
                }
            }
            event.toi = _loc_18;
            return;
        }// end function

        public static function staticSweep(event:ZPP_ToiEvent, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = null as ZPP_Polygon;
            var _loc_26:* = null as ZPP_Vec2;
            var _loc_27:* = null as ZPP_Vec2;
            var _loc_28:* = null as ZPP_Vec2;
            var _loc_29:* = null as ZPP_Vec2;
            var _loc_30:* = null as ZNPNode_ZPP_Edge;
            var _loc_31:* = null as ZPP_Edge;
            var _loc_32:* = null as ZPP_Shape;
            var _loc_33:* = null as ZPP_Shape;
            var _loc_34:* = null as ZPP_Circle;
            var _loc_35:* = null as ZPP_Circle;
            var _loc_36:* = 0;
            var _loc_37:* = NaN;
            var _loc_38:* = false;
            var _loc_39:* = null as ZPP_Shape;
            var _loc_40:* = null as ZPP_Edge;
            var _loc_41:* = NaN;
            var _loc_42:* = null as ZPP_Polygon;
            var _loc_43:* = null as ZPP_Edge;
            var _loc_44:* = null as ZPP_Polygon;
            var _loc_45:* = null as ZPP_Polygon;
            var _loc_46:* = null as ZPP_Edge;
            var _loc_47:* = null as ZPP_Edge;
            var _loc_48:* = null as ZPP_Vec2;
            var _loc_49:* = null as ZPP_Vec2;
            var _loc_50:* = NaN;
            var _loc_51:* = NaN;
            var _loc_52:* = NaN;
            var _loc_53:* = NaN;
            var _loc_54:* = NaN;
            var _loc_55:* = NaN;
            var _loc_56:* = NaN;
            var _loc_57:* = NaN;
            var _loc_58:* = NaN;
            var _loc_59:* = NaN;
            var _loc_60:* = NaN;
            var _loc_61:* = NaN;
            var _loc_62:* = NaN;
            var _loc_63:* = NaN;
            var _loc_64:* = NaN;
            var _loc_65:* = NaN;
            var _loc_66:* = NaN;
            var _loc_67:* = NaN;
            var _loc_68:* = NaN;
            var _loc_69:* = null as ZPP_Vec2;
            var _loc_70:* = NaN;
            var _loc_71:* = NaN;
            var _loc_72:* = null as ZPP_Vec2;
            var _loc_73:* = NaN;
            var _loc_74:* = NaN;
            var _loc_75:* = NaN;
            var _loc_76:* = NaN;
            var _loc_77:* = NaN;
            var _loc_5:* = event.s1;
            var _loc_6:* = event.s2;
            var _loc_7:* = _loc_5.body;
            var _loc_8:* = _loc_6.body;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            _loc_9 = -_loc_7.velx;
            _loc_10 = -_loc_7.vely;
            var _loc_11:* = _loc_7.sweep_angvel;
            if (_loc_11 < 0)
            {
                _loc_11 = -_loc_11;
            }
            var _loc_12:* = _loc_5.sweepCoef * _loc_11;
            var _loc_13:* = event.c1;
            var _loc_14:* = event.c2;
            var _loc_15:* = event.axis;
            var _loc_16:* = param3;
            var _loc_17:* = 0;
            while (true)
            {
                
                _loc_18 = _loc_16 * param2;
                _loc_19 = _loc_18 - _loc_7.sweepTime;
                if (_loc_19 != 0)
                {
                    _loc_7.sweepTime = _loc_18;
                    _loc_20 = _loc_19;
                    _loc_7.posx = _loc_7.posx + _loc_7.velx * _loc_20;
                    _loc_7.posy = _loc_7.posy + _loc_7.vely * _loc_20;
                    if (_loc_7.angvel != 0)
                    {
                        _loc_20 = _loc_7.sweep_angvel * _loc_19;
                        _loc_7.rot = _loc_7.rot + _loc_20;
                        if (_loc_20 * _loc_20 > 0.0001)
                        {
                            _loc_7.axisx = Math.sin(_loc_7.rot);
                            _loc_7.axisy = Math.cos(_loc_7.rot);
                        }
                        else
                        {
                            _loc_21 = _loc_20 * _loc_20;
                            _loc_22 = 1 - 0.5 * _loc_21;
                            _loc_23 = 1 - _loc_21 * _loc_21 / 8;
                            _loc_24 = (_loc_22 * _loc_7.axisx + _loc_20 * _loc_7.axisy) * _loc_23;
                            _loc_7.axisy = (_loc_22 * _loc_7.axisy - _loc_20 * _loc_7.axisx) * _loc_23;
                            _loc_7.axisx = _loc_24;
                        }
                    }
                }
                if (_loc_5.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    _loc_5.worldCOMx = _loc_7.posx + (_loc_7.axisy * _loc_5.localCOMx - _loc_7.axisx * _loc_5.localCOMy);
                    _loc_5.worldCOMy = _loc_7.posy + (_loc_5.localCOMx * _loc_7.axisx + _loc_5.localCOMy * _loc_7.axisy);
                }
                else
                {
                    _loc_25 = _loc_5.polygon;
                    _loc_26 = _loc_25.lverts.next;
                    _loc_27 = _loc_25.gverts.next;
                    while (_loc_27 != null)
                    {
                        
                        _loc_28 = _loc_27;
                        _loc_29 = _loc_26;
                        _loc_26 = _loc_26.next;
                        _loc_28.x = _loc_7.posx + (_loc_7.axisy * _loc_29.x - _loc_7.axisx * _loc_29.y);
                        _loc_28.y = _loc_7.posy + (_loc_29.x * _loc_7.axisx + _loc_29.y * _loc_7.axisy);
                        _loc_27 = _loc_27.next;
                    }
                    _loc_30 = _loc_25.edges.head;
                    _loc_27 = _loc_25.gverts.next;
                    _loc_28 = _loc_27;
                    _loc_27 = _loc_27.next;
                    while (_loc_27 != null)
                    {
                        
                        _loc_29 = _loc_27;
                        _loc_31 = _loc_30.elt;
                        _loc_30 = _loc_30.next;
                        _loc_31.gnormx = _loc_7.axisy * _loc_31.lnormx - _loc_7.axisx * _loc_31.lnormy;
                        _loc_31.gnormy = _loc_31.lnormx * _loc_7.axisx + _loc_31.lnormy * _loc_7.axisy;
                        _loc_31.gprojection = _loc_7.posx * _loc_31.gnormx + _loc_7.posy * _loc_31.gnormy + _loc_31.lprojection;
                        _loc_31.tp0 = _loc_28.y * _loc_31.gnormx - _loc_28.x * _loc_31.gnormy;
                        _loc_31.tp1 = _loc_29.y * _loc_31.gnormx - _loc_29.x * _loc_31.gnormy;
                        _loc_28 = _loc_29;
                        _loc_27 = _loc_27.next;
                    }
                    _loc_29 = _loc_25.gverts.next;
                    _loc_31 = _loc_30.elt;
                    _loc_30 = _loc_30.next;
                    _loc_31.gnormx = _loc_7.axisy * _loc_31.lnormx - _loc_7.axisx * _loc_31.lnormy;
                    _loc_31.gnormy = _loc_31.lnormx * _loc_7.axisx + _loc_31.lnormy * _loc_7.axisy;
                    _loc_31.gprojection = _loc_7.posx * _loc_31.gnormx + _loc_7.posy * _loc_31.gnormy + _loc_31.lprojection;
                    _loc_31.tp0 = _loc_28.y * _loc_31.gnormx - _loc_28.x * _loc_31.gnormy;
                    _loc_31.tp1 = _loc_29.y * _loc_31.gnormx - _loc_29.x * _loc_31.gnormy;
                }
                _loc_32 = _loc_5;
                _loc_33 = _loc_6;
                _loc_26 = _loc_13;
                _loc_27 = _loc_14;
                _loc_19 = 1000000000000000000000000000000;
                if (_loc_32.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                }
                if (_loc_33.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    _loc_34 = _loc_32.circle;
                    _loc_35 = _loc_33.circle;
                    _loc_21 = 0;
                    _loc_22 = 0;
                    _loc_21 = _loc_35.worldCOMx - _loc_34.worldCOMx;
                    _loc_22 = _loc_35.worldCOMy - _loc_34.worldCOMy;
                    _loc_24 = _loc_21 * _loc_21 + _loc_22 * _loc_22;
                    if (_loc_24 == 0)
                    {
                        _loc_23 = 0;
                    }
                    else
                    {
                        _loc_36 = 1597463007 - (0 >> 1);
                        _loc_37 = 0;
                        _loc_23 = 0 / (_loc_37 * (1.5 - 0.5 * _loc_24 * _loc_37 * _loc_37));
                    }
                    _loc_20 = _loc_23 - (_loc_34.radius + _loc_35.radius);
                    if (_loc_20 < _loc_19)
                    {
                        if (_loc_23 == 0)
                        {
                            _loc_21 = 1;
                            _loc_22 = 0;
                        }
                        else
                        {
                            _loc_24 = 1 / _loc_23;
                            _loc_21 = _loc_21 * _loc_24;
                            _loc_22 = _loc_22 * _loc_24;
                        }
                        _loc_24 = _loc_34.radius;
                        _loc_26.x = _loc_34.worldCOMx + _loc_21 * _loc_24;
                        _loc_26.y = _loc_34.worldCOMy + _loc_22 * _loc_24;
                        _loc_24 = -_loc_35.radius;
                        _loc_27.x = _loc_35.worldCOMx + _loc_21 * _loc_24;
                        _loc_27.y = _loc_35.worldCOMy + _loc_22 * _loc_24;
                        _loc_15.x = _loc_21;
                        _loc_15.y = _loc_22;
                    }
                }
                else
                {
                    _loc_38 = false;
                    if (_loc_32.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                    }
                    if (_loc_33.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                        _loc_39 = _loc_32;
                        _loc_32 = _loc_33;
                        _loc_33 = _loc_39;
                        _loc_28 = _loc_26;
                        _loc_26 = _loc_27;
                        _loc_27 = _loc_28;
                        _loc_38 = true;
                    }
                    if (_loc_32.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                    }
                    if (_loc_33.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_25 = _loc_32.polygon;
                        _loc_34 = _loc_33.circle;
                        _loc_20 = -1000000000000000000000000000000;
                        _loc_31 = null;
                        _loc_30 = _loc_25.edges.head;
                        while (_loc_30 != null)
                        {
                            
                            _loc_40 = _loc_30.elt;
                            _loc_21 = _loc_40.gnormx * _loc_34.worldCOMx + _loc_40.gnormy * _loc_34.worldCOMy - _loc_40.gprojection - _loc_34.radius;
                            if (_loc_21 > _loc_19)
                            {
                                _loc_20 = _loc_21;
                                break;
                            }
                            if (_loc_21 > 0)
                            {
                                if (_loc_21 > _loc_20)
                                {
                                    _loc_20 = _loc_21;
                                    _loc_31 = _loc_40;
                                }
                            }
                            else
                            {
                                if (_loc_20 < 0)
                                {
                                }
                                if (_loc_21 > _loc_20)
                                {
                                    _loc_20 = _loc_21;
                                    _loc_31 = _loc_40;
                                }
                            }
                            _loc_30 = _loc_30.next;
                        }
                        if (_loc_20 < _loc_19)
                        {
                            _loc_28 = _loc_31.gp0;
                            _loc_29 = _loc_31.gp1;
                            _loc_21 = _loc_34.worldCOMy * _loc_31.gnormx - _loc_34.worldCOMx * _loc_31.gnormy;
                            if (_loc_21 <= _loc_28.y * _loc_31.gnormx - _loc_28.x * _loc_31.gnormy)
                            {
                                _loc_22 = 0;
                                _loc_23 = 0;
                                _loc_22 = _loc_34.worldCOMx - _loc_28.x;
                                _loc_23 = _loc_34.worldCOMy - _loc_28.y;
                                _loc_37 = _loc_22 * _loc_22 + _loc_23 * _loc_23;
                                if (_loc_37 == 0)
                                {
                                    _loc_24 = 0;
                                }
                                else
                                {
                                    _loc_36 = 1597463007 - (0 >> 1);
                                    _loc_41 = 0;
                                    _loc_24 = 0 / (_loc_41 * (1.5 - 0.5 * _loc_37 * _loc_41 * _loc_41));
                                }
                                _loc_20 = _loc_24 - _loc_34.radius;
                                if (_loc_20 < _loc_19)
                                {
                                    if (_loc_24 == 0)
                                    {
                                        _loc_22 = 1;
                                        _loc_23 = 0;
                                    }
                                    else
                                    {
                                        _loc_37 = 1 / _loc_24;
                                        _loc_22 = _loc_22 * _loc_37;
                                        _loc_23 = _loc_23 * _loc_37;
                                    }
                                    _loc_36 = 0;
                                    _loc_26.x = _loc_28.x + _loc_22 * _loc_36;
                                    _loc_26.y = _loc_28.y + _loc_23 * _loc_36;
                                    _loc_37 = -_loc_34.radius;
                                    _loc_27.x = _loc_34.worldCOMx + _loc_22 * _loc_37;
                                    _loc_27.y = _loc_34.worldCOMy + _loc_23 * _loc_37;
                                    _loc_15.x = _loc_22;
                                    _loc_15.y = _loc_23;
                                }
                            }
                            else if (_loc_21 >= _loc_29.y * _loc_31.gnormx - _loc_29.x * _loc_31.gnormy)
                            {
                                _loc_22 = 0;
                                _loc_23 = 0;
                                _loc_22 = _loc_34.worldCOMx - _loc_29.x;
                                _loc_23 = _loc_34.worldCOMy - _loc_29.y;
                                _loc_37 = _loc_22 * _loc_22 + _loc_23 * _loc_23;
                                if (_loc_37 == 0)
                                {
                                    _loc_24 = 0;
                                }
                                else
                                {
                                    _loc_36 = 1597463007 - (0 >> 1);
                                    _loc_41 = 0;
                                    _loc_24 = 0 / (_loc_41 * (1.5 - 0.5 * _loc_37 * _loc_41 * _loc_41));
                                }
                                _loc_20 = _loc_24 - _loc_34.radius;
                                if (_loc_20 < _loc_19)
                                {
                                    if (_loc_24 == 0)
                                    {
                                        _loc_22 = 1;
                                        _loc_23 = 0;
                                    }
                                    else
                                    {
                                        _loc_37 = 1 / _loc_24;
                                        _loc_22 = _loc_22 * _loc_37;
                                        _loc_23 = _loc_23 * _loc_37;
                                    }
                                    _loc_36 = 0;
                                    _loc_26.x = _loc_29.x + _loc_22 * _loc_36;
                                    _loc_26.y = _loc_29.y + _loc_23 * _loc_36;
                                    _loc_37 = -_loc_34.radius;
                                    _loc_27.x = _loc_34.worldCOMx + _loc_22 * _loc_37;
                                    _loc_27.y = _loc_34.worldCOMy + _loc_23 * _loc_37;
                                    _loc_15.x = _loc_22;
                                    _loc_15.y = _loc_23;
                                }
                            }
                            else
                            {
                                _loc_22 = -_loc_34.radius;
                                _loc_27.x = _loc_34.worldCOMx + _loc_31.gnormx * _loc_22;
                                _loc_27.y = _loc_34.worldCOMy + _loc_31.gnormy * _loc_22;
                                _loc_22 = -_loc_20;
                                _loc_26.x = _loc_27.x + _loc_31.gnormx * _loc_22;
                                _loc_26.y = _loc_27.y + _loc_31.gnormy * _loc_22;
                                _loc_15.x = _loc_31.gnormx;
                                _loc_15.y = _loc_31.gnormy;
                            }
                        }
                        if (_loc_38)
                        {
                            _loc_15.x = -_loc_15.x;
                            _loc_15.y = -_loc_15.y;
                        }
                    }
                    else
                    {
                        _loc_25 = _loc_32.polygon;
                        _loc_42 = _loc_33.polygon;
                        _loc_20 = -1000000000000000000000000000000;
                        _loc_31 = null;
                        _loc_40 = null;
                        _loc_36 = 0;
                        _loc_30 = _loc_25.edges.head;
                        while (_loc_30 != null)
                        {
                            
                            _loc_43 = _loc_30.elt;
                            _loc_21 = 1000000000000000000000000000000;
                            _loc_28 = _loc_42.gverts.next;
                            while (_loc_28 != null)
                            {
                                
                                _loc_29 = _loc_28;
                                _loc_22 = _loc_43.gnormx * _loc_29.x + _loc_43.gnormy * _loc_29.y;
                                if (_loc_22 < _loc_21)
                                {
                                    _loc_21 = _loc_22;
                                }
                                _loc_28 = _loc_28.next;
                            }
                            _loc_21 = _loc_21 - _loc_43.gprojection;
                            if (_loc_21 > _loc_19)
                            {
                                _loc_20 = _loc_21;
                                break;
                            }
                            if (_loc_21 > 0)
                            {
                                if (_loc_21 > _loc_20)
                                {
                                    _loc_20 = _loc_21;
                                    _loc_31 = _loc_43;
                                    _loc_36 = 1;
                                }
                            }
                            else
                            {
                                if (_loc_20 < 0)
                                {
                                }
                                if (_loc_21 > _loc_20)
                                {
                                    _loc_20 = _loc_21;
                                    _loc_31 = _loc_43;
                                    _loc_36 = 1;
                                }
                            }
                            _loc_30 = _loc_30.next;
                        }
                        if (_loc_20 < _loc_19)
                        {
                            _loc_30 = _loc_42.edges.head;
                            while (_loc_30 != null)
                            {
                                
                                _loc_43 = _loc_30.elt;
                                _loc_21 = 1000000000000000000000000000000;
                                _loc_28 = _loc_25.gverts.next;
                                while (_loc_28 != null)
                                {
                                    
                                    _loc_29 = _loc_28;
                                    _loc_22 = _loc_43.gnormx * _loc_29.x + _loc_43.gnormy * _loc_29.y;
                                    if (_loc_22 < _loc_21)
                                    {
                                        _loc_21 = _loc_22;
                                    }
                                    _loc_28 = _loc_28.next;
                                }
                                _loc_21 = _loc_21 - _loc_43.gprojection;
                                if (_loc_21 > _loc_19)
                                {
                                    _loc_20 = _loc_21;
                                    break;
                                }
                                if (_loc_21 > 0)
                                {
                                    if (_loc_21 > _loc_20)
                                    {
                                        _loc_20 = _loc_21;
                                        _loc_40 = _loc_43;
                                        _loc_36 = 2;
                                    }
                                }
                                else
                                {
                                    if (_loc_20 < 0)
                                    {
                                    }
                                    if (_loc_21 > _loc_20)
                                    {
                                        _loc_20 = _loc_21;
                                        _loc_40 = _loc_43;
                                        _loc_36 = 2;
                                    }
                                }
                                _loc_30 = _loc_30.next;
                            }
                            if (_loc_20 < _loc_19)
                            {
                                if (_loc_36 == 1)
                                {
                                    _loc_44 = _loc_25;
                                    _loc_45 = _loc_42;
                                    _loc_43 = _loc_31;
                                }
                                else
                                {
                                    _loc_44 = _loc_42;
                                    _loc_45 = _loc_25;
                                    _loc_43 = _loc_40;
                                    _loc_28 = _loc_26;
                                    _loc_26 = _loc_27;
                                    _loc_27 = _loc_28;
                                    _loc_38 = !_loc_38;
                                }
                                _loc_46 = null;
                                _loc_21 = 1000000000000000000000000000000;
                                _loc_30 = _loc_45.edges.head;
                                while (_loc_30 != null)
                                {
                                    
                                    _loc_47 = _loc_30.elt;
                                    _loc_22 = _loc_43.gnormx * _loc_47.gnormx + _loc_43.gnormy * _loc_47.gnormy;
                                    if (_loc_22 < _loc_21)
                                    {
                                        _loc_21 = _loc_22;
                                        _loc_46 = _loc_47;
                                    }
                                    _loc_30 = _loc_30.next;
                                }
                                if (_loc_38)
                                {
                                    _loc_15.x = -_loc_43.gnormx;
                                    _loc_15.y = -_loc_43.gnormy;
                                }
                                else
                                {
                                    _loc_15.x = _loc_43.gnormx;
                                    _loc_15.y = _loc_43.gnormy;
                                }
                                if (_loc_20 >= 0)
                                {
                                    _loc_28 = _loc_43.gp0;
                                    _loc_29 = _loc_43.gp1;
                                    _loc_48 = _loc_46.gp0;
                                    _loc_49 = _loc_46.gp1;
                                    _loc_22 = 0;
                                    _loc_23 = 0;
                                    _loc_24 = 0;
                                    _loc_37 = 0;
                                    _loc_22 = _loc_29.x - _loc_28.x;
                                    _loc_23 = _loc_29.y - _loc_28.y;
                                    _loc_24 = _loc_49.x - _loc_48.x;
                                    _loc_37 = _loc_49.y - _loc_48.y;
                                    _loc_41 = 1 / (_loc_22 * _loc_22 + _loc_23 * _loc_23);
                                    _loc_50 = 1 / (_loc_24 * _loc_24 + _loc_37 * _loc_37);
                                    _loc_51 = (-(_loc_22 * (_loc_28.x - _loc_48.x) + _loc_23 * (_loc_28.y - _loc_48.y))) * _loc_41;
                                    _loc_52 = (-(_loc_22 * (_loc_28.x - _loc_49.x) + _loc_23 * (_loc_28.y - _loc_49.y))) * _loc_41;
                                    _loc_53 = (-(_loc_24 * (_loc_48.x - _loc_28.x) + _loc_37 * (_loc_48.y - _loc_28.y))) * _loc_50;
                                    _loc_54 = (-(_loc_24 * (_loc_48.x - _loc_29.x) + _loc_37 * (_loc_48.y - _loc_29.y))) * _loc_50;
                                    if (_loc_51 < 0)
                                    {
                                        _loc_51 = 0;
                                    }
                                    else if (_loc_51 > 1)
                                    {
                                        _loc_51 = 1;
                                    }
                                    if (_loc_52 < 0)
                                    {
                                        _loc_52 = 0;
                                    }
                                    else if (_loc_52 > 1)
                                    {
                                        _loc_52 = 1;
                                    }
                                    if (_loc_53 < 0)
                                    {
                                        _loc_53 = 0;
                                    }
                                    else if (_loc_53 > 1)
                                    {
                                        _loc_53 = 1;
                                    }
                                    if (_loc_54 < 0)
                                    {
                                        _loc_54 = 0;
                                    }
                                    else if (_loc_54 > 1)
                                    {
                                        _loc_54 = 1;
                                    }
                                    _loc_55 = 0;
                                    _loc_56 = 0;
                                    _loc_57 = _loc_51;
                                    _loc_55 = _loc_28.x + _loc_22 * _loc_57;
                                    _loc_56 = _loc_28.y + _loc_23 * _loc_57;
                                    _loc_57 = 0;
                                    _loc_58 = 0;
                                    _loc_59 = _loc_52;
                                    _loc_57 = _loc_28.x + _loc_22 * _loc_59;
                                    _loc_58 = _loc_28.y + _loc_23 * _loc_59;
                                    _loc_59 = 0;
                                    _loc_60 = 0;
                                    _loc_61 = _loc_53;
                                    _loc_59 = _loc_48.x + _loc_24 * _loc_61;
                                    _loc_60 = _loc_48.y + _loc_37 * _loc_61;
                                    _loc_61 = 0;
                                    _loc_62 = 0;
                                    _loc_63 = _loc_54;
                                    _loc_61 = _loc_48.x + _loc_24 * _loc_63;
                                    _loc_62 = _loc_48.y + _loc_37 * _loc_63;
                                    _loc_64 = 0;
                                    _loc_65 = 0;
                                    _loc_64 = _loc_55 - _loc_48.x;
                                    _loc_65 = _loc_56 - _loc_48.y;
                                    _loc_63 = _loc_64 * _loc_64 + _loc_65 * _loc_65;
                                    _loc_65 = 0;
                                    _loc_66 = 0;
                                    _loc_65 = _loc_57 - _loc_49.x;
                                    _loc_66 = _loc_58 - _loc_49.y;
                                    _loc_64 = _loc_65 * _loc_65 + _loc_66 * _loc_66;
                                    _loc_66 = 0;
                                    _loc_67 = 0;
                                    _loc_66 = _loc_59 - _loc_28.x;
                                    _loc_67 = _loc_60 - _loc_28.y;
                                    _loc_65 = _loc_66 * _loc_66 + _loc_67 * _loc_67;
                                    _loc_67 = 0;
                                    _loc_68 = 0;
                                    _loc_67 = _loc_61 - _loc_29.x;
                                    _loc_68 = _loc_62 - _loc_29.y;
                                    _loc_66 = _loc_67 * _loc_67 + _loc_68 * _loc_68;
                                    _loc_67 = 0;
                                    _loc_68 = 0;
                                    _loc_69 = null;
                                    if (_loc_63 < _loc_64)
                                    {
                                        _loc_67 = _loc_55;
                                        _loc_68 = _loc_56;
                                        _loc_69 = _loc_48;
                                    }
                                    else
                                    {
                                        _loc_67 = _loc_57;
                                        _loc_68 = _loc_58;
                                        _loc_69 = _loc_49;
                                        _loc_63 = _loc_64;
                                    }
                                    _loc_70 = 0;
                                    _loc_71 = 0;
                                    _loc_72 = null;
                                    if (_loc_65 < _loc_66)
                                    {
                                        _loc_70 = _loc_59;
                                        _loc_71 = _loc_60;
                                        _loc_72 = _loc_28;
                                    }
                                    else
                                    {
                                        _loc_70 = _loc_61;
                                        _loc_71 = _loc_62;
                                        _loc_72 = _loc_29;
                                        _loc_65 = _loc_66;
                                    }
                                    if (_loc_63 < _loc_65)
                                    {
                                        _loc_26.x = _loc_67;
                                        _loc_26.y = _loc_68;
                                        _loc_27.x = _loc_69.x;
                                        _loc_27.y = _loc_69.y;
                                        _loc_20 = Math.sqrt(_loc_63);
                                    }
                                    else
                                    {
                                        _loc_27.x = _loc_70;
                                        _loc_27.y = _loc_71;
                                        _loc_26.x = _loc_72.x;
                                        _loc_26.y = _loc_72.y;
                                        _loc_20 = Math.sqrt(_loc_65);
                                    }
                                    if (_loc_20 != 0)
                                    {
                                        _loc_15.x = _loc_27.x - _loc_26.x;
                                        _loc_15.y = _loc_27.y - _loc_26.y;
                                        _loc_73 = 1 / _loc_20;
                                        _loc_15.x = _loc_15.x * _loc_73;
                                        _loc_15.y = _loc_15.y * _loc_73;
                                        if (_loc_38)
                                        {
                                            _loc_15.x = -_loc_15.x;
                                            _loc_15.y = -_loc_15.y;
                                        }
                                    }
                                }
                                else
                                {
                                    _loc_22 = 0;
                                    _loc_23 = 0;
                                    _loc_22 = _loc_46.gp0.x;
                                    _loc_23 = _loc_46.gp0.y;
                                    _loc_24 = 0;
                                    _loc_37 = 0;
                                    _loc_24 = _loc_46.gp1.x;
                                    _loc_37 = _loc_46.gp1.y;
                                    _loc_41 = 0;
                                    _loc_50 = 0;
                                    _loc_41 = _loc_24 - _loc_22;
                                    _loc_50 = _loc_37 - _loc_23;
                                    _loc_51 = _loc_43.gnormy * _loc_22 - _loc_43.gnormx * _loc_23;
                                    _loc_52 = _loc_43.gnormy * _loc_24 - _loc_43.gnormx * _loc_37;
                                    _loc_53 = 1 / (_loc_52 - _loc_51);
                                    _loc_54 = (-_loc_43.tp1 - _loc_51) * _loc_53;
                                    if (_loc_54 > Config.epsilon)
                                    {
                                        _loc_55 = _loc_54;
                                        _loc_22 = _loc_22 + _loc_41 * _loc_55;
                                        _loc_23 = _loc_23 + _loc_50 * _loc_55;
                                    }
                                    _loc_55 = (-_loc_43.tp0 - _loc_52) * _loc_53;
                                    if (_loc_55 < -Config.epsilon)
                                    {
                                        _loc_56 = _loc_55;
                                        _loc_24 = _loc_24 + _loc_41 * _loc_56;
                                        _loc_37 = _loc_37 + _loc_50 * _loc_56;
                                    }
                                    _loc_56 = _loc_22 * _loc_43.gnormx + _loc_23 * _loc_43.gnormy - _loc_43.gprojection;
                                    _loc_57 = _loc_24 * _loc_43.gnormx + _loc_37 * _loc_43.gnormy - _loc_43.gprojection;
                                }
                            }
                            else
                            {
                            }
                        }
                        else
                        {
                        }
                    }
                }
                _loc_18 = _loc_19 + param4;
                _loc_19 = _loc_9 * _loc_15.x + _loc_10 * _loc_15.y;
                if (_loc_18 < Config.distanceThresholdCCD)
                {
                    _loc_20 = 0;
                    _loc_21 = 0;
                    _loc_20 = _loc_13.x - _loc_7.posx;
                    _loc_21 = _loc_13.y - _loc_7.posy;
                    _loc_22 = _loc_19 - _loc_7.sweep_angvel * (_loc_15.y * _loc_20 - _loc_15.x * _loc_21);
                    if (_loc_22 > 0)
                    {
                        event.slipped = true;
                    }
                    if (_loc_22 > 0)
                    {
                    }
                    if (_loc_18 < Config.distanceThresholdCCD * 0.5)
                    {
                        break;
                    }
                }
                _loc_20 = (_loc_12 - _loc_19) * param2;
                if (_loc_20 <= 0)
                {
                    _loc_16 = -1;
                    break;
                }
                _loc_21 = _loc_18 / _loc_20;
                if (_loc_21 < 1e-006)
                {
                    _loc_21 = 1e-006;
                }
                _loc_16 = _loc_16 + _loc_21;
                if (_loc_16 >= 1)
                {
                    _loc_16 = 1;
                    _loc_22 = _loc_16 * param2;
                    _loc_23 = _loc_22 - _loc_7.sweepTime;
                    if (_loc_23 != 0)
                    {
                        _loc_7.sweepTime = _loc_22;
                        _loc_24 = _loc_23;
                        _loc_7.posx = _loc_7.posx + _loc_7.velx * _loc_24;
                        _loc_7.posy = _loc_7.posy + _loc_7.vely * _loc_24;
                        if (_loc_7.angvel != 0)
                        {
                            _loc_24 = _loc_7.sweep_angvel * _loc_23;
                            _loc_7.rot = _loc_7.rot + _loc_24;
                            if (_loc_24 * _loc_24 > 0.0001)
                            {
                                _loc_7.axisx = Math.sin(_loc_7.rot);
                                _loc_7.axisy = Math.cos(_loc_7.rot);
                            }
                            else
                            {
                                _loc_37 = _loc_24 * _loc_24;
                                _loc_41 = 1 - 0.5 * _loc_37;
                                _loc_50 = 1 - _loc_37 * _loc_37 / 8;
                                _loc_51 = (_loc_41 * _loc_7.axisx + _loc_24 * _loc_7.axisy) * _loc_50;
                                _loc_7.axisy = (_loc_41 * _loc_7.axisy - _loc_24 * _loc_7.axisx) * _loc_50;
                                _loc_7.axisx = _loc_51;
                            }
                        }
                    }
                    if (_loc_5.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_5.worldCOMx = _loc_7.posx + (_loc_7.axisy * _loc_5.localCOMx - _loc_7.axisx * _loc_5.localCOMy);
                        _loc_5.worldCOMy = _loc_7.posy + (_loc_5.localCOMx * _loc_7.axisx + _loc_5.localCOMy * _loc_7.axisy);
                    }
                    else
                    {
                        _loc_25 = _loc_5.polygon;
                        _loc_26 = _loc_25.lverts.next;
                        _loc_27 = _loc_25.gverts.next;
                        while (_loc_27 != null)
                        {
                            
                            _loc_28 = _loc_27;
                            _loc_29 = _loc_26;
                            _loc_26 = _loc_26.next;
                            _loc_28.x = _loc_7.posx + (_loc_7.axisy * _loc_29.x - _loc_7.axisx * _loc_29.y);
                            _loc_28.y = _loc_7.posy + (_loc_29.x * _loc_7.axisx + _loc_29.y * _loc_7.axisy);
                            _loc_27 = _loc_27.next;
                        }
                        _loc_30 = _loc_25.edges.head;
                        _loc_27 = _loc_25.gverts.next;
                        _loc_28 = _loc_27;
                        _loc_27 = _loc_27.next;
                        while (_loc_27 != null)
                        {
                            
                            _loc_29 = _loc_27;
                            _loc_31 = _loc_30.elt;
                            _loc_30 = _loc_30.next;
                            _loc_31.gnormx = _loc_7.axisy * _loc_31.lnormx - _loc_7.axisx * _loc_31.lnormy;
                            _loc_31.gnormy = _loc_31.lnormx * _loc_7.axisx + _loc_31.lnormy * _loc_7.axisy;
                            _loc_31.gprojection = _loc_7.posx * _loc_31.gnormx + _loc_7.posy * _loc_31.gnormy + _loc_31.lprojection;
                            _loc_31.tp0 = _loc_28.y * _loc_31.gnormx - _loc_28.x * _loc_31.gnormy;
                            _loc_31.tp1 = _loc_29.y * _loc_31.gnormx - _loc_29.x * _loc_31.gnormy;
                            _loc_28 = _loc_29;
                            _loc_27 = _loc_27.next;
                        }
                        _loc_29 = _loc_25.gverts.next;
                        _loc_31 = _loc_30.elt;
                        _loc_30 = _loc_30.next;
                        _loc_31.gnormx = _loc_7.axisy * _loc_31.lnormx - _loc_7.axisx * _loc_31.lnormy;
                        _loc_31.gnormy = _loc_31.lnormx * _loc_7.axisx + _loc_31.lnormy * _loc_7.axisy;
                        _loc_31.gprojection = _loc_7.posx * _loc_31.gnormx + _loc_7.posy * _loc_31.gnormy + _loc_31.lprojection;
                        _loc_31.tp0 = _loc_28.y * _loc_31.gnormx - _loc_28.x * _loc_31.gnormy;
                        _loc_31.tp1 = _loc_29.y * _loc_31.gnormx - _loc_29.x * _loc_31.gnormy;
                    }
                    _loc_32 = _loc_5;
                    _loc_33 = _loc_6;
                    _loc_26 = _loc_13;
                    _loc_27 = _loc_14;
                    _loc_23 = 1000000000000000000000000000000;
                    if (_loc_32.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                    }
                    if (_loc_33.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_34 = _loc_32.circle;
                        _loc_35 = _loc_33.circle;
                        _loc_37 = 0;
                        _loc_41 = 0;
                        _loc_37 = _loc_35.worldCOMx - _loc_34.worldCOMx;
                        _loc_41 = _loc_35.worldCOMy - _loc_34.worldCOMy;
                        _loc_51 = _loc_37 * _loc_37 + _loc_41 * _loc_41;
                        if (_loc_51 == 0)
                        {
                            _loc_50 = 0;
                        }
                        else
                        {
                            _loc_36 = 1597463007 - (0 >> 1);
                            _loc_52 = 0;
                            _loc_50 = 0 / (_loc_52 * (1.5 - 0.5 * _loc_51 * _loc_52 * _loc_52));
                        }
                        _loc_24 = _loc_50 - (_loc_34.radius + _loc_35.radius);
                        if (_loc_24 < _loc_23)
                        {
                            if (_loc_50 == 0)
                            {
                                _loc_37 = 1;
                                _loc_41 = 0;
                            }
                            else
                            {
                                _loc_51 = 1 / _loc_50;
                                _loc_37 = _loc_37 * _loc_51;
                                _loc_41 = _loc_41 * _loc_51;
                            }
                            _loc_51 = _loc_34.radius;
                            _loc_26.x = _loc_34.worldCOMx + _loc_37 * _loc_51;
                            _loc_26.y = _loc_34.worldCOMy + _loc_41 * _loc_51;
                            _loc_51 = -_loc_35.radius;
                            _loc_27.x = _loc_35.worldCOMx + _loc_37 * _loc_51;
                            _loc_27.y = _loc_35.worldCOMy + _loc_41 * _loc_51;
                            _loc_15.x = _loc_37;
                            _loc_15.y = _loc_41;
                        }
                    }
                    else
                    {
                        _loc_38 = false;
                        if (_loc_32.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                        }
                        if (_loc_33.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_39 = _loc_32;
                            _loc_32 = _loc_33;
                            _loc_33 = _loc_39;
                            _loc_28 = _loc_26;
                            _loc_26 = _loc_27;
                            _loc_27 = _loc_28;
                            _loc_38 = true;
                        }
                        if (_loc_32.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                        }
                        if (_loc_33.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_25 = _loc_32.polygon;
                            _loc_34 = _loc_33.circle;
                            _loc_24 = -1000000000000000000000000000000;
                            _loc_31 = null;
                            _loc_30 = _loc_25.edges.head;
                            while (_loc_30 != null)
                            {
                                
                                _loc_40 = _loc_30.elt;
                                _loc_37 = _loc_40.gnormx * _loc_34.worldCOMx + _loc_40.gnormy * _loc_34.worldCOMy - _loc_40.gprojection - _loc_34.radius;
                                if (_loc_37 > _loc_23)
                                {
                                    _loc_24 = _loc_37;
                                    break;
                                }
                                if (_loc_37 > 0)
                                {
                                    if (_loc_37 > _loc_24)
                                    {
                                        _loc_24 = _loc_37;
                                        _loc_31 = _loc_40;
                                    }
                                }
                                else
                                {
                                    if (_loc_24 < 0)
                                    {
                                    }
                                    if (_loc_37 > _loc_24)
                                    {
                                        _loc_24 = _loc_37;
                                        _loc_31 = _loc_40;
                                    }
                                }
                                _loc_30 = _loc_30.next;
                            }
                            if (_loc_24 < _loc_23)
                            {
                                _loc_28 = _loc_31.gp0;
                                _loc_29 = _loc_31.gp1;
                                _loc_37 = _loc_34.worldCOMy * _loc_31.gnormx - _loc_34.worldCOMx * _loc_31.gnormy;
                                if (_loc_37 <= _loc_28.y * _loc_31.gnormx - _loc_28.x * _loc_31.gnormy)
                                {
                                    _loc_41 = 0;
                                    _loc_50 = 0;
                                    _loc_41 = _loc_34.worldCOMx - _loc_28.x;
                                    _loc_50 = _loc_34.worldCOMy - _loc_28.y;
                                    _loc_52 = _loc_41 * _loc_41 + _loc_50 * _loc_50;
                                    if (_loc_52 == 0)
                                    {
                                        _loc_51 = 0;
                                    }
                                    else
                                    {
                                        _loc_36 = 1597463007 - (0 >> 1);
                                        _loc_53 = 0;
                                        _loc_51 = 0 / (_loc_53 * (1.5 - 0.5 * _loc_52 * _loc_53 * _loc_53));
                                    }
                                    _loc_24 = _loc_51 - _loc_34.radius;
                                    if (_loc_24 < _loc_23)
                                    {
                                        if (_loc_51 == 0)
                                        {
                                            _loc_41 = 1;
                                            _loc_50 = 0;
                                        }
                                        else
                                        {
                                            _loc_52 = 1 / _loc_51;
                                            _loc_41 = _loc_41 * _loc_52;
                                            _loc_50 = _loc_50 * _loc_52;
                                        }
                                        _loc_36 = 0;
                                        _loc_26.x = _loc_28.x + _loc_41 * _loc_36;
                                        _loc_26.y = _loc_28.y + _loc_50 * _loc_36;
                                        _loc_52 = -_loc_34.radius;
                                        _loc_27.x = _loc_34.worldCOMx + _loc_41 * _loc_52;
                                        _loc_27.y = _loc_34.worldCOMy + _loc_50 * _loc_52;
                                        _loc_15.x = _loc_41;
                                        _loc_15.y = _loc_50;
                                    }
                                }
                                else if (_loc_37 >= _loc_29.y * _loc_31.gnormx - _loc_29.x * _loc_31.gnormy)
                                {
                                    _loc_41 = 0;
                                    _loc_50 = 0;
                                    _loc_41 = _loc_34.worldCOMx - _loc_29.x;
                                    _loc_50 = _loc_34.worldCOMy - _loc_29.y;
                                    _loc_52 = _loc_41 * _loc_41 + _loc_50 * _loc_50;
                                    if (_loc_52 == 0)
                                    {
                                        _loc_51 = 0;
                                    }
                                    else
                                    {
                                        _loc_36 = 1597463007 - (0 >> 1);
                                        _loc_53 = 0;
                                        _loc_51 = 0 / (_loc_53 * (1.5 - 0.5 * _loc_52 * _loc_53 * _loc_53));
                                    }
                                    _loc_24 = _loc_51 - _loc_34.radius;
                                    if (_loc_24 < _loc_23)
                                    {
                                        if (_loc_51 == 0)
                                        {
                                            _loc_41 = 1;
                                            _loc_50 = 0;
                                        }
                                        else
                                        {
                                            _loc_52 = 1 / _loc_51;
                                            _loc_41 = _loc_41 * _loc_52;
                                            _loc_50 = _loc_50 * _loc_52;
                                        }
                                        _loc_36 = 0;
                                        _loc_26.x = _loc_29.x + _loc_41 * _loc_36;
                                        _loc_26.y = _loc_29.y + _loc_50 * _loc_36;
                                        _loc_52 = -_loc_34.radius;
                                        _loc_27.x = _loc_34.worldCOMx + _loc_41 * _loc_52;
                                        _loc_27.y = _loc_34.worldCOMy + _loc_50 * _loc_52;
                                        _loc_15.x = _loc_41;
                                        _loc_15.y = _loc_50;
                                    }
                                }
                                else
                                {
                                    _loc_41 = -_loc_34.radius;
                                    _loc_27.x = _loc_34.worldCOMx + _loc_31.gnormx * _loc_41;
                                    _loc_27.y = _loc_34.worldCOMy + _loc_31.gnormy * _loc_41;
                                    _loc_41 = -_loc_24;
                                    _loc_26.x = _loc_27.x + _loc_31.gnormx * _loc_41;
                                    _loc_26.y = _loc_27.y + _loc_31.gnormy * _loc_41;
                                    _loc_15.x = _loc_31.gnormx;
                                    _loc_15.y = _loc_31.gnormy;
                                }
                            }
                            if (_loc_38)
                            {
                                _loc_15.x = -_loc_15.x;
                                _loc_15.y = -_loc_15.y;
                            }
                        }
                        else
                        {
                            _loc_25 = _loc_32.polygon;
                            _loc_42 = _loc_33.polygon;
                            _loc_24 = -1000000000000000000000000000000;
                            _loc_31 = null;
                            _loc_40 = null;
                            _loc_36 = 0;
                            _loc_30 = _loc_25.edges.head;
                            while (_loc_30 != null)
                            {
                                
                                _loc_43 = _loc_30.elt;
                                _loc_37 = 1000000000000000000000000000000;
                                _loc_28 = _loc_42.gverts.next;
                                while (_loc_28 != null)
                                {
                                    
                                    _loc_29 = _loc_28;
                                    _loc_41 = _loc_43.gnormx * _loc_29.x + _loc_43.gnormy * _loc_29.y;
                                    if (_loc_41 < _loc_37)
                                    {
                                        _loc_37 = _loc_41;
                                    }
                                    _loc_28 = _loc_28.next;
                                }
                                _loc_37 = _loc_37 - _loc_43.gprojection;
                                if (_loc_37 > _loc_23)
                                {
                                    _loc_24 = _loc_37;
                                    break;
                                }
                                if (_loc_37 > 0)
                                {
                                    if (_loc_37 > _loc_24)
                                    {
                                        _loc_24 = _loc_37;
                                        _loc_31 = _loc_43;
                                        _loc_36 = 1;
                                    }
                                }
                                else
                                {
                                    if (_loc_24 < 0)
                                    {
                                    }
                                    if (_loc_37 > _loc_24)
                                    {
                                        _loc_24 = _loc_37;
                                        _loc_31 = _loc_43;
                                        _loc_36 = 1;
                                    }
                                }
                                _loc_30 = _loc_30.next;
                            }
                            if (_loc_24 < _loc_23)
                            {
                                _loc_30 = _loc_42.edges.head;
                                while (_loc_30 != null)
                                {
                                    
                                    _loc_43 = _loc_30.elt;
                                    _loc_37 = 1000000000000000000000000000000;
                                    _loc_28 = _loc_25.gverts.next;
                                    while (_loc_28 != null)
                                    {
                                        
                                        _loc_29 = _loc_28;
                                        _loc_41 = _loc_43.gnormx * _loc_29.x + _loc_43.gnormy * _loc_29.y;
                                        if (_loc_41 < _loc_37)
                                        {
                                            _loc_37 = _loc_41;
                                        }
                                        _loc_28 = _loc_28.next;
                                    }
                                    _loc_37 = _loc_37 - _loc_43.gprojection;
                                    if (_loc_37 > _loc_23)
                                    {
                                        _loc_24 = _loc_37;
                                        break;
                                    }
                                    if (_loc_37 > 0)
                                    {
                                        if (_loc_37 > _loc_24)
                                        {
                                            _loc_24 = _loc_37;
                                            _loc_40 = _loc_43;
                                            _loc_36 = 2;
                                        }
                                    }
                                    else
                                    {
                                        if (_loc_24 < 0)
                                        {
                                        }
                                        if (_loc_37 > _loc_24)
                                        {
                                            _loc_24 = _loc_37;
                                            _loc_40 = _loc_43;
                                            _loc_36 = 2;
                                        }
                                    }
                                    _loc_30 = _loc_30.next;
                                }
                                if (_loc_24 < _loc_23)
                                {
                                    if (_loc_36 == 1)
                                    {
                                        _loc_44 = _loc_25;
                                        _loc_45 = _loc_42;
                                        _loc_43 = _loc_31;
                                    }
                                    else
                                    {
                                        _loc_44 = _loc_42;
                                        _loc_45 = _loc_25;
                                        _loc_43 = _loc_40;
                                        _loc_28 = _loc_26;
                                        _loc_26 = _loc_27;
                                        _loc_27 = _loc_28;
                                        _loc_38 = !_loc_38;
                                    }
                                    _loc_46 = null;
                                    _loc_37 = 1000000000000000000000000000000;
                                    _loc_30 = _loc_45.edges.head;
                                    while (_loc_30 != null)
                                    {
                                        
                                        _loc_47 = _loc_30.elt;
                                        _loc_41 = _loc_43.gnormx * _loc_47.gnormx + _loc_43.gnormy * _loc_47.gnormy;
                                        if (_loc_41 < _loc_37)
                                        {
                                            _loc_37 = _loc_41;
                                            _loc_46 = _loc_47;
                                        }
                                        _loc_30 = _loc_30.next;
                                    }
                                    if (_loc_38)
                                    {
                                        _loc_15.x = -_loc_43.gnormx;
                                        _loc_15.y = -_loc_43.gnormy;
                                    }
                                    else
                                    {
                                        _loc_15.x = _loc_43.gnormx;
                                        _loc_15.y = _loc_43.gnormy;
                                    }
                                    if (_loc_24 >= 0)
                                    {
                                        _loc_28 = _loc_43.gp0;
                                        _loc_29 = _loc_43.gp1;
                                        _loc_48 = _loc_46.gp0;
                                        _loc_49 = _loc_46.gp1;
                                        _loc_41 = 0;
                                        _loc_50 = 0;
                                        _loc_51 = 0;
                                        _loc_52 = 0;
                                        _loc_41 = _loc_29.x - _loc_28.x;
                                        _loc_50 = _loc_29.y - _loc_28.y;
                                        _loc_51 = _loc_49.x - _loc_48.x;
                                        _loc_52 = _loc_49.y - _loc_48.y;
                                        _loc_53 = 1 / (_loc_41 * _loc_41 + _loc_50 * _loc_50);
                                        _loc_54 = 1 / (_loc_51 * _loc_51 + _loc_52 * _loc_52);
                                        _loc_55 = (-(_loc_41 * (_loc_28.x - _loc_48.x) + _loc_50 * (_loc_28.y - _loc_48.y))) * _loc_53;
                                        _loc_56 = (-(_loc_41 * (_loc_28.x - _loc_49.x) + _loc_50 * (_loc_28.y - _loc_49.y))) * _loc_53;
                                        _loc_57 = (-(_loc_51 * (_loc_48.x - _loc_28.x) + _loc_52 * (_loc_48.y - _loc_28.y))) * _loc_54;
                                        _loc_58 = (-(_loc_51 * (_loc_48.x - _loc_29.x) + _loc_52 * (_loc_48.y - _loc_29.y))) * _loc_54;
                                        if (_loc_55 < 0)
                                        {
                                            _loc_55 = 0;
                                        }
                                        else if (_loc_55 > 1)
                                        {
                                            _loc_55 = 1;
                                        }
                                        if (_loc_56 < 0)
                                        {
                                            _loc_56 = 0;
                                        }
                                        else if (_loc_56 > 1)
                                        {
                                            _loc_56 = 1;
                                        }
                                        if (_loc_57 < 0)
                                        {
                                            _loc_57 = 0;
                                        }
                                        else if (_loc_57 > 1)
                                        {
                                            _loc_57 = 1;
                                        }
                                        if (_loc_58 < 0)
                                        {
                                            _loc_58 = 0;
                                        }
                                        else if (_loc_58 > 1)
                                        {
                                            _loc_58 = 1;
                                        }
                                        _loc_59 = 0;
                                        _loc_60 = 0;
                                        _loc_61 = _loc_55;
                                        _loc_59 = _loc_28.x + _loc_41 * _loc_61;
                                        _loc_60 = _loc_28.y + _loc_50 * _loc_61;
                                        _loc_61 = 0;
                                        _loc_62 = 0;
                                        _loc_63 = _loc_56;
                                        _loc_61 = _loc_28.x + _loc_41 * _loc_63;
                                        _loc_62 = _loc_28.y + _loc_50 * _loc_63;
                                        _loc_63 = 0;
                                        _loc_64 = 0;
                                        _loc_65 = _loc_57;
                                        _loc_63 = _loc_48.x + _loc_51 * _loc_65;
                                        _loc_64 = _loc_48.y + _loc_52 * _loc_65;
                                        _loc_65 = 0;
                                        _loc_66 = 0;
                                        _loc_67 = _loc_58;
                                        _loc_65 = _loc_48.x + _loc_51 * _loc_67;
                                        _loc_66 = _loc_48.y + _loc_52 * _loc_67;
                                        _loc_68 = 0;
                                        _loc_70 = 0;
                                        _loc_68 = _loc_59 - _loc_48.x;
                                        _loc_70 = _loc_60 - _loc_48.y;
                                        _loc_67 = _loc_68 * _loc_68 + _loc_70 * _loc_70;
                                        _loc_70 = 0;
                                        _loc_71 = 0;
                                        _loc_70 = _loc_61 - _loc_49.x;
                                        _loc_71 = _loc_62 - _loc_49.y;
                                        _loc_68 = _loc_70 * _loc_70 + _loc_71 * _loc_71;
                                        _loc_71 = 0;
                                        _loc_73 = 0;
                                        _loc_71 = _loc_63 - _loc_28.x;
                                        _loc_73 = _loc_64 - _loc_28.y;
                                        _loc_70 = _loc_71 * _loc_71 + _loc_73 * _loc_73;
                                        _loc_73 = 0;
                                        _loc_74 = 0;
                                        _loc_73 = _loc_65 - _loc_29.x;
                                        _loc_74 = _loc_66 - _loc_29.y;
                                        _loc_71 = _loc_73 * _loc_73 + _loc_74 * _loc_74;
                                        _loc_73 = 0;
                                        _loc_74 = 0;
                                        _loc_69 = null;
                                        if (_loc_67 < _loc_68)
                                        {
                                            _loc_73 = _loc_59;
                                            _loc_74 = _loc_60;
                                            _loc_69 = _loc_48;
                                        }
                                        else
                                        {
                                            _loc_73 = _loc_61;
                                            _loc_74 = _loc_62;
                                            _loc_69 = _loc_49;
                                            _loc_67 = _loc_68;
                                        }
                                        _loc_75 = 0;
                                        _loc_76 = 0;
                                        _loc_72 = null;
                                        if (_loc_70 < _loc_71)
                                        {
                                            _loc_75 = _loc_63;
                                            _loc_76 = _loc_64;
                                            _loc_72 = _loc_28;
                                        }
                                        else
                                        {
                                            _loc_75 = _loc_65;
                                            _loc_76 = _loc_66;
                                            _loc_72 = _loc_29;
                                            _loc_70 = _loc_71;
                                        }
                                        if (_loc_67 < _loc_70)
                                        {
                                            _loc_26.x = _loc_73;
                                            _loc_26.y = _loc_74;
                                            _loc_27.x = _loc_69.x;
                                            _loc_27.y = _loc_69.y;
                                            _loc_24 = Math.sqrt(_loc_67);
                                        }
                                        else
                                        {
                                            _loc_27.x = _loc_75;
                                            _loc_27.y = _loc_76;
                                            _loc_26.x = _loc_72.x;
                                            _loc_26.y = _loc_72.y;
                                            _loc_24 = Math.sqrt(_loc_70);
                                        }
                                        if (_loc_24 != 0)
                                        {
                                            _loc_15.x = _loc_27.x - _loc_26.x;
                                            _loc_15.y = _loc_27.y - _loc_26.y;
                                            _loc_77 = 1 / _loc_24;
                                            _loc_15.x = _loc_15.x * _loc_77;
                                            _loc_15.y = _loc_15.y * _loc_77;
                                            if (_loc_38)
                                            {
                                                _loc_15.x = -_loc_15.x;
                                                _loc_15.y = -_loc_15.y;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        _loc_41 = 0;
                                        _loc_50 = 0;
                                        _loc_41 = _loc_46.gp0.x;
                                        _loc_50 = _loc_46.gp0.y;
                                        _loc_51 = 0;
                                        _loc_52 = 0;
                                        _loc_51 = _loc_46.gp1.x;
                                        _loc_52 = _loc_46.gp1.y;
                                        _loc_53 = 0;
                                        _loc_54 = 0;
                                        _loc_53 = _loc_51 - _loc_41;
                                        _loc_54 = _loc_52 - _loc_50;
                                        _loc_55 = _loc_43.gnormy * _loc_41 - _loc_43.gnormx * _loc_50;
                                        _loc_56 = _loc_43.gnormy * _loc_51 - _loc_43.gnormx * _loc_52;
                                        _loc_57 = 1 / (_loc_56 - _loc_55);
                                        _loc_58 = (-_loc_43.tp1 - _loc_55) * _loc_57;
                                        if (_loc_58 > Config.epsilon)
                                        {
                                            _loc_59 = _loc_58;
                                            _loc_41 = _loc_41 + _loc_53 * _loc_59;
                                            _loc_50 = _loc_50 + _loc_54 * _loc_59;
                                        }
                                        _loc_59 = (-_loc_43.tp0 - _loc_56) * _loc_57;
                                        if (_loc_59 < -Config.epsilon)
                                        {
                                            _loc_60 = _loc_59;
                                            _loc_51 = _loc_51 + _loc_53 * _loc_60;
                                            _loc_52 = _loc_52 + _loc_54 * _loc_60;
                                        }
                                        _loc_60 = _loc_41 * _loc_43.gnormx + _loc_50 * _loc_43.gnormy - _loc_43.gprojection;
                                        _loc_61 = _loc_51 * _loc_43.gnormx + _loc_52 * _loc_43.gnormy - _loc_43.gprojection;
                                    }
                                }
                                else
                                {
                                }
                            }
                            else
                            {
                            }
                        }
                    }
                    _loc_22 = _loc_23 + param4;
                    _loc_23 = _loc_9 * _loc_15.x + _loc_10 * _loc_15.y;
                    if (_loc_22 < Config.distanceThresholdCCD)
                    {
                        _loc_24 = 0;
                        _loc_37 = 0;
                        _loc_24 = _loc_13.x - _loc_7.posx;
                        _loc_37 = _loc_13.y - _loc_7.posy;
                        _loc_41 = _loc_23 - _loc_7.sweep_angvel * (_loc_15.y * _loc_24 - _loc_15.x * _loc_37);
                        if (_loc_41 > 0)
                        {
                            event.slipped = true;
                        }
                        if (_loc_41 > 0)
                        {
                        }
                        if (_loc_22 < Config.distanceThresholdCCD * 0.5)
                        {
                            break;
                        }
                    }
                    _loc_16 = -1;
                    break;
                }
                _loc_17++;
                if (_loc_17 >= 40)
                {
                    if (_loc_18 > param4)
                    {
                        event.failed = true;
                    }
                    break;
                }
            }
            event.toi = _loc_16;
            return;
        }// end function

        public static function distanceBody(param1:ZPP_Body, param2:ZPP_Body, param3:ZPP_Vec2, param4:ZPP_Vec2) : Number
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_10:* = null as ZPP_Shape;
            var _loc_11:* = null as ZNPNode_ZPP_Shape;
            var _loc_12:* = null as ZPP_Shape;
            var _loc_13:* = NaN;
            var _loc_14:* = null as ZPP_Shape;
            var _loc_15:* = null as ZPP_Shape;
            var _loc_16:* = null as ZPP_Vec2;
            var _loc_17:* = null as ZPP_Vec2;
            var _loc_18:* = null as ZPP_Circle;
            var _loc_19:* = null as ZPP_Circle;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = 0;
            var _loc_26:* = NaN;
            var _loc_27:* = false;
            var _loc_28:* = null as ZPP_Shape;
            var _loc_29:* = null as ZPP_Vec2;
            var _loc_30:* = null as ZPP_Polygon;
            var _loc_31:* = null as ZPP_Edge;
            var _loc_32:* = null as ZNPNode_ZPP_Edge;
            var _loc_33:* = null as ZPP_Edge;
            var _loc_34:* = null as ZPP_Vec2;
            var _loc_35:* = NaN;
            var _loc_36:* = null as ZPP_Polygon;
            var _loc_37:* = null as ZPP_Edge;
            var _loc_38:* = null as ZPP_Polygon;
            var _loc_39:* = null as ZPP_Polygon;
            var _loc_40:* = null as ZPP_Edge;
            var _loc_41:* = null as ZPP_Edge;
            var _loc_42:* = null as ZPP_Vec2;
            var _loc_43:* = null as ZPP_Vec2;
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
            var _loc_56:* = NaN;
            var _loc_57:* = NaN;
            var _loc_58:* = NaN;
            var _loc_59:* = NaN;
            var _loc_60:* = NaN;
            var _loc_61:* = NaN;
            var _loc_62:* = NaN;
            var _loc_63:* = null as ZPP_Vec2;
            var _loc_64:* = NaN;
            var _loc_65:* = NaN;
            var _loc_66:* = null as ZPP_Vec2;
            var _loc_67:* = NaN;
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
            var _loc_8:* = 1000000000000000000000000000000;
            var _loc_9:* = param1.shapes.head;
            while (_loc_9 != null)
            {
                
                _loc_10 = _loc_9.elt;
                _loc_11 = param2.shapes.head;
                while (_loc_11 != null)
                {
                    
                    _loc_12 = _loc_11.elt;
                    _loc_14 = _loc_10;
                    _loc_15 = _loc_12;
                    _loc_16 = _loc_5;
                    _loc_17 = _loc_6;
                    if (_loc_14.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                    }
                    if (_loc_15.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_18 = _loc_14.circle;
                        _loc_19 = _loc_15.circle;
                        _loc_21 = 0;
                        _loc_22 = 0;
                        _loc_21 = _loc_19.worldCOMx - _loc_18.worldCOMx;
                        _loc_22 = _loc_19.worldCOMy - _loc_18.worldCOMy;
                        _loc_24 = _loc_21 * _loc_21 + _loc_22 * _loc_22;
                        if (_loc_24 == 0)
                        {
                            _loc_23 = 0;
                        }
                        else
                        {
                            _loc_25 = 1597463007 - (0 >> 1);
                            _loc_26 = 0;
                            _loc_23 = 0 / (_loc_26 * (1.5 - 0.5 * _loc_24 * _loc_26 * _loc_26));
                        }
                        _loc_20 = _loc_23 - (_loc_18.radius + _loc_19.radius);
                        if (_loc_20 < _loc_8)
                        {
                            if (_loc_23 == 0)
                            {
                                _loc_21 = 1;
                                _loc_22 = 0;
                            }
                            else
                            {
                                _loc_24 = 1 / _loc_23;
                                _loc_21 = _loc_21 * _loc_24;
                                _loc_22 = _loc_22 * _loc_24;
                            }
                            _loc_24 = _loc_18.radius;
                            _loc_16.x = _loc_18.worldCOMx + _loc_21 * _loc_24;
                            _loc_16.y = _loc_18.worldCOMy + _loc_22 * _loc_24;
                            _loc_24 = -_loc_19.radius;
                            _loc_17.x = _loc_19.worldCOMx + _loc_21 * _loc_24;
                            _loc_17.y = _loc_19.worldCOMy + _loc_22 * _loc_24;
                            _loc_7.x = _loc_21;
                            _loc_7.y = _loc_22;
                        }
                        _loc_13 = _loc_20;
                    }
                    else
                    {
                        _loc_27 = false;
                        if (_loc_14.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                        }
                        if (_loc_15.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_28 = _loc_14;
                            _loc_14 = _loc_15;
                            _loc_15 = _loc_28;
                            _loc_29 = _loc_16;
                            _loc_16 = _loc_17;
                            _loc_17 = _loc_29;
                            _loc_27 = true;
                        }
                        if (_loc_14.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                        }
                        if (_loc_15.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_30 = _loc_14.polygon;
                            _loc_18 = _loc_15.circle;
                            _loc_20 = -1000000000000000000000000000000;
                            _loc_31 = null;
                            _loc_32 = _loc_30.edges.head;
                            while (_loc_32 != null)
                            {
                                
                                _loc_33 = _loc_32.elt;
                                _loc_21 = _loc_33.gnormx * _loc_18.worldCOMx + _loc_33.gnormy * _loc_18.worldCOMy - _loc_33.gprojection - _loc_18.radius;
                                if (_loc_21 > _loc_8)
                                {
                                    _loc_20 = _loc_21;
                                    break;
                                }
                                if (_loc_21 > 0)
                                {
                                    if (_loc_21 > _loc_20)
                                    {
                                        _loc_20 = _loc_21;
                                        _loc_31 = _loc_33;
                                    }
                                }
                                else
                                {
                                    if (_loc_20 < 0)
                                    {
                                    }
                                    if (_loc_21 > _loc_20)
                                    {
                                        _loc_20 = _loc_21;
                                        _loc_31 = _loc_33;
                                    }
                                }
                                _loc_32 = _loc_32.next;
                            }
                            if (_loc_20 < _loc_8)
                            {
                                _loc_29 = _loc_31.gp0;
                                _loc_34 = _loc_31.gp1;
                                _loc_21 = _loc_18.worldCOMy * _loc_31.gnormx - _loc_18.worldCOMx * _loc_31.gnormy;
                                if (_loc_21 <= _loc_29.y * _loc_31.gnormx - _loc_29.x * _loc_31.gnormy)
                                {
                                    _loc_22 = 0;
                                    _loc_23 = 0;
                                    _loc_22 = _loc_18.worldCOMx - _loc_29.x;
                                    _loc_23 = _loc_18.worldCOMy - _loc_29.y;
                                    _loc_26 = _loc_22 * _loc_22 + _loc_23 * _loc_23;
                                    if (_loc_26 == 0)
                                    {
                                        _loc_24 = 0;
                                    }
                                    else
                                    {
                                        _loc_25 = 1597463007 - (0 >> 1);
                                        _loc_35 = 0;
                                        _loc_24 = 0 / (_loc_35 * (1.5 - 0.5 * _loc_26 * _loc_35 * _loc_35));
                                    }
                                    _loc_20 = _loc_24 - _loc_18.radius;
                                    if (_loc_20 < _loc_8)
                                    {
                                        if (_loc_24 == 0)
                                        {
                                            _loc_22 = 1;
                                            _loc_23 = 0;
                                        }
                                        else
                                        {
                                            _loc_26 = 1 / _loc_24;
                                            _loc_22 = _loc_22 * _loc_26;
                                            _loc_23 = _loc_23 * _loc_26;
                                        }
                                        _loc_25 = 0;
                                        _loc_16.x = _loc_29.x + _loc_22 * _loc_25;
                                        _loc_16.y = _loc_29.y + _loc_23 * _loc_25;
                                        _loc_26 = -_loc_18.radius;
                                        _loc_17.x = _loc_18.worldCOMx + _loc_22 * _loc_26;
                                        _loc_17.y = _loc_18.worldCOMy + _loc_23 * _loc_26;
                                        _loc_7.x = _loc_22;
                                        _loc_7.y = _loc_23;
                                    }
                                }
                                else if (_loc_21 >= _loc_34.y * _loc_31.gnormx - _loc_34.x * _loc_31.gnormy)
                                {
                                    _loc_22 = 0;
                                    _loc_23 = 0;
                                    _loc_22 = _loc_18.worldCOMx - _loc_34.x;
                                    _loc_23 = _loc_18.worldCOMy - _loc_34.y;
                                    _loc_26 = _loc_22 * _loc_22 + _loc_23 * _loc_23;
                                    if (_loc_26 == 0)
                                    {
                                        _loc_24 = 0;
                                    }
                                    else
                                    {
                                        _loc_25 = 1597463007 - (0 >> 1);
                                        _loc_35 = 0;
                                        _loc_24 = 0 / (_loc_35 * (1.5 - 0.5 * _loc_26 * _loc_35 * _loc_35));
                                    }
                                    _loc_20 = _loc_24 - _loc_18.radius;
                                    if (_loc_20 < _loc_8)
                                    {
                                        if (_loc_24 == 0)
                                        {
                                            _loc_22 = 1;
                                            _loc_23 = 0;
                                        }
                                        else
                                        {
                                            _loc_26 = 1 / _loc_24;
                                            _loc_22 = _loc_22 * _loc_26;
                                            _loc_23 = _loc_23 * _loc_26;
                                        }
                                        _loc_25 = 0;
                                        _loc_16.x = _loc_34.x + _loc_22 * _loc_25;
                                        _loc_16.y = _loc_34.y + _loc_23 * _loc_25;
                                        _loc_26 = -_loc_18.radius;
                                        _loc_17.x = _loc_18.worldCOMx + _loc_22 * _loc_26;
                                        _loc_17.y = _loc_18.worldCOMy + _loc_23 * _loc_26;
                                        _loc_7.x = _loc_22;
                                        _loc_7.y = _loc_23;
                                    }
                                }
                                else
                                {
                                    _loc_22 = -_loc_18.radius;
                                    _loc_17.x = _loc_18.worldCOMx + _loc_31.gnormx * _loc_22;
                                    _loc_17.y = _loc_18.worldCOMy + _loc_31.gnormy * _loc_22;
                                    _loc_22 = -_loc_20;
                                    _loc_16.x = _loc_17.x + _loc_31.gnormx * _loc_22;
                                    _loc_16.y = _loc_17.y + _loc_31.gnormy * _loc_22;
                                    _loc_7.x = _loc_31.gnormx;
                                    _loc_7.y = _loc_31.gnormy;
                                }
                            }
                            if (_loc_27)
                            {
                                _loc_7.x = -_loc_7.x;
                                _loc_7.y = -_loc_7.y;
                            }
                            _loc_13 = _loc_20;
                        }
                        else
                        {
                            _loc_30 = _loc_14.polygon;
                            _loc_36 = _loc_15.polygon;
                            _loc_20 = -1000000000000000000000000000000;
                            _loc_31 = null;
                            _loc_33 = null;
                            _loc_25 = 0;
                            _loc_32 = _loc_30.edges.head;
                            while (_loc_32 != null)
                            {
                                
                                _loc_37 = _loc_32.elt;
                                _loc_21 = 1000000000000000000000000000000;
                                _loc_29 = _loc_36.gverts.next;
                                while (_loc_29 != null)
                                {
                                    
                                    _loc_34 = _loc_29;
                                    _loc_22 = _loc_37.gnormx * _loc_34.x + _loc_37.gnormy * _loc_34.y;
                                    if (_loc_22 < _loc_21)
                                    {
                                        _loc_21 = _loc_22;
                                    }
                                    _loc_29 = _loc_29.next;
                                }
                                _loc_21 = _loc_21 - _loc_37.gprojection;
                                if (_loc_21 > _loc_8)
                                {
                                    _loc_20 = _loc_21;
                                    break;
                                }
                                if (_loc_21 > 0)
                                {
                                    if (_loc_21 > _loc_20)
                                    {
                                        _loc_20 = _loc_21;
                                        _loc_31 = _loc_37;
                                        _loc_25 = 1;
                                    }
                                }
                                else
                                {
                                    if (_loc_20 < 0)
                                    {
                                    }
                                    if (_loc_21 > _loc_20)
                                    {
                                        _loc_20 = _loc_21;
                                        _loc_31 = _loc_37;
                                        _loc_25 = 1;
                                    }
                                }
                                _loc_32 = _loc_32.next;
                            }
                            if (_loc_20 < _loc_8)
                            {
                                _loc_32 = _loc_36.edges.head;
                                while (_loc_32 != null)
                                {
                                    
                                    _loc_37 = _loc_32.elt;
                                    _loc_21 = 1000000000000000000000000000000;
                                    _loc_29 = _loc_30.gverts.next;
                                    while (_loc_29 != null)
                                    {
                                        
                                        _loc_34 = _loc_29;
                                        _loc_22 = _loc_37.gnormx * _loc_34.x + _loc_37.gnormy * _loc_34.y;
                                        if (_loc_22 < _loc_21)
                                        {
                                            _loc_21 = _loc_22;
                                        }
                                        _loc_29 = _loc_29.next;
                                    }
                                    _loc_21 = _loc_21 - _loc_37.gprojection;
                                    if (_loc_21 > _loc_8)
                                    {
                                        _loc_20 = _loc_21;
                                        break;
                                    }
                                    if (_loc_21 > 0)
                                    {
                                        if (_loc_21 > _loc_20)
                                        {
                                            _loc_20 = _loc_21;
                                            _loc_33 = _loc_37;
                                            _loc_25 = 2;
                                        }
                                    }
                                    else
                                    {
                                        if (_loc_20 < 0)
                                        {
                                        }
                                        if (_loc_21 > _loc_20)
                                        {
                                            _loc_20 = _loc_21;
                                            _loc_33 = _loc_37;
                                            _loc_25 = 2;
                                        }
                                    }
                                    _loc_32 = _loc_32.next;
                                }
                                if (_loc_20 < _loc_8)
                                {
                                    if (_loc_25 == 1)
                                    {
                                        _loc_38 = _loc_30;
                                        _loc_39 = _loc_36;
                                        _loc_37 = _loc_31;
                                    }
                                    else
                                    {
                                        _loc_38 = _loc_36;
                                        _loc_39 = _loc_30;
                                        _loc_37 = _loc_33;
                                        _loc_29 = _loc_16;
                                        _loc_16 = _loc_17;
                                        _loc_17 = _loc_29;
                                        _loc_27 = !_loc_27;
                                    }
                                    _loc_40 = null;
                                    _loc_21 = 1000000000000000000000000000000;
                                    _loc_32 = _loc_39.edges.head;
                                    while (_loc_32 != null)
                                    {
                                        
                                        _loc_41 = _loc_32.elt;
                                        _loc_22 = _loc_37.gnormx * _loc_41.gnormx + _loc_37.gnormy * _loc_41.gnormy;
                                        if (_loc_22 < _loc_21)
                                        {
                                            _loc_21 = _loc_22;
                                            _loc_40 = _loc_41;
                                        }
                                        _loc_32 = _loc_32.next;
                                    }
                                    if (_loc_27)
                                    {
                                        _loc_7.x = -_loc_37.gnormx;
                                        _loc_7.y = -_loc_37.gnormy;
                                    }
                                    else
                                    {
                                        _loc_7.x = _loc_37.gnormx;
                                        _loc_7.y = _loc_37.gnormy;
                                    }
                                    if (_loc_20 >= 0)
                                    {
                                        _loc_29 = _loc_37.gp0;
                                        _loc_34 = _loc_37.gp1;
                                        _loc_42 = _loc_40.gp0;
                                        _loc_43 = _loc_40.gp1;
                                        _loc_22 = 0;
                                        _loc_23 = 0;
                                        _loc_24 = 0;
                                        _loc_26 = 0;
                                        _loc_22 = _loc_34.x - _loc_29.x;
                                        _loc_23 = _loc_34.y - _loc_29.y;
                                        _loc_24 = _loc_43.x - _loc_42.x;
                                        _loc_26 = _loc_43.y - _loc_42.y;
                                        _loc_35 = 1 / (_loc_22 * _loc_22 + _loc_23 * _loc_23);
                                        _loc_44 = 1 / (_loc_24 * _loc_24 + _loc_26 * _loc_26);
                                        _loc_45 = (-(_loc_22 * (_loc_29.x - _loc_42.x) + _loc_23 * (_loc_29.y - _loc_42.y))) * _loc_35;
                                        _loc_46 = (-(_loc_22 * (_loc_29.x - _loc_43.x) + _loc_23 * (_loc_29.y - _loc_43.y))) * _loc_35;
                                        _loc_47 = (-(_loc_24 * (_loc_42.x - _loc_29.x) + _loc_26 * (_loc_42.y - _loc_29.y))) * _loc_44;
                                        _loc_48 = (-(_loc_24 * (_loc_42.x - _loc_34.x) + _loc_26 * (_loc_42.y - _loc_34.y))) * _loc_44;
                                        if (_loc_45 < 0)
                                        {
                                            _loc_45 = 0;
                                        }
                                        else if (_loc_45 > 1)
                                        {
                                            _loc_45 = 1;
                                        }
                                        if (_loc_46 < 0)
                                        {
                                            _loc_46 = 0;
                                        }
                                        else if (_loc_46 > 1)
                                        {
                                            _loc_46 = 1;
                                        }
                                        if (_loc_47 < 0)
                                        {
                                            _loc_47 = 0;
                                        }
                                        else if (_loc_47 > 1)
                                        {
                                            _loc_47 = 1;
                                        }
                                        if (_loc_48 < 0)
                                        {
                                            _loc_48 = 0;
                                        }
                                        else if (_loc_48 > 1)
                                        {
                                            _loc_48 = 1;
                                        }
                                        _loc_49 = 0;
                                        _loc_50 = 0;
                                        _loc_51 = _loc_45;
                                        _loc_49 = _loc_29.x + _loc_22 * _loc_51;
                                        _loc_50 = _loc_29.y + _loc_23 * _loc_51;
                                        _loc_51 = 0;
                                        _loc_52 = 0;
                                        _loc_53 = _loc_46;
                                        _loc_51 = _loc_29.x + _loc_22 * _loc_53;
                                        _loc_52 = _loc_29.y + _loc_23 * _loc_53;
                                        _loc_53 = 0;
                                        _loc_54 = 0;
                                        _loc_55 = _loc_47;
                                        _loc_53 = _loc_42.x + _loc_24 * _loc_55;
                                        _loc_54 = _loc_42.y + _loc_26 * _loc_55;
                                        _loc_55 = 0;
                                        _loc_56 = 0;
                                        _loc_57 = _loc_48;
                                        _loc_55 = _loc_42.x + _loc_24 * _loc_57;
                                        _loc_56 = _loc_42.y + _loc_26 * _loc_57;
                                        _loc_58 = 0;
                                        _loc_59 = 0;
                                        _loc_58 = _loc_49 - _loc_42.x;
                                        _loc_59 = _loc_50 - _loc_42.y;
                                        _loc_57 = _loc_58 * _loc_58 + _loc_59 * _loc_59;
                                        _loc_59 = 0;
                                        _loc_60 = 0;
                                        _loc_59 = _loc_51 - _loc_43.x;
                                        _loc_60 = _loc_52 - _loc_43.y;
                                        _loc_58 = _loc_59 * _loc_59 + _loc_60 * _loc_60;
                                        _loc_60 = 0;
                                        _loc_61 = 0;
                                        _loc_60 = _loc_53 - _loc_29.x;
                                        _loc_61 = _loc_54 - _loc_29.y;
                                        _loc_59 = _loc_60 * _loc_60 + _loc_61 * _loc_61;
                                        _loc_61 = 0;
                                        _loc_62 = 0;
                                        _loc_61 = _loc_55 - _loc_34.x;
                                        _loc_62 = _loc_56 - _loc_34.y;
                                        _loc_60 = _loc_61 * _loc_61 + _loc_62 * _loc_62;
                                        _loc_61 = 0;
                                        _loc_62 = 0;
                                        _loc_63 = null;
                                        if (_loc_57 < _loc_58)
                                        {
                                            _loc_61 = _loc_49;
                                            _loc_62 = _loc_50;
                                            _loc_63 = _loc_42;
                                        }
                                        else
                                        {
                                            _loc_61 = _loc_51;
                                            _loc_62 = _loc_52;
                                            _loc_63 = _loc_43;
                                            _loc_57 = _loc_58;
                                        }
                                        _loc_64 = 0;
                                        _loc_65 = 0;
                                        _loc_66 = null;
                                        if (_loc_59 < _loc_60)
                                        {
                                            _loc_64 = _loc_53;
                                            _loc_65 = _loc_54;
                                            _loc_66 = _loc_29;
                                        }
                                        else
                                        {
                                            _loc_64 = _loc_55;
                                            _loc_65 = _loc_56;
                                            _loc_66 = _loc_34;
                                            _loc_59 = _loc_60;
                                        }
                                        if (_loc_57 < _loc_59)
                                        {
                                            _loc_16.x = _loc_61;
                                            _loc_16.y = _loc_62;
                                            _loc_17.x = _loc_63.x;
                                            _loc_17.y = _loc_63.y;
                                            _loc_20 = Math.sqrt(_loc_57);
                                        }
                                        else
                                        {
                                            _loc_17.x = _loc_64;
                                            _loc_17.y = _loc_65;
                                            _loc_16.x = _loc_66.x;
                                            _loc_16.y = _loc_66.y;
                                            _loc_20 = Math.sqrt(_loc_59);
                                        }
                                        if (_loc_20 != 0)
                                        {
                                            _loc_7.x = _loc_17.x - _loc_16.x;
                                            _loc_7.y = _loc_17.y - _loc_16.y;
                                            _loc_67 = 1 / _loc_20;
                                            _loc_7.x = _loc_7.x * _loc_67;
                                            _loc_7.y = _loc_7.y * _loc_67;
                                            if (_loc_27)
                                            {
                                                _loc_7.x = -_loc_7.x;
                                                _loc_7.y = -_loc_7.y;
                                            }
                                        }
                                        _loc_13 = _loc_20;
                                    }
                                    else
                                    {
                                        _loc_22 = 0;
                                        _loc_23 = 0;
                                        _loc_22 = _loc_40.gp0.x;
                                        _loc_23 = _loc_40.gp0.y;
                                        _loc_24 = 0;
                                        _loc_26 = 0;
                                        _loc_24 = _loc_40.gp1.x;
                                        _loc_26 = _loc_40.gp1.y;
                                        _loc_35 = 0;
                                        _loc_44 = 0;
                                        _loc_35 = _loc_24 - _loc_22;
                                        _loc_44 = _loc_26 - _loc_23;
                                        _loc_45 = _loc_37.gnormy * _loc_22 - _loc_37.gnormx * _loc_23;
                                        _loc_46 = _loc_37.gnormy * _loc_24 - _loc_37.gnormx * _loc_26;
                                        _loc_47 = 1 / (_loc_46 - _loc_45);
                                        _loc_48 = (-_loc_37.tp1 - _loc_45) * _loc_47;
                                        if (_loc_48 > Config.epsilon)
                                        {
                                            _loc_49 = _loc_48;
                                            _loc_22 = _loc_22 + _loc_35 * _loc_49;
                                            _loc_23 = _loc_23 + _loc_44 * _loc_49;
                                        }
                                        _loc_49 = (-_loc_37.tp0 - _loc_46) * _loc_47;
                                        if (_loc_49 < -Config.epsilon)
                                        {
                                            _loc_50 = _loc_49;
                                            _loc_24 = _loc_24 + _loc_35 * _loc_50;
                                            _loc_26 = _loc_26 + _loc_44 * _loc_50;
                                        }
                                        _loc_50 = _loc_22 * _loc_37.gnormx + _loc_23 * _loc_37.gnormy - _loc_37.gprojection;
                                        _loc_51 = _loc_24 * _loc_37.gnormx + _loc_26 * _loc_37.gnormy - _loc_37.gprojection;
                                        if (_loc_50 < _loc_51)
                                        {
                                            _loc_17.x = _loc_22;
                                            _loc_17.y = _loc_23;
                                            _loc_52 = -_loc_50;
                                            _loc_16.x = _loc_17.x + _loc_37.gnormx * _loc_52;
                                            _loc_16.y = _loc_17.y + _loc_37.gnormy * _loc_52;
                                            _loc_13 = _loc_50;
                                        }
                                        else
                                        {
                                            _loc_17.x = _loc_24;
                                            _loc_17.y = _loc_26;
                                            _loc_52 = -_loc_51;
                                            _loc_16.x = _loc_17.x + _loc_37.gnormx * _loc_52;
                                            _loc_16.y = _loc_17.y + _loc_37.gnormy * _loc_52;
                                            _loc_13 = _loc_51;
                                        }
                                    }
                                }
                                else
                                {
                                    _loc_13 = _loc_8;
                                }
                            }
                            else
                            {
                                _loc_13 = _loc_8;
                            }
                        }
                    }
                    if (_loc_13 < _loc_8)
                    {
                        _loc_8 = _loc_13;
                        param3.x = _loc_5.x;
                        param3.y = _loc_5.y;
                        param4.x = _loc_6.x;
                        param4.y = _loc_6.y;
                    }
                    _loc_11 = _loc_11.next;
                }
                _loc_9 = _loc_9.next;
            }
            _loc_16 = _loc_5;
            if (_loc_16.outer != null)
            {
                _loc_16.outer.zpp_inner = null;
                _loc_16.outer = null;
            }
            _loc_16._isimmutable = null;
            _loc_16._validate = null;
            _loc_16._invalidate = null;
            _loc_16.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_16;
            _loc_16 = _loc_6;
            if (_loc_16.outer != null)
            {
                _loc_16.outer.zpp_inner = null;
                _loc_16.outer = null;
            }
            _loc_16._isimmutable = null;
            _loc_16._validate = null;
            _loc_16._invalidate = null;
            _loc_16.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_16;
            _loc_16 = _loc_7;
            if (_loc_16.outer != null)
            {
                _loc_16.outer.zpp_inner = null;
                _loc_16.outer = null;
            }
            _loc_16._isimmutable = null;
            _loc_16._validate = null;
            _loc_16._invalidate = null;
            _loc_16.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_16;
            return _loc_8;
        }// end function

        public static function distance(param1:ZPP_Shape, param2:ZPP_Shape, param3:ZPP_Vec2, param4:ZPP_Vec2, param5:ZPP_Vec2, param6:Number = 1e+100) : Number
        {
            var _loc_7:* = null as ZPP_Circle;
            var _loc_8:* = null as ZPP_Circle;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = 0;
            var _loc_15:* = NaN;
            var _loc_16:* = false;
            var _loc_17:* = null as ZPP_Shape;
            var _loc_18:* = null as ZPP_Vec2;
            var _loc_19:* = null as ZPP_Polygon;
            var _loc_20:* = null as ZPP_Edge;
            var _loc_21:* = null as ZNPNode_ZPP_Edge;
            var _loc_22:* = null as ZPP_Edge;
            var _loc_23:* = null as ZPP_Vec2;
            var _loc_24:* = NaN;
            var _loc_25:* = null as ZPP_Polygon;
            var _loc_26:* = null as ZPP_Edge;
            var _loc_27:* = null as ZPP_Polygon;
            var _loc_28:* = null as ZPP_Polygon;
            var _loc_29:* = null as ZPP_Edge;
            var _loc_30:* = null as ZPP_Edge;
            var _loc_31:* = null as ZPP_Vec2;
            var _loc_32:* = null as ZPP_Vec2;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
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
            var _loc_52:* = null as ZPP_Vec2;
            var _loc_53:* = NaN;
            var _loc_54:* = NaN;
            var _loc_55:* = null as ZPP_Vec2;
            var _loc_56:* = NaN;
            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
            }
            if (param2.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
                _loc_7 = param1.circle;
                _loc_8 = param2.circle;
                _loc_10 = 0;
                _loc_11 = 0;
                _loc_10 = _loc_8.worldCOMx - _loc_7.worldCOMx;
                _loc_11 = _loc_8.worldCOMy - _loc_7.worldCOMy;
                _loc_13 = _loc_10 * _loc_10 + _loc_11 * _loc_11;
                if (_loc_13 == 0)
                {
                    _loc_12 = 0;
                }
                else
                {
                    _loc_14 = 1597463007 - (0 >> 1);
                    _loc_15 = 0;
                    _loc_12 = 0 / (_loc_15 * (1.5 - 0.5 * _loc_13 * _loc_15 * _loc_15));
                }
                _loc_9 = _loc_12 - (_loc_7.radius + _loc_8.radius);
                if (_loc_9 < param6)
                {
                    if (_loc_12 == 0)
                    {
                        _loc_10 = 1;
                        _loc_11 = 0;
                    }
                    else
                    {
                        _loc_13 = 1 / _loc_12;
                        _loc_10 = _loc_10 * _loc_13;
                        _loc_11 = _loc_11 * _loc_13;
                    }
                    _loc_13 = _loc_7.radius;
                    param3.x = _loc_7.worldCOMx + _loc_10 * _loc_13;
                    param3.y = _loc_7.worldCOMy + _loc_11 * _loc_13;
                    _loc_13 = -_loc_8.radius;
                    param4.x = _loc_8.worldCOMx + _loc_10 * _loc_13;
                    param4.y = _loc_8.worldCOMy + _loc_11 * _loc_13;
                    param5.x = _loc_10;
                    param5.y = _loc_11;
                }
                return _loc_9;
            }
            else
            {
                _loc_16 = false;
                if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                }
                if (param2.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_17 = param1;
                    param1 = param2;
                    param2 = _loc_17;
                    _loc_18 = param3;
                    param3 = param4;
                    param4 = _loc_18;
                    _loc_16 = true;
                }
                if (param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                }
                if (param2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    _loc_19 = param1.polygon;
                    _loc_7 = param2.circle;
                    _loc_9 = -1000000000000000000000000000000;
                    _loc_20 = null;
                    _loc_21 = _loc_19.edges.head;
                    while (_loc_21 != null)
                    {
                        
                        _loc_22 = _loc_21.elt;
                        _loc_10 = _loc_22.gnormx * _loc_7.worldCOMx + _loc_22.gnormy * _loc_7.worldCOMy - _loc_22.gprojection - _loc_7.radius;
                        if (_loc_10 > param6)
                        {
                            _loc_9 = _loc_10;
                            break;
                        }
                        if (_loc_10 > 0)
                        {
                            if (_loc_10 > _loc_9)
                            {
                                _loc_9 = _loc_10;
                                _loc_20 = _loc_22;
                            }
                        }
                        else
                        {
                            if (_loc_9 < 0)
                            {
                            }
                            if (_loc_10 > _loc_9)
                            {
                                _loc_9 = _loc_10;
                                _loc_20 = _loc_22;
                            }
                        }
                        _loc_21 = _loc_21.next;
                    }
                    if (_loc_9 < param6)
                    {
                        _loc_18 = _loc_20.gp0;
                        _loc_23 = _loc_20.gp1;
                        _loc_10 = _loc_7.worldCOMy * _loc_20.gnormx - _loc_7.worldCOMx * _loc_20.gnormy;
                        if (_loc_10 <= _loc_18.y * _loc_20.gnormx - _loc_18.x * _loc_20.gnormy)
                        {
                            _loc_11 = 0;
                            _loc_12 = 0;
                            _loc_11 = _loc_7.worldCOMx - _loc_18.x;
                            _loc_12 = _loc_7.worldCOMy - _loc_18.y;
                            _loc_15 = _loc_11 * _loc_11 + _loc_12 * _loc_12;
                            if (_loc_15 == 0)
                            {
                                _loc_13 = 0;
                            }
                            else
                            {
                                _loc_14 = 1597463007 - (0 >> 1);
                                _loc_24 = 0;
                                _loc_13 = 0 / (_loc_24 * (1.5 - 0.5 * _loc_15 * _loc_24 * _loc_24));
                            }
                            _loc_9 = _loc_13 - _loc_7.radius;
                            if (_loc_9 < param6)
                            {
                                if (_loc_13 == 0)
                                {
                                    _loc_11 = 1;
                                    _loc_12 = 0;
                                }
                                else
                                {
                                    _loc_15 = 1 / _loc_13;
                                    _loc_11 = _loc_11 * _loc_15;
                                    _loc_12 = _loc_12 * _loc_15;
                                }
                                _loc_14 = 0;
                                param3.x = _loc_18.x + _loc_11 * _loc_14;
                                param3.y = _loc_18.y + _loc_12 * _loc_14;
                                _loc_15 = -_loc_7.radius;
                                param4.x = _loc_7.worldCOMx + _loc_11 * _loc_15;
                                param4.y = _loc_7.worldCOMy + _loc_12 * _loc_15;
                                param5.x = _loc_11;
                                param5.y = _loc_12;
                            }
                        }
                        else if (_loc_10 >= _loc_23.y * _loc_20.gnormx - _loc_23.x * _loc_20.gnormy)
                        {
                            _loc_11 = 0;
                            _loc_12 = 0;
                            _loc_11 = _loc_7.worldCOMx - _loc_23.x;
                            _loc_12 = _loc_7.worldCOMy - _loc_23.y;
                            _loc_15 = _loc_11 * _loc_11 + _loc_12 * _loc_12;
                            if (_loc_15 == 0)
                            {
                                _loc_13 = 0;
                            }
                            else
                            {
                                _loc_14 = 1597463007 - (0 >> 1);
                                _loc_24 = 0;
                                _loc_13 = 0 / (_loc_24 * (1.5 - 0.5 * _loc_15 * _loc_24 * _loc_24));
                            }
                            _loc_9 = _loc_13 - _loc_7.radius;
                            if (_loc_9 < param6)
                            {
                                if (_loc_13 == 0)
                                {
                                    _loc_11 = 1;
                                    _loc_12 = 0;
                                }
                                else
                                {
                                    _loc_15 = 1 / _loc_13;
                                    _loc_11 = _loc_11 * _loc_15;
                                    _loc_12 = _loc_12 * _loc_15;
                                }
                                _loc_14 = 0;
                                param3.x = _loc_23.x + _loc_11 * _loc_14;
                                param3.y = _loc_23.y + _loc_12 * _loc_14;
                                _loc_15 = -_loc_7.radius;
                                param4.x = _loc_7.worldCOMx + _loc_11 * _loc_15;
                                param4.y = _loc_7.worldCOMy + _loc_12 * _loc_15;
                                param5.x = _loc_11;
                                param5.y = _loc_12;
                            }
                        }
                        else
                        {
                            _loc_11 = -_loc_7.radius;
                            param4.x = _loc_7.worldCOMx + _loc_20.gnormx * _loc_11;
                            param4.y = _loc_7.worldCOMy + _loc_20.gnormy * _loc_11;
                            _loc_11 = -_loc_9;
                            param3.x = param4.x + _loc_20.gnormx * _loc_11;
                            param3.y = param4.y + _loc_20.gnormy * _loc_11;
                            param5.x = _loc_20.gnormx;
                            param5.y = _loc_20.gnormy;
                        }
                    }
                    if (_loc_16)
                    {
                        param5.x = -param5.x;
                        param5.y = -param5.y;
                    }
                    return _loc_9;
                }
                else
                {
                    _loc_19 = param1.polygon;
                    _loc_25 = param2.polygon;
                    _loc_9 = -1000000000000000000000000000000;
                    _loc_20 = null;
                    _loc_22 = null;
                    _loc_14 = 0;
                    _loc_21 = _loc_19.edges.head;
                    while (_loc_21 != null)
                    {
                        
                        _loc_26 = _loc_21.elt;
                        _loc_10 = 1000000000000000000000000000000;
                        _loc_18 = _loc_25.gverts.next;
                        while (_loc_18 != null)
                        {
                            
                            _loc_23 = _loc_18;
                            _loc_11 = _loc_26.gnormx * _loc_23.x + _loc_26.gnormy * _loc_23.y;
                            if (_loc_11 < _loc_10)
                            {
                                _loc_10 = _loc_11;
                            }
                            _loc_18 = _loc_18.next;
                        }
                        _loc_10 = _loc_10 - _loc_26.gprojection;
                        if (_loc_10 > param6)
                        {
                            _loc_9 = _loc_10;
                            break;
                        }
                        if (_loc_10 > 0)
                        {
                            if (_loc_10 > _loc_9)
                            {
                                _loc_9 = _loc_10;
                                _loc_20 = _loc_26;
                                _loc_14 = 1;
                            }
                        }
                        else
                        {
                            if (_loc_9 < 0)
                            {
                            }
                            if (_loc_10 > _loc_9)
                            {
                                _loc_9 = _loc_10;
                                _loc_20 = _loc_26;
                                _loc_14 = 1;
                            }
                        }
                        _loc_21 = _loc_21.next;
                    }
                    if (_loc_9 < param6)
                    {
                        _loc_21 = _loc_25.edges.head;
                        while (_loc_21 != null)
                        {
                            
                            _loc_26 = _loc_21.elt;
                            _loc_10 = 1000000000000000000000000000000;
                            _loc_18 = _loc_19.gverts.next;
                            while (_loc_18 != null)
                            {
                                
                                _loc_23 = _loc_18;
                                _loc_11 = _loc_26.gnormx * _loc_23.x + _loc_26.gnormy * _loc_23.y;
                                if (_loc_11 < _loc_10)
                                {
                                    _loc_10 = _loc_11;
                                }
                                _loc_18 = _loc_18.next;
                            }
                            _loc_10 = _loc_10 - _loc_26.gprojection;
                            if (_loc_10 > param6)
                            {
                                _loc_9 = _loc_10;
                                break;
                            }
                            if (_loc_10 > 0)
                            {
                                if (_loc_10 > _loc_9)
                                {
                                    _loc_9 = _loc_10;
                                    _loc_22 = _loc_26;
                                    _loc_14 = 2;
                                }
                            }
                            else
                            {
                                if (_loc_9 < 0)
                                {
                                }
                                if (_loc_10 > _loc_9)
                                {
                                    _loc_9 = _loc_10;
                                    _loc_22 = _loc_26;
                                    _loc_14 = 2;
                                }
                            }
                            _loc_21 = _loc_21.next;
                        }
                        if (_loc_9 < param6)
                        {
                            if (_loc_14 == 1)
                            {
                                _loc_27 = _loc_19;
                                _loc_28 = _loc_25;
                                _loc_26 = _loc_20;
                            }
                            else
                            {
                                _loc_27 = _loc_25;
                                _loc_28 = _loc_19;
                                _loc_26 = _loc_22;
                                _loc_18 = param3;
                                param3 = param4;
                                param4 = _loc_18;
                                _loc_16 = !_loc_16;
                            }
                            _loc_29 = null;
                            _loc_10 = 1000000000000000000000000000000;
                            _loc_21 = _loc_28.edges.head;
                            while (_loc_21 != null)
                            {
                                
                                _loc_30 = _loc_21.elt;
                                _loc_11 = _loc_26.gnormx * _loc_30.gnormx + _loc_26.gnormy * _loc_30.gnormy;
                                if (_loc_11 < _loc_10)
                                {
                                    _loc_10 = _loc_11;
                                    _loc_29 = _loc_30;
                                }
                                _loc_21 = _loc_21.next;
                            }
                            if (_loc_16)
                            {
                                param5.x = -_loc_26.gnormx;
                                param5.y = -_loc_26.gnormy;
                            }
                            else
                            {
                                param5.x = _loc_26.gnormx;
                                param5.y = _loc_26.gnormy;
                            }
                            if (_loc_9 >= 0)
                            {
                                _loc_18 = _loc_26.gp0;
                                _loc_23 = _loc_26.gp1;
                                _loc_31 = _loc_29.gp0;
                                _loc_32 = _loc_29.gp1;
                                _loc_11 = 0;
                                _loc_12 = 0;
                                _loc_13 = 0;
                                _loc_15 = 0;
                                _loc_11 = _loc_23.x - _loc_18.x;
                                _loc_12 = _loc_23.y - _loc_18.y;
                                _loc_13 = _loc_32.x - _loc_31.x;
                                _loc_15 = _loc_32.y - _loc_31.y;
                                _loc_24 = 1 / (_loc_11 * _loc_11 + _loc_12 * _loc_12);
                                _loc_33 = 1 / (_loc_13 * _loc_13 + _loc_15 * _loc_15);
                                _loc_34 = (-(_loc_11 * (_loc_18.x - _loc_31.x) + _loc_12 * (_loc_18.y - _loc_31.y))) * _loc_24;
                                _loc_35 = (-(_loc_11 * (_loc_18.x - _loc_32.x) + _loc_12 * (_loc_18.y - _loc_32.y))) * _loc_24;
                                _loc_36 = (-(_loc_13 * (_loc_31.x - _loc_18.x) + _loc_15 * (_loc_31.y - _loc_18.y))) * _loc_33;
                                _loc_37 = (-(_loc_13 * (_loc_31.x - _loc_23.x) + _loc_15 * (_loc_31.y - _loc_23.y))) * _loc_33;
                                if (_loc_34 < 0)
                                {
                                    _loc_34 = 0;
                                }
                                else if (_loc_34 > 1)
                                {
                                    _loc_34 = 1;
                                }
                                if (_loc_35 < 0)
                                {
                                    _loc_35 = 0;
                                }
                                else if (_loc_35 > 1)
                                {
                                    _loc_35 = 1;
                                }
                                if (_loc_36 < 0)
                                {
                                    _loc_36 = 0;
                                }
                                else if (_loc_36 > 1)
                                {
                                    _loc_36 = 1;
                                }
                                if (_loc_37 < 0)
                                {
                                    _loc_37 = 0;
                                }
                                else if (_loc_37 > 1)
                                {
                                    _loc_37 = 1;
                                }
                                _loc_38 = 0;
                                _loc_39 = 0;
                                _loc_40 = _loc_34;
                                _loc_38 = _loc_18.x + _loc_11 * _loc_40;
                                _loc_39 = _loc_18.y + _loc_12 * _loc_40;
                                _loc_40 = 0;
                                _loc_41 = 0;
                                _loc_42 = _loc_35;
                                _loc_40 = _loc_18.x + _loc_11 * _loc_42;
                                _loc_41 = _loc_18.y + _loc_12 * _loc_42;
                                _loc_42 = 0;
                                _loc_43 = 0;
                                _loc_44 = _loc_36;
                                _loc_42 = _loc_31.x + _loc_13 * _loc_44;
                                _loc_43 = _loc_31.y + _loc_15 * _loc_44;
                                _loc_44 = 0;
                                _loc_45 = 0;
                                _loc_46 = _loc_37;
                                _loc_44 = _loc_31.x + _loc_13 * _loc_46;
                                _loc_45 = _loc_31.y + _loc_15 * _loc_46;
                                _loc_47 = 0;
                                _loc_48 = 0;
                                _loc_47 = _loc_38 - _loc_31.x;
                                _loc_48 = _loc_39 - _loc_31.y;
                                _loc_46 = _loc_47 * _loc_47 + _loc_48 * _loc_48;
                                _loc_48 = 0;
                                _loc_49 = 0;
                                _loc_48 = _loc_40 - _loc_32.x;
                                _loc_49 = _loc_41 - _loc_32.y;
                                _loc_47 = _loc_48 * _loc_48 + _loc_49 * _loc_49;
                                _loc_49 = 0;
                                _loc_50 = 0;
                                _loc_49 = _loc_42 - _loc_18.x;
                                _loc_50 = _loc_43 - _loc_18.y;
                                _loc_48 = _loc_49 * _loc_49 + _loc_50 * _loc_50;
                                _loc_50 = 0;
                                _loc_51 = 0;
                                _loc_50 = _loc_44 - _loc_23.x;
                                _loc_51 = _loc_45 - _loc_23.y;
                                _loc_49 = _loc_50 * _loc_50 + _loc_51 * _loc_51;
                                _loc_50 = 0;
                                _loc_51 = 0;
                                _loc_52 = null;
                                if (_loc_46 < _loc_47)
                                {
                                    _loc_50 = _loc_38;
                                    _loc_51 = _loc_39;
                                    _loc_52 = _loc_31;
                                }
                                else
                                {
                                    _loc_50 = _loc_40;
                                    _loc_51 = _loc_41;
                                    _loc_52 = _loc_32;
                                    _loc_46 = _loc_47;
                                }
                                _loc_53 = 0;
                                _loc_54 = 0;
                                _loc_55 = null;
                                if (_loc_48 < _loc_49)
                                {
                                    _loc_53 = _loc_42;
                                    _loc_54 = _loc_43;
                                    _loc_55 = _loc_18;
                                }
                                else
                                {
                                    _loc_53 = _loc_44;
                                    _loc_54 = _loc_45;
                                    _loc_55 = _loc_23;
                                    _loc_48 = _loc_49;
                                }
                                if (_loc_46 < _loc_48)
                                {
                                    param3.x = _loc_50;
                                    param3.y = _loc_51;
                                    param4.x = _loc_52.x;
                                    param4.y = _loc_52.y;
                                    _loc_9 = Math.sqrt(_loc_46);
                                }
                                else
                                {
                                    param4.x = _loc_53;
                                    param4.y = _loc_54;
                                    param3.x = _loc_55.x;
                                    param3.y = _loc_55.y;
                                    _loc_9 = Math.sqrt(_loc_48);
                                }
                                if (_loc_9 != 0)
                                {
                                    param5.x = param4.x - param3.x;
                                    param5.y = param4.y - param3.y;
                                    _loc_56 = 1 / _loc_9;
                                    param5.x = param5.x * _loc_56;
                                    param5.y = param5.y * _loc_56;
                                    if (_loc_16)
                                    {
                                        param5.x = -param5.x;
                                        param5.y = -param5.y;
                                    }
                                }
                                return _loc_9;
                            }
                            else
                            {
                                _loc_11 = 0;
                                _loc_12 = 0;
                                _loc_11 = _loc_29.gp0.x;
                                _loc_12 = _loc_29.gp0.y;
                                _loc_13 = 0;
                                _loc_15 = 0;
                                _loc_13 = _loc_29.gp1.x;
                                _loc_15 = _loc_29.gp1.y;
                                _loc_24 = 0;
                                _loc_33 = 0;
                                _loc_24 = _loc_13 - _loc_11;
                                _loc_33 = _loc_15 - _loc_12;
                                _loc_34 = _loc_26.gnormy * _loc_11 - _loc_26.gnormx * _loc_12;
                                _loc_35 = _loc_26.gnormy * _loc_13 - _loc_26.gnormx * _loc_15;
                                _loc_36 = 1 / (_loc_35 - _loc_34);
                                _loc_37 = (-_loc_26.tp1 - _loc_34) * _loc_36;
                                if (_loc_37 > Config.epsilon)
                                {
                                    _loc_38 = _loc_37;
                                    _loc_11 = _loc_11 + _loc_24 * _loc_38;
                                    _loc_12 = _loc_12 + _loc_33 * _loc_38;
                                }
                                _loc_38 = (-_loc_26.tp0 - _loc_35) * _loc_36;
                                if (_loc_38 < -Config.epsilon)
                                {
                                    _loc_39 = _loc_38;
                                    _loc_13 = _loc_13 + _loc_24 * _loc_39;
                                    _loc_15 = _loc_15 + _loc_33 * _loc_39;
                                }
                                _loc_39 = _loc_11 * _loc_26.gnormx + _loc_12 * _loc_26.gnormy - _loc_26.gprojection;
                                _loc_40 = _loc_13 * _loc_26.gnormx + _loc_15 * _loc_26.gnormy - _loc_26.gprojection;
                                if (_loc_39 < _loc_40)
                                {
                                    param4.x = _loc_11;
                                    param4.y = _loc_12;
                                    _loc_41 = -_loc_39;
                                    param3.x = param4.x + _loc_26.gnormx * _loc_41;
                                    param3.y = param4.y + _loc_26.gnormy * _loc_41;
                                    return _loc_39;
                                }
                                else
                                {
                                    param4.x = _loc_13;
                                    param4.y = _loc_15;
                                    _loc_41 = -_loc_40;
                                    param3.x = param4.x + _loc_26.gnormx * _loc_41;
                                    param3.y = param4.y + _loc_26.gnormy * _loc_41;
                                    return _loc_40;
                                }
                            }
                        }
                        else
                        {
                            return param6;
                        }
                    }
                    else
                    {
                        return param6;
                    }
                }
            }
        }// end function

    }
}
