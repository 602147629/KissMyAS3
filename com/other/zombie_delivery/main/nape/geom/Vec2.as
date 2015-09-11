package nape.geom
{
    import flash.*;
    import flash.geom.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    final public class Vec2 extends Object
    {
        public var zpp_pool:Vec2;
        public var zpp_inner:ZPP_Vec2;
        public var zpp_disp:Boolean;

        public function Vec2(param1:Number = 0, param2:Number = 0) : void
        {
            var _loc_4:* = null as ZPP_Vec2;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_pool = null;
            zpp_inner = null;
            if (param1 == param1)
            {
            }
            if (param2 != param2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            var _loc_3:* = false;
            if (ZPP_Vec2.zpp_pool == null)
            {
                _loc_4 = new ZPP_Vec2();
            }
            else
            {
                _loc_4 = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_4.next;
                _loc_4.next = null;
            }
            _loc_4.weak = false;
            _loc_4._immutable = _loc_3;
            _loc_4.x = param1;
            _loc_4.y = param2;
            zpp_inner = _loc_4;
            zpp_inner.outer = this;
            return;
        }// end function

        public function unit(param1:Boolean = false) : Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = false;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (Math.sqrt(zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y) == 0)
            {
                throw "Error: Cannot normalise vector of length 0";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_4:* = zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y;
            var _loc_3:* = 0 / (_loc_4 == 0 ? (_loc_5) : (_loc_5 = 1597463007 - (0 >> 1), _loc_6 = 0, 0 / (_loc_6 * (1.5 - 0.5 * _loc_4 * _loc_6 * _loc_6))));
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_4 = zpp_inner.x * _loc_3;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_6 = zpp_inner.y * _loc_3;
            if (_loc_4 == _loc_4)
            {
            }
            if (_loc_6 != _loc_6)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_7 = new Vec2();
            }
            else
            {
                _loc_7 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_7.zpp_pool;
                _loc_7.zpp_pool = null;
                _loc_7.zpp_disp = false;
                if (_loc_7 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_7.zpp_inner == null)
            {
                _loc_8 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_2 = new ZPP_Vec2();
                }
                else
                {
                    _loc_2 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_2.next;
                    _loc_2.next = null;
                }
                _loc_2.weak = false;
                _loc_2._immutable = _loc_8;
                _loc_2.x = _loc_4;
                _loc_2.y = _loc_6;
                _loc_7.zpp_inner = _loc_2;
                _loc_7.zpp_inner.outer = _loc_7;
            }
            else
            {
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = _loc_7.zpp_inner;
                if (_loc_2._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_2._isimmutable != null)
                {
                    _loc_2._isimmutable();
                }
                if (_loc_4 == _loc_4)
                {
                }
                if (_loc_6 != _loc_6)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = _loc_7.zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
                if (_loc_7.zpp_inner.x == _loc_4)
                {
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_2 = _loc_7.zpp_inner;
                    if (_loc_2._validate != null)
                    {
                        _loc_2._validate();
                    }
                }
                if (_loc_7.zpp_inner.y != _loc_6)
                {
                    _loc_7.zpp_inner.x = _loc_4;
                    _loc_7.zpp_inner.y = _loc_6;
                    _loc_2 = _loc_7.zpp_inner;
                    if (_loc_2._invalidate != null)
                    {
                        _loc_2._invalidate(_loc_2);
                    }
                }
            }
            _loc_7.zpp_inner.weak = param1;
            return _loc_7;
        }// end function

        public function toString() : String
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.toString();
        }// end function

        public function toPoint(param1:Point = undefined) : Point
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                param1 = new Point();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_2:* = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            param1.x = zpp_inner.x;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            param1.y = zpp_inner.y;
            return param1;
        }// end function

        public function subeq(param1:Vec2) : Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (param1 == null)
            {
                throw "Error: Cannot subtract null vectors";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = param1.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_3:* = zpp_inner.x - param1.zpp_inner.x;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = param1.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_4:* = zpp_inner.y - param1.zpp_inner.y;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (_loc_3 == _loc_3)
            {
            }
            if (_loc_4 != _loc_4)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.x == _loc_3)
            {
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
            }
            if (zpp_inner.y != _loc_4)
            {
                zpp_inner.x = _loc_3;
                zpp_inner.y = _loc_4;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
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
                _loc_2 = param1.zpp_inner;
                if (_loc_2._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_2._isimmutable != null)
                {
                    _loc_2._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_2 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_5 = param1;
                _loc_5.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_5;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_5;
                }
                ZPP_PubPool.nextVec2 = _loc_5;
                _loc_5.zpp_disp = true;
                _loc_6 = _loc_2;
                if (_loc_6.outer != null)
                {
                    _loc_6.outer.zpp_inner = null;
                    _loc_6.outer = null;
                }
                _loc_6._isimmutable = null;
                _loc_6._validate = null;
                _loc_6._invalidate = null;
                _loc_6.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_6;
            }
            else
            {
            }
            return this;
        }// end function

        public function sub(param1:Vec2, param2:Boolean = false) : Vec2
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = false;
            var _loc_9:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
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
                throw "Error: Cannot subtract null vectors";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = zpp_inner;
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
            var _loc_4:* = zpp_inner.x - param1.zpp_inner.x;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = zpp_inner;
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
            var _loc_6:* = zpp_inner.y - param1.zpp_inner.y;
            if (_loc_4 == _loc_4)
            {
            }
            if (_loc_6 != _loc_6)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_7 = new Vec2();
            }
            else
            {
                _loc_7 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_7.zpp_pool;
                _loc_7.zpp_pool = null;
                _loc_7.zpp_disp = false;
                if (_loc_7 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_7.zpp_inner == null)
            {
                _loc_8 = false;
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
                _loc_5._immutable = _loc_8;
                _loc_5.x = _loc_4;
                _loc_5.y = _loc_6;
                _loc_7.zpp_inner = _loc_5;
                _loc_7.zpp_inner.outer = _loc_7;
            }
            else
            {
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_7.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_4 == _loc_4)
                {
                }
                if (_loc_6 != _loc_6)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_7.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                if (_loc_7.zpp_inner.x == _loc_4)
                {
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_7.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                }
                if (_loc_7.zpp_inner.y != _loc_6)
                {
                    _loc_7.zpp_inner.x = _loc_4;
                    _loc_7.zpp_inner.y = _loc_6;
                    _loc_5 = _loc_7.zpp_inner;
                    if (_loc_5._invalidate != null)
                    {
                        _loc_5._invalidate(_loc_5);
                    }
                }
            }
            _loc_7.zpp_inner.weak = param2;
            var _loc_3:* = _loc_7;
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
            return _loc_3;
        }// end function

        public function setxy(param1:Number, param2:Number) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_3._isimmutable != null)
            {
                _loc_3._isimmutable();
            }
            if (param1 == param1)
            {
            }
            if (param2 != param2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (zpp_inner.x == param1)
            {
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = zpp_inner;
                if (_loc_3._validate != null)
                {
                    _loc_3._validate();
                }
            }
            if (zpp_inner.y != param2)
            {
                zpp_inner.x = param1;
                zpp_inner.y = param2;
                _loc_3 = zpp_inner;
                if (_loc_3._invalidate != null)
                {
                    _loc_3._invalidate(_loc_3);
                }
            }
            return this;
        }// end function

        public function set_y(param1:Number) : Number
        {
            var _loc_2:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.y != param1)
            {
                if (param1 != param1)
                {
                    throw "Error: Vec2::" + "y" + " cannot be NaN";
                }
                zpp_inner.y = param1;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            return zpp_inner.y;
        }// end function

        public function set_x(param1:Number) : Number
        {
            var _loc_2:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.x != param1)
            {
                if (param1 != param1)
                {
                    throw "Error: Vec2::" + "x" + " cannot be NaN";
                }
                zpp_inner.x = param1;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            return zpp_inner.x;
        }// end function

        public function set_length(param1:Number) : Number
        {
            var _loc_2:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (param1 != param1)
            {
                throw "Error: Vec2::length cannot be NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y == 0)
            {
                throw "Error: Cannot set length of a zero vector";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_3:* = param1 / Math.sqrt(zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y);
            var _loc_4:* = this;
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_4.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_5:* = _loc_4.zpp_inner.x * _loc_3;
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_4.zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_4.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (_loc_4.zpp_inner.x != _loc_5)
            {
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Vec2::" + "x" + " cannot be NaN";
                }
                _loc_4.zpp_inner.x = _loc_5;
                _loc_2 = _loc_4.zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_4.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_4 = this;
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_4.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_5 = _loc_4.zpp_inner.y * _loc_3;
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_4.zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_4.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (_loc_4.zpp_inner.y != _loc_5)
            {
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Vec2::" + "y" + " cannot be NaN";
                }
                _loc_4.zpp_inner.y = _loc_5;
                _loc_2 = _loc_4.zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_4.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_2 = zpp_inner;
            if (_loc_2._invalidate != null)
            {
                _loc_2._invalidate(_loc_2);
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            return Math.sqrt(zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y);
        }// end function

        public function set_angle(param1:Number) : Number
        {
            var _loc_2:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (param1 != param1)
            {
                throw "Error: Vec2::angle cannot be NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_3:* = Math.sqrt(zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y);
            var _loc_4:* = _loc_3 * Math.cos(param1);
            var _loc_5:* = _loc_3 * Math.sin(param1);
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (_loc_4 == _loc_4)
            {
            }
            if (_loc_5 != _loc_5)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.x == _loc_4)
            {
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
            }
            if (zpp_inner.y != _loc_5)
            {
                zpp_inner.x = _loc_4;
                zpp_inner.y = _loc_5;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.x == zpp_inner.y)
            {
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
            }
            if (zpp_inner.x == 0)
            {
                return 0;
            }
            else
            {
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
                return Math.atan2(zpp_inner.y, zpp_inner.x);
            }
        }// end function

        public function set(param1:Vec2) : Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (param1 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = param1.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_4:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = param1.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_5:* = param1.zpp_inner.y;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (_loc_4 == _loc_4)
            {
            }
            if (_loc_5 != _loc_5)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.x == _loc_4)
            {
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
            }
            if (zpp_inner.y != _loc_5)
            {
                zpp_inner.x = _loc_4;
                zpp_inner.y = _loc_5;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            var _loc_3:* = this;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = param1.zpp_inner;
                if (_loc_2._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_2._isimmutable != null)
                {
                    _loc_2._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_2 = param1.zpp_inner;
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
                _loc_7 = _loc_2;
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
            return _loc_3;
        }// end function

        public function rotate(param1:Number) : Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (param1 != param1)
            {
                throw "Error: Cannot rotate Vec2 by NaN";
            }
            if (param1 % (Math.PI * 2) != 0)
            {
                _loc_3 = Math.sin(param1);
                _loc_4 = Math.cos(param1);
                _loc_5 = _loc_4 * zpp_inner.x - _loc_3 * zpp_inner.y;
                zpp_inner.y = zpp_inner.x * _loc_3 + zpp_inner.y * _loc_4;
                zpp_inner.x = _loc_5;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            return this;
        }// end function

        public function reflect(param1:Vec2, param2:Boolean = false) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = false;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (Math.sqrt(zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y) == 0)
            {
                throw "Error: Cannot reflect in zero vector";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_5:* = zpp_inner.x;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_6:* = zpp_inner.y;
            if (_loc_5 == _loc_5)
            {
            }
            if (_loc_6 != _loc_6)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_7 = new Vec2();
            }
            else
            {
                _loc_7 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_7.zpp_pool;
                _loc_7.zpp_pool = null;
                _loc_7.zpp_disp = false;
                if (_loc_7 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_7.zpp_inner == null)
            {
                _loc_8 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_3 = new ZPP_Vec2();
                }
                else
                {
                    _loc_3 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_3.next;
                    _loc_3.next = null;
                }
                _loc_3.weak = false;
                _loc_3._immutable = _loc_8;
                _loc_3.x = _loc_5;
                _loc_3.y = _loc_6;
                _loc_7.zpp_inner = _loc_3;
                _loc_7.zpp_inner.outer = _loc_7;
            }
            else
            {
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = _loc_7.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (_loc_5 == _loc_5)
                {
                }
                if (_loc_6 != _loc_6)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = _loc_7.zpp_inner;
                if (_loc_3._validate != null)
                {
                    _loc_3._validate();
                }
                if (_loc_7.zpp_inner.x == _loc_5)
                {
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_3 = _loc_7.zpp_inner;
                    if (_loc_3._validate != null)
                    {
                        _loc_3._validate();
                    }
                }
                if (_loc_7.zpp_inner.y != _loc_6)
                {
                    _loc_7.zpp_inner.x = _loc_5;
                    _loc_7.zpp_inner.y = _loc_6;
                    _loc_3 = _loc_7.zpp_inner;
                    if (_loc_3._invalidate != null)
                    {
                        _loc_3._invalidate(_loc_3);
                    }
                }
            }
            _loc_7.zpp_inner.weak = true;
            var _loc_4:* = _loc_7.normalise();
            _loc_7 = param1.sub(_loc_4.muleq(2 * _loc_4.dot(param1)), param2);
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = param1.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_3 = param1.zpp_inner;
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
                _loc_10 = _loc_3;
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
            return _loc_7;
        }// end function

        public function perp(param1:Boolean = false) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = false;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_2:* = -zpp_inner.y;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_4:* = zpp_inner.x;
            if (_loc_2 == _loc_2)
            {
            }
            if (_loc_4 != _loc_4)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_5 = new Vec2();
            }
            else
            {
                _loc_5 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_5.zpp_pool;
                _loc_5.zpp_pool = null;
                _loc_5.zpp_disp = false;
                if (_loc_5 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_5.zpp_inner == null)
            {
                _loc_6 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_3 = new ZPP_Vec2();
                }
                else
                {
                    _loc_3 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_3.next;
                    _loc_3.next = null;
                }
                _loc_3.weak = false;
                _loc_3._immutable = _loc_6;
                _loc_3.x = _loc_2;
                _loc_3.y = _loc_4;
                _loc_5.zpp_inner = _loc_3;
                _loc_5.zpp_inner.outer = _loc_5;
            }
            else
            {
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = _loc_5.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (_loc_2 == _loc_2)
                {
                }
                if (_loc_4 != _loc_4)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = _loc_5.zpp_inner;
                if (_loc_3._validate != null)
                {
                    _loc_3._validate();
                }
                if (_loc_5.zpp_inner.x == _loc_2)
                {
                    if (_loc_5 != null)
                    {
                    }
                    if (_loc_5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_3 = _loc_5.zpp_inner;
                    if (_loc_3._validate != null)
                    {
                        _loc_3._validate();
                    }
                }
                if (_loc_5.zpp_inner.y != _loc_4)
                {
                    _loc_5.zpp_inner.x = _loc_2;
                    _loc_5.zpp_inner.y = _loc_4;
                    _loc_3 = _loc_5.zpp_inner;
                    if (_loc_3._invalidate != null)
                    {
                        _loc_3._invalidate(_loc_3);
                    }
                }
            }
            _loc_5.zpp_inner.weak = param1;
            return _loc_5;
        }// end function

        public function normalise() : Vec2
        {
            var _loc_1:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_1._isimmutable != null)
            {
                _loc_1._isimmutable();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (Math.sqrt(zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y) == 0)
            {
                throw "Error: Cannot normalise vector of length 0";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            var _loc_2:* = zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y;
            var _loc_3:* = 1 / Math.sqrt(_loc_2);
            var _loc_4:* = _loc_3;
            var _loc_5:* = this;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = _loc_5.zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            var _loc_6:* = _loc_5.zpp_inner.x * _loc_4;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = _loc_5.zpp_inner;
            if (_loc_1._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_1._isimmutable != null)
            {
                _loc_1._isimmutable();
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = _loc_5.zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (_loc_5.zpp_inner.x != _loc_6)
            {
                if (_loc_6 != _loc_6)
                {
                    throw "Error: Vec2::" + "x" + " cannot be NaN";
                }
                _loc_5.zpp_inner.x = _loc_6;
                _loc_1 = _loc_5.zpp_inner;
                if (_loc_1._invalidate != null)
                {
                    _loc_1._invalidate(_loc_1);
                }
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = _loc_5.zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            _loc_5 = this;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = _loc_5.zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            _loc_6 = _loc_5.zpp_inner.y * _loc_4;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = _loc_5.zpp_inner;
            if (_loc_1._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_1._isimmutable != null)
            {
                _loc_1._isimmutable();
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = _loc_5.zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (_loc_5.zpp_inner.y != _loc_6)
            {
                if (_loc_6 != _loc_6)
                {
                    throw "Error: Vec2::" + "y" + " cannot be NaN";
                }
                _loc_5.zpp_inner.y = _loc_6;
                _loc_1 = _loc_5.zpp_inner;
                if (_loc_1._invalidate != null)
                {
                    _loc_1._invalidate(_loc_1);
                }
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = _loc_5.zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            _loc_1 = zpp_inner;
            if (_loc_1._invalidate != null)
            {
                _loc_1._invalidate(_loc_1);
            }
            return this;
        }// end function

        public function muleq(param1:Number) : Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (param1 != param1)
            {
                throw "Error: Cannot multiply with NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_3:* = zpp_inner.x * param1;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_4:* = zpp_inner.y * param1;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (_loc_3 == _loc_3)
            {
            }
            if (_loc_4 != _loc_4)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.x == _loc_3)
            {
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
            }
            if (zpp_inner.y != _loc_4)
            {
                zpp_inner.x = _loc_3;
                zpp_inner.y = _loc_4;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            return this;
        }// end function

        public function mul(param1:Number, param2:Boolean = false) : Vec2
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = false;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 != param1)
            {
                throw "Error: Cannot multiply with NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_3:* = zpp_inner.x * param1;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_5:* = zpp_inner.y * param1;
            if (_loc_3 == _loc_3)
            {
            }
            if (_loc_5 != _loc_5)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_6 = new Vec2();
            }
            else
            {
                _loc_6 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_6.zpp_pool;
                _loc_6.zpp_pool = null;
                _loc_6.zpp_disp = false;
                if (_loc_6 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_6.zpp_inner == null)
            {
                _loc_7 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_4 = new ZPP_Vec2();
                }
                else
                {
                    _loc_4 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_4.next;
                    _loc_4.next = null;
                }
                _loc_4.weak = false;
                _loc_4._immutable = _loc_7;
                _loc_4.x = _loc_3;
                _loc_4.y = _loc_5;
                _loc_6.zpp_inner = _loc_4;
                _loc_6.zpp_inner.outer = _loc_6;
            }
            else
            {
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_6.zpp_inner;
                if (_loc_4._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_4._isimmutable != null)
                {
                    _loc_4._isimmutable();
                }
                if (_loc_3 == _loc_3)
                {
                }
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_6.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                if (_loc_6.zpp_inner.x == _loc_3)
                {
                    if (_loc_6 != null)
                    {
                    }
                    if (_loc_6.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_4 = _loc_6.zpp_inner;
                    if (_loc_4._validate != null)
                    {
                        _loc_4._validate();
                    }
                }
                if (_loc_6.zpp_inner.y != _loc_5)
                {
                    _loc_6.zpp_inner.x = _loc_3;
                    _loc_6.zpp_inner.y = _loc_5;
                    _loc_4 = _loc_6.zpp_inner;
                    if (_loc_4._invalidate != null)
                    {
                        _loc_4._invalidate(_loc_4);
                    }
                }
            }
            _loc_6.zpp_inner.weak = param2;
            return _loc_6;
        }// end function

        public function lsq() : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y;
        }// end function

        public function get_y() : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.y;
        }// end function

        public function get_x() : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.x;
        }// end function

        public function get_length() : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return Math.sqrt(zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y);
        }// end function

        public function get_angle() : Number
        {
            var _loc_1:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_inner.x == zpp_inner.y)
            {
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_1 = zpp_inner;
                if (_loc_1._validate != null)
                {
                    _loc_1._validate();
                }
            }
            if (zpp_inner.x == 0)
            {
                return 0;
            }
            else
            {
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_1 = zpp_inner;
                if (_loc_1._validate != null)
                {
                    _loc_1._validate();
                }
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_1 = zpp_inner;
                if (_loc_1._validate != null)
                {
                    _loc_1._validate();
                }
                return Math.atan2(zpp_inner.y, zpp_inner.x);
            }
        }// end function

        public function dot(param1:Vec2) : Number
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
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
                throw "Error: Cannot take dot product with null vector";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_2:* = zpp_inner.x * param1.zpp_inner.x + zpp_inner.y * param1.zpp_inner.y;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = param1.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_3 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_4 = param1;
                _loc_4.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_4;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_4;
                }
                ZPP_PubPool.nextVec2 = _loc_4;
                _loc_4.zpp_disp = true;
                _loc_5 = _loc_3;
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
            }
            else
            {
            }
            return _loc_2;
        }// end function

        public function dispose() : void
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_1._isimmutable != null)
            {
                _loc_1._isimmutable();
            }
            if (zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_1 = zpp_inner;
            zpp_inner.outer = null;
            zpp_inner = null;
            var _loc_2:* = this;
            _loc_2.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_2;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_2;
            }
            ZPP_PubPool.nextVec2 = _loc_2;
            _loc_2.zpp_disp = true;
            var _loc_3:* = _loc_1;
            if (_loc_3.outer != null)
            {
                _loc_3.outer.zpp_inner = null;
                _loc_3.outer = null;
            }
            _loc_3._isimmutable = null;
            _loc_3._validate = null;
            _loc_3._invalidate = null;
            _loc_3.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_3;
            return;
        }// end function

        public function cross(param1:Vec2) : Number
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
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
                throw "Error: Cannot take cross product with null vector";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_2:* = param1.zpp_inner.y * zpp_inner.x - param1.zpp_inner.x * zpp_inner.y;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = param1.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_3 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_4 = param1;
                _loc_4.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_4;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_4;
                }
                ZPP_PubPool.nextVec2 = _loc_4;
                _loc_4.zpp_disp = true;
                _loc_5 = _loc_3;
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
            }
            else
            {
            }
            return _loc_2;
        }// end function

        public function copy(param1:Boolean = false) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = false;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_2:* = zpp_inner.x;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_4:* = zpp_inner.y;
            if (_loc_2 == _loc_2)
            {
            }
            if (_loc_4 != _loc_4)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_5 = new Vec2();
            }
            else
            {
                _loc_5 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_5.zpp_pool;
                _loc_5.zpp_pool = null;
                _loc_5.zpp_disp = false;
                if (_loc_5 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_5.zpp_inner == null)
            {
                _loc_6 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_3 = new ZPP_Vec2();
                }
                else
                {
                    _loc_3 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_3.next;
                    _loc_3.next = null;
                }
                _loc_3.weak = false;
                _loc_3._immutable = _loc_6;
                _loc_3.x = _loc_2;
                _loc_3.y = _loc_4;
                _loc_5.zpp_inner = _loc_3;
                _loc_5.zpp_inner.outer = _loc_5;
            }
            else
            {
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = _loc_5.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (_loc_2 == _loc_2)
                {
                }
                if (_loc_4 != _loc_4)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = _loc_5.zpp_inner;
                if (_loc_3._validate != null)
                {
                    _loc_3._validate();
                }
                if (_loc_5.zpp_inner.x == _loc_2)
                {
                    if (_loc_5 != null)
                    {
                    }
                    if (_loc_5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_3 = _loc_5.zpp_inner;
                    if (_loc_3._validate != null)
                    {
                        _loc_3._validate();
                    }
                }
                if (_loc_5.zpp_inner.y != _loc_4)
                {
                    _loc_5.zpp_inner.x = _loc_2;
                    _loc_5.zpp_inner.y = _loc_4;
                    _loc_3 = _loc_5.zpp_inner;
                    if (_loc_3._invalidate != null)
                    {
                        _loc_3._invalidate(_loc_3);
                    }
                }
            }
            _loc_5.zpp_inner.weak = param1;
            return _loc_5;
        }// end function

        public function addeq(param1:Vec2) : Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (param1 == null)
            {
                throw "Error: Cannot add null vectors";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = param1.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_3:* = zpp_inner.x + param1.zpp_inner.x;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = param1.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_4:* = zpp_inner.y + param1.zpp_inner.y;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (_loc_3 == _loc_3)
            {
            }
            if (_loc_4 != _loc_4)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.x == _loc_3)
            {
                if (zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
            }
            if (zpp_inner.y != _loc_4)
            {
                zpp_inner.x = _loc_3;
                zpp_inner.y = _loc_4;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
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
                _loc_2 = param1.zpp_inner;
                if (_loc_2._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_2._isimmutable != null)
                {
                    _loc_2._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_2 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_5 = param1;
                _loc_5.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_5;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_5;
                }
                ZPP_PubPool.nextVec2 = _loc_5;
                _loc_5.zpp_disp = true;
                _loc_6 = _loc_2;
                if (_loc_6.outer != null)
                {
                    _loc_6.outer.zpp_inner = null;
                    _loc_6.outer = null;
                }
                _loc_6._isimmutable = null;
                _loc_6._validate = null;
                _loc_6._invalidate = null;
                _loc_6.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_6;
            }
            else
            {
            }
            return this;
        }// end function

        public function addMul(param1:Vec2, param2:Number, param3:Boolean = false) : Vec2
        {
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = false;
            var _loc_10:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
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
                throw "Error: Cannot add null vectors";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = zpp_inner;
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
            var _loc_5:* = zpp_inner.x + param1.zpp_inner.x * param2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = zpp_inner;
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
            var _loc_7:* = zpp_inner.y + param1.zpp_inner.y * param2;
            if (_loc_5 == _loc_5)
            {
            }
            if (_loc_7 != _loc_7)
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
                    _loc_6 = new ZPP_Vec2();
                }
                else
                {
                    _loc_6 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_6.next;
                    _loc_6.next = null;
                }
                _loc_6.weak = false;
                _loc_6._immutable = _loc_9;
                _loc_6.x = _loc_5;
                _loc_6.y = _loc_7;
                _loc_8.zpp_inner = _loc_6;
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
                _loc_6 = _loc_8.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_5 == _loc_5)
                {
                }
                if (_loc_7 != _loc_7)
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
                _loc_6 = _loc_8.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
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
                    _loc_6 = _loc_8.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_8.zpp_inner.y != _loc_7)
                {
                    _loc_8.zpp_inner.x = _loc_5;
                    _loc_8.zpp_inner.y = _loc_7;
                    _loc_6 = _loc_8.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_8.zpp_inner.weak = param3;
            var _loc_4:* = _loc_8;
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
                _loc_10 = _loc_6;
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
            return _loc_4;
        }// end function

        public function add(param1:Vec2, param2:Boolean = false) : Vec2
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = false;
            var _loc_9:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
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
                throw "Error: Cannot add null vectors";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = zpp_inner;
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
            var _loc_4:* = zpp_inner.x + param1.zpp_inner.x;
            if (zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = zpp_inner;
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
            var _loc_6:* = zpp_inner.y + param1.zpp_inner.y;
            if (_loc_4 == _loc_4)
            {
            }
            if (_loc_6 != _loc_6)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_7 = new Vec2();
            }
            else
            {
                _loc_7 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_7.zpp_pool;
                _loc_7.zpp_pool = null;
                _loc_7.zpp_disp = false;
                if (_loc_7 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_7.zpp_inner == null)
            {
                _loc_8 = false;
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
                _loc_5._immutable = _loc_8;
                _loc_5.x = _loc_4;
                _loc_5.y = _loc_6;
                _loc_7.zpp_inner = _loc_5;
                _loc_7.zpp_inner.outer = _loc_7;
            }
            else
            {
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_7.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_4 == _loc_4)
                {
                }
                if (_loc_6 != _loc_6)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_7.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                if (_loc_7.zpp_inner.x == _loc_4)
                {
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_7.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                }
                if (_loc_7.zpp_inner.y != _loc_6)
                {
                    _loc_7.zpp_inner.x = _loc_4;
                    _loc_7.zpp_inner.y = _loc_6;
                    _loc_5 = _loc_7.zpp_inner;
                    if (_loc_5._invalidate != null)
                    {
                        _loc_5._invalidate(_loc_5);
                    }
                }
            }
            _loc_7.zpp_inner.weak = param2;
            var _loc_3:* = _loc_7;
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
            return _loc_3;
        }// end function

        public static function weak(param1:Number = 0, param2:Number = 0) : Vec2
        {
            var _loc_3:* = null as Vec2;
            var _loc_4:* = false;
            var _loc_5:* = null as ZPP_Vec2;
            if (param1 == param1)
            {
            }
            if (param2 != param2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_3 = new Vec2();
            }
            else
            {
                _loc_3 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_3.zpp_pool;
                _loc_3.zpp_pool = null;
                _loc_3.zpp_disp = false;
                if (_loc_3 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_3.zpp_inner == null)
            {
                _loc_4 = false;
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
                _loc_5._immutable = _loc_4;
                _loc_5.x = param1;
                _loc_5.y = param2;
                _loc_3.zpp_inner = _loc_5;
                _loc_3.zpp_inner.outer = _loc_3;
            }
            else
            {
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_3.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (param1 == param1)
                {
                }
                if (param2 != param2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_3.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                if (_loc_3.zpp_inner.x == param1)
                {
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                }
                if (_loc_3.zpp_inner.y != param2)
                {
                    _loc_3.zpp_inner.x = param1;
                    _loc_3.zpp_inner.y = param2;
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._invalidate != null)
                    {
                        _loc_5._invalidate(_loc_5);
                    }
                }
            }
            _loc_3.zpp_inner.weak = true;
            return _loc_3;
        }// end function

        public static function get(param1:Number = 0, param2:Number = 0, param3:Boolean = false) : Vec2
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            if (param1 == param1)
            {
            }
            if (param2 != param2)
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
                _loc_6.x = param1;
                _loc_6.y = param2;
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
                if (param1 == param1)
                {
                }
                if (param2 != param2)
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
                if (_loc_4.zpp_inner.x == param1)
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
                if (_loc_4.zpp_inner.y != param2)
                {
                    _loc_4.zpp_inner.x = param1;
                    _loc_4.zpp_inner.y = param2;
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_4.zpp_inner.weak = param3;
            return _loc_4;
        }// end function

        public static function fromPoint(param1:Point, param2:Boolean = false) : Vec2
        {
            var _loc_5:* = null as Vec2;
            var _loc_6:* = false;
            var _loc_7:* = null as ZPP_Vec2;
            if (param1 == null)
            {
                throw "Error: Cannot create Vec2 from null Point object";
            }
            if (param1.x == param1.x)
            {
            }
            if (param1.y != param1.y)
            {
                throw "Error: Error: Vec2 components cannot be NaN";
            }
            var _loc_3:* = param1.x;
            var _loc_4:* = param1.y;
            if (_loc_3 == _loc_3)
            {
            }
            if (_loc_4 != _loc_4)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_5 = new Vec2();
            }
            else
            {
                _loc_5 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_5.zpp_pool;
                _loc_5.zpp_pool = null;
                _loc_5.zpp_disp = false;
                if (_loc_5 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_5.zpp_inner == null)
            {
                _loc_6 = false;
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
                _loc_7._immutable = _loc_6;
                _loc_7.x = _loc_3;
                _loc_7.y = _loc_4;
                _loc_5.zpp_inner = _loc_7;
                _loc_5.zpp_inner.outer = _loc_5;
            }
            else
            {
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_5.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_3 == _loc_3)
                {
                }
                if (_loc_4 != _loc_4)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_5.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                if (_loc_5.zpp_inner.x == _loc_3)
                {
                    if (_loc_5 != null)
                    {
                    }
                    if (_loc_5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_5.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                }
                if (_loc_5.zpp_inner.y != _loc_4)
                {
                    _loc_5.zpp_inner.x = _loc_3;
                    _loc_5.zpp_inner.y = _loc_4;
                    _loc_7 = _loc_5.zpp_inner;
                    if (_loc_7._invalidate != null)
                    {
                        _loc_7._invalidate(_loc_7);
                    }
                }
            }
            _loc_5.zpp_inner.weak = param2;
            return _loc_5;
        }// end function

        public static function fromPolar(param1:Number, param2:Number, param3:Boolean = false) : Vec2
        {
            var _loc_6:* = null as Vec2;
            var _loc_7:* = false;
            var _loc_8:* = null as ZPP_Vec2;
            if (param1 != param1)
            {
                throw "Error: Vec2::length cannot be NaN";
            }
            if (param2 != param2)
            {
                throw "Error: Vec2::angle cannot be NaN";
            }
            var _loc_4:* = param1 * Math.cos(param2);
            var _loc_5:* = param1 * Math.sin(param2);
            if (_loc_4 == _loc_4)
            {
            }
            if (_loc_5 != _loc_5)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_6 = new Vec2();
            }
            else
            {
                _loc_6 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_6.zpp_pool;
                _loc_6.zpp_pool = null;
                _loc_6.zpp_disp = false;
                if (_loc_6 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_6.zpp_inner == null)
            {
                _loc_7 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_8 = new ZPP_Vec2();
                }
                else
                {
                    _loc_8 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_8.next;
                    _loc_8.next = null;
                }
                _loc_8.weak = false;
                _loc_8._immutable = _loc_7;
                _loc_8.x = _loc_4;
                _loc_8.y = _loc_5;
                _loc_6.zpp_inner = _loc_8;
                _loc_6.zpp_inner.outer = _loc_6;
            }
            else
            {
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = _loc_6.zpp_inner;
                if (_loc_8._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_8._isimmutable != null)
                {
                    _loc_8._isimmutable();
                }
                if (_loc_4 == _loc_4)
                {
                }
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = _loc_6.zpp_inner;
                if (_loc_8._validate != null)
                {
                    _loc_8._validate();
                }
                if (_loc_6.zpp_inner.x == _loc_4)
                {
                    if (_loc_6 != null)
                    {
                    }
                    if (_loc_6.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = _loc_6.zpp_inner;
                    if (_loc_8._validate != null)
                    {
                        _loc_8._validate();
                    }
                }
                if (_loc_6.zpp_inner.y != _loc_5)
                {
                    _loc_6.zpp_inner.x = _loc_4;
                    _loc_6.zpp_inner.y = _loc_5;
                    _loc_8 = _loc_6.zpp_inner;
                    if (_loc_8._invalidate != null)
                    {
                        _loc_8._invalidate(_loc_8);
                    }
                }
            }
            _loc_6.zpp_inner.weak = param3;
            return _loc_6;
        }// end function

        public static function dsq(param1:Vec2, param2:Vec2) : Number
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = null as ZPP_Vec2;
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
            if (param1 != null)
            {
            }
            if (param2 == null)
            {
                throw "Error: Cannot compute squared distance between null Vec2";
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
            var _loc_4:* = param1.zpp_inner.x;
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
            var _loc_6:* = param1.zpp_inner.y;
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
            var _loc_7:* = param2.zpp_inner.x;
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
            var _loc_8:* = param2.zpp_inner.y;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            _loc_9 = _loc_4 - _loc_7;
            _loc_10 = _loc_6 - _loc_8;
            var _loc_3:* = _loc_9 * _loc_9 + _loc_10 * _loc_10;
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
                _loc_11 = param1;
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
                _loc_12 = _loc_5;
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
                _loc_11 = param2;
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
                _loc_12 = _loc_5;
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
            }
            else
            {
            }
            return _loc_3;
        }// end function

        public static function distance(param1:Vec2, param2:Vec2) : Number
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = null as ZPP_Vec2;
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
            if (param1 != null)
            {
            }
            if (param2 == null)
            {
                throw "Error: Cannot compute squared distance between null Vec2";
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
            var _loc_4:* = param1.zpp_inner.x;
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
            var _loc_6:* = param1.zpp_inner.y;
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
            var _loc_7:* = param2.zpp_inner.x;
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
            var _loc_8:* = param2.zpp_inner.y;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            _loc_9 = _loc_4 - _loc_7;
            _loc_10 = _loc_6 - _loc_8;
            var _loc_3:* = Math.sqrt(_loc_9 * _loc_9 + _loc_10 * _loc_10);
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
                _loc_11 = param1;
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
                _loc_12 = _loc_5;
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
                _loc_11 = param2;
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
                _loc_12 = _loc_5;
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
            }
            else
            {
            }
            return _loc_3;
        }// end function

    }
}
