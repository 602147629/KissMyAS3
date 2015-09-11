package nape.geom
{
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    final public class MarchingSquares extends Object
    {

        public function MarchingSquares() : void
        {
            return;
        }// end function

        public static function run(param1:IsoFunction, param2:AABB, param3:Vec2, param4:int = 2, param5:Vec2 = undefined, param6:Boolean = true, param7:GeomPolyList = undefined) : GeomPolyList
        {
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as GeomPolyList;
            var _loc_10:* = null as ZPP_AABB;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = null as ZPP_Vec2;
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param5 != null)
            {
            }
            if (param5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: MarchingSquares requires an iso function to operate";
            }
            if (param2 == null)
            {
                throw "Error: MarchingSquares requires an AABB to define bounds of surface extraction";
            }
            if (param3 == null)
            {
                throw "Error: MarchingSquares requires a Vec2 to define cell size for surface extraction";
            }
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_8 = param3.zpp_inner;
            if (_loc_8._validate != null)
            {
                _loc_8._validate();
            }
            if (param3.zpp_inner.x > 0)
            {
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = param3.zpp_inner;
                if (_loc_8._validate != null)
                {
                    _loc_8._validate();
                }
            }
            if (param3.zpp_inner.y <= 0)
            {
                throw "Error: MarchingSquares cannot operate with non-positive cell dimensions";
            }
            if (param4 < 0)
            {
                throw "Error: MarchingSquares cannot use a negative quality value for interpolation";
            }
            if (param5 != null)
            {
                if (param5 != null)
                {
                }
                if (param5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = param5.zpp_inner;
                if (_loc_8._validate != null)
                {
                    _loc_8._validate();
                }
                if (param5.zpp_inner.x > 0)
                {
                    if (param5 != null)
                    {
                    }
                    if (param5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = param5.zpp_inner;
                    if (_loc_8._validate != null)
                    {
                        _loc_8._validate();
                    }
                }
            }
            if (param5.zpp_inner.y <= 0)
            {
                throw "Error: MarchingSquares cannot with non-positive sub-grid dimensions";
            }
            if (param7 != null)
            {
                _loc_9 = param7;
            }
            else
            {
                _loc_9 = new GeomPolyList();
            }
            if (param5 == null)
            {
                _loc_10 = param2.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_10 = param2.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_11 = param2.zpp_inner.getmax();
                if (_loc_11 != null)
                {
                }
                if (_loc_11.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = _loc_11.zpp_inner;
                if (_loc_8._validate != null)
                {
                    _loc_8._validate();
                }
                _loc_11 = param2.zpp_inner.getmax();
                if (_loc_11 != null)
                {
                }
                if (_loc_11.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = _loc_11.zpp_inner;
                if (_loc_8._validate != null)
                {
                    _loc_8._validate();
                }
                ZPP_MarchingSquares.run(param1, param2.zpp_inner.minx, param2.zpp_inner.miny, _loc_11.zpp_inner.x, _loc_11.zpp_inner.y, param3, param4, param6, _loc_9);
            }
            else
            {
                _loc_10 = param2.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_10 = param2.zpp_inner;
                if (param5 != null)
                {
                }
                if (param5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = param5.zpp_inner;
                if (_loc_8._validate != null)
                {
                    _loc_8._validate();
                }
                _loc_12 = (_loc_10.maxx - _loc_10.minx) / param5.zpp_inner.x;
                _loc_10 = param2.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_10 = param2.zpp_inner;
                if (param5 != null)
                {
                }
                if (param5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = param5.zpp_inner;
                if (_loc_8._validate != null)
                {
                    _loc_8._validate();
                }
                _loc_13 = (_loc_10.maxy - _loc_10.miny) / param5.zpp_inner.y;
                _loc_14 = _loc_12;
                _loc_15 = _loc_13;
                if (_loc_14 != _loc_12)
                {
                    _loc_14++;
                }
                if (_loc_15 != _loc_13)
                {
                    _loc_15++;
                }
                _loc_16 = 0;
                while (_loc_16 < _loc_14)
                {
                    
                    _loc_16++;
                    _loc_17 = _loc_16;
                    _loc_10 = param2.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    if (param5 != null)
                    {
                    }
                    if (param5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = param5.zpp_inner;
                    if (_loc_8._validate != null)
                    {
                        _loc_8._validate();
                    }
                    _loc_18 = param2.zpp_inner.minx + param5.zpp_inner.x * _loc_17;
                    if (_loc_17 == (_loc_14 - 1))
                    {
                        _loc_11 = param2.zpp_inner.getmax();
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_11.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                        _loc_19 = _loc_11.zpp_inner.x;
                    }
                    else
                    {
                        if (param5 != null)
                        {
                        }
                        if (param5.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = param5.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                        _loc_19 = _loc_18 + param5.zpp_inner.x;
                    }
                    _loc_20 = 0;
                    while (_loc_20 < _loc_15)
                    {
                        
                        _loc_20++;
                        _loc_21 = _loc_20;
                        _loc_10 = param2.zpp_inner;
                        if (_loc_10._validate != null)
                        {
                            _loc_10._validate();
                        }
                        if (param5 != null)
                        {
                        }
                        if (param5.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = param5.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                        _loc_22 = param2.zpp_inner.miny + param5.zpp_inner.y * _loc_21;
                        if (_loc_21 == (_loc_15 - 1))
                        {
                            _loc_11 = param2.zpp_inner.getmax();
                            if (_loc_11 != null)
                            {
                            }
                            if (_loc_11.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_8 = _loc_11.zpp_inner;
                            if (_loc_8._validate != null)
                            {
                                _loc_8._validate();
                            }
                            _loc_23 = _loc_11.zpp_inner.y;
                        }
                        else
                        {
                            if (param5 != null)
                            {
                            }
                            if (param5.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_8 = param5.zpp_inner;
                            if (_loc_8._validate != null)
                            {
                                _loc_8._validate();
                            }
                            _loc_23 = _loc_22 + param5.zpp_inner.y;
                        }
                        ZPP_MarchingSquares.run(param1, _loc_18, _loc_22, _loc_19, _loc_23, param3, param4, param6, _loc_9);
                    }
                }
            }
            if (param3.zpp_inner.weak)
            {
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = param3.zpp_inner;
                if (_loc_8._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_8._isimmutable != null)
                {
                    _loc_8._isimmutable();
                }
                if (param3.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_8 = param3.zpp_inner;
                param3.zpp_inner.outer = null;
                param3.zpp_inner = null;
                _loc_11 = param3;
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
                _loc_24 = _loc_8;
                if (_loc_24.outer != null)
                {
                    _loc_24.outer.zpp_inner = null;
                    _loc_24.outer = null;
                }
                _loc_24._isimmutable = null;
                _loc_24._validate = null;
                _loc_24._invalidate = null;
                _loc_24.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_24;
            }
            else
            {
            }
            if (param5 != null)
            {
                if (param5.zpp_inner.weak)
                {
                    if (param5 != null)
                    {
                    }
                    if (param5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = param5.zpp_inner;
                    if (_loc_8._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_8._isimmutable != null)
                    {
                        _loc_8._isimmutable();
                    }
                    if (param5.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_8 = param5.zpp_inner;
                    param5.zpp_inner.outer = null;
                    param5.zpp_inner = null;
                    _loc_11 = param5;
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
                    _loc_24 = _loc_8;
                    if (_loc_24.outer != null)
                    {
                        _loc_24.outer.zpp_inner = null;
                        _loc_24.outer = null;
                    }
                    _loc_24._isimmutable = null;
                    _loc_24._validate = null;
                    _loc_24._invalidate = null;
                    _loc_24.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_24;
                }
                else
                {
                }
            }
            return _loc_9;
        }// end function

    }
}
