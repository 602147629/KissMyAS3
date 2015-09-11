package zpp_nape.geom
{
    import nape.geom.*;
    import zpp_nape.util.*;

    public class ZPP_Cutter extends Object
    {
        public static var ints:ZNPList_ZPP_CutInt;
        public static var paths:ZNPList_ZPP_CutVert;

        public function ZPP_Cutter() : void
        {
            return;
        }// end function

        public static function run(param1:ZPP_GeomVert, param2:Vec2, param3:Vec2, param4:Boolean, param5:Boolean, param6:GeomPolyList) : GeomPolyList
        {
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_18:* = null as ZPP_CutVert;
            var _loc_19:* = null as ZPP_CutVert;
            var _loc_20:* = null as ZPP_CutVert;
            var _loc_21:* = null as ZPP_CutVert;
            var _loc_22:* = null as ZPP_CutVert;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = 0;
            var _loc_28:* = NaN;
            var _loc_29:* = false;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = false;
            var _loc_33:* = null as ZPP_GeomVert;
            var _loc_34:* = null as ZPP_GeomVert;
            var _loc_35:* = null as ZPP_GeomVert;
            var _loc_36:* = null as ZPP_GeomVert;
            var _loc_37:* = null as ZPP_GeomVert;
            var _loc_38:* = null as ZPP_CutVert;
            var _loc_39:* = null as ZPP_CutVert;
            var _loc_40:* = null as ZPP_CutVert;
            var _loc_41:* = null as ZPP_CutInt;
            var _loc_42:* = null as ZPP_GeomVert;
            var _loc_43:* = NaN;
            var _loc_44:* = NaN;
            var _loc_45:* = NaN;
            var _loc_47:* = null as ZNPNode_ZPP_CutInt;
            var _loc_48:* = null as ZNPNode_ZPP_CutInt;
            var _loc_49:* = null as ZNPNode_ZPP_CutInt;
            var _loc_50:* = null as ZNPNode_ZPP_CutInt;
            var _loc_51:* = null as ZNPNode_ZPP_CutInt;
            var _loc_52:* = 0;
            var _loc_53:* = 0;
            var _loc_54:* = 0;
            var _loc_55:* = null as ZPP_CutInt;
            var _loc_56:* = null as Vec2;
            var _loc_57:* = null as Vec2;
            var _loc_58:* = null as ZPP_Vec2;
            var _loc_59:* = null as ZPP_CutInt;
            var _loc_60:* = null as GeomPolyList;
            var _loc_62:* = null as GeomPoly;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = param2.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_7 = param2.zpp_inner.x;
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = param2.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_8 = param2.zpp_inner.y;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = param3.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_10 = param3.zpp_inner.x - _loc_7;
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = param3.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_11 = param3.zpp_inner.y - _loc_8;
            if (param4)
            {
                _loc_12 = 0;
            }
            else
            {
                _loc_12 = -17899999999999994000000000000;
            }
            if (param5)
            {
                _loc_13 = 1;
            }
            else
            {
                _loc_13 = 17899999999999994000000000000;
            }
            var _loc_14:* = -(_loc_8 * _loc_10 - _loc_7 * _loc_11);
            var _loc_15:* = null;
            var _loc_16:* = false;
            var _loc_17:* = param1;
            do
            {
                
                if (ZPP_CutVert.zpp_pool == null)
                {
                    _loc_18 = new ZPP_CutVert();
                }
                else
                {
                    _loc_18 = ZPP_CutVert.zpp_pool;
                    ZPP_CutVert.zpp_pool = _loc_18.next;
                    _loc_18.next = null;
                }
                _loc_18.vert = _loc_17;
                _loc_18.posx = _loc_18.vert.x;
                _loc_18.posy = _loc_18.vert.y;
                _loc_18.value = _loc_18.posy * _loc_10 - _loc_18.posx * _loc_11 + _loc_14;
                _loc_18.positive = _loc_18.value > 0;
                if (_loc_18.value == 0)
                {
                    _loc_16 = true;
                }
                _loc_19 = _loc_18;
                if (_loc_15 == null)
                {
                    _loc_20 = _loc_19;
                    _loc_19.next = _loc_20;
                    _loc_20 = _loc_20;
                    _loc_19.prev = _loc_20;
                    _loc_15 = _loc_20;
                }
                else
                {
                    _loc_19.prev = _loc_15;
                    _loc_19.next = _loc_15.next;
                    _loc_15.next.prev = _loc_19;
                    _loc_15.next = _loc_19;
                }
                _loc_15 = _loc_19;
                _loc_17 = _loc_17.next;
            }while (_loc_17 != param1)
            if (_loc_16)
            {
                _loc_18 = null;
                _loc_19 = _loc_15;
                _loc_20 = _loc_15;
                if (_loc_19 != null)
                {
                    _loc_21 = _loc_19;
                    do
                    {
                        
                        _loc_22 = _loc_21;
                        if (_loc_22.value != 0)
                        {
                            _loc_18 = _loc_22;
                            break;
                        }
                        _loc_21 = _loc_21.next;
                    }while (_loc_21 != _loc_20)
                }
                _loc_23 = 0;
                _loc_24 = 0;
                _loc_23 = _loc_10;
                _loc_24 = _loc_11;
                _loc_25 = _loc_23 * _loc_23 + _loc_24 * _loc_24;
                _loc_27 = 1597463007 - (0 >> 1);
                _loc_28 = 0;
                _loc_26 = _loc_28 * (1.5 - 0.5 * _loc_25 * _loc_28 * _loc_28);
                _loc_28 = _loc_26;
                _loc_23 = _loc_23 * _loc_28;
                _loc_24 = _loc_24 * _loc_28;
                _loc_25 = _loc_23;
                _loc_23 = -_loc_24;
                _loc_24 = _loc_25;
                _loc_19 = null;
                _loc_20 = _loc_18;
                do
                {
                    
                    if (_loc_20.value != 0)
                    {
                        if (_loc_19 != null)
                        {
                        }
                    }
                    if (_loc_20 == _loc_19.next)
                    {
                        _loc_19 = _loc_20;
                        _loc_20 = _loc_20.next;
                        continue;
                    }
                    _loc_25 = _loc_19.value * _loc_20.value;
                    if (_loc_25 == 0)
                    {
                        _loc_20 = _loc_20.next;
                        continue;
                    }
                    _loc_21 = _loc_19.next;
                    if (_loc_25 > 0)
                    {
                        _loc_29 = _loc_19.positive;
                    }
                    else
                    {
                        _loc_22 = _loc_21.next;
                        _loc_26 = 0;
                        _loc_28 = 0;
                        _loc_26 = _loc_21.posx + _loc_22.posx;
                        _loc_28 = _loc_21.posy + _loc_22.posy;
                        _loc_30 = 0.5;
                        _loc_26 = _loc_26 * _loc_30;
                        _loc_28 = _loc_28 * _loc_30;
                        _loc_30 = _loc_26 + _loc_23 * 1e-008;
                        _loc_31 = _loc_28 + _loc_24 * 1e-008;
                        _loc_32 = false;
                        _loc_33 = param1;
                        _loc_34 = param1;
                        if (_loc_33 != null)
                        {
                            _loc_35 = _loc_33;
                            do
                            {
                                
                                _loc_36 = _loc_35;
                                _loc_37 = _loc_36.prev;
                                if (_loc_36.y < _loc_31)
                                {
                                }
                                if (_loc_37.y < _loc_31)
                                {
                                    if (_loc_37.y < _loc_31)
                                    {
                                    }
                                }
                                if (_loc_36.y >= _loc_31)
                                {
                                    if (_loc_36.x > _loc_30)
                                    {
                                    }
                                }
                                if (_loc_37.x <= _loc_30)
                                {
                                    if (_loc_36.x + (_loc_31 - _loc_36.y) / (_loc_37.y - _loc_36.y) * (_loc_37.x - _loc_36.x) < _loc_30)
                                    {
                                        _loc_32 = !_loc_32;
                                    }
                                }
                                _loc_35 = _loc_35.next;
                            }while (_loc_35 != _loc_34)
                        }
                        _loc_29 = _loc_32;
                    }
                    _loc_22 = _loc_21;
                    _loc_38 = _loc_20;
                    if (_loc_22 != null)
                    {
                        _loc_39 = _loc_22;
                        do
                        {
                            
                            _loc_40 = _loc_39;
                            _loc_40.positive = _loc_29;
                            _loc_39 = _loc_39.next;
                        }while (_loc_39 != _loc_38)
                    }
                    _loc_19 = _loc_20;
                    _loc_20 = _loc_20.next;
                }while (_loc_20 != _loc_18)
                do
                {
                    
                    if (_loc_20.value != 0)
                    {
                        if (_loc_19 != null)
                        {
                        }
                    }
                    if (_loc_20 == _loc_19.next)
                    {
                        _loc_19 = _loc_20;
                        _loc_20 = _loc_20.next;
                        continue;
                    }
                    _loc_25 = _loc_19.value * _loc_20.value;
                    if (_loc_25 == 0)
                    {
                        _loc_20 = _loc_20.next;
                        continue;
                    }
                    _loc_21 = _loc_19.next;
                    if (_loc_25 > 0)
                    {
                        _loc_29 = _loc_19.positive;
                    }
                    else
                    {
                        _loc_22 = _loc_21.next;
                        _loc_26 = 0;
                        _loc_28 = 0;
                        _loc_26 = _loc_21.posx + _loc_22.posx;
                        _loc_28 = _loc_21.posy + _loc_22.posy;
                        _loc_30 = 0.5;
                        _loc_26 = _loc_26 * _loc_30;
                        _loc_28 = _loc_28 * _loc_30;
                        _loc_30 = _loc_26 + _loc_23 * 1e-008;
                        _loc_31 = _loc_28 + _loc_24 * 1e-008;
                        _loc_32 = false;
                        _loc_33 = param1;
                        _loc_34 = param1;
                        if (_loc_33 != null)
                        {
                            _loc_35 = _loc_33;
                            do
                            {
                                
                                _loc_36 = _loc_35;
                                _loc_37 = _loc_36.prev;
                                if (_loc_36.y < _loc_31)
                                {
                                }
                                if (_loc_37.y < _loc_31)
                                {
                                    if (_loc_37.y < _loc_31)
                                    {
                                    }
                                }
                                if (_loc_36.y >= _loc_31)
                                {
                                    if (_loc_36.x > _loc_30)
                                    {
                                    }
                                }
                                if (_loc_37.x <= _loc_30)
                                {
                                    if (_loc_36.x + (_loc_31 - _loc_36.y) / (_loc_37.y - _loc_36.y) * (_loc_37.x - _loc_36.x) < _loc_30)
                                    {
                                        _loc_32 = !_loc_32;
                                    }
                                }
                                _loc_35 = _loc_35.next;
                            }while (_loc_35 != _loc_34)
                        }
                        _loc_29 = _loc_32;
                    }
                    _loc_22 = _loc_21;
                    _loc_38 = _loc_20;
                    if (_loc_22 != null)
                    {
                        _loc_39 = _loc_22;
                        do
                        {
                            
                            _loc_40 = _loc_39;
                            _loc_40.positive = _loc_29;
                            _loc_39 = _loc_39.next;
                        }while (_loc_39 != _loc_38)
                    }
                    _loc_19 = _loc_20;
                    _loc_20 = _loc_20.next;
                }while (false)
            }
            if (ZPP_Cutter.ints == null)
            {
                ZPP_Cutter.ints = new ZNPList_ZPP_CutInt();
            }
            if (ZPP_Cutter.paths == null)
            {
                ZPP_Cutter.paths = new ZNPList_ZPP_CutVert();
            }
            _loc_33 = null;
            if (ZPP_GeomVert.zpp_pool == null)
            {
                _loc_35 = new ZPP_GeomVert();
            }
            else
            {
                _loc_35 = ZPP_GeomVert.zpp_pool;
                ZPP_GeomVert.zpp_pool = _loc_35.next;
                _loc_35.next = null;
            }
            _loc_35.forced = false;
            _loc_35.x = _loc_15.posx;
            _loc_35.y = _loc_15.posy;
            _loc_34 = _loc_35;
            if (_loc_33 == null)
            {
                _loc_35 = _loc_34;
                _loc_34.next = _loc_35;
                _loc_35 = _loc_35;
                _loc_34.prev = _loc_35;
                _loc_33 = _loc_35;
            }
            else
            {
                _loc_34.next = _loc_33;
                _loc_34.prev = _loc_33.prev;
                _loc_33.prev.next = _loc_34;
                _loc_33.prev = _loc_34;
            }
            _loc_34 = _loc_33;
            if (ZPP_CutVert.zpp_pool == null)
            {
                _loc_19 = new ZPP_CutVert();
            }
            else
            {
                _loc_19 = ZPP_CutVert.zpp_pool;
                ZPP_CutVert.zpp_pool = _loc_19.next;
                _loc_19.next = null;
            }
            _loc_19.vert = _loc_33;
            _loc_19.parent = _loc_19;
            _loc_19.rank = 0;
            _loc_19.used = false;
            _loc_18 = _loc_19;
            ZPP_Cutter.paths.add(_loc_18);
            _loc_19 = _loc_15;
            do
            {
                
                _loc_20 = _loc_19.next;
                if (ZPP_GeomVert.zpp_pool == null)
                {
                    _loc_36 = new ZPP_GeomVert();
                }
                else
                {
                    _loc_36 = ZPP_GeomVert.zpp_pool;
                    ZPP_GeomVert.zpp_pool = _loc_36.next;
                    _loc_36.next = null;
                }
                _loc_36.forced = false;
                _loc_36.x = _loc_20.posx;
                _loc_36.y = _loc_20.posy;
                _loc_35 = _loc_36;
                if (_loc_19.positive == _loc_20.positive)
                {
                    _loc_36 = _loc_35;
                    if (_loc_33 == null)
                    {
                        _loc_37 = _loc_36;
                        _loc_36.next = _loc_37;
                        _loc_37 = _loc_37;
                        _loc_36.prev = _loc_37;
                        _loc_33 = _loc_37;
                    }
                    else
                    {
                        _loc_36.next = _loc_33;
                        _loc_36.prev = _loc_33.prev;
                        _loc_33.prev.next = _loc_36;
                        _loc_33.prev = _loc_36;
                    }
                }
                else
                {
                    _loc_23 = 0;
                    _loc_24 = 0;
                    _loc_23 = _loc_20.posx - _loc_19.posx;
                    _loc_24 = _loc_20.posy - _loc_19.posy;
                    _loc_25 = _loc_11 * _loc_23 - _loc_10 * _loc_24;
                    _loc_25 = 1 / _loc_25;
                    _loc_26 = 0;
                    _loc_28 = 0;
                    _loc_26 = _loc_7 - _loc_19.posx;
                    _loc_28 = _loc_8 - _loc_19.posy;
                    _loc_30 = (_loc_24 * _loc_26 - _loc_23 * _loc_28) * _loc_25;
                    if (_loc_30 >= _loc_12)
                    {
                    }
                    if (_loc_30 > _loc_13)
                    {
                        _loc_29 = false;
                        if (ZPP_CutInt.zpp_pool == null)
                        {
                            _loc_41 = new ZPP_CutInt();
                        }
                        else
                        {
                            _loc_41 = ZPP_CutInt.zpp_pool;
                            ZPP_CutInt.zpp_pool = _loc_41.next;
                            _loc_41.next = null;
                        }
                        _loc_41.virtualint = true;
                        _loc_41.end = null;
                        _loc_41.start = null;
                        _loc_41.path0 = null;
                        _loc_41.path1 = null;
                        _loc_41.time = _loc_30;
                        _loc_41.vertex = _loc_29;
                        ZPP_Cutter.ints.add(_loc_41);
                        _loc_36 = _loc_35;
                        if (_loc_33 == null)
                        {
                            _loc_37 = _loc_36;
                            _loc_36.next = _loc_37;
                            _loc_37 = _loc_37;
                            _loc_36.prev = _loc_37;
                            _loc_33 = _loc_37;
                        }
                        else
                        {
                            _loc_36.next = _loc_33;
                            _loc_36.prev = _loc_33.prev;
                            _loc_33.prev.next = _loc_36;
                            _loc_33.prev = _loc_36;
                        }
                    }
                    else if (_loc_19.value == 0)
                    {
                        _loc_36 = _loc_33.prev;
                        _loc_33 = null;
                        if (ZPP_GeomVert.zpp_pool == null)
                        {
                            _loc_42 = new ZPP_GeomVert();
                        }
                        else
                        {
                            _loc_42 = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_42.next;
                            _loc_42.next = null;
                        }
                        _loc_42.forced = false;
                        _loc_42.x = _loc_36.x;
                        _loc_42.y = _loc_36.y;
                        _loc_37 = _loc_42;
                        if (_loc_33 == null)
                        {
                            _loc_42 = _loc_37;
                            _loc_37.next = _loc_42;
                            _loc_42 = _loc_42;
                            _loc_37.prev = _loc_42;
                            _loc_33 = _loc_42;
                        }
                        else
                        {
                            _loc_37.next = _loc_33;
                            _loc_37.prev = _loc_33.prev;
                            _loc_33.prev.next = _loc_37;
                            _loc_33.prev = _loc_37;
                        }
                        _loc_37 = _loc_35;
                        if (_loc_33 == null)
                        {
                            _loc_42 = _loc_37;
                            _loc_37.next = _loc_42;
                            _loc_42 = _loc_42;
                            _loc_37.prev = _loc_42;
                            _loc_33 = _loc_42;
                        }
                        else
                        {
                            _loc_37.next = _loc_33;
                            _loc_37.prev = _loc_33.prev;
                            _loc_33.prev.next = _loc_37;
                            _loc_33.prev = _loc_37;
                        }
                        _loc_21 = ZPP_Cutter.paths.head.elt;
                        if (ZPP_CutVert.zpp_pool == null)
                        {
                            _loc_22 = new ZPP_CutVert();
                        }
                        else
                        {
                            _loc_22 = ZPP_CutVert.zpp_pool;
                            ZPP_CutVert.zpp_pool = _loc_22.next;
                            _loc_22.next = null;
                        }
                        _loc_22.vert = _loc_33;
                        _loc_22.parent = _loc_22;
                        _loc_22.rank = 0;
                        _loc_22.used = false;
                        ZPP_Cutter.paths.add(_loc_22);
                        _loc_22 = ZPP_Cutter.paths.head.elt;
                        _loc_29 = false;
                        if (ZPP_CutInt.zpp_pool == null)
                        {
                            _loc_41 = new ZPP_CutInt();
                        }
                        else
                        {
                            _loc_41 = ZPP_CutInt.zpp_pool;
                            ZPP_CutInt.zpp_pool = _loc_41.next;
                            _loc_41.next = null;
                        }
                        _loc_41.virtualint = true;
                        _loc_41.end = _loc_36;
                        _loc_41.start = _loc_33;
                        _loc_41.path0 = _loc_21;
                        _loc_41.path1 = _loc_22;
                        _loc_41.time = _loc_30;
                        _loc_41.vertex = _loc_29;
                        ZPP_Cutter.ints.add(_loc_41);
                    }
                    else if (_loc_20.value == 0)
                    {
                        _loc_36 = _loc_35;
                        if (_loc_33 == null)
                        {
                            _loc_37 = _loc_36;
                            _loc_36.next = _loc_37;
                            _loc_37 = _loc_37;
                            _loc_36.prev = _loc_37;
                            _loc_33 = _loc_37;
                        }
                        else
                        {
                            _loc_36.next = _loc_33;
                            _loc_36.prev = _loc_33.prev;
                            _loc_33.prev.next = _loc_36;
                            _loc_33.prev = _loc_36;
                        }
                        _loc_36 = _loc_33.prev;
                        _loc_33 = null;
                        if (ZPP_GeomVert.zpp_pool == null)
                        {
                            _loc_42 = new ZPP_GeomVert();
                        }
                        else
                        {
                            _loc_42 = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_42.next;
                            _loc_42.next = null;
                        }
                        _loc_42.forced = false;
                        _loc_42.x = _loc_20.posx;
                        _loc_42.y = _loc_20.posy;
                        _loc_37 = _loc_42;
                        if (_loc_33 == null)
                        {
                            _loc_42 = _loc_37;
                            _loc_37.next = _loc_42;
                            _loc_42 = _loc_42;
                            _loc_37.prev = _loc_42;
                            _loc_33 = _loc_42;
                        }
                        else
                        {
                            _loc_37.next = _loc_33;
                            _loc_37.prev = _loc_33.prev;
                            _loc_33.prev.next = _loc_37;
                            _loc_33.prev = _loc_37;
                        }
                        _loc_21 = ZPP_Cutter.paths.head.elt;
                        if (ZPP_CutVert.zpp_pool == null)
                        {
                            _loc_22 = new ZPP_CutVert();
                        }
                        else
                        {
                            _loc_22 = ZPP_CutVert.zpp_pool;
                            ZPP_CutVert.zpp_pool = _loc_22.next;
                            _loc_22.next = null;
                        }
                        _loc_22.vert = _loc_33;
                        _loc_22.parent = _loc_22;
                        _loc_22.rank = 0;
                        _loc_22.used = false;
                        ZPP_Cutter.paths.add(_loc_22);
                        _loc_22 = ZPP_Cutter.paths.head.elt;
                        _loc_29 = false;
                        if (ZPP_CutInt.zpp_pool == null)
                        {
                            _loc_41 = new ZPP_CutInt();
                        }
                        else
                        {
                            _loc_41 = ZPP_CutInt.zpp_pool;
                            ZPP_CutInt.zpp_pool = _loc_41.next;
                            _loc_41.next = null;
                        }
                        _loc_41.virtualint = true;
                        _loc_41.end = _loc_36;
                        _loc_41.start = _loc_33;
                        _loc_41.path0 = _loc_21;
                        _loc_41.path1 = _loc_22;
                        _loc_41.time = _loc_30;
                        _loc_41.vertex = _loc_29;
                        ZPP_Cutter.ints.add(_loc_41);
                    }
                    else
                    {
                        _loc_31 = (_loc_11 * _loc_26 - _loc_10 * _loc_28) * _loc_25;
                        _loc_43 = 0;
                        _loc_44 = 0;
                        _loc_43 = _loc_19.posx;
                        _loc_44 = _loc_19.posy;
                        _loc_45 = _loc_31;
                        _loc_43 = _loc_43 + _loc_23 * _loc_45;
                        _loc_44 = _loc_44 + _loc_24 * _loc_45;
                        if (ZPP_GeomVert.zpp_pool == null)
                        {
                            _loc_37 = new ZPP_GeomVert();
                        }
                        else
                        {
                            _loc_37 = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_37.next;
                            _loc_37.next = null;
                        }
                        _loc_37.forced = false;
                        _loc_37.x = _loc_43;
                        _loc_37.y = _loc_44;
                        _loc_36 = _loc_37;
                        if (_loc_33 == null)
                        {
                            _loc_37 = _loc_36;
                            _loc_36.next = _loc_37;
                            _loc_37 = _loc_37;
                            _loc_36.prev = _loc_37;
                            _loc_33 = _loc_37;
                        }
                        else
                        {
                            _loc_36.next = _loc_33;
                            _loc_36.prev = _loc_33.prev;
                            _loc_33.prev.next = _loc_36;
                            _loc_33.prev = _loc_36;
                        }
                        _loc_36 = _loc_33.prev;
                        _loc_33 = null;
                        if (ZPP_GeomVert.zpp_pool == null)
                        {
                            _loc_42 = new ZPP_GeomVert();
                        }
                        else
                        {
                            _loc_42 = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_42.next;
                            _loc_42.next = null;
                        }
                        _loc_42.forced = false;
                        _loc_42.x = _loc_43;
                        _loc_42.y = _loc_44;
                        _loc_37 = _loc_42;
                        if (_loc_33 == null)
                        {
                            _loc_42 = _loc_37;
                            _loc_37.next = _loc_42;
                            _loc_42 = _loc_42;
                            _loc_37.prev = _loc_42;
                            _loc_33 = _loc_42;
                        }
                        else
                        {
                            _loc_37.next = _loc_33;
                            _loc_37.prev = _loc_33.prev;
                            _loc_33.prev.next = _loc_37;
                            _loc_33.prev = _loc_37;
                        }
                        _loc_37 = _loc_35;
                        if (_loc_33 == null)
                        {
                            _loc_42 = _loc_37;
                            _loc_37.next = _loc_42;
                            _loc_42 = _loc_42;
                            _loc_37.prev = _loc_42;
                            _loc_33 = _loc_42;
                        }
                        else
                        {
                            _loc_37.next = _loc_33;
                            _loc_37.prev = _loc_33.prev;
                            _loc_33.prev.next = _loc_37;
                            _loc_33.prev = _loc_37;
                        }
                        _loc_21 = ZPP_Cutter.paths.head.elt;
                        if (ZPP_CutVert.zpp_pool == null)
                        {
                            _loc_22 = new ZPP_CutVert();
                        }
                        else
                        {
                            _loc_22 = ZPP_CutVert.zpp_pool;
                            ZPP_CutVert.zpp_pool = _loc_22.next;
                            _loc_22.next = null;
                        }
                        _loc_22.vert = _loc_33;
                        _loc_22.parent = _loc_22;
                        _loc_22.rank = 0;
                        _loc_22.used = false;
                        ZPP_Cutter.paths.add(_loc_22);
                        _loc_22 = ZPP_Cutter.paths.head.elt;
                        _loc_29 = false;
                        if (ZPP_CutInt.zpp_pool == null)
                        {
                            _loc_41 = new ZPP_CutInt();
                        }
                        else
                        {
                            _loc_41 = ZPP_CutInt.zpp_pool;
                            ZPP_CutInt.zpp_pool = _loc_41.next;
                            _loc_41.next = null;
                        }
                        _loc_41.virtualint = false;
                        _loc_41.end = _loc_36;
                        _loc_41.start = _loc_33;
                        _loc_41.path0 = _loc_21;
                        _loc_41.path1 = _loc_22;
                        _loc_41.time = _loc_30;
                        _loc_41.vertex = _loc_29;
                        ZPP_Cutter.ints.add(_loc_41);
                    }
                }
                _loc_19 = _loc_19.next;
            }while (_loc_19 != _loc_15)
            _loc_35 = _loc_33.prev;
            _loc_35.next.prev = _loc_34.prev;
            _loc_34.prev.next = _loc_35.next;
            _loc_35.next = _loc_34;
            _loc_34.prev = _loc_35;
            _loc_20 = ZPP_Cutter.paths.head.elt;
            if (_loc_18 == _loc_18.parent)
            {
                _loc_21 = _loc_18;
            }
            else
            {
                _loc_22 = _loc_18;
                _loc_38 = null;
                while (_loc_22 != _loc_22.parent)
                {
                    
                    _loc_39 = _loc_22.parent;
                    _loc_22.parent = _loc_38;
                    _loc_38 = _loc_22;
                    _loc_22 = _loc_39;
                }
                while (_loc_38 != null)
                {
                    
                    _loc_39 = _loc_38.parent;
                    _loc_38.parent = _loc_22;
                    _loc_38 = _loc_39;
                }
                _loc_21 = _loc_22;
            }
            if (_loc_20 == _loc_20.parent)
            {
                _loc_22 = _loc_20;
            }
            else
            {
                _loc_38 = _loc_20;
                _loc_39 = null;
                while (_loc_38 != _loc_38.parent)
                {
                    
                    _loc_40 = _loc_38.parent;
                    _loc_38.parent = _loc_39;
                    _loc_39 = _loc_38;
                    _loc_38 = _loc_40;
                }
                while (_loc_39 != null)
                {
                    
                    _loc_40 = _loc_39.parent;
                    _loc_39.parent = _loc_38;
                    _loc_39 = _loc_40;
                }
                _loc_22 = _loc_38;
            }
            if (_loc_21 != _loc_22)
            {
                if (_loc_21.rank < _loc_22.rank)
                {
                    _loc_21.parent = _loc_22;
                }
                else if (_loc_21.rank > _loc_22.rank)
                {
                    _loc_22.parent = _loc_21;
                }
                else
                {
                    _loc_22.parent = _loc_21;
                    (_loc_21.rank + 1);
                }
            }
            var _loc_46:* = ZPP_Cutter.ints;
            if (_loc_46.head != null)
            {
            }
            if (_loc_46.head.next != null)
            {
                _loc_47 = _loc_46.head;
                _loc_48 = null;
                _loc_49 = null;
                _loc_50 = null;
                _loc_51 = null;
                _loc_27 = 1;
                do
                {
                    
                    _loc_52 = 0;
                    _loc_49 = _loc_47;
                    _loc_47 = null;
                    _loc_48 = _loc_47;
                    while (_loc_49 != null)
                    {
                        
                        _loc_52++;
                        _loc_50 = _loc_49;
                        _loc_53 = 0;
                        _loc_54 = _loc_27;
                        do
                        {
                            
                            _loc_53++;
                            _loc_50 = _loc_50.next;
                            if (_loc_50 != null)
                            {
                            }
                        }while (_loc_53 < _loc_27)
                        do
                        {
                            
                            if (_loc_53 == 0)
                            {
                                _loc_51 = _loc_50;
                                _loc_50 = _loc_50.next;
                                _loc_54--;
                            }
                            else
                            {
                                if (_loc_54 != 0)
                                {
                                }
                                if (_loc_50 == null)
                                {
                                    _loc_51 = _loc_49;
                                    _loc_49 = _loc_49.next;
                                    _loc_53--;
                                }
                                else if (_loc_49.elt.time < _loc_50.elt.time)
                                {
                                    _loc_51 = _loc_49;
                                    _loc_49 = _loc_49.next;
                                    _loc_53--;
                                }
                                else
                                {
                                    _loc_51 = _loc_50;
                                    _loc_50 = _loc_50.next;
                                    _loc_54--;
                                }
                            }
                            if (_loc_48 != null)
                            {
                                _loc_48.next = _loc_51;
                            }
                            else
                            {
                                _loc_47 = _loc_51;
                            }
                            _loc_48 = _loc_51;
                            if (_loc_53 <= 0)
                            {
                                if (_loc_54 > 0)
                                {
                                }
                            }
                        }while (_loc_50 != null)
                        _loc_49 = _loc_50;
                    }
                    _loc_48.next = null;
                    _loc_27 = _loc_27 << 1;
                }while (_loc_52 > 1)
                _loc_46.head = _loc_47;
                _loc_46.modified = true;
                _loc_46.pushmod = true;
            }
            while (ZPP_Cutter.ints.head != null)
            {
                
                _loc_41 = ZPP_Cutter.ints.pop_unsafe();
                _loc_55 = ZPP_Cutter.ints.pop_unsafe();
                if (!_loc_41.virtualint)
                {
                }
                if (!_loc_55.virtualint)
                {
                    _loc_41.end.next.prev = _loc_55.start.prev;
                    _loc_55.start.prev.next = _loc_41.end.next;
                    _loc_41.end.next = _loc_55.start;
                    _loc_55.start.prev = _loc_41.end;
                    _loc_55.end.next.prev = _loc_41.start.prev;
                    _loc_41.start.prev.next = _loc_55.end.next;
                    _loc_55.end.next = _loc_41.start;
                    _loc_41.start.prev = _loc_55.end;
                    if (_loc_41.path0 == _loc_41.path0.parent)
                    {
                        _loc_21 = _loc_41.path0;
                    }
                    else
                    {
                        _loc_22 = _loc_41.path0;
                        _loc_38 = null;
                        while (_loc_22 != _loc_22.parent)
                        {
                            
                            _loc_39 = _loc_22.parent;
                            _loc_22.parent = _loc_38;
                            _loc_38 = _loc_22;
                            _loc_22 = _loc_39;
                        }
                        while (_loc_38 != null)
                        {
                            
                            _loc_39 = _loc_38.parent;
                            _loc_38.parent = _loc_22;
                            _loc_38 = _loc_39;
                        }
                        _loc_21 = _loc_22;
                    }
                    if (_loc_55.path1 == _loc_55.path1.parent)
                    {
                        _loc_22 = _loc_55.path1;
                    }
                    else
                    {
                        _loc_38 = _loc_55.path1;
                        _loc_39 = null;
                        while (_loc_38 != _loc_38.parent)
                        {
                            
                            _loc_40 = _loc_38.parent;
                            _loc_38.parent = _loc_39;
                            _loc_39 = _loc_38;
                            _loc_38 = _loc_40;
                        }
                        while (_loc_39 != null)
                        {
                            
                            _loc_40 = _loc_39.parent;
                            _loc_39.parent = _loc_38;
                            _loc_39 = _loc_40;
                        }
                        _loc_22 = _loc_38;
                    }
                    if (_loc_21 != _loc_22)
                    {
                        if (_loc_21.rank < _loc_22.rank)
                        {
                            _loc_21.parent = _loc_22;
                        }
                        else if (_loc_21.rank > _loc_22.rank)
                        {
                            _loc_22.parent = _loc_21;
                        }
                        else
                        {
                            _loc_22.parent = _loc_21;
                            (_loc_21.rank + 1);
                        }
                    }
                    if (_loc_41.path1 == _loc_41.path1.parent)
                    {
                        _loc_21 = _loc_41.path1;
                    }
                    else
                    {
                        _loc_22 = _loc_41.path1;
                        _loc_38 = null;
                        while (_loc_22 != _loc_22.parent)
                        {
                            
                            _loc_39 = _loc_22.parent;
                            _loc_22.parent = _loc_38;
                            _loc_38 = _loc_22;
                            _loc_22 = _loc_39;
                        }
                        while (_loc_38 != null)
                        {
                            
                            _loc_39 = _loc_38.parent;
                            _loc_38.parent = _loc_22;
                            _loc_38 = _loc_39;
                        }
                        _loc_21 = _loc_22;
                    }
                    if (_loc_55.path0 == _loc_55.path0.parent)
                    {
                        _loc_22 = _loc_55.path0;
                    }
                    else
                    {
                        _loc_38 = _loc_55.path0;
                        _loc_39 = null;
                        while (_loc_38 != _loc_38.parent)
                        {
                            
                            _loc_40 = _loc_38.parent;
                            _loc_38.parent = _loc_39;
                            _loc_39 = _loc_38;
                            _loc_38 = _loc_40;
                        }
                        while (_loc_39 != null)
                        {
                            
                            _loc_40 = _loc_39.parent;
                            _loc_39.parent = _loc_38;
                            _loc_39 = _loc_40;
                        }
                        _loc_22 = _loc_38;
                    }
                    if (_loc_21 != _loc_22)
                    {
                        if (_loc_21.rank < _loc_22.rank)
                        {
                            _loc_21.parent = _loc_22;
                        }
                        else if (_loc_21.rank > _loc_22.rank)
                        {
                            _loc_22.parent = _loc_21;
                        }
                        else
                        {
                            _loc_22.parent = _loc_21;
                            (_loc_21.rank + 1);
                        }
                    }
                }
                else
                {
                    if (_loc_41.virtualint)
                    {
                    }
                    if (!_loc_55.virtualint)
                    {
                        if (_loc_55.end != null)
                        {
                        }
                        if (_loc_55.end.prev == _loc_55.end)
                        {
                            _loc_36 = null;
                            _loc_55.end.prev = _loc_36;
                            _loc_55.end.next = _loc_36;
                            _loc_36 = _loc_55.end;
                            if (_loc_36.wrap != null)
                            {
                                _loc_36.wrap.zpp_inner._inuse = false;
                                _loc_56 = _loc_36.wrap;
                                if (_loc_56 != null)
                                {
                                }
                                if (_loc_56.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_9 = _loc_56.zpp_inner;
                                if (_loc_9._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_9._isimmutable != null)
                                {
                                    _loc_9._isimmutable();
                                }
                                if (_loc_56.zpp_inner._inuse)
                                {
                                    throw "Error: This Vec2 is not disposable";
                                }
                                _loc_9 = _loc_56.zpp_inner;
                                _loc_56.zpp_inner.outer = null;
                                _loc_56.zpp_inner = null;
                                _loc_57 = _loc_56;
                                _loc_57.zpp_pool = null;
                                if (ZPP_PubPool.nextVec2 != null)
                                {
                                    ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                }
                                else
                                {
                                    ZPP_PubPool.poolVec2 = _loc_57;
                                }
                                ZPP_PubPool.nextVec2 = _loc_57;
                                _loc_57.zpp_disp = true;
                                _loc_58 = _loc_9;
                                if (_loc_58.outer != null)
                                {
                                    _loc_58.outer.zpp_inner = null;
                                    _loc_58.outer = null;
                                }
                                _loc_58._isimmutable = null;
                                _loc_58._validate = null;
                                _loc_58._invalidate = null;
                                _loc_58.next = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_58;
                                _loc_36.wrap = null;
                            }
                            _loc_37 = null;
                            _loc_36.next = _loc_37;
                            _loc_36.prev = _loc_37;
                            _loc_36.next = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_36;
                            _loc_55.end = null;
                        }
                        else
                        {
                            _loc_36 = _loc_55.end.prev;
                            _loc_55.end.prev.next = _loc_55.end.next;
                            _loc_55.end.next.prev = _loc_55.end.prev;
                            _loc_37 = null;
                            _loc_55.end.prev = _loc_37;
                            _loc_55.end.next = _loc_37;
                            _loc_37 = _loc_55.end;
                            if (_loc_37.wrap != null)
                            {
                                _loc_37.wrap.zpp_inner._inuse = false;
                                _loc_56 = _loc_37.wrap;
                                if (_loc_56 != null)
                                {
                                }
                                if (_loc_56.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_9 = _loc_56.zpp_inner;
                                if (_loc_9._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_9._isimmutable != null)
                                {
                                    _loc_9._isimmutable();
                                }
                                if (_loc_56.zpp_inner._inuse)
                                {
                                    throw "Error: This Vec2 is not disposable";
                                }
                                _loc_9 = _loc_56.zpp_inner;
                                _loc_56.zpp_inner.outer = null;
                                _loc_56.zpp_inner = null;
                                _loc_57 = _loc_56;
                                _loc_57.zpp_pool = null;
                                if (ZPP_PubPool.nextVec2 != null)
                                {
                                    ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                }
                                else
                                {
                                    ZPP_PubPool.poolVec2 = _loc_57;
                                }
                                ZPP_PubPool.nextVec2 = _loc_57;
                                _loc_57.zpp_disp = true;
                                _loc_58 = _loc_9;
                                if (_loc_58.outer != null)
                                {
                                    _loc_58.outer.zpp_inner = null;
                                    _loc_58.outer = null;
                                }
                                _loc_58._isimmutable = null;
                                _loc_58._validate = null;
                                _loc_58._invalidate = null;
                                _loc_58.next = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_58;
                                _loc_37.wrap = null;
                            }
                            _loc_42 = null;
                            _loc_37.next = _loc_42;
                            _loc_37.prev = _loc_42;
                            _loc_37.next = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_37;
                            _loc_55.end = null;
                            _loc_55.end = _loc_36;
                        }
                        if (!_loc_55.vertex)
                        {
                            if (_loc_55.end != _loc_55.path0.vert)
                            {
                                _loc_55.start.x = _loc_55.end.x;
                                _loc_55.start.y = _loc_55.end.y;
                                if (_loc_55.end != null)
                                {
                                }
                                if (_loc_55.end.prev == _loc_55.end)
                                {
                                    _loc_36 = null;
                                    _loc_55.end.prev = _loc_36;
                                    _loc_55.end.next = _loc_36;
                                    _loc_36 = _loc_55.end;
                                    if (_loc_36.wrap != null)
                                    {
                                        _loc_36.wrap.zpp_inner._inuse = false;
                                        _loc_56 = _loc_36.wrap;
                                        if (_loc_56 != null)
                                        {
                                        }
                                        if (_loc_56.zpp_disp)
                                        {
                                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                        }
                                        _loc_9 = _loc_56.zpp_inner;
                                        if (_loc_9._immutable)
                                        {
                                            throw "Error: Vec2 is immutable";
                                        }
                                        if (_loc_9._isimmutable != null)
                                        {
                                            _loc_9._isimmutable();
                                        }
                                        if (_loc_56.zpp_inner._inuse)
                                        {
                                            throw "Error: This Vec2 is not disposable";
                                        }
                                        _loc_9 = _loc_56.zpp_inner;
                                        _loc_56.zpp_inner.outer = null;
                                        _loc_56.zpp_inner = null;
                                        _loc_57 = _loc_56;
                                        _loc_57.zpp_pool = null;
                                        if (ZPP_PubPool.nextVec2 != null)
                                        {
                                            ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                        }
                                        else
                                        {
                                            ZPP_PubPool.poolVec2 = _loc_57;
                                        }
                                        ZPP_PubPool.nextVec2 = _loc_57;
                                        _loc_57.zpp_disp = true;
                                        _loc_58 = _loc_9;
                                        if (_loc_58.outer != null)
                                        {
                                            _loc_58.outer.zpp_inner = null;
                                            _loc_58.outer = null;
                                        }
                                        _loc_58._isimmutable = null;
                                        _loc_58._validate = null;
                                        _loc_58._invalidate = null;
                                        _loc_58.next = ZPP_Vec2.zpp_pool;
                                        ZPP_Vec2.zpp_pool = _loc_58;
                                        _loc_36.wrap = null;
                                    }
                                    _loc_37 = null;
                                    _loc_36.next = _loc_37;
                                    _loc_36.prev = _loc_37;
                                    _loc_36.next = ZPP_GeomVert.zpp_pool;
                                    ZPP_GeomVert.zpp_pool = _loc_36;
                                    _loc_55.end = null;
                                }
                                else
                                {
                                    _loc_36 = _loc_55.end.prev;
                                    _loc_55.end.prev.next = _loc_55.end.next;
                                    _loc_55.end.next.prev = _loc_55.end.prev;
                                    _loc_37 = null;
                                    _loc_55.end.prev = _loc_37;
                                    _loc_55.end.next = _loc_37;
                                    _loc_37 = _loc_55.end;
                                    if (_loc_37.wrap != null)
                                    {
                                        _loc_37.wrap.zpp_inner._inuse = false;
                                        _loc_56 = _loc_37.wrap;
                                        if (_loc_56 != null)
                                        {
                                        }
                                        if (_loc_56.zpp_disp)
                                        {
                                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                        }
                                        _loc_9 = _loc_56.zpp_inner;
                                        if (_loc_9._immutable)
                                        {
                                            throw "Error: Vec2 is immutable";
                                        }
                                        if (_loc_9._isimmutable != null)
                                        {
                                            _loc_9._isimmutable();
                                        }
                                        if (_loc_56.zpp_inner._inuse)
                                        {
                                            throw "Error: This Vec2 is not disposable";
                                        }
                                        _loc_9 = _loc_56.zpp_inner;
                                        _loc_56.zpp_inner.outer = null;
                                        _loc_56.zpp_inner = null;
                                        _loc_57 = _loc_56;
                                        _loc_57.zpp_pool = null;
                                        if (ZPP_PubPool.nextVec2 != null)
                                        {
                                            ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                        }
                                        else
                                        {
                                            ZPP_PubPool.poolVec2 = _loc_57;
                                        }
                                        ZPP_PubPool.nextVec2 = _loc_57;
                                        _loc_57.zpp_disp = true;
                                        _loc_58 = _loc_9;
                                        if (_loc_58.outer != null)
                                        {
                                            _loc_58.outer.zpp_inner = null;
                                            _loc_58.outer = null;
                                        }
                                        _loc_58._isimmutable = null;
                                        _loc_58._validate = null;
                                        _loc_58._invalidate = null;
                                        _loc_58.next = ZPP_Vec2.zpp_pool;
                                        ZPP_Vec2.zpp_pool = _loc_58;
                                        _loc_37.wrap = null;
                                    }
                                    _loc_42 = null;
                                    _loc_37.next = _loc_42;
                                    _loc_37.prev = _loc_42;
                                    _loc_37.next = ZPP_GeomVert.zpp_pool;
                                    ZPP_GeomVert.zpp_pool = _loc_37;
                                    _loc_55.end = null;
                                    _loc_55.end = _loc_36;
                                }
                            }
                            else
                            {
                                _loc_36 = _loc_55.start.next;
                                _loc_55.start.x = _loc_36.x;
                                _loc_55.start.y = _loc_36.y;
                                if (_loc_36 != null)
                                {
                                }
                                if (_loc_36.prev == _loc_36)
                                {
                                    _loc_37 = null;
                                    _loc_36.prev = _loc_37;
                                    _loc_36.next = _loc_37;
                                    _loc_37 = _loc_36;
                                    if (_loc_37.wrap != null)
                                    {
                                        _loc_37.wrap.zpp_inner._inuse = false;
                                        _loc_56 = _loc_37.wrap;
                                        if (_loc_56 != null)
                                        {
                                        }
                                        if (_loc_56.zpp_disp)
                                        {
                                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                        }
                                        _loc_9 = _loc_56.zpp_inner;
                                        if (_loc_9._immutable)
                                        {
                                            throw "Error: Vec2 is immutable";
                                        }
                                        if (_loc_9._isimmutable != null)
                                        {
                                            _loc_9._isimmutable();
                                        }
                                        if (_loc_56.zpp_inner._inuse)
                                        {
                                            throw "Error: This Vec2 is not disposable";
                                        }
                                        _loc_9 = _loc_56.zpp_inner;
                                        _loc_56.zpp_inner.outer = null;
                                        _loc_56.zpp_inner = null;
                                        _loc_57 = _loc_56;
                                        _loc_57.zpp_pool = null;
                                        if (ZPP_PubPool.nextVec2 != null)
                                        {
                                            ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                        }
                                        else
                                        {
                                            ZPP_PubPool.poolVec2 = _loc_57;
                                        }
                                        ZPP_PubPool.nextVec2 = _loc_57;
                                        _loc_57.zpp_disp = true;
                                        _loc_58 = _loc_9;
                                        if (_loc_58.outer != null)
                                        {
                                            _loc_58.outer.zpp_inner = null;
                                            _loc_58.outer = null;
                                        }
                                        _loc_58._isimmutable = null;
                                        _loc_58._validate = null;
                                        _loc_58._invalidate = null;
                                        _loc_58.next = ZPP_Vec2.zpp_pool;
                                        ZPP_Vec2.zpp_pool = _loc_58;
                                        _loc_37.wrap = null;
                                    }
                                    _loc_42 = null;
                                    _loc_37.next = _loc_42;
                                    _loc_37.prev = _loc_42;
                                    _loc_37.next = ZPP_GeomVert.zpp_pool;
                                    ZPP_GeomVert.zpp_pool = _loc_37;
                                    _loc_36 = null;
                                }
                                else
                                {
                                    _loc_36.prev.next = _loc_36.next;
                                    _loc_36.next.prev = _loc_36.prev;
                                    _loc_37 = null;
                                    _loc_36.prev = _loc_37;
                                    _loc_36.next = _loc_37;
                                    _loc_37 = _loc_36;
                                    if (_loc_37.wrap != null)
                                    {
                                        _loc_37.wrap.zpp_inner._inuse = false;
                                        _loc_56 = _loc_37.wrap;
                                        if (_loc_56 != null)
                                        {
                                        }
                                        if (_loc_56.zpp_disp)
                                        {
                                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                        }
                                        _loc_9 = _loc_56.zpp_inner;
                                        if (_loc_9._immutable)
                                        {
                                            throw "Error: Vec2 is immutable";
                                        }
                                        if (_loc_9._isimmutable != null)
                                        {
                                            _loc_9._isimmutable();
                                        }
                                        if (_loc_56.zpp_inner._inuse)
                                        {
                                            throw "Error: This Vec2 is not disposable";
                                        }
                                        _loc_9 = _loc_56.zpp_inner;
                                        _loc_56.zpp_inner.outer = null;
                                        _loc_56.zpp_inner = null;
                                        _loc_57 = _loc_56;
                                        _loc_57.zpp_pool = null;
                                        if (ZPP_PubPool.nextVec2 != null)
                                        {
                                            ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                        }
                                        else
                                        {
                                            ZPP_PubPool.poolVec2 = _loc_57;
                                        }
                                        ZPP_PubPool.nextVec2 = _loc_57;
                                        _loc_57.zpp_disp = true;
                                        _loc_58 = _loc_9;
                                        if (_loc_58.outer != null)
                                        {
                                            _loc_58.outer.zpp_inner = null;
                                            _loc_58.outer = null;
                                        }
                                        _loc_58._isimmutable = null;
                                        _loc_58._validate = null;
                                        _loc_58._invalidate = null;
                                        _loc_58.next = ZPP_Vec2.zpp_pool;
                                        ZPP_Vec2.zpp_pool = _loc_58;
                                        _loc_37.wrap = null;
                                    }
                                    _loc_42 = null;
                                    _loc_37.next = _loc_42;
                                    _loc_37.prev = _loc_42;
                                    _loc_37.next = ZPP_GeomVert.zpp_pool;
                                    ZPP_GeomVert.zpp_pool = _loc_37;
                                }
                            }
                        }
                        _loc_55.end.next.prev = _loc_55.start.prev;
                        _loc_55.start.prev.next = _loc_55.end.next;
                        _loc_55.end.next = _loc_55.start;
                        _loc_55.start.prev = _loc_55.end;
                        if (_loc_55.path0 == _loc_55.path0.parent)
                        {
                            _loc_21 = _loc_55.path0;
                        }
                        else
                        {
                            _loc_22 = _loc_55.path0;
                            _loc_38 = null;
                            while (_loc_22 != _loc_22.parent)
                            {
                                
                                _loc_39 = _loc_22.parent;
                                _loc_22.parent = _loc_38;
                                _loc_38 = _loc_22;
                                _loc_22 = _loc_39;
                            }
                            while (_loc_38 != null)
                            {
                                
                                _loc_39 = _loc_38.parent;
                                _loc_38.parent = _loc_22;
                                _loc_38 = _loc_39;
                            }
                            _loc_21 = _loc_22;
                        }
                        if (_loc_55.path1 == _loc_55.path1.parent)
                        {
                            _loc_22 = _loc_55.path1;
                        }
                        else
                        {
                            _loc_38 = _loc_55.path1;
                            _loc_39 = null;
                            while (_loc_38 != _loc_38.parent)
                            {
                                
                                _loc_40 = _loc_38.parent;
                                _loc_38.parent = _loc_39;
                                _loc_39 = _loc_38;
                                _loc_38 = _loc_40;
                            }
                            while (_loc_39 != null)
                            {
                                
                                _loc_40 = _loc_39.parent;
                                _loc_39.parent = _loc_38;
                                _loc_39 = _loc_40;
                            }
                            _loc_22 = _loc_38;
                        }
                        if (_loc_21 != _loc_22)
                        {
                            if (_loc_21.rank < _loc_22.rank)
                            {
                                _loc_21.parent = _loc_22;
                            }
                            else if (_loc_21.rank > _loc_22.rank)
                            {
                                _loc_22.parent = _loc_21;
                            }
                            else
                            {
                                _loc_22.parent = _loc_21;
                                (_loc_21.rank + 1);
                            }
                        }
                    }
                    else
                    {
                        if (_loc_55.virtualint)
                        {
                        }
                        if (!_loc_41.virtualint)
                        {
                            if (_loc_41.end != null)
                            {
                            }
                            if (_loc_41.end.prev == _loc_41.end)
                            {
                                _loc_36 = null;
                                _loc_41.end.prev = _loc_36;
                                _loc_41.end.next = _loc_36;
                                _loc_36 = _loc_41.end;
                                if (_loc_36.wrap != null)
                                {
                                    _loc_36.wrap.zpp_inner._inuse = false;
                                    _loc_56 = _loc_36.wrap;
                                    if (_loc_56 != null)
                                    {
                                    }
                                    if (_loc_56.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_9 = _loc_56.zpp_inner;
                                    if (_loc_9._immutable)
                                    {
                                        throw "Error: Vec2 is immutable";
                                    }
                                    if (_loc_9._isimmutable != null)
                                    {
                                        _loc_9._isimmutable();
                                    }
                                    if (_loc_56.zpp_inner._inuse)
                                    {
                                        throw "Error: This Vec2 is not disposable";
                                    }
                                    _loc_9 = _loc_56.zpp_inner;
                                    _loc_56.zpp_inner.outer = null;
                                    _loc_56.zpp_inner = null;
                                    _loc_57 = _loc_56;
                                    _loc_57.zpp_pool = null;
                                    if (ZPP_PubPool.nextVec2 != null)
                                    {
                                        ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                    }
                                    else
                                    {
                                        ZPP_PubPool.poolVec2 = _loc_57;
                                    }
                                    ZPP_PubPool.nextVec2 = _loc_57;
                                    _loc_57.zpp_disp = true;
                                    _loc_58 = _loc_9;
                                    if (_loc_58.outer != null)
                                    {
                                        _loc_58.outer.zpp_inner = null;
                                        _loc_58.outer = null;
                                    }
                                    _loc_58._isimmutable = null;
                                    _loc_58._validate = null;
                                    _loc_58._invalidate = null;
                                    _loc_58.next = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_58;
                                    _loc_36.wrap = null;
                                }
                                _loc_37 = null;
                                _loc_36.next = _loc_37;
                                _loc_36.prev = _loc_37;
                                _loc_36.next = ZPP_GeomVert.zpp_pool;
                                ZPP_GeomVert.zpp_pool = _loc_36;
                                _loc_41.end = null;
                            }
                            else
                            {
                                _loc_36 = _loc_41.end.prev;
                                _loc_41.end.prev.next = _loc_41.end.next;
                                _loc_41.end.next.prev = _loc_41.end.prev;
                                _loc_37 = null;
                                _loc_41.end.prev = _loc_37;
                                _loc_41.end.next = _loc_37;
                                _loc_37 = _loc_41.end;
                                if (_loc_37.wrap != null)
                                {
                                    _loc_37.wrap.zpp_inner._inuse = false;
                                    _loc_56 = _loc_37.wrap;
                                    if (_loc_56 != null)
                                    {
                                    }
                                    if (_loc_56.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_9 = _loc_56.zpp_inner;
                                    if (_loc_9._immutable)
                                    {
                                        throw "Error: Vec2 is immutable";
                                    }
                                    if (_loc_9._isimmutable != null)
                                    {
                                        _loc_9._isimmutable();
                                    }
                                    if (_loc_56.zpp_inner._inuse)
                                    {
                                        throw "Error: This Vec2 is not disposable";
                                    }
                                    _loc_9 = _loc_56.zpp_inner;
                                    _loc_56.zpp_inner.outer = null;
                                    _loc_56.zpp_inner = null;
                                    _loc_57 = _loc_56;
                                    _loc_57.zpp_pool = null;
                                    if (ZPP_PubPool.nextVec2 != null)
                                    {
                                        ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                    }
                                    else
                                    {
                                        ZPP_PubPool.poolVec2 = _loc_57;
                                    }
                                    ZPP_PubPool.nextVec2 = _loc_57;
                                    _loc_57.zpp_disp = true;
                                    _loc_58 = _loc_9;
                                    if (_loc_58.outer != null)
                                    {
                                        _loc_58.outer.zpp_inner = null;
                                        _loc_58.outer = null;
                                    }
                                    _loc_58._isimmutable = null;
                                    _loc_58._validate = null;
                                    _loc_58._invalidate = null;
                                    _loc_58.next = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_58;
                                    _loc_37.wrap = null;
                                }
                                _loc_42 = null;
                                _loc_37.next = _loc_42;
                                _loc_37.prev = _loc_42;
                                _loc_37.next = ZPP_GeomVert.zpp_pool;
                                ZPP_GeomVert.zpp_pool = _loc_37;
                                _loc_41.end = null;
                                _loc_41.end = _loc_36;
                            }
                            if (!_loc_41.vertex)
                            {
                                if (_loc_41.end != _loc_41.path0.vert)
                                {
                                    _loc_41.start.x = _loc_41.end.x;
                                    _loc_41.start.y = _loc_41.end.y;
                                    if (_loc_41.end != null)
                                    {
                                    }
                                    if (_loc_41.end.prev == _loc_41.end)
                                    {
                                        _loc_36 = null;
                                        _loc_41.end.prev = _loc_36;
                                        _loc_41.end.next = _loc_36;
                                        _loc_36 = _loc_41.end;
                                        if (_loc_36.wrap != null)
                                        {
                                            _loc_36.wrap.zpp_inner._inuse = false;
                                            _loc_56 = _loc_36.wrap;
                                            if (_loc_56 != null)
                                            {
                                            }
                                            if (_loc_56.zpp_disp)
                                            {
                                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                            }
                                            _loc_9 = _loc_56.zpp_inner;
                                            if (_loc_9._immutable)
                                            {
                                                throw "Error: Vec2 is immutable";
                                            }
                                            if (_loc_9._isimmutable != null)
                                            {
                                                _loc_9._isimmutable();
                                            }
                                            if (_loc_56.zpp_inner._inuse)
                                            {
                                                throw "Error: This Vec2 is not disposable";
                                            }
                                            _loc_9 = _loc_56.zpp_inner;
                                            _loc_56.zpp_inner.outer = null;
                                            _loc_56.zpp_inner = null;
                                            _loc_57 = _loc_56;
                                            _loc_57.zpp_pool = null;
                                            if (ZPP_PubPool.nextVec2 != null)
                                            {
                                                ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                            }
                                            else
                                            {
                                                ZPP_PubPool.poolVec2 = _loc_57;
                                            }
                                            ZPP_PubPool.nextVec2 = _loc_57;
                                            _loc_57.zpp_disp = true;
                                            _loc_58 = _loc_9;
                                            if (_loc_58.outer != null)
                                            {
                                                _loc_58.outer.zpp_inner = null;
                                                _loc_58.outer = null;
                                            }
                                            _loc_58._isimmutable = null;
                                            _loc_58._validate = null;
                                            _loc_58._invalidate = null;
                                            _loc_58.next = ZPP_Vec2.zpp_pool;
                                            ZPP_Vec2.zpp_pool = _loc_58;
                                            _loc_36.wrap = null;
                                        }
                                        _loc_37 = null;
                                        _loc_36.next = _loc_37;
                                        _loc_36.prev = _loc_37;
                                        _loc_36.next = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_36;
                                        _loc_41.end = null;
                                    }
                                    else
                                    {
                                        _loc_36 = _loc_41.end.prev;
                                        _loc_41.end.prev.next = _loc_41.end.next;
                                        _loc_41.end.next.prev = _loc_41.end.prev;
                                        _loc_37 = null;
                                        _loc_41.end.prev = _loc_37;
                                        _loc_41.end.next = _loc_37;
                                        _loc_37 = _loc_41.end;
                                        if (_loc_37.wrap != null)
                                        {
                                            _loc_37.wrap.zpp_inner._inuse = false;
                                            _loc_56 = _loc_37.wrap;
                                            if (_loc_56 != null)
                                            {
                                            }
                                            if (_loc_56.zpp_disp)
                                            {
                                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                            }
                                            _loc_9 = _loc_56.zpp_inner;
                                            if (_loc_9._immutable)
                                            {
                                                throw "Error: Vec2 is immutable";
                                            }
                                            if (_loc_9._isimmutable != null)
                                            {
                                                _loc_9._isimmutable();
                                            }
                                            if (_loc_56.zpp_inner._inuse)
                                            {
                                                throw "Error: This Vec2 is not disposable";
                                            }
                                            _loc_9 = _loc_56.zpp_inner;
                                            _loc_56.zpp_inner.outer = null;
                                            _loc_56.zpp_inner = null;
                                            _loc_57 = _loc_56;
                                            _loc_57.zpp_pool = null;
                                            if (ZPP_PubPool.nextVec2 != null)
                                            {
                                                ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                            }
                                            else
                                            {
                                                ZPP_PubPool.poolVec2 = _loc_57;
                                            }
                                            ZPP_PubPool.nextVec2 = _loc_57;
                                            _loc_57.zpp_disp = true;
                                            _loc_58 = _loc_9;
                                            if (_loc_58.outer != null)
                                            {
                                                _loc_58.outer.zpp_inner = null;
                                                _loc_58.outer = null;
                                            }
                                            _loc_58._isimmutable = null;
                                            _loc_58._validate = null;
                                            _loc_58._invalidate = null;
                                            _loc_58.next = ZPP_Vec2.zpp_pool;
                                            ZPP_Vec2.zpp_pool = _loc_58;
                                            _loc_37.wrap = null;
                                        }
                                        _loc_42 = null;
                                        _loc_37.next = _loc_42;
                                        _loc_37.prev = _loc_42;
                                        _loc_37.next = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_37;
                                        _loc_41.end = null;
                                        _loc_41.end = _loc_36;
                                    }
                                }
                                else
                                {
                                    _loc_36 = _loc_41.start.next;
                                    _loc_41.start.x = _loc_36.x;
                                    _loc_41.start.y = _loc_36.y;
                                    if (_loc_36 != null)
                                    {
                                    }
                                    if (_loc_36.prev == _loc_36)
                                    {
                                        _loc_37 = null;
                                        _loc_36.prev = _loc_37;
                                        _loc_36.next = _loc_37;
                                        _loc_37 = _loc_36;
                                        if (_loc_37.wrap != null)
                                        {
                                            _loc_37.wrap.zpp_inner._inuse = false;
                                            _loc_56 = _loc_37.wrap;
                                            if (_loc_56 != null)
                                            {
                                            }
                                            if (_loc_56.zpp_disp)
                                            {
                                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                            }
                                            _loc_9 = _loc_56.zpp_inner;
                                            if (_loc_9._immutable)
                                            {
                                                throw "Error: Vec2 is immutable";
                                            }
                                            if (_loc_9._isimmutable != null)
                                            {
                                                _loc_9._isimmutable();
                                            }
                                            if (_loc_56.zpp_inner._inuse)
                                            {
                                                throw "Error: This Vec2 is not disposable";
                                            }
                                            _loc_9 = _loc_56.zpp_inner;
                                            _loc_56.zpp_inner.outer = null;
                                            _loc_56.zpp_inner = null;
                                            _loc_57 = _loc_56;
                                            _loc_57.zpp_pool = null;
                                            if (ZPP_PubPool.nextVec2 != null)
                                            {
                                                ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                            }
                                            else
                                            {
                                                ZPP_PubPool.poolVec2 = _loc_57;
                                            }
                                            ZPP_PubPool.nextVec2 = _loc_57;
                                            _loc_57.zpp_disp = true;
                                            _loc_58 = _loc_9;
                                            if (_loc_58.outer != null)
                                            {
                                                _loc_58.outer.zpp_inner = null;
                                                _loc_58.outer = null;
                                            }
                                            _loc_58._isimmutable = null;
                                            _loc_58._validate = null;
                                            _loc_58._invalidate = null;
                                            _loc_58.next = ZPP_Vec2.zpp_pool;
                                            ZPP_Vec2.zpp_pool = _loc_58;
                                            _loc_37.wrap = null;
                                        }
                                        _loc_42 = null;
                                        _loc_37.next = _loc_42;
                                        _loc_37.prev = _loc_42;
                                        _loc_37.next = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_37;
                                        _loc_36 = null;
                                    }
                                    else
                                    {
                                        _loc_36.prev.next = _loc_36.next;
                                        _loc_36.next.prev = _loc_36.prev;
                                        _loc_37 = null;
                                        _loc_36.prev = _loc_37;
                                        _loc_36.next = _loc_37;
                                        _loc_37 = _loc_36;
                                        if (_loc_37.wrap != null)
                                        {
                                            _loc_37.wrap.zpp_inner._inuse = false;
                                            _loc_56 = _loc_37.wrap;
                                            if (_loc_56 != null)
                                            {
                                            }
                                            if (_loc_56.zpp_disp)
                                            {
                                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                            }
                                            _loc_9 = _loc_56.zpp_inner;
                                            if (_loc_9._immutable)
                                            {
                                                throw "Error: Vec2 is immutable";
                                            }
                                            if (_loc_9._isimmutable != null)
                                            {
                                                _loc_9._isimmutable();
                                            }
                                            if (_loc_56.zpp_inner._inuse)
                                            {
                                                throw "Error: This Vec2 is not disposable";
                                            }
                                            _loc_9 = _loc_56.zpp_inner;
                                            _loc_56.zpp_inner.outer = null;
                                            _loc_56.zpp_inner = null;
                                            _loc_57 = _loc_56;
                                            _loc_57.zpp_pool = null;
                                            if (ZPP_PubPool.nextVec2 != null)
                                            {
                                                ZPP_PubPool.nextVec2.zpp_pool = _loc_57;
                                            }
                                            else
                                            {
                                                ZPP_PubPool.poolVec2 = _loc_57;
                                            }
                                            ZPP_PubPool.nextVec2 = _loc_57;
                                            _loc_57.zpp_disp = true;
                                            _loc_58 = _loc_9;
                                            if (_loc_58.outer != null)
                                            {
                                                _loc_58.outer.zpp_inner = null;
                                                _loc_58.outer = null;
                                            }
                                            _loc_58._isimmutable = null;
                                            _loc_58._validate = null;
                                            _loc_58._invalidate = null;
                                            _loc_58.next = ZPP_Vec2.zpp_pool;
                                            ZPP_Vec2.zpp_pool = _loc_58;
                                            _loc_37.wrap = null;
                                        }
                                        _loc_42 = null;
                                        _loc_37.next = _loc_42;
                                        _loc_37.prev = _loc_42;
                                        _loc_37.next = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_37;
                                    }
                                }
                            }
                            _loc_41.end.next.prev = _loc_41.start.prev;
                            _loc_41.start.prev.next = _loc_41.end.next;
                            _loc_41.end.next = _loc_41.start;
                            _loc_41.start.prev = _loc_41.end;
                            if (_loc_41.path0 == _loc_41.path0.parent)
                            {
                                _loc_21 = _loc_41.path0;
                            }
                            else
                            {
                                _loc_22 = _loc_41.path0;
                                _loc_38 = null;
                                while (_loc_22 != _loc_22.parent)
                                {
                                    
                                    _loc_39 = _loc_22.parent;
                                    _loc_22.parent = _loc_38;
                                    _loc_38 = _loc_22;
                                    _loc_22 = _loc_39;
                                }
                                while (_loc_38 != null)
                                {
                                    
                                    _loc_39 = _loc_38.parent;
                                    _loc_38.parent = _loc_22;
                                    _loc_38 = _loc_39;
                                }
                                _loc_21 = _loc_22;
                            }
                            if (_loc_41.path1 == _loc_41.path1.parent)
                            {
                                _loc_22 = _loc_41.path1;
                            }
                            else
                            {
                                _loc_38 = _loc_41.path1;
                                _loc_39 = null;
                                while (_loc_38 != _loc_38.parent)
                                {
                                    
                                    _loc_40 = _loc_38.parent;
                                    _loc_38.parent = _loc_39;
                                    _loc_39 = _loc_38;
                                    _loc_38 = _loc_40;
                                }
                                while (_loc_39 != null)
                                {
                                    
                                    _loc_40 = _loc_39.parent;
                                    _loc_39.parent = _loc_38;
                                    _loc_39 = _loc_40;
                                }
                                _loc_22 = _loc_38;
                            }
                            if (_loc_21 != _loc_22)
                            {
                                if (_loc_21.rank < _loc_22.rank)
                                {
                                    _loc_21.parent = _loc_22;
                                }
                                else if (_loc_21.rank > _loc_22.rank)
                                {
                                    _loc_22.parent = _loc_21;
                                }
                                else
                                {
                                    _loc_22.parent = _loc_21;
                                    (_loc_21.rank + 1);
                                }
                            }
                        }
                    }
                }
                _loc_59 = _loc_41;
                _loc_36 = null;
                _loc_59.start = _loc_36;
                _loc_59.end = _loc_36;
                _loc_21 = null;
                _loc_59.path1 = _loc_21;
                _loc_59.path0 = _loc_21;
                _loc_59.next = ZPP_CutInt.zpp_pool;
                ZPP_CutInt.zpp_pool = _loc_59;
                _loc_59 = _loc_55;
                _loc_36 = null;
                _loc_59.start = _loc_36;
                _loc_59.end = _loc_36;
                _loc_21 = null;
                _loc_59.path1 = _loc_21;
                _loc_59.path0 = _loc_21;
                _loc_59.next = ZPP_CutInt.zpp_pool;
                ZPP_CutInt.zpp_pool = _loc_59;
            }
            if (param6 == null)
            {
                _loc_60 = new GeomPolyList();
            }
            else
            {
                _loc_60 = param6;
            }
            var _loc_61:* = ZPP_Cutter.paths.head;
            while (_loc_61 != null)
            {
                
                _loc_21 = _loc_61.elt;
                if (_loc_21 == _loc_21.parent)
                {
                    _loc_22 = _loc_21;
                }
                else
                {
                    _loc_38 = _loc_21;
                    _loc_39 = null;
                    while (_loc_38 != _loc_38.parent)
                    {
                        
                        _loc_40 = _loc_38.parent;
                        _loc_38.parent = _loc_39;
                        _loc_39 = _loc_38;
                        _loc_38 = _loc_40;
                    }
                    while (_loc_39 != null)
                    {
                        
                        _loc_40 = _loc_39.parent;
                        _loc_39.parent = _loc_38;
                        _loc_39 = _loc_40;
                    }
                    _loc_22 = _loc_38;
                }
                if (_loc_22.used)
                {
                    _loc_61 = _loc_61.next;
                    continue;
                }
                _loc_22.used = true;
                _loc_36 = _loc_22.vert;
                _loc_29 = true;
                do
                {
                    
                    _loc_29 = false;
                    if (_loc_36.x == _loc_36.next.x)
                    {
                    }
                    if (_loc_36.y == _loc_36.next.y)
                    {
                        if (_loc_36 == _loc_22.vert)
                        {
                            if (_loc_36.next == _loc_36)
                            {
                                _loc_22.vert = null;
                            }
                            else
                            {
                                _loc_22.vert = _loc_36.next;
                            }
                            _loc_29 = true;
                        }
                        if (_loc_36 != null)
                        {
                        }
                        if (_loc_36.prev == _loc_36)
                        {
                            _loc_37 = null;
                            _loc_36.prev = _loc_37;
                            _loc_36.next = _loc_37;
                            _loc_36 = null;
                            _loc_36 = _loc_36;
                        }
                        else
                        {
                            _loc_37 = _loc_36.next;
                            _loc_36.prev.next = _loc_36.next;
                            _loc_36.next.prev = _loc_36.prev;
                            _loc_42 = null;
                            _loc_36.prev = _loc_42;
                            _loc_36.next = _loc_42;
                            _loc_36 = null;
                            _loc_36 = _loc_37;
                        }
                    }
                    else
                    {
                        _loc_36 = _loc_36.next;
                    }
                    if (_loc_22.vert != null)
                    {
                        if (!_loc_29)
                        {
                        }
                    }
                }while (_loc_36 != _loc_22.vert)
                if (_loc_22.vert != null)
                {
                    _loc_62 = GeomPoly.get();
                    _loc_62.zpp_inner.vertices = _loc_22.vert;
                    if (_loc_60.zpp_inner.reverse_flag)
                    {
                        _loc_60.push(_loc_62);
                    }
                    else
                    {
                        _loc_60.unshift(_loc_62);
                    }
                }
                _loc_61 = _loc_61.next;
            }
            while (ZPP_Cutter.paths.head != null)
            {
                
                _loc_21 = ZPP_Cutter.paths.pop_unsafe();
                _loc_22 = _loc_21;
                _loc_22.vert = null;
                _loc_22.parent = null;
                _loc_22.next = ZPP_CutVert.zpp_pool;
                ZPP_CutVert.zpp_pool = _loc_22;
            }
            while (_loc_15 != null)
            {
                
                if (_loc_15 != null)
                {
                }
                if (_loc_15.prev == _loc_15)
                {
                    _loc_21 = null;
                    _loc_15.prev = _loc_21;
                    _loc_15.next = _loc_21;
                    _loc_21 = _loc_15;
                    _loc_21.vert = null;
                    _loc_21.parent = null;
                    _loc_21.next = ZPP_CutVert.zpp_pool;
                    ZPP_CutVert.zpp_pool = _loc_21;
                    _loc_15 = null;
                    _loc_15 = _loc_15;
                    continue;
                }
                _loc_21 = _loc_15.next;
                _loc_15.prev.next = _loc_15.next;
                _loc_15.next.prev = _loc_15.prev;
                _loc_22 = null;
                _loc_15.prev = _loc_22;
                _loc_15.next = _loc_22;
                _loc_22 = _loc_15;
                _loc_22.vert = null;
                _loc_22.parent = null;
                _loc_22.next = ZPP_CutVert.zpp_pool;
                ZPP_CutVert.zpp_pool = _loc_22;
                _loc_15 = null;
                _loc_15 = _loc_21;
            }
            return _loc_60;
        }// end function

    }
}
