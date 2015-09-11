package zpp_nape.geom
{
    import zpp_nape.util.*;

    public class ZPP_Simplify extends Object
    {
        public static var stack:ZNPList_ZPP_SimplifyP;

        public function ZPP_Simplify() : void
        {
            return;
        }// end function

        public static function lessval(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV) : Number
        {
            return param1.x - param2.x + (param1.y - param2.y);
        }// end function

        public static function less(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV) : Boolean
        {
            return param1.x - param2.x + (param1.y - param2.y) < 0;
        }// end function

        public static function distance(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV, param3:ZPP_SimplifyV) : Number
        {
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_4 = param3.x - param2.x;
            _loc_5 = param3.y - param2.y;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_6 = param1.x - param2.x;
            _loc_7 = param1.y - param2.y;
            var _loc_8:* = _loc_4 * _loc_4 + _loc_5 * _loc_5;
            if (_loc_8 == 0)
            {
                return _loc_6 * _loc_6 + _loc_7 * _loc_7;
            }
            else
            {
                _loc_9 = (_loc_6 * _loc_4 + _loc_7 * _loc_5) / (_loc_4 * _loc_4 + _loc_5 * _loc_5);
                if (_loc_9 <= 0)
                {
                    return _loc_6 * _loc_6 + _loc_7 * _loc_7;
                }
                else if (_loc_9 >= 1)
                {
                    _loc_10 = 0;
                    _loc_11 = 0;
                    _loc_10 = param1.x - param3.x;
                    _loc_11 = param1.y - param3.y;
                    return _loc_10 * _loc_10 + _loc_11 * _loc_11;
                }
                else
                {
                    _loc_10 = _loc_9;
                    _loc_6 = _loc_6 - _loc_4 * _loc_10;
                    _loc_7 = _loc_7 - _loc_5 * _loc_10;
                    return _loc_6 * _loc_6 + _loc_7 * _loc_7;
                }
            }
        }// end function

        public static function simplify(param1:ZPP_GeomVert, param2:Number) : ZPP_GeomVert
        {
            var _loc_9:* = null as ZPP_SimplifyV;
            var _loc_10:* = null as ZPP_SimplifyV;
            var _loc_11:* = null as ZPP_SimplifyP;
            var _loc_12:* = null as ZPP_SimplifyV;
            var _loc_13:* = false;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = null as ZPP_SimplifyP;
            var _loc_17:* = null as ZPP_SimplifyV;
            var _loc_19:* = null as ZPP_GeomVert;
            var _loc_20:* = null as ZPP_GeomVert;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            param2 = param2 * param2;
            if (ZPP_Simplify.stack == null)
            {
                ZPP_Simplify.stack = new ZNPList_ZPP_SimplifyP();
            }
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = param1;
            do
            {
                
                if (ZPP_SimplifyV.zpp_pool == null)
                {
                    _loc_10 = new ZPP_SimplifyV();
                }
                else
                {
                    _loc_10 = ZPP_SimplifyV.zpp_pool;
                    ZPP_SimplifyV.zpp_pool = _loc_10.next;
                    _loc_10.next = null;
                }
                _loc_10.x = _loc_8.x;
                _loc_10.y = _loc_8.y;
                _loc_10.flag = false;
                _loc_9 = _loc_10;
                _loc_9.forced = _loc_8.forced;
                if (_loc_9.forced)
                {
                    _loc_9.flag = true;
                    if (_loc_6 != null)
                    {
                        if (ZPP_SimplifyP.zpp_pool == null)
                        {
                            _loc_11 = new ZPP_SimplifyP();
                        }
                        else
                        {
                            _loc_11 = ZPP_SimplifyP.zpp_pool;
                            ZPP_SimplifyP.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.min = _loc_6;
                        _loc_11.max = _loc_9;
                        ZPP_Simplify.stack.add(_loc_11);
                    }
                    else
                    {
                        _loc_7 = _loc_9;
                    }
                    _loc_6 = _loc_9;
                }
                _loc_10 = _loc_9;
                if (_loc_3 == null)
                {
                    _loc_12 = _loc_10;
                    _loc_10.next = _loc_12;
                    _loc_12 = _loc_12;
                    _loc_10.prev = _loc_12;
                    _loc_3 = _loc_12;
                }
                else
                {
                    _loc_10.prev = _loc_3;
                    _loc_10.next = _loc_3.next;
                    _loc_3.next.prev = _loc_10;
                    _loc_3.next = _loc_10;
                }
                _loc_3 = _loc_10;
                if (_loc_4 == null)
                {
                    _loc_4 = _loc_3;
                    _loc_5 = _loc_3;
                }
                else
                {
                    if (_loc_3.x - _loc_4.x + (_loc_3.y - _loc_4.y) < 0)
                    {
                        _loc_4 = _loc_3;
                    }
                    if (_loc_5.x - _loc_3.x + (_loc_5.y - _loc_3.y) < 0)
                    {
                        _loc_5 = _loc_3;
                    }
                }
                _loc_8 = _loc_8.next;
            }while (_loc_8 != param1)
            if (ZPP_Simplify.stack.head == null)
            {
                if (_loc_7 == null)
                {
                    _loc_13 = true;
                    _loc_5.flag = _loc_13;
                    _loc_4.flag = _loc_13;
                    if (ZPP_SimplifyP.zpp_pool == null)
                    {
                        _loc_11 = new ZPP_SimplifyP();
                    }
                    else
                    {
                        _loc_11 = ZPP_SimplifyP.zpp_pool;
                        ZPP_SimplifyP.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.min = _loc_4;
                    _loc_11.max = _loc_5;
                    ZPP_Simplify.stack.add(_loc_11);
                    if (ZPP_SimplifyP.zpp_pool == null)
                    {
                        _loc_11 = new ZPP_SimplifyP();
                    }
                    else
                    {
                        _loc_11 = ZPP_SimplifyP.zpp_pool;
                        ZPP_SimplifyP.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.min = _loc_5;
                    _loc_11.max = _loc_4;
                    ZPP_Simplify.stack.add(_loc_11);
                }
                else
                {
                    _loc_14 = _loc_4.x - _loc_7.x + (_loc_4.y - _loc_7.y);
                    if (_loc_14 < 0)
                    {
                        _loc_14 = -_loc_14;
                    }
                    _loc_15 = _loc_5.x - _loc_7.x + (_loc_5.y - _loc_7.y);
                    if (_loc_15 < 0)
                    {
                        _loc_15 = -_loc_15;
                    }
                    if (_loc_14 > _loc_15)
                    {
                        _loc_13 = true;
                        _loc_7.flag = _loc_13;
                        _loc_4.flag = _loc_13;
                        if (ZPP_SimplifyP.zpp_pool == null)
                        {
                            _loc_11 = new ZPP_SimplifyP();
                        }
                        else
                        {
                            _loc_11 = ZPP_SimplifyP.zpp_pool;
                            ZPP_SimplifyP.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.min = _loc_4;
                        _loc_11.max = _loc_7;
                        ZPP_Simplify.stack.add(_loc_11);
                        if (ZPP_SimplifyP.zpp_pool == null)
                        {
                            _loc_11 = new ZPP_SimplifyP();
                        }
                        else
                        {
                            _loc_11 = ZPP_SimplifyP.zpp_pool;
                            ZPP_SimplifyP.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.min = _loc_7;
                        _loc_11.max = _loc_4;
                        ZPP_Simplify.stack.add(_loc_11);
                    }
                    else
                    {
                        _loc_13 = true;
                        _loc_7.flag = _loc_13;
                        _loc_5.flag = _loc_13;
                        if (ZPP_SimplifyP.zpp_pool == null)
                        {
                            _loc_11 = new ZPP_SimplifyP();
                        }
                        else
                        {
                            _loc_11 = ZPP_SimplifyP.zpp_pool;
                            ZPP_SimplifyP.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.min = _loc_5;
                        _loc_11.max = _loc_7;
                        ZPP_Simplify.stack.add(_loc_11);
                        if (ZPP_SimplifyP.zpp_pool == null)
                        {
                            _loc_11 = new ZPP_SimplifyP();
                        }
                        else
                        {
                            _loc_11 = ZPP_SimplifyP.zpp_pool;
                            ZPP_SimplifyP.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.min = _loc_7;
                        _loc_11.max = _loc_5;
                        ZPP_Simplify.stack.add(_loc_11);
                    }
                }
            }
            else
            {
                if (ZPP_SimplifyP.zpp_pool == null)
                {
                    _loc_11 = new ZPP_SimplifyP();
                }
                else
                {
                    _loc_11 = ZPP_SimplifyP.zpp_pool;
                    ZPP_SimplifyP.zpp_pool = _loc_11.next;
                    _loc_11.next = null;
                }
                _loc_11.min = _loc_6;
                _loc_11.max = _loc_7;
                ZPP_Simplify.stack.add(_loc_11);
            }
            while (ZPP_Simplify.stack.head != null)
            {
                
                _loc_11 = ZPP_Simplify.stack.pop_unsafe();
                _loc_9 = _loc_11.min;
                _loc_10 = _loc_11.max;
                _loc_16 = _loc_11;
                _loc_12 = null;
                _loc_16.max = _loc_12;
                _loc_16.min = _loc_12;
                _loc_16.next = ZPP_SimplifyP.zpp_pool;
                ZPP_SimplifyP.zpp_pool = _loc_16;
                _loc_14 = param2;
                _loc_12 = null;
                _loc_17 = _loc_9.next;
                while (_loc_17 != _loc_10)
                {
                    
                    _loc_15 = ZPP_Simplify.distance(_loc_17, _loc_9, _loc_10);
                    if (_loc_15 > _loc_14)
                    {
                        _loc_14 = _loc_15;
                        _loc_12 = _loc_17;
                    }
                    _loc_17 = _loc_17.next;
                }
                if (_loc_12 != null)
                {
                    _loc_12.flag = true;
                    if (ZPP_SimplifyP.zpp_pool == null)
                    {
                        _loc_16 = new ZPP_SimplifyP();
                    }
                    else
                    {
                        _loc_16 = ZPP_SimplifyP.zpp_pool;
                        ZPP_SimplifyP.zpp_pool = _loc_16.next;
                        _loc_16.next = null;
                    }
                    _loc_16.min = _loc_9;
                    _loc_16.max = _loc_12;
                    ZPP_Simplify.stack.add(_loc_16);
                    if (ZPP_SimplifyP.zpp_pool == null)
                    {
                        _loc_16 = new ZPP_SimplifyP();
                    }
                    else
                    {
                        _loc_16 = ZPP_SimplifyP.zpp_pool;
                        ZPP_SimplifyP.zpp_pool = _loc_16.next;
                        _loc_16.next = null;
                    }
                    _loc_16.min = _loc_12;
                    _loc_16.max = _loc_10;
                    ZPP_Simplify.stack.add(_loc_16);
                }
            }
            var _loc_18:* = null;
            while (_loc_3 != null)
            {
                
                if (_loc_3.flag)
                {
                    if (ZPP_GeomVert.zpp_pool == null)
                    {
                        _loc_20 = new ZPP_GeomVert();
                    }
                    else
                    {
                        _loc_20 = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc_20.next;
                        _loc_20.next = null;
                    }
                    _loc_20.forced = false;
                    _loc_20.x = _loc_3.x;
                    _loc_20.y = _loc_3.y;
                    _loc_19 = _loc_20;
                    if (_loc_18 == null)
                    {
                        _loc_20 = _loc_19;
                        _loc_19.next = _loc_20;
                        _loc_20 = _loc_20;
                        _loc_19.prev = _loc_20;
                        _loc_18 = _loc_20;
                    }
                    else
                    {
                        _loc_19.prev = _loc_18;
                        _loc_19.next = _loc_18.next;
                        _loc_18.next.prev = _loc_19;
                        _loc_18.next = _loc_19;
                    }
                    _loc_18 = _loc_19;
                    _loc_18.forced = _loc_3.forced;
                }
                if (_loc_3 != null)
                {
                }
                if (_loc_3.prev == _loc_3)
                {
                    _loc_9 = null;
                    _loc_3.prev = _loc_9;
                    _loc_3.next = _loc_9;
                    _loc_9 = _loc_3;
                    _loc_9.next = ZPP_SimplifyV.zpp_pool;
                    ZPP_SimplifyV.zpp_pool = _loc_9;
                    _loc_3 = null;
                    _loc_3 = _loc_3;
                    continue;
                }
                _loc_9 = _loc_3.next;
                _loc_3.prev.next = _loc_3.next;
                _loc_3.next.prev = _loc_3.prev;
                _loc_10 = null;
                _loc_3.prev = _loc_10;
                _loc_3.next = _loc_10;
                _loc_10 = _loc_3;
                _loc_10.next = ZPP_SimplifyV.zpp_pool;
                ZPP_SimplifyV.zpp_pool = _loc_10;
                _loc_3 = null;
                _loc_3 = _loc_9;
            }
            return _loc_18;
        }// end function

    }
}
