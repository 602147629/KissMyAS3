package nape.util
{
    import __AS3__.vec.*;
    import flash.*;
    import nape.constraint.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import nape.space.*;
    import zpp_nape.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    final public class BitmapDebug extends Debug
    {
        public var zpp_inner_zn:ZPP_BitmapDebug;

        public function BitmapDebug(param1:int = 0, param2:int = 0, param3:int = 3355443, param4:Boolean = false) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner_zn = null;
            if (param1 <= 0)
            {
                throw "Error: Debug width must be > 0";
            }
            if (param2 <= 0)
            {
                throw "Error: Debug height must be > 0";
            }
            ZPP_Debug.internal = true;
            ZPP_Debug.internal = false;
            zpp_inner_zn = new ZPP_BitmapDebug(param1, param2, param3, param4);
            zpp_inner_zn.outer_zn = this;
            zpp_inner = zpp_inner_zn;
            zpp_inner.outer = this;
            return;
        }// end function

        public function prepare() : void
        {
            zpp_inner_zn.prepare();
            return;
        }// end function

        override public function flush() : void
        {
            zpp_inner_zn.flush();
            return;
        }// end function

        override public function drawSpring(param1:Vec2, param2:Vec2, param3:int, param4:int = 3, param5:Number = 3) : void
        {
            var _loc_6:* = NaN;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = NaN;
            var _loc_15:* = null as Vec2;
            var _loc_16:* = false;
            var _loc_17:* = null as Vec2;
            var _loc_18:* = false;
            var _loc_19:* = null as Vec2;
            var _loc_20:* = null as Vec2;
            var _loc_21:* = 0;
            var _loc_22:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: drawCurve::start cannot be null";
            }
            if (param2 == null)
            {
                throw "Error: drawCurve::end cannot be null";
            }
            if (param4 < 0)
            {
                throw "Error: drawCurve::coils must be >= 0";
            }
            if (param4 == 0)
            {
                drawLine(param1, param2, param3);
            }
            else
            {
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param2.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param1.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                _loc_6 = param2.zpp_inner.x - param1.zpp_inner.x;
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param2.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param1.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                _loc_8 = param2.zpp_inner.y - param1.zpp_inner.y;
                _loc_9 = 1 / (param4 * 4);
                _loc_6 = _loc_6 * _loc_9;
                _loc_8 = _loc_8 * _loc_9;
                _loc_9 = 0;
                _loc_10 = 0;
                _loc_9 = _loc_6;
                _loc_10 = _loc_8;
                if (_loc_9 * _loc_9 + _loc_10 * _loc_10 < 0.1)
                {
                    return;
                }
                _loc_11 = _loc_9 * _loc_9 + _loc_10 * _loc_10;
                _loc_13 = 1597463007 - (0 >> 1);
                _loc_14 = 0;
                _loc_12 = _loc_14 * (1.5 - 0.5 * _loc_11 * _loc_14 * _loc_14);
                _loc_14 = _loc_12;
                _loc_9 = _loc_9 * _loc_14;
                _loc_10 = _loc_10 * _loc_14;
                _loc_11 = _loc_9;
                _loc_9 = -_loc_10;
                _loc_10 = _loc_11;
                _loc_11 = param5 * 2;
                _loc_9 = _loc_9 * _loc_11;
                _loc_10 = _loc_10 * _loc_11;
                _loc_16 = false;
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param1.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                _loc_11 = param1.zpp_inner.x;
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param1.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                _loc_12 = param1.zpp_inner.y;
                if (_loc_11 == _loc_11)
                {
                }
                if (_loc_12 != _loc_12)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_17 = new Vec2();
                }
                else
                {
                    _loc_17 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_17.zpp_pool;
                    _loc_17.zpp_pool = null;
                    _loc_17.zpp_disp = false;
                    if (_loc_17 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_17.zpp_inner == null)
                {
                    _loc_18 = false;
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
                    _loc_7._immutable = _loc_18;
                    _loc_7.x = _loc_11;
                    _loc_7.y = _loc_12;
                    _loc_17.zpp_inner = _loc_7;
                    _loc_17.zpp_inner.outer = _loc_17;
                }
                else
                {
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_11 == _loc_11)
                    {
                    }
                    if (_loc_12 != _loc_12)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_17.zpp_inner.x == _loc_11)
                    {
                        if (_loc_17 != null)
                        {
                        }
                        if (_loc_17.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_7 = _loc_17.zpp_inner;
                        if (_loc_7._validate != null)
                        {
                            _loc_7._validate();
                        }
                    }
                    if (_loc_17.zpp_inner.y != _loc_12)
                    {
                        _loc_17.zpp_inner.x = _loc_11;
                        _loc_17.zpp_inner.y = _loc_12;
                        _loc_7 = _loc_17.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                }
                _loc_17.zpp_inner.weak = _loc_16;
                _loc_15 = _loc_17;
                _loc_11 = 0;
                _loc_12 = 0;
                _loc_16 = false;
                if (_loc_11 == _loc_11)
                {
                }
                if (_loc_12 != _loc_12)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_19 = new Vec2();
                }
                else
                {
                    _loc_19 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_19.zpp_pool;
                    _loc_19.zpp_pool = null;
                    _loc_19.zpp_disp = false;
                    if (_loc_19 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_19.zpp_inner == null)
                {
                    _loc_18 = false;
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
                    _loc_7._immutable = _loc_18;
                    _loc_7.x = _loc_11;
                    _loc_7.y = _loc_12;
                    _loc_19.zpp_inner = _loc_7;
                    _loc_19.zpp_inner.outer = _loc_19;
                }
                else
                {
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_11 == _loc_11)
                    {
                    }
                    if (_loc_12 != _loc_12)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_19.zpp_inner.x == _loc_11)
                    {
                        if (_loc_19 != null)
                        {
                        }
                        if (_loc_19.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_7 = _loc_19.zpp_inner;
                        if (_loc_7._validate != null)
                        {
                            _loc_7._validate();
                        }
                    }
                    if (_loc_19.zpp_inner.y != _loc_12)
                    {
                        _loc_19.zpp_inner.x = _loc_11;
                        _loc_19.zpp_inner.y = _loc_12;
                        _loc_7 = _loc_19.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                }
                _loc_19.zpp_inner.weak = _loc_16;
                _loc_17 = _loc_19;
                _loc_11 = 0;
                _loc_12 = 0;
                _loc_16 = false;
                if (_loc_11 == _loc_11)
                {
                }
                if (_loc_12 != _loc_12)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_20 = new Vec2();
                }
                else
                {
                    _loc_20 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_20.zpp_pool;
                    _loc_20.zpp_pool = null;
                    _loc_20.zpp_disp = false;
                    if (_loc_20 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_20.zpp_inner == null)
                {
                    _loc_18 = false;
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
                    _loc_7._immutable = _loc_18;
                    _loc_7.x = _loc_11;
                    _loc_7.y = _loc_12;
                    _loc_20.zpp_inner = _loc_7;
                    _loc_20.zpp_inner.outer = _loc_20;
                }
                else
                {
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_20.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_11 == _loc_11)
                    {
                    }
                    if (_loc_12 != _loc_12)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_20.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_20.zpp_inner.x == _loc_11)
                    {
                        if (_loc_20 != null)
                        {
                        }
                        if (_loc_20.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_7 = _loc_20.zpp_inner;
                        if (_loc_7._validate != null)
                        {
                            _loc_7._validate();
                        }
                    }
                    if (_loc_20.zpp_inner.y != _loc_12)
                    {
                        _loc_20.zpp_inner.x = _loc_11;
                        _loc_20.zpp_inner.y = _loc_12;
                        _loc_7 = _loc_20.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                }
                _loc_20.zpp_inner.weak = _loc_16;
                _loc_19 = _loc_20;
                _loc_13 = 0;
                while (_loc_13 < param4)
                {
                    
                    _loc_13++;
                    _loc_21 = _loc_13;
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_15.zpp_inner.x + _loc_6 + _loc_9;
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_17.zpp_inner.x != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "x" + " cannot be NaN";
                        }
                        _loc_17.zpp_inner.x = _loc_11;
                        _loc_7 = _loc_17.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_15.zpp_inner.y + _loc_8 + _loc_10;
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_17.zpp_inner.y != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "y" + " cannot be NaN";
                        }
                        _loc_17.zpp_inner.y = _loc_11;
                        _loc_7 = _loc_17.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_15.zpp_inner.x + _loc_6 * 2;
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_19.zpp_inner.x != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "x" + " cannot be NaN";
                        }
                        _loc_19.zpp_inner.x = _loc_11;
                        _loc_7 = _loc_19.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_15.zpp_inner.y + _loc_8 * 2;
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_19.zpp_inner.y != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "y" + " cannot be NaN";
                        }
                        _loc_19.zpp_inner.y = _loc_11;
                        _loc_7 = _loc_19.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    drawCurve(_loc_15, _loc_17, _loc_19, param3);
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_19.zpp_inner.x;
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15.zpp_inner.x != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "x" + " cannot be NaN";
                        }
                        _loc_15.zpp_inner.x = _loc_11;
                        _loc_7 = _loc_15.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_19.zpp_inner.y;
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15.zpp_inner.y != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "y" + " cannot be NaN";
                        }
                        _loc_15.zpp_inner.y = _loc_11;
                        _loc_7 = _loc_15.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_15.zpp_inner.x + _loc_6 - _loc_9;
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_17.zpp_inner.x != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "x" + " cannot be NaN";
                        }
                        _loc_17.zpp_inner.x = _loc_11;
                        _loc_7 = _loc_17.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_15.zpp_inner.y + _loc_8 - _loc_10;
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_17.zpp_inner.y != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "y" + " cannot be NaN";
                        }
                        _loc_17.zpp_inner.y = _loc_11;
                        _loc_7 = _loc_17.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_17.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_15.zpp_inner.x + _loc_6 * 2;
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_19.zpp_inner.x != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "x" + " cannot be NaN";
                        }
                        _loc_19.zpp_inner.x = _loc_11;
                        _loc_7 = _loc_19.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_15.zpp_inner.y + _loc_8 * 2;
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_19.zpp_inner.y != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "y" + " cannot be NaN";
                        }
                        _loc_19.zpp_inner.y = _loc_11;
                        _loc_7 = _loc_19.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    drawCurve(_loc_15, _loc_17, _loc_19, param3);
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_19.zpp_inner.x;
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15.zpp_inner.x != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "x" + " cannot be NaN";
                        }
                        _loc_15.zpp_inner.x = _loc_11;
                        _loc_7 = _loc_15.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_19 != null)
                    {
                    }
                    if (_loc_19.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_19.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    _loc_11 = _loc_19.zpp_inner.y;
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_15.zpp_inner.y != _loc_11)
                    {
                        if (_loc_11 != _loc_11)
                        {
                            throw "Error: Vec2::" + "y" + " cannot be NaN";
                        }
                        _loc_15.zpp_inner.y = _loc_11;
                        _loc_7 = _loc_15.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_15.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                }
                if (_loc_15 != null)
                {
                }
                if (_loc_15.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_15.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_15.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = _loc_15.zpp_inner;
                _loc_15.zpp_inner.outer = null;
                _loc_15.zpp_inner = null;
                _loc_20 = _loc_15;
                _loc_20.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_20;
                }
                ZPP_PubPool.nextVec2 = _loc_20;
                _loc_20.zpp_disp = true;
                _loc_22 = _loc_7;
                if (_loc_22.outer != null)
                {
                    _loc_22.outer.zpp_inner = null;
                    _loc_22.outer = null;
                }
                _loc_22._isimmutable = null;
                _loc_22._validate = null;
                _loc_22._invalidate = null;
                _loc_22.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_22;
                if (_loc_17 != null)
                {
                }
                if (_loc_17.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_17.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_17.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = _loc_17.zpp_inner;
                _loc_17.zpp_inner.outer = null;
                _loc_17.zpp_inner = null;
                _loc_20 = _loc_17;
                _loc_20.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_20;
                }
                ZPP_PubPool.nextVec2 = _loc_20;
                _loc_20.zpp_disp = true;
                _loc_22 = _loc_7;
                if (_loc_22.outer != null)
                {
                    _loc_22.outer.zpp_inner = null;
                    _loc_22.outer = null;
                }
                _loc_22._isimmutable = null;
                _loc_22._validate = null;
                _loc_22._invalidate = null;
                _loc_22.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_22;
                if (_loc_19 != null)
                {
                }
                if (_loc_19.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_19.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_19.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = _loc_19.zpp_inner;
                _loc_19.zpp_inner.outer = null;
                _loc_19.zpp_inner = null;
                _loc_20 = _loc_19;
                _loc_20.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_20;
                }
                ZPP_PubPool.nextVec2 = _loc_20;
                _loc_20.zpp_disp = true;
                _loc_22 = _loc_7;
                if (_loc_22.outer != null)
                {
                    _loc_22.outer.zpp_inner = null;
                    _loc_22.outer = null;
                }
                _loc_22._isimmutable = null;
                _loc_22._validate = null;
                _loc_22._invalidate = null;
                _loc_22.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_22;
            }
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param1.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_15 = param1;
                _loc_15.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_15;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_15;
                }
                ZPP_PubPool.nextVec2 = _loc_15;
                _loc_15.zpp_disp = true;
                _loc_22 = _loc_7;
                if (_loc_22.outer != null)
                {
                    _loc_22.outer.zpp_inner = null;
                    _loc_22.outer = null;
                }
                _loc_22._isimmutable = null;
                _loc_22._validate = null;
                _loc_22._invalidate = null;
                _loc_22.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_22;
            }
            else
            {
            }
            if (param2.zpp_inner.weak)
            {
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param2.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (param2.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = param2.zpp_inner;
                param2.zpp_inner.outer = null;
                param2.zpp_inner = null;
                _loc_15 = param2;
                _loc_15.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_15;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_15;
                }
                ZPP_PubPool.nextVec2 = _loc_15;
                _loc_15.zpp_disp = true;
                _loc_22 = _loc_7;
                if (_loc_22.outer != null)
                {
                    _loc_22.outer.zpp_inner = null;
                    _loc_22.outer = null;
                }
                _loc_22._isimmutable = null;
                _loc_22._validate = null;
                _loc_22._invalidate = null;
                _loc_22.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_22;
            }
            else
            {
            }
            return;
        }// end function

        override public function drawPolygon(param1, param2:int) : void
        {
            var _loc_9:* = null as Array;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null as Vec2;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = false;
            var _loc_16:* = null as ZPP_Vec2;
            var _loc_17:* = false;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = null as Vec2;
            var _loc_21:* = false;
            var _loc_22:* = null as Vec2;
            var _loc_23:* = null as ZPP_Vec2;
            var _loc_24:* = null as Vector.<Vec2>;
            var _loc_25:* = null as Vec2;
            var _loc_26:* = null as Vec2List;
            var _loc_27:* = null as Vec2Iterator;
            var _loc_28:* = null as GeomPoly;
            var _loc_29:* = null as ZPP_GeomVert;
            var _loc_30:* = null as ZPP_GeomVert;
            var _loc_31:* = null as ZNPList_ZPP_Vec2;
            var _loc_32:* = null as ZNPNode_ZPP_Vec2;
            var _loc_33:* = null as ZNPNode_ZPP_Vec2;
            var _loc_34:* = null as ZPP_Vec2;
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot draw null Vec2 list";
            }
            var _loc_3:* = param2 | -16777216;
            var _loc_6:* = null;
            var _loc_8:* = 0;
            var _loc_7:* = 0;
            var _loc_5:* = 0;
            var _loc_4:* = 0;
            if (param1 is Array)
            {
                _loc_9 = param1;
                _loc_10 = 0;
                while (_loc_10 < _loc_9.length)
                {
                    
                    _loc_11 = _loc_9[_loc_10];
                    _loc_10++;
                    if (_loc_11 == null)
                    {
                        throw "Error: Array<Vec2> contains null objects";
                    }
                    if (!(_loc_11 is Vec2))
                    {
                        throw "Error: Array<Vec2> contains non Vec2 objects";
                    }
                    _loc_12 = _loc_11;
                    if (_loc_12 != null)
                    {
                    }
                    if (_loc_12.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_6 == null;
                    if (zpp_inner.xnull)
                    {
                        if (_loc_12 != null)
                        {
                        }
                        if (_loc_12.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_12.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_13 = _loc_12.zpp_inner.x + 0.5;
                        if (_loc_12 != null)
                        {
                        }
                        if (_loc_12.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_12.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_14 = _loc_12.zpp_inner.y + 0.5;
                        if (_loc_15)
                        {
                            _loc_17 = false;
                            if (_loc_12 != null)
                            {
                            }
                            if (_loc_12.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            if (_loc_12.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_12.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            _loc_18 = _loc_12.zpp_inner.x;
                            if (_loc_12.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_12.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            _loc_19 = _loc_12.zpp_inner.y;
                            if (_loc_18 == _loc_18)
                            {
                            }
                            if (_loc_19 != _loc_19)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_20 = new Vec2();
                            }
                            else
                            {
                                _loc_20 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_20.zpp_pool;
                                _loc_20.zpp_pool = null;
                                _loc_20.zpp_disp = false;
                                if (_loc_20 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_20.zpp_inner == null)
                            {
                                _loc_21 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_16 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_16 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_16.next;
                                    _loc_16.next = null;
                                }
                                _loc_16.weak = false;
                                _loc_16._immutable = _loc_21;
                                _loc_16.x = _loc_18;
                                _loc_16.y = _loc_19;
                                _loc_20.zpp_inner = _loc_16;
                                _loc_20.zpp_inner.outer = _loc_20;
                            }
                            else
                            {
                                if (_loc_20 != null)
                                {
                                }
                                if (_loc_20.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_16 = _loc_20.zpp_inner;
                                if (_loc_16._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_16._isimmutable != null)
                                {
                                    _loc_16._isimmutable();
                                }
                                if (_loc_18 == _loc_18)
                                {
                                }
                                if (_loc_19 != _loc_19)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_20 != null)
                                {
                                }
                                if (_loc_20.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_16 = _loc_20.zpp_inner;
                                if (_loc_16._validate != null)
                                {
                                    _loc_16._validate();
                                }
                                if (_loc_20.zpp_inner.x == _loc_18)
                                {
                                    if (_loc_20 != null)
                                    {
                                    }
                                    if (_loc_20.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_16 = _loc_20.zpp_inner;
                                    if (_loc_16._validate != null)
                                    {
                                        _loc_16._validate();
                                    }
                                }
                                if (_loc_20.zpp_inner.y != _loc_19)
                                {
                                    _loc_20.zpp_inner.x = _loc_18;
                                    _loc_20.zpp_inner.y = _loc_19;
                                    _loc_16 = _loc_20.zpp_inner;
                                    if (_loc_16._invalidate != null)
                                    {
                                        _loc_16._invalidate(_loc_16);
                                    }
                                }
                            }
                            _loc_20.zpp_inner.weak = _loc_17;
                            _loc_6 = _loc_20;
                        }
                    }
                    else
                    {
                        _loc_20 = zpp_inner.xform.outer.transform(_loc_12);
                        if (_loc_20 != null)
                        {
                        }
                        if (_loc_20.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_20.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_13 = _loc_20.zpp_inner.x + 0.5;
                        if (_loc_20 != null)
                        {
                        }
                        if (_loc_20.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_20.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_14 = _loc_20.zpp_inner.y + 0.5;
                        if (_loc_15)
                        {
                            _loc_6 = _loc_20;
                        }
                        else
                        {
                            if (_loc_20 != null)
                            {
                            }
                            if (_loc_20.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_20.zpp_inner;
                            if (_loc_16._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_16._isimmutable != null)
                            {
                                _loc_16._isimmutable();
                            }
                            if (_loc_20.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_16 = _loc_20.zpp_inner;
                            _loc_20.zpp_inner.outer = null;
                            _loc_20.zpp_inner = null;
                            _loc_22 = _loc_20;
                            _loc_22.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_22;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_22;
                            }
                            ZPP_PubPool.nextVec2 = _loc_22;
                            _loc_22.zpp_disp = true;
                            _loc_23 = _loc_16;
                            if (_loc_23.outer != null)
                            {
                                _loc_23.outer.zpp_inner = null;
                                _loc_23.outer = null;
                            }
                            _loc_23._isimmutable = null;
                            _loc_23._validate = null;
                            _loc_23._invalidate = null;
                            _loc_23.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_23;
                        }
                    }
                    if (_loc_15)
                    {
                        _loc_7 = _loc_13;
                        _loc_4 = _loc_7;
                        _loc_8 = _loc_14;
                        _loc_5 = _loc_8;
                        continue;
                    }
                    zpp_inner_zn.__line(_loc_7, _loc_8, _loc_13, _loc_14, _loc_3);
                    _loc_7 = _loc_13;
                    _loc_8 = _loc_14;
                }
            }
            else if (param1 is ZPP_Const.vec2vector)
            {
                _loc_24 = param1;
                _loc_10 = 0;
                while (_loc_10 < _loc_24.length)
                {
                    
                    _loc_12 = _loc_24[_loc_10];
                    _loc_10++;
                    if (_loc_12 == null)
                    {
                        throw "Error: flash.Vector<Vec2> contains null objects";
                    }
                    _loc_20 = _loc_12;
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_6 == null;
                    if (zpp_inner.xnull)
                    {
                        if (_loc_20 != null)
                        {
                        }
                        if (_loc_20.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_20.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_13 = _loc_20.zpp_inner.x + 0.5;
                        if (_loc_20 != null)
                        {
                        }
                        if (_loc_20.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_20.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_14 = _loc_20.zpp_inner.y + 0.5;
                        if (_loc_15)
                        {
                            _loc_17 = false;
                            if (_loc_20 != null)
                            {
                            }
                            if (_loc_20.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            if (_loc_20.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_20.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            _loc_18 = _loc_20.zpp_inner.x;
                            if (_loc_20.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_20.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            _loc_19 = _loc_20.zpp_inner.y;
                            if (_loc_18 == _loc_18)
                            {
                            }
                            if (_loc_19 != _loc_19)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_22 = new Vec2();
                            }
                            else
                            {
                                _loc_22 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_22.zpp_pool;
                                _loc_22.zpp_pool = null;
                                _loc_22.zpp_disp = false;
                                if (_loc_22 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_22.zpp_inner == null)
                            {
                                _loc_21 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_16 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_16 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_16.next;
                                    _loc_16.next = null;
                                }
                                _loc_16.weak = false;
                                _loc_16._immutable = _loc_21;
                                _loc_16.x = _loc_18;
                                _loc_16.y = _loc_19;
                                _loc_22.zpp_inner = _loc_16;
                                _loc_22.zpp_inner.outer = _loc_22;
                            }
                            else
                            {
                                if (_loc_22 != null)
                                {
                                }
                                if (_loc_22.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_16 = _loc_22.zpp_inner;
                                if (_loc_16._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_16._isimmutable != null)
                                {
                                    _loc_16._isimmutable();
                                }
                                if (_loc_18 == _loc_18)
                                {
                                }
                                if (_loc_19 != _loc_19)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_22 != null)
                                {
                                }
                                if (_loc_22.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_16 = _loc_22.zpp_inner;
                                if (_loc_16._validate != null)
                                {
                                    _loc_16._validate();
                                }
                                if (_loc_22.zpp_inner.x == _loc_18)
                                {
                                    if (_loc_22 != null)
                                    {
                                    }
                                    if (_loc_22.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_16 = _loc_22.zpp_inner;
                                    if (_loc_16._validate != null)
                                    {
                                        _loc_16._validate();
                                    }
                                }
                                if (_loc_22.zpp_inner.y != _loc_19)
                                {
                                    _loc_22.zpp_inner.x = _loc_18;
                                    _loc_22.zpp_inner.y = _loc_19;
                                    _loc_16 = _loc_22.zpp_inner;
                                    if (_loc_16._invalidate != null)
                                    {
                                        _loc_16._invalidate(_loc_16);
                                    }
                                }
                            }
                            _loc_22.zpp_inner.weak = _loc_17;
                            _loc_6 = _loc_22;
                        }
                    }
                    else
                    {
                        _loc_22 = zpp_inner.xform.outer.transform(_loc_20);
                        if (_loc_22 != null)
                        {
                        }
                        if (_loc_22.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_22.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_13 = _loc_22.zpp_inner.x + 0.5;
                        if (_loc_22 != null)
                        {
                        }
                        if (_loc_22.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_22.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_14 = _loc_22.zpp_inner.y + 0.5;
                        if (_loc_15)
                        {
                            _loc_6 = _loc_22;
                        }
                        else
                        {
                            if (_loc_22 != null)
                            {
                            }
                            if (_loc_22.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_22.zpp_inner;
                            if (_loc_16._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_16._isimmutable != null)
                            {
                                _loc_16._isimmutable();
                            }
                            if (_loc_22.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_16 = _loc_22.zpp_inner;
                            _loc_22.zpp_inner.outer = null;
                            _loc_22.zpp_inner = null;
                            _loc_25 = _loc_22;
                            _loc_25.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_25;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_25;
                            }
                            ZPP_PubPool.nextVec2 = _loc_25;
                            _loc_25.zpp_disp = true;
                            _loc_23 = _loc_16;
                            if (_loc_23.outer != null)
                            {
                                _loc_23.outer.zpp_inner = null;
                                _loc_23.outer = null;
                            }
                            _loc_23._isimmutable = null;
                            _loc_23._validate = null;
                            _loc_23._invalidate = null;
                            _loc_23.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_23;
                        }
                    }
                    if (_loc_15)
                    {
                        _loc_7 = _loc_13;
                        _loc_4 = _loc_7;
                        _loc_8 = _loc_14;
                        _loc_5 = _loc_8;
                        continue;
                    }
                    zpp_inner_zn.__line(_loc_7, _loc_8, _loc_13, _loc_14, _loc_3);
                    _loc_7 = _loc_13;
                    _loc_8 = _loc_14;
                }
            }
            else if (param1 is Vec2List)
            {
                _loc_26 = param1;
                _loc_27 = _loc_26.iterator();
                do
                {
                    
                    _loc_27.zpp_critical = false;
                    _loc_10 = _loc_27.zpp_i;
                    (_loc_27.zpp_i + 1);
                    _loc_12 = _loc_27.zpp_inner.at(_loc_10);
                    if (_loc_12 == null)
                    {
                        throw "Error: Vec2List contains null objects";
                    }
                    if (_loc_12 != null)
                    {
                    }
                    if (_loc_12.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_6 == null;
                    if (zpp_inner.xnull)
                    {
                        if (_loc_12 != null)
                        {
                        }
                        if (_loc_12.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_12.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_10 = _loc_12.zpp_inner.x + 0.5;
                        if (_loc_12 != null)
                        {
                        }
                        if (_loc_12.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_12.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_13 = _loc_12.zpp_inner.y + 0.5;
                        if (_loc_15)
                        {
                            _loc_17 = false;
                            if (_loc_12 != null)
                            {
                            }
                            if (_loc_12.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            if (_loc_12.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_12.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            _loc_18 = _loc_12.zpp_inner.x;
                            if (_loc_12.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_12.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            _loc_19 = _loc_12.zpp_inner.y;
                            if (_loc_18 == _loc_18)
                            {
                            }
                            if (_loc_19 != _loc_19)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_20 = new Vec2();
                            }
                            else
                            {
                                _loc_20 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_20.zpp_pool;
                                _loc_20.zpp_pool = null;
                                _loc_20.zpp_disp = false;
                                if (_loc_20 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_20.zpp_inner == null)
                            {
                                _loc_21 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_16 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_16 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_16.next;
                                    _loc_16.next = null;
                                }
                                _loc_16.weak = false;
                                _loc_16._immutable = _loc_21;
                                _loc_16.x = _loc_18;
                                _loc_16.y = _loc_19;
                                _loc_20.zpp_inner = _loc_16;
                                _loc_20.zpp_inner.outer = _loc_20;
                            }
                            else
                            {
                                if (_loc_20 != null)
                                {
                                }
                                if (_loc_20.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_16 = _loc_20.zpp_inner;
                                if (_loc_16._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_16._isimmutable != null)
                                {
                                    _loc_16._isimmutable();
                                }
                                if (_loc_18 == _loc_18)
                                {
                                }
                                if (_loc_19 != _loc_19)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_20 != null)
                                {
                                }
                                if (_loc_20.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_16 = _loc_20.zpp_inner;
                                if (_loc_16._validate != null)
                                {
                                    _loc_16._validate();
                                }
                                if (_loc_20.zpp_inner.x == _loc_18)
                                {
                                    if (_loc_20 != null)
                                    {
                                    }
                                    if (_loc_20.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_16 = _loc_20.zpp_inner;
                                    if (_loc_16._validate != null)
                                    {
                                        _loc_16._validate();
                                    }
                                }
                                if (_loc_20.zpp_inner.y != _loc_19)
                                {
                                    _loc_20.zpp_inner.x = _loc_18;
                                    _loc_20.zpp_inner.y = _loc_19;
                                    _loc_16 = _loc_20.zpp_inner;
                                    if (_loc_16._invalidate != null)
                                    {
                                        _loc_16._invalidate(_loc_16);
                                    }
                                }
                            }
                            _loc_20.zpp_inner.weak = _loc_17;
                            _loc_6 = _loc_20;
                        }
                    }
                    else
                    {
                        _loc_20 = zpp_inner.xform.outer.transform(_loc_12);
                        if (_loc_20 != null)
                        {
                        }
                        if (_loc_20.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_20.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_10 = _loc_20.zpp_inner.x + 0.5;
                        if (_loc_20 != null)
                        {
                        }
                        if (_loc_20.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_20.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                        _loc_13 = _loc_20.zpp_inner.y + 0.5;
                        if (_loc_15)
                        {
                            _loc_6 = _loc_20;
                        }
                        else
                        {
                            if (_loc_20 != null)
                            {
                            }
                            if (_loc_20.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_20.zpp_inner;
                            if (_loc_16._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_16._isimmutable != null)
                            {
                                _loc_16._isimmutable();
                            }
                            if (_loc_20.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_16 = _loc_20.zpp_inner;
                            _loc_20.zpp_inner.outer = null;
                            _loc_20.zpp_inner = null;
                            _loc_22 = _loc_20;
                            _loc_22.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_22;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_22;
                            }
                            ZPP_PubPool.nextVec2 = _loc_22;
                            _loc_22.zpp_disp = true;
                            _loc_23 = _loc_16;
                            if (_loc_23.outer != null)
                            {
                                _loc_23.outer.zpp_inner = null;
                                _loc_23.outer = null;
                            }
                            _loc_23._isimmutable = null;
                            _loc_23._validate = null;
                            _loc_23._invalidate = null;
                            _loc_23.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_23;
                        }
                    }
                    if (_loc_15)
                    {
                        _loc_7 = _loc_10;
                        _loc_4 = _loc_7;
                        _loc_8 = _loc_13;
                        _loc_5 = _loc_8;
                    }
                    else
                    {
                        zpp_inner_zn.__line(_loc_7, _loc_8, _loc_10, _loc_13, _loc_3);
                        _loc_7 = _loc_10;
                        _loc_8 = _loc_13;
                    }
                    _loc_27.zpp_inner.zpp_inner.valmod();
                    _loc_10 = _loc_27.zpp_inner.zpp_gl();
                    _loc_27.zpp_critical = true;
                }while (_loc_27.zpp_i < _loc_10 ? (true) : (_loc_27.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_27, _loc_27.zpp_inner = null, false))
            }
            else if (param1 is GeomPoly)
            {
                _loc_28 = param1;
                if (_loc_28 != null)
                {
                }
                if (_loc_28.zpp_disp)
                {
                    throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
                }
                _loc_29 = _loc_28.zpp_inner.vertices;
                if (_loc_29 != null)
                {
                    _loc_30 = _loc_29;
                    do
                    {
                        
                        _loc_18 = _loc_30.x;
                        _loc_19 = _loc_30.y;
                        _loc_15 = false;
                        if (_loc_18 == _loc_18)
                        {
                        }
                        if (_loc_19 != _loc_19)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (ZPP_PubPool.poolVec2 == null)
                        {
                            _loc_20 = new Vec2();
                        }
                        else
                        {
                            _loc_20 = ZPP_PubPool.poolVec2;
                            ZPP_PubPool.poolVec2 = _loc_20.zpp_pool;
                            _loc_20.zpp_pool = null;
                            _loc_20.zpp_disp = false;
                            if (_loc_20 == ZPP_PubPool.nextVec2)
                            {
                                ZPP_PubPool.nextVec2 = null;
                            }
                        }
                        if (_loc_20.zpp_inner == null)
                        {
                            _loc_17 = false;
                            if (ZPP_Vec2.zpp_pool == null)
                            {
                                _loc_16 = new ZPP_Vec2();
                            }
                            else
                            {
                                _loc_16 = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_16.next;
                                _loc_16.next = null;
                            }
                            _loc_16.weak = false;
                            _loc_16._immutable = _loc_17;
                            _loc_16.x = _loc_18;
                            _loc_16.y = _loc_19;
                            _loc_20.zpp_inner = _loc_16;
                            _loc_20.zpp_inner.outer = _loc_20;
                        }
                        else
                        {
                            if (_loc_20 != null)
                            {
                            }
                            if (_loc_20.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_20.zpp_inner;
                            if (_loc_16._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_16._isimmutable != null)
                            {
                                _loc_16._isimmutable();
                            }
                            if (_loc_18 == _loc_18)
                            {
                            }
                            if (_loc_19 != _loc_19)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (_loc_20 != null)
                            {
                            }
                            if (_loc_20.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_20.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            if (_loc_20.zpp_inner.x == _loc_18)
                            {
                                if (_loc_20 != null)
                                {
                                }
                                if (_loc_20.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_16 = _loc_20.zpp_inner;
                                if (_loc_16._validate != null)
                                {
                                    _loc_16._validate();
                                }
                            }
                            if (_loc_20.zpp_inner.y != _loc_19)
                            {
                                _loc_20.zpp_inner.x = _loc_18;
                                _loc_20.zpp_inner.y = _loc_19;
                                _loc_16 = _loc_20.zpp_inner;
                                if (_loc_16._invalidate != null)
                                {
                                    _loc_16._invalidate(_loc_16);
                                }
                            }
                        }
                        _loc_20.zpp_inner.weak = _loc_15;
                        _loc_12 = _loc_20;
                        _loc_30 = _loc_30.next;
                        _loc_15 = _loc_6 == null;
                        if (zpp_inner.xnull)
                        {
                            if (_loc_12 != null)
                            {
                            }
                            if (_loc_12.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_12.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            _loc_10 = _loc_12.zpp_inner.x + 0.5;
                            if (_loc_12 != null)
                            {
                            }
                            if (_loc_12.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_12.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            _loc_13 = _loc_12.zpp_inner.y + 0.5;
                            if (_loc_15)
                            {
                                _loc_17 = false;
                                if (_loc_12 != null)
                                {
                                }
                                if (_loc_12.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                if (_loc_12.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_16 = _loc_12.zpp_inner;
                                if (_loc_16._validate != null)
                                {
                                    _loc_16._validate();
                                }
                                _loc_18 = _loc_12.zpp_inner.x;
                                if (_loc_12.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_16 = _loc_12.zpp_inner;
                                if (_loc_16._validate != null)
                                {
                                    _loc_16._validate();
                                }
                                _loc_19 = _loc_12.zpp_inner.y;
                                if (_loc_18 == _loc_18)
                                {
                                }
                                if (_loc_19 != _loc_19)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (ZPP_PubPool.poolVec2 == null)
                                {
                                    _loc_20 = new Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_PubPool.poolVec2;
                                    ZPP_PubPool.poolVec2 = _loc_20.zpp_pool;
                                    _loc_20.zpp_pool = null;
                                    _loc_20.zpp_disp = false;
                                    if (_loc_20 == ZPP_PubPool.nextVec2)
                                    {
                                        ZPP_PubPool.nextVec2 = null;
                                    }
                                }
                                if (_loc_20.zpp_inner == null)
                                {
                                    _loc_21 = false;
                                    if (ZPP_Vec2.zpp_pool == null)
                                    {
                                        _loc_16 = new ZPP_Vec2();
                                    }
                                    else
                                    {
                                        _loc_16 = ZPP_Vec2.zpp_pool;
                                        ZPP_Vec2.zpp_pool = _loc_16.next;
                                        _loc_16.next = null;
                                    }
                                    _loc_16.weak = false;
                                    _loc_16._immutable = _loc_21;
                                    _loc_16.x = _loc_18;
                                    _loc_16.y = _loc_19;
                                    _loc_20.zpp_inner = _loc_16;
                                    _loc_20.zpp_inner.outer = _loc_20;
                                }
                                else
                                {
                                    if (_loc_20 != null)
                                    {
                                    }
                                    if (_loc_20.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_16 = _loc_20.zpp_inner;
                                    if (_loc_16._immutable)
                                    {
                                        throw "Error: Vec2 is immutable";
                                    }
                                    if (_loc_16._isimmutable != null)
                                    {
                                        _loc_16._isimmutable();
                                    }
                                    if (_loc_18 == _loc_18)
                                    {
                                    }
                                    if (_loc_19 != _loc_19)
                                    {
                                        throw "Error: Vec2 components cannot be NaN";
                                    }
                                    if (_loc_20 != null)
                                    {
                                    }
                                    if (_loc_20.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_16 = _loc_20.zpp_inner;
                                    if (_loc_16._validate != null)
                                    {
                                        _loc_16._validate();
                                    }
                                    if (_loc_20.zpp_inner.x == _loc_18)
                                    {
                                        if (_loc_20 != null)
                                        {
                                        }
                                        if (_loc_20.zpp_disp)
                                        {
                                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                        }
                                        _loc_16 = _loc_20.zpp_inner;
                                        if (_loc_16._validate != null)
                                        {
                                            _loc_16._validate();
                                        }
                                    }
                                    if (_loc_20.zpp_inner.y != _loc_19)
                                    {
                                        _loc_20.zpp_inner.x = _loc_18;
                                        _loc_20.zpp_inner.y = _loc_19;
                                        _loc_16 = _loc_20.zpp_inner;
                                        if (_loc_16._invalidate != null)
                                        {
                                            _loc_16._invalidate(_loc_16);
                                        }
                                    }
                                }
                                _loc_20.zpp_inner.weak = _loc_17;
                                _loc_6 = _loc_20;
                            }
                        }
                        else
                        {
                            _loc_20 = zpp_inner.xform.outer.transform(_loc_12);
                            if (_loc_20 != null)
                            {
                            }
                            if (_loc_20.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_20.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            _loc_10 = _loc_20.zpp_inner.x + 0.5;
                            if (_loc_20 != null)
                            {
                            }
                            if (_loc_20.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_20.zpp_inner;
                            if (_loc_16._validate != null)
                            {
                                _loc_16._validate();
                            }
                            _loc_13 = _loc_20.zpp_inner.y + 0.5;
                            if (_loc_15)
                            {
                                _loc_6 = _loc_20;
                            }
                            else
                            {
                                if (_loc_20 != null)
                                {
                                }
                                if (_loc_20.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_16 = _loc_20.zpp_inner;
                                if (_loc_16._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_16._isimmutable != null)
                                {
                                    _loc_16._isimmutable();
                                }
                                if (_loc_20.zpp_inner._inuse)
                                {
                                    throw "Error: This Vec2 is not disposable";
                                }
                                _loc_16 = _loc_20.zpp_inner;
                                _loc_20.zpp_inner.outer = null;
                                _loc_20.zpp_inner = null;
                                _loc_22 = _loc_20;
                                _loc_22.zpp_pool = null;
                                if (ZPP_PubPool.nextVec2 != null)
                                {
                                    ZPP_PubPool.nextVec2.zpp_pool = _loc_22;
                                }
                                else
                                {
                                    ZPP_PubPool.poolVec2 = _loc_22;
                                }
                                ZPP_PubPool.nextVec2 = _loc_22;
                                _loc_22.zpp_disp = true;
                                _loc_23 = _loc_16;
                                if (_loc_23.outer != null)
                                {
                                    _loc_23.outer.zpp_inner = null;
                                    _loc_23.outer = null;
                                }
                                _loc_23._isimmutable = null;
                                _loc_23._validate = null;
                                _loc_23._invalidate = null;
                                _loc_23.next = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_23;
                            }
                        }
                        if (_loc_15)
                        {
                            _loc_7 = _loc_10;
                            _loc_4 = _loc_7;
                            _loc_8 = _loc_13;
                            _loc_5 = _loc_8;
                        }
                        else
                        {
                            zpp_inner_zn.__line(_loc_7, _loc_8, _loc_10, _loc_13, _loc_3);
                            _loc_7 = _loc_10;
                            _loc_8 = _loc_13;
                        }
                        if (_loc_12 != null)
                        {
                        }
                        if (_loc_12.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_12.zpp_inner;
                        if (_loc_16._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_16._isimmutable != null)
                        {
                            _loc_16._isimmutable();
                        }
                        if (_loc_12.zpp_inner._inuse)
                        {
                            throw "Error: This Vec2 is not disposable";
                        }
                        _loc_16 = _loc_12.zpp_inner;
                        _loc_12.zpp_inner.outer = null;
                        _loc_12.zpp_inner = null;
                        _loc_20 = _loc_12;
                        _loc_20.zpp_pool = null;
                        if (ZPP_PubPool.nextVec2 != null)
                        {
                            ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                        }
                        else
                        {
                            ZPP_PubPool.poolVec2 = _loc_20;
                        }
                        ZPP_PubPool.nextVec2 = _loc_20;
                        _loc_20.zpp_disp = true;
                        _loc_23 = _loc_16;
                        if (_loc_23.outer != null)
                        {
                            _loc_23.outer.zpp_inner = null;
                            _loc_23.outer = null;
                        }
                        _loc_23._isimmutable = null;
                        _loc_23._validate = null;
                        _loc_23._invalidate = null;
                        _loc_23.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_23;
                    }while (_loc_30 != _loc_29)
                }
            }
            else
            {
                throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
            }
            zpp_inner_zn.__line(_loc_7, _loc_8, _loc_4, _loc_5, _loc_3);
            if (_loc_6 != null)
            {
            }
            if (_loc_6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_6.zpp_inner;
            if (_loc_16._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_16._isimmutable != null)
            {
                _loc_16._isimmutable();
            }
            if (_loc_6.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_16 = _loc_6.zpp_inner;
            _loc_6.zpp_inner.outer = null;
            _loc_6.zpp_inner = null;
            _loc_12 = _loc_6;
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
            _loc_23 = _loc_16;
            if (_loc_23.outer != null)
            {
                _loc_23.outer.zpp_inner = null;
                _loc_23.outer = null;
            }
            _loc_23._isimmutable = null;
            _loc_23._validate = null;
            _loc_23._invalidate = null;
            _loc_23.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_23;
            if (param1 is Array)
            {
                _loc_9 = param1;
                _loc_10 = 0;
                while (_loc_10 < _loc_9.length)
                {
                    
                    _loc_12 = _loc_9[_loc_10];
                    if (_loc_12.zpp_inner.weak)
                    {
                        if (_loc_12 != null)
                        {
                        }
                        if (_loc_12.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_12.zpp_inner;
                        if (_loc_16._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_16._isimmutable != null)
                        {
                            _loc_16._isimmutable();
                        }
                        if (_loc_12.zpp_inner._inuse)
                        {
                            throw "Error: This Vec2 is not disposable";
                        }
                        _loc_16 = _loc_12.zpp_inner;
                        _loc_12.zpp_inner.outer = null;
                        _loc_12.zpp_inner = null;
                        _loc_20 = _loc_12;
                        _loc_20.zpp_pool = null;
                        if (ZPP_PubPool.nextVec2 != null)
                        {
                            ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                        }
                        else
                        {
                            ZPP_PubPool.poolVec2 = _loc_20;
                        }
                        ZPP_PubPool.nextVec2 = _loc_20;
                        _loc_20.zpp_disp = true;
                        _loc_23 = _loc_16;
                        if (_loc_23.outer != null)
                        {
                            _loc_23.outer.zpp_inner = null;
                            _loc_23.outer = null;
                        }
                        _loc_23._isimmutable = null;
                        _loc_23._validate = null;
                        _loc_23._invalidate = null;
                        _loc_23.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_23;
                    }
                    else
                    {
                    }
                    if (false)
                    {
                        _loc_9.splice(_loc_10, 1);
                        continue;
                    }
                    _loc_10++;
                }
            }
            else if (param1 is ZPP_Const.vec2vector)
            {
                _loc_24 = param1;
                if (!_loc_24.fixed)
                {
                    _loc_10 = 0;
                    while (_loc_10 < _loc_24.length)
                    {
                        
                        _loc_12 = _loc_24[_loc_10];
                        if (_loc_12.zpp_inner.weak)
                        {
                            if (_loc_12 != null)
                            {
                            }
                            if (_loc_12.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_16 = _loc_12.zpp_inner;
                            if (_loc_16._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_16._isimmutable != null)
                            {
                                _loc_16._isimmutable();
                            }
                            if (_loc_12.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_16 = _loc_12.zpp_inner;
                            _loc_12.zpp_inner.outer = null;
                            _loc_12.zpp_inner = null;
                            _loc_20 = _loc_12;
                            _loc_20.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_20;
                            }
                            ZPP_PubPool.nextVec2 = _loc_20;
                            _loc_20.zpp_disp = true;
                            _loc_23 = _loc_16;
                            if (_loc_23.outer != null)
                            {
                                _loc_23.outer.zpp_inner = null;
                                _loc_23.outer = null;
                            }
                            _loc_23._isimmutable = null;
                            _loc_23._validate = null;
                            _loc_23._invalidate = null;
                            _loc_23.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_23;
                        }
                        else
                        {
                        }
                        if (false)
                        {
                            _loc_24.splice(_loc_10, 1);
                            continue;
                        }
                        _loc_10++;
                    }
                }
            }
            else if (param1 is Vec2List)
            {
                _loc_26 = param1;
                if (_loc_26.zpp_inner._validate != null)
                {
                    _loc_26.zpp_inner._validate();
                }
                _loc_31 = _loc_26.zpp_inner.inner;
                _loc_32 = null;
                _loc_33 = _loc_31.head;
                while (_loc_33 != null)
                {
                    
                    _loc_16 = _loc_33.elt;
                    if (_loc_16.outer.zpp_inner.weak)
                    {
                        _loc_33 = _loc_31.erase(_loc_32);
                        if (_loc_16.outer.zpp_inner.weak)
                        {
                            _loc_12 = _loc_16.outer;
                            if (_loc_12 != null)
                            {
                            }
                            if (_loc_12.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_23 = _loc_12.zpp_inner;
                            if (_loc_23._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_23._isimmutable != null)
                            {
                                _loc_23._isimmutable();
                            }
                            if (_loc_12.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_23 = _loc_12.zpp_inner;
                            _loc_12.zpp_inner.outer = null;
                            _loc_12.zpp_inner = null;
                            _loc_20 = _loc_12;
                            _loc_20.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_20;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_20;
                            }
                            ZPP_PubPool.nextVec2 = _loc_20;
                            _loc_20.zpp_disp = true;
                            _loc_34 = _loc_23;
                            if (_loc_34.outer != null)
                            {
                                _loc_34.outer.zpp_inner = null;
                                _loc_34.outer = null;
                            }
                            _loc_34._isimmutable = null;
                            _loc_34._validate = null;
                            _loc_34._invalidate = null;
                            _loc_34.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_34;
                        }
                        else
                        {
                        }
                        continue;
                    }
                    _loc_32 = _loc_33;
                    _loc_33 = _loc_33.next;
                }
            }
            return;
        }// end function

        override public function drawLine(param1:Vec2, param2:Vec2, param3:int) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as Vec2;
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: drawLine::start cannot be null";
            }
            if (param2 == null)
            {
                throw "Error: drawLine::end cannot be null";
            }
            if (zpp_inner.xnull)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param1.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_4 = param1.zpp_inner.x + 0.5;
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param1.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_6 = param1.zpp_inner.y + 0.5;
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param2.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_7 = param2.zpp_inner.x + 0.5;
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param2.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_8 = param2.zpp_inner.y + 0.5;
                zpp_inner_zn.__line(_loc_4, _loc_6, _loc_7, _loc_8, param3 | -16777216);
                if (param1.zpp_inner.weak)
                {
                    if (param1 != null)
                    {
                    }
                    if (param1.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = param1.zpp_inner;
                    if (_loc_5._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_5._isimmutable != null)
                    {
                        _loc_5._isimmutable();
                    }
                    if (param1.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_5 = param1.zpp_inner;
                    param1.zpp_inner.outer = null;
                    param1.zpp_inner = null;
                    _loc_9 = param1;
                    _loc_9.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_9;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_9;
                    }
                    ZPP_PubPool.nextVec2 = _loc_9;
                    _loc_9.zpp_disp = true;
                    _loc_10 = _loc_5;
                    if (_loc_10.outer != null)
                    {
                        _loc_10.outer.zpp_inner = null;
                        _loc_10.outer = null;
                    }
                    _loc_10._isimmutable = null;
                    _loc_10._validate = null;
                    _loc_10._invalidate = null;
                    _loc_10.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_10;
                }
                else
                {
                }
                if (param2.zpp_inner.weak)
                {
                    if (param2 != null)
                    {
                    }
                    if (param2.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = param2.zpp_inner;
                    if (_loc_5._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_5._isimmutable != null)
                    {
                        _loc_5._isimmutable();
                    }
                    if (param2.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_5 = param2.zpp_inner;
                    param2.zpp_inner.outer = null;
                    param2.zpp_inner = null;
                    _loc_9 = param2;
                    _loc_9.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_9;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_9;
                    }
                    ZPP_PubPool.nextVec2 = _loc_9;
                    _loc_9.zpp_disp = true;
                    _loc_10 = _loc_5;
                    if (_loc_10.outer != null)
                    {
                        _loc_10.outer.zpp_inner = null;
                        _loc_10.outer = null;
                    }
                    _loc_10._isimmutable = null;
                    _loc_10._validate = null;
                    _loc_10._invalidate = null;
                    _loc_10.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_10;
                }
                else
                {
                }
            }
            else
            {
                _loc_9 = zpp_inner.xform.outer.transform(param1);
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_9.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_4 = _loc_9.zpp_inner.x + 0.5;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_9.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_6 = _loc_9.zpp_inner.y + 0.5;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_9.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_9.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_9.zpp_inner;
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
                _loc_10 = _loc_5;
                if (_loc_10.outer != null)
                {
                    _loc_10.outer.zpp_inner = null;
                    _loc_10.outer = null;
                }
                _loc_10._isimmutable = null;
                _loc_10._validate = null;
                _loc_10._invalidate = null;
                _loc_10.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_10;
                _loc_9 = zpp_inner.xform.outer.transform(param2);
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_9.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_7 = _loc_9.zpp_inner.x + 0.5;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_9.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_8 = _loc_9.zpp_inner.y + 0.5;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_9.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_9.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_9.zpp_inner;
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
                _loc_10 = _loc_5;
                if (_loc_10.outer != null)
                {
                    _loc_10.outer.zpp_inner = null;
                    _loc_10.outer = null;
                }
                _loc_10._isimmutable = null;
                _loc_10._validate = null;
                _loc_10._invalidate = null;
                _loc_10.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_10;
                zpp_inner_zn.__line(_loc_4, _loc_6, _loc_7, _loc_8, param3 | -16777216);
            }
            return;
        }// end function

        override public function drawFilledTriangle(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param2 != null)
            {
            }
            if (param3 == null)
            {
                throw "Error: drawFilledTriangle can\'t use null points";
            }
            zpp_inner_zn.__tri(param1, param2, param3, param4);
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param1.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_6 = param1;
                _loc_6.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_6;
                }
                ZPP_PubPool.nextVec2 = _loc_6;
                _loc_6.zpp_disp = true;
                _loc_7 = _loc_5;
                if (_loc_7.outer != null)
                {
                    _loc_7.outer.zpp_inner = null;
                    _loc_7.outer = null;
                }
                _loc_7._isimmutable = null;
                _loc_7._validate = null;
                _loc_7._invalidate = null;
                _loc_7.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7;
            }
            else
            {
            }
            if (param2.zpp_inner.weak)
            {
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param2.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (param2.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = param2.zpp_inner;
                param2.zpp_inner.outer = null;
                param2.zpp_inner = null;
                _loc_6 = param2;
                _loc_6.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_6;
                }
                ZPP_PubPool.nextVec2 = _loc_6;
                _loc_6.zpp_disp = true;
                _loc_7 = _loc_5;
                if (_loc_7.outer != null)
                {
                    _loc_7.outer.zpp_inner = null;
                    _loc_7.outer = null;
                }
                _loc_7._isimmutable = null;
                _loc_7._validate = null;
                _loc_7._invalidate = null;
                _loc_7.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7;
            }
            else
            {
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
                _loc_5 = param3.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (param3.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = param3.zpp_inner;
                param3.zpp_inner.outer = null;
                param3.zpp_inner = null;
                _loc_6 = param3;
                _loc_6.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_6;
                }
                ZPP_PubPool.nextVec2 = _loc_6;
                _loc_6.zpp_disp = true;
                _loc_7 = _loc_5;
                if (_loc_7.outer != null)
                {
                    _loc_7.outer.zpp_inner = null;
                    _loc_7.outer = null;
                }
                _loc_7._isimmutable = null;
                _loc_7._validate = null;
                _loc_7._invalidate = null;
                _loc_7.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7;
            }
            else
            {
            }
            return;
        }// end function

        override public function drawFilledPolygon(param1, param2:int) : void
        {
            var _loc_7:* = null as Array;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null as Vec2;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = false;
            var _loc_13:* = NaN;
            var _loc_14:* = null as ZPP_Vec2;
            var _loc_15:* = NaN;
            var _loc_16:* = null as Vec2;
            var _loc_17:* = false;
            var _loc_18:* = null as Vector.<Vec2>;
            var _loc_19:* = null as Vec2;
            var _loc_20:* = null as Vec2List;
            var _loc_21:* = null as Vec2Iterator;
            var _loc_22:* = null as GeomPoly;
            var _loc_23:* = null as ZPP_GeomVert;
            var _loc_24:* = null as ZPP_GeomVert;
            var _loc_25:* = null as ZPP_Vec2;
            var _loc_26:* = null as ZNPList_ZPP_Vec2;
            var _loc_27:* = null as ZNPNode_ZPP_Vec2;
            var _loc_28:* = null as ZNPNode_ZPP_Vec2;
            var _loc_29:* = null as ZPP_Vec2;
            var _loc_33:* = 0;
            var _loc_34:* = 0;
            var _loc_35:* = 0;
            var _loc_36:* = 0;
            var _loc_37:* = 0;
            var _loc_38:* = 0;
            var _loc_39:* = 0;
            var _loc_40:* = 0;
            var _loc_41:* = 0;
            var _loc_42:* = 0;
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot render null polygon";
            }
            var _loc_3:* = param2 | -16777216;
            var _loc_4:* = Math.POSITIVE_INFINITY;
            var _loc_5:* = Math.NEGATIVE_INFINITY;
            var _loc_6:* = zpp_inner_zn.filledVertices;
            if (param1 is Array)
            {
                _loc_7 = param1;
                _loc_8 = 0;
                while (_loc_8 < _loc_7.length)
                {
                    
                    _loc_9 = _loc_7[_loc_8];
                    _loc_8++;
                    if (_loc_9 == null)
                    {
                        throw "Error: Array<Vec2> contains null objects";
                    }
                    if (!(_loc_9 is Vec2))
                    {
                        throw "Error: Array<Vec2> contains non Vec2 objects";
                    }
                    _loc_10 = _loc_9;
                    if (_loc_10 != null)
                    {
                    }
                    if (_loc_10.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (zpp_inner.xnull)
                    {
                        _loc_12 = false;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_13 = _loc_10.zpp_inner.x;
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_15 = _loc_10.zpp_inner.y;
                        if (_loc_13 == _loc_13)
                        {
                        }
                        if (_loc_15 != _loc_15)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (ZPP_PubPool.poolVec2 == null)
                        {
                            _loc_16 = new Vec2();
                        }
                        else
                        {
                            _loc_16 = ZPP_PubPool.poolVec2;
                            ZPP_PubPool.poolVec2 = _loc_16.zpp_pool;
                            _loc_16.zpp_pool = null;
                            _loc_16.zpp_disp = false;
                            if (_loc_16 == ZPP_PubPool.nextVec2)
                            {
                                ZPP_PubPool.nextVec2 = null;
                            }
                        }
                        if (_loc_16.zpp_inner == null)
                        {
                            _loc_17 = false;
                            if (ZPP_Vec2.zpp_pool == null)
                            {
                                _loc_14 = new ZPP_Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_14.next;
                                _loc_14.next = null;
                            }
                            _loc_14.weak = false;
                            _loc_14._immutable = _loc_17;
                            _loc_14.x = _loc_13;
                            _loc_14.y = _loc_15;
                            _loc_16.zpp_inner = _loc_14;
                            _loc_16.zpp_inner.outer = _loc_16;
                        }
                        else
                        {
                            if (_loc_16 != null)
                            {
                            }
                            if (_loc_16.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_16.zpp_inner;
                            if (_loc_14._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_14._isimmutable != null)
                            {
                                _loc_14._isimmutable();
                            }
                            if (_loc_13 == _loc_13)
                            {
                            }
                            if (_loc_15 != _loc_15)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (_loc_16 != null)
                            {
                            }
                            if (_loc_16.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_16.zpp_inner;
                            if (_loc_14._validate != null)
                            {
                                _loc_14._validate();
                            }
                            if (_loc_16.zpp_inner.x == _loc_13)
                            {
                                if (_loc_16 != null)
                                {
                                }
                                if (_loc_16.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_14 = _loc_16.zpp_inner;
                                if (_loc_14._validate != null)
                                {
                                    _loc_14._validate();
                                }
                            }
                            if (_loc_16.zpp_inner.y != _loc_15)
                            {
                                _loc_16.zpp_inner.x = _loc_13;
                                _loc_16.zpp_inner.y = _loc_15;
                                _loc_14 = _loc_16.zpp_inner;
                                if (_loc_14._invalidate != null)
                                {
                                    _loc_14._invalidate(_loc_14);
                                }
                            }
                        }
                        _loc_16.zpp_inner.weak = _loc_12;
                        _loc_11 = _loc_16;
                        _loc_6.push(_loc_11);
                    }
                    else
                    {
                        _loc_11 = zpp_inner.xform.outer.transform(_loc_10);
                        _loc_6.push(_loc_11);
                    }
                    if (_loc_11 != null)
                    {
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_14 = _loc_11.zpp_inner;
                    if (_loc_14._validate != null)
                    {
                        _loc_14._validate();
                    }
                    if (_loc_11.zpp_inner.y < _loc_4)
                    {
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_4 = _loc_11.zpp_inner.y;
                    }
                    if (_loc_11 != null)
                    {
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_14 = _loc_11.zpp_inner;
                    if (_loc_14._validate != null)
                    {
                        _loc_14._validate();
                    }
                    if (_loc_11.zpp_inner.y > _loc_5)
                    {
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_5 = _loc_11.zpp_inner.y;
                    }
                }
            }
            else if (param1 is ZPP_Const.vec2vector)
            {
                _loc_18 = param1;
                _loc_8 = 0;
                while (_loc_8 < _loc_18.length)
                {
                    
                    _loc_10 = _loc_18[_loc_8];
                    _loc_8++;
                    if (_loc_10 == null)
                    {
                        throw "Error: flash.Vector<Vec2> contains null objects";
                    }
                    _loc_11 = _loc_10;
                    if (_loc_11 != null)
                    {
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (zpp_inner.xnull)
                    {
                        _loc_12 = false;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_13 = _loc_11.zpp_inner.x;
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_15 = _loc_11.zpp_inner.y;
                        if (_loc_13 == _loc_13)
                        {
                        }
                        if (_loc_15 != _loc_15)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (ZPP_PubPool.poolVec2 == null)
                        {
                            _loc_19 = new Vec2();
                        }
                        else
                        {
                            _loc_19 = ZPP_PubPool.poolVec2;
                            ZPP_PubPool.poolVec2 = _loc_19.zpp_pool;
                            _loc_19.zpp_pool = null;
                            _loc_19.zpp_disp = false;
                            if (_loc_19 == ZPP_PubPool.nextVec2)
                            {
                                ZPP_PubPool.nextVec2 = null;
                            }
                        }
                        if (_loc_19.zpp_inner == null)
                        {
                            _loc_17 = false;
                            if (ZPP_Vec2.zpp_pool == null)
                            {
                                _loc_14 = new ZPP_Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_14.next;
                                _loc_14.next = null;
                            }
                            _loc_14.weak = false;
                            _loc_14._immutable = _loc_17;
                            _loc_14.x = _loc_13;
                            _loc_14.y = _loc_15;
                            _loc_19.zpp_inner = _loc_14;
                            _loc_19.zpp_inner.outer = _loc_19;
                        }
                        else
                        {
                            if (_loc_19 != null)
                            {
                            }
                            if (_loc_19.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_19.zpp_inner;
                            if (_loc_14._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_14._isimmutable != null)
                            {
                                _loc_14._isimmutable();
                            }
                            if (_loc_13 == _loc_13)
                            {
                            }
                            if (_loc_15 != _loc_15)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (_loc_19 != null)
                            {
                            }
                            if (_loc_19.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_19.zpp_inner;
                            if (_loc_14._validate != null)
                            {
                                _loc_14._validate();
                            }
                            if (_loc_19.zpp_inner.x == _loc_13)
                            {
                                if (_loc_19 != null)
                                {
                                }
                                if (_loc_19.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_14 = _loc_19.zpp_inner;
                                if (_loc_14._validate != null)
                                {
                                    _loc_14._validate();
                                }
                            }
                            if (_loc_19.zpp_inner.y != _loc_15)
                            {
                                _loc_19.zpp_inner.x = _loc_13;
                                _loc_19.zpp_inner.y = _loc_15;
                                _loc_14 = _loc_19.zpp_inner;
                                if (_loc_14._invalidate != null)
                                {
                                    _loc_14._invalidate(_loc_14);
                                }
                            }
                        }
                        _loc_19.zpp_inner.weak = _loc_12;
                        _loc_16 = _loc_19;
                        _loc_6.push(_loc_16);
                    }
                    else
                    {
                        _loc_16 = zpp_inner.xform.outer.transform(_loc_11);
                        _loc_6.push(_loc_16);
                    }
                    if (_loc_16 != null)
                    {
                    }
                    if (_loc_16.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_14 = _loc_16.zpp_inner;
                    if (_loc_14._validate != null)
                    {
                        _loc_14._validate();
                    }
                    if (_loc_16.zpp_inner.y < _loc_4)
                    {
                        if (_loc_16 != null)
                        {
                        }
                        if (_loc_16.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_16.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_4 = _loc_16.zpp_inner.y;
                    }
                    if (_loc_16 != null)
                    {
                    }
                    if (_loc_16.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_14 = _loc_16.zpp_inner;
                    if (_loc_14._validate != null)
                    {
                        _loc_14._validate();
                    }
                    if (_loc_16.zpp_inner.y > _loc_5)
                    {
                        if (_loc_16 != null)
                        {
                        }
                        if (_loc_16.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_16.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_5 = _loc_16.zpp_inner.y;
                    }
                }
            }
            else if (param1 is Vec2List)
            {
                _loc_20 = param1;
                _loc_21 = _loc_20.iterator();
                do
                {
                    
                    _loc_21.zpp_critical = false;
                    _loc_8 = _loc_21.zpp_i;
                    (_loc_21.zpp_i + 1);
                    _loc_10 = _loc_21.zpp_inner.at(_loc_8);
                    if (_loc_10 == null)
                    {
                        throw "Error: Vec2List contains null objects";
                    }
                    if (_loc_10 != null)
                    {
                    }
                    if (_loc_10.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (zpp_inner.xnull)
                    {
                        _loc_12 = false;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_13 = _loc_10.zpp_inner.x;
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_15 = _loc_10.zpp_inner.y;
                        if (_loc_13 == _loc_13)
                        {
                        }
                        if (_loc_15 != _loc_15)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (ZPP_PubPool.poolVec2 == null)
                        {
                            _loc_16 = new Vec2();
                        }
                        else
                        {
                            _loc_16 = ZPP_PubPool.poolVec2;
                            ZPP_PubPool.poolVec2 = _loc_16.zpp_pool;
                            _loc_16.zpp_pool = null;
                            _loc_16.zpp_disp = false;
                            if (_loc_16 == ZPP_PubPool.nextVec2)
                            {
                                ZPP_PubPool.nextVec2 = null;
                            }
                        }
                        if (_loc_16.zpp_inner == null)
                        {
                            _loc_17 = false;
                            if (ZPP_Vec2.zpp_pool == null)
                            {
                                _loc_14 = new ZPP_Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_14.next;
                                _loc_14.next = null;
                            }
                            _loc_14.weak = false;
                            _loc_14._immutable = _loc_17;
                            _loc_14.x = _loc_13;
                            _loc_14.y = _loc_15;
                            _loc_16.zpp_inner = _loc_14;
                            _loc_16.zpp_inner.outer = _loc_16;
                        }
                        else
                        {
                            if (_loc_16 != null)
                            {
                            }
                            if (_loc_16.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_16.zpp_inner;
                            if (_loc_14._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_14._isimmutable != null)
                            {
                                _loc_14._isimmutable();
                            }
                            if (_loc_13 == _loc_13)
                            {
                            }
                            if (_loc_15 != _loc_15)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (_loc_16 != null)
                            {
                            }
                            if (_loc_16.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_16.zpp_inner;
                            if (_loc_14._validate != null)
                            {
                                _loc_14._validate();
                            }
                            if (_loc_16.zpp_inner.x == _loc_13)
                            {
                                if (_loc_16 != null)
                                {
                                }
                                if (_loc_16.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_14 = _loc_16.zpp_inner;
                                if (_loc_14._validate != null)
                                {
                                    _loc_14._validate();
                                }
                            }
                            if (_loc_16.zpp_inner.y != _loc_15)
                            {
                                _loc_16.zpp_inner.x = _loc_13;
                                _loc_16.zpp_inner.y = _loc_15;
                                _loc_14 = _loc_16.zpp_inner;
                                if (_loc_14._invalidate != null)
                                {
                                    _loc_14._invalidate(_loc_14);
                                }
                            }
                        }
                        _loc_16.zpp_inner.weak = _loc_12;
                        _loc_11 = _loc_16;
                        _loc_6.push(_loc_11);
                    }
                    else
                    {
                        _loc_11 = zpp_inner.xform.outer.transform(_loc_10);
                        _loc_6.push(_loc_11);
                    }
                    if (_loc_11 != null)
                    {
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_14 = _loc_11.zpp_inner;
                    if (_loc_14._validate != null)
                    {
                        _loc_14._validate();
                    }
                    if (_loc_11.zpp_inner.y < _loc_4)
                    {
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_4 = _loc_11.zpp_inner.y;
                    }
                    if (_loc_11 != null)
                    {
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_14 = _loc_11.zpp_inner;
                    if (_loc_14._validate != null)
                    {
                        _loc_14._validate();
                    }
                    if (_loc_11.zpp_inner.y > _loc_5)
                    {
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_5 = _loc_11.zpp_inner.y;
                    }
                    _loc_21.zpp_inner.zpp_inner.valmod();
                    _loc_8 = _loc_21.zpp_inner.zpp_gl();
                    _loc_21.zpp_critical = true;
                }while (_loc_21.zpp_i < _loc_8 ? (true) : (_loc_21.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_21, _loc_21.zpp_inner = null, false))
            }
            else if (param1 is GeomPoly)
            {
                _loc_22 = param1;
                if (_loc_22 != null)
                {
                }
                if (_loc_22.zpp_disp)
                {
                    throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_22.zpp_inner.vertices;
                if (_loc_23 != null)
                {
                    _loc_24 = _loc_23;
                    do
                    {
                        
                        _loc_13 = _loc_24.x;
                        _loc_15 = _loc_24.y;
                        _loc_12 = false;
                        if (_loc_13 == _loc_13)
                        {
                        }
                        if (_loc_15 != _loc_15)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (ZPP_PubPool.poolVec2 == null)
                        {
                            _loc_11 = new Vec2();
                        }
                        else
                        {
                            _loc_11 = ZPP_PubPool.poolVec2;
                            ZPP_PubPool.poolVec2 = _loc_11.zpp_pool;
                            _loc_11.zpp_pool = null;
                            _loc_11.zpp_disp = false;
                            if (_loc_11 == ZPP_PubPool.nextVec2)
                            {
                                ZPP_PubPool.nextVec2 = null;
                            }
                        }
                        if (_loc_11.zpp_inner == null)
                        {
                            _loc_17 = false;
                            if (ZPP_Vec2.zpp_pool == null)
                            {
                                _loc_14 = new ZPP_Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_14.next;
                                _loc_14.next = null;
                            }
                            _loc_14.weak = false;
                            _loc_14._immutable = _loc_17;
                            _loc_14.x = _loc_13;
                            _loc_14.y = _loc_15;
                            _loc_11.zpp_inner = _loc_14;
                            _loc_11.zpp_inner.outer = _loc_11;
                        }
                        else
                        {
                            if (_loc_11 != null)
                            {
                            }
                            if (_loc_11.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_11.zpp_inner;
                            if (_loc_14._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_14._isimmutable != null)
                            {
                                _loc_14._isimmutable();
                            }
                            if (_loc_13 == _loc_13)
                            {
                            }
                            if (_loc_15 != _loc_15)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (_loc_11 != null)
                            {
                            }
                            if (_loc_11.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_11.zpp_inner;
                            if (_loc_14._validate != null)
                            {
                                _loc_14._validate();
                            }
                            if (_loc_11.zpp_inner.x == _loc_13)
                            {
                                if (_loc_11 != null)
                                {
                                }
                                if (_loc_11.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_14 = _loc_11.zpp_inner;
                                if (_loc_14._validate != null)
                                {
                                    _loc_14._validate();
                                }
                            }
                            if (_loc_11.zpp_inner.y != _loc_15)
                            {
                                _loc_11.zpp_inner.x = _loc_13;
                                _loc_11.zpp_inner.y = _loc_15;
                                _loc_14 = _loc_11.zpp_inner;
                                if (_loc_14._invalidate != null)
                                {
                                    _loc_14._invalidate(_loc_14);
                                }
                            }
                        }
                        _loc_11.zpp_inner.weak = _loc_12;
                        _loc_10 = _loc_11;
                        _loc_24 = _loc_24.next;
                        if (zpp_inner.xnull)
                        {
                            _loc_12 = false;
                            if (_loc_10 != null)
                            {
                            }
                            if (_loc_10.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            if (_loc_10.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_10.zpp_inner;
                            if (_loc_14._validate != null)
                            {
                                _loc_14._validate();
                            }
                            _loc_13 = _loc_10.zpp_inner.x;
                            if (_loc_10.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_10.zpp_inner;
                            if (_loc_14._validate != null)
                            {
                                _loc_14._validate();
                            }
                            _loc_15 = _loc_10.zpp_inner.y;
                            if (_loc_13 == _loc_13)
                            {
                            }
                            if (_loc_15 != _loc_15)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_16 = new Vec2();
                            }
                            else
                            {
                                _loc_16 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_16.zpp_pool;
                                _loc_16.zpp_pool = null;
                                _loc_16.zpp_disp = false;
                                if (_loc_16 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_16.zpp_inner == null)
                            {
                                _loc_17 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_14 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_14 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_14.next;
                                    _loc_14.next = null;
                                }
                                _loc_14.weak = false;
                                _loc_14._immutable = _loc_17;
                                _loc_14.x = _loc_13;
                                _loc_14.y = _loc_15;
                                _loc_16.zpp_inner = _loc_14;
                                _loc_16.zpp_inner.outer = _loc_16;
                            }
                            else
                            {
                                if (_loc_16 != null)
                                {
                                }
                                if (_loc_16.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_14 = _loc_16.zpp_inner;
                                if (_loc_14._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_14._isimmutable != null)
                                {
                                    _loc_14._isimmutable();
                                }
                                if (_loc_13 == _loc_13)
                                {
                                }
                                if (_loc_15 != _loc_15)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_16 != null)
                                {
                                }
                                if (_loc_16.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_14 = _loc_16.zpp_inner;
                                if (_loc_14._validate != null)
                                {
                                    _loc_14._validate();
                                }
                                if (_loc_16.zpp_inner.x == _loc_13)
                                {
                                    if (_loc_16 != null)
                                    {
                                    }
                                    if (_loc_16.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_14 = _loc_16.zpp_inner;
                                    if (_loc_14._validate != null)
                                    {
                                        _loc_14._validate();
                                    }
                                }
                                if (_loc_16.zpp_inner.y != _loc_15)
                                {
                                    _loc_16.zpp_inner.x = _loc_13;
                                    _loc_16.zpp_inner.y = _loc_15;
                                    _loc_14 = _loc_16.zpp_inner;
                                    if (_loc_14._invalidate != null)
                                    {
                                        _loc_14._invalidate(_loc_14);
                                    }
                                }
                            }
                            _loc_16.zpp_inner.weak = _loc_12;
                            _loc_11 = _loc_16;
                            _loc_6.push(_loc_11);
                        }
                        else
                        {
                            _loc_11 = zpp_inner.xform.outer.transform(_loc_10);
                            _loc_6.push(_loc_11);
                        }
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        if (_loc_11.zpp_inner.y < _loc_4)
                        {
                            if (_loc_11 != null)
                            {
                            }
                            if (_loc_11.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_11.zpp_inner;
                            if (_loc_14._validate != null)
                            {
                                _loc_14._validate();
                            }
                            _loc_4 = _loc_11.zpp_inner.y;
                        }
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        if (_loc_11.zpp_inner.y > _loc_5)
                        {
                            if (_loc_11 != null)
                            {
                            }
                            if (_loc_11.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_11.zpp_inner;
                            if (_loc_14._validate != null)
                            {
                                _loc_14._validate();
                            }
                            _loc_5 = _loc_11.zpp_inner.y;
                        }
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        if (_loc_14._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_14._isimmutable != null)
                        {
                            _loc_14._isimmutable();
                        }
                        if (_loc_10.zpp_inner._inuse)
                        {
                            throw "Error: This Vec2 is not disposable";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        _loc_10.zpp_inner.outer = null;
                        _loc_10.zpp_inner = null;
                        _loc_11 = _loc_10;
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
                        _loc_25 = _loc_14;
                        if (_loc_25.outer != null)
                        {
                            _loc_25.outer.zpp_inner = null;
                            _loc_25.outer = null;
                        }
                        _loc_25._isimmutable = null;
                        _loc_25._validate = null;
                        _loc_25._invalidate = null;
                        _loc_25.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_25;
                    }while (_loc_24 != _loc_23)
                }
            }
            else
            {
                throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
            }
            if (param1 is Array)
            {
                _loc_7 = param1;
                _loc_8 = 0;
                while (_loc_8 < _loc_7.length)
                {
                    
                    _loc_10 = _loc_7[_loc_8];
                    if (_loc_10.zpp_inner.weak)
                    {
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        if (_loc_14._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_14._isimmutable != null)
                        {
                            _loc_14._isimmutable();
                        }
                        if (_loc_10.zpp_inner._inuse)
                        {
                            throw "Error: This Vec2 is not disposable";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        _loc_10.zpp_inner.outer = null;
                        _loc_10.zpp_inner = null;
                        _loc_11 = _loc_10;
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
                        _loc_25 = _loc_14;
                        if (_loc_25.outer != null)
                        {
                            _loc_25.outer.zpp_inner = null;
                            _loc_25.outer = null;
                        }
                        _loc_25._isimmutable = null;
                        _loc_25._validate = null;
                        _loc_25._invalidate = null;
                        _loc_25.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_25;
                    }
                    else
                    {
                    }
                    if (false)
                    {
                        _loc_7.splice(_loc_8, 1);
                        continue;
                    }
                    _loc_8++;
                }
            }
            else if (param1 is ZPP_Const.vec2vector)
            {
                _loc_18 = param1;
                if (!_loc_18.fixed)
                {
                    _loc_8 = 0;
                    while (_loc_8 < _loc_18.length)
                    {
                        
                        _loc_10 = _loc_18[_loc_8];
                        if (_loc_10.zpp_inner.weak)
                        {
                            if (_loc_10 != null)
                            {
                            }
                            if (_loc_10.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_10.zpp_inner;
                            if (_loc_14._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_14._isimmutable != null)
                            {
                                _loc_14._isimmutable();
                            }
                            if (_loc_10.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_14 = _loc_10.zpp_inner;
                            _loc_10.zpp_inner.outer = null;
                            _loc_10.zpp_inner = null;
                            _loc_11 = _loc_10;
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
                            _loc_25 = _loc_14;
                            if (_loc_25.outer != null)
                            {
                                _loc_25.outer.zpp_inner = null;
                                _loc_25.outer = null;
                            }
                            _loc_25._isimmutable = null;
                            _loc_25._validate = null;
                            _loc_25._invalidate = null;
                            _loc_25.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_25;
                        }
                        else
                        {
                        }
                        if (false)
                        {
                            _loc_18.splice(_loc_8, 1);
                            continue;
                        }
                        _loc_8++;
                    }
                }
            }
            else if (param1 is Vec2List)
            {
                _loc_20 = param1;
                if (_loc_20.zpp_inner._validate != null)
                {
                    _loc_20.zpp_inner._validate();
                }
                _loc_26 = _loc_20.zpp_inner.inner;
                _loc_27 = null;
                _loc_28 = _loc_26.head;
                while (_loc_28 != null)
                {
                    
                    _loc_14 = _loc_28.elt;
                    if (_loc_14.outer.zpp_inner.weak)
                    {
                        _loc_28 = _loc_26.erase(_loc_27);
                        if (_loc_14.outer.zpp_inner.weak)
                        {
                            _loc_10 = _loc_14.outer;
                            if (_loc_10 != null)
                            {
                            }
                            if (_loc_10.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_25 = _loc_10.zpp_inner;
                            if (_loc_25._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_25._isimmutable != null)
                            {
                                _loc_25._isimmutable();
                            }
                            if (_loc_10.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_25 = _loc_10.zpp_inner;
                            _loc_10.zpp_inner.outer = null;
                            _loc_10.zpp_inner = null;
                            _loc_11 = _loc_10;
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
                            _loc_29 = _loc_25;
                            if (_loc_29.outer != null)
                            {
                                _loc_29.outer.zpp_inner = null;
                                _loc_29.outer = null;
                            }
                            _loc_29._isimmutable = null;
                            _loc_29._validate = null;
                            _loc_29._invalidate = null;
                            _loc_29.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_29;
                        }
                        else
                        {
                        }
                        continue;
                    }
                    _loc_27 = _loc_28;
                    _loc_28 = _loc_28.next;
                }
            }
            _loc_8 = _loc_4 + 0.5;
            var _loc_30:* = _loc_5 + 0.5;
            if (_loc_30 >= 0)
            {
            }
            if (_loc_8 >= zpp_inner.height)
            {
                return;
            }
            if (_loc_8 < 0)
            {
                _loc_8 = 0;
            }
            if (_loc_30 >= zpp_inner.height)
            {
                _loc_30 = zpp_inner.height - 1;
            }
            _loc_7 = zpp_inner_zn.filledXs;
            var _loc_31:* = _loc_8;
            var _loc_32:* = _loc_30 + 1;
            while (_loc_31 < _loc_32)
            {
                
                _loc_31++;
                _loc_33 = _loc_31;
                _loc_34 = 0;
                _loc_35 = 0;
                _loc_36 = _loc_6.length;
                while (_loc_35 < _loc_36)
                {
                    
                    _loc_35++;
                    _loc_37 = _loc_35;
                    _loc_10 = _loc_6[_loc_37];
                    _loc_11 = _loc_6[(_loc_37 + 1) % _loc_6.length];
                    if (_loc_11 != null)
                    {
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_14 = _loc_11.zpp_inner;
                    if (_loc_14._validate != null)
                    {
                        _loc_14._validate();
                    }
                    if (_loc_11.zpp_inner.y < _loc_33)
                    {
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                    }
                    if (_loc_10.zpp_inner.y < _loc_33)
                    {
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        if (_loc_10.zpp_inner.y < _loc_33)
                        {
                            if (_loc_11 != null)
                            {
                            }
                            if (_loc_11.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_14 = _loc_11.zpp_inner;
                            if (_loc_14._validate != null)
                            {
                                _loc_14._validate();
                            }
                        }
                    }
                    if (_loc_11.zpp_inner.y >= _loc_33)
                    {
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_10.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_13 = _loc_11.zpp_inner.x + (_loc_33 - _loc_11.zpp_inner.y) / (_loc_10.zpp_inner.y - _loc_11.zpp_inner.y) * (_loc_10.zpp_inner.x - _loc_11.zpp_inner.x);
                        _loc_34++;
                        _loc_7[_loc_34] = _loc_13 + 0.5;
                    }
                }
                _loc_35 = 1;
                while (_loc_35 < _loc_34)
                {
                    
                    _loc_35++;
                    _loc_36 = _loc_35;
                    _loc_37 = _loc_7[_loc_36];
                    _loc_38 = _loc_36;
                    while (_loc_38 > 0)
                    {
                        
                        _loc_39 = _loc_7[(_loc_38 - 1)];
                        if (_loc_39 < _loc_37)
                        {
                            break;
                        }
                        _loc_7[_loc_38] = _loc_39;
                        _loc_38--;
                    }
                    _loc_7[_loc_38] = _loc_37;
                }
                _loc_35 = 0;
                while ((_loc_35 + 1) < _loc_34)
                {
                    
                    _loc_35++;
                    _loc_36 = _loc_7[_loc_35];
                    _loc_35++;
                    _loc_37 = _loc_7[_loc_35];
                    if (_loc_37 < 0)
                    {
                        continue;
                    }
                    if (_loc_36 >= zpp_inner.width)
                    {
                        break;
                    }
                    if (_loc_36 < 0)
                    {
                        _loc_36 = 0;
                    }
                    if (_loc_37 >= zpp_inner.width)
                    {
                        _loc_37 = zpp_inner.width - 1;
                    }
                    _loc_38 = _loc_33 * zpp_inner_zn.width + _loc_36;
                    _loc_39 = _loc_36;
                    _loc_40 = _loc_37 + 1;
                    while (_loc_39 < _loc_40)
                    {
                        
                        _loc_39++;
                        _loc_41 = _loc_39;
                        _loc_38++;
                        _loc_42 = _loc_38;
                    }
                }
            }
            while (_loc_6.length > 0)
            {
                
                _loc_10 = _loc_6.pop();
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_14 = _loc_10.zpp_inner;
                if (_loc_14._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_14._isimmutable != null)
                {
                    _loc_14._isimmutable();
                }
                if (_loc_10.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_14 = _loc_10.zpp_inner;
                _loc_10.zpp_inner.outer = null;
                _loc_10.zpp_inner = null;
                _loc_11 = _loc_10;
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
                _loc_25 = _loc_14;
                if (_loc_25.outer != null)
                {
                    _loc_25.outer.zpp_inner = null;
                    _loc_25.outer = null;
                }
                _loc_25._isimmutable = null;
                _loc_25._validate = null;
                _loc_25._invalidate = null;
                _loc_25.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_25;
            }
            return;
        }// end function

        override public function drawFilledCircle(param1:Vec2, param2:Number, param3:int) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = null as Vec2;
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: drawFilledCircle::position cannot be null";
            }
            if (param2 == param2)
            {
            }
            if (param2 < 0)
            {
                throw "Error: drawFilledCircle::radius must be >=0";
            }
            if (zpp_inner.xnull)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param1.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_4 = param1.zpp_inner.x + 0.5;
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param1.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_6 = param1.zpp_inner.y + 0.5;
                _loc_7 = param2 + 0.5;
                zpp_inner_zn.__fcircle(_loc_4, _loc_6, _loc_7, param3 | -16777216);
                if (param1.zpp_inner.weak)
                {
                    if (param1 != null)
                    {
                    }
                    if (param1.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = param1.zpp_inner;
                    if (_loc_5._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_5._isimmutable != null)
                    {
                        _loc_5._isimmutable();
                    }
                    if (param1.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_5 = param1.zpp_inner;
                    param1.zpp_inner.outer = null;
                    param1.zpp_inner = null;
                    _loc_8 = param1;
                    _loc_8.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_8;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_8;
                    }
                    ZPP_PubPool.nextVec2 = _loc_8;
                    _loc_8.zpp_disp = true;
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
                }
                else
                {
                }
            }
            else
            {
                _loc_8 = zpp_inner.xform.outer.transform(param1);
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_4 = _loc_8.zpp_inner.x + 0.5;
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_6 = _loc_8.zpp_inner.y + 0.5;
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_8.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_8.zpp_inner;
                _loc_8.zpp_inner.outer = null;
                _loc_8.zpp_inner = null;
                _loc_10 = _loc_8;
                _loc_10.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_10;
                }
                ZPP_PubPool.nextVec2 = _loc_10;
                _loc_10.zpp_disp = true;
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
                _loc_7 = param2 * zpp_inner.xdet + 0.5;
                zpp_inner_zn.__fcircle(_loc_4, _loc_6, _loc_7, param3 | -16777216);
            }
            return;
        }// end function

        override public function drawCurve(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = null as Vec2;
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: drawCurve::start cannot be null";
            }
            if (param2 == null)
            {
                throw "Error: drawCurve::control cannot be null";
            }
            if (param3 == null)
            {
                throw "Error: drawCurve::end cannot be null";
            }
            if (zpp_inner.xnull)
            {
                zpp_inner_zn.__curve(param1, param2, param3, param4);
                if (param1.zpp_inner.weak)
                {
                    if (param1 != null)
                    {
                    }
                    if (param1.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = param1.zpp_inner;
                    if (_loc_5._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_5._isimmutable != null)
                    {
                        _loc_5._isimmutable();
                    }
                    if (param1.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_5 = param1.zpp_inner;
                    param1.zpp_inner.outer = null;
                    param1.zpp_inner = null;
                    _loc_6 = param1;
                    _loc_6.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_6;
                    }
                    ZPP_PubPool.nextVec2 = _loc_6;
                    _loc_6.zpp_disp = true;
                    _loc_7 = _loc_5;
                    if (_loc_7.outer != null)
                    {
                        _loc_7.outer.zpp_inner = null;
                        _loc_7.outer = null;
                    }
                    _loc_7._isimmutable = null;
                    _loc_7._validate = null;
                    _loc_7._invalidate = null;
                    _loc_7.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_7;
                }
                else
                {
                }
                if (param2.zpp_inner.weak)
                {
                    if (param2 != null)
                    {
                    }
                    if (param2.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = param2.zpp_inner;
                    if (_loc_5._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_5._isimmutable != null)
                    {
                        _loc_5._isimmutable();
                    }
                    if (param2.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_5 = param2.zpp_inner;
                    param2.zpp_inner.outer = null;
                    param2.zpp_inner = null;
                    _loc_6 = param2;
                    _loc_6.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_6;
                    }
                    ZPP_PubPool.nextVec2 = _loc_6;
                    _loc_6.zpp_disp = true;
                    _loc_7 = _loc_5;
                    if (_loc_7.outer != null)
                    {
                        _loc_7.outer.zpp_inner = null;
                        _loc_7.outer = null;
                    }
                    _loc_7._isimmutable = null;
                    _loc_7._validate = null;
                    _loc_7._invalidate = null;
                    _loc_7.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_7;
                }
                else
                {
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
                    _loc_5 = param3.zpp_inner;
                    if (_loc_5._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_5._isimmutable != null)
                    {
                        _loc_5._isimmutable();
                    }
                    if (param3.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_5 = param3.zpp_inner;
                    param3.zpp_inner.outer = null;
                    param3.zpp_inner = null;
                    _loc_6 = param3;
                    _loc_6.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_6;
                    }
                    ZPP_PubPool.nextVec2 = _loc_6;
                    _loc_6.zpp_disp = true;
                    _loc_7 = _loc_5;
                    if (_loc_7.outer != null)
                    {
                        _loc_7.outer.zpp_inner = null;
                        _loc_7.outer = null;
                    }
                    _loc_7._isimmutable = null;
                    _loc_7._validate = null;
                    _loc_7._invalidate = null;
                    _loc_7.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_7;
                }
                else
                {
                }
            }
            else
            {
                _loc_6 = zpp_inner.xform.outer.transform(param1);
                _loc_8 = zpp_inner.xform.outer.transform(param2);
                _loc_9 = zpp_inner.xform.outer.transform(param3);
                zpp_inner_zn.__curve(_loc_6, _loc_8, _loc_9, param4);
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_6.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_6.zpp_inner;
                _loc_6.zpp_inner.outer = null;
                _loc_6.zpp_inner = null;
                _loc_10 = _loc_6;
                _loc_10.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_10;
                }
                ZPP_PubPool.nextVec2 = _loc_10;
                _loc_10.zpp_disp = true;
                _loc_7 = _loc_5;
                if (_loc_7.outer != null)
                {
                    _loc_7.outer.zpp_inner = null;
                    _loc_7.outer = null;
                }
                _loc_7._isimmutable = null;
                _loc_7._validate = null;
                _loc_7._invalidate = null;
                _loc_7.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7;
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_8.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_8.zpp_inner;
                _loc_8.zpp_inner.outer = null;
                _loc_8.zpp_inner = null;
                _loc_10 = _loc_8;
                _loc_10.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_10;
                }
                ZPP_PubPool.nextVec2 = _loc_10;
                _loc_10.zpp_disp = true;
                _loc_7 = _loc_5;
                if (_loc_7.outer != null)
                {
                    _loc_7.outer.zpp_inner = null;
                    _loc_7.outer = null;
                }
                _loc_7._isimmutable = null;
                _loc_7._validate = null;
                _loc_7._invalidate = null;
                _loc_7.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_9.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_9.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_9.zpp_inner;
                _loc_9.zpp_inner.outer = null;
                _loc_9.zpp_inner = null;
                _loc_10 = _loc_9;
                _loc_10.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_10;
                }
                ZPP_PubPool.nextVec2 = _loc_10;
                _loc_10.zpp_disp = true;
                _loc_7 = _loc_5;
                if (_loc_7.outer != null)
                {
                    _loc_7.outer.zpp_inner = null;
                    _loc_7.outer = null;
                }
                _loc_7._isimmutable = null;
                _loc_7._validate = null;
                _loc_7._invalidate = null;
                _loc_7.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7;
            }
            return;
        }// end function

        override public function drawCircle(param1:Vec2, param2:Number, param3:int) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = null as Vec2;
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: drawCircle::position cannot be null";
            }
            if (param2 == param2)
            {
            }
            if (param2 < 0)
            {
                throw "Error: drawCircle::radius must be >=0";
            }
            if (zpp_inner.xnull)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param1.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_4 = param1.zpp_inner.x + 0.5;
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param1.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_6 = param1.zpp_inner.y + 0.5;
                _loc_7 = param2 + 0.5;
                zpp_inner_zn.__circle(_loc_4, _loc_6, _loc_7, param3 | -16777216);
                if (param1.zpp_inner.weak)
                {
                    if (param1 != null)
                    {
                    }
                    if (param1.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = param1.zpp_inner;
                    if (_loc_5._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_5._isimmutable != null)
                    {
                        _loc_5._isimmutable();
                    }
                    if (param1.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_5 = param1.zpp_inner;
                    param1.zpp_inner.outer = null;
                    param1.zpp_inner = null;
                    _loc_8 = param1;
                    _loc_8.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_8;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_8;
                    }
                    ZPP_PubPool.nextVec2 = _loc_8;
                    _loc_8.zpp_disp = true;
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
                }
                else
                {
                }
            }
            else
            {
                _loc_8 = zpp_inner.xform.outer.transform(param1);
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_4 = _loc_8.zpp_inner.x + 0.5;
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_6 = _loc_8.zpp_inner.y + 0.5;
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_8.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_8.zpp_inner;
                _loc_8.zpp_inner.outer = null;
                _loc_8.zpp_inner = null;
                _loc_10 = _loc_8;
                _loc_10.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_10;
                }
                ZPP_PubPool.nextVec2 = _loc_10;
                _loc_10.zpp_disp = true;
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
                _loc_7 = param2 * zpp_inner.xdet + 0.5;
                zpp_inner_zn.__circle(_loc_4, _loc_6, _loc_7, param3 | -16777216);
            }
            return;
        }// end function

        override public function drawAABB(param1:AABB, param2:int) : void
        {
            var _loc_3:* = null as Vec2;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = NaN;
            var _loc_6:* = null as ZPP_AABB;
            var _loc_7:* = false;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = false;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = null as Vec2;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = null as Vec2;
            var _loc_22:* = null as ZPP_Vec2;
            var _loc_23:* = 0;
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (param1 == null)
            {
                throw "Error: drawAABB::aabb cannot be null";
            }
            if (zpp_inner.xnull)
            {
                zpp_inner_zn.__aabb(param1.zpp_inner, param2);
            }
            else
            {
                _loc_3 = zpp_inner.xform.outer.transform(param1.zpp_inner.getmin());
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_6 = param1.zpp_inner;
                _loc_5 = _loc_6.maxx - _loc_6.minx;
                _loc_7 = false;
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_8 = new Vec2();
                }
                else
                {
                    _loc_8 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_8.zpp_pool;
                    _loc_8.zpp_pool = null;
                    _loc_8.zpp_disp = false;
                    if (_loc_8 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_8.zpp_inner == null)
                {
                    _loc_9 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_10 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_10 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_10.next;
                        _loc_10.next = null;
                    }
                    _loc_10.weak = false;
                    _loc_10._immutable = _loc_9;
                    _loc_10.x = _loc_5;
                    _loc_10.y = 0;
                    _loc_8.zpp_inner = _loc_10;
                    _loc_8.zpp_inner.outer = _loc_8;
                }
                else
                {
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_8.zpp_inner;
                    if (_loc_10._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_10._isimmutable != null)
                    {
                        _loc_10._isimmutable();
                    }
                    if (_loc_5 != _loc_5)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_8.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    if (_loc_8.zpp_inner.x == _loc_5)
                    {
                        if (_loc_8 != null)
                        {
                        }
                        if (_loc_8.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_10 = _loc_8.zpp_inner;
                        if (_loc_10._validate != null)
                        {
                            _loc_10._validate();
                        }
                    }
                    if (_loc_8.zpp_inner.y != 0)
                    {
                        _loc_8.zpp_inner.x = _loc_5;
                        _loc_8.zpp_inner.y = 0;
                        _loc_10 = _loc_8.zpp_inner;
                        if (_loc_10._invalidate != null)
                        {
                            _loc_10._invalidate(_loc_10);
                        }
                    }
                }
                _loc_8.zpp_inner.weak = _loc_7;
                _loc_4 = _loc_8;
                _loc_8 = zpp_inner.xform.outer.transform(_loc_4, true);
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_6 = param1.zpp_inner;
                _loc_5 = _loc_6.maxy - _loc_6.miny;
                _loc_7 = false;
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_12 = new Vec2();
                }
                else
                {
                    _loc_12 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_12.zpp_pool;
                    _loc_12.zpp_pool = null;
                    _loc_12.zpp_disp = false;
                    if (_loc_12 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_12.zpp_inner == null)
                {
                    _loc_9 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_10 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_10 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_10.next;
                        _loc_10.next = null;
                    }
                    _loc_10.weak = false;
                    _loc_10._immutable = _loc_9;
                    _loc_10.x = 0;
                    _loc_10.y = _loc_5;
                    _loc_12.zpp_inner = _loc_10;
                    _loc_12.zpp_inner.outer = _loc_12;
                }
                else
                {
                    if (_loc_12 != null)
                    {
                    }
                    if (_loc_12.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_12.zpp_inner;
                    if (_loc_10._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_10._isimmutable != null)
                    {
                        _loc_10._isimmutable();
                    }
                    if (_loc_5 != _loc_5)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_12 != null)
                    {
                    }
                    if (_loc_12.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_12.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    if (_loc_12.zpp_inner.x == 0)
                    {
                        if (_loc_12 != null)
                        {
                        }
                        if (_loc_12.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_10 = _loc_12.zpp_inner;
                        if (_loc_10._validate != null)
                        {
                            _loc_10._validate();
                        }
                    }
                    if (_loc_12.zpp_inner.y != _loc_5)
                    {
                        _loc_12.zpp_inner.x = 0;
                        _loc_12.zpp_inner.y = _loc_5;
                        _loc_10 = _loc_12.zpp_inner;
                        if (_loc_10._invalidate != null)
                        {
                            _loc_10._invalidate(_loc_10);
                        }
                    }
                }
                _loc_12.zpp_inner.weak = _loc_7;
                _loc_11 = _loc_12;
                _loc_12 = zpp_inner.xform.outer.transform(_loc_11, true);
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_3.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_13 = _loc_3.zpp_inner.x + 0.5;
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_3.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_14 = _loc_3.zpp_inner.y + 0.5;
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_3.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_8.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_15 = _loc_3.zpp_inner.x + _loc_8.zpp_inner.x + 0.5;
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_3.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_8.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_16 = _loc_3.zpp_inner.y + _loc_8.zpp_inner.y + 0.5;
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_3.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_8.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                if (_loc_12 != null)
                {
                }
                if (_loc_12.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_12.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_17 = _loc_3.zpp_inner.x + _loc_8.zpp_inner.x + _loc_12.zpp_inner.x + 0.5;
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_3.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_8.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                if (_loc_12 != null)
                {
                }
                if (_loc_12.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_12.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_18 = _loc_3.zpp_inner.y + _loc_8.zpp_inner.y + _loc_12.zpp_inner.y + 0.5;
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_3.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                if (_loc_12 != null)
                {
                }
                if (_loc_12.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_12.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_19 = _loc_3.zpp_inner.x + _loc_12.zpp_inner.x + 0.5;
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_3.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                if (_loc_12 != null)
                {
                }
                if (_loc_12.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_12.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_20 = _loc_3.zpp_inner.y + _loc_12.zpp_inner.y + 0.5;
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_3.zpp_inner;
                if (_loc_10._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_10._isimmutable != null)
                {
                    _loc_10._isimmutable();
                }
                if (_loc_3.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_10 = _loc_3.zpp_inner;
                _loc_3.zpp_inner.outer = null;
                _loc_3.zpp_inner = null;
                _loc_21 = _loc_3;
                _loc_21.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_21;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_21;
                }
                ZPP_PubPool.nextVec2 = _loc_21;
                _loc_21.zpp_disp = true;
                _loc_22 = _loc_10;
                if (_loc_22.outer != null)
                {
                    _loc_22.outer.zpp_inner = null;
                    _loc_22.outer = null;
                }
                _loc_22._isimmutable = null;
                _loc_22._validate = null;
                _loc_22._invalidate = null;
                _loc_22.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_22;
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_4.zpp_inner;
                if (_loc_10._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_10._isimmutable != null)
                {
                    _loc_10._isimmutable();
                }
                if (_loc_4.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_10 = _loc_4.zpp_inner;
                _loc_4.zpp_inner.outer = null;
                _loc_4.zpp_inner = null;
                _loc_21 = _loc_4;
                _loc_21.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_21;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_21;
                }
                ZPP_PubPool.nextVec2 = _loc_21;
                _loc_21.zpp_disp = true;
                _loc_22 = _loc_10;
                if (_loc_22.outer != null)
                {
                    _loc_22.outer.zpp_inner = null;
                    _loc_22.outer = null;
                }
                _loc_22._isimmutable = null;
                _loc_22._validate = null;
                _loc_22._invalidate = null;
                _loc_22.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_22;
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_8.zpp_inner;
                if (_loc_10._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_10._isimmutable != null)
                {
                    _loc_10._isimmutable();
                }
                if (_loc_8.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_10 = _loc_8.zpp_inner;
                _loc_8.zpp_inner.outer = null;
                _loc_8.zpp_inner = null;
                _loc_21 = _loc_8;
                _loc_21.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_21;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_21;
                }
                ZPP_PubPool.nextVec2 = _loc_21;
                _loc_21.zpp_disp = true;
                _loc_22 = _loc_10;
                if (_loc_22.outer != null)
                {
                    _loc_22.outer.zpp_inner = null;
                    _loc_22.outer = null;
                }
                _loc_22._isimmutable = null;
                _loc_22._validate = null;
                _loc_22._invalidate = null;
                _loc_22.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_22;
                if (_loc_11 != null)
                {
                }
                if (_loc_11.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_11.zpp_inner;
                if (_loc_10._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_10._isimmutable != null)
                {
                    _loc_10._isimmutable();
                }
                if (_loc_11.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_10 = _loc_11.zpp_inner;
                _loc_11.zpp_inner.outer = null;
                _loc_11.zpp_inner = null;
                _loc_21 = _loc_11;
                _loc_21.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_21;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_21;
                }
                ZPP_PubPool.nextVec2 = _loc_21;
                _loc_21.zpp_disp = true;
                _loc_22 = _loc_10;
                if (_loc_22.outer != null)
                {
                    _loc_22.outer.zpp_inner = null;
                    _loc_22.outer = null;
                }
                _loc_22._isimmutable = null;
                _loc_22._validate = null;
                _loc_22._invalidate = null;
                _loc_22.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_22;
                if (_loc_12 != null)
                {
                }
                if (_loc_12.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_12.zpp_inner;
                if (_loc_10._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_10._isimmutable != null)
                {
                    _loc_10._isimmutable();
                }
                if (_loc_12.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_10 = _loc_12.zpp_inner;
                _loc_12.zpp_inner.outer = null;
                _loc_12.zpp_inner = null;
                _loc_21 = _loc_12;
                _loc_21.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_21;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_21;
                }
                ZPP_PubPool.nextVec2 = _loc_21;
                _loc_21.zpp_disp = true;
                _loc_22 = _loc_10;
                if (_loc_22.outer != null)
                {
                    _loc_22.outer.zpp_inner = null;
                    _loc_22.outer = null;
                }
                _loc_22._isimmutable = null;
                _loc_22._validate = null;
                _loc_22._invalidate = null;
                _loc_22.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_22;
                _loc_23 = param2 | -16777216;
                zpp_inner_zn.__line(_loc_13, _loc_14, _loc_15, _loc_16, _loc_23);
                zpp_inner_zn.__line(_loc_15, _loc_16, _loc_17, _loc_18, _loc_23);
                zpp_inner_zn.__line(_loc_17, _loc_18, _loc_19, _loc_20, _loc_23);
                zpp_inner_zn.__line(_loc_19, _loc_20, _loc_13, _loc_14, _loc_23);
            }
            return;
        }// end function

        override public function draw(param1) : void
        {
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (zpp_inner.xnull)
            {
                if (param1 is Space)
                {
                    zpp_inner_zn.draw_space(param1.zpp_inner, null, 1, true);
                }
                else if (param1 is Compound)
                {
                    zpp_inner_zn.draw_compound(param1.zpp_inner, null, 1, true);
                }
                else if (param1 is Body)
                {
                    zpp_inner_zn.draw_body(param1.zpp_inner, null, 1, true);
                }
                else if (param1 is Shape)
                {
                    zpp_inner_zn.draw_shape(param1.zpp_inner, null, 1, true);
                }
                else if (param1 is Constraint)
                {
                    param1.zpp_inner.draw(this);
                }
                else
                {
                    throw "Error: Unhandled object type for Debug draw";
                }
            }
            else if (param1 is Space)
            {
                zpp_inner_zn.draw_space(param1.zpp_inner, zpp_inner.xform, zpp_inner.xdet, false);
            }
            else if (param1 is Body)
            {
                zpp_inner_zn.draw_body(param1.zpp_inner, zpp_inner.xform, zpp_inner.xdet, false);
            }
            else if (param1 is Shape)
            {
                zpp_inner_zn.draw_shape(param1.zpp_inner, zpp_inner.xform, zpp_inner.xdet, false);
            }
            else if (param1 is Constraint)
            {
                param1.zpp_inner.draw(this);
            }
            else
            {
                throw "Error: Unhandled object type for Debug draw";
            }
            return;
        }// end function

        override public function clear() : void
        {
            zpp_inner_zn.clear();
            return;
        }// end function

    }
}
