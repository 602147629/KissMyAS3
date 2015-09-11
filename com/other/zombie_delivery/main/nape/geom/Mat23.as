package nape.geom
{
    import flash.*;
    import flash.geom.*;
    import nape.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    final public class Mat23 extends Object
    {
        public var zpp_inner:ZPP_Mat23;

        public function Mat23(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 1, param5:Number = 0, param6:Number = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            zpp_inner = ZPP_Mat23.get();
            zpp_inner.outer = this;
            if (param1 != param1)
            {
                throw "Error: Mat23::" + "a" + " cannot be NaN";
            }
            zpp_inner.a = param1;
            var _loc_7:* = zpp_inner;
            if (_loc_7._invalidate != null)
            {
                _loc_7._invalidate();
            }
            if (param2 != param2)
            {
                throw "Error: Mat23::" + "b" + " cannot be NaN";
            }
            zpp_inner.b = param2;
            _loc_7 = zpp_inner;
            if (_loc_7._invalidate != null)
            {
                _loc_7._invalidate();
            }
            if (param5 != param5)
            {
                throw "Error: Mat23::" + "tx" + " cannot be NaN";
            }
            zpp_inner.tx = param5;
            _loc_7 = zpp_inner;
            if (_loc_7._invalidate != null)
            {
                _loc_7._invalidate();
            }
            if (param3 != param3)
            {
                throw "Error: Mat23::" + "c" + " cannot be NaN";
            }
            zpp_inner.c = param3;
            _loc_7 = zpp_inner;
            if (_loc_7._invalidate != null)
            {
                _loc_7._invalidate();
            }
            if (param4 != param4)
            {
                throw "Error: Mat23::" + "d" + " cannot be NaN";
            }
            zpp_inner.d = param4;
            _loc_7 = zpp_inner;
            if (_loc_7._invalidate != null)
            {
                _loc_7._invalidate();
            }
            if (param6 != param6)
            {
                throw "Error: Mat23::" + "ty" + " cannot be NaN";
            }
            zpp_inner.ty = param6;
            _loc_7 = zpp_inner;
            if (_loc_7._invalidate != null)
            {
                _loc_7._invalidate();
            }
            return;
        }// end function

        public function transpose() : Mat23
        {
            return new Mat23(zpp_inner.a, zpp_inner.c, zpp_inner.b, zpp_inner.d, (-zpp_inner.a) * zpp_inner.tx - zpp_inner.c * zpp_inner.ty, (-zpp_inner.b) * zpp_inner.tx - zpp_inner.d * zpp_inner.ty);
        }// end function

        public function transform(param1:Vec2, param2:Boolean = false, param3:Boolean = false) : Vec2
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = NaN;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = NaN;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = false;
            var _loc_10:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot transform null Vec2";
            }
            if (param2)
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
                _loc_5 = param1.zpp_inner.x * zpp_inner.a + param1.zpp_inner.y * zpp_inner.b;
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
                _loc_7 = param1.zpp_inner.x * zpp_inner.c + param1.zpp_inner.y * zpp_inner.d;
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
                _loc_4 = _loc_8;
            }
            else
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
                _loc_5 = param1.zpp_inner.x * zpp_inner.a + param1.zpp_inner.y * zpp_inner.b + zpp_inner.tx;
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
                _loc_7 = param1.zpp_inner.x * zpp_inner.c + param1.zpp_inner.y * zpp_inner.d + zpp_inner.ty;
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
                _loc_4 = _loc_8;
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

        public function toString() : String
        {
            return "{ a: " + zpp_inner.a + " b: " + zpp_inner.b + " c: " + zpp_inner.c + " d: " + zpp_inner.d + " tx: " + zpp_inner.tx + " ty: " + zpp_inner.ty + " }";
        }// end function

        public function toMatrix(param1:Matrix = undefined) : Matrix
        {
            if (param1 == null)
            {
                param1 = new Matrix();
            }
            param1.a = zpp_inner.a;
            param1.b = zpp_inner.c;
            param1.c = zpp_inner.b;
            param1.d = zpp_inner.d;
            param1.tx = zpp_inner.tx;
            param1.ty = zpp_inner.ty;
            return param1;
        }// end function

        public function singular() : Boolean
        {
            var _loc_1:* = zpp_inner.a * zpp_inner.a + zpp_inner.b * zpp_inner.b + zpp_inner.c * zpp_inner.c + zpp_inner.d * zpp_inner.d;
            var _loc_2:* = zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c;
            if (_loc_2 < 0)
            {
                _loc_2 = -_loc_2;
            }
            return _loc_1 > Config.illConditionedThreshold * _loc_2;
        }// end function

        public function set_ty(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: Mat23::" + "ty" + " cannot be NaN";
            }
            zpp_inner.ty = param1;
            var _loc_2:* = zpp_inner;
            if (_loc_2._invalidate != null)
            {
                _loc_2._invalidate();
            }
            return zpp_inner.ty;
        }// end function

        public function set_tx(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: Mat23::" + "tx" + " cannot be NaN";
            }
            zpp_inner.tx = param1;
            var _loc_2:* = zpp_inner;
            if (_loc_2._invalidate != null)
            {
                _loc_2._invalidate();
            }
            return zpp_inner.tx;
        }// end function

        public function set_d(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: Mat23::" + "d" + " cannot be NaN";
            }
            zpp_inner.d = param1;
            var _loc_2:* = zpp_inner;
            if (_loc_2._invalidate != null)
            {
                _loc_2._invalidate();
            }
            return zpp_inner.d;
        }// end function

        public function set_c(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: Mat23::" + "c" + " cannot be NaN";
            }
            zpp_inner.c = param1;
            var _loc_2:* = zpp_inner;
            if (_loc_2._invalidate != null)
            {
                _loc_2._invalidate();
            }
            return zpp_inner.c;
        }// end function

        public function set_b(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: Mat23::" + "b" + " cannot be NaN";
            }
            zpp_inner.b = param1;
            var _loc_2:* = zpp_inner;
            if (_loc_2._invalidate != null)
            {
                _loc_2._invalidate();
            }
            return zpp_inner.b;
        }// end function

        public function set_a(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: Mat23::" + "a" + " cannot be NaN";
            }
            zpp_inner.a = param1;
            var _loc_2:* = zpp_inner;
            if (_loc_2._invalidate != null)
            {
                _loc_2._invalidate();
            }
            return zpp_inner.a;
        }// end function

        public function setAs(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 1, param5:Number = 0, param6:Number = 0) : Mat23
        {
            zpp_inner.setas(param1, param2, param3, param4, param5, param6);
            var _loc_7:* = zpp_inner;
            if (_loc_7._invalidate != null)
            {
                _loc_7._invalidate();
            }
            return this;
        }// end function

        public function set(param1:Mat23) : Mat23
        {
            if (param1 == null)
            {
                throw "Error: Cannot set form null matrix";
            }
            var _loc_2:* = param1.zpp_inner;
            zpp_inner.setas(_loc_2.a, _loc_2.b, _loc_2.c, _loc_2.d, _loc_2.tx, _loc_2.ty);
            _loc_2 = zpp_inner;
            if (_loc_2._invalidate != null)
            {
                _loc_2._invalidate();
            }
            return this;
        }// end function

        public function reset() : Mat23
        {
            return setAs();
        }// end function

        public function orthogonalise() : Mat23
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = null as Mat23;
            var _loc_5:* = NaN;
            var _loc_6:* = null as ZPP_Mat23;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            if (!orthogonal())
            {
                _loc_1 = Math.sqrt(zpp_inner.a * zpp_inner.a + zpp_inner.c * zpp_inner.c);
                _loc_2 = Math.sqrt(zpp_inner.b * zpp_inner.b + zpp_inner.d * zpp_inner.d);
                if (_loc_1 * _loc_1 >= Config.epsilon)
                {
                }
                if (_loc_2 * _loc_2 < Config.epsilon)
                {
                    throw "Error: Matrix is singular and cannot be " + "orthogonal" + "ised";
                }
                _loc_3 = 1;
                _loc_1 = _loc_3 / _loc_1;
                _loc_2 = _loc_3 / _loc_2;
                _loc_4 = this;
                _loc_5 = _loc_4.zpp_inner.a * _loc_1;
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Mat23::" + "a" + " cannot be NaN";
                }
                _loc_4.zpp_inner.a = _loc_5;
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_4 = this;
                _loc_5 = _loc_4.zpp_inner.c * _loc_1;
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Mat23::" + "c" + " cannot be NaN";
                }
                _loc_4.zpp_inner.c = _loc_5;
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_4 = this;
                _loc_5 = _loc_4.zpp_inner.b * _loc_2;
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Mat23::" + "b" + " cannot be NaN";
                }
                _loc_4.zpp_inner.b = _loc_5;
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_4 = this;
                _loc_5 = _loc_4.zpp_inner.d * _loc_2;
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Mat23::" + "d" + " cannot be NaN";
                }
                _loc_4.zpp_inner.d = _loc_5;
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_5 = zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d;
                _loc_7 = 0.25 * Math.PI - 0.5 * Math.acos(_loc_5 / (_loc_3 * _loc_3));
                if (zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c > 0)
                {
                    _loc_7 = -_loc_7;
                }
                _loc_8 = Math.sin(_loc_7);
                _loc_9 = Math.cos(_loc_7);
                _loc_10 = zpp_inner.a * _loc_9 - zpp_inner.c * _loc_8;
                _loc_11 = zpp_inner.b * _loc_9 + zpp_inner.d * _loc_8;
                _loc_12 = zpp_inner.c * _loc_9 + zpp_inner.a * _loc_8;
                if (_loc_12 != _loc_12)
                {
                    throw "Error: Mat23::" + "c" + " cannot be NaN";
                }
                zpp_inner.c = _loc_12;
                _loc_6 = zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                if (_loc_10 != _loc_10)
                {
                    throw "Error: Mat23::" + "a" + " cannot be NaN";
                }
                zpp_inner.a = _loc_10;
                _loc_6 = zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_12 = zpp_inner.d * _loc_9 - zpp_inner.b * _loc_8;
                if (_loc_12 != _loc_12)
                {
                    throw "Error: Mat23::" + "d" + " cannot be NaN";
                }
                zpp_inner.d = _loc_12;
                _loc_6 = zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                if (_loc_11 != _loc_11)
                {
                    throw "Error: Mat23::" + "b" + " cannot be NaN";
                }
                zpp_inner.b = _loc_11;
                _loc_6 = zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_6 = zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
            }
            return this;
        }// end function

        public function orthogonal() : Boolean
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_1:* = zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d;
            if (_loc_1 * _loc_1 < Config.epsilon)
            {
                _loc_2 = zpp_inner.a * zpp_inner.a + zpp_inner.b * zpp_inner.b - 1;
                _loc_3 = zpp_inner.c * zpp_inner.c + zpp_inner.d * zpp_inner.d - 1;
                if (_loc_2 * _loc_2 < Config.epsilon)
                {
                }
                return _loc_3 * _loc_3 < Config.epsilon;
            }
            else
            {
                return false;
            }
        }// end function

        public function inverseTransform(param1:Vec2, param2:Boolean = false, param3:Boolean = false) : Vec2
        {
            var _loc_5:* = null as Vec2;
            var _loc_6:* = NaN;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = NaN;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = false;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot transform null Vec2";
            }
            if (singular())
            {
                throw "Error: Matrix is singular and inverse transformation cannot be performed";
            }
            var _loc_4:* = 1 / (zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c);
            if (param2)
            {
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
                _loc_6 = (param1.zpp_inner.x * zpp_inner.d - param1.zpp_inner.y * zpp_inner.b) * _loc_4;
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
                _loc_8 = (param1.zpp_inner.y * zpp_inner.a - param1.zpp_inner.x * zpp_inner.c) * _loc_4;
                if (_loc_6 == _loc_6)
                {
                }
                if (_loc_8 != _loc_8)
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
                        _loc_7 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_7 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_7.next;
                        _loc_7.next = null;
                    }
                    _loc_7.weak = false;
                    _loc_7._immutable = _loc_10;
                    _loc_7.x = _loc_6;
                    _loc_7.y = _loc_8;
                    _loc_9.zpp_inner = _loc_7;
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
                    _loc_7 = _loc_9.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_6 == _loc_6)
                    {
                    }
                    if (_loc_8 != _loc_8)
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
                    _loc_7 = _loc_9.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_9.zpp_inner.x == _loc_6)
                    {
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_7 = _loc_9.zpp_inner;
                        if (_loc_7._validate != null)
                        {
                            _loc_7._validate();
                        }
                    }
                    if (_loc_9.zpp_inner.y != _loc_8)
                    {
                        _loc_9.zpp_inner.x = _loc_6;
                        _loc_9.zpp_inner.y = _loc_8;
                        _loc_7 = _loc_9.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                }
                _loc_9.zpp_inner.weak = param3;
                _loc_5 = _loc_9;
            }
            else
            {
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
                _loc_6 = param1.zpp_inner.x - zpp_inner.tx;
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
                _loc_8 = param1.zpp_inner.y - zpp_inner.ty;
                _loc_11 = (_loc_6 * zpp_inner.d - _loc_8 * zpp_inner.b) * _loc_4;
                _loc_12 = (_loc_8 * zpp_inner.a - _loc_6 * zpp_inner.c) * _loc_4;
                if (_loc_11 == _loc_11)
                {
                }
                if (_loc_12 != _loc_12)
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
                        _loc_7 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_7 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_7.next;
                        _loc_7.next = null;
                    }
                    _loc_7.weak = false;
                    _loc_7._immutable = _loc_10;
                    _loc_7.x = _loc_11;
                    _loc_7.y = _loc_12;
                    _loc_9.zpp_inner = _loc_7;
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
                    _loc_7 = _loc_9.zpp_inner;
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
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_9.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_9.zpp_inner.x == _loc_11)
                    {
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_7 = _loc_9.zpp_inner;
                        if (_loc_7._validate != null)
                        {
                            _loc_7._validate();
                        }
                    }
                    if (_loc_9.zpp_inner.y != _loc_12)
                    {
                        _loc_9.zpp_inner.x = _loc_11;
                        _loc_9.zpp_inner.y = _loc_12;
                        _loc_7 = _loc_9.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                }
                _loc_9.zpp_inner.weak = param3;
                _loc_5 = _loc_9;
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
                _loc_13 = _loc_7;
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
            }
            else
            {
            }
            return _loc_5;
        }// end function

        public function inverse() : Mat23
        {
            if (singular())
            {
                throw "Error: Matrix is singular and cannot be inverted";
            }
            var _loc_1:* = 1 / (zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c);
            return new Mat23(zpp_inner.d * _loc_1, (-zpp_inner.b) * _loc_1, (-zpp_inner.c) * _loc_1, zpp_inner.a * _loc_1, (zpp_inner.b * zpp_inner.ty - zpp_inner.d * zpp_inner.tx) * _loc_1, (zpp_inner.c * zpp_inner.tx - zpp_inner.a * zpp_inner.ty) * _loc_1);
        }// end function

        public function get_ty() : Number
        {
            return zpp_inner.ty;
        }// end function

        public function get_tx() : Number
        {
            return zpp_inner.tx;
        }// end function

        public function get_determinant() : Number
        {
            return zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c;
        }// end function

        public function get_d() : Number
        {
            return zpp_inner.d;
        }// end function

        public function get_c() : Number
        {
            return zpp_inner.c;
        }// end function

        public function get_b() : Number
        {
            return zpp_inner.b;
        }// end function

        public function get_a() : Number
        {
            return zpp_inner.a;
        }// end function

        public function equiorthogonalise() : Mat23
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = null as Mat23;
            var _loc_5:* = NaN;
            var _loc_6:* = null as ZPP_Mat23;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            if (!equiorthogonal())
            {
                _loc_1 = Math.sqrt(zpp_inner.a * zpp_inner.a + zpp_inner.c * zpp_inner.c);
                _loc_2 = Math.sqrt(zpp_inner.b * zpp_inner.b + zpp_inner.d * zpp_inner.d);
                if (_loc_1 * _loc_1 >= Config.epsilon)
                {
                }
                if (_loc_2 * _loc_2 < Config.epsilon)
                {
                    throw "Error: Matrix is singular and cannot be " + "equiorthogonal" + "ised";
                }
                _loc_3 = (_loc_1 + _loc_2) / 2;
                _loc_1 = _loc_3 / _loc_1;
                _loc_2 = _loc_3 / _loc_2;
                _loc_4 = this;
                _loc_5 = _loc_4.zpp_inner.a * _loc_1;
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Mat23::" + "a" + " cannot be NaN";
                }
                _loc_4.zpp_inner.a = _loc_5;
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_4 = this;
                _loc_5 = _loc_4.zpp_inner.c * _loc_1;
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Mat23::" + "c" + " cannot be NaN";
                }
                _loc_4.zpp_inner.c = _loc_5;
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_4 = this;
                _loc_5 = _loc_4.zpp_inner.b * _loc_2;
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Mat23::" + "b" + " cannot be NaN";
                }
                _loc_4.zpp_inner.b = _loc_5;
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_4 = this;
                _loc_5 = _loc_4.zpp_inner.d * _loc_2;
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Mat23::" + "d" + " cannot be NaN";
                }
                _loc_4.zpp_inner.d = _loc_5;
                _loc_6 = _loc_4.zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_5 = zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d;
                _loc_7 = 0.25 * Math.PI - 0.5 * Math.acos(_loc_5 / (_loc_3 * _loc_3));
                if (zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c > 0)
                {
                    _loc_7 = -_loc_7;
                }
                _loc_8 = Math.sin(_loc_7);
                _loc_9 = Math.cos(_loc_7);
                _loc_10 = zpp_inner.a * _loc_9 - zpp_inner.c * _loc_8;
                _loc_11 = zpp_inner.b * _loc_9 + zpp_inner.d * _loc_8;
                _loc_12 = zpp_inner.c * _loc_9 + zpp_inner.a * _loc_8;
                if (_loc_12 != _loc_12)
                {
                    throw "Error: Mat23::" + "c" + " cannot be NaN";
                }
                zpp_inner.c = _loc_12;
                _loc_6 = zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                if (_loc_10 != _loc_10)
                {
                    throw "Error: Mat23::" + "a" + " cannot be NaN";
                }
                zpp_inner.a = _loc_10;
                _loc_6 = zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_12 = zpp_inner.d * _loc_9 - zpp_inner.b * _loc_8;
                if (_loc_12 != _loc_12)
                {
                    throw "Error: Mat23::" + "d" + " cannot be NaN";
                }
                zpp_inner.d = _loc_12;
                _loc_6 = zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                if (_loc_11 != _loc_11)
                {
                    throw "Error: Mat23::" + "b" + " cannot be NaN";
                }
                zpp_inner.b = _loc_11;
                _loc_6 = zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
                _loc_6 = zpp_inner;
                if (_loc_6._invalidate != null)
                {
                    _loc_6._invalidate();
                }
            }
            return this;
        }// end function

        public function equiorthogonal() : Boolean
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            if (singular())
            {
                return false;
            }
            else
            {
                _loc_1 = zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d;
                if (_loc_1 * _loc_1 < Config.epsilon)
                {
                    _loc_2 = zpp_inner.a * zpp_inner.a + zpp_inner.b * zpp_inner.b - zpp_inner.c * zpp_inner.c - zpp_inner.d * zpp_inner.d;
                    return _loc_2 * _loc_2 < Config.epsilon;
                }
                else
                {
                    return false;
                }
            }
        }// end function

        public function copy() : Mat23
        {
            return new Mat23(zpp_inner.a, zpp_inner.b, zpp_inner.c, zpp_inner.d, zpp_inner.tx, zpp_inner.ty);
        }// end function

        public function concat(param1:Mat23) : Mat23
        {
            var _loc_2:* = param1;
            if (_loc_2 == null)
            {
                throw "Error: Cannot concatenate with null Mat23";
            }
            return new Mat23(_loc_2.zpp_inner.a * zpp_inner.a + _loc_2.zpp_inner.b * zpp_inner.c, _loc_2.zpp_inner.a * zpp_inner.b + _loc_2.zpp_inner.b * zpp_inner.d, _loc_2.zpp_inner.c * zpp_inner.a + _loc_2.zpp_inner.d * zpp_inner.c, _loc_2.zpp_inner.c * zpp_inner.b + _loc_2.zpp_inner.d * zpp_inner.d, _loc_2.zpp_inner.a * zpp_inner.tx + _loc_2.zpp_inner.b * zpp_inner.ty + _loc_2.zpp_inner.tx, _loc_2.zpp_inner.c * zpp_inner.tx + _loc_2.zpp_inner.d * zpp_inner.ty + _loc_2.zpp_inner.ty);
        }// end function

        public static function fromMatrix(param1:Matrix) : Mat23
        {
            var _loc_2:* = param1;
            return new Mat23(_loc_2.a, _loc_2.c, _loc_2.b, _loc_2.d, _loc_2.tx, _loc_2.ty);
        }// end function

        public static function rotation(param1:Number) : Mat23
        {
            if (param1 != param1)
            {
                throw "Error: Cannot create rotation matrix with NaN angle";
            }
            var _loc_2:* = Math.cos(param1);
            var _loc_3:* = Math.sin(param1);
            return new Mat23(_loc_2, -_loc_3, _loc_3, _loc_2, 0, 0);
        }// end function

        public static function translation(param1:Number, param2:Number) : Mat23
        {
            return new Mat23(1, 0, 0, 1, param1, param2);
        }// end function

        public static function scale(param1:Number, param2:Number) : Mat23
        {
            return new Mat23(param1, 0, 0, param2, 0, 0);
        }// end function

    }
}
