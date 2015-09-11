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

    public class ZPP_Polygon extends ZPP_Shape
    {
        public var zip_valid:Boolean;
        public var zip_sanitation:Boolean;
        public var zip_lverts:Boolean;
        public var zip_laxi:Boolean;
        public var zip_gverts:Boolean;
        public var zip_gaxi:Boolean;
        public var wrap_lverts:Vec2List;
        public var wrap_gverts:Vec2List;
        public var wrap_edges:EdgeList;
        public var validation:ValidationResult;
        public var reverse_flag:Boolean;
        public var outer_zn:Polygon;
        public var lverts:ZPP_Vec2;
        public var gverts:ZPP_Vec2;
        public var edges:ZNPList_ZPP_Edge;
        public var edgeCnt:int;

        public function ZPP_Polygon() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zip_sanitation = false;
            zip_valid = false;
            zip_gaxi = false;
            zip_gverts = false;
            zip_laxi = false;
            zip_lverts = false;
            reverse_flag = false;
            edgeCnt = 0;
            wrap_edges = null;
            edges = null;
            wrap_gverts = null;
            gverts = null;
            wrap_lverts = null;
            lverts = null;
            outer_zn = null;
            super(ZPP_Flags.id_ShapeType_POLYGON);
            polygon = this;
            lverts = new ZPP_Vec2();
            gverts = new ZPP_Vec2();
            edges = new ZNPList_ZPP_Edge();
            edgeCnt = 0;
            return;
        }// end function

        public function validate_lverts() : void
        {
            if (zip_lverts)
            {
                zip_lverts = false;
                if (lverts.length > 2)
                {
                    validate_area_inertia();
                    if (area < 0)
                    {
                        reverse_vertices();
                        area = -area;
                    }
                }
            }
            return;
        }// end function

        public function validate_laxi() : void
        {
            var _loc_1:* = null as ZNPNode_ZPP_Edge;
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Edge;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            if (zip_laxi)
            {
                zip_laxi = false;
                validate_lverts();
                _loc_1 = edges.head;
                _loc_2 = lverts.next;
                _loc_3 = _loc_2;
                _loc_2 = _loc_2.next;
                while (_loc_2 != null)
                {
                    
                    _loc_4 = _loc_2;
                    _loc_5 = _loc_1.elt;
                    _loc_1 = _loc_1.next;
                    _loc_5.lp0 = _loc_3;
                    _loc_5.lp1 = _loc_4;
                    _loc_6 = 0;
                    _loc_7 = 0;
                    _loc_6 = _loc_3.x - _loc_4.x;
                    _loc_7 = _loc_3.y - _loc_4.y;
                    _loc_8 = Math.sqrt(_loc_6 * _loc_6 + _loc_7 * _loc_7);
                    _loc_5.length = _loc_8;
                    _loc_9 = 1 / _loc_8;
                    _loc_6 = _loc_6 * _loc_9;
                    _loc_7 = _loc_7 * _loc_9;
                    _loc_9 = _loc_6;
                    _loc_6 = -_loc_7;
                    _loc_7 = _loc_9;
                    _loc_5.lprojection = _loc_6 * _loc_3.x + _loc_7 * _loc_3.y;
                    _loc_5.lnormx = _loc_6;
                    _loc_5.lnormy = _loc_7;
                    if (_loc_5.wrap_lnorm != null)
                    {
                        _loc_5.wrap_lnorm.zpp_inner.x = _loc_6;
                        _loc_5.wrap_lnorm.zpp_inner.y = _loc_7;
                    }
                    _loc_3 = _loc_4;
                    _loc_2 = _loc_2.next;
                }
                _loc_4 = lverts.next;
                _loc_5 = _loc_1.elt;
                _loc_1 = _loc_1.next;
                _loc_5.lp0 = _loc_3;
                _loc_5.lp1 = _loc_4;
                _loc_6 = 0;
                _loc_7 = 0;
                _loc_6 = _loc_3.x - _loc_4.x;
                _loc_7 = _loc_3.y - _loc_4.y;
                _loc_8 = Math.sqrt(_loc_6 * _loc_6 + _loc_7 * _loc_7);
                _loc_5.length = _loc_8;
                _loc_9 = 1 / _loc_8;
                _loc_6 = _loc_6 * _loc_9;
                _loc_7 = _loc_7 * _loc_9;
                _loc_9 = _loc_6;
                _loc_6 = -_loc_7;
                _loc_7 = _loc_9;
                _loc_5.lprojection = _loc_6 * _loc_3.x + _loc_7 * _loc_3.y;
                _loc_5.lnormx = _loc_6;
                _loc_5.lnormy = _loc_7;
                if (_loc_5.wrap_lnorm != null)
                {
                    _loc_5.wrap_lnorm.zpp_inner.x = _loc_6;
                    _loc_5.wrap_lnorm.zpp_inner.y = _loc_7;
                }
            }
            return;
        }// end function

        public function validate_gverts() : void
        {
            var _loc_1:* = null as ZPP_Body;
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            if (zip_gverts)
            {
                if (body != null)
                {
                    zip_gverts = false;
                    validate_lverts();
                    _loc_1 = body;
                    if (_loc_1.zip_axis)
                    {
                        _loc_1.zip_axis = false;
                        _loc_1.axisx = Math.sin(_loc_1.rot);
                        _loc_1.axisy = Math.cos(_loc_1.rot);
                    }
                    _loc_2 = lverts.next;
                    _loc_3 = gverts.next;
                    while (_loc_3 != null)
                    {
                        
                        _loc_4 = _loc_3;
                        _loc_5 = _loc_2;
                        _loc_2 = _loc_2.next;
                        _loc_4.x = body.posx + (body.axisy * _loc_5.x - body.axisx * _loc_5.y);
                        _loc_4.y = body.posy + (_loc_5.x * body.axisx + _loc_5.y * body.axisy);
                        _loc_3 = _loc_3.next;
                    }
                }
            }
            return;
        }// end function

        public function validate_gaxi() : void
        {
            var _loc_1:* = null as ZPP_Body;
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZNPNode_ZPP_Edge;
            var _loc_7:* = null as ZPP_Edge;
            if (zip_gaxi)
            {
                if (body != null)
                {
                    zip_gaxi = false;
                    validate_laxi();
                    _loc_1 = body;
                    if (_loc_1.zip_axis)
                    {
                        _loc_1.zip_axis = false;
                        _loc_1.axisx = Math.sin(_loc_1.rot);
                        _loc_1.axisy = Math.cos(_loc_1.rot);
                    }
                    if (zip_gverts)
                    {
                        if (body != null)
                        {
                            zip_gverts = false;
                            validate_lverts();
                            _loc_1 = body;
                            if (_loc_1.zip_axis)
                            {
                                _loc_1.zip_axis = false;
                                _loc_1.axisx = Math.sin(_loc_1.rot);
                                _loc_1.axisy = Math.cos(_loc_1.rot);
                            }
                            _loc_2 = lverts.next;
                            _loc_3 = gverts.next;
                            while (_loc_3 != null)
                            {
                                
                                _loc_4 = _loc_3;
                                _loc_5 = _loc_2;
                                _loc_2 = _loc_2.next;
                                _loc_4.x = body.posx + (body.axisy * _loc_5.x - body.axisx * _loc_5.y);
                                _loc_4.y = body.posy + (_loc_5.x * body.axisx + _loc_5.y * body.axisy);
                                _loc_3 = _loc_3.next;
                            }
                        }
                    }
                    _loc_6 = edges.head;
                    _loc_2 = gverts.next;
                    _loc_3 = _loc_2;
                    _loc_2 = _loc_2.next;
                    while (_loc_2 != null)
                    {
                        
                        _loc_4 = _loc_2;
                        _loc_7 = _loc_6.elt;
                        _loc_6 = _loc_6.next;
                        _loc_7.gp0 = _loc_3;
                        _loc_7.gp1 = _loc_4;
                        _loc_7.gnormx = body.axisy * _loc_7.lnormx - body.axisx * _loc_7.lnormy;
                        _loc_7.gnormy = _loc_7.lnormx * body.axisx + _loc_7.lnormy * body.axisy;
                        _loc_7.gprojection = body.posx * _loc_7.gnormx + body.posy * _loc_7.gnormy + _loc_7.lprojection;
                        if (_loc_7.wrap_gnorm != null)
                        {
                            _loc_7.wrap_gnorm.zpp_inner.x = _loc_7.gnormx;
                            _loc_7.wrap_gnorm.zpp_inner.y = _loc_7.gnormy;
                        }
                        _loc_7.tp0 = _loc_7.gp0.y * _loc_7.gnormx - _loc_7.gp0.x * _loc_7.gnormy;
                        _loc_7.tp1 = _loc_7.gp1.y * _loc_7.gnormx - _loc_7.gp1.x * _loc_7.gnormy;
                        _loc_3 = _loc_4;
                        _loc_2 = _loc_2.next;
                    }
                    _loc_4 = gverts.next;
                    _loc_7 = _loc_6.elt;
                    _loc_6 = _loc_6.next;
                    _loc_7.gp0 = _loc_3;
                    _loc_7.gp1 = _loc_4;
                    _loc_7.gnormx = body.axisy * _loc_7.lnormx - body.axisx * _loc_7.lnormy;
                    _loc_7.gnormy = _loc_7.lnormx * body.axisx + _loc_7.lnormy * body.axisy;
                    _loc_7.gprojection = body.posx * _loc_7.gnormx + body.posy * _loc_7.gnormy + _loc_7.lprojection;
                    if (_loc_7.wrap_gnorm != null)
                    {
                        _loc_7.wrap_gnorm.zpp_inner.x = _loc_7.gnormx;
                        _loc_7.wrap_gnorm.zpp_inner.y = _loc_7.gnormy;
                    }
                    _loc_7.tp0 = _loc_7.gp0.y * _loc_7.gnormx - _loc_7.gp0.x * _loc_7.gnormy;
                    _loc_7.tp1 = _loc_7.gp1.y * _loc_7.gnormx - _loc_7.gp1.x * _loc_7.gnormy;
                }
            }
            return;
        }// end function

        public function valid() : ValidationResult
        {
            var _loc_1:* = null as ValidationResult;
            var _loc_2:* = false;
            var _loc_3:* = false;
            var _loc_4:* = false;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = null as ZPP_Vec2;
            var _loc_15:* = false;
            var _loc_16:* = false;
            var _loc_17:* = null as ZPP_Vec2;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            if (zip_valid)
            {
                zip_valid = false;
                if (zip_sanitation)
                {
                    zip_sanitation = false;
                    splice_collinear_real();
                }
                if (lverts.length < 3)
                {
                    if (ZPP_Flags.ValidationResult_DEGENERATE == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.ValidationResult_DEGENERATE = new ValidationResult();
                        ZPP_Flags.internal = false;
                    }
                    _loc_1 = ZPP_Flags.ValidationResult_DEGENERATE;
                    validation = _loc_1;
                    return _loc_1;
                }
                else
                {
                    validate_lverts();
                    validate_area_inertia();
                    if (area < Config.epsilon)
                    {
                        if (ZPP_Flags.ValidationResult_DEGENERATE == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.ValidationResult_DEGENERATE = new ValidationResult();
                            ZPP_Flags.internal = false;
                        }
                        _loc_1 = ZPP_Flags.ValidationResult_DEGENERATE;
                        validation = _loc_1;
                        return _loc_1;
                    }
                    else
                    {
                        _loc_2 = false;
                        _loc_3 = false;
                        _loc_4 = true;
                        _loc_5 = lverts.next;
                        _loc_6 = _loc_5;
                        _loc_5 = _loc_5.next;
                        _loc_7 = _loc_5;
                        _loc_5 = _loc_5.next;
                        while (_loc_5 != null)
                        {
                            
                            _loc_8 = _loc_5;
                            _loc_9 = 0;
                            _loc_10 = 0;
                            _loc_9 = _loc_8.x - _loc_7.x;
                            _loc_10 = _loc_8.y - _loc_7.y;
                            _loc_11 = 0;
                            _loc_12 = 0;
                            _loc_11 = _loc_7.x - _loc_6.x;
                            _loc_12 = _loc_7.y - _loc_6.y;
                            _loc_13 = _loc_12 * _loc_9 - _loc_11 * _loc_10;
                            if (_loc_13 > Config.epsilon)
                            {
                                _loc_3 = true;
                            }
                            else if (_loc_13 < -Config.epsilon)
                            {
                                _loc_2 = true;
                            }
                            if (_loc_3)
                            {
                            }
                            if (_loc_2)
                            {
                                _loc_4 = false;
                                break;
                            }
                            _loc_6 = _loc_7;
                            _loc_7 = _loc_8;
                            _loc_5 = _loc_5.next;
                        }
                        if (_loc_4)
                        {
                            _loc_5 = lverts.next;
                            _loc_8 = _loc_5;
                            do
                            {
                                
                                _loc_9 = 0;
                                _loc_10 = 0;
                                _loc_9 = _loc_8.x - _loc_7.x;
                                _loc_10 = _loc_8.y - _loc_7.y;
                                _loc_11 = 0;
                                _loc_12 = 0;
                                _loc_11 = _loc_7.x - _loc_6.x;
                                _loc_12 = _loc_7.y - _loc_6.y;
                                _loc_13 = _loc_12 * _loc_9 - _loc_11 * _loc_10;
                                if (_loc_13 > Config.epsilon)
                                {
                                    _loc_3 = true;
                                }
                                else if (_loc_13 < -Config.epsilon)
                                {
                                    _loc_2 = true;
                                }
                                if (_loc_3)
                                {
                                }
                                if (_loc_2)
                                {
                                    _loc_4 = false;
                                    break;
                                }
                            }while (false)
                            if (_loc_4)
                            {
                                _loc_6 = _loc_7;
                                _loc_7 = _loc_8;
                                _loc_5 = _loc_5.next;
                                _loc_14 = _loc_5;
                                do
                                {
                                    
                                    _loc_9 = 0;
                                    _loc_10 = 0;
                                    _loc_9 = _loc_14.x - _loc_7.x;
                                    _loc_10 = _loc_14.y - _loc_7.y;
                                    _loc_11 = 0;
                                    _loc_12 = 0;
                                    _loc_11 = _loc_7.x - _loc_6.x;
                                    _loc_12 = _loc_7.y - _loc_6.y;
                                    _loc_13 = _loc_12 * _loc_9 - _loc_11 * _loc_10;
                                    if (_loc_13 > Config.epsilon)
                                    {
                                        _loc_3 = true;
                                    }
                                    else if (_loc_13 < -Config.epsilon)
                                    {
                                        _loc_2 = true;
                                    }
                                    if (_loc_3)
                                    {
                                    }
                                    if (_loc_2)
                                    {
                                        break;
                                    }
                                }while (false)
                            }
                        }
                        if (_loc_3)
                        {
                        }
                        if (_loc_2)
                        {
                            if (ZPP_Flags.ValidationResult_CONCAVE == null)
                            {
                                ZPP_Flags.internal = true;
                                ZPP_Flags.ValidationResult_CONCAVE = new ValidationResult();
                                ZPP_Flags.internal = false;
                            }
                            _loc_1 = ZPP_Flags.ValidationResult_CONCAVE;
                            validation = _loc_1;
                            return _loc_1;
                        }
                        else
                        {
                            _loc_4 = true;
                            _loc_15 = true;
                            _loc_5 = lverts.next;
                            _loc_6 = _loc_5;
                            _loc_5 = _loc_5.next;
                            while (_loc_5 != null)
                            {
                                
                                _loc_7 = _loc_5;
                                if (!_loc_4)
                                {
                                    _loc_15 = false;
                                    break;
                                }
                                _loc_16 = true;
                                _loc_8 = lverts.next;
                                _loc_14 = _loc_8;
                                _loc_8 = _loc_8.next;
                                while (_loc_8 != null)
                                {
                                    
                                    _loc_17 = _loc_8;
                                    if (_loc_6 != _loc_14)
                                    {
                                    }
                                    if (_loc_6 != _loc_17)
                                    {
                                    }
                                    if (_loc_7 != _loc_14)
                                    {
                                    }
                                    if (_loc_7 == _loc_17)
                                    {
                                        _loc_14 = _loc_17;
                                        _loc_8 = _loc_8.next;
                                        continue;
                                    }
                                    _loc_9 = 0;
                                    _loc_10 = 0;
                                    _loc_9 = _loc_6.x - _loc_14.x;
                                    _loc_10 = _loc_6.y - _loc_14.y;
                                    _loc_11 = 0;
                                    _loc_12 = 0;
                                    _loc_11 = _loc_7.x - _loc_6.x;
                                    _loc_12 = _loc_7.y - _loc_6.y;
                                    _loc_13 = 0;
                                    _loc_18 = 0;
                                    _loc_13 = _loc_17.x - _loc_14.x;
                                    _loc_18 = _loc_17.y - _loc_14.y;
                                    _loc_19 = _loc_12 * _loc_13 - _loc_11 * _loc_18;
                                    if (_loc_19 * _loc_19 > Config.epsilon)
                                    {
                                        _loc_19 = 1 / _loc_19;
                                        _loc_20 = (_loc_18 * _loc_9 - _loc_13 * _loc_10) * _loc_19;
                                        if (_loc_20 > Config.epsilon)
                                        {
                                        }
                                        if (_loc_20 < 1 - Config.epsilon)
                                        {
                                            _loc_21 = (_loc_12 * _loc_9 - _loc_11 * _loc_10) * _loc_19;
                                            if (_loc_21 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_21 < 1 - Config.epsilon)
                                            {
                                                _loc_4 = false;
                                                _loc_16 = false;
                                                break;
                                            }
                                        }
                                    }
                                    _loc_14 = _loc_17;
                                    _loc_8 = _loc_8.next;
                                }
                                if (_loc_16)
                                {
                                    do
                                    {
                                        
                                        _loc_17 = lverts.next;
                                        if (_loc_6 != _loc_14)
                                        {
                                        }
                                        if (_loc_6 != _loc_17)
                                        {
                                        }
                                        if (_loc_7 != _loc_14)
                                        {
                                        }
                                        if (_loc_7 == _loc_17)
                                        {
                                            break;
                                        }
                                        _loc_9 = 0;
                                        _loc_10 = 0;
                                        _loc_9 = _loc_6.x - _loc_14.x;
                                        _loc_10 = _loc_6.y - _loc_14.y;
                                        _loc_11 = 0;
                                        _loc_12 = 0;
                                        _loc_11 = _loc_7.x - _loc_6.x;
                                        _loc_12 = _loc_7.y - _loc_6.y;
                                        _loc_13 = 0;
                                        _loc_18 = 0;
                                        _loc_13 = _loc_17.x - _loc_14.x;
                                        _loc_18 = _loc_17.y - _loc_14.y;
                                        _loc_19 = _loc_12 * _loc_13 - _loc_11 * _loc_18;
                                        if (_loc_19 * _loc_19 > Config.epsilon)
                                        {
                                            _loc_19 = 1 / _loc_19;
                                            _loc_20 = (_loc_18 * _loc_9 - _loc_13 * _loc_10) * _loc_19;
                                            if (_loc_20 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_20 < 1 - Config.epsilon)
                                            {
                                                _loc_21 = (_loc_12 * _loc_9 - _loc_11 * _loc_10) * _loc_19;
                                                if (_loc_21 > Config.epsilon)
                                                {
                                                }
                                                if (_loc_21 < 1 - Config.epsilon)
                                                {
                                                    _loc_4 = false;
                                                    break;
                                                }
                                            }
                                        }
                                    }while (false)
                                }
                                _loc_6 = _loc_7;
                                _loc_5 = _loc_5.next;
                            }
                            if (_loc_15)
                            {
                                do
                                {
                                    
                                    _loc_7 = lverts.next;
                                    if (!_loc_4)
                                    {
                                        break;
                                    }
                                    _loc_16 = true;
                                    _loc_8 = lverts.next;
                                    _loc_14 = _loc_8;
                                    _loc_8 = _loc_8.next;
                                    while (_loc_8 != null)
                                    {
                                        
                                        _loc_17 = _loc_8;
                                        if (_loc_6 != _loc_14)
                                        {
                                        }
                                        if (_loc_6 != _loc_17)
                                        {
                                        }
                                        if (_loc_7 != _loc_14)
                                        {
                                        }
                                        if (_loc_7 == _loc_17)
                                        {
                                            _loc_14 = _loc_17;
                                            _loc_8 = _loc_8.next;
                                            continue;
                                        }
                                        _loc_9 = 0;
                                        _loc_10 = 0;
                                        _loc_9 = _loc_6.x - _loc_14.x;
                                        _loc_10 = _loc_6.y - _loc_14.y;
                                        _loc_11 = 0;
                                        _loc_12 = 0;
                                        _loc_11 = _loc_7.x - _loc_6.x;
                                        _loc_12 = _loc_7.y - _loc_6.y;
                                        _loc_13 = 0;
                                        _loc_18 = 0;
                                        _loc_13 = _loc_17.x - _loc_14.x;
                                        _loc_18 = _loc_17.y - _loc_14.y;
                                        _loc_19 = _loc_12 * _loc_13 - _loc_11 * _loc_18;
                                        if (_loc_19 * _loc_19 > Config.epsilon)
                                        {
                                            _loc_19 = 1 / _loc_19;
                                            _loc_20 = (_loc_18 * _loc_9 - _loc_13 * _loc_10) * _loc_19;
                                            if (_loc_20 > Config.epsilon)
                                            {
                                            }
                                            if (_loc_20 < 1 - Config.epsilon)
                                            {
                                                _loc_21 = (_loc_12 * _loc_9 - _loc_11 * _loc_10) * _loc_19;
                                                if (_loc_21 > Config.epsilon)
                                                {
                                                }
                                                if (_loc_21 < 1 - Config.epsilon)
                                                {
                                                    _loc_4 = false;
                                                    _loc_16 = false;
                                                    break;
                                                }
                                            }
                                        }
                                        _loc_14 = _loc_17;
                                        _loc_8 = _loc_8.next;
                                    }
                                    if (_loc_16)
                                    {
                                        do
                                        {
                                            
                                            _loc_17 = lverts.next;
                                            if (_loc_6 != _loc_14)
                                            {
                                            }
                                            if (_loc_6 != _loc_17)
                                            {
                                            }
                                            if (_loc_7 != _loc_14)
                                            {
                                            }
                                            if (_loc_7 == _loc_17)
                                            {
                                                break;
                                            }
                                            _loc_9 = 0;
                                            _loc_10 = 0;
                                            _loc_9 = _loc_6.x - _loc_14.x;
                                            _loc_10 = _loc_6.y - _loc_14.y;
                                            _loc_11 = 0;
                                            _loc_12 = 0;
                                            _loc_11 = _loc_7.x - _loc_6.x;
                                            _loc_12 = _loc_7.y - _loc_6.y;
                                            _loc_13 = 0;
                                            _loc_18 = 0;
                                            _loc_13 = _loc_17.x - _loc_14.x;
                                            _loc_18 = _loc_17.y - _loc_14.y;
                                            _loc_19 = _loc_12 * _loc_13 - _loc_11 * _loc_18;
                                            if (_loc_19 * _loc_19 > Config.epsilon)
                                            {
                                                _loc_19 = 1 / _loc_19;
                                                _loc_20 = (_loc_18 * _loc_9 - _loc_13 * _loc_10) * _loc_19;
                                                if (_loc_20 > Config.epsilon)
                                                {
                                                }
                                                if (_loc_20 < 1 - Config.epsilon)
                                                {
                                                    _loc_21 = (_loc_12 * _loc_9 - _loc_11 * _loc_10) * _loc_19;
                                                    if (_loc_21 > Config.epsilon)
                                                    {
                                                    }
                                                    if (_loc_21 < 1 - Config.epsilon)
                                                    {
                                                        _loc_4 = false;
                                                        break;
                                                    }
                                                }
                                            }
                                        }while (false)
                                    }
                                }while (false)
                            }
                            if (!_loc_4)
                            {
                                if (ZPP_Flags.ValidationResult_SELF_INTERSECTING == null)
                                {
                                    ZPP_Flags.internal = true;
                                    ZPP_Flags.ValidationResult_SELF_INTERSECTING = new ValidationResult();
                                    ZPP_Flags.internal = false;
                                }
                                _loc_1 = ZPP_Flags.ValidationResult_SELF_INTERSECTING;
                                validation = _loc_1;
                                return _loc_1;
                            }
                            else
                            {
                                if (ZPP_Flags.ValidationResult_VALID == null)
                                {
                                    ZPP_Flags.internal = true;
                                    ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                                    ZPP_Flags.internal = false;
                                }
                                _loc_1 = ZPP_Flags.ValidationResult_VALID;
                                validation = _loc_1;
                                return _loc_1;
                            }
                        }
                    }
                }
            }
            else
            {
                return validation;
            }
        }// end function

        public function splice_collinear_real() : void
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = false;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            if (lverts.next == null)
            {
                return;
            }
            if (lverts.next.next == null)
            {
                return;
            }
            if (lverts.next.next.next == null)
            {
                return;
            }
            var _loc_1:* = null;
            var _loc_2:* = lverts.next;
            while (_loc_2 != null)
            {
                
                if (_loc_2.next == null)
                {
                    _loc_3 = lverts.next;
                }
                else
                {
                    _loc_3 = _loc_2.next;
                }
                _loc_4 = _loc_2;
                _loc_5 = _loc_3;
                _loc_6 = 0;
                _loc_7 = 0;
                _loc_6 = _loc_4.x - _loc_5.x;
                _loc_7 = _loc_4.y - _loc_5.y;
                if (_loc_6 * _loc_6 + _loc_7 * _loc_7 < Config.epsilon * Config.epsilon)
                {
                    cleanup_lvert(_loc_2);
                    _loc_2 = lverts.erase(_loc_1);
                    continue;
                }
                _loc_1 = _loc_2;
                _loc_2 = _loc_2.next;
            }
            if (lverts.next == null)
            {
                return;
            }
            do
            {
                
                _loc_8 = false;
                _loc_3 = lverts.next;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3.next == null)
                    {
                        _loc_4 = lverts.next;
                    }
                    else
                    {
                        _loc_4 = _loc_3.next;
                    }
                    if (_loc_4.next == null)
                    {
                        _loc_5 = lverts.next;
                    }
                    else
                    {
                        _loc_5 = _loc_4.next;
                    }
                    _loc_9 = _loc_3;
                    _loc_10 = _loc_4;
                    _loc_11 = _loc_5;
                    _loc_6 = 0;
                    _loc_7 = 0;
                    _loc_6 = _loc_10.x - _loc_9.x;
                    _loc_7 = _loc_10.y - _loc_9.y;
                    _loc_12 = 0;
                    _loc_13 = 0;
                    _loc_12 = _loc_11.x - _loc_10.x;
                    _loc_13 = _loc_11.y - _loc_10.y;
                    _loc_14 = _loc_13 * _loc_6 - _loc_12 * _loc_7;
                    if (_loc_14 * _loc_14 >= Config.epsilon * Config.epsilon)
                    {
                        _loc_3 = _loc_3.next;
                        continue;
                    }
                    cleanup_lvert(_loc_4);
                    lverts.erase(_loc_3.next == null ? (null) : (_loc_3));
                    _loc_8 = true;
                    _loc_3 = _loc_3.next;
                }
            }while (_loc_8)
            return;
        }// end function

        public function splice_collinear() : void
        {
            if (zip_sanitation)
            {
                zip_sanitation = false;
                splice_collinear_real();
            }
            return;
        }// end function

        public function setupLocalCOM() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = localCOMx;
            var _loc_2:* = localCOMy;
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
            wrap_localCOM = _loc_4;
            wrap_localCOM.zpp_inner._inuse = true;
            wrap_localCOM.zpp_inner._validate = localCOM_validate;
            wrap_localCOM.zpp_inner._invalidate = localCOM_invalidate;
            return;
        }// end function

        public function reverse_vertices() : void
        {
            lverts.reverse();
            gverts.reverse();
            edges.reverse();
            var _loc_1:* = edges.iterator_at((edgeCnt - 1));
            var _loc_2:* = edges.pop_unsafe();
            edges.insert(_loc_1, _loc_2);
            reverse_flag = !reverse_flag;
            if (wrap_lverts != null)
            {
                wrap_lverts.zpp_inner.reverse_flag = reverse_flag;
            }
            if (wrap_gverts != null)
            {
                wrap_gverts.zpp_inner.reverse_flag = reverse_flag;
            }
            if (wrap_edges != null)
            {
                wrap_edges.zpp_inner.reverse_flag = reverse_flag;
            }
            return;
        }// end function

        public function lverts_validate() : void
        {
            validate_lverts();
            return;
        }// end function

        public function lverts_subber(param1:Vec2) : void
        {
            cleanup_lvert(param1.zpp_inner);
            return;
        }// end function

        public function lverts_post_adder(param1:Vec2) : void
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Edge;
            var _loc_7:* = null as ZPP_Edge;
            param1.zpp_inner._invalidate = lverts_pa_invalidate;
            param1.zpp_inner._isimmutable = lverts_pa_immutable;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = lverts.next;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4;
                if (_loc_5 == param1.zpp_inner)
                {
                    break;
                }
                else
                {
                    if (_loc_2 == null)
                    {
                        _loc_2 = gverts.next;
                    }
                    else
                    {
                        _loc_2 = _loc_2.next;
                    }
                    if (_loc_3 == null)
                    {
                        _loc_3 = edges.head;
                    }
                    else
                    {
                        _loc_3 = _loc_3.next;
                    }
                }
                _loc_4 = _loc_4.next;
            }
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
            _loc_5._immutable = true;
            _loc_5.x = 0;
            _loc_5.y = 0;
            _loc_4 = _loc_5;
            gverts.insert(_loc_2, _loc_4);
            if (lverts.next.next != null)
            {
                if (lverts.next.next.next == null)
                {
                    if (ZPP_Edge.zpp_pool == null)
                    {
                        _loc_6 = new ZPP_Edge();
                    }
                    else
                    {
                        _loc_6 = ZPP_Edge.zpp_pool;
                        ZPP_Edge.zpp_pool = _loc_6.next;
                        _loc_6.next = null;
                    }
                    _loc_6.polygon = this;
                    edges.add(_loc_6);
                    if (ZPP_Edge.zpp_pool == null)
                    {
                        _loc_7 = new ZPP_Edge();
                    }
                    else
                    {
                        _loc_7 = ZPP_Edge.zpp_pool;
                        ZPP_Edge.zpp_pool = _loc_7.next;
                        _loc_7.next = null;
                    }
                    _loc_7.polygon = this;
                    edges.add(_loc_7);
                    edgeCnt = edgeCnt + 2;
                }
                else
                {
                    if (ZPP_Edge.zpp_pool == null)
                    {
                        _loc_6 = new ZPP_Edge();
                    }
                    else
                    {
                        _loc_6 = ZPP_Edge.zpp_pool;
                        ZPP_Edge.zpp_pool = _loc_6.next;
                        _loc_6.next = null;
                    }
                    _loc_6.polygon = this;
                    edges.insert(_loc_3, _loc_6);
                    (edgeCnt + 1);
                }
            }
            _loc_4._validate = gverts_pa_validate;
            return;
        }// end function

        public function lverts_pa_invalidate(param1:ZPP_Vec2) : void
        {
            invalidate_lverts();
            return;
        }// end function

        public function lverts_pa_immutable() : void
        {
            if (body != null)
            {
            }
            if (body.type == ZPP_Flags.id_BodyType_STATIC)
            {
            }
            if (body.space != null)
            {
                throw "Error: Cannot modify local vertex of Polygon added to a static body whilst within a Space";
            }
            return;
        }// end function

        public function lverts_modifiable() : void
        {
            immutable_midstep("Polygon::localVerts");
            if (body != null)
            {
            }
            if (body.type == ZPP_Flags.id_BodyType_STATIC)
            {
            }
            if (body.space != null)
            {
                throw "Error: Cannot modifiy shapes of static object once added to Space";
            }
            return;
        }// end function

        public function lverts_invalidate(param1:ZPP_Vec2List) : void
        {
            invalidate_lverts();
            return;
        }// end function

        public function localCOM_validate() : void
        {
            var _loc_1:* = null as ZPP_Polygon;
            var _loc_2:* = NaN;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = NaN;
            var _loc_8:* = null as ZPP_Vec2;
            if (lverts.next == null)
            {
                throw "Error: An empty polygon does not have any meaningful localCOM";
            }
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

        public function localCOM_invalidate(param1:ZPP_Vec2) : void
        {
            var _loc_2:* = null as ZPP_Polygon;
            var _loc_3:* = NaN;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = NaN;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = NaN;
            if (zip_localCOM)
            {
                zip_localCOM = false;
                if (type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_2 = polygon;
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
                if (wrap_localCOM != null)
                {
                    wrap_localCOM.zpp_inner.x = localCOMx;
                    wrap_localCOM.zpp_inner.y = localCOMy;
                }
            }
            _loc_3 = 0;
            _loc_8 = 0;
            _loc_3 = param1.x - localCOMx;
            _loc_8 = param1.y - localCOMy;
            _loc_4 = lverts.next;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4;
                _loc_10 = 1;
                _loc_5.x = _loc_5.x + _loc_3 * _loc_10;
                _loc_5.y = _loc_5.y + _loc_8 * _loc_10;
                _loc_4 = _loc_4.next;
            }
            invalidate_lverts();
            return;
        }// end function

        public function invalidate_lverts() : void
        {
            invalidate_laxi();
            invalidate_area_inertia();
            invalidate_angDrag();
            invalidate_localCOM();
            invalidate_gverts();
            zip_lverts = true;
            zip_valid = true;
            zip_sanitation = true;
            if (body != null)
            {
                body.wake();
            }
            return;
        }// end function

        public function invalidate_laxi() : void
        {
            invalidate_gaxi();
            zip_sweepRadius = true;
            zip_laxi = true;
            return;
        }// end function

        public function invalidate_gverts() : void
        {
            zip_aabb = true;
            if (body != null)
            {
                body.zip_aabb = true;
            }
            zip_gverts = true;
            return;
        }// end function

        public function invalidate_gaxi() : void
        {
            zip_gaxi = true;
            return;
        }// end function

        public function gverts_validate() : void
        {
            var _loc_1:* = null as ZPP_Body;
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            if (zip_gverts)
            {
                if (body != null)
                {
                    zip_gverts = false;
                    validate_lverts();
                    _loc_1 = body;
                    if (_loc_1.zip_axis)
                    {
                        _loc_1.zip_axis = false;
                        _loc_1.axisx = Math.sin(_loc_1.rot);
                        _loc_1.axisy = Math.cos(_loc_1.rot);
                    }
                    _loc_2 = lverts.next;
                    _loc_3 = gverts.next;
                    while (_loc_3 != null)
                    {
                        
                        _loc_4 = _loc_3;
                        _loc_5 = _loc_2;
                        _loc_2 = _loc_2.next;
                        _loc_4.x = body.posx + (body.axisy * _loc_5.x - body.axisx * _loc_5.y);
                        _loc_4.y = body.posy + (_loc_5.x * body.axisx + _loc_5.y * body.axisy);
                        _loc_3 = _loc_3.next;
                    }
                }
            }
            return;
        }// end function

        public function gverts_pa_validate() : void
        {
            var _loc_1:* = null as ZPP_Body;
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            if (body == null)
            {
                throw "Error: World vertex only makes sense when Polygon is contained in a rigid body";
            }
            if (zip_gverts)
            {
                if (body != null)
                {
                    zip_gverts = false;
                    validate_lverts();
                    _loc_1 = body;
                    if (_loc_1.zip_axis)
                    {
                        _loc_1.zip_axis = false;
                        _loc_1.axisx = Math.sin(_loc_1.rot);
                        _loc_1.axisy = Math.cos(_loc_1.rot);
                    }
                    _loc_2 = lverts.next;
                    _loc_3 = gverts.next;
                    while (_loc_3 != null)
                    {
                        
                        _loc_4 = _loc_3;
                        _loc_5 = _loc_2;
                        _loc_2 = _loc_2.next;
                        _loc_4.x = body.posx + (body.axisy * _loc_5.x - body.axisx * _loc_5.y);
                        _loc_4.y = body.posy + (_loc_5.x * body.axisx + _loc_5.y * body.axisy);
                        _loc_3 = _loc_3.next;
                    }
                }
            }
            return;
        }// end function

        public function getlverts() : void
        {
            var _loc_1:* = this;
            wrap_lverts = ZPP_MixVec2List.get(lverts);
            wrap_lverts.zpp_inner.post_adder = lverts_post_adder;
            wrap_lverts.zpp_inner.subber = lverts_subber;
            wrap_lverts.zpp_inner._invalidate = lverts_invalidate;
            wrap_lverts.zpp_inner._validate = lverts_validate;
            wrap_lverts.zpp_inner._modifiable = lverts_modifiable;
            wrap_lverts.zpp_inner.reverse_flag = reverse_flag;
            return;
        }// end function

        public function getgverts() : void
        {
            var _loc_1:* = this;
            wrap_gverts = ZPP_MixVec2List.get(gverts, true);
            wrap_gverts.zpp_inner.reverse_flag = reverse_flag;
            wrap_gverts.zpp_inner._validate = gverts_validate;
            return;
        }// end function

        public function getedges() : void
        {
            var _loc_1:* = this;
            wrap_edges = ZPP_EdgeList.get(edges, true);
            wrap_edges.zpp_inner.reverse_flag = reverse_flag;
            wrap_edges.zpp_inner._validate = edges_validate;
            return;
        }// end function

        public function edges_validate() : void
        {
            validate_lverts();
            return;
        }// end function

        public function cleanup_lvert(param1:ZPP_Vec2) : void
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Edge;
            var _loc_7:* = null as ZPP_Edge;
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_4 = lverts.next;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4;
                if (_loc_5 == param1)
                {
                    break;
                }
                else
                {
                    if (_loc_2 == null)
                    {
                        _loc_2 = gverts.next;
                    }
                    else
                    {
                        _loc_2 = _loc_2.next;
                    }
                    if (_loc_3 == null)
                    {
                        _loc_3 = edges.head;
                    }
                    else
                    {
                        _loc_3 = _loc_3.next;
                    }
                }
                _loc_4 = _loc_4.next;
            }
            if (_loc_2 == null)
            {
                _loc_4 = gverts.next;
            }
            else
            {
                _loc_4 = _loc_2.next;
            }
            gverts.erase(_loc_2);
            _loc_5 = _loc_4;
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
            if (edgeCnt == 2)
            {
                _loc_6 = edges.pop_unsafe();
                _loc_7 = _loc_6;
                _loc_7.polygon = null;
                _loc_7.next = ZPP_Edge.zpp_pool;
                ZPP_Edge.zpp_pool = _loc_7;
                _loc_6 = edges.pop_unsafe();
                _loc_7 = _loc_6;
                _loc_7.polygon = null;
                _loc_7.next = ZPP_Edge.zpp_pool;
                ZPP_Edge.zpp_pool = _loc_7;
                edgeCnt = 0;
            }
            else if (edgeCnt != 0)
            {
                if (_loc_3 == null)
                {
                    _loc_6 = edges.head.elt;
                }
                else
                {
                    _loc_6 = _loc_3.next.elt;
                }
                edges.erase(_loc_3);
                _loc_7 = _loc_6;
                _loc_7.polygon = null;
                _loc_7.next = ZPP_Edge.zpp_pool;
                ZPP_Edge.zpp_pool = _loc_7;
                (edgeCnt - 1);
            }
            return;
        }// end function

        public function _force_validate_aabb() : void
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = lverts.next;
            var _loc_2:* = gverts.next;
            var _loc_3:* = _loc_1;
            _loc_1 = _loc_1.next;
            _loc_2.x = body.posx + (body.axisy * _loc_3.x - body.axisx * _loc_3.y);
            _loc_2.y = body.posy + (_loc_3.x * body.axisx + _loc_3.y * body.axisy);
            aabb.minx = _loc_2.x;
            aabb.miny = _loc_2.y;
            aabb.maxx = _loc_2.x;
            aabb.maxy = _loc_2.y;
            var _loc_4:* = gverts.next.next;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4;
                _loc_6 = _loc_1;
                _loc_1 = _loc_1.next;
                _loc_5.x = body.posx + (body.axisy * _loc_6.x - body.axisx * _loc_6.y);
                _loc_5.y = body.posy + (_loc_6.x * body.axisx + _loc_6.y * body.axisy);
                if (_loc_5.x < aabb.minx)
                {
                    aabb.minx = _loc_5.x;
                }
                if (_loc_5.x > aabb.maxx)
                {
                    aabb.maxx = _loc_5.x;
                }
                if (_loc_5.y < aabb.miny)
                {
                    aabb.miny = _loc_5.y;
                }
                if (_loc_5.y > aabb.maxy)
                {
                    aabb.maxy = _loc_5.y;
                }
                _loc_4 = _loc_4.next;
            }
            return;
        }// end function

        public function __validate_sweepRadius() : void
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = NaN;
            var _loc_7:* = null as ZPP_Edge;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            validate_laxi();
            var _loc_3:* = lverts.next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
                _loc_5 = _loc_4.x * _loc_4.x + _loc_4.y * _loc_4.y;
                if (_loc_5 > _loc_1)
                {
                    _loc_1 = _loc_5;
                }
                _loc_3 = _loc_3.next;
            }
            var _loc_6:* = edges.head;
            while (_loc_6 != null)
            {
                
                _loc_7 = _loc_6.elt;
                if (_loc_7.lprojection < _loc_2)
                {
                    _loc_2 = _loc_7.lprojection;
                    if (_loc_2 < 0)
                    {
                        break;
                    }
                }
                _loc_6 = _loc_6.next;
            }
            if (_loc_2 < 0)
            {
                _loc_2 = 0;
            }
            sweepRadius = Math.sqrt(_loc_1);
            sweepCoef = sweepRadius - _loc_2;
            return;
        }// end function

        public function __validate_localCOM() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = NaN;
            var _loc_7:* = null as ZPP_Vec2;
            if (lverts.next == null)
            {
                throw "Error: An empty polygon has no meaningful localCOM";
            }
            if (lverts.next.next == null)
            {
                localCOMx = lverts.next.x;
                localCOMy = lverts.next.y;
            }
            else if (lverts.next.next.next == null)
            {
                localCOMx = lverts.next.x;
                localCOMy = lverts.next.y;
                _loc_1 = 1;
                localCOMx = localCOMx + lverts.next.next.x * _loc_1;
                localCOMy = localCOMy + lverts.next.next.y * _loc_1;
                _loc_1 = 0.5;
                localCOMx = localCOMx * _loc_1;
                localCOMy = localCOMy * _loc_1;
            }
            else
            {
                localCOMx = 0;
                localCOMy = 0;
                _loc_1 = 0;
                _loc_2 = lverts.next;
                _loc_3 = _loc_2;
                _loc_2 = _loc_2.next;
                _loc_4 = _loc_2;
                _loc_2 = _loc_2.next;
                while (_loc_2 != null)
                {
                    
                    _loc_5 = _loc_2;
                    _loc_1 = _loc_1 + _loc_4.x * (_loc_5.y - _loc_3.y);
                    _loc_6 = _loc_5.y * _loc_4.x - _loc_5.x * _loc_4.y;
                    localCOMx = localCOMx + (_loc_4.x + _loc_5.x) * _loc_6;
                    localCOMy = localCOMy + (_loc_4.y + _loc_5.y) * _loc_6;
                    _loc_3 = _loc_4;
                    _loc_4 = _loc_5;
                    _loc_2 = _loc_2.next;
                }
                _loc_2 = lverts.next;
                _loc_5 = _loc_2;
                _loc_1 = _loc_1 + _loc_4.x * (_loc_5.y - _loc_3.y);
                _loc_6 = _loc_5.y * _loc_4.x - _loc_5.x * _loc_4.y;
                localCOMx = localCOMx + (_loc_4.x + _loc_5.x) * _loc_6;
                localCOMy = localCOMy + (_loc_4.y + _loc_5.y) * _loc_6;
                _loc_3 = _loc_4;
                _loc_4 = _loc_5;
                _loc_2 = _loc_2.next;
                _loc_7 = _loc_2;
                _loc_1 = _loc_1 + _loc_4.x * (_loc_7.y - _loc_3.y);
                _loc_6 = _loc_7.y * _loc_4.x - _loc_7.x * _loc_4.y;
                localCOMx = localCOMx + (_loc_4.x + _loc_7.x) * _loc_6;
                localCOMy = localCOMy + (_loc_4.y + _loc_7.y) * _loc_6;
                _loc_1 = 1 / (3 * _loc_1);
                _loc_6 = _loc_1;
                localCOMx = localCOMx * _loc_6;
                localCOMy = localCOMy * _loc_6;
            }
            return;
        }// end function

        public function __validate_area_inertia() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = null as ZPP_Vec2;
            if (lverts.next != null)
            {
            }
            if (lverts.next.next != null)
            {
            }
            if (lverts.next.next.next == null)
            {
                area = 0;
                inertia = 0;
            }
            else
            {
                area = 0;
                _loc_1 = 0;
                _loc_2 = 0;
                _loc_3 = lverts.next;
                _loc_4 = _loc_3;
                _loc_3 = _loc_3.next;
                _loc_5 = _loc_3;
                _loc_3 = _loc_3.next;
                while (_loc_3 != null)
                {
                    
                    _loc_6 = _loc_3;
                    _loc_7 = _loc_5.y * _loc_4.x - _loc_5.x * _loc_4.y;
                    _loc_8 = _loc_5.x * _loc_5.x + _loc_5.y * _loc_5.y + (_loc_5.x * _loc_4.x + _loc_5.y * _loc_4.y) + (_loc_4.x * _loc_4.x + _loc_4.y * _loc_4.y);
                    _loc_1 = _loc_1 + _loc_7 * _loc_8;
                    _loc_2 = _loc_2 + _loc_7;
                    area = area + _loc_5.x * (_loc_6.y - _loc_4.y);
                    _loc_4 = _loc_5;
                    _loc_5 = _loc_6;
                    _loc_3 = _loc_3.next;
                }
                _loc_3 = lverts.next;
                _loc_6 = _loc_3;
                _loc_7 = _loc_5.y * _loc_4.x - _loc_5.x * _loc_4.y;
                _loc_8 = _loc_5.x * _loc_5.x + _loc_5.y * _loc_5.y + (_loc_5.x * _loc_4.x + _loc_5.y * _loc_4.y) + (_loc_4.x * _loc_4.x + _loc_4.y * _loc_4.y);
                _loc_1 = _loc_1 + _loc_7 * _loc_8;
                _loc_2 = _loc_2 + _loc_7;
                area = area + _loc_5.x * (_loc_6.y - _loc_4.y);
                _loc_4 = _loc_5;
                _loc_5 = _loc_6;
                _loc_3 = _loc_3.next;
                _loc_9 = _loc_3;
                _loc_7 = _loc_5.y * _loc_4.x - _loc_5.x * _loc_4.y;
                _loc_8 = _loc_5.x * _loc_5.x + _loc_5.y * _loc_5.y + (_loc_5.x * _loc_4.x + _loc_5.y * _loc_4.y) + (_loc_4.x * _loc_4.x + _loc_4.y * _loc_4.y);
                _loc_1 = _loc_1 + _loc_7 * _loc_8;
                _loc_2 = _loc_2 + _loc_7;
                area = area + _loc_5.x * (_loc_9.y - _loc_4.y);
                inertia = _loc_1 / (6 * _loc_2);
                area = area * 0.5;
                if (area < 0)
                {
                    area = -area;
                    reverse_vertices();
                }
            }
            return;
        }// end function

        public function __validate_angDrag() : void
        {
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as ZPP_Edge;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            if (lverts.length < 3)
            {
                throw "Error: Polygon\'s with less than 3 vertices have no meaningful angDrag";
            }
            validate_area_inertia();
            validate_laxi();
            var _loc_1:* = 0;
            var _loc_2:* = edges.head;
            var _loc_3:* = 0;
            var _loc_4:* = true;
            var _loc_5:* = lverts.next;
            var _loc_6:* = _loc_5;
            var _loc_7:* = _loc_5.next;
            while (_loc_7 != null)
            {
                
                _loc_8 = _loc_7;
                _loc_9 = _loc_2.elt;
                _loc_2 = _loc_2.next;
                _loc_3 = _loc_3 + _loc_9.length;
                _loc_10 = 0;
                _loc_11 = 0;
                _loc_10 = _loc_8.x - _loc_6.x;
                _loc_11 = _loc_8.y - _loc_6.y;
                _loc_1 = _loc_1 + _loc_9.length * Config.fluidAngularDragFriction * material.dynamicFriction * _loc_9.lprojection * _loc_9.lprojection;
                _loc_12 = (-(_loc_6.y * _loc_9.lnormx - _loc_6.x * _loc_9.lnormy)) / (_loc_11 * _loc_9.lnormx - _loc_10 * _loc_9.lnormy);
                if (_loc_12 > 0)
                {
                    if (_loc_12 > 1)
                    {
                        _loc_13 = 1;
                    }
                    else
                    {
                        _loc_13 = _loc_12;
                    }
                    _loc_14 = 0;
                    _loc_15 = 0;
                    _loc_14 = _loc_6.x;
                    _loc_15 = _loc_6.y;
                    _loc_16 = _loc_13;
                    _loc_14 = _loc_14 + _loc_10 * _loc_16;
                    _loc_15 = _loc_15 + _loc_11 * _loc_16;
                    _loc_16 = _loc_9.lnormy * _loc_6.x - _loc_9.lnormx * _loc_6.y;
                    _loc_17 = _loc_9.lnormy * _loc_14 - _loc_9.lnormx * _loc_15;
                    _loc_18 = (_loc_17 * _loc_17 * _loc_17 - _loc_16 * _loc_16 * _loc_16) / (3 * (_loc_17 - _loc_16));
                    _loc_1 = _loc_1 + _loc_18 * _loc_13 * _loc_9.length * Config.fluidAngularDrag;
                }
                if (_loc_12 < 1)
                {
                    if (_loc_12 < 0)
                    {
                        _loc_13 = 0;
                    }
                    else
                    {
                        _loc_13 = _loc_12;
                    }
                    _loc_14 = 0;
                    _loc_15 = 0;
                    _loc_14 = _loc_6.x;
                    _loc_15 = _loc_6.y;
                    _loc_16 = _loc_13;
                    _loc_14 = _loc_14 + _loc_10 * _loc_16;
                    _loc_15 = _loc_15 + _loc_11 * _loc_16;
                    _loc_16 = _loc_9.lnormy * _loc_14 - _loc_9.lnormx * _loc_15;
                    _loc_17 = _loc_9.lnormy * _loc_8.x - _loc_9.lnormx * _loc_8.y;
                    _loc_18 = (_loc_17 * _loc_17 * _loc_17 - _loc_16 * _loc_16 * _loc_16) / (3 * (_loc_17 - _loc_16));
                    _loc_1 = _loc_1 + _loc_18 * Config.fluidVacuumDrag * (1 - _loc_13) * _loc_9.length * Config.fluidAngularDrag;
                }
                _loc_5 = _loc_7;
                _loc_6 = _loc_8;
                _loc_7 = _loc_7.next;
            }
            if (_loc_4)
            {
                do
                {
                    
                    _loc_7 = lverts.next;
                    _loc_8 = _loc_7;
                    _loc_9 = _loc_2.elt;
                    _loc_2 = _loc_2.next;
                    _loc_3 = _loc_3 + _loc_9.length;
                    _loc_10 = 0;
                    _loc_11 = 0;
                    _loc_10 = _loc_8.x - _loc_6.x;
                    _loc_11 = _loc_8.y - _loc_6.y;
                    _loc_1 = _loc_1 + _loc_9.length * Config.fluidAngularDragFriction * material.dynamicFriction * _loc_9.lprojection * _loc_9.lprojection;
                    _loc_12 = (-(_loc_6.y * _loc_9.lnormx - _loc_6.x * _loc_9.lnormy)) / (_loc_11 * _loc_9.lnormx - _loc_10 * _loc_9.lnormy);
                    if (_loc_12 > 0)
                    {
                        if (_loc_12 > 1)
                        {
                            _loc_13 = 1;
                        }
                        else
                        {
                            _loc_13 = _loc_12;
                        }
                        _loc_14 = 0;
                        _loc_15 = 0;
                        _loc_14 = _loc_6.x;
                        _loc_15 = _loc_6.y;
                        _loc_16 = _loc_13;
                        _loc_14 = _loc_14 + _loc_10 * _loc_16;
                        _loc_15 = _loc_15 + _loc_11 * _loc_16;
                        _loc_16 = _loc_9.lnormy * _loc_6.x - _loc_9.lnormx * _loc_6.y;
                        _loc_17 = _loc_9.lnormy * _loc_14 - _loc_9.lnormx * _loc_15;
                        _loc_18 = (_loc_17 * _loc_17 * _loc_17 - _loc_16 * _loc_16 * _loc_16) / (3 * (_loc_17 - _loc_16));
                        _loc_1 = _loc_1 + _loc_18 * _loc_13 * _loc_9.length * Config.fluidAngularDrag;
                    }
                    if (_loc_12 < 1)
                    {
                        if (_loc_12 < 0)
                        {
                            _loc_13 = 0;
                        }
                        else
                        {
                            _loc_13 = _loc_12;
                        }
                        _loc_14 = 0;
                        _loc_15 = 0;
                        _loc_14 = _loc_6.x;
                        _loc_15 = _loc_6.y;
                        _loc_16 = _loc_13;
                        _loc_14 = _loc_14 + _loc_10 * _loc_16;
                        _loc_15 = _loc_15 + _loc_11 * _loc_16;
                        _loc_16 = _loc_9.lnormy * _loc_14 - _loc_9.lnormx * _loc_15;
                        _loc_17 = _loc_9.lnormy * _loc_8.x - _loc_9.lnormx * _loc_8.y;
                        _loc_18 = (_loc_17 * _loc_17 * _loc_17 - _loc_16 * _loc_16 * _loc_16) / (3 * (_loc_17 - _loc_16));
                        _loc_1 = _loc_1 + _loc_18 * Config.fluidVacuumDrag * (1 - _loc_13) * _loc_9.length * Config.fluidAngularDrag;
                    }
                }while (false)
            }
            angDrag = _loc_1 / (inertia * _loc_3);
            return;
        }// end function

        public function __validate_aabb() : void
        {
            var _loc_1:* = null as ZPP_Body;
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            if (zip_gverts)
            {
                if (body != null)
                {
                    zip_gverts = false;
                    validate_lverts();
                    _loc_1 = body;
                    if (_loc_1.zip_axis)
                    {
                        _loc_1.zip_axis = false;
                        _loc_1.axisx = Math.sin(_loc_1.rot);
                        _loc_1.axisy = Math.cos(_loc_1.rot);
                    }
                    _loc_2 = lverts.next;
                    _loc_3 = gverts.next;
                    while (_loc_3 != null)
                    {
                        
                        _loc_4 = _loc_3;
                        _loc_5 = _loc_2;
                        _loc_2 = _loc_2.next;
                        _loc_4.x = body.posx + (body.axisy * _loc_5.x - body.axisx * _loc_5.y);
                        _loc_4.y = body.posy + (_loc_5.x * body.axisx + _loc_5.y * body.axisy);
                        _loc_3 = _loc_3.next;
                    }
                }
            }
            if (lverts.next == null)
            {
                throw "Error: An empty polygon has no meaningful bounds";
            }
            _loc_2 = gverts.next;
            aabb.minx = _loc_2.x;
            aabb.miny = _loc_2.y;
            aabb.maxx = _loc_2.x;
            aabb.maxy = _loc_2.y;
            _loc_3 = gverts.next.next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
                if (_loc_4.x < aabb.minx)
                {
                    aabb.minx = _loc_4.x;
                }
                if (_loc_4.x > aabb.maxx)
                {
                    aabb.maxx = _loc_4.x;
                }
                if (_loc_4.y < aabb.miny)
                {
                    aabb.miny = _loc_4.y;
                }
                if (_loc_4.y > aabb.maxy)
                {
                    aabb.maxy = _loc_4.y;
                }
                _loc_3 = _loc_3.next;
            }
            return;
        }// end function

        public function __translate(param1:Number, param2:Number) : void
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = NaN;
            var _loc_3:* = lverts.next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
                _loc_5 = 1;
                _loc_4.x = _loc_4.x + param1 * _loc_5;
                _loc_4.y = _loc_4.y + param2 * _loc_5;
                _loc_3 = _loc_3.next;
            }
            invalidate_lverts();
            return;
        }// end function

        public function __transform(param1:Mat23) : void
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = NaN;
            var _loc_2:* = lverts.next;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2;
                _loc_4 = param1.zpp_inner.a * _loc_3.x + param1.zpp_inner.b * _loc_3.y + param1.zpp_inner.tx;
                _loc_3.y = param1.zpp_inner.c * _loc_3.x + param1.zpp_inner.d * _loc_3.y + param1.zpp_inner.ty;
                _loc_3.x = _loc_4;
                _loc_2 = _loc_2.next;
            }
            invalidate_lverts();
            return;
        }// end function

        public function __scale(param1:Number, param2:Number) : void
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_3:* = lverts.next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
                _loc_4.x = _loc_4.x * param1;
                _loc_4.y = _loc_4.y * param2;
                _loc_3 = _loc_3.next;
            }
            invalidate_lverts();
            return;
        }// end function

        public function __rotate(param1:Number, param2:Number) : void
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_3:* = lverts.next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
                _loc_5 = 0;
                _loc_6 = 0;
                _loc_5 = param2 * _loc_4.x - param1 * _loc_4.y;
                _loc_6 = _loc_4.x * param1 + _loc_4.y * param2;
                _loc_4.x = _loc_5;
                _loc_4.y = _loc_6;
                _loc_3 = _loc_3.next;
            }
            invalidate_lverts();
            return;
        }// end function

        public function __copy() : ZPP_Polygon
        {
            var _loc_2:* = outer_zn;
            if (_loc_2.zpp_inner_zn.wrap_lverts == null)
            {
                _loc_2.zpp_inner_zn.getlverts();
            }
            var _loc_1:* = new Polygon(_loc_2.zpp_inner_zn.wrap_lverts).zpp_inner_zn;
            return _loc_1;
        }// end function

        public function __clear() : void
        {
            return;
        }// end function

    }
}
