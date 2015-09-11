package zpp_nape.geom
{
    import nape.*;
    import nape.geom.*;
    import zpp_nape.util.*;

    public class ZPP_MarchingSquares extends Object
    {
        public static var init__:Boolean;
        public static var me:ZPP_MarchingSquares;
        public static var isos:ZNPArray2_Float;
        public static var ints:ZNPArray2_ZPP_GeomVert;
        public static var map:ZNPArray2_ZPP_MarchPair;
        public static var look_march:Array;

        public function ZPP_MarchingSquares() : void
        {
            return;
        }// end function

        public function ylerp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:IsoFunction, param7:int) : Number
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            if (param4 == 0)
            {
                _loc_8 = param1;
            }
            else if (param5 == 0)
            {
                _loc_8 = param2;
            }
            else
            {
                _loc_9 = param4 - param5;
                if (_loc_9 * _loc_9 < Config.epsilon * Config.epsilon)
                {
                    _loc_10 = 0.5;
                }
                else
                {
                    _loc_10 = param4 / _loc_9;
                }
                if (_loc_10 < 0)
                {
                    _loc_10 = 0;
                }
                else if (_loc_10 > 1)
                {
                    _loc_10 = 1;
                }
                _loc_8 = param1 + _loc_10 * (param2 - param1);
            }
            do
            {
                
                _loc_9 = param6.iso(param3, _loc_8);
                if (_loc_9 == 0)
                {
                    break;
                }
                if (param4 * _loc_9 < 0)
                {
                    param2 = _loc_8;
                    param5 = _loc_9;
                }
                else
                {
                    param1 = _loc_8;
                    param4 = _loc_9;
                }
                if (param4 == 0)
                {
                    _loc_8 = param1;
                }
                else if (param5 == 0)
                {
                    _loc_8 = param2;
                }
                else
                {
                    _loc_10 = param4 - param5;
                    if (_loc_10 * _loc_10 < Config.epsilon * Config.epsilon)
                    {
                        _loc_11 = 0.5;
                    }
                    else
                    {
                        _loc_11 = param4 / _loc_10;
                    }
                    if (_loc_11 < 0)
                    {
                        _loc_11 = 0;
                    }
                    else if (_loc_11 > 1)
                    {
                        _loc_11 = 1;
                    }
                    _loc_8 = param1 + _loc_11 * (param2 - param1);
                }
                param7--;
                if (param7 != 0)
                {
                }
                if (param1 < _loc_8)
                {
                }
            }while (_loc_8 < param2)
            return _loc_8;
        }// end function

        public function xlerp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:IsoFunction, param7:int) : Number
        {
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            if (param4 == 0)
            {
                _loc_8 = param1;
            }
            else if (param5 == 0)
            {
                _loc_8 = param2;
            }
            else
            {
                _loc_9 = param4 - param5;
                if (_loc_9 * _loc_9 < Config.epsilon * Config.epsilon)
                {
                    _loc_10 = 0.5;
                }
                else
                {
                    _loc_10 = param4 / _loc_9;
                }
                if (_loc_10 < 0)
                {
                    _loc_10 = 0;
                }
                else if (_loc_10 > 1)
                {
                    _loc_10 = 1;
                }
                _loc_8 = param1 + _loc_10 * (param2 - param1);
            }
            do
            {
                
                _loc_9 = param6.iso(_loc_8, param3);
                if (_loc_9 == 0)
                {
                    break;
                }
                if (param4 * _loc_9 < 0)
                {
                    param2 = _loc_8;
                    param5 = _loc_9;
                }
                else
                {
                    param1 = _loc_8;
                    param4 = _loc_9;
                }
                if (param4 == 0)
                {
                    _loc_8 = param1;
                }
                else if (param5 == 0)
                {
                    _loc_8 = param2;
                }
                else
                {
                    _loc_10 = param4 - param5;
                    if (_loc_10 * _loc_10 < Config.epsilon * Config.epsilon)
                    {
                        _loc_11 = 0.5;
                    }
                    else
                    {
                        _loc_11 = param4 / _loc_10;
                    }
                    if (_loc_11 < 0)
                    {
                        _loc_11 = 0;
                    }
                    else if (_loc_11 > 1)
                    {
                        _loc_11 = 1;
                    }
                    _loc_8 = param1 + _loc_11 * (param2 - param1);
                }
                param7--;
                if (param7 != 0)
                {
                }
                if (param1 < _loc_8)
                {
                }
            }while (_loc_8 < param2)
            return _loc_8;
        }// end function

        public function output(param1:GeomPolyList, param2:ZPP_GeomVert) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = null as ZPP_GeomVert;
            var _loc_8:* = null as ZPP_GeomVert;
            if (param2 != null)
            {
            }
            if (param2.next != param2)
            {
            }
            if (_loc_5 != null)
            {
                while (_loc_7 != _loc_6)
                {
                }
            }
            if (_loc_7 == _loc_6 ? (true) : (_loc_4 = 0, _loc_5 = param2, _loc_6 = param2, if (_loc_5 == null) goto 162, _loc_7 = _loc_5, // Jump to 109, // label, _loc_8 = _loc_7, _loc_4 = _loc_4 + _loc_8.x * (_loc_8.next.y - _loc_8.prev.y), _loc_7 = _loc_7.next, if (!(_loc_7 == _loc_6)) goto 108, _loc_3 = _loc_4 * 0.5, _loc_3 * _loc_3 < Config.epsilon * Config.epsilon))
            {
                while (param2 != null)
                {
                    
                    if (param2 != null)
                    {
                    }
                    if (param2.prev == param2)
                    {
                        _loc_5 = null;
                        param2.prev = _loc_5;
                        param2.next = _loc_5;
                        param2 = null;
                        param2 = param2;
                        continue;
                    }
                    _loc_5 = param2.next;
                    param2.prev.next = param2.next;
                    param2.next.prev = param2.prev;
                    _loc_6 = null;
                    param2.prev = _loc_6;
                    param2.next = _loc_6;
                    param2 = null;
                    param2 = _loc_5;
                }
                return;
            }
            var _loc_9:* = GeomPoly.get();
            _loc_9.zpp_inner.vertices = param2;
            if (param1.zpp_inner.reverse_flag)
            {
                param1.push(_loc_9);
            }
            else
            {
                param1.unshift(_loc_9);
            }
            return;
        }// end function

        public function marchSquare(param1:IsoFunction, param2:ZNPArray2_Float, param3:ZNPArray2_ZPP_GeomVert, param4:Number, param5:Number, param6:Number, param7:Number, param8:int, param9:int, param10:Boolean, param11:Boolean, param12:Boolean, param13:Boolean, param14:int) : ZPP_MarchPair
        {
            var _loc_20:* = null as ZPP_MarchPair;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = null as ZPP_GeomVert;
            var _loc_25:* = null as ZPP_GeomVert;
            var _loc_26:* = NaN;
            var _loc_27:* = null as ZPP_GeomVert;
            var _loc_28:* = false;
            var _loc_29:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = param2.list[param9 * param2.width + param8];
            if (_loc_16 < 0)
            {
                _loc_15 = _loc_15 | 8;
            }
            var _loc_17:* = param2.list[param9 * param2.width + (param8 + 1)];
            if (_loc_17 < 0)
            {
                _loc_15 = _loc_15 | 4;
            }
            var _loc_18:* = param2.list[(param9 + 1) * param2.width + (param8 + 1)];
            if (_loc_18 < 0)
            {
                _loc_15 = _loc_15 | 2;
            }
            var _loc_19:* = param2.list[(param9 + 1) * param2.width + param8];
            if (_loc_19 < 0)
            {
                _loc_15 = _loc_15 | 1;
            }
            if (_loc_15 == 0)
            {
                return null;
            }
            else
            {
                if (ZPP_MarchPair.zpp_pool == null)
                {
                    _loc_20 = new ZPP_MarchPair();
                }
                else
                {
                    _loc_20 = ZPP_MarchPair.zpp_pool;
                    ZPP_MarchPair.zpp_pool = _loc_20.next;
                    _loc_20.next = null;
                }
                if (_loc_15 != 10)
                {
                }
                if (_loc_15 != 5)
                {
                    _loc_21 = ZPP_MarchingSquares.look_march[_loc_15];
                    _loc_20.okey1 = _loc_21;
                    _loc_22 = 0;
                    while (_loc_22 < 8)
                    {
                        
                        _loc_22++;
                        _loc_23 = _loc_22;
                        if ((_loc_21 & 1 << _loc_23) != 0)
                        {
                            _loc_24 = null;
                            if (_loc_23 == 0)
                            {
                                if (ZPP_GeomVert.zpp_pool == null)
                                {
                                    _loc_25 = new ZPP_GeomVert();
                                }
                                else
                                {
                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                    _loc_25.next = null;
                                }
                                _loc_25.forced = false;
                                _loc_25.x = param4;
                                _loc_25.y = param5;
                                _loc_24 = _loc_25;
                                if (!param10)
                                {
                                }
                                if (param11)
                                {
                                    _loc_24.forced = true;
                                }
                            }
                            else if (_loc_23 == 2)
                            {
                                if (ZPP_GeomVert.zpp_pool == null)
                                {
                                    _loc_25 = new ZPP_GeomVert();
                                }
                                else
                                {
                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                    _loc_25.next = null;
                                }
                                _loc_25.forced = false;
                                _loc_25.x = param6;
                                _loc_25.y = param5;
                                _loc_24 = _loc_25;
                                if (!param12)
                                {
                                }
                                if (param11)
                                {
                                    _loc_24.forced = true;
                                }
                            }
                            else if (_loc_23 == 4)
                            {
                                if (ZPP_GeomVert.zpp_pool == null)
                                {
                                    _loc_25 = new ZPP_GeomVert();
                                }
                                else
                                {
                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                    _loc_25.next = null;
                                }
                                _loc_25.forced = false;
                                _loc_25.x = param6;
                                _loc_25.y = param7;
                                _loc_24 = _loc_25;
                                if (!param12)
                                {
                                }
                                if (param13)
                                {
                                    _loc_24.forced = true;
                                }
                            }
                            else if (_loc_23 == 6)
                            {
                                if (ZPP_GeomVert.zpp_pool == null)
                                {
                                    _loc_25 = new ZPP_GeomVert();
                                }
                                else
                                {
                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                    _loc_25.next = null;
                                }
                                _loc_25.forced = false;
                                _loc_25.x = param4;
                                _loc_25.y = param7;
                                _loc_24 = _loc_25;
                                if (!param10)
                                {
                                }
                                if (param13)
                                {
                                    _loc_24.forced = true;
                                }
                            }
                            else if (_loc_23 == 1)
                            {
                                _loc_24 = param3.list[(param9 << 1) * param3.width + param8];
                                if (_loc_24 == null)
                                {
                                    _loc_26 = xlerp(param4, param6, param5, _loc_16, _loc_17, param1, param14);
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = _loc_26;
                                    _loc_25.y = param5;
                                    _loc_24 = _loc_25;
                                    param3.list[(param9 << 1) * param3.width + param8] = _loc_24;
                                }
                                else
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = _loc_24.x;
                                    _loc_25.y = _loc_24.y;
                                    _loc_24 = _loc_25;
                                }
                                if (param11)
                                {
                                    _loc_24.forced = true;
                                }
                                if (_loc_24.x != param4)
                                {
                                }
                                if (_loc_24.x == param6)
                                {
                                    if (_loc_24.x == param4)
                                    {
                                    }
                                    if ((_loc_21 & 1) == 0)
                                    {
                                        if (_loc_24.x == param6)
                                        {
                                        }
                                    }
                                    if ((_loc_21 & 4) != 0)
                                    {
                                        _loc_21 = _loc_21 ^ 2;
                                    }
                                }
                            }
                            else if (_loc_23 == 5)
                            {
                                _loc_24 = param3.list[((param9 << 1) + 2) * param3.width + param8];
                                if (_loc_24 == null)
                                {
                                    _loc_26 = xlerp(param4, param6, param7, _loc_19, _loc_18, param1, param14);
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = _loc_26;
                                    _loc_25.y = param7;
                                    _loc_24 = _loc_25;
                                    param3.list[((param9 << 1) + 2) * param3.width + param8] = _loc_24;
                                }
                                else
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = _loc_24.x;
                                    _loc_25.y = _loc_24.y;
                                    _loc_24 = _loc_25;
                                }
                                if (param13)
                                {
                                    _loc_24.forced = true;
                                }
                                if (_loc_24.x != param4)
                                {
                                }
                                if (_loc_24.x == param6)
                                {
                                    if (_loc_24.x == param4)
                                    {
                                    }
                                    if ((_loc_21 & 64) == 0)
                                    {
                                        if (_loc_24.x == param6)
                                        {
                                        }
                                    }
                                    if ((_loc_21 & 16) != 0)
                                    {
                                        _loc_21 = _loc_21 ^ 32;
                                    }
                                }
                            }
                            else if (_loc_23 == 3)
                            {
                                _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)];
                                if (_loc_24 == null)
                                {
                                    _loc_26 = ylerp(param5, param7, param6, _loc_17, _loc_18, param1, param14);
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = param6;
                                    _loc_25.y = _loc_26;
                                    _loc_24 = _loc_25;
                                    param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)] = _loc_24;
                                }
                                else
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = _loc_24.x;
                                    _loc_25.y = _loc_24.y;
                                    _loc_24 = _loc_25;
                                }
                                if (param12)
                                {
                                    _loc_24.forced = true;
                                }
                                if (_loc_24.y != param5)
                                {
                                }
                                if (_loc_24.y == param7)
                                {
                                    if (_loc_24.y == param5)
                                    {
                                    }
                                    if ((_loc_21 & 4) == 0)
                                    {
                                        if (_loc_24.y == param7)
                                        {
                                        }
                                    }
                                    if ((_loc_21 & 16) != 0)
                                    {
                                        _loc_21 = _loc_21 ^ 8;
                                    }
                                }
                            }
                            else
                            {
                                _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + param8];
                                if (_loc_24 == null)
                                {
                                    _loc_26 = ylerp(param5, param7, param4, _loc_16, _loc_19, param1, param14);
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = param4;
                                    _loc_25.y = _loc_26;
                                    _loc_24 = _loc_25;
                                    param3.list[((param9 << 1) + 1) * param3.width + param8] = _loc_24;
                                }
                                else
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = _loc_24.x;
                                    _loc_25.y = _loc_24.y;
                                    _loc_24 = _loc_25;
                                }
                                if (param10)
                                {
                                    _loc_24.forced = true;
                                }
                                if (_loc_24.y != param5)
                                {
                                }
                                if (_loc_24.y == param7)
                                {
                                    if (_loc_24.y == param5)
                                    {
                                    }
                                    if ((_loc_21 & 1) == 0)
                                    {
                                        if (_loc_24.y == param7)
                                        {
                                        }
                                    }
                                    if ((_loc_21 & 64) != 0)
                                    {
                                        _loc_21 = _loc_21 ^ 128;
                                    }
                                }
                            }
                            _loc_25 = _loc_24;
                            if (_loc_20.p1 == null)
                            {
                                _loc_27 = _loc_25;
                                _loc_25.next = _loc_27;
                                _loc_27 = _loc_27;
                                _loc_25.prev = _loc_27;
                                _loc_20.p1 = _loc_27;
                            }
                            else
                            {
                                _loc_25.prev = _loc_20.p1;
                                _loc_25.next = _loc_20.p1.next;
                                _loc_20.p1.next.prev = _loc_25;
                                _loc_20.p1.next = _loc_25;
                            }
                            _loc_20.p1 = _loc_25;
                        }
                    }
                    _loc_20.p1 = _loc_20.p1.next;
                    _loc_20.key1 = _loc_21;
                    if (_loc_21 != 1)
                    {
                    }
                    if (_loc_21 != 4)
                    {
                    }
                    if (_loc_21 != 16)
                    {
                    }
                    if (_loc_21 != 64)
                    {
                    }
                    if (_loc_21 != 3)
                    {
                    }
                    if (_loc_21 != 12)
                    {
                    }
                    if (_loc_21 != 48)
                    {
                    }
                    if (_loc_21 != 192)
                    {
                    }
                    if (_loc_21 != 129)
                    {
                    }
                    if (_loc_21 != 6)
                    {
                    }
                    if (_loc_21 != 24)
                    {
                    }
                    if (_loc_21 != 96)
                    {
                    }
                    if (_loc_21 != 5)
                    {
                    }
                    if (_loc_21 != 20)
                    {
                    }
                    if (_loc_21 != 80)
                    {
                    }
                    if (_loc_21 != 65)
                    {
                    }
                    if (_loc_21 != 17)
                    {
                    }
                    if (_loc_21 == 68)
                    {
                        _loc_21 = 0;
                        _loc_20.key1 = 0;
                        _loc_20.p1 = null;
                    }
                    if (_loc_21 == 0)
                    {
                        _loc_20 = null;
                    }
                    else
                    {
                        _loc_20.pr = _loc_20.p1;
                        _loc_20.okeyr = _loc_20.okey1;
                        _loc_20.keyr = _loc_20.key1;
                    }
                }
                else
                {
                    _loc_28 = param1.iso(0.5 * (param4 + param6), 0.5 * (param5 + param7)) < 0;
                    if (_loc_15 == 10)
                    {
                        if (_loc_28)
                        {
                            _loc_21 = 187;
                            _loc_20.okey1 = _loc_21;
                            _loc_22 = 0;
                            while (_loc_22 < 8)
                            {
                                
                                _loc_22++;
                                _loc_23 = _loc_22;
                                if ((_loc_21 & 1 << _loc_23) != 0)
                                {
                                    _loc_24 = null;
                                    if (_loc_23 == 0)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param4;
                                        _loc_25.y = param5;
                                        _loc_24 = _loc_25;
                                        if (!param10)
                                        {
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_23 == 2)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param6;
                                        _loc_25.y = param5;
                                        _loc_24 = _loc_25;
                                        if (!param12)
                                        {
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_23 == 4)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param6;
                                        _loc_25.y = param7;
                                        _loc_24 = _loc_25;
                                        if (!param12)
                                        {
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_23 == 6)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param4;
                                        _loc_25.y = param7;
                                        _loc_24 = _loc_25;
                                        if (!param10)
                                        {
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_23 == 1)
                                    {
                                        _loc_24 = param3.list[(param9 << 1) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = xlerp(param4, param6, param5, _loc_16, _loc_17, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_26;
                                            _loc_25.y = param5;
                                            _loc_24 = _loc_25;
                                            param3.list[(param9 << 1) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.x != param4)
                                        {
                                        }
                                        if (_loc_24.x == param6)
                                        {
                                            if (_loc_24.x == param4)
                                            {
                                            }
                                            if ((_loc_21 & 1) == 0)
                                            {
                                                if (_loc_24.x == param6)
                                                {
                                                }
                                            }
                                            if ((_loc_21 & 4) != 0)
                                            {
                                                _loc_21 = _loc_21 ^ 2;
                                            }
                                        }
                                    }
                                    else if (_loc_23 == 5)
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 2) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = xlerp(param4, param6, param7, _loc_19, _loc_18, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_26;
                                            _loc_25.y = param7;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 2) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.x != param4)
                                        {
                                        }
                                        if (_loc_24.x == param6)
                                        {
                                            if (_loc_24.x == param4)
                                            {
                                            }
                                            if ((_loc_21 & 64) == 0)
                                            {
                                                if (_loc_24.x == param6)
                                                {
                                                }
                                            }
                                            if ((_loc_21 & 16) != 0)
                                            {
                                                _loc_21 = _loc_21 ^ 32;
                                            }
                                        }
                                    }
                                    else if (_loc_23 == 3)
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = ylerp(param5, param7, param6, _loc_17, _loc_18, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param6;
                                            _loc_25.y = _loc_26;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param12)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.y != param5)
                                        {
                                        }
                                        if (_loc_24.y == param7)
                                        {
                                            if (_loc_24.y == param5)
                                            {
                                            }
                                            if ((_loc_21 & 4) == 0)
                                            {
                                                if (_loc_24.y == param7)
                                                {
                                                }
                                            }
                                            if ((_loc_21 & 16) != 0)
                                            {
                                                _loc_21 = _loc_21 ^ 8;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = ylerp(param5, param7, param4, _loc_16, _loc_19, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param4;
                                            _loc_25.y = _loc_26;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 1) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param10)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.y != param5)
                                        {
                                        }
                                        if (_loc_24.y == param7)
                                        {
                                            if (_loc_24.y == param5)
                                            {
                                            }
                                            if ((_loc_21 & 1) == 0)
                                            {
                                                if (_loc_24.y == param7)
                                                {
                                                }
                                            }
                                            if ((_loc_21 & 64) != 0)
                                            {
                                                _loc_21 = _loc_21 ^ 128;
                                            }
                                        }
                                    }
                                    _loc_25 = _loc_24;
                                    if (_loc_20.p1 == null)
                                    {
                                        _loc_27 = _loc_25;
                                        _loc_25.next = _loc_27;
                                        _loc_27 = _loc_27;
                                        _loc_25.prev = _loc_27;
                                        _loc_20.p1 = _loc_27;
                                    }
                                    else
                                    {
                                        _loc_25.prev = _loc_20.p1;
                                        _loc_25.next = _loc_20.p1.next;
                                        _loc_20.p1.next.prev = _loc_25;
                                        _loc_20.p1.next = _loc_25;
                                    }
                                    _loc_20.p1 = _loc_25;
                                }
                            }
                            _loc_20.p1 = _loc_20.p1.next;
                            _loc_20.key1 = _loc_21;
                            if (_loc_21 != 1)
                            {
                            }
                            if (_loc_21 != 4)
                            {
                            }
                            if (_loc_21 != 16)
                            {
                            }
                            if (_loc_21 != 64)
                            {
                            }
                            if (_loc_21 != 3)
                            {
                            }
                            if (_loc_21 != 12)
                            {
                            }
                            if (_loc_21 != 48)
                            {
                            }
                            if (_loc_21 != 192)
                            {
                            }
                            if (_loc_21 != 129)
                            {
                            }
                            if (_loc_21 != 6)
                            {
                            }
                            if (_loc_21 != 24)
                            {
                            }
                            if (_loc_21 != 96)
                            {
                            }
                            if (_loc_21 != 5)
                            {
                            }
                            if (_loc_21 != 20)
                            {
                            }
                            if (_loc_21 != 80)
                            {
                            }
                            if (_loc_21 != 65)
                            {
                            }
                            if (_loc_21 != 17)
                            {
                            }
                            if (_loc_21 == 68)
                            {
                                _loc_21 = 0;
                                _loc_20.key1 = 0;
                                _loc_20.p1 = null;
                            }
                            if (_loc_21 == 0)
                            {
                                _loc_20 = null;
                            }
                            else
                            {
                                _loc_20.pr = _loc_20.p1;
                                _loc_20.okeyr = _loc_20.okey1;
                                _loc_20.keyr = _loc_20.key1;
                            }
                        }
                        else
                        {
                            _loc_21 = 131;
                            _loc_20.okey1 = _loc_21;
                            _loc_22 = 0;
                            while (_loc_22 < 8)
                            {
                                
                                _loc_22++;
                                _loc_23 = _loc_22;
                                if ((_loc_21 & 1 << _loc_23) != 0)
                                {
                                    _loc_24 = null;
                                    if (_loc_23 == 0)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param4;
                                        _loc_25.y = param5;
                                        _loc_24 = _loc_25;
                                        if (!param10)
                                        {
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_23 == 2)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param6;
                                        _loc_25.y = param5;
                                        _loc_24 = _loc_25;
                                        if (!param12)
                                        {
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_23 == 4)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param6;
                                        _loc_25.y = param7;
                                        _loc_24 = _loc_25;
                                        if (!param12)
                                        {
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_23 == 6)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param4;
                                        _loc_25.y = param7;
                                        _loc_24 = _loc_25;
                                        if (!param10)
                                        {
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_23 == 1)
                                    {
                                        _loc_24 = param3.list[(param9 << 1) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = xlerp(param4, param6, param5, _loc_16, _loc_17, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_26;
                                            _loc_25.y = param5;
                                            _loc_24 = _loc_25;
                                            param3.list[(param9 << 1) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.x != param4)
                                        {
                                        }
                                        if (_loc_24.x == param6)
                                        {
                                            if (_loc_24.x == param4)
                                            {
                                            }
                                            if ((_loc_21 & 1) == 0)
                                            {
                                                if (_loc_24.x == param6)
                                                {
                                                }
                                            }
                                            if ((_loc_21 & 4) != 0)
                                            {
                                                _loc_21 = _loc_21 ^ 2;
                                            }
                                        }
                                    }
                                    else if (_loc_23 == 5)
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 2) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = xlerp(param4, param6, param7, _loc_19, _loc_18, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_26;
                                            _loc_25.y = param7;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 2) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.x != param4)
                                        {
                                        }
                                        if (_loc_24.x == param6)
                                        {
                                            if (_loc_24.x == param4)
                                            {
                                            }
                                            if ((_loc_21 & 64) == 0)
                                            {
                                                if (_loc_24.x == param6)
                                                {
                                                }
                                            }
                                            if ((_loc_21 & 16) != 0)
                                            {
                                                _loc_21 = _loc_21 ^ 32;
                                            }
                                        }
                                    }
                                    else if (_loc_23 == 3)
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = ylerp(param5, param7, param6, _loc_17, _loc_18, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param6;
                                            _loc_25.y = _loc_26;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param12)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.y != param5)
                                        {
                                        }
                                        if (_loc_24.y == param7)
                                        {
                                            if (_loc_24.y == param5)
                                            {
                                            }
                                            if ((_loc_21 & 4) == 0)
                                            {
                                                if (_loc_24.y == param7)
                                                {
                                                }
                                            }
                                            if ((_loc_21 & 16) != 0)
                                            {
                                                _loc_21 = _loc_21 ^ 8;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = ylerp(param5, param7, param4, _loc_16, _loc_19, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param4;
                                            _loc_25.y = _loc_26;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 1) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param10)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.y != param5)
                                        {
                                        }
                                        if (_loc_24.y == param7)
                                        {
                                            if (_loc_24.y == param5)
                                            {
                                            }
                                            if ((_loc_21 & 1) == 0)
                                            {
                                                if (_loc_24.y == param7)
                                                {
                                                }
                                            }
                                            if ((_loc_21 & 64) != 0)
                                            {
                                                _loc_21 = _loc_21 ^ 128;
                                            }
                                        }
                                    }
                                    _loc_25 = _loc_24;
                                    if (_loc_20.p1 == null)
                                    {
                                        _loc_27 = _loc_25;
                                        _loc_25.next = _loc_27;
                                        _loc_27 = _loc_27;
                                        _loc_25.prev = _loc_27;
                                        _loc_20.p1 = _loc_27;
                                    }
                                    else
                                    {
                                        _loc_25.prev = _loc_20.p1;
                                        _loc_25.next = _loc_20.p1.next;
                                        _loc_20.p1.next.prev = _loc_25;
                                        _loc_20.p1.next = _loc_25;
                                    }
                                    _loc_20.p1 = _loc_25;
                                }
                            }
                            _loc_20.p1 = _loc_20.p1.next;
                            _loc_20.key1 = _loc_21;
                            if (_loc_21 != 1)
                            {
                            }
                            if (_loc_21 != 4)
                            {
                            }
                            if (_loc_21 != 16)
                            {
                            }
                            if (_loc_21 != 64)
                            {
                            }
                            if (_loc_21 != 3)
                            {
                            }
                            if (_loc_21 != 12)
                            {
                            }
                            if (_loc_21 != 48)
                            {
                            }
                            if (_loc_21 != 192)
                            {
                            }
                            if (_loc_21 != 129)
                            {
                            }
                            if (_loc_21 != 6)
                            {
                            }
                            if (_loc_21 != 24)
                            {
                            }
                            if (_loc_21 != 96)
                            {
                            }
                            if (_loc_21 != 5)
                            {
                            }
                            if (_loc_21 != 20)
                            {
                            }
                            if (_loc_21 != 80)
                            {
                            }
                            if (_loc_21 != 65)
                            {
                            }
                            if (_loc_21 != 17)
                            {
                            }
                            if (_loc_21 == 68)
                            {
                                _loc_21 = 0;
                                _loc_20.key1 = 0;
                                _loc_20.p1 = null;
                            }
                            if (_loc_21 != 0)
                            {
                                _loc_22 = 56;
                                _loc_20.okey2 = _loc_22;
                                _loc_23 = 0;
                                while (_loc_23 < 8)
                                {
                                    
                                    _loc_23++;
                                    _loc_29 = _loc_23;
                                    if ((_loc_22 & 1 << _loc_29) != 0)
                                    {
                                        _loc_24 = null;
                                        if (_loc_29 == 0)
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param4;
                                            _loc_25.y = param5;
                                            _loc_24 = _loc_25;
                                            if (!param10)
                                            {
                                            }
                                            if (param11)
                                            {
                                                _loc_24.forced = true;
                                            }
                                        }
                                        else if (_loc_29 == 2)
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param6;
                                            _loc_25.y = param5;
                                            _loc_24 = _loc_25;
                                            if (!param12)
                                            {
                                            }
                                            if (param11)
                                            {
                                                _loc_24.forced = true;
                                            }
                                        }
                                        else if (_loc_29 == 4)
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param6;
                                            _loc_25.y = param7;
                                            _loc_24 = _loc_25;
                                            if (!param12)
                                            {
                                            }
                                            if (param13)
                                            {
                                                _loc_24.forced = true;
                                            }
                                        }
                                        else if (_loc_29 == 6)
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param4;
                                            _loc_25.y = param7;
                                            _loc_24 = _loc_25;
                                            if (!param10)
                                            {
                                            }
                                            if (param13)
                                            {
                                                _loc_24.forced = true;
                                            }
                                        }
                                        else if (_loc_29 == 1)
                                        {
                                            _loc_24 = param3.list[(param9 << 1) * param3.width + param8];
                                            if (_loc_24 == null)
                                            {
                                                _loc_26 = xlerp(param4, param6, param5, _loc_16, _loc_17, param1, param14);
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_26;
                                                _loc_25.y = param5;
                                                _loc_24 = _loc_25;
                                                param3.list[(param9 << 1) * param3.width + param8] = _loc_24;
                                            }
                                            else
                                            {
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_24.x;
                                                _loc_25.y = _loc_24.y;
                                                _loc_24 = _loc_25;
                                            }
                                            if (param11)
                                            {
                                                _loc_24.forced = true;
                                            }
                                            if (_loc_24.x != param4)
                                            {
                                            }
                                            if (_loc_24.x == param6)
                                            {
                                                if (_loc_24.x == param4)
                                                {
                                                }
                                                if ((_loc_22 & 1) == 0)
                                                {
                                                    if (_loc_24.x == param6)
                                                    {
                                                    }
                                                }
                                                if ((_loc_22 & 4) != 0)
                                                {
                                                    _loc_22 = _loc_22 ^ 2;
                                                }
                                            }
                                        }
                                        else if (_loc_29 == 5)
                                        {
                                            _loc_24 = param3.list[((param9 << 1) + 2) * param3.width + param8];
                                            if (_loc_24 == null)
                                            {
                                                _loc_26 = xlerp(param4, param6, param7, _loc_19, _loc_18, param1, param14);
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_26;
                                                _loc_25.y = param7;
                                                _loc_24 = _loc_25;
                                                param3.list[((param9 << 1) + 2) * param3.width + param8] = _loc_24;
                                            }
                                            else
                                            {
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_24.x;
                                                _loc_25.y = _loc_24.y;
                                                _loc_24 = _loc_25;
                                            }
                                            if (param13)
                                            {
                                                _loc_24.forced = true;
                                            }
                                            if (_loc_24.x != param4)
                                            {
                                            }
                                            if (_loc_24.x == param6)
                                            {
                                                if (_loc_24.x == param4)
                                                {
                                                }
                                                if ((_loc_22 & 64) == 0)
                                                {
                                                    if (_loc_24.x == param6)
                                                    {
                                                    }
                                                }
                                                if ((_loc_22 & 16) != 0)
                                                {
                                                    _loc_22 = _loc_22 ^ 32;
                                                }
                                            }
                                        }
                                        else if (_loc_29 == 3)
                                        {
                                            _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)];
                                            if (_loc_24 == null)
                                            {
                                                _loc_26 = ylerp(param5, param7, param6, _loc_17, _loc_18, param1, param14);
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = param6;
                                                _loc_25.y = _loc_26;
                                                _loc_24 = _loc_25;
                                                param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)] = _loc_24;
                                            }
                                            else
                                            {
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_24.x;
                                                _loc_25.y = _loc_24.y;
                                                _loc_24 = _loc_25;
                                            }
                                            if (param12)
                                            {
                                                _loc_24.forced = true;
                                            }
                                            if (_loc_24.y != param5)
                                            {
                                            }
                                            if (_loc_24.y == param7)
                                            {
                                                if (_loc_24.y == param5)
                                                {
                                                }
                                                if ((_loc_22 & 4) == 0)
                                                {
                                                    if (_loc_24.y == param7)
                                                    {
                                                    }
                                                }
                                                if ((_loc_22 & 16) != 0)
                                                {
                                                    _loc_22 = _loc_22 ^ 8;
                                                }
                                            }
                                        }
                                        else
                                        {
                                            _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + param8];
                                            if (_loc_24 == null)
                                            {
                                                _loc_26 = ylerp(param5, param7, param4, _loc_16, _loc_19, param1, param14);
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = param4;
                                                _loc_25.y = _loc_26;
                                                _loc_24 = _loc_25;
                                                param3.list[((param9 << 1) + 1) * param3.width + param8] = _loc_24;
                                            }
                                            else
                                            {
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_24.x;
                                                _loc_25.y = _loc_24.y;
                                                _loc_24 = _loc_25;
                                            }
                                            if (param10)
                                            {
                                                _loc_24.forced = true;
                                            }
                                            if (_loc_24.y != param5)
                                            {
                                            }
                                            if (_loc_24.y == param7)
                                            {
                                                if (_loc_24.y == param5)
                                                {
                                                }
                                                if ((_loc_22 & 1) == 0)
                                                {
                                                    if (_loc_24.y == param7)
                                                    {
                                                    }
                                                }
                                                if ((_loc_22 & 64) != 0)
                                                {
                                                    _loc_22 = _loc_22 ^ 128;
                                                }
                                            }
                                        }
                                        _loc_25 = _loc_24;
                                        if (_loc_20.p2 == null)
                                        {
                                            _loc_27 = _loc_25;
                                            _loc_25.next = _loc_27;
                                            _loc_27 = _loc_27;
                                            _loc_25.prev = _loc_27;
                                            _loc_20.p2 = _loc_27;
                                        }
                                        else
                                        {
                                            _loc_25.prev = _loc_20.p2;
                                            _loc_25.next = _loc_20.p2.next;
                                            _loc_20.p2.next.prev = _loc_25;
                                            _loc_20.p2.next = _loc_25;
                                        }
                                        _loc_20.p2 = _loc_25;
                                    }
                                }
                                _loc_20.p2 = _loc_20.p2.next;
                                _loc_20.key2 = _loc_22;
                                if (_loc_22 != 1)
                                {
                                }
                                if (_loc_22 != 4)
                                {
                                }
                                if (_loc_22 != 16)
                                {
                                }
                                if (_loc_22 != 64)
                                {
                                }
                                if (_loc_22 != 3)
                                {
                                }
                                if (_loc_22 != 12)
                                {
                                }
                                if (_loc_22 != 48)
                                {
                                }
                                if (_loc_22 != 192)
                                {
                                }
                                if (_loc_22 != 129)
                                {
                                }
                                if (_loc_22 != 6)
                                {
                                }
                                if (_loc_22 != 24)
                                {
                                }
                                if (_loc_22 != 96)
                                {
                                }
                                if (_loc_22 != 5)
                                {
                                }
                                if (_loc_22 != 20)
                                {
                                }
                                if (_loc_22 != 80)
                                {
                                }
                                if (_loc_22 != 65)
                                {
                                }
                                if (_loc_22 != 17)
                                {
                                }
                                if (_loc_22 == 68)
                                {
                                    _loc_22 = 0;
                                    _loc_20.key2 = 0;
                                    _loc_20.p2 = null;
                                }
                                if (_loc_22 == 0)
                                {
                                    _loc_20.pr = _loc_20.p1;
                                    _loc_20.okeyr = _loc_20.okey1;
                                    _loc_20.keyr = _loc_20.key1;
                                }
                                else
                                {
                                    _loc_20.pr = _loc_20.p2;
                                    _loc_20.okeyr = _loc_20.okey2;
                                    _loc_20.keyr = _loc_20.key2;
                                }
                            }
                            else
                            {
                                _loc_22 = 56;
                                _loc_20.okey1 = _loc_22;
                                _loc_23 = 0;
                                while (_loc_23 < 8)
                                {
                                    
                                    _loc_23++;
                                    _loc_29 = _loc_23;
                                    if ((_loc_22 & 1 << _loc_29) != 0)
                                    {
                                        _loc_24 = null;
                                        if (_loc_29 == 0)
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param4;
                                            _loc_25.y = param5;
                                            _loc_24 = _loc_25;
                                            if (!param10)
                                            {
                                            }
                                            if (param11)
                                            {
                                                _loc_24.forced = true;
                                            }
                                        }
                                        else if (_loc_29 == 2)
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param6;
                                            _loc_25.y = param5;
                                            _loc_24 = _loc_25;
                                            if (!param12)
                                            {
                                            }
                                            if (param11)
                                            {
                                                _loc_24.forced = true;
                                            }
                                        }
                                        else if (_loc_29 == 4)
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param6;
                                            _loc_25.y = param7;
                                            _loc_24 = _loc_25;
                                            if (!param12)
                                            {
                                            }
                                            if (param13)
                                            {
                                                _loc_24.forced = true;
                                            }
                                        }
                                        else if (_loc_29 == 6)
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param4;
                                            _loc_25.y = param7;
                                            _loc_24 = _loc_25;
                                            if (!param10)
                                            {
                                            }
                                            if (param13)
                                            {
                                                _loc_24.forced = true;
                                            }
                                        }
                                        else if (_loc_29 == 1)
                                        {
                                            _loc_24 = param3.list[(param9 << 1) * param3.width + param8];
                                            if (_loc_24 == null)
                                            {
                                                _loc_26 = xlerp(param4, param6, param5, _loc_16, _loc_17, param1, param14);
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_26;
                                                _loc_25.y = param5;
                                                _loc_24 = _loc_25;
                                                param3.list[(param9 << 1) * param3.width + param8] = _loc_24;
                                            }
                                            else
                                            {
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_24.x;
                                                _loc_25.y = _loc_24.y;
                                                _loc_24 = _loc_25;
                                            }
                                            if (param11)
                                            {
                                                _loc_24.forced = true;
                                            }
                                            if (_loc_24.x != param4)
                                            {
                                            }
                                            if (_loc_24.x == param6)
                                            {
                                                if (_loc_24.x == param4)
                                                {
                                                }
                                                if ((_loc_22 & 1) == 0)
                                                {
                                                    if (_loc_24.x == param6)
                                                    {
                                                    }
                                                }
                                                if ((_loc_22 & 4) != 0)
                                                {
                                                    _loc_22 = _loc_22 ^ 2;
                                                }
                                            }
                                        }
                                        else if (_loc_29 == 5)
                                        {
                                            _loc_24 = param3.list[((param9 << 1) + 2) * param3.width + param8];
                                            if (_loc_24 == null)
                                            {
                                                _loc_26 = xlerp(param4, param6, param7, _loc_19, _loc_18, param1, param14);
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_26;
                                                _loc_25.y = param7;
                                                _loc_24 = _loc_25;
                                                param3.list[((param9 << 1) + 2) * param3.width + param8] = _loc_24;
                                            }
                                            else
                                            {
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_24.x;
                                                _loc_25.y = _loc_24.y;
                                                _loc_24 = _loc_25;
                                            }
                                            if (param13)
                                            {
                                                _loc_24.forced = true;
                                            }
                                            if (_loc_24.x != param4)
                                            {
                                            }
                                            if (_loc_24.x == param6)
                                            {
                                                if (_loc_24.x == param4)
                                                {
                                                }
                                                if ((_loc_22 & 64) == 0)
                                                {
                                                    if (_loc_24.x == param6)
                                                    {
                                                    }
                                                }
                                                if ((_loc_22 & 16) != 0)
                                                {
                                                    _loc_22 = _loc_22 ^ 32;
                                                }
                                            }
                                        }
                                        else if (_loc_29 == 3)
                                        {
                                            _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)];
                                            if (_loc_24 == null)
                                            {
                                                _loc_26 = ylerp(param5, param7, param6, _loc_17, _loc_18, param1, param14);
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = param6;
                                                _loc_25.y = _loc_26;
                                                _loc_24 = _loc_25;
                                                param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)] = _loc_24;
                                            }
                                            else
                                            {
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_24.x;
                                                _loc_25.y = _loc_24.y;
                                                _loc_24 = _loc_25;
                                            }
                                            if (param12)
                                            {
                                                _loc_24.forced = true;
                                            }
                                            if (_loc_24.y != param5)
                                            {
                                            }
                                            if (_loc_24.y == param7)
                                            {
                                                if (_loc_24.y == param5)
                                                {
                                                }
                                                if ((_loc_22 & 4) == 0)
                                                {
                                                    if (_loc_24.y == param7)
                                                    {
                                                    }
                                                }
                                                if ((_loc_22 & 16) != 0)
                                                {
                                                    _loc_22 = _loc_22 ^ 8;
                                                }
                                            }
                                        }
                                        else
                                        {
                                            _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + param8];
                                            if (_loc_24 == null)
                                            {
                                                _loc_26 = ylerp(param5, param7, param4, _loc_16, _loc_19, param1, param14);
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = param4;
                                                _loc_25.y = _loc_26;
                                                _loc_24 = _loc_25;
                                                param3.list[((param9 << 1) + 1) * param3.width + param8] = _loc_24;
                                            }
                                            else
                                            {
                                                if (ZPP_GeomVert.zpp_pool == null)
                                                {
                                                    _loc_25 = new ZPP_GeomVert();
                                                }
                                                else
                                                {
                                                    _loc_25 = ZPP_GeomVert.zpp_pool;
                                                    ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                    _loc_25.next = null;
                                                }
                                                _loc_25.forced = false;
                                                _loc_25.x = _loc_24.x;
                                                _loc_25.y = _loc_24.y;
                                                _loc_24 = _loc_25;
                                            }
                                            if (param10)
                                            {
                                                _loc_24.forced = true;
                                            }
                                            if (_loc_24.y != param5)
                                            {
                                            }
                                            if (_loc_24.y == param7)
                                            {
                                                if (_loc_24.y == param5)
                                                {
                                                }
                                                if ((_loc_22 & 1) == 0)
                                                {
                                                    if (_loc_24.y == param7)
                                                    {
                                                    }
                                                }
                                                if ((_loc_22 & 64) != 0)
                                                {
                                                    _loc_22 = _loc_22 ^ 128;
                                                }
                                            }
                                        }
                                        _loc_25 = _loc_24;
                                        if (_loc_20.p1 == null)
                                        {
                                            _loc_27 = _loc_25;
                                            _loc_25.next = _loc_27;
                                            _loc_27 = _loc_27;
                                            _loc_25.prev = _loc_27;
                                            _loc_20.p1 = _loc_27;
                                        }
                                        else
                                        {
                                            _loc_25.prev = _loc_20.p1;
                                            _loc_25.next = _loc_20.p1.next;
                                            _loc_20.p1.next.prev = _loc_25;
                                            _loc_20.p1.next = _loc_25;
                                        }
                                        _loc_20.p1 = _loc_25;
                                    }
                                }
                                _loc_20.p1 = _loc_20.p1.next;
                                _loc_20.key1 = _loc_22;
                                if (_loc_22 != 1)
                                {
                                }
                                if (_loc_22 != 4)
                                {
                                }
                                if (_loc_22 != 16)
                                {
                                }
                                if (_loc_22 != 64)
                                {
                                }
                                if (_loc_22 != 3)
                                {
                                }
                                if (_loc_22 != 12)
                                {
                                }
                                if (_loc_22 != 48)
                                {
                                }
                                if (_loc_22 != 192)
                                {
                                }
                                if (_loc_22 != 129)
                                {
                                }
                                if (_loc_22 != 6)
                                {
                                }
                                if (_loc_22 != 24)
                                {
                                }
                                if (_loc_22 != 96)
                                {
                                }
                                if (_loc_22 != 5)
                                {
                                }
                                if (_loc_22 != 20)
                                {
                                }
                                if (_loc_22 != 80)
                                {
                                }
                                if (_loc_22 != 65)
                                {
                                }
                                if (_loc_22 != 17)
                                {
                                }
                                if (_loc_22 == 68)
                                {
                                    _loc_22 = 0;
                                    _loc_20.key1 = 0;
                                    _loc_20.p1 = null;
                                }
                                if (_loc_22 == 0)
                                {
                                    _loc_20 = null;
                                }
                                else
                                {
                                    _loc_20.pr = _loc_20.p1;
                                    _loc_20.okeyr = _loc_20.okey1;
                                    _loc_20.keyr = _loc_20.key1;
                                }
                            }
                        }
                    }
                    else if (_loc_28)
                    {
                        _loc_21 = 238;
                        _loc_20.okey1 = _loc_21;
                        _loc_22 = 0;
                        while (_loc_22 < 8)
                        {
                            
                            _loc_22++;
                            _loc_23 = _loc_22;
                            if ((_loc_21 & 1 << _loc_23) != 0)
                            {
                                _loc_24 = null;
                                if (_loc_23 == 0)
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = param4;
                                    _loc_25.y = param5;
                                    _loc_24 = _loc_25;
                                    if (!param10)
                                    {
                                    }
                                    if (param11)
                                    {
                                        _loc_24.forced = true;
                                    }
                                }
                                else if (_loc_23 == 2)
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = param6;
                                    _loc_25.y = param5;
                                    _loc_24 = _loc_25;
                                    if (!param12)
                                    {
                                    }
                                    if (param11)
                                    {
                                        _loc_24.forced = true;
                                    }
                                }
                                else if (_loc_23 == 4)
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = param6;
                                    _loc_25.y = param7;
                                    _loc_24 = _loc_25;
                                    if (!param12)
                                    {
                                    }
                                    if (param13)
                                    {
                                        _loc_24.forced = true;
                                    }
                                }
                                else if (_loc_23 == 6)
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = param4;
                                    _loc_25.y = param7;
                                    _loc_24 = _loc_25;
                                    if (!param10)
                                    {
                                    }
                                    if (param13)
                                    {
                                        _loc_24.forced = true;
                                    }
                                }
                                else if (_loc_23 == 1)
                                {
                                    _loc_24 = param3.list[(param9 << 1) * param3.width + param8];
                                    if (_loc_24 == null)
                                    {
                                        _loc_26 = xlerp(param4, param6, param5, _loc_16, _loc_17, param1, param14);
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_26;
                                        _loc_25.y = param5;
                                        _loc_24 = _loc_25;
                                        param3.list[(param9 << 1) * param3.width + param8] = _loc_24;
                                    }
                                    else
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_24.x;
                                        _loc_25.y = _loc_24.y;
                                        _loc_24 = _loc_25;
                                    }
                                    if (param11)
                                    {
                                        _loc_24.forced = true;
                                    }
                                    if (_loc_24.x != param4)
                                    {
                                    }
                                    if (_loc_24.x == param6)
                                    {
                                        if (_loc_24.x == param4)
                                        {
                                        }
                                        if ((_loc_21 & 1) == 0)
                                        {
                                            if (_loc_24.x == param6)
                                            {
                                            }
                                        }
                                        if ((_loc_21 & 4) != 0)
                                        {
                                            _loc_21 = _loc_21 ^ 2;
                                        }
                                    }
                                }
                                else if (_loc_23 == 5)
                                {
                                    _loc_24 = param3.list[((param9 << 1) + 2) * param3.width + param8];
                                    if (_loc_24 == null)
                                    {
                                        _loc_26 = xlerp(param4, param6, param7, _loc_19, _loc_18, param1, param14);
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_26;
                                        _loc_25.y = param7;
                                        _loc_24 = _loc_25;
                                        param3.list[((param9 << 1) + 2) * param3.width + param8] = _loc_24;
                                    }
                                    else
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_24.x;
                                        _loc_25.y = _loc_24.y;
                                        _loc_24 = _loc_25;
                                    }
                                    if (param13)
                                    {
                                        _loc_24.forced = true;
                                    }
                                    if (_loc_24.x != param4)
                                    {
                                    }
                                    if (_loc_24.x == param6)
                                    {
                                        if (_loc_24.x == param4)
                                        {
                                        }
                                        if ((_loc_21 & 64) == 0)
                                        {
                                            if (_loc_24.x == param6)
                                            {
                                            }
                                        }
                                        if ((_loc_21 & 16) != 0)
                                        {
                                            _loc_21 = _loc_21 ^ 32;
                                        }
                                    }
                                }
                                else if (_loc_23 == 3)
                                {
                                    _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)];
                                    if (_loc_24 == null)
                                    {
                                        _loc_26 = ylerp(param5, param7, param6, _loc_17, _loc_18, param1, param14);
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param6;
                                        _loc_25.y = _loc_26;
                                        _loc_24 = _loc_25;
                                        param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)] = _loc_24;
                                    }
                                    else
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_24.x;
                                        _loc_25.y = _loc_24.y;
                                        _loc_24 = _loc_25;
                                    }
                                    if (param12)
                                    {
                                        _loc_24.forced = true;
                                    }
                                    if (_loc_24.y != param5)
                                    {
                                    }
                                    if (_loc_24.y == param7)
                                    {
                                        if (_loc_24.y == param5)
                                        {
                                        }
                                        if ((_loc_21 & 4) == 0)
                                        {
                                            if (_loc_24.y == param7)
                                            {
                                            }
                                        }
                                        if ((_loc_21 & 16) != 0)
                                        {
                                            _loc_21 = _loc_21 ^ 8;
                                        }
                                    }
                                }
                                else
                                {
                                    _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + param8];
                                    if (_loc_24 == null)
                                    {
                                        _loc_26 = ylerp(param5, param7, param4, _loc_16, _loc_19, param1, param14);
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param4;
                                        _loc_25.y = _loc_26;
                                        _loc_24 = _loc_25;
                                        param3.list[((param9 << 1) + 1) * param3.width + param8] = _loc_24;
                                    }
                                    else
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_24.x;
                                        _loc_25.y = _loc_24.y;
                                        _loc_24 = _loc_25;
                                    }
                                    if (param10)
                                    {
                                        _loc_24.forced = true;
                                    }
                                    if (_loc_24.y != param5)
                                    {
                                    }
                                    if (_loc_24.y == param7)
                                    {
                                        if (_loc_24.y == param5)
                                        {
                                        }
                                        if ((_loc_21 & 1) == 0)
                                        {
                                            if (_loc_24.y == param7)
                                            {
                                            }
                                        }
                                        if ((_loc_21 & 64) != 0)
                                        {
                                            _loc_21 = _loc_21 ^ 128;
                                        }
                                    }
                                }
                                _loc_25 = _loc_24;
                                if (_loc_20.p1 == null)
                                {
                                    _loc_27 = _loc_25;
                                    _loc_25.next = _loc_27;
                                    _loc_27 = _loc_27;
                                    _loc_25.prev = _loc_27;
                                    _loc_20.p1 = _loc_27;
                                }
                                else
                                {
                                    _loc_25.prev = _loc_20.p1;
                                    _loc_25.next = _loc_20.p1.next;
                                    _loc_20.p1.next.prev = _loc_25;
                                    _loc_20.p1.next = _loc_25;
                                }
                                _loc_20.p1 = _loc_25;
                            }
                        }
                        _loc_20.p1 = _loc_20.p1.next;
                        _loc_20.key1 = _loc_21;
                        if (_loc_21 != 1)
                        {
                        }
                        if (_loc_21 != 4)
                        {
                        }
                        if (_loc_21 != 16)
                        {
                        }
                        if (_loc_21 != 64)
                        {
                        }
                        if (_loc_21 != 3)
                        {
                        }
                        if (_loc_21 != 12)
                        {
                        }
                        if (_loc_21 != 48)
                        {
                        }
                        if (_loc_21 != 192)
                        {
                        }
                        if (_loc_21 != 129)
                        {
                        }
                        if (_loc_21 != 6)
                        {
                        }
                        if (_loc_21 != 24)
                        {
                        }
                        if (_loc_21 != 96)
                        {
                        }
                        if (_loc_21 != 5)
                        {
                        }
                        if (_loc_21 != 20)
                        {
                        }
                        if (_loc_21 != 80)
                        {
                        }
                        if (_loc_21 != 65)
                        {
                        }
                        if (_loc_21 != 17)
                        {
                        }
                        if (_loc_21 == 68)
                        {
                            _loc_21 = 0;
                            _loc_20.key1 = 0;
                            _loc_20.p1 = null;
                        }
                        if (_loc_21 == 0)
                        {
                            _loc_20 = null;
                        }
                        else
                        {
                            _loc_20.pr = _loc_20.p1;
                            _loc_20.okeyr = _loc_20.okey1;
                            _loc_20.keyr = _loc_20.key1;
                        }
                    }
                    else
                    {
                        _loc_21 = 224;
                        _loc_20.okey1 = _loc_21;
                        _loc_22 = 0;
                        while (_loc_22 < 8)
                        {
                            
                            _loc_22++;
                            _loc_23 = _loc_22;
                            if ((_loc_21 & 1 << _loc_23) != 0)
                            {
                                _loc_24 = null;
                                if (_loc_23 == 0)
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = param4;
                                    _loc_25.y = param5;
                                    _loc_24 = _loc_25;
                                    if (!param10)
                                    {
                                    }
                                    if (param11)
                                    {
                                        _loc_24.forced = true;
                                    }
                                }
                                else if (_loc_23 == 2)
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = param6;
                                    _loc_25.y = param5;
                                    _loc_24 = _loc_25;
                                    if (!param12)
                                    {
                                    }
                                    if (param11)
                                    {
                                        _loc_24.forced = true;
                                    }
                                }
                                else if (_loc_23 == 4)
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = param6;
                                    _loc_25.y = param7;
                                    _loc_24 = _loc_25;
                                    if (!param12)
                                    {
                                    }
                                    if (param13)
                                    {
                                        _loc_24.forced = true;
                                    }
                                }
                                else if (_loc_23 == 6)
                                {
                                    if (ZPP_GeomVert.zpp_pool == null)
                                    {
                                        _loc_25 = new ZPP_GeomVert();
                                    }
                                    else
                                    {
                                        _loc_25 = ZPP_GeomVert.zpp_pool;
                                        ZPP_GeomVert.zpp_pool = _loc_25.next;
                                        _loc_25.next = null;
                                    }
                                    _loc_25.forced = false;
                                    _loc_25.x = param4;
                                    _loc_25.y = param7;
                                    _loc_24 = _loc_25;
                                    if (!param10)
                                    {
                                    }
                                    if (param13)
                                    {
                                        _loc_24.forced = true;
                                    }
                                }
                                else if (_loc_23 == 1)
                                {
                                    _loc_24 = param3.list[(param9 << 1) * param3.width + param8];
                                    if (_loc_24 == null)
                                    {
                                        _loc_26 = xlerp(param4, param6, param5, _loc_16, _loc_17, param1, param14);
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_26;
                                        _loc_25.y = param5;
                                        _loc_24 = _loc_25;
                                        param3.list[(param9 << 1) * param3.width + param8] = _loc_24;
                                    }
                                    else
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_24.x;
                                        _loc_25.y = _loc_24.y;
                                        _loc_24 = _loc_25;
                                    }
                                    if (param11)
                                    {
                                        _loc_24.forced = true;
                                    }
                                    if (_loc_24.x != param4)
                                    {
                                    }
                                    if (_loc_24.x == param6)
                                    {
                                        if (_loc_24.x == param4)
                                        {
                                        }
                                        if ((_loc_21 & 1) == 0)
                                        {
                                            if (_loc_24.x == param6)
                                            {
                                            }
                                        }
                                        if ((_loc_21 & 4) != 0)
                                        {
                                            _loc_21 = _loc_21 ^ 2;
                                        }
                                    }
                                }
                                else if (_loc_23 == 5)
                                {
                                    _loc_24 = param3.list[((param9 << 1) + 2) * param3.width + param8];
                                    if (_loc_24 == null)
                                    {
                                        _loc_26 = xlerp(param4, param6, param7, _loc_19, _loc_18, param1, param14);
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_26;
                                        _loc_25.y = param7;
                                        _loc_24 = _loc_25;
                                        param3.list[((param9 << 1) + 2) * param3.width + param8] = _loc_24;
                                    }
                                    else
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_24.x;
                                        _loc_25.y = _loc_24.y;
                                        _loc_24 = _loc_25;
                                    }
                                    if (param13)
                                    {
                                        _loc_24.forced = true;
                                    }
                                    if (_loc_24.x != param4)
                                    {
                                    }
                                    if (_loc_24.x == param6)
                                    {
                                        if (_loc_24.x == param4)
                                        {
                                        }
                                        if ((_loc_21 & 64) == 0)
                                        {
                                            if (_loc_24.x == param6)
                                            {
                                            }
                                        }
                                        if ((_loc_21 & 16) != 0)
                                        {
                                            _loc_21 = _loc_21 ^ 32;
                                        }
                                    }
                                }
                                else if (_loc_23 == 3)
                                {
                                    _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)];
                                    if (_loc_24 == null)
                                    {
                                        _loc_26 = ylerp(param5, param7, param6, _loc_17, _loc_18, param1, param14);
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param6;
                                        _loc_25.y = _loc_26;
                                        _loc_24 = _loc_25;
                                        param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)] = _loc_24;
                                    }
                                    else
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_24.x;
                                        _loc_25.y = _loc_24.y;
                                        _loc_24 = _loc_25;
                                    }
                                    if (param12)
                                    {
                                        _loc_24.forced = true;
                                    }
                                    if (_loc_24.y != param5)
                                    {
                                    }
                                    if (_loc_24.y == param7)
                                    {
                                        if (_loc_24.y == param5)
                                        {
                                        }
                                        if ((_loc_21 & 4) == 0)
                                        {
                                            if (_loc_24.y == param7)
                                            {
                                            }
                                        }
                                        if ((_loc_21 & 16) != 0)
                                        {
                                            _loc_21 = _loc_21 ^ 8;
                                        }
                                    }
                                }
                                else
                                {
                                    _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + param8];
                                    if (_loc_24 == null)
                                    {
                                        _loc_26 = ylerp(param5, param7, param4, _loc_16, _loc_19, param1, param14);
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param4;
                                        _loc_25.y = _loc_26;
                                        _loc_24 = _loc_25;
                                        param3.list[((param9 << 1) + 1) * param3.width + param8] = _loc_24;
                                    }
                                    else
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = _loc_24.x;
                                        _loc_25.y = _loc_24.y;
                                        _loc_24 = _loc_25;
                                    }
                                    if (param10)
                                    {
                                        _loc_24.forced = true;
                                    }
                                    if (_loc_24.y != param5)
                                    {
                                    }
                                    if (_loc_24.y == param7)
                                    {
                                        if (_loc_24.y == param5)
                                        {
                                        }
                                        if ((_loc_21 & 1) == 0)
                                        {
                                            if (_loc_24.y == param7)
                                            {
                                            }
                                        }
                                        if ((_loc_21 & 64) != 0)
                                        {
                                            _loc_21 = _loc_21 ^ 128;
                                        }
                                    }
                                }
                                _loc_25 = _loc_24;
                                if (_loc_20.p1 == null)
                                {
                                    _loc_27 = _loc_25;
                                    _loc_25.next = _loc_27;
                                    _loc_27 = _loc_27;
                                    _loc_25.prev = _loc_27;
                                    _loc_20.p1 = _loc_27;
                                }
                                else
                                {
                                    _loc_25.prev = _loc_20.p1;
                                    _loc_25.next = _loc_20.p1.next;
                                    _loc_20.p1.next.prev = _loc_25;
                                    _loc_20.p1.next = _loc_25;
                                }
                                _loc_20.p1 = _loc_25;
                            }
                        }
                        _loc_20.p1 = _loc_20.p1.next;
                        _loc_20.key1 = _loc_21;
                        if (_loc_21 != 1)
                        {
                        }
                        if (_loc_21 != 4)
                        {
                        }
                        if (_loc_21 != 16)
                        {
                        }
                        if (_loc_21 != 64)
                        {
                        }
                        if (_loc_21 != 3)
                        {
                        }
                        if (_loc_21 != 12)
                        {
                        }
                        if (_loc_21 != 48)
                        {
                        }
                        if (_loc_21 != 192)
                        {
                        }
                        if (_loc_21 != 129)
                        {
                        }
                        if (_loc_21 != 6)
                        {
                        }
                        if (_loc_21 != 24)
                        {
                        }
                        if (_loc_21 != 96)
                        {
                        }
                        if (_loc_21 != 5)
                        {
                        }
                        if (_loc_21 != 20)
                        {
                        }
                        if (_loc_21 != 80)
                        {
                        }
                        if (_loc_21 != 65)
                        {
                        }
                        if (_loc_21 != 17)
                        {
                        }
                        if (_loc_21 == 68)
                        {
                            _loc_21 = 0;
                            _loc_20.key1 = 0;
                            _loc_20.p1 = null;
                        }
                        if (_loc_21 != 0)
                        {
                            _loc_22 = 14;
                            _loc_20.okey2 = _loc_22;
                            _loc_23 = 0;
                            while (_loc_23 < 8)
                            {
                                
                                _loc_23++;
                                _loc_29 = _loc_23;
                                if ((_loc_22 & 1 << _loc_29) != 0)
                                {
                                    _loc_24 = null;
                                    if (_loc_29 == 0)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param4;
                                        _loc_25.y = param5;
                                        _loc_24 = _loc_25;
                                        if (!param10)
                                        {
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_29 == 2)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param6;
                                        _loc_25.y = param5;
                                        _loc_24 = _loc_25;
                                        if (!param12)
                                        {
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_29 == 4)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param6;
                                        _loc_25.y = param7;
                                        _loc_24 = _loc_25;
                                        if (!param12)
                                        {
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_29 == 6)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param4;
                                        _loc_25.y = param7;
                                        _loc_24 = _loc_25;
                                        if (!param10)
                                        {
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_29 == 1)
                                    {
                                        _loc_24 = param3.list[(param9 << 1) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = xlerp(param4, param6, param5, _loc_16, _loc_17, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_26;
                                            _loc_25.y = param5;
                                            _loc_24 = _loc_25;
                                            param3.list[(param9 << 1) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.x != param4)
                                        {
                                        }
                                        if (_loc_24.x == param6)
                                        {
                                            if (_loc_24.x == param4)
                                            {
                                            }
                                            if ((_loc_22 & 1) == 0)
                                            {
                                                if (_loc_24.x == param6)
                                                {
                                                }
                                            }
                                            if ((_loc_22 & 4) != 0)
                                            {
                                                _loc_22 = _loc_22 ^ 2;
                                            }
                                        }
                                    }
                                    else if (_loc_29 == 5)
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 2) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = xlerp(param4, param6, param7, _loc_19, _loc_18, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_26;
                                            _loc_25.y = param7;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 2) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.x != param4)
                                        {
                                        }
                                        if (_loc_24.x == param6)
                                        {
                                            if (_loc_24.x == param4)
                                            {
                                            }
                                            if ((_loc_22 & 64) == 0)
                                            {
                                                if (_loc_24.x == param6)
                                                {
                                                }
                                            }
                                            if ((_loc_22 & 16) != 0)
                                            {
                                                _loc_22 = _loc_22 ^ 32;
                                            }
                                        }
                                    }
                                    else if (_loc_29 == 3)
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = ylerp(param5, param7, param6, _loc_17, _loc_18, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param6;
                                            _loc_25.y = _loc_26;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param12)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.y != param5)
                                        {
                                        }
                                        if (_loc_24.y == param7)
                                        {
                                            if (_loc_24.y == param5)
                                            {
                                            }
                                            if ((_loc_22 & 4) == 0)
                                            {
                                                if (_loc_24.y == param7)
                                                {
                                                }
                                            }
                                            if ((_loc_22 & 16) != 0)
                                            {
                                                _loc_22 = _loc_22 ^ 8;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = ylerp(param5, param7, param4, _loc_16, _loc_19, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param4;
                                            _loc_25.y = _loc_26;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 1) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param10)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.y != param5)
                                        {
                                        }
                                        if (_loc_24.y == param7)
                                        {
                                            if (_loc_24.y == param5)
                                            {
                                            }
                                            if ((_loc_22 & 1) == 0)
                                            {
                                                if (_loc_24.y == param7)
                                                {
                                                }
                                            }
                                            if ((_loc_22 & 64) != 0)
                                            {
                                                _loc_22 = _loc_22 ^ 128;
                                            }
                                        }
                                    }
                                    _loc_25 = _loc_24;
                                    if (_loc_20.p2 == null)
                                    {
                                        _loc_27 = _loc_25;
                                        _loc_25.next = _loc_27;
                                        _loc_27 = _loc_27;
                                        _loc_25.prev = _loc_27;
                                        _loc_20.p2 = _loc_27;
                                    }
                                    else
                                    {
                                        _loc_25.prev = _loc_20.p2;
                                        _loc_25.next = _loc_20.p2.next;
                                        _loc_20.p2.next.prev = _loc_25;
                                        _loc_20.p2.next = _loc_25;
                                    }
                                    _loc_20.p2 = _loc_25;
                                }
                            }
                            _loc_20.p2 = _loc_20.p2.next;
                            _loc_20.key2 = _loc_22;
                            if (_loc_22 != 1)
                            {
                            }
                            if (_loc_22 != 4)
                            {
                            }
                            if (_loc_22 != 16)
                            {
                            }
                            if (_loc_22 != 64)
                            {
                            }
                            if (_loc_22 != 3)
                            {
                            }
                            if (_loc_22 != 12)
                            {
                            }
                            if (_loc_22 != 48)
                            {
                            }
                            if (_loc_22 != 192)
                            {
                            }
                            if (_loc_22 != 129)
                            {
                            }
                            if (_loc_22 != 6)
                            {
                            }
                            if (_loc_22 != 24)
                            {
                            }
                            if (_loc_22 != 96)
                            {
                            }
                            if (_loc_22 != 5)
                            {
                            }
                            if (_loc_22 != 20)
                            {
                            }
                            if (_loc_22 != 80)
                            {
                            }
                            if (_loc_22 != 65)
                            {
                            }
                            if (_loc_22 != 17)
                            {
                            }
                            if (_loc_22 == 68)
                            {
                                _loc_22 = 0;
                                _loc_20.key2 = 0;
                                _loc_20.p2 = null;
                            }
                            if (_loc_22 == 0)
                            {
                                _loc_20.pr = _loc_20.p1;
                                _loc_20.okeyr = _loc_20.okey1;
                                _loc_20.keyr = _loc_20.key1;
                            }
                            else
                            {
                                _loc_20.pr = _loc_20.p2;
                                _loc_20.okeyr = _loc_20.okey2;
                                _loc_20.keyr = _loc_20.key2;
                            }
                        }
                        else
                        {
                            _loc_22 = 14;
                            _loc_20.okey1 = _loc_22;
                            _loc_23 = 0;
                            while (_loc_23 < 8)
                            {
                                
                                _loc_23++;
                                _loc_29 = _loc_23;
                                if ((_loc_22 & 1 << _loc_29) != 0)
                                {
                                    _loc_24 = null;
                                    if (_loc_29 == 0)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param4;
                                        _loc_25.y = param5;
                                        _loc_24 = _loc_25;
                                        if (!param10)
                                        {
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_29 == 2)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param6;
                                        _loc_25.y = param5;
                                        _loc_24 = _loc_25;
                                        if (!param12)
                                        {
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_29 == 4)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param6;
                                        _loc_25.y = param7;
                                        _loc_24 = _loc_25;
                                        if (!param12)
                                        {
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_29 == 6)
                                    {
                                        if (ZPP_GeomVert.zpp_pool == null)
                                        {
                                            _loc_25 = new ZPP_GeomVert();
                                        }
                                        else
                                        {
                                            _loc_25 = ZPP_GeomVert.zpp_pool;
                                            ZPP_GeomVert.zpp_pool = _loc_25.next;
                                            _loc_25.next = null;
                                        }
                                        _loc_25.forced = false;
                                        _loc_25.x = param4;
                                        _loc_25.y = param7;
                                        _loc_24 = _loc_25;
                                        if (!param10)
                                        {
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                    }
                                    else if (_loc_29 == 1)
                                    {
                                        _loc_24 = param3.list[(param9 << 1) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = xlerp(param4, param6, param5, _loc_16, _loc_17, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_26;
                                            _loc_25.y = param5;
                                            _loc_24 = _loc_25;
                                            param3.list[(param9 << 1) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param11)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.x != param4)
                                        {
                                        }
                                        if (_loc_24.x == param6)
                                        {
                                            if (_loc_24.x == param4)
                                            {
                                            }
                                            if ((_loc_22 & 1) == 0)
                                            {
                                                if (_loc_24.x == param6)
                                                {
                                                }
                                            }
                                            if ((_loc_22 & 4) != 0)
                                            {
                                                _loc_22 = _loc_22 ^ 2;
                                            }
                                        }
                                    }
                                    else if (_loc_29 == 5)
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 2) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = xlerp(param4, param6, param7, _loc_19, _loc_18, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_26;
                                            _loc_25.y = param7;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 2) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param13)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.x != param4)
                                        {
                                        }
                                        if (_loc_24.x == param6)
                                        {
                                            if (_loc_24.x == param4)
                                            {
                                            }
                                            if ((_loc_22 & 64) == 0)
                                            {
                                                if (_loc_24.x == param6)
                                                {
                                                }
                                            }
                                            if ((_loc_22 & 16) != 0)
                                            {
                                                _loc_22 = _loc_22 ^ 32;
                                            }
                                        }
                                    }
                                    else if (_loc_29 == 3)
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = ylerp(param5, param7, param6, _loc_17, _loc_18, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param6;
                                            _loc_25.y = _loc_26;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 1) * param3.width + (param8 + 1)] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param12)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.y != param5)
                                        {
                                        }
                                        if (_loc_24.y == param7)
                                        {
                                            if (_loc_24.y == param5)
                                            {
                                            }
                                            if ((_loc_22 & 4) == 0)
                                            {
                                                if (_loc_24.y == param7)
                                                {
                                                }
                                            }
                                            if ((_loc_22 & 16) != 0)
                                            {
                                                _loc_22 = _loc_22 ^ 8;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        _loc_24 = param3.list[((param9 << 1) + 1) * param3.width + param8];
                                        if (_loc_24 == null)
                                        {
                                            _loc_26 = ylerp(param5, param7, param4, _loc_16, _loc_19, param1, param14);
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = param4;
                                            _loc_25.y = _loc_26;
                                            _loc_24 = _loc_25;
                                            param3.list[((param9 << 1) + 1) * param3.width + param8] = _loc_24;
                                        }
                                        else
                                        {
                                            if (ZPP_GeomVert.zpp_pool == null)
                                            {
                                                _loc_25 = new ZPP_GeomVert();
                                            }
                                            else
                                            {
                                                _loc_25 = ZPP_GeomVert.zpp_pool;
                                                ZPP_GeomVert.zpp_pool = _loc_25.next;
                                                _loc_25.next = null;
                                            }
                                            _loc_25.forced = false;
                                            _loc_25.x = _loc_24.x;
                                            _loc_25.y = _loc_24.y;
                                            _loc_24 = _loc_25;
                                        }
                                        if (param10)
                                        {
                                            _loc_24.forced = true;
                                        }
                                        if (_loc_24.y != param5)
                                        {
                                        }
                                        if (_loc_24.y == param7)
                                        {
                                            if (_loc_24.y == param5)
                                            {
                                            }
                                            if ((_loc_22 & 1) == 0)
                                            {
                                                if (_loc_24.y == param7)
                                                {
                                                }
                                            }
                                            if ((_loc_22 & 64) != 0)
                                            {
                                                _loc_22 = _loc_22 ^ 128;
                                            }
                                        }
                                    }
                                    _loc_25 = _loc_24;
                                    if (_loc_20.p1 == null)
                                    {
                                        _loc_27 = _loc_25;
                                        _loc_25.next = _loc_27;
                                        _loc_27 = _loc_27;
                                        _loc_25.prev = _loc_27;
                                        _loc_20.p1 = _loc_27;
                                    }
                                    else
                                    {
                                        _loc_25.prev = _loc_20.p1;
                                        _loc_25.next = _loc_20.p1.next;
                                        _loc_20.p1.next.prev = _loc_25;
                                        _loc_20.p1.next = _loc_25;
                                    }
                                    _loc_20.p1 = _loc_25;
                                }
                            }
                            _loc_20.p1 = _loc_20.p1.next;
                            _loc_20.key1 = _loc_22;
                            if (_loc_22 != 1)
                            {
                            }
                            if (_loc_22 != 4)
                            {
                            }
                            if (_loc_22 != 16)
                            {
                            }
                            if (_loc_22 != 64)
                            {
                            }
                            if (_loc_22 != 3)
                            {
                            }
                            if (_loc_22 != 12)
                            {
                            }
                            if (_loc_22 != 48)
                            {
                            }
                            if (_loc_22 != 192)
                            {
                            }
                            if (_loc_22 != 129)
                            {
                            }
                            if (_loc_22 != 6)
                            {
                            }
                            if (_loc_22 != 24)
                            {
                            }
                            if (_loc_22 != 96)
                            {
                            }
                            if (_loc_22 != 5)
                            {
                            }
                            if (_loc_22 != 20)
                            {
                            }
                            if (_loc_22 != 80)
                            {
                            }
                            if (_loc_22 != 65)
                            {
                            }
                            if (_loc_22 != 17)
                            {
                            }
                            if (_loc_22 == 68)
                            {
                                _loc_22 = 0;
                                _loc_20.key1 = 0;
                                _loc_20.p1 = null;
                            }
                            if (_loc_22 == 0)
                            {
                                _loc_20 = null;
                            }
                            else
                            {
                                _loc_20.pr = _loc_20.p1;
                                _loc_20.okeyr = _loc_20.okey1;
                                _loc_20.keyr = _loc_20.key1;
                            }
                        }
                    }
                }
                return _loc_20;
            }
        }// end function

        public function linkup(param1:ZPP_GeomVert, param2:int) : ZPP_GeomVert
        {
            return param1;
        }// end function

        public function linkright(param1:ZPP_GeomVert, param2:int) : ZPP_GeomVert
        {
            var _loc_3:* = param2 & 7;
            if (_loc_3 == 0)
            {
                return param1;
            }
            else if (_loc_3 == 3)
            {
                return param1.next.next;
            }
            else
            {
                return param1.next;
            }
        }// end function

        public function linkleft(param1:ZPP_GeomVert, param2:int) : ZPP_GeomVert
        {
            if ((param2 & 1) == 0)
            {
                return param1.prev;
            }
            else
            {
                return param1;
            }
        }// end function

        public function linkdown(param1:ZPP_GeomVert, param2:int) : ZPP_GeomVert
        {
            if ((param2 & 128) == 0)
            {
                return param1.prev;
            }
            else
            {
                return param1.prev.prev;
            }
        }// end function

        public function lerp(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            if (param3 == 0)
            {
                return param1;
            }
            else if (param4 == 0)
            {
                return param2;
            }
            else
            {
                _loc_5 = param3 - param4;
                if (_loc_5 * _loc_5 < Config.epsilon * Config.epsilon)
                {
                    _loc_6 = 0.5;
                }
                else
                {
                    _loc_6 = param3 / _loc_5;
                }
                if (_loc_6 < 0)
                {
                    _loc_6 = 0;
                }
                else if (_loc_6 > 1)
                {
                    _loc_6 = 1;
                }
                return param1 + _loc_6 * (param2 - param1);
            }
        }// end function

        public function combUp(param1:int) : Boolean
        {
            var _loc_2:* = param1 & 7;
            var _loc_3:* = 0;
            if ((_loc_2 & 1) != 0)
            {
                _loc_3++;
            }
            if ((_loc_2 & 2) != 0)
            {
                _loc_3++;
            }
            if ((_loc_2 & 4) != 0)
            {
                _loc_3++;
            }
            return _loc_3 >= 2;
        }// end function

        public function combUD_virtual(param1:ZPP_MarchPair, param2:ZPP_MarchPair) : void
        {
            var _loc_3:* = null as ZPP_GeomVert;
            var _loc_4:* = null as ZPP_GeomVert;
            if (param1.p2 != null)
            {
            }
            if (param1.key2 == 56)
            {
                _loc_3 = param1.p2;
            }
            else
            {
                _loc_3 = param1.p1;
            }
            if (param2.p2 != null)
            {
            }
            if (param2.key2 == 14)
            {
                _loc_4 = param2.p2;
            }
            else
            {
                _loc_4 = param2.p1;
            }
            var _loc_5:* = param1.pd;
            var _loc_6:* = _loc_4;
            var _loc_7:* = _loc_5.prev;
            var _loc_8:* = _loc_6.next;
            var _loc_9:* = true;
            _loc_8.forced = true;
            _loc_9 = _loc_9;
            _loc_7.forced = _loc_9;
            _loc_9 = _loc_9;
            _loc_6.forced = _loc_9;
            _loc_5.forced = _loc_9;
            return;
        }// end function

        public function combUD(param1:ZPP_MarchPair, param2:ZPP_MarchPair) : void
        {
            var _loc_3:* = null as ZPP_GeomVert;
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_10:* = null as Vec2;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as Vec2;
            var _loc_13:* = null as ZPP_Vec2;
            if (param1.p2 != null)
            {
            }
            if (param1.key2 == 56)
            {
                _loc_3 = param1.p2;
            }
            else
            {
                _loc_3 = param1.p1;
            }
            if (param2.p2 != null)
            {
            }
            if (param2.key2 == 14)
            {
                _loc_4 = param2.p2;
            }
            else
            {
                _loc_4 = param2.p1;
            }
            var _loc_5:* = param1.pd;
            var _loc_6:* = _loc_4;
            var _loc_7:* = _loc_5.prev;
            var _loc_8:* = _loc_6.next;
            _loc_6.next = _loc_5.next;
            _loc_5.next.prev = _loc_6;
            var _loc_9:* = _loc_5;
            if (_loc_9.wrap != null)
            {
                _loc_9.wrap.zpp_inner._inuse = false;
                _loc_10 = _loc_9.wrap;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_10.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_11 = _loc_10.zpp_inner;
                _loc_10.zpp_inner.outer = null;
                _loc_10.zpp_inner = null;
                _loc_12 = _loc_10;
                _loc_12.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_12;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_12;
                }
                ZPP_PubPool.nextVec2 = _loc_12;
                _loc_12.zpp_disp = true;
                _loc_13 = _loc_11;
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
                _loc_9.wrap = null;
            }
            var _loc_14:* = null;
            _loc_9.next = null;
            _loc_9.prev = _loc_14;
            _loc_9.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc_9;
            _loc_8.prev = _loc_7.prev;
            _loc_7.prev.next = _loc_8;
            if (_loc_7 == param1.p1)
            {
                param1.p1 = _loc_8;
            }
            _loc_9 = _loc_7;
            if (_loc_9.wrap != null)
            {
                _loc_9.wrap.zpp_inner._inuse = false;
                _loc_10 = _loc_9.wrap;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_10.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_11 = _loc_10.zpp_inner;
                _loc_10.zpp_inner.outer = null;
                _loc_10.zpp_inner = null;
                _loc_12 = _loc_10;
                _loc_12.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_12;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_12;
                }
                ZPP_PubPool.nextVec2 = _loc_12;
                _loc_12.zpp_disp = true;
                _loc_13 = _loc_11;
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
                _loc_9.wrap = null;
            }
            _loc_14 = null;
            _loc_9.next = _loc_14;
            _loc_9.prev = _loc_14;
            _loc_9.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc_9;
            return;
        }// end function

        public function combRight(param1:int) : Boolean
        {
            var _loc_2:* = (param1 & 28) >> 2;
            var _loc_3:* = 0;
            if ((_loc_2 & 1) != 0)
            {
                _loc_3++;
            }
            if ((_loc_2 & 2) != 0)
            {
                _loc_3++;
            }
            if ((_loc_2 & 4) != 0)
            {
                _loc_3++;
            }
            return _loc_3 >= 2;
        }// end function

        public function combLeft(param1:int) : Boolean
        {
            var _loc_2:* = param1 & 1 | (param1 & 192) >> 5;
            var _loc_3:* = 0;
            if ((_loc_2 & 1) != 0)
            {
                _loc_3++;
            }
            if ((_loc_2 & 2) != 0)
            {
                _loc_3++;
            }
            if ((_loc_2 & 4) != 0)
            {
                _loc_3++;
            }
            return _loc_3 >= 2;
        }// end function

        public function combLR(param1:ZPP_MarchPair, param2:ZPP_MarchPair) : void
        {
            var _loc_3:* = null as ZPP_GeomVert;
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_8:* = null as ZPP_GeomVert;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_13:* = null as ZPP_GeomVert;
            _loc_4 = param1.pr;
            var _loc_5:* = param1.okeyr & 7;
            if (_loc_5 == 0)
            {
                _loc_3 = _loc_4;
            }
            else if (_loc_5 == 3)
            {
                _loc_3 = _loc_4.next.next;
            }
            else
            {
                _loc_3 = _loc_4.next;
            }
            var _loc_6:* = param2.p1;
            if ((param2.okey1 & 1) == 0)
            {
                _loc_4 = _loc_6.prev;
            }
            else
            {
                _loc_4 = _loc_6;
            }
            _loc_6 = _loc_3.next;
            var _loc_7:* = _loc_4.prev;
            if ((param1.keyr & 4) != 0)
            {
                if (param2.pr == param2.p1)
                {
                    param2.pr = _loc_3.prev;
                }
                param2.p1 = _loc_3.prev;
                _loc_3.prev.next = _loc_4.next;
                _loc_4.next.prev = _loc_3.prev;
                _loc_8 = _loc_3;
                if (_loc_8.wrap != null)
                {
                    _loc_8.wrap.zpp_inner._inuse = false;
                    _loc_9 = _loc_8.wrap;
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_9.zpp_inner;
                    if (_loc_10._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_10._isimmutable != null)
                    {
                        _loc_10._isimmutable();
                    }
                    if (_loc_9.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_10 = _loc_9.zpp_inner;
                    _loc_9.zpp_inner.outer = null;
                    _loc_9.zpp_inner = null;
                    _loc_11 = _loc_9;
                    _loc_11.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_11;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_11;
                    }
                    ZPP_PubPool.nextVec2 = _loc_11;
                    _loc_11.zpp_disp = true;
                    _loc_12 = _loc_10;
                    if (_loc_12.outer != null)
                    {
                        _loc_12.outer.zpp_inner = null;
                        _loc_12.outer = null;
                    }
                    _loc_12._isimmutable = null;
                    _loc_12._validate = null;
                    _loc_12._invalidate = null;
                    _loc_12.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_12;
                    _loc_8.wrap = null;
                }
                _loc_13 = null;
                _loc_8.next = _loc_13;
                _loc_8.prev = _loc_13;
                _loc_8.next = ZPP_GeomVert.zpp_pool;
                ZPP_GeomVert.zpp_pool = _loc_8;
            }
            else
            {
                _loc_3.next = _loc_4.next;
                _loc_4.next.prev = _loc_3;
            }
            _loc_8 = _loc_4;
            if (_loc_8.wrap != null)
            {
                _loc_8.wrap.zpp_inner._inuse = false;
                _loc_9 = _loc_8.wrap;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_9.zpp_inner;
                if (_loc_10._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_10._isimmutable != null)
                {
                    _loc_10._isimmutable();
                }
                if (_loc_9.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_10 = _loc_9.zpp_inner;
                _loc_9.zpp_inner.outer = null;
                _loc_9.zpp_inner = null;
                _loc_11 = _loc_9;
                _loc_11.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_11;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_11;
                }
                ZPP_PubPool.nextVec2 = _loc_11;
                _loc_11.zpp_disp = true;
                _loc_12 = _loc_10;
                if (_loc_12.outer != null)
                {
                    _loc_12.outer.zpp_inner = null;
                    _loc_12.outer = null;
                }
                _loc_12._isimmutable = null;
                _loc_12._validate = null;
                _loc_12._invalidate = null;
                _loc_12.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_12;
                _loc_8.wrap = null;
            }
            _loc_13 = null;
            _loc_8.next = _loc_13;
            _loc_8.prev = _loc_13;
            _loc_8.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc_8;
            if ((param1.keyr & 16) != 0)
            {
                param2.pd = _loc_6.next;
                _loc_6.next.prev = _loc_7.prev;
                _loc_7.prev.next = _loc_6.next;
                _loc_8 = _loc_6;
                if (_loc_8.wrap != null)
                {
                    _loc_8.wrap.zpp_inner._inuse = false;
                    _loc_9 = _loc_8.wrap;
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_9.zpp_inner;
                    if (_loc_10._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_10._isimmutable != null)
                    {
                        _loc_10._isimmutable();
                    }
                    if (_loc_9.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_10 = _loc_9.zpp_inner;
                    _loc_9.zpp_inner.outer = null;
                    _loc_9.zpp_inner = null;
                    _loc_11 = _loc_9;
                    _loc_11.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_11;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_11;
                    }
                    ZPP_PubPool.nextVec2 = _loc_11;
                    _loc_11.zpp_disp = true;
                    _loc_12 = _loc_10;
                    if (_loc_12.outer != null)
                    {
                        _loc_12.outer.zpp_inner = null;
                        _loc_12.outer = null;
                    }
                    _loc_12._isimmutable = null;
                    _loc_12._validate = null;
                    _loc_12._invalidate = null;
                    _loc_12.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_12;
                    _loc_8.wrap = null;
                }
                _loc_13 = null;
                _loc_8.next = _loc_13;
                _loc_8.prev = _loc_13;
                _loc_8.next = ZPP_GeomVert.zpp_pool;
                ZPP_GeomVert.zpp_pool = _loc_8;
            }
            else
            {
                _loc_6.prev = _loc_7.prev;
                _loc_7.prev.next = _loc_6;
            }
            _loc_8 = _loc_7;
            if (_loc_8.wrap != null)
            {
                _loc_8.wrap.zpp_inner._inuse = false;
                _loc_9 = _loc_8.wrap;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_9.zpp_inner;
                if (_loc_10._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_10._isimmutable != null)
                {
                    _loc_10._isimmutable();
                }
                if (_loc_9.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_10 = _loc_9.zpp_inner;
                _loc_9.zpp_inner.outer = null;
                _loc_9.zpp_inner = null;
                _loc_11 = _loc_9;
                _loc_11.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_11;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_11;
                }
                ZPP_PubPool.nextVec2 = _loc_11;
                _loc_11.zpp_disp = true;
                _loc_12 = _loc_10;
                if (_loc_12.outer != null)
                {
                    _loc_12.outer.zpp_inner = null;
                    _loc_12.outer = null;
                }
                _loc_12._isimmutable = null;
                _loc_12._validate = null;
                _loc_12._invalidate = null;
                _loc_12.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_12;
                _loc_8.wrap = null;
            }
            _loc_13 = null;
            _loc_8.next = _loc_13;
            _loc_8.prev = _loc_13;
            _loc_8.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc_8;
            return;
        }// end function

        public function combDown(param1:int) : Boolean
        {
            var _loc_2:* = (param1 & 112) >> 4;
            var _loc_3:* = 0;
            if ((_loc_2 & 1) != 0)
            {
                _loc_3++;
            }
            if ((_loc_2 & 2) != 0)
            {
                _loc_3++;
            }
            if ((_loc_2 & 4) != 0)
            {
                _loc_3++;
            }
            return _loc_3 >= 2;
        }// end function

        public function comb(param1:int) : Boolean
        {
            var _loc_2:* = 0;
            if ((param1 & 1) != 0)
            {
                _loc_2++;
            }
            if ((param1 & 2) != 0)
            {
                _loc_2++;
            }
            if ((param1 & 4) != 0)
            {
                _loc_2++;
            }
            return _loc_2 >= 2;
        }// end function

        public static function run(param1:IsoFunction, param2:Number, param3:Number, param4:Number, param5:Number, param6:Vec2, param7:int, param8:Boolean, param9:GeomPolyList) : void
        {
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = NaN;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = NaN;
            var _loc_23:* = null as ZNPArray2_Float;
            var _loc_24:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = null as ZPP_MarchPair;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = false;
            var _loc_31:* = false;
            var _loc_32:* = false;
            var _loc_33:* = false;
            var _loc_34:* = null as ZPP_MarchPair;
            var _loc_35:* = null as ZPP_GeomVert;
            var _loc_36:* = null as ZNPArray2_ZPP_MarchPair;
            var _loc_37:* = 0;
            var _loc_38:* = null as ZPP_MarchSpan;
            var _loc_39:* = null as ZPP_MarchPair;
            var _loc_40:* = 0;
            var _loc_41:* = null as ZPP_MarchSpan;
            var _loc_42:* = null as ZPP_MarchSpan;
            var _loc_43:* = null as ZPP_MarchSpan;
            var _loc_44:* = null as ZPP_MarchSpan;
            var _loc_45:* = null as ZPP_MarchSpan;
            var _loc_46:* = null as ZPP_MarchSpan;
            var _loc_47:* = null as ZPP_MarchSpan;
            if (param6 != null)
            {
            }
            if (param6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = param6.zpp_inner;
            if (_loc_11._validate != null)
            {
                _loc_11._validate();
            }
            var _loc_10:* = (param4 - param2) / param6.zpp_inner.x;
            var _loc_12:* = _loc_10;
            if (param6 != null)
            {
            }
            if (param6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_11 = param6.zpp_inner;
            if (_loc_11._validate != null)
            {
                _loc_11._validate();
            }
            var _loc_13:* = (param5 - param3) / param6.zpp_inner.y;
            var _loc_14:* = _loc_13;
            if (_loc_10 != _loc_12)
            {
                _loc_12++;
            }
            if (_loc_13 != _loc_14)
            {
                _loc_14++;
            }
            if (param8)
            {
                if (ZPP_MarchingSquares.map == null)
                {
                    ZPP_MarchingSquares.map = new ZNPArray2_ZPP_MarchPair(_loc_12, _loc_14);
                }
                else
                {
                    ZPP_MarchingSquares.map.resize(_loc_12, _loc_14, null);
                }
            }
            if (ZPP_MarchingSquares.isos == null)
            {
                ZPP_MarchingSquares.isos = new ZNPArray2_Float((_loc_12 + 1), (_loc_14 + 1));
            }
            else
            {
                ZPP_MarchingSquares.isos.resize((_loc_12 + 1), (_loc_14 + 1), 0);
            }
            var _loc_15:* = 0;
            _loc_16 = _loc_14 + 1;
            while (_loc_15 < _loc_16)
            {
                
                _loc_15++;
                _loc_17 = _loc_15;
                if (_loc_17 == 0)
                {
                    _loc_18 = param3;
                }
                else if (_loc_17 <= _loc_14)
                {
                    if (param6 != null)
                    {
                    }
                    if (param6.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = param6.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    _loc_18 = param3 + param6.zpp_inner.y * _loc_17;
                }
                else
                {
                    _loc_18 = param5;
                }
                _loc_19 = 0;
                _loc_20 = _loc_12 + 1;
                while (_loc_19 < _loc_20)
                {
                    
                    _loc_19++;
                    _loc_21 = _loc_19;
                    if (_loc_21 == 0)
                    {
                        _loc_22 = param2;
                    }
                    else if (_loc_21 <= _loc_12)
                    {
                        if (param6 != null)
                        {
                        }
                        if (param6.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = param6.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                        _loc_22 = param2 + param6.zpp_inner.x * _loc_21;
                    }
                    else
                    {
                        _loc_22 = param4;
                    }
                    _loc_23 = ZPP_MarchingSquares.isos;
                    _loc_24 = param1.iso(_loc_22, _loc_18);
                    _loc_23.list[_loc_17 * _loc_23.width + _loc_21] = _loc_24;
                }
            }
            if (ZPP_MarchingSquares.ints == null)
            {
                ZPP_MarchingSquares.ints = new ZNPArray2_ZPP_GeomVert((_loc_12 + 1), (_loc_14 << 1) + 1);
            }
            else
            {
                ZPP_MarchingSquares.ints.resize((_loc_12 + 1), (_loc_14 << 1) + 1, null);
            }
            var _loc_25:* = null;
            if (param8)
            {
                if (ZPP_MarchSpan.zpp_pool == null)
                {
                    _loc_25 = new ZPP_MarchSpan();
                }
                else
                {
                    _loc_25 = ZPP_MarchSpan.zpp_pool;
                    ZPP_MarchSpan.zpp_pool = _loc_25.next;
                    _loc_25.next = null;
                }
                _loc_25.out = false;
                _loc_25.rank = 0;
            }
            _loc_18 = param3;
            _loc_15 = 0;
            while (_loc_15 < _loc_14)
            {
                
                _loc_15++;
                _loc_16 = _loc_15;
                _loc_22 = _loc_18;
                if (_loc_16 == (_loc_14 - 1))
                {
                    _loc_24 = param5;
                }
                else
                {
                    if (param6 != null)
                    {
                    }
                    if (param6.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = param6.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    _loc_24 = param3 + param6.zpp_inner.y * (_loc_16 + 1);
                }
                _loc_18 = _loc_24;
                _loc_26 = param2;
                _loc_27 = null;
                _loc_17 = 0;
                while (_loc_17 < _loc_12)
                {
                    
                    _loc_17++;
                    _loc_19 = _loc_17;
                    _loc_28 = _loc_26;
                    if (_loc_19 == (_loc_12 - 1))
                    {
                        _loc_29 = param4;
                    }
                    else
                    {
                        if (param6 != null)
                        {
                        }
                        if (param6.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = param6.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                        _loc_29 = param2 + param6.zpp_inner.x * (_loc_19 + 1);
                    }
                    _loc_26 = _loc_29;
                    if (_loc_19 != 0)
                    {
                    }
                    _loc_30 = !param8;
                    if (_loc_16 != 0)
                    {
                    }
                    _loc_31 = !param8;
                    if (_loc_19 != (_loc_12 - 1))
                    {
                    }
                    _loc_32 = !param8;
                    if (_loc_16 != (_loc_14 - 1))
                    {
                    }
                    _loc_33 = !param8;
                    _loc_34 = ZPP_MarchingSquares.me.marchSquare(param1, ZPP_MarchingSquares.isos, ZPP_MarchingSquares.ints, _loc_28, _loc_22, _loc_29, _loc_24, _loc_19, _loc_16, _loc_30, _loc_31, _loc_32, _loc_33, param7);
                    if (_loc_34 == null)
                    {
                        _loc_27 = null;
                        continue;
                    }
                    if (param8)
                    {
                        if (_loc_34.p2 != null)
                        {
                        }
                        if (_loc_34.okey2 != 14)
                        {
                            _loc_35 = _loc_34.p2;
                        }
                        else
                        {
                            _loc_35 = _loc_34.p1;
                        }
                        if (((_loc_35 == _loc_34.p2 ? (_loc_34.okey2) : (_loc_34.okey1)) & 128) == 0)
                        {
                            _loc_34.pd = _loc_35.prev;
                        }
                        else
                        {
                            _loc_34.pd = _loc_35.prev.prev;
                        }
                        _loc_36 = ZPP_MarchingSquares.map;
                        _loc_36.list[_loc_16 * _loc_36.width + _loc_19] = _loc_34;
                        if (_loc_27 != null)
                        {
                            _loc_20 = _loc_34.key1;
                            _loc_21 = _loc_20 & 1 | (_loc_20 & 192) >> 5;
                            _loc_37 = 0;
                            if ((_loc_21 & 1) != 0)
                            {
                                _loc_37++;
                            }
                            if ((_loc_21 & 2) != 0)
                            {
                                _loc_37++;
                            }
                            if ((_loc_21 & 4) != 0)
                            {
                                _loc_37++;
                            }
                        }
                        if (_loc_37 >= 2)
                        {
                            ZPP_MarchingSquares.me.combLR(_loc_27, _loc_34);
                            _loc_34.span1 = _loc_27.spanr;
                        }
                        else
                        {
                            if (ZPP_MarchSpan.zpp_pool == null)
                            {
                                _loc_34.span1 = new ZPP_MarchSpan();
                            }
                            else
                            {
                                _loc_34.span1 = ZPP_MarchSpan.zpp_pool;
                                ZPP_MarchSpan.zpp_pool = _loc_34.span1.next;
                                _loc_34.span1.next = null;
                            }
                            _loc_38 = _loc_34.span1;
                            _loc_38.out = false;
                            _loc_38.rank = 0;
                            _loc_34.span1.next = _loc_25;
                            _loc_25 = _loc_34.span1;
                        }
                        if (_loc_34.p2 != null)
                        {
                            if (ZPP_MarchSpan.zpp_pool == null)
                            {
                                _loc_34.span2 = new ZPP_MarchSpan();
                            }
                            else
                            {
                                _loc_34.span2 = ZPP_MarchSpan.zpp_pool;
                                ZPP_MarchSpan.zpp_pool = _loc_34.span2.next;
                                _loc_34.span2.next = null;
                            }
                            _loc_38 = _loc_34.span2;
                            _loc_38.out = false;
                            _loc_38.rank = 0;
                            _loc_34.span2.next = _loc_25;
                            _loc_25 = _loc_34.span2;
                            _loc_34.spanr = _loc_34.span2;
                        }
                        else
                        {
                            _loc_34.spanr = _loc_34.span1;
                        }
                        _loc_20 = (_loc_34.keyr & 28) >> 2;
                        _loc_21 = 0;
                        if ((_loc_20 & 1) != 0)
                        {
                            _loc_21++;
                        }
                        if ((_loc_20 & 2) != 0)
                        {
                            _loc_21++;
                        }
                        if ((_loc_20 & 4) != 0)
                        {
                            _loc_21++;
                        }
                        if (_loc_21 >= 2)
                        {
                            _loc_27 = _loc_34;
                        }
                        else
                        {
                            _loc_27 = null;
                        }
                        continue;
                    }
                    ZPP_MarchingSquares.me.output(param9, _loc_34.p1);
                    if (_loc_34.p2 != null)
                    {
                        ZPP_MarchingSquares.me.output(param9, _loc_34.p2);
                    }
                    _loc_39 = _loc_34;
                    _loc_35 = null;
                    _loc_39.pd = _loc_35;
                    _loc_35 = _loc_35;
                    _loc_39.pr = _loc_35;
                    _loc_35 = _loc_35;
                    _loc_39.p2 = _loc_35;
                    _loc_39.p1 = _loc_35;
                    _loc_38 = null;
                    _loc_39.spanr = _loc_38;
                    _loc_38 = _loc_38;
                    _loc_39.span2 = _loc_38;
                    _loc_39.span1 = _loc_38;
                    _loc_39.next = ZPP_MarchPair.zpp_pool;
                    ZPP_MarchPair.zpp_pool = _loc_39;
                }
            }
            if (!param8)
            {
                return;
            }
            _loc_15 = 1;
            while (_loc_15 < _loc_14)
            {
                
                _loc_15++;
                _loc_16 = _loc_15;
                _loc_38 = null;
                _loc_17 = 0;
                while (_loc_17 < _loc_12)
                {
                    
                    _loc_17++;
                    _loc_19 = _loc_17;
                    _loc_36 = ZPP_MarchingSquares.map;
                    _loc_27 = _loc_36.list[_loc_16 * _loc_36.width + _loc_19];
                    if (_loc_27 == null)
                    {
                        _loc_38 = null;
                        continue;
                    }
                    if (_loc_27.p2 != null)
                    {
                    }
                    if (_loc_27.okey2 == 14)
                    {
                        _loc_20 = _loc_27.okey2;
                    }
                    else
                    {
                        _loc_20 = _loc_27.okey1;
                    }
                    _loc_21 = _loc_20 & 7;
                    _loc_37 = 0;
                    if ((_loc_21 & 1) != 0)
                    {
                        _loc_37++;
                    }
                    if ((_loc_21 & 2) != 0)
                    {
                        _loc_37++;
                    }
                    if ((_loc_21 & 4) != 0)
                    {
                        _loc_37++;
                    }
                    if (_loc_37 < 2)
                    {
                        _loc_38 = null;
                        continue;
                    }
                    _loc_36 = ZPP_MarchingSquares.map;
                    _loc_34 = _loc_36.list[(_loc_16 - 1) * _loc_36.width + _loc_19];
                    if (_loc_34 == null)
                    {
                        _loc_38 = null;
                        continue;
                    }
                    if (_loc_34.p2 != null)
                    {
                    }
                    if (_loc_34.okey2 == 56)
                    {
                        _loc_21 = _loc_34.okey2;
                    }
                    else
                    {
                        _loc_21 = _loc_34.okey1;
                    }
                    _loc_37 = (_loc_21 & 112) >> 4;
                    _loc_40 = 0;
                    if ((_loc_37 & 1) != 0)
                    {
                        _loc_40++;
                    }
                    if ((_loc_37 & 2) != 0)
                    {
                        _loc_40++;
                    }
                    if ((_loc_37 & 4) != 0)
                    {
                        _loc_40++;
                    }
                    if (_loc_40 < 2)
                    {
                        _loc_38 = null;
                        continue;
                    }
                    if (_loc_34.p2 != null)
                    {
                    }
                    if (_loc_34.okey2 == 56)
                    {
                        _loc_41 = _loc_34.span2;
                    }
                    else
                    {
                        _loc_41 = _loc_34.span1;
                    }
                    if (_loc_27.p2 != null)
                    {
                    }
                    if (_loc_27.okey2 == 14)
                    {
                        _loc_42 = _loc_27.span2;
                    }
                    else
                    {
                        _loc_42 = _loc_27.span1;
                    }
                    while (_loc_43 != _loc_43.parent)
                    {
                    }
                    while (_loc_44 != null)
                    {
                    }
                    while (_loc_43 != _loc_43.parent)
                    {
                    }
                    while (_loc_44 != null)
                    {
                    }
                    if ((_loc_44 == null ? (_loc_41) : (_loc_43 = _loc_41, _loc_44 = null, // Jump to 2778, // label, _loc_45 = _loc_43.parent, _loc_43.parent = _loc_44, _loc_44 = _loc_43, _loc_43 = _loc_45, if (!(_loc_43 == _loc_43.parent)) goto 2746, // Jump to 2818, // label, _loc_45 = _loc_44.parent, _loc_44.parent = _loc_43, _loc_44 = _loc_45, if (!(_loc_44 == null)) goto 2793, _loc_43)) == (_loc_44 == null ? (_loc_42) : (_loc_43 = _loc_42, _loc_44 = null, // Jump to 2899, // label, _loc_45 = _loc_43.parent, _loc_43.parent = _loc_44, _loc_44 = _loc_43, _loc_43 = _loc_45, if (!(_loc_43 == _loc_43.parent)) goto 2867, // Jump to 2939, // label, _loc_45 = _loc_44.parent, _loc_44.parent = _loc_43, _loc_44 = _loc_45, if (!(_loc_44 == null)) goto 2914, _loc_43)))
                    {
                        if (_loc_38 != _loc_42)
                        {
                            ZPP_MarchingSquares.me.combUD_virtual(_loc_34, _loc_27);
                        }
                    }
                    else
                    {
                        if (_loc_41 == _loc_41.parent)
                        {
                            _loc_43 = _loc_41;
                        }
                        else
                        {
                            _loc_44 = _loc_41;
                            _loc_45 = null;
                            while (_loc_44 != _loc_44.parent)
                            {
                                
                                _loc_46 = _loc_44.parent;
                                _loc_44.parent = _loc_45;
                                _loc_45 = _loc_44;
                                _loc_44 = _loc_46;
                            }
                            while (_loc_45 != null)
                            {
                                
                                _loc_46 = _loc_45.parent;
                                _loc_45.parent = _loc_44;
                                _loc_45 = _loc_46;
                            }
                            _loc_43 = _loc_44;
                        }
                        if (_loc_42 == _loc_42.parent)
                        {
                            _loc_44 = _loc_42;
                        }
                        else
                        {
                            _loc_45 = _loc_42;
                            _loc_46 = null;
                            while (_loc_45 != _loc_45.parent)
                            {
                                
                                _loc_47 = _loc_45.parent;
                                _loc_45.parent = _loc_46;
                                _loc_46 = _loc_45;
                                _loc_45 = _loc_47;
                            }
                            while (_loc_46 != null)
                            {
                                
                                _loc_47 = _loc_46.parent;
                                _loc_46.parent = _loc_45;
                                _loc_46 = _loc_47;
                            }
                            _loc_44 = _loc_45;
                        }
                        if (_loc_43 != _loc_44)
                        {
                            if (_loc_43.rank < _loc_44.rank)
                            {
                                _loc_43.parent = _loc_44;
                            }
                            else if (_loc_43.rank > _loc_44.rank)
                            {
                                _loc_44.parent = _loc_43;
                            }
                            else
                            {
                                _loc_44.parent = _loc_43;
                                (_loc_43.rank + 1);
                            }
                        }
                        ZPP_MarchingSquares.me.combUD(_loc_34, _loc_27);
                    }
                    if (_loc_42 == _loc_27.span2)
                    {
                        _loc_37 = _loc_27.okey2;
                    }
                    else
                    {
                        _loc_37 = _loc_27.okey1;
                    }
                    if ((_loc_37 & 4) != 0)
                    {
                        _loc_38 = _loc_42;
                        continue;
                    }
                    _loc_38 = null;
                }
            }
            _loc_15 = 0;
            while (_loc_15 < _loc_14)
            {
                
                _loc_15++;
                _loc_16 = _loc_15;
                _loc_17 = 0;
                while (_loc_17 < _loc_12)
                {
                    
                    _loc_17++;
                    _loc_19 = _loc_17;
                    _loc_36 = ZPP_MarchingSquares.map;
                    _loc_27 = _loc_36.list[_loc_16 * _loc_36.width + _loc_19];
                    if (_loc_27 == null)
                    {
                        continue;
                    }
                    if (_loc_27.span1 == _loc_27.span1.parent)
                    {
                        _loc_38 = _loc_27.span1;
                    }
                    else
                    {
                        _loc_41 = _loc_27.span1;
                        _loc_42 = null;
                        while (_loc_41 != _loc_41.parent)
                        {
                            
                            _loc_43 = _loc_41.parent;
                            _loc_41.parent = _loc_42;
                            _loc_42 = _loc_41;
                            _loc_41 = _loc_43;
                        }
                        while (_loc_42 != null)
                        {
                            
                            _loc_43 = _loc_42.parent;
                            _loc_42.parent = _loc_41;
                            _loc_42 = _loc_43;
                        }
                        _loc_38 = _loc_41;
                    }
                    if (!_loc_38.out)
                    {
                        _loc_38.out = true;
                        ZPP_MarchingSquares.me.output(param9, _loc_27.p1);
                    }
                    if (_loc_27.p2 != null)
                    {
                        if (_loc_27.span2 == _loc_27.span2.parent)
                        {
                            _loc_38 = _loc_27.span2;
                        }
                        else
                        {
                            _loc_41 = _loc_27.span2;
                            _loc_42 = null;
                            while (_loc_41 != _loc_41.parent)
                            {
                                
                                _loc_43 = _loc_41.parent;
                                _loc_41.parent = _loc_42;
                                _loc_42 = _loc_41;
                                _loc_41 = _loc_43;
                            }
                            while (_loc_42 != null)
                            {
                                
                                _loc_43 = _loc_42.parent;
                                _loc_42.parent = _loc_41;
                                _loc_42 = _loc_43;
                            }
                            _loc_38 = _loc_41;
                        }
                        if (!_loc_38.out)
                        {
                            _loc_38.out = true;
                            ZPP_MarchingSquares.me.output(param9, _loc_27.p2);
                        }
                    }
                    _loc_34 = _loc_27;
                    _loc_35 = null;
                    _loc_34.pd = _loc_35;
                    _loc_35 = _loc_35;
                    _loc_34.pr = _loc_35;
                    _loc_35 = _loc_35;
                    _loc_34.p2 = _loc_35;
                    _loc_34.p1 = _loc_35;
                    _loc_41 = null;
                    _loc_34.spanr = _loc_41;
                    _loc_41 = _loc_41;
                    _loc_34.span2 = _loc_41;
                    _loc_34.span1 = _loc_41;
                    _loc_34.next = ZPP_MarchPair.zpp_pool;
                    ZPP_MarchPair.zpp_pool = _loc_34;
                    _loc_36 = ZPP_MarchingSquares.map;
                    _loc_36.list[_loc_16 * _loc_36.width + _loc_19] = null;
                }
            }
            while (_loc_25 != null)
            {
                
                _loc_38 = _loc_25;
                _loc_25 = _loc_38.next;
                _loc_41 = _loc_38;
                _loc_41.parent = _loc_41;
                _loc_41.next = ZPP_MarchSpan.zpp_pool;
                ZPP_MarchSpan.zpp_pool = _loc_41;
            }
            return;
        }// end function

        public static function ISO(param1:IsoFunction, param2:Number, param3:Number) : Number
        {
            return param1.iso(param2, param3);
        }// end function

    }
}
