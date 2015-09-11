package zpp_nape.constraint
{
    import nape.*;
    import nape.geom.*;
    import nape.util.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    public class ZPP_AngleDraw extends Object
    {
        public static var init__:Boolean;
        public static var maxarc:Number;

        public function ZPP_AngleDraw() : void
        {
            return;
        }// end function

        public static function indicator(param1:Debug, param2:Vec2, param3:Number, param4:Number, param5:int) : void
        {
            var _loc_10:* = null as Vec2;
            var _loc_11:* = false;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_7:* = Math.cos(param3);
            var _loc_8:* = Math.sin(param3);
            var _loc_9:* = false;
            if (_loc_7 == _loc_7)
            {
            }
            if (_loc_8 != _loc_8)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_10 = new Vec2();
            }
            else
            {
                _loc_10 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_10.zpp_pool;
                _loc_10.zpp_pool = null;
                _loc_10.zpp_disp = false;
                if (_loc_10 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_10.zpp_inner == null)
            {
                _loc_11 = false;
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
                _loc_12._immutable = _loc_11;
                _loc_12.x = _loc_7;
                _loc_12.y = _loc_8;
                _loc_10.zpp_inner = _loc_12;
                _loc_10.zpp_inner.outer = _loc_10;
            }
            else
            {
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_10.zpp_inner;
                if (_loc_12._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_12._isimmutable != null)
                {
                    _loc_12._isimmutable();
                }
                if (_loc_7 == _loc_7)
                {
                }
                if (_loc_8 != _loc_8)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_12 = _loc_10.zpp_inner;
                if (_loc_12._validate != null)
                {
                    _loc_12._validate();
                }
                if (_loc_10.zpp_inner.x == _loc_7)
                {
                    if (_loc_10 != null)
                    {
                    }
                    if (_loc_10.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_12 = _loc_10.zpp_inner;
                    if (_loc_12._validate != null)
                    {
                        _loc_12._validate();
                    }
                }
                if (_loc_10.zpp_inner.y != _loc_8)
                {
                    _loc_10.zpp_inner.x = _loc_7;
                    _loc_10.zpp_inner.y = _loc_8;
                    _loc_12 = _loc_10.zpp_inner;
                    if (_loc_12._invalidate != null)
                    {
                        _loc_12._invalidate(_loc_12);
                    }
                }
            }
            _loc_10.zpp_inner.weak = _loc_9;
            var _loc_6:* = _loc_10;
            param1.drawFilledCircle(param2.add(_loc_6.mul(param4, true), true), 2, param5);
            if (_loc_6 != null)
            {
            }
            if (_loc_6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_12 = _loc_6.zpp_inner;
            if (_loc_12._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_12._isimmutable != null)
            {
                _loc_12._isimmutable();
            }
            if (_loc_6.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_12 = _loc_6.zpp_inner;
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
            var _loc_13:* = _loc_12;
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
            return;
        }// end function

        public static function drawSpiralSpring(param1:Debug, param2:Vec2, param3:Number, param4:Number, param5:Number, param6:Number, param7:int, param8:int = 4) : void
        {
            var _loc_9:* = NaN;
            var _loc_11:* = NaN;
            var _loc_13:* = 0;
            var _loc_15:* = 0;
            var _loc_23:* = null as ZPP_Vec2;
            var _loc_26:* = null as Vec2;
            var _loc_27:* = false;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = null as Vec2;
            var _loc_32:* = null as Vec2;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = NaN;
            var _loc_40:* = NaN;
            var _loc_41:* = null as Vec2;
            var _loc_42:* = null as ZPP_Vec2;
            if (param3 > param4)
            {
                _loc_9 = param3;
                param3 = param4;
                param4 = _loc_9;
                _loc_9 = param5;
                param5 = param6;
                param6 = _loc_9;
            }
            if (param3 == param4)
            {
                return;
            }
            _loc_9 = param6 - param5;
            var _loc_10:* = param4 - param3;
            var _loc_12:* = 2 * Math.PI * _loc_9 / _loc_10;
            if (_loc_12 < 0)
            {
                _loc_11 = -_loc_12;
            }
            else
            {
                _loc_11 = _loc_12;
            }
            var _loc_14:* = Math.ceil(_loc_10 / ZPP_AngleDraw.maxarc * 3);
            _loc_15 = 4 * param8;
            if (_loc_14 > _loc_15)
            {
                _loc_13 = _loc_14;
            }
            else
            {
                _loc_13 = _loc_15;
            }
            _loc_12 = _loc_9 / _loc_13;
            var _loc_16:* = _loc_10 / _loc_13;
            var _loc_17:* = 1 / _loc_13;
            var _loc_18:* = Math.cos(param3);
            var _loc_19:* = Math.sin(param3);
            var _loc_21:* = param5 + _loc_9 * 0;
            var _loc_20:* = _loc_21 + 0.75 * _loc_11 * Math.sin(2 * param8 * Math.PI * 0);
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_23 = param2.zpp_inner;
            if (_loc_23._validate != null)
            {
                _loc_23._validate();
            }
            _loc_21 = param2.zpp_inner.x + _loc_20 * _loc_18;
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_23 = param2.zpp_inner;
            if (_loc_23._validate != null)
            {
                _loc_23._validate();
            }
            var _loc_24:* = param2.zpp_inner.y + _loc_20 * _loc_19;
            var _loc_25:* = false;
            if (_loc_21 == _loc_21)
            {
            }
            if (_loc_24 != _loc_24)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_26 = new Vec2();
            }
            else
            {
                _loc_26 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_26.zpp_pool;
                _loc_26.zpp_pool = null;
                _loc_26.zpp_disp = false;
                if (_loc_26 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_26.zpp_inner == null)
            {
                _loc_27 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_23 = new ZPP_Vec2();
                }
                else
                {
                    _loc_23 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_23.next;
                    _loc_23.next = null;
                }
                _loc_23.weak = false;
                _loc_23._immutable = _loc_27;
                _loc_23.x = _loc_21;
                _loc_23.y = _loc_24;
                _loc_26.zpp_inner = _loc_23;
                _loc_26.zpp_inner.outer = _loc_26;
            }
            else
            {
                if (_loc_26 != null)
                {
                }
                if (_loc_26.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_26.zpp_inner;
                if (_loc_23._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_23._isimmutable != null)
                {
                    _loc_23._isimmutable();
                }
                if (_loc_21 == _loc_21)
                {
                }
                if (_loc_24 != _loc_24)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_26 != null)
                {
                }
                if (_loc_26.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_26.zpp_inner;
                if (_loc_23._validate != null)
                {
                    _loc_23._validate();
                }
                if (_loc_26.zpp_inner.x == _loc_21)
                {
                    if (_loc_26 != null)
                    {
                    }
                    if (_loc_26.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_23 = _loc_26.zpp_inner;
                    if (_loc_23._validate != null)
                    {
                        _loc_23._validate();
                    }
                }
                if (_loc_26.zpp_inner.y != _loc_24)
                {
                    _loc_26.zpp_inner.x = _loc_21;
                    _loc_26.zpp_inner.y = _loc_24;
                    _loc_23 = _loc_26.zpp_inner;
                    if (_loc_23._invalidate != null)
                    {
                        _loc_23._invalidate(_loc_23);
                    }
                }
            }
            _loc_26.zpp_inner.weak = _loc_25;
            var _loc_22:* = _loc_26;
            _loc_21 = _loc_9 + 1.5 * param8 * _loc_11 * Math.PI * Math.cos(2 * param8 * Math.PI * 0);
            _loc_24 = _loc_21 * _loc_18 - _loc_20 * _loc_10 * _loc_19;
            var _loc_28:* = _loc_21 * _loc_19 + _loc_20 * _loc_10 * _loc_18;
            _loc_29 = 0;
            _loc_30 = 0;
            _loc_25 = false;
            if (_loc_29 == _loc_29)
            {
            }
            if (_loc_30 != _loc_30)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_31 = new Vec2();
            }
            else
            {
                _loc_31 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_31.zpp_pool;
                _loc_31.zpp_pool = null;
                _loc_31.zpp_disp = false;
                if (_loc_31 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_31.zpp_inner == null)
            {
                _loc_27 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_23 = new ZPP_Vec2();
                }
                else
                {
                    _loc_23 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_23.next;
                    _loc_23.next = null;
                }
                _loc_23.weak = false;
                _loc_23._immutable = _loc_27;
                _loc_23.x = _loc_29;
                _loc_23.y = _loc_30;
                _loc_31.zpp_inner = _loc_23;
                _loc_31.zpp_inner.outer = _loc_31;
            }
            else
            {
                if (_loc_31 != null)
                {
                }
                if (_loc_31.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_31.zpp_inner;
                if (_loc_23._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_23._isimmutable != null)
                {
                    _loc_23._isimmutable();
                }
                if (_loc_29 == _loc_29)
                {
                }
                if (_loc_30 != _loc_30)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_31 != null)
                {
                }
                if (_loc_31.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_31.zpp_inner;
                if (_loc_23._validate != null)
                {
                    _loc_23._validate();
                }
                if (_loc_31.zpp_inner.x == _loc_29)
                {
                    if (_loc_31 != null)
                    {
                    }
                    if (_loc_31.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_23 = _loc_31.zpp_inner;
                    if (_loc_23._validate != null)
                    {
                        _loc_23._validate();
                    }
                }
                if (_loc_31.zpp_inner.y != _loc_30)
                {
                    _loc_31.zpp_inner.x = _loc_29;
                    _loc_31.zpp_inner.y = _loc_30;
                    _loc_23 = _loc_31.zpp_inner;
                    if (_loc_23._invalidate != null)
                    {
                        _loc_23._invalidate(_loc_23);
                    }
                }
            }
            _loc_31.zpp_inner.weak = _loc_25;
            _loc_26 = _loc_31;
            _loc_29 = 0;
            _loc_30 = 0;
            _loc_25 = false;
            if (_loc_29 == _loc_29)
            {
            }
            if (_loc_30 != _loc_30)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_32 = new Vec2();
            }
            else
            {
                _loc_32 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_32.zpp_pool;
                _loc_32.zpp_pool = null;
                _loc_32.zpp_disp = false;
                if (_loc_32 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_32.zpp_inner == null)
            {
                _loc_27 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_23 = new ZPP_Vec2();
                }
                else
                {
                    _loc_23 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_23.next;
                    _loc_23.next = null;
                }
                _loc_23.weak = false;
                _loc_23._immutable = _loc_27;
                _loc_23.x = _loc_29;
                _loc_23.y = _loc_30;
                _loc_32.zpp_inner = _loc_23;
                _loc_32.zpp_inner.outer = _loc_32;
            }
            else
            {
                if (_loc_32 != null)
                {
                }
                if (_loc_32.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_32.zpp_inner;
                if (_loc_23._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_23._isimmutable != null)
                {
                    _loc_23._isimmutable();
                }
                if (_loc_29 == _loc_29)
                {
                }
                if (_loc_30 != _loc_30)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_32 != null)
                {
                }
                if (_loc_32.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_32.zpp_inner;
                if (_loc_23._validate != null)
                {
                    _loc_23._validate();
                }
                if (_loc_32.zpp_inner.x == _loc_29)
                {
                    if (_loc_32 != null)
                    {
                    }
                    if (_loc_32.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_23 = _loc_32.zpp_inner;
                    if (_loc_23._validate != null)
                    {
                        _loc_23._validate();
                    }
                }
                if (_loc_32.zpp_inner.y != _loc_30)
                {
                    _loc_32.zpp_inner.x = _loc_29;
                    _loc_32.zpp_inner.y = _loc_30;
                    _loc_23 = _loc_32.zpp_inner;
                    if (_loc_23._invalidate != null)
                    {
                        _loc_23._invalidate(_loc_23);
                    }
                }
            }
            _loc_32.zpp_inner.weak = _loc_25;
            _loc_31 = _loc_32;
            _loc_14 = 0;
            while (_loc_14 < _loc_13)
            {
                
                _loc_14++;
                _loc_15 = _loc_14;
                _loc_29 = param3 + _loc_16;
                _loc_30 = Math.cos(_loc_29);
                _loc_33 = Math.sin(_loc_29);
                _loc_35 = param5 + _loc_9 * (_loc_15 + 1) * _loc_17;
                _loc_34 = _loc_35 + 0.75 * _loc_11 * Math.sin(2 * param8 * Math.PI * (_loc_15 + 1) * _loc_17);
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = param2.zpp_inner;
                if (_loc_23._validate != null)
                {
                    _loc_23._validate();
                }
                _loc_35 = param2.zpp_inner.x + _loc_34 * _loc_30;
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = param2.zpp_inner;
                if (_loc_23._validate != null)
                {
                    _loc_23._validate();
                }
                _loc_36 = param2.zpp_inner.y + _loc_34 * _loc_33;
                if (_loc_26 != null)
                {
                }
                if (_loc_26.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_26.zpp_inner;
                if (_loc_23._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_23._isimmutable != null)
                {
                    _loc_23._isimmutable();
                }
                if (_loc_35 == _loc_35)
                {
                }
                if (_loc_36 != _loc_36)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_26 != null)
                {
                }
                if (_loc_26.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_26.zpp_inner;
                if (_loc_23._validate != null)
                {
                    _loc_23._validate();
                }
                if (_loc_26.zpp_inner.x == _loc_35)
                {
                    if (_loc_26 != null)
                    {
                    }
                    if (_loc_26.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_23 = _loc_26.zpp_inner;
                    if (_loc_23._validate != null)
                    {
                        _loc_23._validate();
                    }
                }
                if (_loc_26.zpp_inner.y != _loc_36)
                {
                    _loc_26.zpp_inner.x = _loc_35;
                    _loc_26.zpp_inner.y = _loc_36;
                    _loc_23 = _loc_26.zpp_inner;
                    if (_loc_23._invalidate != null)
                    {
                        _loc_23._invalidate(_loc_23);
                    }
                }
                _loc_35 = _loc_9 + 1.5 * param8 * _loc_11 * Math.PI * Math.cos(2 * param8 * Math.PI * (_loc_15 + 1) * _loc_17);
                _loc_36 = _loc_35 * _loc_30 - _loc_34 * _loc_10 * _loc_33;
                _loc_37 = _loc_35 * _loc_33 + _loc_34 * _loc_10 * _loc_30;
                _loc_38 = _loc_24 * _loc_37 - _loc_28 * _loc_36;
                if (_loc_38 * _loc_38 >= Config.epsilon)
                {
                }
                if (_loc_24 * _loc_36 + _loc_28 * _loc_37 > 0)
                {
                }
                if (_loc_24 * _loc_36 + _loc_28 * _loc_37 > 0.999)
                {
                    param1.drawLine(_loc_22, _loc_26, param7);
                }
                else
                {
                    if (_loc_26 != null)
                    {
                    }
                    if (_loc_26.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_23 = _loc_26.zpp_inner;
                    if (_loc_23._validate != null)
                    {
                        _loc_23._validate();
                    }
                    if (_loc_22 != null)
                    {
                    }
                    if (_loc_22.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_23 = _loc_22.zpp_inner;
                    if (_loc_23._validate != null)
                    {
                        _loc_23._validate();
                    }
                    if (_loc_22 != null)
                    {
                    }
                    if (_loc_22.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_23 = _loc_22.zpp_inner;
                    if (_loc_23._validate != null)
                    {
                        _loc_23._validate();
                    }
                    if (_loc_26 != null)
                    {
                    }
                    if (_loc_26.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_23 = _loc_26.zpp_inner;
                    if (_loc_23._validate != null)
                    {
                        _loc_23._validate();
                    }
                    _loc_39 = ((_loc_26.zpp_inner.x - _loc_22.zpp_inner.x) * _loc_37 + (_loc_22.zpp_inner.y - _loc_26.zpp_inner.y) * _loc_36) / _loc_38;
                    if (_loc_39 <= 0)
                    {
                        param1.drawLine(_loc_22, _loc_26, param7);
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
                        _loc_23 = _loc_22.zpp_inner;
                        if (_loc_23._validate != null)
                        {
                            _loc_23._validate();
                        }
                        _loc_40 = _loc_22.zpp_inner.x + _loc_24 * _loc_39;
                        if (_loc_31 != null)
                        {
                        }
                        if (_loc_31.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_23 = _loc_31.zpp_inner;
                        if (_loc_23._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_23._isimmutable != null)
                        {
                            _loc_23._isimmutable();
                        }
                        if (_loc_31 != null)
                        {
                        }
                        if (_loc_31.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_23 = _loc_31.zpp_inner;
                        if (_loc_23._validate != null)
                        {
                            _loc_23._validate();
                        }
                        if (_loc_31.zpp_inner.x != _loc_40)
                        {
                            if (_loc_40 != _loc_40)
                            {
                                throw "Error: Vec2::" + "x" + " cannot be NaN";
                            }
                            _loc_31.zpp_inner.x = _loc_40;
                            _loc_23 = _loc_31.zpp_inner;
                            if (_loc_23._invalidate != null)
                            {
                                _loc_23._invalidate(_loc_23);
                            }
                        }
                        if (_loc_31 != null)
                        {
                        }
                        if (_loc_31.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_23 = _loc_31.zpp_inner;
                        if (_loc_23._validate != null)
                        {
                            _loc_23._validate();
                        }
                        if (_loc_22 != null)
                        {
                        }
                        if (_loc_22.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_23 = _loc_22.zpp_inner;
                        if (_loc_23._validate != null)
                        {
                            _loc_23._validate();
                        }
                        _loc_40 = _loc_22.zpp_inner.y + _loc_28 * _loc_39;
                        if (_loc_31 != null)
                        {
                        }
                        if (_loc_31.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_23 = _loc_31.zpp_inner;
                        if (_loc_23._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_23._isimmutable != null)
                        {
                            _loc_23._isimmutable();
                        }
                        if (_loc_31 != null)
                        {
                        }
                        if (_loc_31.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_23 = _loc_31.zpp_inner;
                        if (_loc_23._validate != null)
                        {
                            _loc_23._validate();
                        }
                        if (_loc_31.zpp_inner.y != _loc_40)
                        {
                            if (_loc_40 != _loc_40)
                            {
                                throw "Error: Vec2::" + "y" + " cannot be NaN";
                            }
                            _loc_31.zpp_inner.y = _loc_40;
                            _loc_23 = _loc_31.zpp_inner;
                            if (_loc_23._invalidate != null)
                            {
                                _loc_23._invalidate(_loc_23);
                            }
                        }
                        if (_loc_31 != null)
                        {
                        }
                        if (_loc_31.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_23 = _loc_31.zpp_inner;
                        if (_loc_23._validate != null)
                        {
                            _loc_23._validate();
                        }
                        param1.drawCurve(_loc_22, _loc_31, _loc_26, param7);
                    }
                }
                param3 = _loc_29;
                _loc_18 = _loc_30;
                _loc_19 = _loc_33;
                _loc_24 = _loc_36;
                _loc_28 = _loc_37;
                if (_loc_22 != null)
                {
                }
                if (_loc_22.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (_loc_26 != null)
                {
                }
                if (_loc_26.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_22.zpp_inner;
                if (_loc_23._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_23._isimmutable != null)
                {
                    _loc_23._isimmutable();
                }
                if (_loc_26 == null)
                {
                    throw "Error: Cannot assign null Vec2";
                }
                if (_loc_26 != null)
                {
                }
                if (_loc_26.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_26.zpp_inner;
                if (_loc_23._validate != null)
                {
                    _loc_23._validate();
                }
                _loc_39 = _loc_26.zpp_inner.x;
                if (_loc_26 != null)
                {
                }
                if (_loc_26.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_26.zpp_inner;
                if (_loc_23._validate != null)
                {
                    _loc_23._validate();
                }
                _loc_40 = _loc_26.zpp_inner.y;
                if (_loc_22 != null)
                {
                }
                if (_loc_22.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_23 = _loc_22.zpp_inner;
                if (_loc_23._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_23._isimmutable != null)
                {
                    _loc_23._isimmutable();
                }
                if (_loc_39 == _loc_39)
                {
                }
                if (_loc_40 != _loc_40)
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
                _loc_23 = _loc_22.zpp_inner;
                if (_loc_23._validate != null)
                {
                    _loc_23._validate();
                }
                if (_loc_22.zpp_inner.x == _loc_39)
                {
                    if (_loc_22 != null)
                    {
                    }
                    if (_loc_22.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_23 = _loc_22.zpp_inner;
                    if (_loc_23._validate != null)
                    {
                        _loc_23._validate();
                    }
                }
                if (_loc_22.zpp_inner.y != _loc_40)
                {
                    _loc_22.zpp_inner.x = _loc_39;
                    _loc_22.zpp_inner.y = _loc_40;
                    _loc_23 = _loc_22.zpp_inner;
                    if (_loc_23._invalidate != null)
                    {
                        _loc_23._invalidate(_loc_23);
                    }
                }
                _loc_32 = _loc_22;
                if (_loc_26.zpp_inner.weak)
                {
                    if (_loc_26 != null)
                    {
                    }
                    if (_loc_26.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_23 = _loc_26.zpp_inner;
                    if (_loc_23._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_23._isimmutable != null)
                    {
                        _loc_23._isimmutable();
                    }
                    if (_loc_26.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_23 = _loc_26.zpp_inner;
                    _loc_26.zpp_inner.outer = null;
                    _loc_26.zpp_inner = null;
                    _loc_41 = _loc_26;
                    _loc_41.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_41;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_41;
                    }
                    ZPP_PubPool.nextVec2 = _loc_41;
                    _loc_41.zpp_disp = true;
                    _loc_42 = _loc_23;
                    if (_loc_42.outer != null)
                    {
                        _loc_42.outer.zpp_inner = null;
                        _loc_42.outer = null;
                    }
                    _loc_42._isimmutable = null;
                    _loc_42._validate = null;
                    _loc_42._invalidate = null;
                    _loc_42.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_42;
                    continue;
                }
            }
            if (_loc_22 != null)
            {
            }
            if (_loc_22.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_23 = _loc_22.zpp_inner;
            if (_loc_23._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_23._isimmutable != null)
            {
                _loc_23._isimmutable();
            }
            if (_loc_22.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_23 = _loc_22.zpp_inner;
            _loc_22.zpp_inner.outer = null;
            _loc_22.zpp_inner = null;
            _loc_32 = _loc_22;
            _loc_32.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_32;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_32;
            }
            ZPP_PubPool.nextVec2 = _loc_32;
            _loc_32.zpp_disp = true;
            _loc_42 = _loc_23;
            if (_loc_42.outer != null)
            {
                _loc_42.outer.zpp_inner = null;
                _loc_42.outer = null;
            }
            _loc_42._isimmutable = null;
            _loc_42._validate = null;
            _loc_42._invalidate = null;
            _loc_42.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_42;
            if (_loc_26 != null)
            {
            }
            if (_loc_26.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_23 = _loc_26.zpp_inner;
            if (_loc_23._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_23._isimmutable != null)
            {
                _loc_23._isimmutable();
            }
            if (_loc_26.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_23 = _loc_26.zpp_inner;
            _loc_26.zpp_inner.outer = null;
            _loc_26.zpp_inner = null;
            _loc_32 = _loc_26;
            _loc_32.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_32;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_32;
            }
            ZPP_PubPool.nextVec2 = _loc_32;
            _loc_32.zpp_disp = true;
            _loc_42 = _loc_23;
            if (_loc_42.outer != null)
            {
                _loc_42.outer.zpp_inner = null;
                _loc_42.outer = null;
            }
            _loc_42._isimmutable = null;
            _loc_42._validate = null;
            _loc_42._invalidate = null;
            _loc_42.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_42;
            if (_loc_31 != null)
            {
            }
            if (_loc_31.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_23 = _loc_31.zpp_inner;
            if (_loc_23._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_23._isimmutable != null)
            {
                _loc_23._isimmutable();
            }
            if (_loc_31.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_23 = _loc_31.zpp_inner;
            _loc_31.zpp_inner.outer = null;
            _loc_31.zpp_inner = null;
            _loc_32 = _loc_31;
            _loc_32.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_32;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_32;
            }
            ZPP_PubPool.nextVec2 = _loc_32;
            _loc_32.zpp_disp = true;
            _loc_42 = _loc_23;
            if (_loc_42.outer != null)
            {
                _loc_42.outer.zpp_inner = null;
                _loc_42.outer = null;
            }
            _loc_42._isimmutable = null;
            _loc_42._validate = null;
            _loc_42._invalidate = null;
            _loc_42.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_42;
            return;
        }// end function

        public static function drawSpiral(param1:Debug, param2:Vec2, param3:Number, param4:Number, param5:Number, param6:Number, param7:int) : void
        {
            var _loc_8:* = NaN;
            var _loc_17:* = null as ZPP_Vec2;
            var _loc_20:* = null as Vec2;
            var _loc_21:* = false;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = null as Vec2;
            var _loc_25:* = null as Vec2;
            var _loc_27:* = 0;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = null as Vec2;
            var _loc_36:* = null as ZPP_Vec2;
            if (param3 > param4)
            {
                _loc_8 = param3;
                param3 = param4;
                param4 = _loc_8;
                _loc_8 = param5;
                param5 = param6;
                param6 = _loc_8;
            }
            if (param3 == param4)
            {
                return;
            }
            _loc_8 = param6 - param5;
            var _loc_9:* = param4 - param3;
            var _loc_10:* = Math.ceil(_loc_9 / ZPP_AngleDraw.maxarc);
            var _loc_11:* = _loc_8 / _loc_10;
            var _loc_12:* = _loc_9 / _loc_10;
            var _loc_13:* = Math.cos(param3);
            var _loc_14:* = Math.sin(param3);
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_17 = param2.zpp_inner;
            if (_loc_17._validate != null)
            {
                _loc_17._validate();
            }
            var _loc_16:* = param2.zpp_inner.x + param5 * _loc_13;
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_17 = param2.zpp_inner;
            if (_loc_17._validate != null)
            {
                _loc_17._validate();
            }
            var _loc_18:* = param2.zpp_inner.y + param5 * _loc_14;
            var _loc_19:* = false;
            if (_loc_16 == _loc_16)
            {
            }
            if (_loc_18 != _loc_18)
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
                    _loc_17 = new ZPP_Vec2();
                }
                else
                {
                    _loc_17 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_17.next;
                    _loc_17.next = null;
                }
                _loc_17.weak = false;
                _loc_17._immutable = _loc_21;
                _loc_17.x = _loc_16;
                _loc_17.y = _loc_18;
                _loc_20.zpp_inner = _loc_17;
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
                _loc_17 = _loc_20.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_16 == _loc_16)
                {
                }
                if (_loc_18 != _loc_18)
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
                _loc_17 = _loc_20.zpp_inner;
                if (_loc_17._validate != null)
                {
                    _loc_17._validate();
                }
                if (_loc_20.zpp_inner.x == _loc_16)
                {
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_17 = _loc_20.zpp_inner;
                    if (_loc_17._validate != null)
                    {
                        _loc_17._validate();
                    }
                }
                if (_loc_20.zpp_inner.y != _loc_18)
                {
                    _loc_20.zpp_inner.x = _loc_16;
                    _loc_20.zpp_inner.y = _loc_18;
                    _loc_17 = _loc_20.zpp_inner;
                    if (_loc_17._invalidate != null)
                    {
                        _loc_17._invalidate(_loc_17);
                    }
                }
            }
            _loc_20.zpp_inner.weak = _loc_19;
            var _loc_15:* = _loc_20;
            _loc_16 = _loc_8 * _loc_13 - param5 * _loc_9 * _loc_14;
            _loc_18 = _loc_8 * _loc_14 + param5 * _loc_9 * _loc_13;
            _loc_22 = 0;
            _loc_23 = 0;
            _loc_19 = false;
            if (_loc_22 == _loc_22)
            {
            }
            if (_loc_23 != _loc_23)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_24 = new Vec2();
            }
            else
            {
                _loc_24 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_24.zpp_pool;
                _loc_24.zpp_pool = null;
                _loc_24.zpp_disp = false;
                if (_loc_24 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_24.zpp_inner == null)
            {
                _loc_21 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_17 = new ZPP_Vec2();
                }
                else
                {
                    _loc_17 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_17.next;
                    _loc_17.next = null;
                }
                _loc_17.weak = false;
                _loc_17._immutable = _loc_21;
                _loc_17.x = _loc_22;
                _loc_17.y = _loc_23;
                _loc_24.zpp_inner = _loc_17;
                _loc_24.zpp_inner.outer = _loc_24;
            }
            else
            {
                if (_loc_24 != null)
                {
                }
                if (_loc_24.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_24.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_22 == _loc_22)
                {
                }
                if (_loc_23 != _loc_23)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_24 != null)
                {
                }
                if (_loc_24.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_24.zpp_inner;
                if (_loc_17._validate != null)
                {
                    _loc_17._validate();
                }
                if (_loc_24.zpp_inner.x == _loc_22)
                {
                    if (_loc_24 != null)
                    {
                    }
                    if (_loc_24.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_17 = _loc_24.zpp_inner;
                    if (_loc_17._validate != null)
                    {
                        _loc_17._validate();
                    }
                }
                if (_loc_24.zpp_inner.y != _loc_23)
                {
                    _loc_24.zpp_inner.x = _loc_22;
                    _loc_24.zpp_inner.y = _loc_23;
                    _loc_17 = _loc_24.zpp_inner;
                    if (_loc_17._invalidate != null)
                    {
                        _loc_17._invalidate(_loc_17);
                    }
                }
            }
            _loc_24.zpp_inner.weak = _loc_19;
            _loc_20 = _loc_24;
            _loc_22 = 0;
            _loc_23 = 0;
            _loc_19 = false;
            if (_loc_22 == _loc_22)
            {
            }
            if (_loc_23 != _loc_23)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_25 = new Vec2();
            }
            else
            {
                _loc_25 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_25.zpp_pool;
                _loc_25.zpp_pool = null;
                _loc_25.zpp_disp = false;
                if (_loc_25 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_25.zpp_inner == null)
            {
                _loc_21 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_17 = new ZPP_Vec2();
                }
                else
                {
                    _loc_17 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_17.next;
                    _loc_17.next = null;
                }
                _loc_17.weak = false;
                _loc_17._immutable = _loc_21;
                _loc_17.x = _loc_22;
                _loc_17.y = _loc_23;
                _loc_25.zpp_inner = _loc_17;
                _loc_25.zpp_inner.outer = _loc_25;
            }
            else
            {
                if (_loc_25 != null)
                {
                }
                if (_loc_25.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_25.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_22 == _loc_22)
                {
                }
                if (_loc_23 != _loc_23)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_25 != null)
                {
                }
                if (_loc_25.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_25.zpp_inner;
                if (_loc_17._validate != null)
                {
                    _loc_17._validate();
                }
                if (_loc_25.zpp_inner.x == _loc_22)
                {
                    if (_loc_25 != null)
                    {
                    }
                    if (_loc_25.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_17 = _loc_25.zpp_inner;
                    if (_loc_17._validate != null)
                    {
                        _loc_17._validate();
                    }
                }
                if (_loc_25.zpp_inner.y != _loc_23)
                {
                    _loc_25.zpp_inner.x = _loc_22;
                    _loc_25.zpp_inner.y = _loc_23;
                    _loc_17 = _loc_25.zpp_inner;
                    if (_loc_17._invalidate != null)
                    {
                        _loc_17._invalidate(_loc_17);
                    }
                }
            }
            _loc_25.zpp_inner.weak = _loc_19;
            _loc_24 = _loc_25;
            var _loc_26:* = 0;
            while (_loc_26 < _loc_10)
            {
                
                _loc_26++;
                _loc_27 = _loc_26;
                _loc_22 = param5 + _loc_11;
                _loc_23 = param3 + _loc_12;
                _loc_28 = Math.cos(_loc_23);
                _loc_29 = Math.sin(_loc_23);
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = param2.zpp_inner;
                if (_loc_17._validate != null)
                {
                    _loc_17._validate();
                }
                _loc_30 = param2.zpp_inner.x + _loc_22 * _loc_28;
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = param2.zpp_inner;
                if (_loc_17._validate != null)
                {
                    _loc_17._validate();
                }
                _loc_31 = param2.zpp_inner.y + _loc_22 * _loc_29;
                if (_loc_20 != null)
                {
                }
                if (_loc_20.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_20.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_30 == _loc_30)
                {
                }
                if (_loc_31 != _loc_31)
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
                _loc_17 = _loc_20.zpp_inner;
                if (_loc_17._validate != null)
                {
                    _loc_17._validate();
                }
                if (_loc_20.zpp_inner.x == _loc_30)
                {
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_17 = _loc_20.zpp_inner;
                    if (_loc_17._validate != null)
                    {
                        _loc_17._validate();
                    }
                }
                if (_loc_20.zpp_inner.y != _loc_31)
                {
                    _loc_20.zpp_inner.x = _loc_30;
                    _loc_20.zpp_inner.y = _loc_31;
                    _loc_17 = _loc_20.zpp_inner;
                    if (_loc_17._invalidate != null)
                    {
                        _loc_17._invalidate(_loc_17);
                    }
                }
                _loc_30 = _loc_8 * _loc_28 - _loc_22 * _loc_9 * _loc_29;
                _loc_31 = _loc_8 * _loc_29 + _loc_22 * _loc_9 * _loc_28;
                _loc_32 = _loc_16 * _loc_31 - _loc_18 * _loc_30;
                if (_loc_32 * _loc_32 < Config.epsilon)
                {
                    param1.drawLine(_loc_15, _loc_20, param7);
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
                    _loc_17 = _loc_20.zpp_inner;
                    if (_loc_17._validate != null)
                    {
                        _loc_17._validate();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_17 = _loc_15.zpp_inner;
                    if (_loc_17._validate != null)
                    {
                        _loc_17._validate();
                    }
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_17 = _loc_15.zpp_inner;
                    if (_loc_17._validate != null)
                    {
                        _loc_17._validate();
                    }
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_17 = _loc_20.zpp_inner;
                    if (_loc_17._validate != null)
                    {
                        _loc_17._validate();
                    }
                    _loc_33 = ((_loc_20.zpp_inner.x - _loc_15.zpp_inner.x) * _loc_31 + (_loc_15.zpp_inner.y - _loc_20.zpp_inner.y) * _loc_30) / _loc_32;
                    if (_loc_33 <= 0)
                    {
                        param1.drawLine(_loc_15, _loc_20, param7);
                    }
                    else
                    {
                        if (_loc_15 != null)
                        {
                        }
                        if (_loc_15.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_17 = _loc_15.zpp_inner;
                        if (_loc_17._validate != null)
                        {
                            _loc_17._validate();
                        }
                        _loc_34 = _loc_15.zpp_inner.x + _loc_16 * _loc_33;
                        if (_loc_24 != null)
                        {
                        }
                        if (_loc_24.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_17 = _loc_24.zpp_inner;
                        if (_loc_17._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_17._isimmutable != null)
                        {
                            _loc_17._isimmutable();
                        }
                        if (_loc_24 != null)
                        {
                        }
                        if (_loc_24.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_17 = _loc_24.zpp_inner;
                        if (_loc_17._validate != null)
                        {
                            _loc_17._validate();
                        }
                        if (_loc_24.zpp_inner.x != _loc_34)
                        {
                            if (_loc_34 != _loc_34)
                            {
                                throw "Error: Vec2::" + "x" + " cannot be NaN";
                            }
                            _loc_24.zpp_inner.x = _loc_34;
                            _loc_17 = _loc_24.zpp_inner;
                            if (_loc_17._invalidate != null)
                            {
                                _loc_17._invalidate(_loc_17);
                            }
                        }
                        if (_loc_24 != null)
                        {
                        }
                        if (_loc_24.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_17 = _loc_24.zpp_inner;
                        if (_loc_17._validate != null)
                        {
                            _loc_17._validate();
                        }
                        if (_loc_15 != null)
                        {
                        }
                        if (_loc_15.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_17 = _loc_15.zpp_inner;
                        if (_loc_17._validate != null)
                        {
                            _loc_17._validate();
                        }
                        _loc_34 = _loc_15.zpp_inner.y + _loc_18 * _loc_33;
                        if (_loc_24 != null)
                        {
                        }
                        if (_loc_24.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_17 = _loc_24.zpp_inner;
                        if (_loc_17._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_17._isimmutable != null)
                        {
                            _loc_17._isimmutable();
                        }
                        if (_loc_24 != null)
                        {
                        }
                        if (_loc_24.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_17 = _loc_24.zpp_inner;
                        if (_loc_17._validate != null)
                        {
                            _loc_17._validate();
                        }
                        if (_loc_24.zpp_inner.y != _loc_34)
                        {
                            if (_loc_34 != _loc_34)
                            {
                                throw "Error: Vec2::" + "y" + " cannot be NaN";
                            }
                            _loc_24.zpp_inner.y = _loc_34;
                            _loc_17 = _loc_24.zpp_inner;
                            if (_loc_17._invalidate != null)
                            {
                                _loc_17._invalidate(_loc_17);
                            }
                        }
                        if (_loc_24 != null)
                        {
                        }
                        if (_loc_24.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_17 = _loc_24.zpp_inner;
                        if (_loc_17._validate != null)
                        {
                            _loc_17._validate();
                        }
                        param1.drawCurve(_loc_15, _loc_24, _loc_20, param7);
                    }
                }
                param5 = _loc_22;
                param3 = _loc_23;
                _loc_13 = _loc_28;
                _loc_14 = _loc_29;
                _loc_16 = _loc_30;
                _loc_18 = _loc_31;
                if (_loc_15 != null)
                {
                }
                if (_loc_15.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (_loc_20 != null)
                {
                }
                if (_loc_20.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_15.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_20 == null)
                {
                    throw "Error: Cannot assign null Vec2";
                }
                if (_loc_20 != null)
                {
                }
                if (_loc_20.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_20.zpp_inner;
                if (_loc_17._validate != null)
                {
                    _loc_17._validate();
                }
                _loc_33 = _loc_20.zpp_inner.x;
                if (_loc_20 != null)
                {
                }
                if (_loc_20.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_20.zpp_inner;
                if (_loc_17._validate != null)
                {
                    _loc_17._validate();
                }
                _loc_34 = _loc_20.zpp_inner.y;
                if (_loc_15 != null)
                {
                }
                if (_loc_15.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_15.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_33 == _loc_33)
                {
                }
                if (_loc_34 != _loc_34)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_15 != null)
                {
                }
                if (_loc_15.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_15.zpp_inner;
                if (_loc_17._validate != null)
                {
                    _loc_17._validate();
                }
                if (_loc_15.zpp_inner.x == _loc_33)
                {
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_17 = _loc_15.zpp_inner;
                    if (_loc_17._validate != null)
                    {
                        _loc_17._validate();
                    }
                }
                if (_loc_15.zpp_inner.y != _loc_34)
                {
                    _loc_15.zpp_inner.x = _loc_33;
                    _loc_15.zpp_inner.y = _loc_34;
                    _loc_17 = _loc_15.zpp_inner;
                    if (_loc_17._invalidate != null)
                    {
                        _loc_17._invalidate(_loc_17);
                    }
                }
                _loc_25 = _loc_15;
                if (_loc_20.zpp_inner.weak)
                {
                    if (_loc_20 != null)
                    {
                    }
                    if (_loc_20.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_17 = _loc_20.zpp_inner;
                    if (_loc_17._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_17._isimmutable != null)
                    {
                        _loc_17._isimmutable();
                    }
                    if (_loc_20.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_17 = _loc_20.zpp_inner;
                    _loc_20.zpp_inner.outer = null;
                    _loc_20.zpp_inner = null;
                    _loc_35 = _loc_20;
                    _loc_35.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_35;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_35;
                    }
                    ZPP_PubPool.nextVec2 = _loc_35;
                    _loc_35.zpp_disp = true;
                    _loc_36 = _loc_17;
                    if (_loc_36.outer != null)
                    {
                        _loc_36.outer.zpp_inner = null;
                        _loc_36.outer = null;
                    }
                    _loc_36._isimmutable = null;
                    _loc_36._validate = null;
                    _loc_36._invalidate = null;
                    _loc_36.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_36;
                    continue;
                }
            }
            if (_loc_15 != null)
            {
            }
            if (_loc_15.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_17 = _loc_15.zpp_inner;
            if (_loc_17._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_17._isimmutable != null)
            {
                _loc_17._isimmutable();
            }
            if (_loc_15.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_17 = _loc_15.zpp_inner;
            _loc_15.zpp_inner.outer = null;
            _loc_15.zpp_inner = null;
            _loc_25 = _loc_15;
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
            _loc_36 = _loc_17;
            if (_loc_36.outer != null)
            {
                _loc_36.outer.zpp_inner = null;
                _loc_36.outer = null;
            }
            _loc_36._isimmutable = null;
            _loc_36._validate = null;
            _loc_36._invalidate = null;
            _loc_36.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_36;
            if (_loc_20 != null)
            {
            }
            if (_loc_20.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_17 = _loc_20.zpp_inner;
            if (_loc_17._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_17._isimmutable != null)
            {
                _loc_17._isimmutable();
            }
            if (_loc_20.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_17 = _loc_20.zpp_inner;
            _loc_20.zpp_inner.outer = null;
            _loc_20.zpp_inner = null;
            _loc_25 = _loc_20;
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
            _loc_36 = _loc_17;
            if (_loc_36.outer != null)
            {
                _loc_36.outer.zpp_inner = null;
                _loc_36.outer = null;
            }
            _loc_36._isimmutable = null;
            _loc_36._validate = null;
            _loc_36._invalidate = null;
            _loc_36.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_36;
            if (_loc_24 != null)
            {
            }
            if (_loc_24.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_17 = _loc_24.zpp_inner;
            if (_loc_17._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_17._isimmutable != null)
            {
                _loc_17._isimmutable();
            }
            if (_loc_24.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_17 = _loc_24.zpp_inner;
            _loc_24.zpp_inner.outer = null;
            _loc_24.zpp_inner = null;
            _loc_25 = _loc_24;
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
            _loc_36 = _loc_17;
            if (_loc_36.outer != null)
            {
                _loc_36.outer.zpp_inner = null;
                _loc_36.outer = null;
            }
            _loc_36._isimmutable = null;
            _loc_36._validate = null;
            _loc_36._invalidate = null;
            _loc_36.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_36;
            return;
        }// end function

    }
}
