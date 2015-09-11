package nape.util
{
    import __AS3__.vec.*;
    import flash.*;
    import flash.display.*;
    import nape.constraint.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import nape.space.*;
    import zpp_nape.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    final public class ShapeDebug extends Debug
    {
        public var zpp_inner_zn:ZPP_ShapeDebug;
        public var thickness:Number;

        public function ShapeDebug(param1:int = 0, param2:int = 0, param3:int = 3355443) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            thickness = 0;
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
            zpp_inner_zn = new ZPP_ShapeDebug(param1, param2);
            zpp_inner_zn.outer_zn = this;
            zpp_inner = zpp_inner_zn;
            zpp_inner.outer = this;
            if (zpp_inner.isbmp)
            {
                zpp_inner.d_bmp.setbg(param3);
            }
            else
            {
                zpp_inner.d_shape.setbg(param3);
            }
            thickness = 0.1;
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
            var _loc_6:* = null as Array;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = false;
            var _loc_11:* = NaN;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_13:* = NaN;
            var _loc_14:* = null as Vec2;
            var _loc_15:* = false;
            var _loc_16:* = null as Vector.<Vec2>;
            var _loc_17:* = null as Vec2;
            var _loc_18:* = null as Vec2List;
            var _loc_19:* = null as Vec2Iterator;
            var _loc_20:* = null as GeomPoly;
            var _loc_21:* = null as ZPP_GeomVert;
            var _loc_22:* = null as ZPP_GeomVert;
            var _loc_23:* = null as ZPP_Vec2;
            var _loc_24:* = null as Vec2;
            var _loc_25:* = null as ZNPList_ZPP_Vec2;
            var _loc_26:* = null as ZNPNode_ZPP_Vec2;
            var _loc_27:* = null as ZNPNode_ZPP_Vec2;
            var _loc_28:* = null as ZPP_Vec2;
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot draw null polygon";
            }
            var _loc_3:* = zpp_inner_zn.graphics;
            _loc_3.lineStyle(thickness, param2 & 16777215, 1);
            var _loc_4:* = null;
            var _loc_5:* = true;
            if (zpp_inner.xnull)
            {
                if (param1 is Array)
                {
                    _loc_6 = param1;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6.length)
                    {
                        
                        _loc_8 = _loc_6[_loc_7];
                        _loc_7++;
                        if (_loc_8 == null)
                        {
                            throw "Error: Array<Vec2> contains null objects";
                        }
                        if (!(_loc_8 is Vec2))
                        {
                            throw "Error: Array<Vec2> contains non Vec2 objects";
                        }
                        _loc_9 = _loc_8;
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_5)
                        {
                            _loc_10 = false;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_11 = _loc_9.zpp_inner.x;
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_13 = _loc_9.zpp_inner.y;
                            if (_loc_11 == _loc_11)
                            {
                            }
                            if (_loc_13 != _loc_13)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_14 = new Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                                _loc_14.zpp_pool = null;
                                _loc_14.zpp_disp = false;
                                if (_loc_14 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_14.zpp_inner == null)
                            {
                                _loc_15 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_12 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_12 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_12.next;
                                    _loc_12.next = null;
                                }
                                _loc_12.weak = false;
                                _loc_12._immutable = _loc_15;
                                _loc_12.x = _loc_11;
                                _loc_12.y = _loc_13;
                                _loc_14.zpp_inner = _loc_12;
                                _loc_14.zpp_inner.outer = _loc_14;
                            }
                            else
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14.zpp_inner.x == _loc_11)
                                {
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                }
                                if (_loc_14.zpp_inner.y != _loc_13)
                                {
                                    _loc_14.zpp_inner.x = _loc_11;
                                    _loc_14.zpp_inner.y = _loc_13;
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._invalidate != null)
                                    {
                                        _loc_12._invalidate(_loc_12);
                                    }
                                }
                            }
                            _loc_14.zpp_inner.weak = _loc_10;
                            _loc_4 = _loc_14;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                        }
                        else
                        {
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                        }
                        _loc_5 = false;
                    }
                }
                else if (param1 is ZPP_Const.vec2vector)
                {
                    _loc_16 = param1;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_16.length)
                    {
                        
                        _loc_9 = _loc_16[_loc_7];
                        _loc_7++;
                        if (_loc_9 == null)
                        {
                            throw "Error: flash.Vector<Vec2> contains null objects";
                        }
                        _loc_14 = _loc_9;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_5)
                        {
                            _loc_10 = false;
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_11 = _loc_14.zpp_inner.x;
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_13 = _loc_14.zpp_inner.y;
                            if (_loc_11 == _loc_11)
                            {
                            }
                            if (_loc_13 != _loc_13)
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
                                _loc_15 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_12 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_12 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_12.next;
                                    _loc_12.next = null;
                                }
                                _loc_12.weak = false;
                                _loc_12._immutable = _loc_15;
                                _loc_12.x = _loc_11;
                                _loc_12.y = _loc_13;
                                _loc_17.zpp_inner = _loc_12;
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
                                _loc_12 = _loc_17.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
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
                                _loc_12 = _loc_17.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
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
                                    _loc_12 = _loc_17.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                }
                                if (_loc_17.zpp_inner.y != _loc_13)
                                {
                                    _loc_17.zpp_inner.x = _loc_11;
                                    _loc_17.zpp_inner.y = _loc_13;
                                    _loc_12 = _loc_17.zpp_inner;
                                    if (_loc_12._invalidate != null)
                                    {
                                        _loc_12._invalidate(_loc_12);
                                    }
                                }
                            }
                            _loc_17.zpp_inner.weak = _loc_10;
                            _loc_4 = _loc_17;
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        else
                        {
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        _loc_5 = false;
                    }
                }
                else if (param1 is Vec2List)
                {
                    _loc_18 = param1;
                    _loc_19 = _loc_18.iterator();
                    do
                    {
                        
                        _loc_19.zpp_critical = false;
                        _loc_7 = _loc_19.zpp_i;
                        (_loc_19.zpp_i + 1);
                        _loc_9 = _loc_19.zpp_inner.at(_loc_7);
                        if (_loc_9 == null)
                        {
                            throw "Error: Vec2List contains null objects";
                        }
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_5)
                        {
                            _loc_10 = false;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_11 = _loc_9.zpp_inner.x;
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_13 = _loc_9.zpp_inner.y;
                            if (_loc_11 == _loc_11)
                            {
                            }
                            if (_loc_13 != _loc_13)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_14 = new Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                                _loc_14.zpp_pool = null;
                                _loc_14.zpp_disp = false;
                                if (_loc_14 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_14.zpp_inner == null)
                            {
                                _loc_15 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_12 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_12 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_12.next;
                                    _loc_12.next = null;
                                }
                                _loc_12.weak = false;
                                _loc_12._immutable = _loc_15;
                                _loc_12.x = _loc_11;
                                _loc_12.y = _loc_13;
                                _loc_14.zpp_inner = _loc_12;
                                _loc_14.zpp_inner.outer = _loc_14;
                            }
                            else
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14.zpp_inner.x == _loc_11)
                                {
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                }
                                if (_loc_14.zpp_inner.y != _loc_13)
                                {
                                    _loc_14.zpp_inner.x = _loc_11;
                                    _loc_14.zpp_inner.y = _loc_13;
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._invalidate != null)
                                    {
                                        _loc_12._invalidate(_loc_12);
                                    }
                                }
                            }
                            _loc_14.zpp_inner.weak = _loc_10;
                            _loc_4 = _loc_14;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                        }
                        else
                        {
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                        }
                        _loc_5 = false;
                        _loc_19.zpp_inner.zpp_inner.valmod();
                        _loc_7 = _loc_19.zpp_inner.zpp_gl();
                        _loc_19.zpp_critical = true;
                    }while (_loc_19.zpp_i < _loc_7 ? (true) : (_loc_19.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_19, _loc_19.zpp_inner = null, false))
                }
                else if (param1 is GeomPoly)
                {
                    _loc_20 = param1;
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
                    }
                    _loc_21 = _loc_20.zpp_inner.vertices;
                    if (_loc_21 != null)
                    {
                        _loc_22 = _loc_21;
                        do
                        {
                            
                            _loc_11 = _loc_22.x;
                            _loc_13 = _loc_22.y;
                            _loc_10 = false;
                            if (_loc_11 == _loc_11)
                            {
                            }
                            if (_loc_13 != _loc_13)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_14 = new Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                                _loc_14.zpp_pool = null;
                                _loc_14.zpp_disp = false;
                                if (_loc_14 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_14.zpp_inner == null)
                            {
                                _loc_15 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_12 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_12 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_12.next;
                                    _loc_12.next = null;
                                }
                                _loc_12.weak = false;
                                _loc_12._immutable = _loc_15;
                                _loc_12.x = _loc_11;
                                _loc_12.y = _loc_13;
                                _loc_14.zpp_inner = _loc_12;
                                _loc_14.zpp_inner.outer = _loc_14;
                            }
                            else
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14.zpp_inner.x == _loc_11)
                                {
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                }
                                if (_loc_14.zpp_inner.y != _loc_13)
                                {
                                    _loc_14.zpp_inner.x = _loc_11;
                                    _loc_14.zpp_inner.y = _loc_13;
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._invalidate != null)
                                    {
                                        _loc_12._invalidate(_loc_12);
                                    }
                                }
                            }
                            _loc_14.zpp_inner.weak = _loc_10;
                            _loc_9 = _loc_14;
                            _loc_22 = _loc_22.next;
                            if (_loc_5)
                            {
                                _loc_10 = false;
                                if (_loc_9 != null)
                                {
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_11 = _loc_9.zpp_inner.x;
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_13 = _loc_9.zpp_inner.y;
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (ZPP_PubPool.poolVec2 == null)
                                {
                                    _loc_14 = new Vec2();
                                }
                                else
                                {
                                    _loc_14 = ZPP_PubPool.poolVec2;
                                    ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                                    _loc_14.zpp_pool = null;
                                    _loc_14.zpp_disp = false;
                                    if (_loc_14 == ZPP_PubPool.nextVec2)
                                    {
                                        ZPP_PubPool.nextVec2 = null;
                                    }
                                }
                                if (_loc_14.zpp_inner == null)
                                {
                                    _loc_15 = false;
                                    if (ZPP_Vec2.zpp_pool == null)
                                    {
                                        _loc_12 = new ZPP_Vec2();
                                    }
                                    else
                                    {
                                        _loc_12 = ZPP_Vec2.zpp_pool;
                                        ZPP_Vec2.zpp_pool = _loc_12.next;
                                        _loc_12.next = null;
                                    }
                                    _loc_12.weak = false;
                                    _loc_12._immutable = _loc_15;
                                    _loc_12.x = _loc_11;
                                    _loc_12.y = _loc_13;
                                    _loc_14.zpp_inner = _loc_12;
                                    _loc_14.zpp_inner.outer = _loc_14;
                                }
                                else
                                {
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._immutable)
                                    {
                                        throw "Error: Vec2 is immutable";
                                    }
                                    if (_loc_12._isimmutable != null)
                                    {
                                        _loc_12._isimmutable();
                                    }
                                    if (_loc_11 == _loc_11)
                                    {
                                    }
                                    if (_loc_13 != _loc_13)
                                    {
                                        throw "Error: Vec2 components cannot be NaN";
                                    }
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                    if (_loc_14.zpp_inner.x == _loc_11)
                                    {
                                        if (_loc_14 != null)
                                        {
                                        }
                                        if (_loc_14.zpp_disp)
                                        {
                                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                        }
                                        _loc_12 = _loc_14.zpp_inner;
                                        if (_loc_12._validate != null)
                                        {
                                            _loc_12._validate();
                                        }
                                    }
                                    if (_loc_14.zpp_inner.y != _loc_13)
                                    {
                                        _loc_14.zpp_inner.x = _loc_11;
                                        _loc_14.zpp_inner.y = _loc_13;
                                        _loc_12 = _loc_14.zpp_inner;
                                        if (_loc_12._invalidate != null)
                                        {
                                            _loc_12._invalidate(_loc_12);
                                        }
                                    }
                                }
                                _loc_14.zpp_inner.weak = _loc_10;
                                _loc_4 = _loc_14;
                                if (_loc_9 != null)
                                {
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_9 != null)
                                {
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_3.moveTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                            }
                            else
                            {
                                if (_loc_9 != null)
                                {
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_9 != null)
                                {
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_3.lineTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                            }
                            _loc_5 = false;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_9.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            _loc_9.zpp_inner.outer = null;
                            _loc_9.zpp_inner = null;
                            _loc_14 = _loc_9;
                            _loc_14.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_14;
                            }
                            ZPP_PubPool.nextVec2 = _loc_14;
                            _loc_14.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                        }while (_loc_22 != _loc_21)
                    }
                }
                else
                {
                    throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._validate != null)
                {
                    _loc_12._validate();
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._validate != null)
                {
                    _loc_12._validate();
                }
                _loc_3.lineTo(_loc_4.zpp_inner.x, _loc_4.zpp_inner.y);
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_12._isimmutable != null)
                {
                    _loc_12._isimmutable();
                }
                if (_loc_4.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_12 = _loc_4.zpp_inner;
                _loc_4.zpp_inner.outer = null;
                _loc_4.zpp_inner = null;
                _loc_9 = _loc_4;
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
                _loc_23 = _loc_12;
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
                if (param1 is Array)
                {
                    _loc_6 = param1;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6.length)
                    {
                        
                        _loc_8 = _loc_6[_loc_7];
                        _loc_7++;
                        if (_loc_8 == null)
                        {
                            throw "Error: Array<Vec2> contains null objects";
                        }
                        if (!(_loc_8 is Vec2))
                        {
                            throw "Error: Array<Vec2> contains non Vec2 objects";
                        }
                        _loc_9 = _loc_8;
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = zpp_inner.xform.outer.transform(_loc_9);
                        if (_loc_5)
                        {
                            _loc_4 = _loc_14;
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        else
                        {
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        if (!_loc_5)
                        {
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_14.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            _loc_14.zpp_inner.outer = null;
                            _loc_14.zpp_inner = null;
                            _loc_17 = _loc_14;
                            _loc_17.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_17;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_17;
                            }
                            ZPP_PubPool.nextVec2 = _loc_17;
                            _loc_17.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                        _loc_5 = false;
                    }
                }
                else if (param1 is ZPP_Const.vec2vector)
                {
                    _loc_16 = param1;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_16.length)
                    {
                        
                        _loc_9 = _loc_16[_loc_7];
                        _loc_7++;
                        if (_loc_9 == null)
                        {
                            throw "Error: flash.Vector<Vec2> contains null objects";
                        }
                        _loc_14 = _loc_9;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_17 = zpp_inner.xform.outer.transform(_loc_14);
                        if (_loc_5)
                        {
                            _loc_4 = _loc_17;
                            if (_loc_17 != null)
                            {
                            }
                            if (_loc_17.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_17.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_17 != null)
                            {
                            }
                            if (_loc_17.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_17.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_17.zpp_inner.x, _loc_17.zpp_inner.y);
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
                            _loc_12 = _loc_17.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_17 != null)
                            {
                            }
                            if (_loc_17.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_17.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_17.zpp_inner.x, _loc_17.zpp_inner.y);
                        }
                        if (!_loc_5)
                        {
                            if (_loc_17 != null)
                            {
                            }
                            if (_loc_17.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_17.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_17.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_17.zpp_inner;
                            _loc_17.zpp_inner.outer = null;
                            _loc_17.zpp_inner = null;
                            _loc_24 = _loc_17;
                            _loc_24.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_24;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_24;
                            }
                            ZPP_PubPool.nextVec2 = _loc_24;
                            _loc_24.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                        _loc_5 = false;
                    }
                }
                else if (param1 is Vec2List)
                {
                    _loc_18 = param1;
                    _loc_19 = _loc_18.iterator();
                    do
                    {
                        
                        _loc_19.zpp_critical = false;
                        _loc_7 = _loc_19.zpp_i;
                        (_loc_19.zpp_i + 1);
                        _loc_9 = _loc_19.zpp_inner.at(_loc_7);
                        if (_loc_9 == null)
                        {
                            throw "Error: Vec2List contains null objects";
                        }
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = zpp_inner.xform.outer.transform(_loc_9);
                        if (_loc_5)
                        {
                            _loc_4 = _loc_14;
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        else
                        {
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        if (!_loc_5)
                        {
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_14.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            _loc_14.zpp_inner.outer = null;
                            _loc_14.zpp_inner = null;
                            _loc_17 = _loc_14;
                            _loc_17.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_17;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_17;
                            }
                            ZPP_PubPool.nextVec2 = _loc_17;
                            _loc_17.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                        _loc_5 = false;
                        _loc_19.zpp_inner.zpp_inner.valmod();
                        _loc_7 = _loc_19.zpp_inner.zpp_gl();
                        _loc_19.zpp_critical = true;
                    }while (_loc_19.zpp_i < _loc_7 ? (true) : (_loc_19.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_19, _loc_19.zpp_inner = null, false))
                }
                else if (param1 is GeomPoly)
                {
                    _loc_20 = param1;
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
                    }
                    _loc_21 = _loc_20.zpp_inner.vertices;
                    if (_loc_21 != null)
                    {
                        _loc_22 = _loc_21;
                        do
                        {
                            
                            _loc_11 = _loc_22.x;
                            _loc_13 = _loc_22.y;
                            _loc_10 = false;
                            if (_loc_11 == _loc_11)
                            {
                            }
                            if (_loc_13 != _loc_13)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_14 = new Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                                _loc_14.zpp_pool = null;
                                _loc_14.zpp_disp = false;
                                if (_loc_14 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_14.zpp_inner == null)
                            {
                                _loc_15 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_12 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_12 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_12.next;
                                    _loc_12.next = null;
                                }
                                _loc_12.weak = false;
                                _loc_12._immutable = _loc_15;
                                _loc_12.x = _loc_11;
                                _loc_12.y = _loc_13;
                                _loc_14.zpp_inner = _loc_12;
                                _loc_14.zpp_inner.outer = _loc_14;
                            }
                            else
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14.zpp_inner.x == _loc_11)
                                {
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                }
                                if (_loc_14.zpp_inner.y != _loc_13)
                                {
                                    _loc_14.zpp_inner.x = _loc_11;
                                    _loc_14.zpp_inner.y = _loc_13;
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._invalidate != null)
                                    {
                                        _loc_12._invalidate(_loc_12);
                                    }
                                }
                            }
                            _loc_14.zpp_inner.weak = _loc_10;
                            _loc_9 = _loc_14;
                            _loc_22 = _loc_22.next;
                            _loc_14 = zpp_inner.xform.outer.transform(_loc_9);
                            if (_loc_5)
                            {
                                _loc_4 = _loc_14;
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_3.moveTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                            }
                            else
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_3.lineTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                            }
                            if (!_loc_5)
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_14.zpp_inner._inuse)
                                {
                                    throw "Error: This Vec2 is not disposable";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                _loc_14.zpp_inner.outer = null;
                                _loc_14.zpp_inner = null;
                                _loc_17 = _loc_14;
                                _loc_17.zpp_pool = null;
                                if (ZPP_PubPool.nextVec2 != null)
                                {
                                    ZPP_PubPool.nextVec2.zpp_pool = _loc_17;
                                }
                                else
                                {
                                    ZPP_PubPool.poolVec2 = _loc_17;
                                }
                                ZPP_PubPool.nextVec2 = _loc_17;
                                _loc_17.zpp_disp = true;
                                _loc_23 = _loc_12;
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
                            _loc_5 = false;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_9.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            _loc_9.zpp_inner.outer = null;
                            _loc_9.zpp_inner = null;
                            _loc_14 = _loc_9;
                            _loc_14.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_14;
                            }
                            ZPP_PubPool.nextVec2 = _loc_14;
                            _loc_14.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                        }while (_loc_22 != _loc_21)
                    }
                }
                else
                {
                    throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._validate != null)
                {
                    _loc_12._validate();
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._validate != null)
                {
                    _loc_12._validate();
                }
                _loc_3.lineTo(_loc_4.zpp_inner.x, _loc_4.zpp_inner.y);
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_12._isimmutable != null)
                {
                    _loc_12._isimmutable();
                }
                if (_loc_4.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_12 = _loc_4.zpp_inner;
                _loc_4.zpp_inner.outer = null;
                _loc_4.zpp_inner = null;
                _loc_9 = _loc_4;
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
                _loc_23 = _loc_12;
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
            if (param1 is Array)
            {
                _loc_6 = param1;
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    _loc_9 = _loc_6[_loc_7];
                    if (_loc_9.zpp_inner.weak)
                    {
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_12 = _loc_9.zpp_inner;
                        if (_loc_12._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_12._isimmutable != null)
                        {
                            _loc_12._isimmutable();
                        }
                        if (_loc_9.zpp_inner._inuse)
                        {
                            throw "Error: This Vec2 is not disposable";
                        }
                        _loc_12 = _loc_9.zpp_inner;
                        _loc_9.zpp_inner.outer = null;
                        _loc_9.zpp_inner = null;
                        _loc_14 = _loc_9;
                        _loc_14.zpp_pool = null;
                        if (ZPP_PubPool.nextVec2 != null)
                        {
                            ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                        }
                        else
                        {
                            ZPP_PubPool.poolVec2 = _loc_14;
                        }
                        ZPP_PubPool.nextVec2 = _loc_14;
                        _loc_14.zpp_disp = true;
                        _loc_23 = _loc_12;
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
                        _loc_6.splice(_loc_7, 1);
                        continue;
                    }
                    _loc_7++;
                }
            }
            else if (param1 is ZPP_Const.vec2vector)
            {
                _loc_16 = param1;
                if (!_loc_16.fixed)
                {
                    _loc_7 = 0;
                    while (_loc_7 < _loc_16.length)
                    {
                        
                        _loc_9 = _loc_16[_loc_7];
                        if (_loc_9.zpp_inner.weak)
                        {
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_9.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            _loc_9.zpp_inner.outer = null;
                            _loc_9.zpp_inner = null;
                            _loc_14 = _loc_9;
                            _loc_14.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_14;
                            }
                            ZPP_PubPool.nextVec2 = _loc_14;
                            _loc_14.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                            _loc_16.splice(_loc_7, 1);
                            continue;
                        }
                        _loc_7++;
                    }
                }
            }
            else if (param1 is Vec2List)
            {
                _loc_18 = param1;
                if (_loc_18.zpp_inner._validate != null)
                {
                    _loc_18.zpp_inner._validate();
                }
                _loc_25 = _loc_18.zpp_inner.inner;
                _loc_26 = null;
                _loc_27 = _loc_25.head;
                while (_loc_27 != null)
                {
                    
                    _loc_12 = _loc_27.elt;
                    if (_loc_12.outer.zpp_inner.weak)
                    {
                        _loc_27 = _loc_25.erase(_loc_26);
                        if (_loc_12.outer.zpp_inner.weak)
                        {
                            _loc_9 = _loc_12.outer;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_23 = _loc_9.zpp_inner;
                            if (_loc_23._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_23._isimmutable != null)
                            {
                                _loc_23._isimmutable();
                            }
                            if (_loc_9.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_23 = _loc_9.zpp_inner;
                            _loc_9.zpp_inner.outer = null;
                            _loc_9.zpp_inner = null;
                            _loc_14 = _loc_9;
                            _loc_14.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_14;
                            }
                            ZPP_PubPool.nextVec2 = _loc_14;
                            _loc_14.zpp_disp = true;
                            _loc_28 = _loc_23;
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
                        else
                        {
                        }
                        continue;
                    }
                    _loc_26 = _loc_27;
                    _loc_27 = _loc_27.next;
                }
            }
            return;
        }// end function

        override public function drawLine(param1:Vec2, param2:Vec2, param3:int) : void
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
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
            var _loc_4:* = zpp_inner_zn.graphics;
            _loc_4.lineStyle(thickness, param3 & 16777215, 1);
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
                _loc_4.moveTo(param1.zpp_inner.x, param1.zpp_inner.y);
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
                _loc_4.lineTo(param2.zpp_inner.x, param2.zpp_inner.y);
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
            }
            else
            {
                _loc_6 = zpp_inner.xform.outer.transform(param1);
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_4.moveTo(_loc_6.zpp_inner.x, _loc_6.zpp_inner.y);
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
                _loc_8 = _loc_6;
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
                _loc_6 = zpp_inner.xform.outer.transform(param2);
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_4.lineTo(_loc_6.zpp_inner.x, _loc_6.zpp_inner.y);
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
                _loc_8 = _loc_6;
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

        override public function drawFilledTriangle(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
        {
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as Vec2;
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
            var _loc_5:* = zpp_inner_zn.graphics;
            _loc_5.lineStyle(0, 0, 0);
            _loc_5.beginFill(param4 & 16777215, 1);
            if (zpp_inner.xnull)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_5.moveTo(param1.zpp_inner.x, param1.zpp_inner.y);
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param2.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param2.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_5.lineTo(param2.zpp_inner.x, param2.zpp_inner.y);
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param3.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param3.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_5.lineTo(param3.zpp_inner.x, param3.zpp_inner.y);
                if (param1.zpp_inner.weak)
                {
                    if (param1 != null)
                    {
                    }
                    if (param1.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = param1.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (param1.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_6 = param1.zpp_inner;
                    param1.zpp_inner.outer = null;
                    param1.zpp_inner = null;
                    _loc_7 = param1;
                    _loc_7.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_7;
                    }
                    ZPP_PubPool.nextVec2 = _loc_7;
                    _loc_7.zpp_disp = true;
                    _loc_8 = _loc_6;
                    if (_loc_8.outer != null)
                    {
                        _loc_8.outer.zpp_inner = null;
                        _loc_8.outer = null;
                    }
                    _loc_8._isimmutable = null;
                    _loc_8._validate = null;
                    _loc_8._invalidate = null;
                    _loc_8.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_8;
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
                    _loc_6 = param2.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (param2.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_6 = param2.zpp_inner;
                    param2.zpp_inner.outer = null;
                    param2.zpp_inner = null;
                    _loc_7 = param2;
                    _loc_7.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_7;
                    }
                    ZPP_PubPool.nextVec2 = _loc_7;
                    _loc_7.zpp_disp = true;
                    _loc_8 = _loc_6;
                    if (_loc_8.outer != null)
                    {
                        _loc_8.outer.zpp_inner = null;
                        _loc_8.outer = null;
                    }
                    _loc_8._isimmutable = null;
                    _loc_8._validate = null;
                    _loc_8._invalidate = null;
                    _loc_8.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_8;
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
                    _loc_6 = param3.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (param3.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_6 = param3.zpp_inner;
                    param3.zpp_inner.outer = null;
                    param3.zpp_inner = null;
                    _loc_7 = param3;
                    _loc_7.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_7;
                    }
                    ZPP_PubPool.nextVec2 = _loc_7;
                    _loc_7.zpp_disp = true;
                    _loc_8 = _loc_6;
                    if (_loc_8.outer != null)
                    {
                        _loc_8.outer.zpp_inner = null;
                        _loc_8.outer = null;
                    }
                    _loc_8._isimmutable = null;
                    _loc_8._validate = null;
                    _loc_8._invalidate = null;
                    _loc_8.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_8;
                }
                else
                {
                }
            }
            else
            {
                _loc_7 = zpp_inner.xform.outer.transform(param1);
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_5.moveTo(_loc_7.zpp_inner.x, _loc_7.zpp_inner.y);
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_7.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = _loc_7.zpp_inner;
                _loc_7.zpp_inner.outer = null;
                _loc_7.zpp_inner = null;
                _loc_9 = _loc_7;
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
                _loc_8 = _loc_6;
                if (_loc_8.outer != null)
                {
                    _loc_8.outer.zpp_inner = null;
                    _loc_8.outer = null;
                }
                _loc_8._isimmutable = null;
                _loc_8._validate = null;
                _loc_8._invalidate = null;
                _loc_8.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_8;
                _loc_7 = zpp_inner.xform.outer.transform(param2);
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_5.lineTo(_loc_7.zpp_inner.x, _loc_7.zpp_inner.y);
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_7.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = _loc_7.zpp_inner;
                _loc_7.zpp_inner.outer = null;
                _loc_7.zpp_inner = null;
                _loc_9 = _loc_7;
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
                _loc_8 = _loc_6;
                if (_loc_8.outer != null)
                {
                    _loc_8.outer.zpp_inner = null;
                    _loc_8.outer = null;
                }
                _loc_8._isimmutable = null;
                _loc_8._validate = null;
                _loc_8._invalidate = null;
                _loc_8.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_8;
                _loc_7 = zpp_inner.xform.outer.transform(param3);
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_5.lineTo(_loc_7.zpp_inner.x, _loc_7.zpp_inner.y);
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_7.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = _loc_7.zpp_inner;
                _loc_7.zpp_inner.outer = null;
                _loc_7.zpp_inner = null;
                _loc_9 = _loc_7;
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
                _loc_8 = _loc_6;
                if (_loc_8.outer != null)
                {
                    _loc_8.outer.zpp_inner = null;
                    _loc_8.outer = null;
                }
                _loc_8._isimmutable = null;
                _loc_8._validate = null;
                _loc_8._invalidate = null;
                _loc_8.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_8;
            }
            _loc_5.endFill();
            return;
        }// end function

        override public function drawFilledPolygon(param1, param2:int) : void
        {
            var _loc_6:* = null as Array;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = false;
            var _loc_11:* = NaN;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_13:* = NaN;
            var _loc_14:* = null as Vec2;
            var _loc_15:* = false;
            var _loc_16:* = null as Vector.<Vec2>;
            var _loc_17:* = null as Vec2;
            var _loc_18:* = null as Vec2List;
            var _loc_19:* = null as Vec2Iterator;
            var _loc_20:* = null as GeomPoly;
            var _loc_21:* = null as ZPP_GeomVert;
            var _loc_22:* = null as ZPP_GeomVert;
            var _loc_23:* = null as ZPP_Vec2;
            var _loc_24:* = null as Vec2;
            var _loc_25:* = null as ZNPList_ZPP_Vec2;
            var _loc_26:* = null as ZNPNode_ZPP_Vec2;
            var _loc_27:* = null as ZNPNode_ZPP_Vec2;
            var _loc_28:* = null as ZPP_Vec2;
            if (zpp_inner.xform != null)
            {
            }
            if (!zpp_inner.xform.outer.equiorthogonal())
            {
                throw "Error: Debug draw can only operate with an equiorthogonal transform!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot draw null polygon!";
            }
            var _loc_3:* = zpp_inner_zn.graphics;
            _loc_3.beginFill(param2 & 16777215, 1);
            _loc_3.lineStyle(0, 0, 0);
            var _loc_4:* = null;
            var _loc_5:* = true;
            if (zpp_inner.xnull)
            {
                if (param1 is Array)
                {
                    _loc_6 = param1;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6.length)
                    {
                        
                        _loc_8 = _loc_6[_loc_7];
                        _loc_7++;
                        if (_loc_8 == null)
                        {
                            throw "Error: Array<Vec2> contains null objects";
                        }
                        if (!(_loc_8 is Vec2))
                        {
                            throw "Error: Array<Vec2> contains non Vec2 objects";
                        }
                        _loc_9 = _loc_8;
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_5)
                        {
                            _loc_10 = false;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_11 = _loc_9.zpp_inner.x;
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_13 = _loc_9.zpp_inner.y;
                            if (_loc_11 == _loc_11)
                            {
                            }
                            if (_loc_13 != _loc_13)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_14 = new Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                                _loc_14.zpp_pool = null;
                                _loc_14.zpp_disp = false;
                                if (_loc_14 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_14.zpp_inner == null)
                            {
                                _loc_15 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_12 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_12 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_12.next;
                                    _loc_12.next = null;
                                }
                                _loc_12.weak = false;
                                _loc_12._immutable = _loc_15;
                                _loc_12.x = _loc_11;
                                _loc_12.y = _loc_13;
                                _loc_14.zpp_inner = _loc_12;
                                _loc_14.zpp_inner.outer = _loc_14;
                            }
                            else
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14.zpp_inner.x == _loc_11)
                                {
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                }
                                if (_loc_14.zpp_inner.y != _loc_13)
                                {
                                    _loc_14.zpp_inner.x = _loc_11;
                                    _loc_14.zpp_inner.y = _loc_13;
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._invalidate != null)
                                    {
                                        _loc_12._invalidate(_loc_12);
                                    }
                                }
                            }
                            _loc_14.zpp_inner.weak = _loc_10;
                            _loc_4 = _loc_14;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                        }
                        else
                        {
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                        }
                        _loc_5 = false;
                    }
                }
                else if (param1 is ZPP_Const.vec2vector)
                {
                    _loc_16 = param1;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_16.length)
                    {
                        
                        _loc_9 = _loc_16[_loc_7];
                        _loc_7++;
                        if (_loc_9 == null)
                        {
                            throw "Error: flash.Vector<Vec2> contains null objects";
                        }
                        _loc_14 = _loc_9;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_5)
                        {
                            _loc_10 = false;
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_11 = _loc_14.zpp_inner.x;
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_13 = _loc_14.zpp_inner.y;
                            if (_loc_11 == _loc_11)
                            {
                            }
                            if (_loc_13 != _loc_13)
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
                                _loc_15 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_12 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_12 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_12.next;
                                    _loc_12.next = null;
                                }
                                _loc_12.weak = false;
                                _loc_12._immutable = _loc_15;
                                _loc_12.x = _loc_11;
                                _loc_12.y = _loc_13;
                                _loc_17.zpp_inner = _loc_12;
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
                                _loc_12 = _loc_17.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
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
                                _loc_12 = _loc_17.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
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
                                    _loc_12 = _loc_17.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                }
                                if (_loc_17.zpp_inner.y != _loc_13)
                                {
                                    _loc_17.zpp_inner.x = _loc_11;
                                    _loc_17.zpp_inner.y = _loc_13;
                                    _loc_12 = _loc_17.zpp_inner;
                                    if (_loc_12._invalidate != null)
                                    {
                                        _loc_12._invalidate(_loc_12);
                                    }
                                }
                            }
                            _loc_17.zpp_inner.weak = _loc_10;
                            _loc_4 = _loc_17;
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        else
                        {
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        _loc_5 = false;
                    }
                }
                else if (param1 is Vec2List)
                {
                    _loc_18 = param1;
                    _loc_19 = _loc_18.iterator();
                    do
                    {
                        
                        _loc_19.zpp_critical = false;
                        _loc_7 = _loc_19.zpp_i;
                        (_loc_19.zpp_i + 1);
                        _loc_9 = _loc_19.zpp_inner.at(_loc_7);
                        if (_loc_9 == null)
                        {
                            throw "Error: Vec2List contains null objects";
                        }
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_5)
                        {
                            _loc_10 = false;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_11 = _loc_9.zpp_inner.x;
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_13 = _loc_9.zpp_inner.y;
                            if (_loc_11 == _loc_11)
                            {
                            }
                            if (_loc_13 != _loc_13)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_14 = new Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                                _loc_14.zpp_pool = null;
                                _loc_14.zpp_disp = false;
                                if (_loc_14 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_14.zpp_inner == null)
                            {
                                _loc_15 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_12 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_12 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_12.next;
                                    _loc_12.next = null;
                                }
                                _loc_12.weak = false;
                                _loc_12._immutable = _loc_15;
                                _loc_12.x = _loc_11;
                                _loc_12.y = _loc_13;
                                _loc_14.zpp_inner = _loc_12;
                                _loc_14.zpp_inner.outer = _loc_14;
                            }
                            else
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14.zpp_inner.x == _loc_11)
                                {
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                }
                                if (_loc_14.zpp_inner.y != _loc_13)
                                {
                                    _loc_14.zpp_inner.x = _loc_11;
                                    _loc_14.zpp_inner.y = _loc_13;
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._invalidate != null)
                                    {
                                        _loc_12._invalidate(_loc_12);
                                    }
                                }
                            }
                            _loc_14.zpp_inner.weak = _loc_10;
                            _loc_4 = _loc_14;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                        }
                        else
                        {
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                        }
                        _loc_5 = false;
                        _loc_19.zpp_inner.zpp_inner.valmod();
                        _loc_7 = _loc_19.zpp_inner.zpp_gl();
                        _loc_19.zpp_critical = true;
                    }while (_loc_19.zpp_i < _loc_7 ? (true) : (_loc_19.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_19, _loc_19.zpp_inner = null, false))
                }
                else if (param1 is GeomPoly)
                {
                    _loc_20 = param1;
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
                    }
                    _loc_21 = _loc_20.zpp_inner.vertices;
                    if (_loc_21 != null)
                    {
                        _loc_22 = _loc_21;
                        do
                        {
                            
                            _loc_11 = _loc_22.x;
                            _loc_13 = _loc_22.y;
                            _loc_10 = false;
                            if (_loc_11 == _loc_11)
                            {
                            }
                            if (_loc_13 != _loc_13)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_14 = new Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                                _loc_14.zpp_pool = null;
                                _loc_14.zpp_disp = false;
                                if (_loc_14 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_14.zpp_inner == null)
                            {
                                _loc_15 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_12 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_12 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_12.next;
                                    _loc_12.next = null;
                                }
                                _loc_12.weak = false;
                                _loc_12._immutable = _loc_15;
                                _loc_12.x = _loc_11;
                                _loc_12.y = _loc_13;
                                _loc_14.zpp_inner = _loc_12;
                                _loc_14.zpp_inner.outer = _loc_14;
                            }
                            else
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14.zpp_inner.x == _loc_11)
                                {
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                }
                                if (_loc_14.zpp_inner.y != _loc_13)
                                {
                                    _loc_14.zpp_inner.x = _loc_11;
                                    _loc_14.zpp_inner.y = _loc_13;
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._invalidate != null)
                                    {
                                        _loc_12._invalidate(_loc_12);
                                    }
                                }
                            }
                            _loc_14.zpp_inner.weak = _loc_10;
                            _loc_9 = _loc_14;
                            _loc_22 = _loc_22.next;
                            if (_loc_5)
                            {
                                _loc_10 = false;
                                if (_loc_9 != null)
                                {
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_11 = _loc_9.zpp_inner.x;
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_13 = _loc_9.zpp_inner.y;
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (ZPP_PubPool.poolVec2 == null)
                                {
                                    _loc_14 = new Vec2();
                                }
                                else
                                {
                                    _loc_14 = ZPP_PubPool.poolVec2;
                                    ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                                    _loc_14.zpp_pool = null;
                                    _loc_14.zpp_disp = false;
                                    if (_loc_14 == ZPP_PubPool.nextVec2)
                                    {
                                        ZPP_PubPool.nextVec2 = null;
                                    }
                                }
                                if (_loc_14.zpp_inner == null)
                                {
                                    _loc_15 = false;
                                    if (ZPP_Vec2.zpp_pool == null)
                                    {
                                        _loc_12 = new ZPP_Vec2();
                                    }
                                    else
                                    {
                                        _loc_12 = ZPP_Vec2.zpp_pool;
                                        ZPP_Vec2.zpp_pool = _loc_12.next;
                                        _loc_12.next = null;
                                    }
                                    _loc_12.weak = false;
                                    _loc_12._immutable = _loc_15;
                                    _loc_12.x = _loc_11;
                                    _loc_12.y = _loc_13;
                                    _loc_14.zpp_inner = _loc_12;
                                    _loc_14.zpp_inner.outer = _loc_14;
                                }
                                else
                                {
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._immutable)
                                    {
                                        throw "Error: Vec2 is immutable";
                                    }
                                    if (_loc_12._isimmutable != null)
                                    {
                                        _loc_12._isimmutable();
                                    }
                                    if (_loc_11 == _loc_11)
                                    {
                                    }
                                    if (_loc_13 != _loc_13)
                                    {
                                        throw "Error: Vec2 components cannot be NaN";
                                    }
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                    if (_loc_14.zpp_inner.x == _loc_11)
                                    {
                                        if (_loc_14 != null)
                                        {
                                        }
                                        if (_loc_14.zpp_disp)
                                        {
                                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                        }
                                        _loc_12 = _loc_14.zpp_inner;
                                        if (_loc_12._validate != null)
                                        {
                                            _loc_12._validate();
                                        }
                                    }
                                    if (_loc_14.zpp_inner.y != _loc_13)
                                    {
                                        _loc_14.zpp_inner.x = _loc_11;
                                        _loc_14.zpp_inner.y = _loc_13;
                                        _loc_12 = _loc_14.zpp_inner;
                                        if (_loc_12._invalidate != null)
                                        {
                                            _loc_12._invalidate(_loc_12);
                                        }
                                    }
                                }
                                _loc_14.zpp_inner.weak = _loc_10;
                                _loc_4 = _loc_14;
                                if (_loc_9 != null)
                                {
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_9 != null)
                                {
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_3.moveTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                            }
                            else
                            {
                                if (_loc_9 != null)
                                {
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_9 != null)
                                {
                                }
                                if (_loc_9.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_9.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_3.lineTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y);
                            }
                            _loc_5 = false;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_9.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            _loc_9.zpp_inner.outer = null;
                            _loc_9.zpp_inner = null;
                            _loc_14 = _loc_9;
                            _loc_14.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_14;
                            }
                            ZPP_PubPool.nextVec2 = _loc_14;
                            _loc_14.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                        }while (_loc_22 != _loc_21)
                    }
                }
                else
                {
                    throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._validate != null)
                {
                    _loc_12._validate();
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._validate != null)
                {
                    _loc_12._validate();
                }
                _loc_3.lineTo(_loc_4.zpp_inner.x, _loc_4.zpp_inner.y);
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_12._isimmutable != null)
                {
                    _loc_12._isimmutable();
                }
                if (_loc_4.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_12 = _loc_4.zpp_inner;
                _loc_4.zpp_inner.outer = null;
                _loc_4.zpp_inner = null;
                _loc_9 = _loc_4;
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
                _loc_23 = _loc_12;
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
                if (param1 is Array)
                {
                    _loc_6 = param1;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6.length)
                    {
                        
                        _loc_8 = _loc_6[_loc_7];
                        _loc_7++;
                        if (_loc_8 == null)
                        {
                            throw "Error: Array<Vec2> contains null objects";
                        }
                        if (!(_loc_8 is Vec2))
                        {
                            throw "Error: Array<Vec2> contains non Vec2 objects";
                        }
                        _loc_9 = _loc_8;
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = zpp_inner.xform.outer.transform(_loc_9);
                        if (_loc_5)
                        {
                            _loc_4 = _loc_14;
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        else
                        {
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        if (!_loc_5)
                        {
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_14.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            _loc_14.zpp_inner.outer = null;
                            _loc_14.zpp_inner = null;
                            _loc_17 = _loc_14;
                            _loc_17.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_17;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_17;
                            }
                            ZPP_PubPool.nextVec2 = _loc_17;
                            _loc_17.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                        _loc_5 = false;
                    }
                }
                else if (param1 is ZPP_Const.vec2vector)
                {
                    _loc_16 = param1;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_16.length)
                    {
                        
                        _loc_9 = _loc_16[_loc_7];
                        _loc_7++;
                        if (_loc_9 == null)
                        {
                            throw "Error: flash.Vector<Vec2> contains null objects";
                        }
                        _loc_14 = _loc_9;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_17 = zpp_inner.xform.outer.transform(_loc_14);
                        if (_loc_5)
                        {
                            _loc_4 = _loc_17;
                            if (_loc_17 != null)
                            {
                            }
                            if (_loc_17.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_17.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_17 != null)
                            {
                            }
                            if (_loc_17.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_17.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_17.zpp_inner.x, _loc_17.zpp_inner.y);
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
                            _loc_12 = _loc_17.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_17 != null)
                            {
                            }
                            if (_loc_17.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_17.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_17.zpp_inner.x, _loc_17.zpp_inner.y);
                        }
                        if (!_loc_5)
                        {
                            if (_loc_17 != null)
                            {
                            }
                            if (_loc_17.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_17.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_17.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_17.zpp_inner;
                            _loc_17.zpp_inner.outer = null;
                            _loc_17.zpp_inner = null;
                            _loc_24 = _loc_17;
                            _loc_24.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_24;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_24;
                            }
                            ZPP_PubPool.nextVec2 = _loc_24;
                            _loc_24.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                        _loc_5 = false;
                    }
                }
                else if (param1 is Vec2List)
                {
                    _loc_18 = param1;
                    _loc_19 = _loc_18.iterator();
                    do
                    {
                        
                        _loc_19.zpp_critical = false;
                        _loc_7 = _loc_19.zpp_i;
                        (_loc_19.zpp_i + 1);
                        _loc_9 = _loc_19.zpp_inner.at(_loc_7);
                        if (_loc_9 == null)
                        {
                            throw "Error: Vec2List contains null objects";
                        }
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = zpp_inner.xform.outer.transform(_loc_9);
                        if (_loc_5)
                        {
                            _loc_4 = _loc_14;
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.moveTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        else
                        {
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._validate != null)
                            {
                                _loc_12._validate();
                            }
                            _loc_3.lineTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                        }
                        if (!_loc_5)
                        {
                            if (_loc_14 != null)
                            {
                            }
                            if (_loc_14.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_14.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_14.zpp_inner;
                            _loc_14.zpp_inner.outer = null;
                            _loc_14.zpp_inner = null;
                            _loc_17 = _loc_14;
                            _loc_17.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_17;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_17;
                            }
                            ZPP_PubPool.nextVec2 = _loc_17;
                            _loc_17.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                        _loc_5 = false;
                        _loc_19.zpp_inner.zpp_inner.valmod();
                        _loc_7 = _loc_19.zpp_inner.zpp_gl();
                        _loc_19.zpp_critical = true;
                    }while (_loc_19.zpp_i < _loc_7 ? (true) : (_loc_19.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_19, _loc_19.zpp_inner = null, false))
                }
                else if (param1 is GeomPoly)
                {
                    _loc_20 = param1;
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
                    }
                    _loc_21 = _loc_20.zpp_inner.vertices;
                    if (_loc_21 != null)
                    {
                        _loc_22 = _loc_21;
                        do
                        {
                            
                            _loc_11 = _loc_22.x;
                            _loc_13 = _loc_22.y;
                            _loc_10 = false;
                            if (_loc_11 == _loc_11)
                            {
                            }
                            if (_loc_13 != _loc_13)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_14 = new Vec2();
                            }
                            else
                            {
                                _loc_14 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                                _loc_14.zpp_pool = null;
                                _loc_14.zpp_disp = false;
                                if (_loc_14 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_14.zpp_inner == null)
                            {
                                _loc_15 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_12 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_12 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_12.next;
                                    _loc_12.next = null;
                                }
                                _loc_12.weak = false;
                                _loc_12._immutable = _loc_15;
                                _loc_12.x = _loc_11;
                                _loc_12.y = _loc_13;
                                _loc_14.zpp_inner = _loc_12;
                                _loc_14.zpp_inner.outer = _loc_14;
                            }
                            else
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_11 == _loc_11)
                                {
                                }
                                if (_loc_13 != _loc_13)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14.zpp_inner.x == _loc_11)
                                {
                                    if (_loc_14 != null)
                                    {
                                    }
                                    if (_loc_14.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._validate != null)
                                    {
                                        _loc_12._validate();
                                    }
                                }
                                if (_loc_14.zpp_inner.y != _loc_13)
                                {
                                    _loc_14.zpp_inner.x = _loc_11;
                                    _loc_14.zpp_inner.y = _loc_13;
                                    _loc_12 = _loc_14.zpp_inner;
                                    if (_loc_12._invalidate != null)
                                    {
                                        _loc_12._invalidate(_loc_12);
                                    }
                                }
                            }
                            _loc_14.zpp_inner.weak = _loc_10;
                            _loc_9 = _loc_14;
                            _loc_22 = _loc_22.next;
                            _loc_14 = zpp_inner.xform.outer.transform(_loc_9);
                            if (_loc_5)
                            {
                                _loc_4 = _loc_14;
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_3.moveTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                            }
                            else
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._validate != null)
                                {
                                    _loc_12._validate();
                                }
                                _loc_3.lineTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                            }
                            if (!_loc_5)
                            {
                                if (_loc_14 != null)
                                {
                                }
                                if (_loc_14.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                if (_loc_12._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_12._isimmutable != null)
                                {
                                    _loc_12._isimmutable();
                                }
                                if (_loc_14.zpp_inner._inuse)
                                {
                                    throw "Error: This Vec2 is not disposable";
                                }
                                _loc_12 = _loc_14.zpp_inner;
                                _loc_14.zpp_inner.outer = null;
                                _loc_14.zpp_inner = null;
                                _loc_17 = _loc_14;
                                _loc_17.zpp_pool = null;
                                if (ZPP_PubPool.nextVec2 != null)
                                {
                                    ZPP_PubPool.nextVec2.zpp_pool = _loc_17;
                                }
                                else
                                {
                                    ZPP_PubPool.poolVec2 = _loc_17;
                                }
                                ZPP_PubPool.nextVec2 = _loc_17;
                                _loc_17.zpp_disp = true;
                                _loc_23 = _loc_12;
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
                            _loc_5 = false;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_9.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            _loc_9.zpp_inner.outer = null;
                            _loc_9.zpp_inner = null;
                            _loc_14 = _loc_9;
                            _loc_14.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_14;
                            }
                            ZPP_PubPool.nextVec2 = _loc_14;
                            _loc_14.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                        }while (_loc_22 != _loc_21)
                    }
                }
                else
                {
                    throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._validate != null)
                {
                    _loc_12._validate();
                }
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._validate != null)
                {
                    _loc_12._validate();
                }
                _loc_3.lineTo(_loc_4.zpp_inner.x, _loc_4.zpp_inner.y);
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_4.zpp_inner;
                if (_loc_12._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_12._isimmutable != null)
                {
                    _loc_12._isimmutable();
                }
                if (_loc_4.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_12 = _loc_4.zpp_inner;
                _loc_4.zpp_inner.outer = null;
                _loc_4.zpp_inner = null;
                _loc_9 = _loc_4;
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
                _loc_23 = _loc_12;
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
            _loc_3.endFill();
            if (param1 is Array)
            {
                _loc_6 = param1;
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    _loc_9 = _loc_6[_loc_7];
                    if (_loc_9.zpp_inner.weak)
                    {
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_12 = _loc_9.zpp_inner;
                        if (_loc_12._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_12._isimmutable != null)
                        {
                            _loc_12._isimmutable();
                        }
                        if (_loc_9.zpp_inner._inuse)
                        {
                            throw "Error: This Vec2 is not disposable";
                        }
                        _loc_12 = _loc_9.zpp_inner;
                        _loc_9.zpp_inner.outer = null;
                        _loc_9.zpp_inner = null;
                        _loc_14 = _loc_9;
                        _loc_14.zpp_pool = null;
                        if (ZPP_PubPool.nextVec2 != null)
                        {
                            ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                        }
                        else
                        {
                            ZPP_PubPool.poolVec2 = _loc_14;
                        }
                        ZPP_PubPool.nextVec2 = _loc_14;
                        _loc_14.zpp_disp = true;
                        _loc_23 = _loc_12;
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
                        _loc_6.splice(_loc_7, 1);
                        continue;
                    }
                    _loc_7++;
                }
            }
            else if (param1 is ZPP_Const.vec2vector)
            {
                _loc_16 = param1;
                if (!_loc_16.fixed)
                {
                    _loc_7 = 0;
                    while (_loc_7 < _loc_16.length)
                    {
                        
                        _loc_9 = _loc_16[_loc_7];
                        if (_loc_9.zpp_inner.weak)
                        {
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            if (_loc_12._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_12._isimmutable != null)
                            {
                                _loc_12._isimmutable();
                            }
                            if (_loc_9.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_12 = _loc_9.zpp_inner;
                            _loc_9.zpp_inner.outer = null;
                            _loc_9.zpp_inner = null;
                            _loc_14 = _loc_9;
                            _loc_14.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_14;
                            }
                            ZPP_PubPool.nextVec2 = _loc_14;
                            _loc_14.zpp_disp = true;
                            _loc_23 = _loc_12;
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
                            _loc_16.splice(_loc_7, 1);
                            continue;
                        }
                        _loc_7++;
                    }
                }
            }
            else if (param1 is Vec2List)
            {
                _loc_18 = param1;
                if (_loc_18.zpp_inner._validate != null)
                {
                    _loc_18.zpp_inner._validate();
                }
                _loc_25 = _loc_18.zpp_inner.inner;
                _loc_26 = null;
                _loc_27 = _loc_25.head;
                while (_loc_27 != null)
                {
                    
                    _loc_12 = _loc_27.elt;
                    if (_loc_12.outer.zpp_inner.weak)
                    {
                        _loc_27 = _loc_25.erase(_loc_26);
                        if (_loc_12.outer.zpp_inner.weak)
                        {
                            _loc_9 = _loc_12.outer;
                            if (_loc_9 != null)
                            {
                            }
                            if (_loc_9.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_23 = _loc_9.zpp_inner;
                            if (_loc_23._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_23._isimmutable != null)
                            {
                                _loc_23._isimmutable();
                            }
                            if (_loc_9.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_23 = _loc_9.zpp_inner;
                            _loc_9.zpp_inner.outer = null;
                            _loc_9.zpp_inner = null;
                            _loc_14 = _loc_9;
                            _loc_14.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_14;
                            }
                            ZPP_PubPool.nextVec2 = _loc_14;
                            _loc_14.zpp_disp = true;
                            _loc_28 = _loc_23;
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
                        else
                        {
                        }
                        continue;
                    }
                    _loc_26 = _loc_27;
                    _loc_27 = _loc_27.next;
                }
            }
            return;
        }// end function

        override public function drawFilledCircle(param1:Vec2, param2:Number, param3:int) : void
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
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
            var _loc_4:* = zpp_inner_zn.graphics;
            _loc_4.lineStyle(0, 0, 0);
            _loc_4.beginFill(param3 & 16777215, 1);
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
                _loc_4.drawCircle(param1.zpp_inner.x, param1.zpp_inner.y, param2);
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
            }
            else
            {
                _loc_6 = zpp_inner.xform.outer.transform(param1);
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_4.drawCircle(_loc_6.zpp_inner.x, _loc_6.zpp_inner.y, param2 * zpp_inner.xdet);
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
                _loc_8 = _loc_6;
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
            _loc_4.endFill();
            return;
        }// end function

        override public function drawCurve(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
        {
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = null as Vec2;
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
            var _loc_5:* = zpp_inner_zn.graphics;
            _loc_5.lineStyle(thickness, param4 & 16777215, 1);
            if (zpp_inner.xnull)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_5.moveTo(param1.zpp_inner.x, param1.zpp_inner.y);
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param2.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param2.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param3.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param3.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_5.curveTo(param2.zpp_inner.x, param2.zpp_inner.y, param3.zpp_inner.x, param3.zpp_inner.y);
                if (param1.zpp_inner.weak)
                {
                    if (param1 != null)
                    {
                    }
                    if (param1.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = param1.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (param1.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_6 = param1.zpp_inner;
                    param1.zpp_inner.outer = null;
                    param1.zpp_inner = null;
                    _loc_7 = param1;
                    _loc_7.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_7;
                    }
                    ZPP_PubPool.nextVec2 = _loc_7;
                    _loc_7.zpp_disp = true;
                    _loc_8 = _loc_6;
                    if (_loc_8.outer != null)
                    {
                        _loc_8.outer.zpp_inner = null;
                        _loc_8.outer = null;
                    }
                    _loc_8._isimmutable = null;
                    _loc_8._validate = null;
                    _loc_8._invalidate = null;
                    _loc_8.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_8;
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
                    _loc_6 = param2.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (param2.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_6 = param2.zpp_inner;
                    param2.zpp_inner.outer = null;
                    param2.zpp_inner = null;
                    _loc_7 = param2;
                    _loc_7.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_7;
                    }
                    ZPP_PubPool.nextVec2 = _loc_7;
                    _loc_7.zpp_disp = true;
                    _loc_8 = _loc_6;
                    if (_loc_8.outer != null)
                    {
                        _loc_8.outer.zpp_inner = null;
                        _loc_8.outer = null;
                    }
                    _loc_8._isimmutable = null;
                    _loc_8._validate = null;
                    _loc_8._invalidate = null;
                    _loc_8.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_8;
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
                    _loc_6 = param3.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (param3.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_6 = param3.zpp_inner;
                    param3.zpp_inner.outer = null;
                    param3.zpp_inner = null;
                    _loc_7 = param3;
                    _loc_7.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_7;
                    }
                    ZPP_PubPool.nextVec2 = _loc_7;
                    _loc_7.zpp_disp = true;
                    _loc_8 = _loc_6;
                    if (_loc_8.outer != null)
                    {
                        _loc_8.outer.zpp_inner = null;
                        _loc_8.outer = null;
                    }
                    _loc_8._isimmutable = null;
                    _loc_8._validate = null;
                    _loc_8._invalidate = null;
                    _loc_8.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_8;
                }
                else
                {
                }
            }
            else
            {
                _loc_7 = zpp_inner.xform.outer.transform(param1);
                _loc_9 = zpp_inner.xform.outer.transform(param2);
                _loc_10 = zpp_inner.xform.outer.transform(param3);
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_5.moveTo(_loc_7.zpp_inner.x, _loc_7.zpp_inner.y);
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_9.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_9.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_10.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_10.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_5.curveTo(_loc_9.zpp_inner.x, _loc_9.zpp_inner.y, _loc_10.zpp_inner.x, _loc_10.zpp_inner.y);
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_7.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = _loc_7.zpp_inner;
                _loc_7.zpp_inner.outer = null;
                _loc_7.zpp_inner = null;
                _loc_11 = _loc_7;
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
                _loc_8 = _loc_6;
                if (_loc_8.outer != null)
                {
                    _loc_8.outer.zpp_inner = null;
                    _loc_8.outer = null;
                }
                _loc_8._isimmutable = null;
                _loc_8._validate = null;
                _loc_8._invalidate = null;
                _loc_8.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_8;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_9.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_9.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = _loc_9.zpp_inner;
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
                _loc_8 = _loc_6;
                if (_loc_8.outer != null)
                {
                    _loc_8.outer.zpp_inner = null;
                    _loc_8.outer = null;
                }
                _loc_8._isimmutable = null;
                _loc_8._validate = null;
                _loc_8._invalidate = null;
                _loc_8.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_8;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_10.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_10.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = _loc_10.zpp_inner;
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
                _loc_8 = _loc_6;
                if (_loc_8.outer != null)
                {
                    _loc_8.outer.zpp_inner = null;
                    _loc_8.outer = null;
                }
                _loc_8._isimmutable = null;
                _loc_8._validate = null;
                _loc_8._invalidate = null;
                _loc_8.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_8;
            }
            return;
        }// end function

        override public function drawCircle(param1:Vec2, param2:Number, param3:int) : void
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
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
            var _loc_4:* = zpp_inner_zn.graphics;
            _loc_4.lineStyle(thickness, param3 & 16777215, 1);
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
                _loc_4.drawCircle(param1.zpp_inner.x, param1.zpp_inner.y, param2);
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
            }
            else
            {
                _loc_6 = zpp_inner.xform.outer.transform(param1);
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                _loc_4.drawCircle(_loc_6.zpp_inner.x, _loc_6.zpp_inner.y, param2 * zpp_inner.xdet);
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
                _loc_8 = _loc_6;
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

        override public function drawAABB(param1:AABB, param2:int) : void
        {
            var _loc_4:* = null as ZPP_AABB;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = NaN;
            var _loc_8:* = false;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = false;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as Vec2;
            var _loc_13:* = null as Vec2;
            var _loc_14:* = null as Vec2;
            var _loc_15:* = null as ZPP_Vec2;
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
            var _loc_3:* = zpp_inner_zn.graphics;
            _loc_3.lineStyle(thickness, param2 & 16777215, 1);
            if (zpp_inner.xnull)
            {
                _loc_4 = param1.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                _loc_4 = param1.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                _loc_4 = param1.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                _loc_4 = param1.zpp_inner;
                _loc_4 = param1.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                _loc_4 = param1.zpp_inner;
                _loc_3.drawRect(param1.zpp_inner.minx, param1.zpp_inner.miny, _loc_4.maxx - _loc_4.minx, _loc_4.maxy - _loc_4.miny);
            }
            else
            {
                _loc_5 = zpp_inner.xform.outer.transform(param1.zpp_inner.getmin());
                _loc_4 = param1.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                _loc_4 = param1.zpp_inner;
                _loc_7 = _loc_4.maxx - _loc_4.minx;
                _loc_8 = false;
                if (_loc_7 != _loc_7)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_9 = new Vec2();
                }
                else
                {
                    _loc_9 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_9.zpp_pool;
                    _loc_9.zpp_pool = null;
                    _loc_9.zpp_disp = false;
                    if (_loc_9 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_9.zpp_inner == null)
                {
                    _loc_10 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_11 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_11 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.weak = false;
                    _loc_11._immutable = _loc_10;
                    _loc_11.x = _loc_7;
                    _loc_11.y = 0;
                    _loc_9.zpp_inner = _loc_11;
                    _loc_9.zpp_inner.outer = _loc_9;
                }
                else
                {
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_9.zpp_inner;
                    if (_loc_11._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_11._isimmutable != null)
                    {
                        _loc_11._isimmutable();
                    }
                    if (_loc_7 != _loc_7)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_9.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    if (_loc_9.zpp_inner.x == _loc_7)
                    {
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_9.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                    }
                    if (_loc_9.zpp_inner.y != 0)
                    {
                        _loc_9.zpp_inner.x = _loc_7;
                        _loc_9.zpp_inner.y = 0;
                        _loc_11 = _loc_9.zpp_inner;
                        if (_loc_11._invalidate != null)
                        {
                            _loc_11._invalidate(_loc_11);
                        }
                    }
                }
                _loc_9.zpp_inner.weak = _loc_8;
                _loc_6 = _loc_9;
                _loc_9 = zpp_inner.xform.outer.transform(_loc_6, true);
                _loc_4 = param1.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                _loc_4 = param1.zpp_inner;
                _loc_7 = _loc_4.maxy - _loc_4.miny;
                _loc_8 = false;
                if (_loc_7 != _loc_7)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_13 = new Vec2();
                }
                else
                {
                    _loc_13 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_13.zpp_pool;
                    _loc_13.zpp_pool = null;
                    _loc_13.zpp_disp = false;
                    if (_loc_13 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_13.zpp_inner == null)
                {
                    _loc_10 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_11 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_11 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.weak = false;
                    _loc_11._immutable = _loc_10;
                    _loc_11.x = 0;
                    _loc_11.y = _loc_7;
                    _loc_13.zpp_inner = _loc_11;
                    _loc_13.zpp_inner.outer = _loc_13;
                }
                else
                {
                    if (_loc_13 != null)
                    {
                    }
                    if (_loc_13.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_13.zpp_inner;
                    if (_loc_11._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_11._isimmutable != null)
                    {
                        _loc_11._isimmutable();
                    }
                    if (_loc_7 != _loc_7)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_13 != null)
                    {
                    }
                    if (_loc_13.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_13.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    if (_loc_13.zpp_inner.x == 0)
                    {
                        if (_loc_13 != null)
                        {
                        }
                        if (_loc_13.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_13.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                    }
                    if (_loc_13.zpp_inner.y != _loc_7)
                    {
                        _loc_13.zpp_inner.x = 0;
                        _loc_13.zpp_inner.y = _loc_7;
                        _loc_11 = _loc_13.zpp_inner;
                        if (_loc_11._invalidate != null)
                        {
                            _loc_11._invalidate(_loc_11);
                        }
                    }
                }
                _loc_13.zpp_inner.weak = _loc_8;
                _loc_12 = _loc_13;
                _loc_13 = zpp_inner.xform.outer.transform(_loc_12, true);
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_3.moveTo(_loc_5.zpp_inner.x, _loc_5.zpp_inner.y);
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_9.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_9.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_3.lineTo(_loc_5.zpp_inner.x + _loc_9.zpp_inner.x, _loc_5.zpp_inner.y + _loc_9.zpp_inner.y);
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_9.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_13 != null)
                {
                }
                if (_loc_13.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_13.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_9.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_13 != null)
                {
                }
                if (_loc_13.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_13.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_3.lineTo(_loc_5.zpp_inner.x + _loc_9.zpp_inner.x + _loc_13.zpp_inner.x, _loc_5.zpp_inner.y + _loc_9.zpp_inner.y + _loc_13.zpp_inner.y);
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_13 != null)
                {
                }
                if (_loc_13.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_13.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_13 != null)
                {
                }
                if (_loc_13.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_13.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_3.lineTo(_loc_5.zpp_inner.x + _loc_13.zpp_inner.x, _loc_5.zpp_inner.y + _loc_13.zpp_inner.y);
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_3.lineTo(_loc_5.zpp_inner.x, _loc_5.zpp_inner.y);
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_5.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_5.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_11 = _loc_5.zpp_inner;
                _loc_5.zpp_inner.outer = null;
                _loc_5.zpp_inner = null;
                _loc_14 = _loc_5;
                _loc_14.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_14;
                }
                ZPP_PubPool.nextVec2 = _loc_14;
                _loc_14.zpp_disp = true;
                _loc_15 = _loc_11;
                if (_loc_15.outer != null)
                {
                    _loc_15.outer.zpp_inner = null;
                    _loc_15.outer = null;
                }
                _loc_15._isimmutable = null;
                _loc_15._validate = null;
                _loc_15._invalidate = null;
                _loc_15.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_15;
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_6.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_6.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_11 = _loc_6.zpp_inner;
                _loc_6.zpp_inner.outer = null;
                _loc_6.zpp_inner = null;
                _loc_14 = _loc_6;
                _loc_14.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_14;
                }
                ZPP_PubPool.nextVec2 = _loc_14;
                _loc_14.zpp_disp = true;
                _loc_15 = _loc_11;
                if (_loc_15.outer != null)
                {
                    _loc_15.outer.zpp_inner = null;
                    _loc_15.outer = null;
                }
                _loc_15._isimmutable = null;
                _loc_15._validate = null;
                _loc_15._invalidate = null;
                _loc_15.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_15;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_9.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_9.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_11 = _loc_9.zpp_inner;
                _loc_9.zpp_inner.outer = null;
                _loc_9.zpp_inner = null;
                _loc_14 = _loc_9;
                _loc_14.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_14;
                }
                ZPP_PubPool.nextVec2 = _loc_14;
                _loc_14.zpp_disp = true;
                _loc_15 = _loc_11;
                if (_loc_15.outer != null)
                {
                    _loc_15.outer.zpp_inner = null;
                    _loc_15.outer = null;
                }
                _loc_15._isimmutable = null;
                _loc_15._validate = null;
                _loc_15._invalidate = null;
                _loc_15.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_15;
                if (_loc_12 != null)
                {
                }
                if (_loc_12.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_12.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_12.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_11 = _loc_12.zpp_inner;
                _loc_12.zpp_inner.outer = null;
                _loc_12.zpp_inner = null;
                _loc_14 = _loc_12;
                _loc_14.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_14;
                }
                ZPP_PubPool.nextVec2 = _loc_14;
                _loc_14.zpp_disp = true;
                _loc_15 = _loc_11;
                if (_loc_15.outer != null)
                {
                    _loc_15.outer.zpp_inner = null;
                    _loc_15.outer = null;
                }
                _loc_15._isimmutable = null;
                _loc_15._validate = null;
                _loc_15._invalidate = null;
                _loc_15.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_15;
                if (_loc_13 != null)
                {
                }
                if (_loc_13.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_13.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_13.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_11 = _loc_13.zpp_inner;
                _loc_13.zpp_inner.outer = null;
                _loc_13.zpp_inner = null;
                _loc_14 = _loc_13;
                _loc_14.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_14;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_14;
                }
                ZPP_PubPool.nextVec2 = _loc_14;
                _loc_14.zpp_disp = true;
                _loc_15 = _loc_11;
                if (_loc_15.outer != null)
                {
                    _loc_15.outer.zpp_inner = null;
                    _loc_15.outer = null;
                }
                _loc_15._isimmutable = null;
                _loc_15._validate = null;
                _loc_15._invalidate = null;
                _loc_15.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_15;
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
            zpp_inner_zn.graphics.clear();
            return;
        }// end function

    }
}
